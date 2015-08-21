% The gola of this function is to make body of reference word equal to body
% of test word
function [FilteredConnectedCom] = AnalyzeRefWord(l1Ref,l4Ref,topLineRef,baseLineRef,componentRefImg,ImgRef,accumulatedCell,featureFunc,avgWidth)
% [~, nColRef] = size(beforeRLSARef);
l1Test = accumulatedCell(1,1);
l4Test = accumulatedCell(1,2);
topLineTest = accumulatedCell(1,3);
baseLineTest = accumulatedCell(1,4);

[nRow,nCol] = size(ImgRef);

% aspectRatio = nRw/nCol;
% changedWidth = ceil(hghtTestComponent/aspectRatio);
% ImgRefNw = imresize(ImgRef,[hghtTestComponent changedWidth]);
% componentImgNw = imresize(componentImg,[hghtTestComponent changedWidth]);


aspectRatio = ((abs(baseLineRef - topLineRef))+1)/nCol; % The aspect ratio of the ref word, by considering only the base lines or body of word
changedWidth = ceil(((abs(baseLineTest - topLineTest))+1)/aspectRatio); % changed width of the ref word
nwHgt = (((abs(baseLineTest - topLineTest))+1)/((abs(baseLineRef - topLineRef))+1))*(nRow);

ChangedRefImg = imresize(ImgRef,[nwHgt changedWidth]);
ChangedComponentImg = imresize(componentRefImg,[nwHgt changedWidth]);


if((l1Ref ~= topLineRef)&& (l4Ref ~= baseLineRef))
    %
    changedHghtTop = round(((abs(baseLineTest - topLineTest))*(abs(l1Ref - topLineRef)))/(abs(baseLineRef - topLineRef)));
    %     ImgRefNwTop = imresize(ImgRef(l1Ref:topLineRef,:),[changedHghtTop changedWidth]);
    %     componentImgNwTop = imresize(componentImg(l1Ref:topLineRef,:),[changedHghtTop changedWidth]);
    %
    changedHghtBottom = round(((abs(baseLineTest - topLineTest))*(abs(l4Ref - baseLineRef)))/(abs(baseLineRef - topLineRef)));
    %     ImgRefNwBottom = imresize(ImgRef(baseLineRef:l4Ref,:),[changedHghtBottom changedWidth]);
    %     componentImgNwBottom = imresize(componentImg(baseLineRef:l4Ref,:),[changedHghtBottom changedWidth]);
    %
    %     changedImg = zeros((changedHghtTop+(abs(baseLineTest - topLineTest))+changedHghtBottom),changedWidth);
    %     changedImg(1:changedHghtTop,:) = ImgRefNwTop(:,:);
    %     changedImg(changedHghtTop+1:(changedHghtTop+(abs(baseLineTest - topLineTest))),:) = ImgRefNwBody(:,:);
    %     changedImg(((changedHghtTop+(abs(baseLineTest - topLineTest)))+1):...
    %         ((changedHghtTop+(abs(baseLineTest - topLineTest))))+changedHghtBottom,:) = ImgRefNwBottom(:,:);
    %
    %     changedImgBin = zeros((changedHghtTop+(abs(baseLineTest - topLineTest))+changedHghtBottom),changedWidth);
    %     changedImgBin(1:changedHghtTop,:) = componentImgNwTop(:,:);
    %     changedImgBin(changedHghtTop+1:(changedHghtTop+(abs(baseLineTest - topLineTest))),:) = ChangedcomponentImg(:,:);
    %     changedImgBin(((changedHghtTop+(abs(baseLineTest - topLineTest)))+1):...
    %         ((changedHghtTop+(abs(baseLineTest - topLineTest))))+changedHghtBottom,:) = componentImgNwBottom(:,:);
    l1 = 1;
    l4 = (changedHghtTop+(abs(baseLineTest - topLineTest))+changedHghtBottom)+1;
    topLin = changedHghtTop;
    botLin = ((changedHghtTop+(abs(baseLineTest - topLineTest))));
elseif((l1Ref == topLineRef)&& (l4Ref ~= baseLineRef))
    %
    %
    changedHghtBottom = round(((abs(baseLineTest - topLineTest))*(abs(l4Ref - baseLineRef)))/(abs(baseLineRef - topLineRef)));
    %     ImgRefNwBottom = imresize(ImgRef(baseLineRef:l4Ref,:),[changedHghtBottom changedWidth]);
    %     componentImgNwBottom = imresize(componentImg(baseLineRef:l4Ref,:),[changedHghtBottom changedWidth]);
    %
    %     changedImg = zeros(((abs(baseLineTest - topLineTest))+changedHghtBottom),changedWidth);
    %     changedImg(topLineTest:baseLineTest,:) = ImgRefNwBody(:,:);
    %
    %     changedImg((baseLineTest+1):(baseLineTest + changedHghtBottom),:) = ImgRefNwBottom(:,:);
    %
    %     changedImgBin = zeros(((abs(baseLineTest - topLineTest))+changedHghtBottom),changedWidth);
    %     changedImgBin(topLineTest:baseLineTest,:) = ChangedcomponentImg(:,:);
    %
    %     changedImgBin((baseLineTest+1):(baseLineTest + changedHghtBottom),:) = componentImgNwBottom(:,:);
    %
    l1 = 1;
    topLin = 1;
    l4 = ((abs(baseLineTest - topLineTest))+changedHghtBottom)+1;
    botLin = ((abs(baseLineTest - topLineTest)));
elseif((l1Ref ~= topLineRef)&& (l4Ref == baseLineRef))
    %
    changedHghtTop = round(((abs(baseLineTest - topLineTest))*(abs(l1Ref - topLineRef)))/(abs(baseLineRef - topLineRef)));
    %     ImgRefNwTop = imresize(ImgRef(l1Ref:topLineRef,:),[changedHghtTop changedWidth]);
    %     componentImgNwTop = imresize(componentImg(l1Ref:topLineRef,:),[changedHghtTop changedWidth]);
    %
    %
    %
    %     changedImg = zeros((changedHghtTop+(abs(baseLineTest - topLineTest))),changedWidth);
    %     changedImg(1:changedHghtTop,:) = ImgRefNwTop(:,:);
    %     changedImg(changedHghtTop+1:(changedHghtTop+(abs(baseLineTest - topLineTest))),:) = ImgRefNwBody(:,:);
    %
    %
    %     changedImgBin = zeros((changedHghtTop+(abs(baseLineTest - topLineTest))),changedWidth);
    %     changedImgBin(1:changedHghtTop,:) = componentImgNwTop(:,:);
    %     changedImgBin(changedHghtTop+1:(changedHghtTop+(abs(baseLineTest - topLineTest))),:) = ChangedcomponentImg(:,:);
    %
    l1  = 1;
    l4 = (changedHghtTop+(abs(baseLineTest - topLineTest)))+1;
    topLin = changedHghtTop;
    botLin = l4;
    
elseif((l1Ref == topLineRef)&& (l4Ref == baseLineRef))
    %     changedImg = zeros((abs(baseLineTest - topLineTest)),changedWidth);
    %     changedImg(:,:) = ImgRefNwBody(:,:);
    %
    %
    %     changedImgBin = zeros((abs(baseLineTest - topLineTest)),changedWidth);
    %     changedImgBin(:,:) = ChangedcomponentImg(:,:);
    %
    l1 = 1;
    topLin = 1;
    l4 = (abs(baseLineTest - topLineTest))+1;
    botLin = l4;
end

if(strcmp(featureFunc,'columnFeature'))
    [featureMat,lukUpTableForRealIndex] = GetFeatureOfComponentUpdated_2Exp(ChangedComponentImg,ChangedRefImg);
elseif ((strcmp(featureFunc,'HOGFeature')))
    [featureMat,lukUpTableForRealIndex] = getHOGFeature(ChangedRefImg,ChangedComponentImg,avgWidth);
end

ChangedRefImg(l1,:) = 1;
ChangedRefImg(l4,:) = 1;
ChangedRefImg(topLin,:) = 1;
ChangedRefImg(botLin,:) = 1;

if((abs((baseLineTest - topLineTest) - (botLin - topLin)))>1)
    disp('Body is not normalized correctly');
end

FilteredConnectedCom{1,1} = 0;%HoldConnecComMoreRefined{Chk,1};
FilteredConnectedCom{1,2} = ChangedRefImg; % Storing by cutting with the proper boundary of the Component image
FilteredConnectedCom{1,3} = featureMat;
FilteredConnectedCom{1,4} = lukUpTableForRealIndex;

return;
end

