function [pathCost,path,indxcol,indxrow,distSum] = MinimalVarianceMatching(refSample,testSample,straight)

[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M) % each set containing same no. of feature
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); 
    pathCost = inf(noOfSamplesInRefSample,noOfSamplesInTestSample);
    path = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    
    for i=1:noOfSamplesInRefSample 
        for j=1:noOfSamplesInTestSample 
            total = zeros(N,1);
            for goFeature = 1:N
                total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            
            Dist(i,j) = sqrt(sum(total));
        end
    end
    
elasticity = (noOfSamplesInTestSample-noOfSamplesInRefSample); % noOfSamplesInTestSample is the number of
% chracter in the test sample, which is always more than or equal to the number of
% chracters in  the reference sample (noOfSamplesInRefSample)
if(elasticity <= 1)
    elasticity = 2;
end
if(noOfSamplesInTestSample >= noOfSamplesInRefSample) % this condition k is satisfied only when the above statement
    % is satisfied
    for ji=1:1:(elasticity + 1)
        pathCost(1,ji) = ((Dist(1,ji)) * (Dist(1,ji)));
    end
    for i = 2:1:noOfSamplesInRefSample % for all the rows
        stopkRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
        
        for k = i-1:1:stopkRight
            stopj = min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample);
            for jlick = (k+1):1:stopj
                if ((pathCost(i,jlick)) > (pathCost(i-1,k) + ((Dist(i,jlick))^2)))
                    pathCost(i,jlick) = pathCost(i-1,k) + ((Dist(i,jlick))^2);
                    path(i,jlick) = k;
                end
            end
        end
    end
end

minrow = noOfSamplesInRefSample;
[~,indices] = min(pathCost(noOfSamplesInRefSample,noOfSamplesInRefSample:noOfSamplesInTestSample));
mincol = (noOfSamplesInRefSample-1)+indices;

indxcol = zeros(1,1);
indxrow = zeros(1,1);
cnt = 1;
while ( (minrow>1) && (mincol>1) )
    indxcol(cnt,1) = mincol;
    indxrow(cnt,1) = minrow;
    mincol = path(minrow,mincol);
    minrow = minrow-1;
    cnt = cnt + 1;
end

indxcol(cnt,1) = mincol;
indxrow(cnt,1) = minrow;
indxcol = indxcol(1:cnt);
indxrow = indxrow(1:cnt);

indxcol = flipdim(indxcol,1);
indxrow = flipdim(indxrow,1);

distSum = pathCost(indxrow(end,1),indxcol(end,1));
distSum = distSum/noOfSamplesInRefSample;
return
end

