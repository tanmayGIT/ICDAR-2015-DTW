function [DistanceVal,indxCol,indxRw] = LCSS(refSample,testSample)
% Assuming that the feature matrix are 2D/1D
% epsilon = 4*min( (std(mean(refSample,1))),(std(mean(testSample,1))) );

refMean = sum(refSample,1) ./ sum(refSample~=0,1);%mean(refSample,1);
targetMean = sum(testSample,1) ./ sum(testSample~=0,1);%mean(testSample,1);

refDif = 0;
cnt1 = 0;
for yt = 1:1:size(refSample,1)
    tempRw = refSample(yt,:);
    tempDif = norm(tempRw - refMean);
    refDif = refDif + (tempDif^2);
    cnt1  = cnt1+1;
end
refDif = sqrt(refDif)/cnt1; 
 
targetDif = 0;
cnt2 = 0;
for yt = 1:1:size(testSample,1)
    tempTarRw = testSample(yt,:);
    tempTarDif = norm(tempTarRw - targetMean);
    targetDif = targetDif + (tempTarDif^2);
    cnt2 = cnt2+1;
end
targetDif = sqrt(targetDif)/cnt2; 
epsilon = min(refDif,targetDif);

[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);
Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
for i=1:noOfSamplesInRefSample % xSize
    for j=1:noOfSamplesInTestSample %ySize
        total = zeros(N,1);
        for goFeature=1:N %or M as N & M are same
            total(goFeature,1) = sqrt(double((refSample(i,goFeature)-testSample(j,goFeature))^2));
        end  
        Dist(i,j) = (sum(total));  %(sum(total));
    end
end

delta = abs(noOfSamplesInTestSample - noOfSamplesInRefSample);

L = zeros(noOfSamplesInRefSample+1,noOfSamplesInTestSample+1);
L(1,:) = 0;
L(:,1) = 0;
b = zeros(noOfSamplesInRefSample+1,noOfSamplesInTestSample+1);
b(:,1) = 1;%%% Up
b(1,:) = 2;%%% Left

if(N == M)
    for i = 2:noOfSamplesInRefSample+1
        for j = 2:noOfSamplesInTestSample+1
            if ( ( Dist(i-1,j-1) < epsilon) && (abs(j-i) < delta) )
                L(i,j) = L(i-1,j-1) + 1;
                b(i,j) = 3;%%% Up and left
            else
                L(i,j) = L(i-1,j-1);
            end
            if(L(i-1,j) >= L(i,j))
                L(i,j) = L(i-1,j);
                b(i,j) = 1;%Up
            end
            if(L(i,j-1) >= L(i,j))
                L(i,j) = L(i,j-1);
                b(i,j) = 2;%Left
            end
        end
    end
    % removing the first col, first row, last col, last row
    L(:,1) = [];
    L(1,:) = [];
    b(:,1) = [];
    b(1,:) = [];
    dist = L(noOfSamplesInRefSample,noOfSamplesInTestSample);
    
    DistanceVal = (dist / min(noOfSamplesInTestSample,noOfSamplesInRefSample));
    %     if(dist == 0)
    %         aLongestString = '';
    %     else
    %%%now backtrack to find the longest subsequence
    i = noOfSamplesInRefSample;
    j = noOfSamplesInTestSample;
    Wrapped(1,:)=[i,j];
    p = dist;
    aLongestString = {};
    while(i>1 && j>1)
        if(b(i,j) == 3)
            aLongestString{p} = refSample(i);
            p = p-1;
            i = i-1;
            j = j-1;
        elseif(b(i,j) == 1)
            i = i-1;
        elseif(b(i,j) == 2)
            j = j-1;
        end
        Wrapped = cat(1,Wrapped,[i,j]);
    end
    indxRw =  Wrapped(:,1);%1:(size(refSample,1));
    %  indxRw = indxRw';
    indxCol = Wrapped(:,2);%1:(size(testSample,1));
    %  indxCol = indxCol';
    %         if ischar(aLongestString{1})
    %             aLongestString = char(aLongestString)';
    %         else
    %             aLongestString = cell2mat(aLongestString);
    %         end
    %     end
    
end
end
