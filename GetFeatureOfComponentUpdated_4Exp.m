% This code is completely same as the code
% GetFeatureOfComponentUpdated_3ExpWithSpaces. Here in this code, we tried
% to make it more flexible to skip calculating features from those column,
% which has no fore ground pixels and for those columns which has some fore
% ground pixels. 
function [storFeatureMat,lukUpTableForRealIndex] = GetFeatureOfComponentUpdated_4Exp(componentImg,fullImg)

if ispc
    addpath('.\Hu');
else
    addpath('./Hu');
end


[nRows,nCols] = size(componentImg);
storFeatureMat = zeros(1,18);% zeros(nCols,5); % put the commented portion, if you want to consider all the column
storTopIndex = zeros(1,3);% zeros(nCols,3);% put the commented portion, if you want to consider all the column
storBottomIndex = zeros(1,3);% zeros(nCols,3);% put the commented portion, if you want to consider all the column
lukUpTableForRealIndex = zeros(1,1);
storForeGroundCGforCol = zeros(1,2);% zeros(nCols,2);% put the commented portion, if you want to consider all the column
if(~isempty(componentImg));
    foreGroundColCnt = 0;
    foreCnt = 1;
    for getCol = 1:1:nCols
        calTransition = 0;
        nEdgePixels = 0;
        pixelFlag = 0;
        sumEdgePixels = zeros(nRows,1);
        storRwColOfEdgePixels = zeros(nRows,2);   
        for getRwPixels = 1:1:nRows % starting from minimum row to maximum row, sum all pixels in between them
            if((componentImg(getRwPixels,getCol)) == 1)
                if(pixelFlag == 0)
                    storTopIndex(foreCnt,1) = (getRwPixels); % storing the row
                    storTopIndex(foreCnt,2) = (getCol); % storing the col
                    storTopIndex(foreCnt,3) = (getRwPixels-1)^2; % as it is on the same col, so cols are not participated in disance calculation
                    pixelFlag = 1;
                elseif(pixelFlag == 1)
                    storBottomIndex(foreCnt,1) = (getRwPixels); % storing the row
                    storBottomIndex(foreCnt,2) = (getCol); % storing the col
                    storBottomIndex(foreCnt,3) = (getRwPixels-nRows)^2; % calculation of distance
                end
                sumEdgePixels(getRwPixels,1) = (255 -  (fullImg(getRwPixels, getCol))); % for edge pixels only
                nEdgePixels = nEdgePixels + 1;
                storRwColOfEdgePixels(nEdgePixels,1) = getRwPixels;
                storRwColOfEdgePixels(nEdgePixels,2) = getCol;
            end
            
            if(getRwPixels> 1)
                if ((((componentImg((getRwPixels),(getCol))==1))&&...
                        ((componentImg(((getRwPixels)-1),(getCol))==0))))% AS WE WANT ONLY BACK GROUND TO INK TRANSITION     
                    calTransition = calTransition+1;
                end
            end
        end        
        if(nEdgePixels == 1) % If only one pixel exists in the col, then bottom pixel will also be same as top pixel
            storBottomIndex(foreCnt,1) = storTopIndex(foreCnt,1);
            storBottomIndex(foreCnt,2) = storTopIndex(foreCnt,2);
            storBottomIndex(foreCnt,3) = (getRwPixels-nRows)^2;
        end
        if(nEdgePixels > 0)
            storRwColOfEdgePixels = storRwColOfEdgePixels(1:(nEdgePixels),:);
            cgOfRw = (sum(storRwColOfEdgePixels(:,1))) /(size(storRwColOfEdgePixels,1));
            cgOfCol = storRwColOfEdgePixels(1,2);
            
            foreGroundColCnt = foreGroundColCnt +1;
            storForeGroundCGforCol(foreGroundColCnt,1) = round(cgOfRw);
            storForeGroundCGforCol(foreGroundColCnt,2) = round(cgOfCol);
            
            % Binary level features
            storFeatureMat(foreCnt,1) = sum(sumEdgePixels)/nRows; % only grey feature
            storFeatureMat(foreCnt,2) = nEdgePixels/nRows; % projection profile 
            storFeatureMat(foreCnt,3) = storTopIndex(foreCnt,3)/(size(componentImg,1));% storing the upper profile; as we are calculating the
            storFeatureMat(foreCnt,4) = storBottomIndex(foreCnt,3)/(size(componentImg,1)); % storing the lower profile;as we are calculating the
            storFeatureMat(foreCnt,5) = ( storBottomIndex(foreCnt,3) - storTopIndex(foreCnt,3) )/(size(componentImg,1));
            storFeatureMat(foreCnt,6) = calTransition / 10;
            storFeatureMat(foreCnt,7) = cgOfRw/nRows; 
            storFeatureMat(foreCnt,8) = (std(double(storRwColOfEdgePixels(:,1))))/nRows;
            storFeatureMat(foreCnt,9) = (skewness(double(storRwColOfEdgePixels(:,1))))/nRows;
            storFeatureMat(foreCnt,10) = (kurtosis(double(storRwColOfEdgePixels(:,1))))/nRows;
            storFeatureMat(foreCnt,11) = (var(double(storRwColOfEdgePixels(:,1))))/nRows;
            binCol = componentImg(:,foreCnt);
            momHU = humoments(binCol);
            storFeatureMat(foreCnt,12:18) = momHU(1,:)';
            lukUpTableForRealIndex(foreCnt,1) = getCol; 
            foreCnt = foreCnt +1;
        end
    end
    
%     storForeGroundCGforCol = storForeGroundCGforCol(1:foreGroundColCnt,:);
%     for ii = 1:1:foreGroundColCnt    
%         if(ii > 1)
%             if(((componentImg((storForeGroundCGforCol(ii,1)),(storForeGroundCGforCol(ii,2))) == 0) &&...
%                     (componentImg((storForeGroundCGforCol(ii-1,1)),(storForeGroundCGforCol(ii-1,2))) == 1)) ||...
%                     ((componentImg((storForeGroundCGforCol(ii,1)),(storForeGroundCGforCol(ii,2))) == 1) &&...
%                     (componentImg((storForeGroundCGforCol(ii-1,1)),(storForeGroundCGforCol(ii-1,2))) == 0)))
%                 storFeatureMat((storForeGroundCGforCol(ii,2)),19) = 3; % stroing the transition of the CG of each forground pixels in the column
%             else
%                 storFeatureMat((storForeGroundCGforCol(ii,2)),19) = 2; % if there is no transition but this col have foreground pixel
%             end
%         end
%     end
    
%     % For spline interpolation 
%     non0Rw = find(storFeatureMat(:,1)); % find which columns are non zeros
%     Xinter = non0Rw; % non zero column indexes
%     for pii = 1:1:5
%         Yinter = storFeatureMat(non0Rw,pii);
%         Xreq = setdiff(1:nCols,Xinter);
%         Yereq = interp1(Xinter,Yinter,Xreq,'nearest');
%         storFeatureMat(Xreq,pii) = Yereq;
%     end
%     
%     refinedStorFearureMat = zeros(nCols,(size(storFeatureMat,2)));
    
%     
%     for h = 1:1:nCols
%         refinedStorFearureMat(h,:) = storFeatureMat(h,:);
%         lukUpTableForRealIndex(h,1) = h;    
%     end
  % removing the NAN values by 0  
    for h = 1:1:size(storFeatureMat,1)
        for gh = 1:1:size(storFeatureMat,2)
            val = storFeatureMat(h,gh);
            if(isnan(val))
                storFeatureMat(h,gh) = 0;
            end
        end
    end    
end
return;
end