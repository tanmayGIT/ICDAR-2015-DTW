% The main utilization of this function is that it is used for finding the
% proper boundary around the image


function [l1Ref,l4Ref,topLineRef,baseLineRef,componentImg,ImgRef] = mainBasicFuncForRef(beforeRLSARef,ImgRef,matchingFunc,heightMatter)
[sz1,sz2] = size(beforeRLSARef);
topRw =  1;
botRow = sz1;
leftCol = 1;
rightCol = sz2;
% Finding the top row
flag = 0;
for topI = 1:1:sz1
    for topJ = 1:1:sz2
        if(beforeRLSARef(topI,topJ) == 1)
            topRw = topI;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end

% Finding the bottom row
flag = 0;
for topI = sz1:-1:1
    for topJ = 1:1:sz2
        if(beforeRLSARef(topI,topJ) == 1)
            botRow = topI;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end
% Finding the left col
flag = 0;

for topJ = 1:1:sz2
    for topI = 1:1:sz1
        if(beforeRLSARef(topI,topJ) == 1)
            leftCol = topJ;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
    
end
% Finding the right Col
flag = 0;

for topJ = sz2:-1:1
    for topI = 1:1:sz1
        if(beforeRLSARef(topI,topJ) == 1)
            rightCol = topJ;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end
componentImg = beforeRLSARef(topRw:botRow,leftCol:rightCol);
ImgRef = ImgRef(topRw:botRow,leftCol:rightCol);
% [l1Ref,l4Ref,topLineRef,baseLineRef] = testAscenderDescenderRefWordFunc(componentImg);








%**************************************************************************
% I think therer is no need to make it of double sized as the reference
% image will be dobled later, when it will be matched with particular
% component image
if( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) )
    % Making the image height double of the average height
      
%     componentImg = imresize(componentImg,[(avgHeight*1) NaN]);
%     ImgRef = imresize(ImgRef,[(avgHeight*1) NaN]);

end
%**************************************************************************






if (strcmp(matchingFunc,'New_Normalize'))
    [l1Ref,l4Ref,topLineRef,baseLineRef] = callTestAscenderDescenderFunc(componentImg);
elseif(strcmp(matchingFunc,'Old_Normalize'))
    % As you don't need these values
        l1Ref = 0;
        l4Ref = 0;
        topLineRef = 0;
        baseLineRef = 0;
end
return
end
