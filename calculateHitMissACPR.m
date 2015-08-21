function [hitted,missed,totalGT] = calculateHitMissACPR(realGT,prunnedSet)
totalGT = length(realGT);
matchedCnt = 0;
for ii = 1:1:size(realGT,1)
    %     tempGT = realGT{1,ii};
    tempGT = realGT{ii,1};
    flag = 0;
    for jj = 1:1:size(prunnedSet,1)
        testGT = prunnedSet{jj,1};
        [~, name, ~] = fileparts(testGT) ;
%         nameDig = str2num(name(1,9:end));
        if(strcmp(tempGT,name))
            matchedCnt = matchedCnt +1;
            flag = 1;
            break;
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