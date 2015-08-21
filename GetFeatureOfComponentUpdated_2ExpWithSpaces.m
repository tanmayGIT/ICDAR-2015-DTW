% Here foreground pixel is denoted by 1 and background pixel is denoted by 0
function [refinedStorFearureMat,lukUpTableForRealIndex] = GetFeatureOfComponentUpdated_2ExpWithSpaces(componentImg,fullImg)
[nRows,nCols] = size(componentImg);

storFeatureMat = zeros(nCols,14);
storTopIndex = zeros(nCols,3);
storBottomIndex = zeros(nCols,3);

storForeGroundCGforCol = zeros(nCols,2);
if(~isempty(componentImg))
    colIndexStorer = zeros(nCols,1);
    foreGroundColCnt = 0;
    for getCol = 1:1:nCols
        calTransition = 0;
        nEdgePixels = 0;
        pixelFlag = 0;
        sumEdgePixels = zeros(nRows,1);
        storRwColOfEdgePixels = zeros(nRows,2);
        for getRwPixels = 1:1:nRows % starting from minimum row to maximum row, sum all pixels in between them
            if((componentImg(getRwPixels,getCol)) == 1)
                if(pixelFlag == 0)
                    storTopIndex(getCol,1) = (getRwPixels); % storing the row
                    storTopIndex(getCol,2) = (getCol); % storing the col
                    storTopIndex(getCol,3) = (getRwPixels-1)^2; % as it is on the same col, so cols are not participated in disance calculation
                    pixelFlag = 1;
                elseif(pixelFlag == 1)
                    storBottomIndex(getCol,1) = (getRwPixels); % storing the row
                    storBottomIndex(getCol,2) = (getCol); % storing the col
                    storBottomIndex(getCol,3) = (getRwPixels-nRows)^2; % calculation of distance
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
            storBottomIndex(getCol,1) = storTopIndex(getCol,1);
            storBottomIndex(getCol,2) = storTopIndex(getCol,2);
            storBottomIndex(getCol,3) = (getRwPixels-nRows)^2;
        end
        if(nEdgePixels > 0)
            storRwColOfEdgePixels = storRwColOfEdgePixels(1:(nEdgePixels),:);
            cgOfRw = (sum(storRwColOfEdgePixels(:,1))) /(size(storRwColOfEdgePixels,1));
            cgOfCol = storRwColOfEdgePixels(1,2);
            
            foreGroundColCnt = foreGroundColCnt +1;
            storForeGroundCGforCol(foreGroundColCnt,1) = round(cgOfRw);
            storForeGroundCGforCol(foreGroundColCnt,2) = round(cgOfCol);
            storFeatureMat(getCol,1) = sum(sumEdgePixels)/nRows;
            storFeatureMat(getCol,2) = 0;
            storFeatureMat(getCol,3) = nEdgePixels/nRows;
            storFeatureMat(getCol,6) = calTransition / 10;
            storFeatureMat(getCol,7) = cgOfRw;  
        end
        
        pixelsStat = (fullImg(:, getCol));
        nEle = length(pixelsStat);
        allRows = 1:nEle;
        denomForNormalization = sum(int32(allRows));
        colIndexStorer(getCol,1) = getCol;
        
        %             FFT = zeros((length(pixelsStat)),1);
        %             for calDft = 1:1:(length(pixelsStat))
        %                 ed = double(pixelsStat(calDft,1));
        %                 FFT(calDft,1) = ed * (exp((-2*1i*pi*calDft)/(length(pixelsStat))));
        %             end
        
        storFeatureMat(getCol,8) = (std(double(pixelsStat)))/nRows;
        storFeatureMat(getCol,9) = (skewness(double(pixelsStat)))/nRows;
        storFeatureMat(getCol,10) = (kurtosis(double(pixelsStat)))/nRows;
        [moo,mo1,n_pq] = cent_moment(0,2,fullImg(:, getCol)); % Calling the function for caluculating moments
        
        sumEdgeVal_1stOrder = moo;
        sumEdgeVal_2ndOrder = mo1;
        storFeatureMat(getCol,11) = double( sumEdgeVal_1stOrder/denomForNormalization);        
    end
    
    storForeGroundCGforCol = storForeGroundCGforCol(1:foreGroundColCnt,:);
    for ii = 1:1:foreGroundColCnt    
        if(ii > 1)
            if(((componentImg((storForeGroundCGforCol(ii,1)),(storForeGroundCGforCol(ii,2))) == 0) &&...
                    (componentImg((storForeGroundCGforCol(ii-1,1)),(storForeGroundCGforCol(ii-1,2))) == 1)) ||...
                    ((componentImg((storForeGroundCGforCol(ii,1)),(storForeGroundCGforCol(ii,2))) == 1) &&...
                    (componentImg((storForeGroundCGforCol(ii-1,1)),(storForeGroundCGforCol(ii-1,2))) == 0)))
                storFeatureMat((storForeGroundCGforCol(ii,1)),14) = 3; % stroing the transition of the CG of each forground pixels in the column
            else
                storFeatureMat((storForeGroundCGforCol(ii,1)),14) = 2; % if there is no transition but this col have foreground pixel
            end
        end
    end
    % feature on component Image not on full image
    storFeatureMat(:,4) = storTopIndex(:,3);% storing the upper profile; as we are calculating the
    storFeatureMat(:,4) = storFeatureMat(:,4)./(size(componentImg,1)); % for normalization dividing by height of the component                                                            
    storFeatureMat(:,5) = storBottomIndex(:,3); % storing the lower profile;as we are calculating the
    storFeatureMat(:,5) = storFeatureMat(:,5)./(size(componentImg,1));% feature on component Image not on full image

    refinedStorFearureMat = zeros(nCols,(size(storFeatureMat,2)));
    lukUpTableForRealIndex = zeros(nCols,1);
    
    for h = 1:1:nCols
        refinedStorFearureMat(h,:) = storFeatureMat(h,:);
        lukUpTableForRealIndex(h,1) = h;    
    end
    
    for h = 1:1:nCols
        for gh = 1:1:size(storFeatureMat,2)
            val = refinedStorFearureMat(h,gh);
            if(isnan(val))
                refinedStorFearureMat(h,gh) = 0;
            end
        end
    end    
end
return;
end