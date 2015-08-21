% clear all;
% close all;
% clc;
function [matches,makeWordCluster] = getGT_GWComplete()
%%%%%%%%%%%%%%%%%  Feature Generation For Complete Dataset %%%%%%%%%%%%%%%
inputImgDir = '.\allCroppedImgOriginal\grey\';
files = dir(fullfile(inputImgDir, '*.tif'));
fileNames = {files.name}';
nImagesRef = (length(fileNames));

%%%%%%%%%%%%%%%%%%%%%%   End of feature Generation  %%%%%%%%%%%%%%%%%%
% Read text file "relvance_judgement.txt"
fid = fopen(['annotations.txt'],'rt');
nLinesT1 = 0;

while (fgets(fid) ~= -1),
    nLinesT1 = nLinesT1+1;
end
fclose(fid);
[P] = textread(['annotations.txt'],'%s',nLinesT1);
makeWordCluster = cell(1,1);
cnt = 1;
for ii = 1:1:nImagesRef
    imgPath = fileNames{ii,1} ;
    [pathstr, name, ext] = fileparts(imgPath) ;
    nameDig = str2num(name(1,9:end));
    
    wordChar = P{nameDig,1};
    cleanWord = wordChar(1,1);
    for jj = 2:1:size(wordChar,2)
        if(~(strcmp(wordChar(1,jj),'.')) && ~(strcmp(wordChar(1,jj),','))&&...
                ~(strcmp(wordChar(1,jj),'-'))&&~(strcmp(wordChar(1,jj),';')))
            cleanWord = [cleanWord,wordChar(1,jj)];
        end
    end
    if(ii == 1)
        makeWordCluster{1,1} = wordChar;
        makeWordCluster{1,2} = cleanWord;
        makeWordCluster{1,3}(1,1) = ii;
        makeWordCluster{1,4} = length(cleanWord);
        cnt = cnt +1;
    else
        flag = 0;
        getpos = 0;
        for hy = 1:1:size(makeWordCluster,1)
            if(strcmp(makeWordCluster{hy,2},cleanWord))
                getpos = hy;
                flag = 1;
                break
            end
        end
        if(flag == 1)
            makeWordCluster{getpos,3}(end+1,1) = ii;
        else
            makeWordCluster{cnt,1} = wordChar;
            makeWordCluster{cnt,2} = cleanWord;
            makeWordCluster{cnt,3}(1,1) = ii;
            makeWordCluster{cnt,4} = length(cleanWord);
            cnt = cnt +1;
        end
    end
end
matches = Inf(nImagesRef,1);
for ju = 1:1:nImagesRef
    for hu = 1:1:size(makeWordCluster,1)
        temp = makeWordCluster{hu,3};
        flag = 0;
        for ll = 1:1:length(temp)
            if(ju == temp(ll))
                matches(ju,1) = makeWordCluster{hu,4};
                matches(ju,2:((2+length(temp))-1)) = temp(:);
                flag = 1;
                break;
            end
        end
        if(flag == 1)
            break;
        end
    end    
end
return;
% disp('fucj')
