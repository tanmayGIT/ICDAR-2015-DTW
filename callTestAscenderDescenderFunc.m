function [l1,l4,newRefinedTop,newRefinedBot] = callTestAscenderDescenderFunc(binImg)
[l1,l4,refinedTop,refinedBottom] = testAscenderDescenderFunc(binImg);
[avgHght] = getAvgHghtForAscenderDescender(binImg);

newRefinedTop = refinedTop;
% Now you have to see where is the problem
if((refinedTop ~= l1) && (refinedBottom == l4))
    % Now see what is avg. character height, has been calculated
    if( (abs(refinedBottom - refinedTop)) < (((l4-l1)*35)/100) )
        newRefinedTop = l4 - avgHght;
        if(newRefinedTop < l1)
            newRefinedTop = l1;
        end
    end
end

newRefinedBot = refinedBottom;
if((refinedTop == l1) && (refinedBottom ~= l4))
    % Now see what is avg. character height, has been calculated
    if( (abs(refinedBottom - refinedTop)) < (((l4-l1)*35)/100) )
        newRefinedBot = avgHght;
    end
end
midPoint = (l4 - l1)/2;

if((refinedTop ~= l1) && (refinedBottom ~= l4))
    
    % If the gap between refinedBottom and refinedTop is even less than
    % 40% of word height; the  there is some problem
    if((refinedBottom - refinedTop) < (((l4-l1)*40)/100))
        % now find out which line has the problem
        if((abs(midPoint - refinedTop)) < (abs(midPoint - refinedBottom))) % top line has problem
            newRefinedTop = refinedBottom - avgHght; % get the character height
        else
            newRefinedBot = refinedTop + avgHght;
            if(newRefinedBot > l4)
                newRefinedBot = l4;
            end
        end
    end
    
end

if((newRefinedTop ~= l1)&&((abs(newRefinedTop-l1))<15))
    newRefinedTop = l1;
end
end

