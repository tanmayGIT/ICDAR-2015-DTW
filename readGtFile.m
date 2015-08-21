close all;
clear all;
clc;

storPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3';
orininalImgPath_1 = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/M0275_01/';
orininalImgPath_2 = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/M0275_02/';

fid = fopen('forGTCSERVer_1.txt','rt');
if fid < 0, error('Cannot open file'); end

slitFeatureMat = zeros(1,9);
formatSpec = repmat('%n', [1,(9)]);

lineTracker = 0;
slitCnt = 1;
s = textscan(fid, '%s', 'delimiter', '\n');
lenS = length(s{1,1});
wordInfoArr = cell(1,1);
wordCnt = 0;
secondFolFlg = 0;
secondWordCnt = 0;
firstFolFlag = 0;
firstWordCnt = 0;
for ii = 1:1:lenS
    line = s{1,1}{ii,1};
    tempWord = [];
    tempNum = [];
    badcnt = 0;
    for getChr = 1:1:length(line)
        if(~strcmp(line(1,getChr),' ')   )
            tempWord = strcat(tempWord,line(1,getChr));
        end
    end
    A = isstrprop(tempWord, 'alpha');
    if ( (~isempty(A)) && (all(A)) )% all the element in the tempWord is alphabet; so it is the query word
        wordCnt = wordCnt +1;
        wordInfoArr{wordCnt,1} = tempWord;
        secondFolFlg = 0;
        firstFolFlag = 0;
        firstWordCnt = 1;
        secondWordCnt = 1;
    elseif strcmp(tempWord,'M0275_02')
        wordInfoArr{wordCnt,3}{1,1} = tempWord;
        secondFolFlg = 1;
        firstFolFlag = 0;
    elseif strcmp(tempWord,'M0275_01')
        wordInfoArr{wordCnt,2}{1,1} = tempWord;
        firstFolFlag = 1;
        secondFolFlg = 0;
    elseif ( ( (~isempty(A)) && (nnz(A)==0) ) ||   (isempty(A)) ) % Number of non-zero elements is zero then it is ----------     % blank line
        %         disp('got u');
    else
        myNum = [];
        for yy = 1:1:length(tempWord)
            yCh = tempWord(1,yy);
            if(checkIsNumeric(yCh))
                myNum = strcat(myNum,yCh);
            end
        end
        if(firstFolFlag == 1)
            wordInfoArr{wordCnt,2}{firstWordCnt,1} = str2double(myNum);
            firstWordCnt = firstWordCnt +1;
        elseif(secondFolFlg == 1)
            wordInfoArr{wordCnt,3}{secondWordCnt,1} = str2double(myNum);
            secondWordCnt = secondWordCnt +1;
        end
    end
end
for uu = 1:1:size(wordInfoArr,1)
    disp(uu);
    imageNm = wordInfoArr{uu,1};
    completePath = [storPath '/' 'Images' '/'];
    if((exist(completePath,'dir'))==0)
        mkdir(completePath);
    end
    if(~isempty(wordInfoArr{uu,2}))
        for ii = 1:1:size(wordInfoArr{uu,2},1)
            imageNum = wordInfoArr{uu,2}{ii,1};
            if (imageNum > 700)
                imageNum = imageNum - 700;
            else
                imageNum = imageNum +12;% there are difference of 12 in the numbering
            end
            
            if (imageNum<10)
                imageNum = (['000',num2str(imageNum)]);
            elseif(imageNum<100)
                imageNum = (['00',num2str(imageNum)]);
            elseif(imageNum<1000)
                imageNum = (['0',num2str(imageNum)]);
            end
            
            imgnme = ['BRom_Montaigne1_',imageNum,'.jpg'];
            comImgPath1 = [orininalImgPath_1,imgnme];
            img1 = imread(comImgPath1);
            newNam = ['BRom_Montaigne1_',imageNum,'#',imageNm,'.jpg'];
            imwrite(img1,[completePath,newNam]);
        end
    end
    
    if(~isempty(wordInfoArr{uu,3}))
        for ii = 1:1:size(wordInfoArr{uu,3},1)
            imageNum = wordInfoArr{uu,3}{ii,1};
            if (imageNum > 700)
                imageNum = imageNum - 700;
            else
                imageNum = imageNum +15;% there are difference of 12 in the numbering
            end
            
            if (imageNum<10)
                imageNum = (['000',num2str(imageNum)]);
            elseif(imageNum<100)
                imageNum = (['00',num2str(imageNum)]);
            elseif(imageNum<1000)
                imageNum = (['0',num2str(imageNum)]);
            end
            
            imgnme = ['M0275_02_',imageNum,'.jpg'];
            comImgPath2 = [orininalImgPath_2,imgnme];
            img2 = imread(comImgPath2);
            newNam = ['M0275_02_',imageNum,'#',imageNm,'.jpg'];
            imwrite(img2,[completePath,newNam]);
        end
    end
end

disp('great man');