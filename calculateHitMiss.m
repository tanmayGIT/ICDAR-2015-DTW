function [hitted,missed,totalGT] = calculateHitMiss(realGT,prunnedSet)
totalGT = length(realGT);
matchedCnt = 0;
for ii = 1:1:size(realGT,2)
    tempGT = realGT{1,ii};
    flag = 0;
    for jj = 1:1:size(prunnedSet,1)
        testGT = prunnedSet{jj,1};
        if(strcmp(tempGT,testGT))
            matchedCnt = matchedCnt +1;
            flag = 1;
            continue;
        end
    end
    if(flag == 0)
        disp('you have prob');
        disp(tempGT);
    end
end
hitted = matchedCnt;
missed = totalGT - hitted;
end