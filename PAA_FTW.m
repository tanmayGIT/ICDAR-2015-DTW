function [D_targetData,nBlkTarget] = PAA_FTW(Data_Target,avgWidth)
if ((rem((size(Data_Target,1)),avgWidth)) == 0);
    nBlkTarget = (size(Data_Target,1))/avgWidth;
else
    nBlkTarget = ((size(Data_Target,1)) - (rem((size(Data_Target,1)),avgWidth)))/avgWidth;
end

[Target_Row, Target_Col] = size(Data_Target);
targetRes = mod(Target_Row,nBlkTarget);
target_Blk_Length = (Target_Row - targetRes)/nBlkTarget;

if(targetRes ~= 0)
    if(isnan(nBlkTarget))||(nBlkTarget == Inf)
        disp('you are ill');
    end
    D_targetData = cell(nBlkTarget+1,Target_Col);
    targetCnt = 1;
    for j=1:Target_Col
        for i=1:target_Blk_Length:(Target_Row-targetRes)
            minVal = min(Data_Target(i:((i+target_Blk_Length)-1),j));
            maxVal = max(Data_Target(i:((i+target_Blk_Length)-1),j));
            D_targetData{targetCnt,j} = [minVal,maxVal,target_Blk_Length]; % first cell is minVal, second cell is maxVal and the last cell is target_Blk_Length
            targetCnt = targetCnt +1;
        end
        minVal = min(Data_Target(i:Target_Row,j));
        maxVal = max(Data_Target(i:Target_Row,j));
        D_targetData{targetCnt,j} = [minVal,maxVal,((Target_Row-i)+1)];
        targetCnt = 1;
    end
else
    D_targetData = cell(nBlkTarget,Target_Col);
    targetCnt = 1;
    for j=1:Target_Col
        for i=1:target_Blk_Length:(Target_Row)
            minVal = min(Data_Target(i:((i+target_Blk_Length)-1),j));
            maxVal = max(Data_Target(i:((i+target_Blk_Length)-1),j));
            D_targetData{targetCnt,j} = [minVal,maxVal,target_Blk_Length];
            targetCnt = targetCnt +1;
        end
        targetCnt = 1;
    end
end
return;
end