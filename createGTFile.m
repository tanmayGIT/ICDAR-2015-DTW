function [fid,fileB] = createGTFile(componentImgSavinigPath_Full,folderNm,imgNm)
GTfilePath = [componentImgSavinigPath_Full folderNm '/' 'GT_Value.txt'];
GTfilePath1 = [componentImgSavinigPath_Full folderNm '/' 'GTCopy_Value.txt'];
fid = fopen(GTfilePath,'rt');
fileB = fopen(GTfilePath1, 'wt');
if fid < 0, error('Cannot open file'); end
if fileB < 0, error('Cannot open file'); end
tLine = fgets(fid);

while (ischar(tLine))
    imgNumArr = zeros(1,1);
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
                imgNumArr(tk,1) = str2num(imgNumbe); % put the earlier number in the array
                imgNumbe = [];
                tk = tk +1;
            end
            continue;
        end
        if( (txtFlag == 0) && (iAmEndFlag == 0) )
            txtImgNm = [txtImgNm,tLine(1,ii)];
        elseif(txtFlag == 1) % i got the first |
            imgNumbe = [imgNumbe,tLine(1,ii)];
            numTakenFlag = 1;
        end
    end
    imgNumArr(tk,1) = str2num(imgNumbe);
    fprintf(fileB, txtImgNm);
    for uu = 1:1:length(imgNumArr)
        myImgNm = [num2str(imgNumArr(uu,1)), '_',txtImgNm];
        [iGotUFlag,indenti] = checkMe(imgNm,myImgNm);
        if(iGotUFlag == 1)
            fprintf(fileB, '|');
            fprintf(fileB, indenti);
            fprintf(fileB, num2str(imgNumArr(uu,1)));
        else
            fprintf(fileB, '|');
            fprintf(fileB, num2str(imgNumArr(uu,1)));
        end
    end
    fprintf(fileB,'\n');
    tLine = fgets(fid);
end
fclose(fid);
fclose(fileB);
end

function [iGotUFlag,indenti] = checkMe(imgNm,myImgNm)
iGotUFlag = 0;
for ty = 2:1:length(imgNm)
    tempImgNm = imgNm{1,ty}{1,1};
    indenti = imgNm{1,ty}{1,2};
    % Now search in all the array
    if(strcmp(myImgNm,tempImgNm))
        iGotUFlag = 1;
    end
end
return;
end