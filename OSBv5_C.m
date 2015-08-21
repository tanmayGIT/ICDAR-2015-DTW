function [pathcost,indxcol,indxrow,d] = OSBv5_C(t1,t2,warpwin,queryskip,targetskip,jumpcost)


[m,nFeature1] = size(t1);
[n,nFeature2] = size(t2);

if ~exist('warpwin','var')
    warpwin = abs(m-n);
end

if ~exist('queryskip','var')
    queryskip = abs(m-n);
end

if ~exist('targetskip','var')
    targetskip = abs(m-n);
end
if( (queryskip <= 1) && (targetskip <= 1) ) % to make it compatable, if query and target length are same
    queryskip = 2;
    targetskip = 2;
end

if(nFeature1 == nFeature2)
    Dist = zeros(m,n);
    for i=1:1:m
        for j=1:1:n
            total = zeros(nFeature1,1);
            for goFeature=1:nFeature1
                total(goFeature,1) = (double((t1(i,goFeature)-t2(j,goFeature))^2));
            end
            Dist(i,j) = sqrt(sum(total));
        end
    end
end

matx = Dist;

if ~exist('jumpcost','var') || jumpcost == -1
    statmatx = min(matx');
    statmatx2 = min(matx);
    jumpcost = min( (mean(statmatx)+std(statmatx)), (mean(statmatx2)+std(statmatx2)) )+ eps;
end
matxE = Inf(m+2,n+2);
matxE(2:m+1,2:n+1) = matx;
matxE(1,1) = 0;
matxE(m+2,n+2) = 0;
% calling the main function
[pathcost,indxrow,indxcol] = findpathDAG(matxE,warpwin,queryskip,targetskip,jumpcost);
pathcost = pathcost/length(indxrow); %we normalize path cost

addDistSum = 0;
if((length(indxrow)) == (length(indxcol)))
    for i = 1:1:(length(indxrow))
        getindxrow = indxrow(1,i);
        getindxcol = indxcol(1,i);
        distSum = 0;
        for featureCol = 1:1:(size(t1,2))
            distSum = distSum + ((t1(getindxrow,featureCol) - t2(getindxcol,featureCol)) ^ 2);
        end
        addDistSum = addDistSum + sqrt(distSum)/(size(t1,2));
    end
end

d = (addDistSum)/length(indxrow);   %squared Euclidean distance of correspndoning elements

if (isnan(d))
    disp('why you are nan');
end
indxrow = indxrow';
indxcol = indxcol';
return
return