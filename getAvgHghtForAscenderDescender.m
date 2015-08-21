function [avgHeight] = getAvgHghtForAscenderDescender(binImage)
binarisedImg = binImage;
CC = bwconncomp(binarisedImg);
L = labelmatrix(CC);

totalComponent = max(max(L)); 

HoldConnecCom  = cell(totalComponent, 1);
HoldConnecComRefined = cell(totalComponent, 1);
for Ini = 1:totalComponent
    HoldConnecCom{Ini,1}(1,1) = 0;
    HoldConnecCom{Ini,1}(1,2) = 0;
    
    HoldConnecComRefined{Ini,1}(1,1) = 0;
    HoldConnecComRefined{Ini,1}(1,2) = 0;
    
end

for ConnComX = 1:1:size(L,1)
    for ConnComY = 1:1:size(L,2)
        if (L(ConnComX,ConnComY)~=0)
            s = L(ConnComX,ConnComY);
            if(HoldConnecCom{s,1}(1,1)==0)
                HoldConnecCom{s,1}(1,1) = ConnComX;
                HoldConnecCom{s,1}(1,2) = ConnComY;
            else
                HoldConnecCom{s,1}(end+1,1) = ConnComX;
                HoldConnecCom{s,1}(end,2) = ConnComY;
            end
        end
    end
end

p=1;

ComponentHghtWdth = zeros(totalComponent,2);

for AccesEachCell = 1:1:totalComponent
    if (size((HoldConnecCom{AccesEachCell,1}),1)>=30) 
        HoldConnecComRefined{p,1} = HoldConnecCom{AccesEachCell,1};
        
        [minRow] = min(HoldConnecComRefined{p,1}(:,1));
       
        [minCol] = min(HoldConnecComRefined{p,1}(:,2));
        
        HoldConnecComRefined{p,1}(1,3) = minRow;%holding the min row; i.e. minimum at the Y direction
        HoldConnecComRefined{p,1}(1,4) = minCol;%holding the min value col; i.e. minimum at the X direction
        
        % for the top right most corner
        [maxCol] = max(HoldConnecComRefined{p,1}(:,2));
        % for the top right most corner
        HoldConnecComRefined{p,1}(2,3) = minRow;%holding the min value of row; i.e. minimum at the Y direction
        HoldConnecComRefined{p,1}(2,4) = maxCol;%holding the max value of col; i.e. minimum at the X direction
        
        %for the bottom left most corner from next statement we are getting the
        %maximum of row; i.e in the Y direction
        [maxRow] = max(HoldConnecComRefined{p,1}(:,1));
        
        HoldConnecComRefined{p,1}(3,3) = maxRow;%holding the max of row; i.e. in the Y direction
        HoldConnecComRefined{p,1}(3,4) = minCol;%holding the min of Col i.e. in the X direction
        
        %for the bottom right most corner
        HoldConnecComRefined{p,1}(4,3) = maxRow;%holding the max value of X coordinate
        HoldConnecComRefined{p,1}(4,4) = maxCol;%holding the max value of the Y coordinate
        
        Y = [HoldConnecComRefined{p,1}(1,3) HoldConnecComRefined{p,1}(3,3)];
        X = [HoldConnecComRefined{p,1}(1,4) HoldConnecComRefined{p,1}(2,4)];
   
        Wdth = X(2)-X(1);
        
        % Calculating the height of the component
        Hght = Y(2)-Y(1);
        if ((Hght>0)&&(Wdth>0))
            
            % for eliminating those component whose height & width don't overcome
            % the threshold parameter.
            ComponentHghtWdth(p,1) = Hght; % storing component height
            ComponentHghtWdth(p,2) = Wdth;
            p = p+1;
        end
    end
end

[~,~,ComponentHghtWdth1] = find(ComponentHghtWdth(:,1));
ComponentHghtWdth1 = sort(ComponentHghtWdth1);
% nElement = length(ComponentHghtWdth);

% The minimum height of the character is the average character height
% Here it is considered that a word can not be formed by all characters having ascender/descender
avgHeight = min(ComponentHghtWdth1);
for tkHght = 1:1:length(ComponentHghtWdth1)
    if(ComponentHghtWdth1(tkHght,1) > 15) % assumed that in the dataset he height of the word has to be more than 15
        avgHeight = ComponentHghtWdth1(tkHght,1);
        break;
    end
end

return;





