function avgVal = getPerfectAvgValues(keepAllValues)
[n,xout] = hist(keepAllValues);
width = xout(2)-xout(1);
xoutmin = xout-width/2;
xoutmax = xout+width/2;
[sortedVal,indices] = sort(n,'descend');

consideredVal = 2; % how many bins you are considering
keepxoutmin = zeros(consideredVal,1);
keepxoutmax = zeros(consideredVal,1);

totalEleBucket = 0;
for kt = 1:1:consideredVal
    keepxoutmin(kt,1) = xoutmin(1,indices(1,kt));
    keepxoutmax(kt,1) = xoutmax(1,indices(1,kt));
    totalEleBucket = totalEleBucket + sortedVal(1,kt);
end

getValidDis = zeros(totalEleBucket,1);

tr = 1;
for m = 1:1:length(keepAllValues)
    dist = keepAllValues(1,m);
    if(  (dist <= (max(keepxoutmax))) && ((min(keepxoutmin)) <= dist)  )
        getValidDis(tr,1) = dist;
        tr = tr +1;
    end
end

avgDistance = mean(getValidDis);
stdevDistance = std(getValidDis);

getimpDist = zeros(1,1);
tr = 1;
for m = 1:1:length(keepAllValues)
    dist = keepAllValues(1,m);
    if(  ( (avgDistance-stdevDistance) <= dist ) && (dist <= (avgDistance+stdevDistance))  )
        getimpDist(tr,1) = dist;
        tr = tr +1;
    end
end
avgVal = mean(getimpDist);
avgVal = round(avgVal);
return;
end