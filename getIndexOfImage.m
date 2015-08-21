function [j] = getIndexOfImage(imgName,pathMat)
for j=1:1:(length(pathMat))
    imgPath = pathMat{j,1};
    [~, name, ~] = fileparts(imgPath) ;
    if(strcmp(imgName,name))
        return;
    end
end
end