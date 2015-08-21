function [l1,l4,refinedTop,refinedBottom] = testAscenderDescenderFunc(ImgRef)

% ImgRef = imread(strcat(PathName,FileName));
[nRw,nCol] = size(ImgRef);

if(nCol > (3*30)) % the image width has to be greater than (3*30)
    nParts = ceil((nCol/(3*30))); % for dividing the imae into parts
    eachPartWidth = ceil(nCol/nParts);
    storTopBot = zeros(nParts,6);
    for part = 1:1:nParts
        if(part == 1)
            ImgRef_1 = ImgRef(:,1:eachPartWidth);
        elseif(part == nParts)
            ImgRef_1 = ImgRef(:,((part-1)*eachPartWidth)+1:nCol);
        else
            ImgRef_1 = ImgRef(:,((part-1)*eachPartWidth)+1:(part*eachPartWidth));
        end
        [l1_1,l4_1,topLineTest1,bottomLineTest1,alternativeTopPt,alternativeBottomPt] = performPrunning_3(ImgRef_1);
        storTopBot(part,1) = topLineTest1;
        storTopBot(part,2) = bottomLineTest1;
        storTopBot(part,3) = l1_1;
        storTopBot(part,4) = l4_1;
        storTopBot(part,5) = alternativeTopPt;
        storTopBot(part,6) = alternativeBottomPt;
    end
    l1 = min(storTopBot(:,3));
    l4 = max(storTopBot(:,4));
    
    if( (abs( (max(storTopBot(:,1))) -  (min(storTopBot(:,1))) )) > 10)
        topLineTest = max(storTopBot(:,1));
    else
        topLineTest = min(storTopBot(:,1));
    end
    
%     if( ( (abs(max(storTopBot(:,2))) -  (min(storTopBot(:,2)))) ) > 10)
%          bottomLineTest = min(storTopBot(:,2));
%     else
        bottomLineTest = max(storTopBot(:,2));
%     end
    
    if( (abs( (max(storTopBot(:,5))) -  (min(storTopBot(:,5))) )) > 10)
        alternativeTopPt = max(storTopBot(:,5));
    else
        alternativeTopPt = min(storTopBot(:,5));
    end
%     if( (abs( (max(storTopBot(:,6))) -  (min(storTopBot(:,6))) )) > 10)
%         alternativeBottomPt = min(storTopBot(:,6));
%     else
        alternativeBottomPt = max(storTopBot(:,6));
%     end
    
    forLimitLine = (((abs((l4-l1)))*20)/100); % finding the 10% of difference between l4-l1, obviously it will be very small
    %     forBottomLine = (((abs((l4-l1)/2))*2)/100);
    
    % now if any of the detected top line is too close to l1, then there is no meaning to keep that line.
    % the closeness to l1 is calculated by taking the difference from l1
    
    % Now if the difference between topLineTest and  alternativeTopPt is less than forLimitLine then the ascender line row
    % is chosen by taking the row which has minimum number of foreground
    % pixels among topLineTest and alternativeTopPt
    
    if((abs(l1 - alternativeTopPt))<= forLimitLine)
        alternativeTopPt = l1;
    end
    if((abs(l1 - topLineTest))<= forLimitLine)
        topLineTest = l1;
    end
    if((abs(topLineTest - alternativeTopPt))<= forLimitLine)
        cnt1 = length(find(ImgRef(topLineTest,:))); % counting number of pixels present in topLineTest row in binary image
        cnt2 = length(find(ImgRef(alternativeTopPt,:)));% counting number of pixels present in alternativeTopPt row in binary image
        if(cnt2 >= cnt1)
            alternativeTopPt = topLineTest;% topLineTest th row is having minimum foreground pixels
        elseif(cnt2 < cnt1)
            topLineTest = alternativeTopPt;% alternativeTopPt th row is having minimum foreground pixels
        end
        
    end
    % doing the same thing for bottom line
    if((abs(l4 - alternativeBottomPt))<= forLimitLine)
        alternativeBottomPt = l4;
    end
    if((abs(l4 - bottomLineTest))<= forLimitLine)
        bottomLineTest = l4;
    end
    if((abs(bottomLineTest - alternativeBottomPt))<= forLimitLine)
        cnt1 = length(find(ImgRef(bottomLineTest,:))); % counting number of pixels present in bottomLineTest row in binary image
        cnt2 = length(find(ImgRef(alternativeBottomPt,:)));% counting number of pixels present in alternativeBottomPt row in binary image
        if(cnt2 >= cnt1)
            alternativeBottomPt = bottomLineTest;% bottomLineTest th row is having minimum foreground pixels
        elseif(cnt2 < cnt1)
            bottomLineTest = alternativeBottomPt;% alternativeBottomPt th row is having minimum foreground pixels
        end
    end
    
    
    % Now the next technique is to calculate the number of connnected
    % components in ascender portion and descnder portions, so that it
    % can be understood whether the detected ascender/descender is
    % original or not
    
    % So here it is considered that we have sucucessfully detected one
    % top ascender line and either of alternativeTopPt or topLineTest is equal to l1
    
    % Or there can be another condition where alternativeTopPt ==
    % topLineTest; for this case we will not perform this particular test as it is not needed
    % because both detection methos have specified the ascender line so
    % it is sure that this ascender is real
    
%     if ( (l1 == topLineTest) && (topLineTest ~= alternativeTopPt) )
%         ascenderImg = ImgBin(l1:alternativeTopPt-3,:); % -3 becoz sometime the lines are so accurate that it takes some of the body parts
%         CC = bwconncomp(ascenderImg);
%         L = labelmatrix(CC);
%         totalComponentTop = max(max(L));
%         
%         bodyImg = ImgBin(alternativeTopPt:l4,:);
%         CCBody = bwconncomp(bodyImg);
%         LBody = labelmatrix(CCBody);
%         totalComponentBody = max(max(LBody));
%         % If number of component present in ascender is more than atleast half of no.
%         % of component present in the body
%         if(totalComponentTop>(totalComponentBody/2))
%             alternativeTopPt = l1;
%         end
%     elseif ( (l1 == alternativeTopPt) && (alternativeTopPt ~= topLineTest) )
%         ascenderImg = ImgBin(l1:topLineTest-3,:);
%         CC = bwconncomp(ascenderImg);
%         L = labelmatrix(CC);
%         totalComponentTop = max(max(L));
%         
%         bodyImg = ImgBin(topLineTest:l4,:);
%         CCBody = bwconncomp(bodyImg);
%         LBody = labelmatrix(CCBody);
%         totalComponentBody = max(max(LBody));
%         % If number of component present in ascender is more than atleast half of no.
%         % of component present in the body
%         if(totalComponentTop>(totalComponentBody/2))
%             topLineTest = l1;
%         end
%     end
%     
%     % Now do the same for bottom line
%     
%     if ( (l4 == bottomLineTest) && (bottomLineTest ~= alternativeBottomPt) )
%         descenderImg = ImgBin(alternativeBottomPt+3:l4,:);
%         CC = bwconncomp(descenderImg);
%         L = labelmatrix(CC);
%         totalComponentBottom = max(max(L));
%         
%         bodyImg = ImgBin(l1:alternativeBottomPt,:);
%         CCBody = bwconncomp(bodyImg);
%         LBody = labelmatrix(CCBody);
%         totalComponentBody = max(max(LBody));
%         % If number of component present in ascender is more than atleast half of no.
%         % of component present in the body
%         
%         if(totalComponentBottom>(totalComponentBody/2))
%             alternativeBottomPt = l4;
%         end
%     elseif ( (l4 == alternativeBottomPt) && (alternativeBottomPt ~= bottomLineTest) )
%         descenderImg = ImgBin(bottomLineTest+3:l4,:);
%         CC = bwconncomp(descenderImg);
%         L = labelmatrix(CC);
%         totalComponentBottom = max(max(L));
%         
%         bodyImg = ImgBin(l1:bottomLineTest,:);
%         CCBody = bwconncomp(bodyImg);
%         LBody = labelmatrix(CCBody);
%         totalComponentBody = max(max(LBody));
%         % If number of component present in ascender is more than atleast half of no.
%         % of component present in the body
%         
%         if(totalComponentBottom>(totalComponentBody/2))
%             bottomLineTest = l4;
%         end
%     end
    
    % making the final result
    refinedTop = 1;
    refinedBottom = nRw;
    if ((topLineTest == l1)&&(alternativeTopPt == l1))
        refinedTop = alternativeTopPt;
    elseif((topLineTest == l1)&&(alternativeTopPt ~= l1))
        refinedTop = alternativeTopPt;
    elseif((alternativeTopPt == l1)&&(topLineTest ~= l1))
        refinedTop = topLineTest;
    elseif((alternativeTopPt ~= l1)&&(topLineTest ~= l1))
        cnt1 = length(find(ImgRef(alternativeTopPt,:))); % counting number of pixels present in alternativeTopPt row in binary image
        cnt2 = length(find(ImgRef(topLineTest,:)));% counting number of pixels present in topLineTest row in binary image
        if(cnt2 >= cnt1)
            refinedTop = alternativeTopPt;% alternativeTopPt th row is having minimum foreground pixels
        elseif(cnt2 < cnt1)
            refinedTop = topLineTest;% topLineTest th row is having minimum foreground pixels
        end
    end
    
    
    if((bottomLineTest == l4)&&(alternativeBottomPt == l4))
        refinedBottom = alternativeBottomPt;
    elseif((bottomLineTest == l4)&&(alternativeBottomPt ~= l4))
        refinedBottom = alternativeBottomPt;
    elseif((alternativeBottomPt == l4)&&(bottomLineTest ~= l4))
        refinedBottom = bottomLineTest;
    elseif((alternativeBottomPt ~= l4)&&(bottomLineTest ~= l4))
        cnt1 = length(find(ImgRef(alternativeBottomPt,:))); % counting number of pixels present in alternativeBottomPt row in binary image
        cnt2 = length(find(ImgRef(bottomLineTest,:)));% counting number of pixels present in bottomLineTest row in binary image
        if(cnt2 >= cnt1)
            refinedBottom = alternativeBottomPt;% alternativeBottomPt th row is having minimum foreground pixels
        elseif(cnt2 < cnt1)
            refinedBottom = bottomLineTest;% bottomLineTest th row is having minimum foreground pixels
        end
    end
    
end
if(refinedBottom == 1)
    disp('wanna see u');
end
return;
end