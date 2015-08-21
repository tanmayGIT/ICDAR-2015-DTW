function [pathcost,indxcol,indxrow,d] = OSBv5(t1,t2,warpwin,queryskip,targetskip,jumpcost)

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


function [pathcost,indxrow,indxcol] = findpathDAG(matx,warpwin,queryskip,targetskip,jumpcost)

[m,n] = size(matx); %this matx=matxE, thus it has one row and  column more than the original matx above
weight = Inf(m,n); %the weight of the actually cheapest path

camefromcol = zeros(m,n); %the index of the parent col where the cheapest path came from
camefromrow = zeros(m,n); %the index of the parent row where the cheapest path came from

weight(1,:) = matx(1,:); %initialize first row
weight(:,1) = matx(:,1); %initialize first column

efcilon = 0.002;
for i = 1:m-1 %index over rows; as we are doing i+1
    for j = 1:n-1 %index over columns; as we are doing j+1
        if abs(i-j) <= warpwin %difference between i and j must be smaller than warpwin
            
            stoprowjump = min([m, i+queryskip]);
            stopk = min([n, j+targetskip]);
            for rowjump = i+1:stoprowjump %second index over rows
                for k = j+1:stopk %second index over columns
                    newweight = ( weight(i,j) +  matx(rowjump,k) + ((rowjump-i-1)+(k-j-1))*jumpcost) ;
                    if weight(rowjump,k) > newweight
                        weight(rowjump,k) = newweight;
                        camefromrow(rowjump,k) = i;
                        camefromcol(rowjump,k) = j;
                    end
                end
            end
        end
    end
end

% collecting the indices of points on the cheapest path
pathcost = weight(m,n);   % pathcost: minimal value
mincol = n;
minrow = m;
indxcol = [];
indxrow = [];
while (minrow>1 && mincol>1)
    indxcol = [ mincol indxcol];
    indxrow = [ minrow indxrow];
    mincoltemp = camefromcol(minrow,mincol); % taking the temporary variable mincoltemp bcoz of in the next line we have to use original minrow & mincol
    minrow = camefromrow(minrow,mincol);
    mincol = mincoltemp;
end

indxcol = indxcol(1:end-1);
indxrow = indxrow(1:end-1);
indxcol = indxcol-1;
indxrow = indxrow-1;
return
