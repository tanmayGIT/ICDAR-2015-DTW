function keepAllDist = calculateSpecialJC(refMatFeature,getMyGT,queryInfo)
% now, you need to avoid queryInfo from caculating JC of the images
imgInputFolder = 'gw_20p_wannot\';
onlyRefMat = refMatFeature(:,5:end);

formattedGT = cell(3,size(getMyGT,1));
for tioo = 1:1:size(getMyGT,1)
    formattedGT{1,tioo} = [getMyGT{tioo,1} '_' (num2str(getMyGT{tioo,2}))];
end
global storEachImgResult;
MyLocalVar = storEachImgResult;

amount_of_matches = 2;
keepAllDist = cell(2,1);
cnt_matches = 1;
for matchNm = 1:length(MyLocalVar)
    nm = MyLocalVar{matchNm,2};
    getArr = findMyImg(nm, getMyGT);
    if(~strcmp(nm,queryInfo.imageName)) % if the image name and query is not same
        fullImgPath = [imgInputFolder nm '.' 'tif'];
        img = imread(fullImgPath); % read full image
        if(size(img,3)==3)
            img = rgb2gray(img);
        end
        [fulImgRw,fulImgCol] = size(img);
        fullFeaturesetOfImage = MyLocalVar{matchNm,1};
        myNumberOflne = (size(fullFeaturesetOfImage,1));
        
        for eachGTOfImg = 1:1:size(getArr,1)
            if( (~isempty(getArr)) && (getArr{eachGTOfImg,4} ~= 2)  && (strcmp(getArr{eachGTOfImg,1},nm)) )
                % If we have more than one hyphenated words in a particular image.
                lineArr = zeros(size(getArr,1),1);
                lineArr(eachGTOfImg,1) = getArr{eachGTOfImg,2};
            end
        end
        
        if( ~isempty(getArr) ) % then there are some repeated words in the same line
            [CC,~,~] = unique(lineArr); % this line will say whether there are two words on the same line, if it happen then there will be a repeated entry and this function "unique" will choose only unique entries
            if((length(CC) == length(lineArr)))
                % here it is considered that hyphenated words will always belongs to a consecutive lines
                getLn = 1;
                while (getLn <= myNumberOflne)
                    for hhu = 1:1:size(lineArr,1)
                        if(lineArr(hhu,1) == getLn)
                            completeLinefeatue = fullFeaturesetOfImage{getLn,1};
                            myFullFeaturesetOfImage = fullFeaturesetOfImage{getLn,2};
                            [~,onlyLnFeature,~,~,~] = getAllInfor(completeLinefeatue,myFullFeaturesetOfImage,fulImgRw,fulImgCol,img);
                            distMat = getDistanceMatrix(onlyRefMat,onlyLnFeature);
                            keepAllDist{cnt_matches,1} = distMat;
                            if(cnt_matches == amount_of_matches)
                                return;
                            end
                            cnt_matches = cnt_matches +1;
                        end
                    end
                    getLn = getLn +1;
                end
            end
        end
    end
end

end



function [Dist] = getDistanceMatrix(refSample,testSample)
[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);

for i=1:noOfSamplesInRefSample
    for j=1:noOfSamplesInTestSample
        total = zeros(N,1);
        for goFeature = 1:N
            total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
        end
        Dist(i,j) = sqrt(sum(total));
    end
end
% [jumpcost,smalJC] = calJumpCost(Dist);
return
end

function getArr = findMyImg(nm, myGT)
getArr = cell(1,4);
chkMark = zeros(length(myGT),1);
myCnt = 1;
for io = 1:1:size(myGT,1)
    if(strcmp(nm,myGT{io,1}))
        if( chkMark(io,1) == 0)
            for ptt = 1:1:8
                getArr{myCnt,ptt} = myGT{io,ptt};
                chkMark(io,1) = 1;
            end
            myCnt = myCnt + 1;
        end
    end
end
if (myCnt <2)
    getArr = [];
end
end

function [realIndxTest,onlyLnFeature,Xvert,Yvert,lineImg] = getAllInfor(completeLinefeatue,myFullFeaturesetOfImage,fulImgRw,fulImgCol,img)
realIndxTest = zeros((size(completeLinefeatue,1)),2);
onlyLnFeature = completeLinefeatue(:,8:end);

Xvert = myFullFeaturesetOfImage{1,1};
Yvert = myFullFeaturesetOfImage{1,2};
mask = poly2mask(Xvert,Yvert,fulImgRw,fulImgCol);
masked_im = bsxfun(@times,img,cast(mask,class(img)));
lineImg = masked_im(min(Yvert):max(Yvert),min(Xvert):max(Xvert));
end