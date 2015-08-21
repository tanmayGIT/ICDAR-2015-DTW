function [X,Y,Z,M,highIndex]  = plotAccuracyGraph(storResultOfAllRef)
% nn = 80;]
highIndex  = 1;
for i=1:1:length(storResultOfAllRef) 
    if(length(storResultOfAllRef{i,1}) > highIndex)
        highIndex = length(storResultOfAllRef{i,1});
    end
end
% Now fil all vallues
for i=1:1:length(storResultOfAllRef) 
    if(length(storResultOfAllRef{i,1}) < highIndex)
        newArr = zeros(highIndex,3);
        newArr(1:(length(storResultOfAllRef{i,1})),:) = storResultOfAllRef{i,1}(:,:);
        nGT = ceil((storResultOfAllRef{i,1}((length(storResultOfAllRef{i,1})),1))*(length(storResultOfAllRef{i,1})));
        for k = (length(storResultOfAllRef{i,1})+1):1:highIndex
            newArr(k,1) = nGT/k;%storResultOfAllRef{i,1}((length(storResultOfAllRef{i,1})),1);
            newArr(k,2) = storResultOfAllRef{i,1}((length(storResultOfAllRef{i,1})),2);
            newArr(k,3) = (2*newArr(k,1)*newArr(k,2))/(newArr(k,1)+newArr(k,2));
        end
        storResultOfAllRef{i,1} = newArr;
    end
end

pr = zeros(highIndex,length(storResultOfAllRef) );
recall = zeros(highIndex,length(storResultOfAllRef) );
fScore = zeros(highIndex,length(storResultOfAllRef) );
for i = 1:1:length(storResultOfAllRef) 
    for j = 1:1:highIndex
        pr(j,i) = storResultOfAllRef{i,1}(j,1);
        recall(j,i) = storResultOfAllRef{i,1}(j,2);
        fScore(j,i) = storResultOfAllRef{i,1}(j,3);
    end
end
prMean = zeros(highIndex,1);
recallMean = zeros(highIndex,1);
fMeasure = zeros(highIndex,1);
for k = 1:1:highIndex
    prMean(k,1) = mean(pr(k,:));
    recallMean(k,1) = mean(recall(k,:));
    fMeasure(k,1) = mean(fScore(k,:)) ;
end
X = (1:highIndex);
X = X';
Y = prMean(:,1);
Z = recallMean(:,1);
M = fMeasure(:,1) ;
% figure,plot(X,Y);
% figure,plot(X,Z);
end