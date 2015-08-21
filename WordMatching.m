function allAccuracyArr = WordMatching(option,dataset,featureFunc,nomalizeFunc,heightMatter,technique,percent)
switch (option)
    case 'generateFeatureMatICDARCompetetion'
        addpath('./RGMesquita_CABMello/IRACE+POD_H src/POD_H');
%         dirOutputSourceImgFolders = '.\ICDAR_2015_Competetion\Valdation\Validation_SegmentedWord_Images\';
        dirOutputSourceImgFolders = './allCroppedImgOriginal/grey/';
        filesInFolder = dir(fullfile(dirOutputSourceImgFolders, '*.tif'));
        fileNamesInFolder = {filesInFolder.name}';
        keepAllFeature = generateFeaturematICDAR(dirOutputSourceImgFolders,fileNamesInFolder,nomalizeFunc,featureFunc,heightMatter);
        varName = ['ACPR' '_' featureFunc '_' heightMatter '_' nomalizeFunc];
        disp(varName);
        save(varName,'keepAllFeature');
        
        % Generating the feature mat for the new dataset
    case 'generateFeatureMat'
        % Select the folder containing the reference images
        dirOutput = './RefSet_1/';
        if(strcmp(dataset,'CSER'))
            files = dir(fullfile(dirOutput, '*.jpg'));
        end
        fileNamesRef = {files.name}';
        imgPathRef = strcat(dirOutput,'/');
        nImagesRef = (length(fileNamesRef));
        
        if(strcmp(dataset,'CSER'))
            % The directory containing the folders which is having the full images
            dirOutputSourceImgFolders = './componentImg_1';
            filesSource = dir(dirOutputSourceImgFolders);
            isDir = [filesSource.isdir];
            dirNames = {filesSource(isDir).name};
        end
        
        for goEachRefImg = 1:1:nImagesRef
            imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
            [~, refName, ~] = fileparts(imageFilePathRef);
            
            entered = 0;
            if(strcmp(dataset,'CSER'))
                for matchImgDir = 1:1:(size(dirNames,2))
                    myFolder = dirNames{1,matchImgDir}; % getting all the folders in the particular directory
                    if(strcmp(refName,myFolder)) % if there are any folder matched with reference name
                        entered = 1;
                        eachFolderPath = [dirOutputSourceImgFolders '/' myFolder '/'];
                        filesInFolder = dir(fullfile(eachFolderPath, '*.jpg'));
                        fileNamesInFolder = {filesInFolder.name}';
                        break;
                    end
                end
                if(entered == 1)
                    disp(refName);
                    keepAllFeature = generateFeaturemat(eachFolderPath,fileNamesInFolder,nomalizeFunc,featureFunc,heightMatter);
                    varName = [refName '_' featureFunc '_' heightMatter '_' nomalizeFunc];
                    disp(varName);
                    save(varName,'keepAllFeature');
                end
            end
        end
        % Generating the feature mat for the new dataset
    case 'generateFeatureMatNewDataset'
        % Select the folder containing the reference images
        refImag{1,1} = 'cheualier';
        refImag{1,2} = 'cheual';
        refImag{1,3} = 'cheualerie';
        refImag{1,4} = 'cheualier';
        refImag{1,5} = 'cheuallier';
        refImag{1,6} = 'cheuaus';
        refImag{1,7} = 'cheuaux';
        
        refImag{2,1} = 'victoire';
        refImag{2,2} = 'victo';
        refImag{2,3} = 'victoi';
        refImag{2,4} = 'victoire';
        refImag{2,5} = 'victorieus';
        refImag{2,6} = 'victorieux';
        
        refImag{3,1} = 'mortel';
        refImag{3,2} = 'immortales';
        refImag{3,3} = 'immortali';
        refImag{3,4} = 'immortalit';
        refImag{3,5} = 'immortel';
        refImag{3,6} = 'immortelle';
        refImag{3,7} = 'immortels';
        refImag{3,8} = 'mort';
        refImag{3,9} = 'mortale';
        refImag{3,10} = 'mortales';
        refImag{3,11} = 'mortalia';
        refImag{3,12} = 'mortalibus';
        refImag{3,13} = 'mortalite';
        refImag{3,14} = 'morte';
        refImag{3,15} = 'mortelle';
        refImag{3,16} = 'mortelles';
        refImag{3,17} = 'mortels';
        refImag{3,18} = 'mortem';
        refImag{3,19} = 'mortes';
        refImag{3,20} = 'morgue';
        refImag{3,21} = 'morti';
        refImag{3,22} = 'mortis';
        refImag{3,23} = 'morts';
        refImag{3,24} = 'mortua';
        refImag{3,25} = 'mortuum';
        refImag{3,26} = 'mortuus';
        refImag{3,27} = 'mortz';
        
        refImag{4,1} = 'liberte';
        refImag{4,2} = 'libre';
        refImag{4,3} = 'librement';
        
        refImag{5,1} =  'roy';
        refImag{5,2} = 'royales';
        refImag{5,3} = 'royau';
        refImag{5,4} = 'royaume';
        refImag{5,5} = 'royaumes';
        refImag{5,6} = 'royaus';
        refImag{5,7} = 'royaute';
        refImag{5,8} = 'royaux';
        refImag{5,9} = 'royne';
        refImag{5,10} = 'roys';
        refImag{5,11} = 'rois';
        refImag{5,12} = 'roistre';
        refImag{5,13} = 'roit';
        
        refImag{6,1} = 'despouil';
        refImag{6,2} = 'despouille';
        refImag{6,3} = 'despouiller';
        refImag{6,4} = 'despouillera';
        refImag{6,5} = 'depouille';
        refImag{6,6} = 'depouiller';
        
        refImag{7,1} = 'reconneut';
        refImag{7,2} = 'reconnoi';
        refImag{7,3} = 'reconnoissable';
        refImag{7,4} = 'reconnoissance';
        refImag{7,5} = 'reconnoissant';
        refImag{7,6} = 'reconnoissent';
        refImag{7,7} = 'reconnoissoient';
        refImag{7,8} = 'reconnoissoit';
        refImag{7,9} = 'reconnoissons';
        refImag{7,10} = 'reconnoistre';
        refImag{7,11} = 'reconnoit';
        refImag{7,12} = 'reconnoitre';
        refImag{7,13} = 'reconnoy';
        refImag{7,14} = 'reconnu';
        refImag{7,15} = 'reconnue';
        
        
        refImag{8,1} = 'reconoissent';
        refImag{8,2} = 'reconoissoit';
        refImag{8,3} = 'reconoitre';
        refImag{8,4} = 'recogneu';
        refImag{8,5} = 'recognois';
        refImag{8,6} = 'recognoissan';
        refImag{8,7} = 'recognoissance';
        refImag{8,8} = 'recognoissant';
        refImag{8,9} = 'recognoisse';
        refImag{8,10} = 'recognoissons';
        refImag{8,11} = 'recognoistre';
        refImag{8,12} = 'recognoit';
        refImag{8,13} = 'recognoitre';
        refImag{8,14} = 'recognu';
        
        
        refImag{9,1} = 'connoi';
        refImag{9,2} = 'connois';
        refImag{9,3} = 'connoissan';
        refImag{9,4} = 'connoissance';
        refImag{9,5} = 'connoissans';
        refImag{9,6} = 'connoissant';
        refImag{9,7} = 'connoisse';
        refImag{9,8} = 'connoissent';
        refImag{9,9} = 'connoissoit';
        refImag{9,10} = 'connoist';
        refImag{9,11} = 'connoistre';
        refImag{9,12} = 'connoit';
        refImag{9,13} = 'connoitre';
        refImag{9,14} = 'connoy';
        refImag{9,15} = 'connu';
        refImag{9,16} = 'connue';
        refImag{9,17} = 'connues';
        refImag{9,18} = 'connus';
        
        
        refImag{10,1} = 'cognoissons';
        refImag{10,2} = 'cognoistre';
        refImag{10,3} = 'cognoit';
        refImag{10,4} = 'cognoitre';
        refImag{10,5} = 'cognosci';
        refImag{10,6} = 'cogneu';
        refImag{10,7} = 'cogneue';
        refImag{10,8} = 'cogneut';
        refImag{10,9} = 'cognoi';
        refImag{10,10} = 'cognois';
        refImag{10,11} = 'cognoisoit';
        refImag{10,12} = 'cognoissan';
        refImag{10,13} = 'cognoissance';
        refImag{10,14} = 'cognoissances';
        refImag{10,15} = 'cognoissant';
        refImag{10,16} = 'cognoissent';
        refImag{10,17} = 'cognoissions';
        refImag{10,18} = 'cognoissoint';
        
        
        myImpRef = cell(1,2);
        myImpRefCnt = 1;
        for ui = 1:1:size(refImag,1)
            for yyu = 1:1:size(refImag,2)
                if(~isempty(refImag{ui,yyu}))
                    myImpRef{myImpRefCnt,1} = refImag{ui,yyu};
                    GtCorrsRefImgStorer = GTImgFinder(refImag{ui,yyu},featureFunc,nomalizeFunc,heightMatter);
                    myImpRef{myImpRefCnt,2} = GtCorrsRefImgStorer;
                    myImpRefCnt = myImpRefCnt +1;
                end
            end
        end
        varName = ['NewDatasetCESR' '_' featureFunc '_' heightMatter '_' nomalizeFunc];
        disp(varName);
        save(varName,'myImpRef');
        
    case 'matchOfflineNewCSER'
        % Select the folder containing the reference images
        refImag{1,1} = 'cheualier';
        refImag{1,2} = 'cheual';
        refImag{1,3} = 'cheualerie';
        refImag{1,4} = 'cheualier';
        refImag{1,5} = 'cheuallier';
        refImag{1,6} = 'cheuaus';
        refImag{1,7} = 'cheuaux';
        
        refImag{2,1} = 'victoire';
        refImag{2,2} = 'victo';
        refImag{2,3} = 'victoi';
        refImag{2,4} = 'victoire';
        refImag{2,5} = 'victorieus';
        refImag{2,6} = 'victorieux';
        
        refImag{3,1} = 'mortel';
        refImag{3,2} = 'immortales';
        refImag{3,3} = 'immortali';
        refImag{3,4} = 'immortalit';
        refImag{3,5} = 'immortel';
        refImag{3,6} = 'immortelle';
        refImag{3,7} = 'immortels';
        refImag{3,8} = 'mort';
        refImag{3,9} = 'mortale';
        refImag{3,10} = 'mortales';
        refImag{3,11} = 'mortalia';
        refImag{3,12} = 'mortalibus';
        refImag{3,13} = 'mortalite';
        refImag{3,14} = 'morte';
        refImag{3,15} = 'mortelle';
        refImag{3,16} = 'mortelles';
        refImag{3,17} = 'mortels';
        refImag{3,18} = 'mortem';
        refImag{3,19} = 'mortes';
        refImag{3,20} = 'morgue';
        refImag{3,21} = 'morti';
        refImag{3,22} = 'mortis';
        refImag{3,23} = 'morts';
        refImag{3,24} = 'mortua';
        refImag{3,25} = 'mortuum';
        refImag{3,26} = 'mortuus';
        refImag{3,27} = 'mortz';
        
        refImag{4,1} = 'liberte';
        refImag{4,2} = 'libre';
        refImag{4,3} = 'librement';
        
        
        refImag{5,1} =  'roys';
        refImag{5,2} = 'royales';
        refImag{5,3} = 'royau';
        refImag{5,4} = 'royaume';
        refImag{5,5} = 'royaumes';
        refImag{5,6} = 'royaus';
        refImag{5,7} = 'royaute';
        refImag{5,8} = 'royaux';
        refImag{5,9} = 'royne';
        refImag{5,10} = 'roy';
        refImag{5,11} = 'rois';
        refImag{5,12} = 'roistre';
        refImag{5,13} = 'roit';
        
        
        refImag{6,1} = 'depouille';
        refImag{6,2} = 'despouille';
        refImag{6,3} = 'despouiller';
        refImag{6,4} = 'despouillera';
        refImag{6,5} = 'despouil';
        refImag{6,6} = 'depouiller';
        
        refImag{7,1} = 'reconnoistre';
        refImag{7,2} = 'reconnoi';
        refImag{7,3} = 'reconnoissable';
        refImag{7,4} = 'reconnoissance';
        refImag{7,5} = 'reconnoissant';
        refImag{7,6} = 'reconnoissent';
        refImag{7,7} = 'reconnoissoient';
        refImag{7,8} = 'reconnoissoit';
        refImag{7,9} = 'reconnoissons';
        refImag{7,10} = 'reconneut';
        refImag{7,11} = 'reconnoit';
        refImag{7,12} = 'reconnoitre';
        refImag{7,13} = 'reconnoy';
        refImag{7,14} = 'reconnu';
        refImag{7,15} = 'reconnue';
        
        
        refImag{8,1} = 'recognois';
        refImag{8,2} = 'reconoissoit';
        refImag{8,3} = 'reconoitre';
        refImag{8,4} = 'recogneu';
        refImag{8,5} = 'reconoissent';
        refImag{8,6} = 'recognoissan';
        refImag{8,7} = 'recognoissance';
        refImag{8,8} = 'recognoissant';
        refImag{8,9} = 'recognoisse';
        refImag{8,10} = 'recognoissons';
        refImag{8,11} = 'recognoistre';
        refImag{8,12} = 'recognoit';
        refImag{8,13} = 'recognoitre';
        refImag{8,14} = 'recognu';
        
        
        refImag{9,1} = 'connoit';
        refImag{9,2} = 'connois';
        refImag{9,3} = 'connoissan';
        refImag{9,4} = 'connoissance';
        refImag{9,5} = 'connoissans';
        refImag{9,6} = 'connoissant';
        refImag{9,7} = 'connoisse';
        refImag{9,8} = 'connoissent';
        refImag{9,9} = 'connoissoit';
        refImag{9,10} = 'connoist';
        refImag{9,11} = 'connoistre';
        refImag{9,12} = 'connoi';
        refImag{9,13} = 'connoitre';
        refImag{9,14} = 'connoy';
        refImag{9,15} = 'connu';
        refImag{9,16} = 'connue';
        refImag{9,17} = 'connues';
        refImag{9,18} = 'connus';
        
        
        refImag{10,1} = 'cognoi';
        refImag{10,2} = 'cognoistre';
        refImag{10,3} = 'cognoit';
        refImag{10,4} = 'cognoitre';
        refImag{10,5} = 'cognosci';
        refImag{10,6} = 'cogneu';
        refImag{10,7} = 'cogneue';
        refImag{10,8} = 'cogneut';
        refImag{10,9} = 'cognoissons';
        refImag{10,10} = 'cognois';
        refImag{10,11} = 'cognoisoit';
        refImag{10,12} = 'cognoissan';
        refImag{10,13} = 'cognoissance';
        refImag{10,14} = 'cognoissances';
        refImag{10,15} = 'cognoissant';
        refImag{10,16} = 'cognoissent';
        refImag{10,17} = 'cognoissions';
        refImag{10,18} = 'cognoissoint';
        
        % same series of words but with the different keywords; here the
        % keyword use is  'royaus'
        refImag{11,1} = 'royaus';
        refImag{11,2} = 'royales';
        refImag{11,3} = 'royau';
        refImag{11,4} = 'royaume';
        refImag{11,5} = 'royaumes';
        refImag{11,6} = 'roys';
        refImag{11,7} = 'royaute';
        refImag{11,8} = 'royaux';
        refImag{11,9} = 'royne';
        refImag{11,10} = 'roy';
        refImag{11,11} = 'rois';
        refImag{11,12} = 'roistre';
        refImag{11,13} = 'roit';
        
        % Select the folder containing the reference images
        refImgSaver = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/allRefImages';
        
        load('NewDatasetCESR_columnFeature_makeDoubleHeight_Old_Normalize.mat');
        for ii = 1:1:size(refImag,1)
            for tu = 1:1:size(refImag,2)
                if(~isempty(refImag{ii,tu}))
                    refImgNm = refImag{ii,tu};
                    % now search the reference image name in all the array
                    for searchRef = 1:1:length(myImpRef)
                        tempImgNm = myImpRef{searchRef,1};
                        if(strcmp(tempImgNm,refImgNm))
                            noTotRefImgPossible = size( (myImpRef{searchRef,2}{1,2}),1 );
                            refSaveFolder  = [refImgSaver '/' refImgNm '/'];
                            if((exist(refSaveFolder,'dir'))==0)
                                mkdir(refSaveFolder);
                            end
                            for iui = 1:1:noTotRefImgPossible
                                imgPath = myImpRef{searchRef,2}{1,2}{iui,1};
                                getImg = imread(imgPath);
                                imwrite(getImg,[refSaveFolder num2str(iui) '.jpg']);
                            end
                            % select any random index
                            randIndex = randi([1, noTotRefImgPossible]);
                            imageFilePathRef = myImpRef{searchRef,2}{1,2}{randIndex,1};
                            [~, refName, ~] = fileparts(imageFilePathRef);
                            refImg = imread(imageFilePathRef);
                            break;
                        end
                    end
                end
            end
            featureSaver = cell(1,1);
            totGTSaver = cell(1,1);
            featureMatCnt = 1;
            for uuy = 1:1:size(refImag,2)
                refImgNm = refImag{ii,uuy};
                % now search the reference image name in all the array
                if(~isempty(refImag{ii,uuy}))
                    for searchRef = 1:1:length(myImpRef)
                        tempImgNm = myImpRef{searchRef,1};
                        if(strcmp(tempImgNm,refImgNm))
                            featureSaver{featureMatCnt,1} = myImpRef{searchRef,2}{1,3};
                            totGTSaver{featureMatCnt,1} = myImpRef{searchRef,2}{1,2};
                            featureMatCnt = featureMatCnt +1;
                            break;
                        end
                    end
                end
            end
            % Merging all the features in one matrix
            mergedFeatureMat = cell(1,1);
            mergedFeautureCnt = 1;
            
            mergedGTArr= cell(4,1);
            mergedGTCnt = 1;
            for io = 1:1:length(featureSaver)
                for tt = 1:1:length(featureSaver{io,1})
                    mergedFeatureMat{mergedFeautureCnt,1} = featureSaver{io,1}{tt,1};
                    mergedFeatureMat{mergedFeautureCnt,2} = featureSaver{io,1}{tt,2};
                    mergedFeatureMat{mergedFeautureCnt,3} = featureSaver{io,1}{tt,3};
                    mergedFeatureMat{mergedFeautureCnt,4} = featureSaver{io,1}{tt,4};
                    mergedFeautureCnt = mergedFeautureCnt +1;
                end
                for tk = 1:1:size(totGTSaver{io,1},1)
                    mergedGTArr{1,mergedGTCnt} = totGTSaver{io,1}{tk,1};
                    mergedGTArr{4,mergedGTCnt} = totGTSaver{io,1}{tk,2};
                    mergedGTCnt = mergedGTCnt +1;
                end
            end
            resultArr = matchFeatureOfflineForNewCSER(mergedFeatureMat,refName,refImg,technique,nomalizeFunc,featureFunc,heightMatter,mergedGTArr);
            allAccuracyArr{ii,1} =  resultArr;
        end
        
        varName = [technique '_' nomalizeFunc '_' featureFunc '_' heightMatter];
        disp(varName)
        save(varName,'allAccuracyArr');
    case 'matchOffline'
        % Select the folder containing the reference images
        if(ispc)
            dirOutput =  '.\RefSet_1';
        else
            dirOutput =  './RefSet_1';
        end
        if(strcmp(dataset,'CSER'))
            files = dir(fullfile(dirOutput, '*.jpg'));
        end
        fileNamesRef = {files.name}';
        if(ispc)
            imgPathRef = strcat(dirOutput,'\');
        else
            imgPathRef = strcat(dirOutput,'/');
        end
        nImagesRef = (length(fileNamesRef));
        
        if(strcmp(dataset,'CSER'))
            % The directory containing the folders which is having the full images
            if(ispc)
                dirOutputSourceImgFolders = '.\componentImg_1';
            else
                dirOutputSourceImgFolders = './componentImg_1';
            end
            filesSource = dir(dirOutputSourceImgFolders);
            isDir = [filesSource.isdir];
            dirNames = {filesSource(isDir).name};
        end
        allAccuracyArr = cell(1,1);
        matchNum = 1;
        %%%%%%%%***********
        for goEachRefImg = 1:1:nImagesRef
            imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
            [~, refName, ~] = fileparts(imageFilePathRef);
            refImg = imread(imageFilePathRef);
            entered = 0;
            if(strcmp(dataset,'CSER'))
                for matchImgDir = 1:1:(size(dirNames,2))
                    myFolder = dirNames{1,matchImgDir}; % getting all the folders in the particular directory
                    if(strcmp(refName,myFolder)) % if there are any folder matched with reference name
                        entered = 1;
                        if(ispc)
                            eachFolderPath = [dirOutputSourceImgFolders '\' myFolder '\'];
                        else
                            eachFolderPath = [dirOutputSourceImgFolders '/' myFolder '/'];
                        end
                        filesInFolder = dir(fullfile(eachFolderPath, '*.jpg'));
                        fileNamesInFolder = {filesInFolder.name}';
                        break;
                    end
                end
                if(entered == 1)
                    resultArr = matchFeatureOffline(fileNamesInFolder,refName,refImg,technique,nomalizeFunc,featureFunc,heightMatter,percent);
                    % resultArr = matchFeatureOfflineWithNewGT(fileNamesInFolder,refName,refImg,technique,nomalizeFunc,featureFunc,heightMatter);
                    disp(refName);
                    allAccuracyArr{goEachRefImg,1} =  resultArr;
                    matchNum  = matchNum +1;
                    save([refName,'OSBSmall'],'resultArr');
                end
            end
        end
        varName = [technique '_' nomalizeFunc '_' featureFunc '_' heightMatter];
        disp(varName)
        save(varName,'allAccuracyArr');
        return;
    case 'segregateGT'
        % Select the folder containing the reference images
        dirOutput =  '/Users/tanmoymondal/Documents/Study Guru/STUDY GURU/Dataset/reference Img/Ref Img_CSER/RefSet_1/';
        if(strcmp(dataset,'CSER'))
            files = dir(fullfile(dirOutput, '*.jpg'));
        elseif(strcmp(dataset,'GW'))
            files = dir(fullfile(dirOutput, '*.tif'));
        end
        fileNamesRef = {files.name}';
        imgPathRef = strcat(dirOutput,'/');
        nImagesRef = (length(fileNamesRef));
        
        if(strcmp(dataset,'CSER'))
            % The directory containing the folders which is having the full images
            dirOutputSourceImgFolders = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/ClusteredComponentImg/componentImg_1';
            gtSavingPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/ClusteredComponentImg/GT_Images/';
            filesSource = dir(dirOutputSourceImgFolders);
            isDir = [filesSource.isdir];
            dirNames = {filesSource(isDir).name};
        end
        for goEachRefImg = 1:1:nImagesRef
            imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
            [~, refName, ~] = fileparts(imageFilePathRef);
            refImg = imread(imageFilePathRef);
            entered = 0;
            if(strcmp(dataset,'CSER'))
                for matchImgDir = 1:1:(size(dirNames,2))
                    myFolder = dirNames{1,matchImgDir}; % getting all the folders in the particular directory
                    if(strcmp(refName,myFolder)) % if there are any folder matched with reference name
                        entered = 1;
                        eachFolderPath = [dirOutputSourceImgFolders '/' myFolder '/'];
                        filesInFolder = dir(fullfile(eachFolderPath, '*.jpg'));
                        fileNamesInFolder = {filesInFolder.name}';
                        break;
                    end
                end
                if(entered == 1)
                    GtArray = getGT_1(refName);
                    seperateFol = [gtSavingPath refName '/'];
                    if((exist(seperateFol,'dir'))==0)
                        mkdir(seperateFol);
                    end
                    for ii = 1:1:length(GtArray)
                        gtImgNm = GtArray(1,ii);
                        imgPath = [eachFolderPath num2str(gtImgNm) '.jpg'];
                        img = imread(imgPath);
                        
                        imwrite(img,[seperateFol num2str(gtImgNm) '_' refName '.jpg']);
                    end
                end
            end
        end
    case 'seeTestFeatureMat'
        % Select the folder containing the reference images
        dirOutput = '/Users/tanmoymondal/Documents/Study Guru/STUDY GURU/Dataset/reference Img/Ref Img_CSER/TestRef/';
        if(strcmp(dataset,'CSER'))
            files = dir(fullfile(dirOutput, '*.jpg'));
        elseif(strcmp(dataset,'GW'))
            files = dir(fullfile(dirOutput, '*.tif'));
        end
        fileNamesRef = {files.name}';
        imgPathRef = strcat(dirOutput,'/');
        nImagesRef = (length(fileNamesRef));
        
        if(strcmp(dataset,'CSER'))
            % The directory containing the folders which is having the full images
            dirOutputSourceImgFolders = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/ClusteredComponentImg/SpecificComponent/';
            filesSource = dir(dirOutputSourceImgFolders);
            isDir = [filesSource.isdir];
            dirNames = {filesSource(isDir).name};
        elseif (strcmp(dataset,'GW'))
            
            dirOutputSourceImgFolders = uigetdir('/Users/tanmoymondal/Documents/Parallel Word Spotting 1.1/Parallel Word Spotting/BatchProcessing/Space Seperated/By MVM/Offline Component Analysis/washington_good_set/','Select a folder');
            filesSource = dir(fullfile(dirOutputSourceImgFolders, '*.tif'));
            fileNames = {filesSource.name}';
            fileNamesInFolder = fileNames;
            eachFolderPath = dirOutputSourceImgFolders;
        end
        
        for goEachRefImg = 1:1:nImagesRef
            imageFilePathRef = [imgPathRef,fileNamesRef{goEachRefImg}];
            [~, refName, ~] = fileparts(imageFilePathRef);
            refImg = imread(imageFilePathRef);
            entered = 0;
            if(strcmp(dataset,'CSER'))
                entered = 1;
                %                 for matchImgDir = 1:1:(size(dirNames,2))
                %                     myFolder = dirNames{1,matchImgDir}; % getting all the folders in the particular directory
                %                     if(strcmp(refName,myFolder)) % if there are any folder matched with reference name
                entered = 1;
                eachFolderPath = [dirOutputSourceImgFolders];
                filesInFolder = dir(fullfile(eachFolderPath, '*.jpg'));
                fileNamesInFolder = {filesInFolder.name}';
                %                         break;
                %                     end
                %                 end
                %                 varName = [technique '_' matchingFunc];
                if(entered == 1)
                    disp(refName);
                    technique = 'MVM_Updated_14';
                    keepAllFeature = generateFeaturemat(eachFolderPath,fileNamesInFolder,nomalizeFunc,featureFunc,heightMatter);
                    matchFeatureOfflineTestSmall(fileNamesInFolder,refName,refImg,technique,nomalizeFunc,featureFunc,heightMatter,keepAllFeature);
                    %                     varName = [refName '_' featureFunc '_' heightMatter '_' nomalizeFunc '_' 'allImages'];
                    %                     varName = [refName '_' featureFunc '_' heightMatter '_' nomalizeFunc];
                    %                     disp(varName);
                    %                     save(varName,'keepAllFeature');
                end
                
            end
            
        end
end
