function [GtCorrsRefImgStorer] = GTImgFinder(refImgNm,featureFunc,nomalizeFunc,heightMatter)
dirOutput = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
refImag{1,1} = refImgNm;
disp(refImgNm);
GtCorrsRefImgStorer = cell(length(refImag),3);
for refCnt = 1:1:length(refImag)
    refGtPath = [dirOutput refImag{1,refCnt}];
    refFolPath =[dirOutput refImag{1,refCnt} '/' 'AllComponentImagesGrey/'];
    
    if(~exist(refFolPath,'dir'))
        error('this directory does not exist, correct the reference image name please');
    end
    
    
    filesInFolder = dir(fullfile(refFolPath, '*.jpg'));
    fileNamesInFolder = {filesInFolder.name}';
    
    refinedImgNm = cell(length(fileNamesInFolder),2);
    keepAllFeature = generateFeaturemat(refFolPath,fileNamesInFolder,nomalizeFunc,featureFunc,heightMatter);
    for i = 1:1:length(fileNamesInFolder)
        [~,name,~] = fileparts(filesInFolder(i,1).name) ;
        imgNm = [];
        folderNm = [];
        iGotFlg = 0;
        folderNmFlag = 0;
        for chr = 1:1:length(name)
            if(name(1,chr) == '-')
                iGotFlg = 1;
                continue;
            elseif(name(1,chr) == '#')
                folderNmFlag = 1;
            end
            if(iGotFlg == 1)
                imgNm = [imgNm,name(1,chr)];
            end
        end
        
        refinedImgNm{i,1} = imgNm;
        refinedImgNm{i,2} = name;
    end
    GtFilePath = [refGtPath '/' 'GTCopy_Value.txt'];
    if exist(GtFilePath, 'file') == 2 % then the file exists
        disp(' ');
    else
        GtFilePath = [refGtPath '/' 'GT_Value.txt'];
    end
    fid = fopen(GtFilePath,'rt'); % opening the file in read mode
    if fid < 0, error('Cannot open file'); end
    tLine = fgets(fid);
    
    GTImgStorer = cell(1,1);
    GTStorCnt = 1;
    while (ischar(tLine))
        imgNumArr = cell(1,1);
        txtImgNm = [];
        imgNumbe = [];
        txtFlag = 0;
        iAmEndFlag = 0;
        numTakenFlag = 0;
        tk = 1;
        for ii = 1:1:length(tLine)-1 % the last element is the space
            if(tLine(1,ii) == '|')
                txtFlag = 1;
                iAmEndFlag = 1;
                if(numTakenFlag == 1) % it means, we have already encountered the first |
                    imgNumArr{tk,1} = (imgNumbe); % put the earlier number in the array
                    imgNumbe = [];
                    tk = tk +1;
                end
                continue;
            end
            if( (txtFlag == 0) && (iAmEndFlag == 0) )
                txtImgNm = [txtImgNm,tLine(1,ii)];
            elseif(txtFlag == 1) % i got the first |
%                 if(checkIsNumeric(tLine(1,ii))) % if the character is a numeric value
                    imgNumbe = [imgNumbe,tLine(1,ii)];
                    numTakenFlag = 1;
%                 end       
            end
        end
        imgNumArr{tk,1} = (imgNumbe);
        % Seperate the character from the string of numbers
        for tyu = 1:1:size(imgNumArr,1)
            imgNumbe = [];
            myChar = [];
            for hh = 1:1:length(imgNumArr{tyu,1})
                 if(checkIsNumeric(imgNumArr{tyu,1}(1,hh))) % if the character is a numeric value
                     imgNumbe = [imgNumbe,imgNumArr{tyu,1}(1,hh)];
                 else
                     myChar = imgNumArr{tyu,1}(1,hh);
                 end
            end
            imgNumArr{tyu,1} = str2num(imgNumbe);
            if(~isempty(myChar))
              imgNumArr{tyu,2} = myChar;  
            else
                imgNumArr{tyu,2} = -5; % it means there is no character in the string
            end
        end
        for uu = 1:1:size(imgNumArr,1)
            myImgNm = [num2str(imgNumArr{uu,1}), '_',txtImgNm];
            
            for chkImg = 1:1:length(refinedImgNm)
                if(strcmp(myImgNm,refinedImgNm{chkImg,1}))
                    % myImg = imread([refFolPath refinedImgNm{chkImg,2} '.jpg']);
                    GTImgStorer{GTStorCnt,1} = [refFolPath refinedImgNm{chkImg,2} '.jpg'];
                    GTImgStorer{GTStorCnt,2} = imgNumArr{uu,2};
                    GTStorCnt = GTStorCnt +1;
                    break;
                end
            end
        end
        tLine = fgets(fid);
    end
    GtCorrsRefImgStorer{refCnt,1} = refImag{1,refCnt};
    GtCorrsRefImgStorer{refCnt,2} = GTImgStorer;
    GtCorrsRefImgStorer{refCnt,3} = keepAllFeature;
end
return;
end