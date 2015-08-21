clear all;
close all;
clc;

% Vary the range of alfa
vertical{1,1} = 'DTWICDAR';

horizontal{1,1} = 'DDTWICDAR';

allGT = load('completeGT.mat');
allGT = allGT.saveAllGT;

storResultForAllCombi = cell(length(vertical),length(horizontal));
for ver = 1:1:length(vertical)
    algo_ver = vertical{ver};
    dist_1 = load([algo_ver,'.mat']);
    dist_1 = dist_1.allResult;
    for hor = 1:1:length(horizontal)
        algo_hori = horizontal{hor};
        if(~strcmp(algo_ver,algo_hori)) % if two algo are not same
            
            dist_2 = load([algo_hori,'.mat']);
            dist_2 = dist_2.allResult;
            
            alfa = 0:0.01:1;
            
            keepAllPR = cell(length(dist_1),1);
            parfor ii = 1:length(dist_1) % for each query
                GtArray = allGT{ii,2};
                GtArray_backing = Inf(1,1);
                len_dist1 = size( (dist_1{ii,1}{1,5}),1 );
                len_dist2 = size( (dist_2{ii,1}{1,5}),1 );
                if(len_dist1 == len_dist2)
                    keepAllTempDist = Inf(len_dist1,length(alfa));
                    keepAllTempNames = cell(len_dist1,length(alfa));
                    % Arrange them
                    [~,sortRealIndex_1]= sort((dist_1{ii,1}{1,5}(:,2)));
                    sortedDistTemp1 = dist_1{ii,1}{1,5}(sortRealIndex_1,1);
                    sortedImgNmTemp_1 = cell((size(sortRealIndex_1,1)),1);
                    for hy = 1:1:size(sortRealIndex_1,1)
                        sortedImgNmTemp_1{hy,1} = dist_1{ii,1}{1,6}{sortRealIndex_1(hy,1),1};
                    end
                    
                    [~,sortRealIndex_2]= sort((dist_2{ii,1}{1,5}(:,2)));
                    sortedDistTemp2 = dist_1{ii,1}{1,5}(sortRealIndex_2,1);
                    sortedImgNmTemp_2 = cell((size(sortRealIndex_2,1)),1);
                    for hy = 1:1:size(sortRealIndex_2,1)
                        sortedImgNmTemp_2{hy,1} = dist_2{ii,1}{1,6}{sortRealIndex_2(hy,1),1};
                    end
                    
                    for jj = 1:1:size(sortedDistTemp1,1)
                        distTemp_1 = sortedDistTemp1(jj,1);
                        imgNmTemp_1 = sortedImgNmTemp_1{jj,1};
                        
                        distTemp_2 = sortedDistTemp2(jj,1);
                        imgNmTemp_2 = sortedImgNmTemp_2{jj,1};
                        if(strcmp(imgNmTemp_1,imgNmTemp_2))
                            for kk = 1:1:length(alfa)
                                final_dist = ((alfa(kk)* distTemp_1) + ( (1-alfa(kk)) * distTemp_2)) ;
                                keepAllTempDist(jj,kk) = final_dist;
                                keepAllTempNames{jj,kk} = imgNmTemp_1;
                            end
                        else
                            error('The two images are not same image');
                        end
                    end
                    tempKeepAllPR = cell(1,length(alfa));
                    for kk = 1:1:length(alfa)
                        [sortedDist, sortedIndex] = sort(keepAllTempDist(:,kk));
                        sortedName = cell(size(sortedIndex,1),1);
                        gtcnt = 1;
                        for hy = 1:1:size(sortedIndex,1)
                            sortedName{hy,1} = keepAllTempNames{sortedIndex(hy,1),1};
                            imgName = sortedName{hy,1};
                            
                            for fdNam  = 1:1:size(GtArray,2)
                                namVal = GtArray{1,fdNam};
                                if (strcmp( namVal,imgName ) )
                                    GtArray {2,fdNam} = hy;
                                    GtArray_backing(1,gtcnt) = hy;
                                    gtcnt = gtcnt +1;
                                    GTmatchFlag = 1;
                                    break;
                                end
                            end
                        end
                        
                        % calculate PR values
                        % for generating the textfile with the values of precision and recall
                        
                        resultArr = cell((max(GtArray_backing(1,:))),3);
                        for genPR = 1:1:max(GtArray_backing(1,:))
                            noRelevantWords = find((GtArray_backing(1,:)) <= genPR);
                            calP = (length(noRelevantWords)) / genPR ;
                            calR = (length(noRelevantWords)) / size(GtArray,2);
                            fMeasure = (2*calP*calR)/(calP+calR);
                            
                            resultArr{genPR,1} = calP;
                            resultArr{genPR,2} = calR;
                            resultArr{genPR,3} = fMeasure;
                        end
                        resultArr{1,4} = GtArray;
                        tempKeepAllPR{1,kk} = resultArr;
                    end
                    keepAllPR{ii,1} = tempKeepAllPR;
                else
                    error('Number of target elements are not same for both the algorithms');
                end
            end
            % save('completePRLists.mat','keepAllPR');
            % load('completePRLists.mat');
            alfa = 0:0.01:1;
            arrangeItInFormat = cell(1,1);
            for hy = 1:1:size(keepAllPR,1) % for each query images
                for yh = 1:1: size((keepAllPR{hy,1}),2) % for each alfa
                    arrangeItInFormat{hy,yh} = keepAllPR{hy,1}{1,yh};
                end
            end
            storFinalPRForAlfa = Inf(length(alfa),2);
            for tu = 1:1:size(arrangeItInFormat,2) % for each alfa
                formatttedPRForFunc = cell(1,1);
                for gu = 1:1:size(arrangeItInFormat,1) % for each query images
                    formatttedPRForFunc{gu,1} = arrangeItInFormat{gu,tu};
                end
                [allAccuracyArr,mytotarr] = cellToArrForPlot(formatttedPRForFunc);
                mean_avg_pre = meanAveragePrecision(allAccuracyArr);
                storFinalPRForAlfa(tu,1) = mean_avg_pre;
                storFinalPRForAlfa(tu,2) = alfa(tu);
            end
            storResultForAllCombi{ver,hor}{1,1} = [algo_ver,'+',algo_hori];
            storResultForAllCombi{ver,hor}{1,2} = storFinalPRForAlfa;
            clearvars storFinalPRForAlfa keepAllPR keepAllTempDist keepAllTempNames;
            clearvars arrangeItInFormat dist_2 allAccuracyArr formatttedPRForFunc mytotarr         
        end
    end
    clear dist_1
    disp(ver);
end
save('storResultForAllCombi.mat');
disp('Dekh Amake');