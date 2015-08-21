function [distVal,getIntoCell] = stringMatchingWithFunction_GW(refWordMat,testWordMat,technique,percent)
avgWdth = percent;
realIndexRef = 1:(size(refWordMat,1));
realIndexRef = realIndexRef';
realIndexTest = 1:(size(testWordMat,1));
realIndexTest = realIndexTest';
if(strcmp(technique,'DTW'))
    straight = 1;
    [distVal,~,~] = DynamicTimeWarping(refWordMat,testWordMat,straight);
    pathCost = 0;
else
    getIntoCell = cell(1,2);
    if((size(refWordMat,1)) < (size(testWordMat,1)))
        straight = 1;
        doBin = 1;
        if(strcmp(technique,'MVM'))
            [pathCost,~,indexCol,indexRow,distVal] = MinimalVarianceMatching(refWordMat,testWordMat);
        elseif(strcmp(technique,'WDTW'))
            [distVal,indexCol,indexRow] = WeightedDynamicTimeWarping(refWordMat,testWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'LCSS'))
            [distVal,indexCol,indexRow] = LCSS(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'FastDTW'))
            [distVal,indexCol,indexRow] = fastDTW(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'SSDTW'))
            [distVal,indexCol,indexRow] = subsequenceDynamicTimeWarping(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'SC_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_SC_Band(refWordMat,testWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'0_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,0,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'0_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,0,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'1_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,1,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'1_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,1,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'2_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,2,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'2_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,2,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'50_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,0.5,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'50_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,0.5,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'3_LDTW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,3,'LDTW');
            pathCost = 0;
        elseif(strcmp(technique,'4_SomethingNew'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,4,'SomethingNew');
            pathCost = 0;
        elseif(strcmp(technique,'Itekura_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_Itakura_Band(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'CDTW'))
            [distVal,indexCol,indexRow] = cdtw(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'JawaharDTW'))
            [distVal,indexCol,indexRow] = DTW_Jahawar(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'DTW_CW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_CW(refWordMat,testWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'PDTW'))
            [distVal,indexCol,indexRow] = PAA_PDTW(refWordMat,testWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'PDDTW'))
            [distVal,indexCol,indexRow] = PeicewiseDerivative_DynamicTimeWarping(refWordMat,testWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'WDDTW'))
            [distVal,indexCol,indexRow] = Weighted_Derivative_DynamicTimeWarping(refWordMat,testWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'CDP2'))
            [indexCol,indexRow,distVal] = cdp_2(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'CDP1'))
            [indexCol,indexRow,distVal] = cdp_1(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'DDTW'))
            [distVal,indexCol,indexRow] = Derivative_DynamicTimeWarping(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'OSB'))
            targetskip = abs(size(refWordMat,1) - size(testWordMat,1));
            
            if(targetskip < avgWdth)
                targetskip = avgWdth;
            end
            queryskip = targetskip;
            warpwin = targetskip;
            
            [distVal,indexCol,indexRow,distValAux] = OSBv5_C(refWordMat,testWordMat,warpwin,queryskip,targetskip);
        elseif(strcmp(technique,'MVM_Updated'))
            [pathCost,~,indexCol,indexRow,distVal] = MVM_Updated_8(refWordMat,testWordMat,straight);
        elseif(strcmp(technique,'MVM_Updated_3'))
            [pathCost,~,indexCol,indexRow,distVal] = MVM_Updated_3(refWordMat,testWordMat,straight);
        elseif(strcmp(technique,'MVM_Updated_7'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_7(refWordMat,testWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_9'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_9(refWordMat,testWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_10'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_10(refWordMat,testWordMat,doBin);
            distVal = ((distVal))/(size(indxcol,1));
        elseif(strcmp(technique,'MVM_Updated_11'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_11(refWordMat,testWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_12'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_12_2(refWordMat,testWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_13'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_13(refWordMat,testWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_14'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_14(refWordMat,testWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_15'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_12(refWordMat,testWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_16'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_12(refWordMat,testWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_17'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_17_6(refWordMat,testWordMat,doBin,straight);
        end
        updatedIndexRow = zeros((size(indexRow,1)),1);
        updatedIndexCol = zeros((size(indexCol,1)),1);
        for i=1:1:size(indexRow,1)
            val1 = indexRow(i,1);
            val2 = indexCol(i,1);
            updatedIndexRow(i,1) = realIndexRef(val1,1);
            updatedIndexCol(i,1) = realIndexTest(val2,1);
        end
        getIntoCell{1,1} =  updatedIndexRow;
        getIntoCell{1,2} =  updatedIndexCol;
        
    else
        % just reversing the logic to handle the problem, if reference word is bigger than the test word
        straight = 2;
        doBin = 1;
        if(strcmp(technique,'MVM'))
            [pathCost,~,indexCol,indexRow,distVal] = MinimalVarianceMatching(testWordMat,refWordMat);
        elseif(strcmp(technique,'WDTW'))
            [distVal,indexCol,indexRow] = WeightedDynamicTimeWarping(testWordMat,refWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'LCSS'))
            [distVal,indexCol,indexRow] = LCSS(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'JawaharDTW'))
            [distVal,indexCol,indexRow] = DTW_Jahawar(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'0_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,0,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'0_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,0,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'1_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,1,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'1_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,1,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'50_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,0.5,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'50_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,0.5,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'2_Symmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,2,'Symmetric');
            pathCost = 0;
        elseif(strcmp(technique,'2_Asymmetric'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,2,'Asymmetric');
            pathCost = 0;
        elseif(strcmp(technique,'3_LDTW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,3,'LDTW');
            pathCost = 0;
        elseif(strcmp(technique,'4_SomethingNew'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,4,'SomethingNew');
            pathCost = 0;
        elseif(strcmp(technique,'SSDTW'))
            [distVal,indexCol,indexRow] = subsequenceDynamicTimeWarping(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'CDTW'))
            [distVal,indexCol,indexRow] = cdtw(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'Itekura_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_Itakura_Band(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'SC_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_SC_Band(testWordMat,refWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'DTW_CW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_CW(testWordMat,refWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'FastDTW'))
            [distVal,indexCol,indexRow] = fastDTW(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'PDTW'))
            [distVal,indexCol,indexRow] = PAA_PDTW(testWordMat,refWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'PDDTW'))
            [distVal,indexCol,indexRow] = PeicewiseDerivative_DynamicTimeWarping(testWordMat,refWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'WDDTW'))
            [distVal,indexCol,indexRow] = Weighted_Derivative_DynamicTimeWarping(testWordMat,refWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'CDP2'))
            [indexCol,indexRow,distVal] = cdp_2(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'CDP1'))
            [indexCol,indexRow,distVal] = cdp_1(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'DDTW'))
            [distVal,indexCol,indexRow] = Derivative_DynamicTimeWarping(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'OSB'))
            targetskip = abs(size(refWordMat,1) - size(testWordMat,1));
            
            if(targetskip < avgWdth)
                targetskip = avgWdth;
            end
            queryskip = targetskip;
            warpwin = targetskip;
            
            [distVal,indexCol,indexRow,distValAux] = OSBv5_C(testWordMat,refWordMat,warpwin,queryskip,targetskip);
        elseif(strcmp(technique,'MVM_Updated'))
            [pathCost,~,indexCol,indexRow,distVal] = MVM_Updated_8(testWordMat,refWordMat,straight);
        elseif(strcmp(technique,'MVM_Updated_3'))
            [pathCost,~,indexCol,indexRow,distVal] = MVM_Updated_3(testWordMat,refWordMat,straight);
        elseif(strcmp(technique,'MVM_Updated_7'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_7(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_9'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_9(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_10'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_10(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_11'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_11(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_12'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_12_2(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_13'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_11(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_14'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_11(testWordMat,refWordMat,doBin);
        elseif(strcmp(technique,'MVM_Updated_15'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_12(testWordMat,refWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_16'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_12(testWordMat,refWordMat,doBin,straight);
        elseif(strcmp(technique,'MVM_Updated_17'))
            [pathCost,~,indexCol,indexRow,distVal,jumpcost] = MVM_Updated_17_6_Reverse(testWordMat,refWordMat,doBin);
        end
        tempIndexRow = indexRow;
        indexRow = indexCol;
        indexCol = tempIndexRow;
        
        updatedIndexRow = zeros((size(indexRow,1)),1);
        updatedIndexCol = zeros((size(indexCol,1)),1);
        for i=1:1:size(indexRow,1)
            val1 = indexRow(i,1);
            val2 = indexCol(i,1);
            updatedIndexRow(i,1) = realIndexRef(val1,1);
            updatedIndexCol(i,1) = realIndexTest(val2,1);
        end
        getIntoCell{1,1} =  updatedIndexRow;
        getIntoCell{1,2} =  updatedIndexCol;
    end
end
return;
end