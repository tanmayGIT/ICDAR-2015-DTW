function [jumpcost,smalJC] =  calculateIntelligentJumpCost(keepAllDistQuery)
allDist = calJumpCost(keepAllDistQuery{1,1}{1,1});
for ii = 1:1:size(keepAllDistQuery,1)
    if(ii ==1)
        ght = 2;
    else
        ght = 1;
    end
    for jj = ght:1:size(keepAllDistQuery{ii,1},1)
        minDist = calJumpCost(keepAllDistQuery{ii,1}{jj,1});
        allDist = cat(1,allDist,minDist);
    end
end
counts = hist(allDist);
allDist = sort(allDist);
piece = (max(allDist) - min(allDist)) / 10;
thresh = 80; % the percentage of elements you want
cumSum = 0;
for i = 1:1:length(counts)
    cumSum = cumSum + counts(i);
    if(cumSum >= ceil((length(allDist)* thresh)/100) ) % when cummulative sum exceeds 90 % elements break out
        break;
    end
end
bin_limit = min(allDist) + i*piece;
refinedIndices = find(allDist > bin_limit);
allDist(refinedIndices) = [];
refinedDist = allDist;
if(isempty(refinedDist))
    error('The distance array calculation has some problem');
else
    jumpcost = ( (mean(refinedDist)+ 1*std(refinedDist)) );
    smalJC = mean(refinedDist);
end
end
function [statmatx] = calJumpCost(Dist)
myMinArr = zeros(1,1);
bw = 2;
for iiii = 1:1:size(Dist,1)
    tempMinArr =  sort(Dist(iiii,:));
    takeSome = tempMinArr(1,1:bw);
    myMinArr(iiii,1) = mean(takeSome);
end
statmatx = myMinArr;
[~,~,statmatx] = find(statmatx);
return;
end
