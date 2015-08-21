function [pathCost,distVal,getIntoCell] = stringMatchingWithFunction(refWordMat,testWordMat,realIndexRef,realIndexTest,technique,featureFunc,avgWdth,percent) % refCharWord is
% to which we are matching and testCharWord is with which we are matching

if(strcmp(technique,'DTW'))
    getIntoCell = cell(1,2);
    % if((size(refWordMat,1)) < (size(testWordMat,1)))
    straight = 1;
    
    [distVal,indexCol,indexRow] = DynamicTimeWarping(refWordMat,testWordMat,straight);
    if(strcmp(featureFunc,'columnFeature'))
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
        pathCost = 0;
    end
    if(strcmp(featureFunc,'HOGFeature'))
        updatedIndexRow = zeros(length(indexRow),2);
        updatedIndexCol = zeros(length(indexCol),2);
        for i=1:1:size(indexRow,1)
            val1 = indexRow(i,1);
            val2 = indexCol(i,1);
            
            updatedIndexRow(i,1) = realIndexRef(val1,1);
            updatedIndexRow(i,2) = realIndexRef(val1,2);
            
            updatedIndexCol(i,1) = realIndexTest(val2,1);
            updatedIndexCol(i,2) = realIndexTest(val2,2);
        end
        getIntoCell{1,1} =  updatedIndexRow;
        getIntoCell{1,2} =  updatedIndexCol;
        pathCost = 0;
    end
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
        elseif(strcmp(technique,'FastDTW'))
            [distVal,indexCol,indexRow] = fastDTW(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'SSDTW'))
            [distVal,indexCol,indexRow] = subsequenceDynamicTimeWarping(refWordMat,testWordMat,straight);
            pathCost = 0;
        elseif(strcmp(technique,'SC_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_SC_Band(refWordMat,testWordMat,percent);
            if(distVal == -5)
                 [distVal,indexCol,indexRow] = DynamicTimeWarping(refWordMat,testWordMat,straight);
            end
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
        elseif(strcmp(technique,'sparseDTW'))
            [distVal,indexCol,indexRow] = SparseDTW(refWordMat,testWordMat);
            pathCost = 0;    
        elseif(strcmp(technique,'3_LDTW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,3,'LDTW');
            if(distVal == -5)
                [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,3,'LDTW');
            end
            pathCost = 0;
        elseif(strcmp(technique,'5_LDTW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,5,'LDTW');
            if(distVal == -5)
                [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,3,'LDTW');
            end
            pathCost = 0;
        elseif(strcmp(technique,'4_SomethingNew'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(refWordMat,testWordMat,4,'SomethingNew');
            pathCost = 0;
        elseif(strcmp(technique,'Itekura_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_Itakura_Band(refWordMat,testWordMat);
            if(distVal == -5)
                [distVal,indexCol,indexRow] = DynamicTimeWarping(refWordMat,testWordMat);
            end
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
            [distVal,indexCol,indexRow] = PAA_PDTW(refWordMat,testWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'PDDTW'))
            [distVal,indexCol,indexRow] = PeicewiseDerivative_DynamicTimeWarping(refWordMat,testWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'WDDTW'))
            [distVal,indexCol,indexRow] = Weighted_Derivative_DynamicTimeWarping(refWordMat,testWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'CDP2'))
            [indexCol,indexRow,distVal] = cdp_2(refWordMat,testWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'CDP1'))
            [indexCol,indexRow,distVal] = cdp_1(refWordMat,testWordMat,straight);
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
                      
            [pathCost,indexCol,indexRow,distVal] = OSBv5_C(refWordMat,testWordMat,warpwin,queryskip,targetskip);
            distVal = pathCost;
            
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
        
        if(strcmp(featureFunc,'columnFeature'))
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
        if(strcmp(featureFunc,'HOGFeature'))
            updatedIndexRow = zeros(length(indexRow),2);
            updatedIndexCol = zeros(length(indexCol),2);
            for i=1:1:size(indexRow,1)
                val1 = indexRow(i,1);
                val2 = indexCol(i,1);
                
                updatedIndexRow(i,1) = realIndexRef(val1,1);
                updatedIndexRow(i,2) = realIndexRef(val1,2);
                
                updatedIndexCol(i,1) = realIndexTest(val2,1);
                updatedIndexCol(i,2) = realIndexTest(val2,2);
            end
            getIntoCell{1,1} =  updatedIndexRow;
            getIntoCell{1,2} =  updatedIndexCol;
        end
    else
        %     just reversing the logic to handle the problem, if reference word is bigger than the test word
        straight = 2;
        doBin = 1;
        if(strcmp(technique,'MVM'))
            [pathCost,~,indexCol,indexRow,distVal] = MinimalVarianceMatching(testWordMat,refWordMat);
        elseif(strcmp(technique,'WDTW'))
            [distVal,indexCol,indexRow] = WeightedDynamicTimeWarping(testWordMat,refWordMat,percent);
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
        elseif(strcmp(technique,'sparseDTW'))
            [distVal,indexCol,indexRow] = SparseDTW(testWordMat,refWordMat);
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
            if(distVal == -5)
               [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,3,'LDTW'); 
            end
            pathCost = 0;
        elseif(strcmp(technique,'5_LDTW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,5,'LDTW');
            if(distVal == -5)
               [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,3,'LDTW'); 
            end
            pathCost = 0;
        elseif(strcmp(technique,'4_SomethingNew'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_VariousWarpingPath(testWordMat,refWordMat,4,'SomethingNew');
            pathCost = 0;
        elseif(strcmp(technique,'SSDTW'))
            [distVal,indexCol,indexRow] = subsequenceDynamicTimeWarping(testWordMat,refWordMat,straight);
            pathCost = 0;
        elseif(strcmp(technique,'CDTW'))
            [distVal,indexCol,indexRow] = cdtw(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'Itekura_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_Itakura_Band(testWordMat,refWordMat);
            if(distVal == -5)
                [distVal,indexCol,indexRow] = DynamicTimeWarping(testWordMat,refWordMat);
            end
            pathCost = 0;
        elseif(strcmp(technique,'SC_Band'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_SC_Band(testWordMat,refWordMat,percent);
            pathCost = 0;
            if(distVal == -5)
                 [distVal,indexCol,indexRow] = DynamicTimeWarping(testWordMat,refWordMat,percent);
            end
        elseif(strcmp(technique,'DTW_CW'))
            [distVal,indexCol,indexRow] = DynamicTimeWarping_CW(testWordMat,refWordMat,avgWdth);
            pathCost = 0;
        elseif(strcmp(technique,'FastDTW'))
            [distVal,indexCol,indexRow] = fastDTW(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'PDTW'))
            [distVal,indexCol,indexRow] = PAA_PDTW(testWordMat,refWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'PDDTW'))
            [distVal,indexCol,indexRow] = PeicewiseDerivative_DynamicTimeWarping(testWordMat,refWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'WDDTW'))
            [distVal,indexCol,indexRow] = Weighted_Derivative_DynamicTimeWarping(testWordMat,refWordMat,percent);
            pathCost = 0;
        elseif(strcmp(technique,'CDP2'))
            [indexCol,indexRow,distVal] = cdp_2(testWordMat,refWordMat);
            pathCost = 0;
        elseif(strcmp(technique,'CDP1'))
            [indexCol,indexRow,distVal] = cdp_1(testWordMat,refWordMat,straight);
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
            
            [pathCost,indexCol,indexRow,distVal] = OSBv5_C(testWordMat,refWordMat,warpwin,queryskip,targetskip);
            distVal = pathCost;
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
        if(strcmp(featureFunc,'columnFeature'))
            %     so for this case indexRow will orginally will refer to the test word and indexCol is to the reference word
            %     so we will just swap the two array
            
            
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
            
            % This value is decided based on the feature matrix as the feature matrix is only have
            % participated in distance calculation. The original image
            % matrix has not been considered and we
            % have not considered the coulmns having no foreground pixels
            % for the calculation of matching. For the matching we have
            % only considered the feature matrix and Reverese Matching
            % penalty should be dependent on only the feature matrix
            if((strcmp(technique,'MVM_Updated_7'))|| (strcmp(technique,'MVM_Updated_9'))|| (strcmp(technique,'MVM_Updated_10')))
                colSkipped = (indexRow(1,1)-1)+( (size(refWordMat,1))-indexRow(end,1) );
                distVal = distVal + (colSkipped*jumpcost);
            end
            
            getIntoCell{1,1} =  updatedIndexRow;
            getIntoCell{1,2} =  updatedIndexCol;
        end
        if(strcmp(featureFunc,'HOGFeature'))
            %     so for this case indexRow will orginally will refer to the test word and indexCol is to the reference word
            %     so we will just swap the two array
            
            tempIndexRow = indexRow;
            indexRow = indexCol;
            indexCol = tempIndexRow;
            
            updatedIndexRow = zeros(length(indexRow),2);
            updatedIndexCol = zeros(length(indexCol),2);
            for i=1:1:size(indexRow,1)
                val1 = indexRow(i,1);
                val2 = indexCol(i,1);
                
                updatedIndexRow(i,1) = realIndexRef(val1,1);
                updatedIndexRow(i,2) = realIndexRef(val1,2);
                
                updatedIndexCol(i,1) = realIndexTest(val2,1);
                updatedIndexCol(i,2) = realIndexTest(val2,2);
            end
            % Here we have not ignored any column having no foreground
            % pixels. So all the column belonging to images are taken into
            % consideration for matching
            %
            if((strcmp(technique,'MVM_Updated_7'))|| (strcmp(technique,'MVM_Updated_9'))|| (strcmp(technique,'MVM_Updated_10')))
                colSkipped = (updatedIndexRow(1,1)-1)+( (realIndexRef(end,2))-updatedIndexRow(end,2) );
                distVal = distVal + (colSkipped*jumpcost);
            end
            
            getIntoCell{1,1} =  updatedIndexRow;
            getIntoCell{1,2} =  updatedIndexCol;
        end
        
    end
end
return;
end