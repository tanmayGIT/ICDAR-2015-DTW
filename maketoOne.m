% close all;
% clear all;
% clc;
%
% comImgFolder = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_2/';
% imgSavingPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Original_Images/';
% allFolders = dir(comImgFolder);
% isub = [allFolders(:).isdir];
% nameFolds = {allFolders(isub).name}';
% for i = 3:1:length(nameFolds)
%     parFolderNm = nameFolds{i,1};
%     folderPath = [comImgFolder parFolderNm '/'];
%     filesInFolder = dir(fullfile(folderPath, '*.jpg'));
%     fileNamesInFolder = {filesInFolder.name}';
%     for k = 1:1:length(fileNamesInFolder)
%         imgPath = [folderPath fileNamesInFolder{k,1}];
%         img = imread(imgPath);
%         [~,name,~] = fileparts(fileNamesInFolder{k,1}) ;
%         savingPath = [imgSavingPath name '#' parFolderNm '.jpg'];
%         imwrite(img,savingPath);
%     end
% end








% close all;
% clear all;
% clc;
%
% comImgFolder = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary/';
% imgSavingPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_1/';
% realSavPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_2/';
% filesInFolder = dir(fullfile(imgSavingPath, '*.tif'));
% fileNamesInFolder = {filesInFolder(~[filesInFolder.isdir]).name};
% for i = 1:1:length(fileNamesInFolder)
%
%     [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%     imgPath = [imgSavingPath filesInFolder(i,1).name];
%     img = imread(imgPath);
%
%     filesInFolder1 = dir(fullfile(comImgFolder, '*.tif'));
%     fileNamesInFolder1 = {filesInFolder1.name}';
%     myFlag = 0;
%
%     imgNm = [];
%     folderNm = [];
%     iGotFlg = 0;
%
%     for chr = 1:1:length(name)
%         if(name(1,chr) == '#')
%             iGotFlg = 1;
%         else
%             if(iGotFlg == 0)
%                 imgNm = [imgNm,name(1,chr)];
%             elseif(iGotFlg == 1)
%                 folderNm = [folderNm,name(1,chr)];
%             end
%         end
%     end
%
%     for k = 1:1:length(fileNamesInFolder1)
%         [~,name1,~] = fileparts(filesInFolder1(k,1).name);
%         imgNm1 = [];
%         folderNm1 = [];
%         iGotFlg1 = 0;
%
%         for chr1 = 1:1:length(name1)
%             if(name1(1,chr1) == '#')
%                 iGotFlg1 = 1;
%             else
%                 if(iGotFlg1 == 0)
%                     imgNm1 = [imgNm1,name1(1,chr1)];
%                 elseif(iGotFlg == 1)
%                     folderNm1 = [folderNm1,name1(1,chr1)];
%                 end
%             end
%         end
%         if(strcmp(imgNm1,imgNm))
%             myFlag = 1;
%             break;
%         end
%     end
%     if(myFlag == 1)
%         savingPath = [realSavPath 'getMatched/' name '.jpg'];
%         imgPath = [comImgFolder imgNm1 '#' folderNm1 '.tif'];
%         img = imread(imgPath);
%         imwrite(img,savingPath);
%     else
%         savingPath = [realSavPath 'notMatched/' name '.jpg'];
%         imwrite(img,savingPath);
%     end
% end









% close all;
% clear all;
% clc;
%
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% imgSavingPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_3/';
%
% filesInFolder = dir(fullfile(imgSavingPath, '*.jpg'));
% fileNamesInFolder = {filesInFolder(~[filesInFolder.isdir]).name};
% for i = 1:1:length(fileNamesInFolder)
%
%     [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%     imgPath = [imgSavingPath filesInFolder(i,1).name];
%     img = imread(imgPath);
%
%     imgNm = [];
%     folderNm = [];
%     iGotFlg = 0;
%
%     for chr = 1:1:length(name)
%         if(name(1,chr) == '#')
%             iGotFlg = 1;
%         else
%             if(iGotFlg == 0)
%                 imgNm = [imgNm,name(1,chr)];
%             elseif(iGotFlg == 1)
%                 folderNm = [folderNm,name(1,chr)];
%             end
%         end
%     end
%     componentImgSavinigPath = [componentImgSavinigPath_Full folderNm '/' filesInFolder(i,1).name];
%     if((exist([componentImgSavinigPath_Full folderNm '\'],'dir'))==0)
%         mkdir([componentImgSavinigPath_Full folderNm '\']);
%     end
%
%     imwrite(img,componentImgSavinigPath);
%
% end









% close all;
% clear all;
% clc;
%
% comImgFolder = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% imgSavingPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/SubOriginal_Images/';
% allFolders = dir(comImgFolder);
% isub = [allFolders(:).isdir];
% nameFolds = {allFolders(isub).name}';
% if((exist(imgSavingPath,'dir'))==0)
%     mkdir(imgSavingPath);
% end
% for i = 3:1:length(nameFolds)
%     parFolderNm = nameFolds{i,1};
%     folderPath = [comImgFolder parFolderNm '/'];
%     filesInFolder = dir(fullfile(folderPath, '*.jpg'));
%     fileNamesInFolder = {filesInFolder.name}';
%     for k = 1:1:length(fileNamesInFolder)
%         imgPath = [folderPath fileNamesInFolder{k,1}];
%         img = imread(imgPath);
%         [~,name,~] = fileparts(fileNamesInFolder{k,1}) ;
%
%         imgNm = [];
%         folderNm = [];
%         iGotFlg = 0;
%
%         for chr = 1:1:length(name)
%             if(name(1,chr) == '#')
%                 iGotFlg = 1;
%             else
%                 if(iGotFlg == 0)
%                     imgNm = [imgNm,name(1,chr)];
%                 elseif(iGotFlg == 1)
%                     folderNm = [folderNm,name(1,chr)];
%                 end
%             end
%         end
%         if(size(img,3)~=3)
%
%              savingPath = [imgSavingPath imgNm '#' parFolderNm '.jpg'];
% %             imwrite(img,savingPath);
%         end
%     end
% end









% close all;
% clear all;
% clc;
%
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% imgSavingPath = '/Users/tanmoymondal/Downloads/Binary_2/Binary_2/';
%
% filesInFolder = dir(fullfile(imgSavingPath, '*.tif'));
% fileNamesInFolder = {filesInFolder(~[filesInFolder.isdir]).name};
% for i = 1:1:length(fileNamesInFolder)
%
%     [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%     imgPath = [imgSavingPath filesInFolder(i,1).name];
%     img = imread(imgPath);
%
%     imgNm = [];
%     folderNm = [];
%     iGotFlg = 0;
%
%     for chr = 1:1:length(name)
%         if(name(1,chr) == '#')
%             iGotFlg = 1;
%         else
%             if(iGotFlg == 0)
%                 imgNm = [imgNm,name(1,chr)];
%             elseif(iGotFlg == 1)
%                 folderNm = [folderNm,name(1,chr)];
%             end
%         end
%     end
%     componentImgSavinigPath = [componentImgSavinigPath_Full folderNm '/' name '.jpg'];
%     if((exist([componentImgSavinigPath_Full folderNm '\'],'dir'))==0)
%         mkdir([componentImgSavinigPath_Full folderNm '\']);
%     end
%
%     imwrite(img,componentImgSavinigPath);
%
% end








% close all;
% clear all;
% clc;
%
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
%
% allFolders = dir(componentImgSavinigPath_Full);
% isub = [allFolders(:).isdir];
% nameFolds = {allFolders(isub).name}';
%
% for k = 3:1:length(nameFolds)
%     parFolderNm = nameFolds{k,1};
%     folderPath = [componentImgSavinigPath_Full parFolderNm '/' 'Grey/'];
%     filesInFolder = dir(fullfile(folderPath, '*.jpg'));
%     fileNamesInFolder = {filesInFolder.name}';
%     for i = 1:1:length(fileNamesInFolder)
%
%         [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%         imgPath = [folderPath filesInFolder(i,1).name];
%         img = imread(imgPath);
%
%         imgNm = [];
%         folderNm = [];
%         iGotFlg = 0;
%
%         for chr = 1:1:length(name)
%             if(name(1,chr) == '#')
%                 iGotFlg = 1;
%             else
%                 if(iGotFlg == 0)
%                     imgNm = [imgNm,name(1,chr)];
%                 elseif(iGotFlg == 1)
%                     folderNm = [folderNm,name(1,chr)];
%                 end
%             end
%         end
% %         componentImgSavinigPath = [componentImgSavinigPath_Full folderNm '/' 'markedBinary/'];
% %         if((exist(componentImgSavinigPath,'dir'))==0)
% %             mkdir(componentImgSavinigPath);
% %         end
% %         componentImgSavinigPath_All = [componentImgSavinigPath name '.jpg'];
% %         imwrite(img,componentImgSavinigPath_All);
%         delete([componentImgSavinigPath_Full folderNm '/' 'Grey/' name '.jpg']);
%
%     end
% end







% close all;
% clear all;
% clc;
%
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% allBinPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/allGreyImages/';
%
% allFolders = dir(componentImgSavinigPath_Full);
% isub = [allFolders(:).isdir];
% nameFolds = {allFolders(isub).name}';
%
% for k = 3:1:length(nameFolds)
%     parFolderNm = nameFolds{k,1};
%     folderPath = [componentImgSavinigPath_Full parFolderNm '/' 'markedBinary/'];
%     GTfilePath = [componentImgSavinigPath_Full parFolderNm '/' 'GT_Value.txt'];
%     filesInFolder = dir(fullfile(folderPath, '*.jpg'));
%     fileNamesInFolder = {filesInFolder.name}';
%     for i = 1:1:length(fileNamesInFolder)
%
%         [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%         imgPath = [folderPath filesInFolder(i,1).name];
%
%         imgNm = [];
%         folderNm = [];
%         iGotFlg = 0;
%
%         for chr = 1:1:length(name)
%             if(name(1,chr) == '#')
%                 iGotFlg = 1;
%             else
%                 if(iGotFlg == 0)
%                     imgNm = [imgNm,name(1,chr)];
%                 elseif(iGotFlg == 1)
%                     folderNm = [folderNm,name(1,chr)];
%                 end
%             end
%         end
%         componentImgSavinigPath = [componentImgSavinigPath_Full folderNm '/' 'Grey/'];
%         if((exist(componentImgSavinigPath,'dir'))==0)
%             mkdir(componentImgSavinigPath);
%         end
%         componentImgSavinigPath_All = [allBinPath imgNm '.jpg'];
%         if exist(componentImgSavinigPath_All, 'file') == 2
%             img = imread(componentImgSavinigPath_All);
%             imwrite(img,[componentImgSavinigPath name '.jpg']);
%         else
%             error('you are not present man');
%         end
%     end
% end






% close all;
% clear all;
% clc;
%
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% componentImgSavinigPath_GT = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/allMarkedImg/';
% allBinPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/allGreyImages/';
%
% allFolders = dir(componentImgSavinigPath_Full);
% isub = [allFolders(:).isdir];
% nameFolds = {allFolders(isub).name}';
%
% for k = 3:1:length(nameFolds)
%     parFolderNm = nameFolds{k,1};
%     folderPath = [componentImgSavinigPath_Full parFolderNm '/' 'AllComponentImagesGrey/'];
%     filesInFolder = dir(fullfile(folderPath, '*.jpg'));
%     fileNamesInFolder = {filesInFolder.name}';
%
%     fileNmStorer = cell(length(fileNamesInFolder),2);
%     for i = 1:1:length(fileNamesInFolder)
%         [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%         imgPath = [folderPath filesInFolder(i,1).name];
%         imgNm = [];
%         iGotFlg = 0;
%         for chr = 1:1:length(name)
%             if(name(1,chr) == '-')
%                 iGotFlg = 1;
%                 continue;
%             end
%             if(iGotFlg == 1)
%                 imgNm = [imgNm,name(1,chr)];
%             end
%         end
%         fileNmStorer{i,1} = name;
%         fileNmStorer{i,2} = imgNm;
%     end
%
%     GTfilePath = [componentImgSavinigPath_Full parFolderNm '/' 'GT_Value.txt'];
%     fid = fopen(GTfilePath,'rt');
%     if fid < 0, error('Cannot open file'); end
%     fileType = fgets(fid);
%     tLine = fgets(fid);
%
%     while (ischar(tLine))
%         imgNumArr = zeros(1,1);
%         txtImgNm = [];
%         imgNumbe = [];
%         txtFlag = 0;
%         iAmEndFlag = 0;
%         numTakenFlag = 0;
%         tk = 1;
%         for ii = 1:1:length(tLine)-1 % the last element is the space
%             if(tLine(1,ii) == '|')
%                 txtFlag = 1;
%                 iAmEndFlag = 1;
%                 if(numTakenFlag == 1) % it means, we have already encountered the first |
%                     imgNumArr(tk,1) = str2num(imgNumbe); % put the earlier number in the array
%                     imgNumbe = [];
%                     tk = tk +1;
%                 end
%                 continue;
%             end
%             if( (txtFlag == 0) && (iAmEndFlag == 0) )
%                 txtImgNm = [txtImgNm,tLine(1,ii)];
%             elseif(txtFlag == 1) % i got the first |
%                 imgNumbe = [imgNumbe,tLine(1,ii)];
%                 numTakenFlag = 1;
%             end
%         end
%         imgNumArr(tk,1) = str2num(imgNumbe);
%
%         for uu = 1:1:length(imgNumArr)
%             myImgNm = [num2str(imgNumArr(uu,1)), '_',txtImgNm];
%             % Now search in all the array
%             for uh = 1:1:length(fileNamesInFolder)
%                 if(strcmp(myImgNm,fileNmStorer{uh,2}))
%                     getImgNm = fileNmStorer{uh,1};
%                     myImg = imread([folderPath,getImgNm,'.jpg']);
%                     imwrite(myImg,[componentImgSavinigPath_GT,getImgNm,'.jpg']);
%                     break;
%                 end
%             end
%         end
%         tLine = fgets(fid);
%     end
% end



% close all;
% clear all;
% clc;
% 
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% componentImgSavinigPath_GTCap = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/GTseperation/capital/';
% componentImgSavinigPath_GTItalic = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/GTseperation/italic/';
% 
% filesInFolderCap = dir(fullfile(componentImgSavinigPath_GTCap, '*.jpg'));
% fileNamesInFolderCap = {filesInFolderCap.name}';
% 
% filesInFolderItalic = dir(fullfile(componentImgSavinigPath_GTItalic, '*.jpg'));
% fileNamesInFolderItalic = {filesInFolderItalic.name}';
% 
% allFileNames = cell(1,2);
% allFileNmCnt = 1;
% for i = 1:1:length(fileNamesInFolderCap)
%     [~,name,~] = fileparts(fileNamesInFolderCap{i,1}) ;
%     allFileNames{allFileNmCnt,1} = name;
%     allFileNames{allFileNmCnt,2} = 'C';
%     allFileNmCnt = allFileNmCnt +1;
% end
% 
% 
% for i = 1:1:length(fileNamesInFolderItalic)
%     [~,name,~] = fileparts(fileNamesInFolderItalic{i,1}) ;
%     allFileNames{allFileNmCnt,1} = name;
%     allFileNames{allFileNmCnt,2} = 'I';
%     allFileNmCnt = allFileNmCnt +1;
% end
% 
% allGTStor = cell(1,1);
% gtLevCnt = 1;
% for i = 1:1:length(allFileNames)
%     name = allFileNames{i,1} ;
%     identifica = allFileNames{i,2};
%     imgNm = [];
%     folderNm = [];
%     iGotFlg = 0;
%     folderNmFlag = 0;
%     for chr = 1:1:length(name)
%         if(name(1,chr) == '-')
%             iGotFlg = 1;
%             continue;
%         elseif(name(1,chr) == '#')
%             folderNmFlag = 1;
%         end
%         if(iGotFlg == 1)
%             imgNm = [imgNm,name(1,chr)];
%         end
%         if(folderNmFlag == 1)
%             folderNm = [folderNm,name(1,chr)];
%         end
%     end
%     folderNm = folderNm(1,2:end);
%     % Check whether the folder name already exists or not; if the folder
%     % does not exists from before then we will create a new entry
%     igotUFlag = 0;
%     for yyu = 1:1:size(allGTStor,1)
%         if(strcmp(allGTStor{yyu,1},folderNm))
%             igotUFlag = yyu;
%         end
%     end
%     if(igotUFlag~= 0)
%         allGTStor{igotUFlag,end+1}{1,1} = imgNm;
%         allGTStor{igotUFlag,end}{1,2} = identifica;
%     else
%         allGTStor{gtLevCnt,1} = folderNm;
%         allGTStor{gtLevCnt,2}{1,1} = imgNm;
%         allGTStor{gtLevCnt,2}{1,2} = identifica;
%         gtLevCnt = gtLevCnt +1;
%     end
% end
% for uuo = 1:1:size(allGTStor,1)
%     tempGTArr = cell(1,1);
%     tempGTCnt = 1;
%     folderNm = allGTStor{uuo,1};
%     for yy = 1:1:size(allGTStor,2)
%         if(~isempty(allGTStor{uuo,yy}))
%             tempGTArr{1,tempGTCnt} = allGTStor{uuo,yy};
%             tempGTCnt = tempGTCnt +1;
%         end
%     end
%     [fid,fileB] = createGTFile(componentImgSavinigPath_Full,folderNm,tempGTArr);
% end








% close all;
% clear all;
% clc;
% 
% componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Binary_4/';
% componentImgSavinigPath_GT = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/GTseperation/italic/';
% 
% filesInFolder = dir(fullfile(componentImgSavinigPath_GT, '*.jpg'));
% fileNamesInFolder = {filesInFolder.name}';
% 
% for i = 1:1:length(fileNamesInFolder)
%     [~,name,~] = fileparts(filesInFolder(i,1).name) ;
%     imgNm = [];
%     folderNm = [];
%     iGotFlg = 0;
%     folderNmFlag = 0;
%     for chr = 1:1:length(name)
%         if(name(1,chr) == '-')
%             iGotFlg = 1;
%             continue;
%         elseif(name(1,chr) == '#')
%             folderNmFlag = 1;
%         end
%         if(iGotFlg == 1)
%             imgNm = [imgNm,name(1,chr)];
%         end
%         if(folderNmFlag == 1)
%             folderNm = [folderNm,name(1,chr)];
%         end
%     end
%     folderNm = folderNm(1,2:end);
%     
%     GTfilePathDy = [componentImgSavinigPath_Full folderNm '/' 'GT_Value.txt'];
%     GTfilePath = [componentImgSavinigPath_Full folderNm '/' 'GTCopy_Value.txt'];
%     GTfilePath1 = [componentImgSavinigPath_Full folderNm '/' 'GTCopy_Value.txt'];
%     fid = fopen(GTfilePath,'rt');
%     
%     fileB = fopen(GTfilePath1, 'wt');
%     if fileB < 0, error('Cannot open file'); end
%     
%     fileA = fopen(GTfilePathDy, 'rt');
%     
%     if (fid < 0)  % if GTCopy_Value.txt does not exists
%         if(fileA<0) % if GT_Value.txt does not exists also
%             error('Cannot open file');
%         else
%             fid =  fileA;
%         end
%     end
%     tLine = fgets(fid);
%     
%     while (ischar(tLine))
%         imgNumArr = zeros(1,1);
%         txtImgNm = [];
%         imgNumbe = [];
%         txtFlag = 0;
%         iAmEndFlag = 0;
%         numTakenFlag = 0;
%         tk = 1;
%         for ii = 1:1:length(tLine)-1 % the last element is the space
%             if(tLine(1,ii) == '|')
%                 txtFlag = 1;
%                 iAmEndFlag = 1;
%                 if(numTakenFlag == 1) % it means, we have already encountered the first |
%                     imgNumArr(tk,1) = str2num(imgNumbe); % put the earlier number in the array
%                     imgNumbe = [];
%                     tk = tk +1;
%                 end
%                 continue;
%             end
%             if( (txtFlag == 0) && (iAmEndFlag == 0) )
%                 txtImgNm = [txtImgNm,tLine(1,ii)];
%             elseif(txtFlag == 1) % i got the first |
%                 if(checkIsNumeric(tLine(1,ii))) % if the character is a numeric value
%                     imgNumbe = [imgNumbe,tLine(1,ii)];
%                     numTakenFlag = 1;
%                 end
%             end
%         end
%         imgNumArr(tk,1) = str2num(imgNumbe);
%         
%         fprintf(fileB, txtImgNm);
%         for uu = 1:1:length(imgNumArr)
%             myImgNm = [num2str(imgNumArr(uu,1)), '_',txtImgNm];
%             % Now search in all the array
%             if(strcmp(myImgNm,imgNm))
%                 fprintf(fileB, '|I');
%                 fprintf(fileB, num2str(imgNumArr(uu,1)));
%             else
%                 fprintf(fileB, '|');
%                 fprintf(fileB, num2str(imgNumArr(uu,1)));
%             end
%         end
%         fprintf(fileB,'\n');
%         tLine = fgets(fid);
%     end
%     fclose(fid);
%     fclose(fileB);
% end



close all;
clear all;
clc;

componentImgSavinigPath_Full = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/Original_Images/';
savingPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/saveImgsGrey/';

filesInFolderCap = dir(fullfile(componentImgSavinigPath_Full, '*.jpg'));
fileNamesInFolderCap = {filesInFolderCap.name}';

for i = 1:1:length(fileNamesInFolderCap)
    name = fileNamesInFolderCap{i,1} ;
    imgNm = [];
    folderNm = [];
    iGotFlg = 0;
    folderNmFlag = 0;
    img = imread([componentImgSavinigPath_Full name]);
    [~, name, ext] = fileparts(name); 
    for chr = 1:1:length(name)
        if((name(1,chr) ~= '#') && (folderNmFlag == 0) )
            iGotFlg = 1;
        elseif(name(1,chr) == '#')
            folderNmFlag = 1;
            iGotFlg = 0;
        end
        if(iGotFlg == 1)
            imgNm = [imgNm,name(1,chr)];
        elseif(folderNmFlag == 1)
            folderNm = [folderNm,name(1,chr)];
        end
    end
    mysavingPath = [savingPath imgNm '.jpg'];
    imwrite(img,mysavingPath);
end