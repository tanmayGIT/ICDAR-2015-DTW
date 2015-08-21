close all;
clear all;
clc;

storPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_2';
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
    if(strcmp(imageNm,'roy'))
        completePath = [storPath '/' imageNm '/'];
        if((exist(completePath,'dir'))==0)
            mkdir(completePath);
        end
        if(~isempty(wordInfoArr{uu,2}))
            for ii = 1:1:size(wordInfoArr{uu,2},1)
                imageNum = wordInfoArr{uu,2}{ii,1};
                if (imageNum > 700)
                    imageNum = imageNum - 700;
                else
                    imageNum = imageNum +16;% there are difference of 12 in the numbering
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
                %             newNam = ['BRom_Montaigne1_',imageNum,'#',imageNm,'.jpg'];
                imwrite(img1,[completePath imgnme]);
            end
        end
        
        if(~isempty(wordInfoArr{uu,3}))
            for ii = 1:1:size(wordInfoArr{uu,3},1)
                imageNum = wordInfoArr{uu,3}{ii,1};
                if (imageNum > 700)
                    imageNum = imageNum - 700;
                else
                    if((2<=imageNum)&&(imageNum<=41) )
                        imageNum = imageNum +12;
                    elseif(imageNum == 43)
                        imageNum = 53;
                    elseif(imageNum == 42)
                        imageNum = 55;
                    elseif(imageNum == 44)
                        imageNum = 56;
                    elseif(imageNum == 45)
                        imageNum = 57;
                    elseif(imageNum == 40)
                        imageNum = 58;
                    elseif((47<= imageNum)&&(imageNum<= 55) )
                        imageNum = imageNum + 12;
                    elseif(imageNum == 54)
                        imageNum = 68;
                    elseif(imageNum == 55)
                        imageNum = 69;
                    elseif(imageNum == 58)
                        imageNum = 70;
                    elseif(imageNum == 59)
                        imageNum = 71;
                    elseif(imageNum == 58)
                        imageNum = 72;
                    elseif(imageNum == 59)
                        imageNum = 73;
                    elseif(imageNum == 62)
                        imageNum = 74;
                    elseif(imageNum == 63)
                        imageNum = 75;
                    elseif(imageNum == 63)
                        imageNum = 75;
                    elseif(imageNum == 62)
                        imageNum = 76;
                    elseif(imageNum == 65)
                        imageNum = 77;
                    elseif( (66<=imageNum)&&(imageNum<=84) )
                        imageNum = imageNum + 12;
                    elseif(imageNum == 83)
                        imageNum = 97;
                    elseif(imageNum == 86)
                        imageNum = 98;
                    elseif(imageNum == 87)
                        imageNum = 99;
                    elseif(imageNum == 85)
                        imageNum = 100;
                    elseif(imageNum == 86)
                        imageNum = 101;
                    elseif(imageNum == 90)
                        imageNum = 102;
                    elseif(imageNum == 91)
                        imageNum = 103;
                    elseif(imageNum == 89)
                        imageNum = 104;
                    elseif(imageNum == 90)
                        imageNum = 105;
                    elseif(imageNum == 95)
                        imageNum = 106;
                    elseif(imageNum == 96)
                        imageNum = 107;
                    elseif(imageNum == 93)
                        imageNum = 108;
                    elseif(imageNum == 93)
                        imageNum = 109;
                    elseif((95<=imageNum)&&(imageNum <= 101) )
                        imageNum = imageNum + 15;
                    elseif(imageNum == 72)
                        imageNum = 117;
                    elseif( (103<= imageNum)&&(imageNum<= 106) )
                        imageNum = imageNum + 15;
                    elseif(imageNum == 167)
                        imageNum = 122;
                    elseif( (108 <=imageNum)&&(imageNum<= 189) )
                        imageNum = imageNum + 15;
                    elseif( (224 <=imageNum)&& (imageNum<= 239) )
                        imageNum = imageNum + 14;
                    elseif( (256 <=imageNum)&&(imageNum <= 301) )
                        imageNum = imageNum + 12;
                    elseif( (302 <=imageNum)&&(imageNum <= 335) )
                        imageNum = imageNum + 13;
                    elseif((347 <=imageNum)&&(imageNum <= 366))
                        imageNum = imageNum + 14;
                    elseif( (367 <=imageNum)&&(imageNum <= 490) )
                        imageNum = imageNum + 15;
                    elseif( (492 <=imageNum) &&(imageNum<= 513) )
                        imageNum = imageNum + 16;
                    elseif( (530 <=imageNum) && (imageNum <= 568) )
                        imageNum = imageNum + 16;     
                    elseif( (570 <=imageNum)&& (imageNum<= 636) )
                        imageNum = imageNum + 16;            
                    else
                         imageNum = imageNum + 12; 
                    end
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
                %             newNam = ['M0275_02_',imageNum,'#',imageNm,'.jpg'];
                imwrite(img2,[completePath imgnme]);
            end
        end
    end
end

disp('great man');