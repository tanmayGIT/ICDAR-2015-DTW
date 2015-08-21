function [X,Y,Z,M,highIndex]  = plotAccuracyGraph_1(storResultOfAllRef)
sortedContainerArr = zeros(length(storResultOfAllRef),1);
highIndex  = 1;
for i=1:1:length(storResultOfAllRef)
    sortedContainerArr(i,1) = length(storResultOfAllRef{i,1});
    if(length(storResultOfAllRef{i,1}) > highIndex)
        highIndex = length(storResultOfAllRef{i,1});
    end
end
makeAvg = zeros(highIndex,3);

sortedContainerArr = sort(sortedContainerArr);
for eachQuery = 1:1:length(storResultOfAllRef)
    cnt = 1;
    for enterCell = 1:1:length(storResultOfAllRef{eachQuery,1})
        makeAvg(cnt,1) = makeAvg(cnt,1) + storResultOfAllRef{eachQuery,1}(enterCell,1);
        makeAvg(cnt,2) = makeAvg(cnt,2) + storResultOfAllRef{eachQuery,1}(enterCell,2);
        cnt = cnt +1;
    end
end
meanMakeAvg = zeros(highIndex,3);


for uu = 1:1:highIndex
    divFactor = find(sortedContainerArr >= uu); % find how many cells maximum index are less eq to uu
    divFactor = length(divFactor);
    meanMakeAvg(uu,1) = (makeAvg(uu,1)/divFactor);
    meanMakeAvg(uu,2) = (makeAvg(uu,2)/divFactor);
    calP = meanMakeAvg(uu,1);
    calR = meanMakeAvg(uu,2);
    fMeasure = (2*calP*calR)/(calP+calR);
    meanMakeAvg(uu,3) = fMeasure;
end
X = (1:highIndex);
X = X';
Y = meanMakeAvg(:,1);
Z = meanMakeAvg(:,2);
M = meanMakeAvg(:,3) ;
% figure,plot(X,Y);
% figure,plot(X,Z);
end