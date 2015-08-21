function [D_targetData,D_refData,nBlkTarget] = PAA(Data_Ref,Data_Target,avgWidth)
% global stroke
% avgWidth = stroke;%round(avgWidth);
if ((rem((size(Data_Target,1)),avgWidth)) == 0);
    nBlkTarget = (size(Data_Target,1))/avgWidth;
else
    nBlkTarget = ((size(Data_Target,1)) - (rem((size(Data_Target,1)),avgWidth)))/avgWidth;
end

if ((rem((size(Data_Ref,1)),avgWidth)) == 0);
    nBlkRef = (size(Data_Ref,1))/avgWidth;
else
    nBlkRef = ((size(Data_Ref,1)) - (rem((size(Data_Ref,1)),avgWidth)))/avgWidth;
end

[Target_Row, Target_Col] = size(Data_Target);
[Ref_Row, Ref_Col] = size(Data_Ref);

targetRes = mod(Target_Row,nBlkTarget);
refRes = mod(Ref_Row,nBlkRef);

target_Blk_Length = (Target_Row - targetRes)/nBlkTarget;
ref_Blk_Length = (Ref_Row - refRes)/nBlkRef;

if(targetRes ~= 0)
    if(isnan(nBlkTarget))||(nBlkTarget == Inf)
        disp('you are ill');
    end
    D_targetData = zeros(nBlkTarget+1,Target_Col);
    targetCnt = 1;
    for j=1:Target_Col
        for i=1:target_Blk_Length:(Target_Row-targetRes)
            meanVal = mean(Data_Target(i:((i+target_Blk_Length)-1),j));
            D_targetData(targetCnt,j) = meanVal;
            targetCnt = targetCnt +1;
        end
        D_targetData(targetCnt,j) = mean(Data_Target(i:Target_Row,j));
        targetCnt = 1;
    end
else
    D_targetData = zeros(nBlkTarget,Target_Col);
    targetCnt = 1;
    for j=1:Target_Col
        for i=1:target_Blk_Length:(Target_Row)
            meanVal = mean(Data_Target(i:((i+target_Blk_Length)-1),j));
            D_targetData(targetCnt,j) = meanVal;
            targetCnt = targetCnt +1;
        end
        targetCnt = 1;
    end
end

if(refRes ~= 0)
    D_refData = zeros(nBlkRef+1,Ref_Col);
    refCnt = 1;
    for j = 1:Ref_Col
        for i = 1:ref_Blk_Length:(Ref_Row-refRes)
            meanVal = mean(Data_Ref(i:((i+ref_Blk_Length)-1),j));
            D_refData(refCnt,j) = meanVal;
            refCnt = refCnt+1;
        end
        D_refData(refCnt,j) = mean(Data_Ref(i:Ref_Row,j));
        refCnt = 1;
    end
else
    D_refData = zeros(nBlkRef,Ref_Col);
    refCnt = 1;
    for j = 1:Ref_Col
        for i = 1:ref_Blk_Length:(Ref_Row-refRes)
            meanVal = mean(Data_Ref(i:((i+ref_Blk_Length)-1),j));
            D_refData(refCnt,j) = meanVal;
            refCnt = refCnt+1;
        end
        refCnt = 1;
    end
end
return;
end