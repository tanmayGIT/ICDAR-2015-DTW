function [Img,binImg] =  generatePerfectBoundary(greyImg,beforeRLSATest)   
[sz1,sz2] = size(beforeRLSATest);
    topRw =  1;
    botRow = sz1;
    leftCol = 1;
    rightCol = sz2;
    % Finding the top row
    flag = 0;
    for topI = 1:1:sz1
        for topJ = 1:1:sz2
            if(beforeRLSATest(topI,topJ) == 1)
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
            if(beforeRLSATest(topI,topJ) == 1)
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
            if(beforeRLSATest(topI,topJ) == 1)
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
            if(beforeRLSATest(topI,topJ) == 1)
                rightCol = topJ;
                flag = 1;
                break;
            end
        end
        if(flag == 1)
            break;
        end
    end
    Img = greyImg(topRw:botRow,leftCol:rightCol);
    binImg = beforeRLSATest(topRw:botRow,leftCol:rightCol);
    return;