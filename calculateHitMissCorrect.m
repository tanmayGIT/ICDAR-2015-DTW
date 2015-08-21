function [refinedPrunnedSet] = calculateHitMissCorrect(realGT,prunnedSet,keepAllFeature)
totalGT = length(realGT);
matchedCnt = 0;
refinedPrunnedSet = prunnedSet;
for ii = 1:1:size(realGT,2)
    tempGT = realGT{1,ii};
    i_got_uFlag = 0;
    for jj = 1:1:size(prunnedSet,1)
        testGT = prunnedSet{jj,1};
        if(strcmp(tempGT,testGT))
            matchedCnt = matchedCnt +1;
            i_got_uFlag = 1;
            continue;
        end
    end
    % if the i_got_uFlag still 0 then there is a problem; so forcefully
    % push the particular image in the array
    if(i_got_uFlag == 0)
        getIndex = changePrunningSet(tempGT,keepAllFeature);
        refinedPrunnedSet{end+1,1} = tempGT;
        refinedPrunnedSet{end,2} = getIndex; % you have already reached the end
    end
end
% hitted = matchedCnt;
% missed = totalGT - hitted;
end
function getIndex = changePrunningSet(tempGT,keepAllFeature)
% look for the GT and it's index in the complete arry

for ii = 1:1:size(keepAllFeature,1)
    testImgPath = keepAllFeature{ii,4};
    [~, testName, ~] = fileparts(testImgPath);
    if(strcmp(testName,tempGT))
        getIndex = ii;
        break;
    end
end
return;
end