%This code is same as MVM_Updated_17_5, but here we tried to optimize the
%code by merging some of the if else loops

function [pathCost,pathTarget,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_17_6(refSample,testSample,weight,bal)

% adding dummy at the ref and target
nwRef = zeros((size(refSample,1)+1),size(refSample,2));
nwRef(2:end,:) = refSample;
refSample = nwRef;

nwTarget = zeros((size(testSample,1)+1),size(testSample,2));
nwTarget(2:end,:) = testSample;
testSample = nwTarget;

pathTarget = 1;
[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M)
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathCost = inf(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetRw = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetCol = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    jumpMat = ones(noOfSamplesInRefSample,noOfSamplesInTestSample); % the value in this matrix wil be 1 if it is nit jumping any row, other wise it will be -1
    
    for i=1:noOfSamplesInRefSample
        for jick=1:noOfSamplesInTestSample
            total = zeros(N,1);
            for goFeature = 1:N
                total(goFeature,1) = (double((refSample(i,goFeature)-testSample(jick,goFeature))^2));
            end
            Dist(i,jick) = sqrt(sum(total));
        end
    end
    
    elasticity = (noOfSamplesInTestSample - noOfSamplesInRefSample);
    if(noOfSamplesInTestSample == noOfSamplesInTestSample)
        elasticity = noOfSamplesInRefSample;
    end
    if (~exist('jumpcost','var'))
        statmatx = calcJumpCost(Dist, noOfSamplesInRefSample);
        %         statmatx = min(Dist,[],2);
        [~,~,statmatx] = find(statmatx);
        if(isempty(statmatx))
            jumpcost = 0;
        else
            jumpcost = ( (mean(statmatx)+ 2*std(statmatx)) );
            smalJC = mean(statmatx);
        end
    end
    %     if(jumpcost<1) % Only add unity matrix, if and only if jumpcost <1
    %         grac = ones(noOfSamplesInRefSample,noOfSamplesInTestSample);
    %         Dist = Dist + grac;  %  0.335^3 = 0.0376 : bcoz of this reason we need to add by 1, so if we are using power for calculating jumpCost then it is necessary to add by 1 otherwise the technique will not work
    %         statmatx = min(Dist,[],2);
    %         [~,~,statmatx] = find(statmatx);
    %         if(isempty(statmatx))
    %             jumpcost = 0;
    %         else
    %             jumpcost = ( (mean(statmatx)+ 3*std(statmatx)) );
    %         end
    %     end
    Dist1 = Dist;%zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Incrementing the size by one array more as we need to get the
    % generating the modified Dist matrix and the jumpMat matrix
    
    for i=1:noOfSamplesInRefSample
        for jick=1:noOfSamplesInTestSample
            if( (Dist1(i,jick) > jumpcost) && (i >1) ) % the fisrt row of jumpMat is all 1
                Dist1(i,jick) = jumpcost;
                jumpMat(i,jick) = -1;
            end
        end
    end
    
    
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample)
        pathCost(1,:) =   Dist(1,:) ;
        for i = 2:1:noOfSamplesInRefSample % so it is actually the 1st row and the other initial row is dummy
            
            stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
            stopMotherLeft = max(((i-1)-(elasticity)),2);
            
            for k = stopMotherLeft:1:stopMotherRight
                stopj = min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample);
                stopLeft  = max(k,1);
                if( ((i-1) == 1) && (k == 1) ) % only for the top left most first node; to stop many of query to one of target matching with the dummy node
                    stopLeft  = 2;
                else
                    stopLeft  = max(k,2); % 2 bcoz we don't need any link from the first node
                end
                for j = (stopLeft):1:stopj
                    if ((j-(k+1)) <= 0)
                        if ((j-(k+1)) == -1) % for vertical link
                            costJump = smalJC;
                        else
                            costJump = 0;
                        end
                    else
                        costJump = jumpcost*(weight*(abs(j-(k+1))));
                    end
                    if(jumpMat(i-1,k) == 1)  % the normal condition
                        if ( pathCost(i,j) > (pathCost(i-1,k) + costJump + Dist1(i,j)) )
                            pathCost(i,j) = pathCost(i-1,k) + costJump + Dist1(i,j);
                            pathTargetRw(i,j) = i-1;
                            pathTargetCol(i,j) = k;
                        end
                    elseif(jumpMat(i-1,k) == -1) % when we want to skip the outlier
                        if ( pathCost(i,j) > (pathCost(i-1,k) + costJump + Dist1(i,j)) )
                            pathCost(i,j) = pathCost(i-1,k) + costJump + Dist1(i,j);
                            pathTargetRw(i,j) = pathTargetRw(i-1,k); % keeping the value which was at the skipped cell
                            pathTargetCol(i,j) = pathTargetCol(i-1,k);
                        end
                    end
                    takeMin = max(1,j-1);
                    if( (pathCost(i,j) > (pathCost(i,takeMin) + smalJC + Dist1(i,j)))  )
                        pathCost(i,j) =   pathCost(i,takeMin) + smalJC + Dist1(i,j) ;
                        pathTargetRw(i,j) = i;
                        pathTargetCol(i,j) = j-1;
                        jumpMat(i,j) = 1;
                    end
                end
            end
        end
        
        lastElasticity = max((noOfSamplesInRefSample),1);
        [minVal,~] = min(pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample));
        tempArr = pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample);
        ind = find(tempArr == minVal);
        indices = max(ind); % Taking the distant element
        
        mincol = (lastElasticity-1)+indices;
        minrow = noOfSamplesInRefSample;
        Wrapped =[];
        
        while (minrow>=1 && mincol>=1)
            if(jumpMat(minrow,mincol) == -1) % by this way, you can skip the last element of target also
                mincolTemp = pathTargetCol(minrow,mincol); % going to the previous link
                minrow = pathTargetRw(minrow,mincol); % going to the previous link
                mincol = mincolTemp; % going to the previous link
            else
                Wrapped = cat(1,[minrow,mincol],Wrapped);
                if(minrow == 1)&&(mincol == 1)
                    break;
                end
                mincolTemp = pathTargetCol(minrow,mincol);
                minrow = pathTargetRw(minrow,mincol);
                mincol = mincolTemp;
            end
        end
        indxrow = Wrapped(:,1);
        indxcol = Wrapped(:,2);
        
        distSum = pathCost(indxrow(end,1),indxcol(end,1));
        distSum = normalizationTech_0(indxrow,indxcol,distSum,noOfSamplesInRefSample,noOfSamplesInTestSample,jumpcost);
        indxrow = indxrow - 1; % reduce the index by 1 because of adding the dummy row
        indxrow = indxrow(2:end,1); % now reduce the first entry as it will 0 after subtration as 1st dummy element has to be matched with some
        
        indxcol = indxcol - 1;
        indxcol = indxcol(2:end,1);
        
        return
    end
end
end
function distSum = normalizationTech_0(~,indxcol,distSum,~,~,~)
distSum = ((distSum))/(size(indxcol,1));
end
function distSum = normalizationTech_1(indxrow,indxcol,distSum,~,~,~)
jumpedQueryEle = 0;
jumpedTargetEle = 0;
for iiu = 1:1:(size(indxrow,1)-1)
    dif1 = indxrow(iiu+1,1) - indxrow(iiu,1);
    dif2 = indxcol(iiu+1,1) - indxcol(iiu,1);
    if(dif1>1)
        jumpedQueryEle = jumpedQueryEle + (dif1-1); % as if  the difference is 1 then it is fine but it if is more than one then it has to be counted
    end
    if(dif2 > 1)
        jumpedTargetEle = jumpedTargetEle + (dif2-1);
    end
end
distSum = distSum/(size(indxcol,1))+ jumpedQueryEle + jumpedTargetEle;
return
end
function distSum = normalizationTech_2(~,indxcol,distSum,~,~,~)
distSum = ((distSum))/(abs(indxcol(end,1) - indxcol(1,1)) ) ;
return;
end
function distSum = normalizationTech_3(indxrow,indxcol,distSum,noOfSamplesInRefSample,~,jumpcost)
jumpedQueryEle = 0;
jumpedTargetEle = 0;
for iiu = 1:1:(size(indxrow,1)-1)
    dif1 = indxrow(iiu+1,1) - indxrow(iiu,1);
    dif2 = indxcol(iiu+1,1) - indxcol(iiu,1);
    if(dif1>1)
        jumpedQueryEle = jumpedQueryEle + (dif1-1); % as if  the difference is 1 then it is fine but it if is more than one then it has to be counted
    end
    if(dif2 > 1)
        jumpedTargetEle = jumpedTargetEle + (dif2-1);
    end
end
% so the main refinement has to be done from here as we had added one dummy row at the begginning
endSkip = abs(noOfSamplesInRefSample - indxrow(end,1));
begSkip = (indxrow(1,1) -1);
distSum = distSum + ((begSkip + endSkip)*jumpcost);
distSum = distSum/(size(indxcol,1))+jumpedQueryEle+jumpedTargetEle + (begSkip + endSkip);
end
function distSum = normalizationTech_4(indxrow,indxcol,distSum,noOfSamplesInRefSample,~,jumpcost)
endSkip = abs(noOfSamplesInRefSample - indxrow(end,1));
begSkip = (indxrow(1,1) -1);
distSum = distSum + ((begSkip + endSkip)*jumpcost);
distSum = distSum/(abs(indxcol(end,1) - indxcol(1,1)) ) + (begSkip + endSkip);
end
function myMinArr = calcJumpCost(distMat, elasticity)
myMinArr = zeros(1,1);
elasticity = round(elasticity*1/100);
for iiii = 1:1:size(distMat,1)
    tempMinArr =  sort(distMat(iiii,:));
    takeSome = tempMinArr(1,1:elasticity);
    myMinArr(iiii,1) = mean(takeSome);
end
end