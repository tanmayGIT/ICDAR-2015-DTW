function angle = slantDetection(bw)

%     bw = im2bw(bw);
    bwTrans = (bw(:,2:end) - bw(:,1:end-1)) ~= 0;
%     bwTrans = bwmorph(bwTrans,'clean');
    bwTrans = bwmorph(bwTrans,'hbreak');
    box = bwTrans;
    Cbox = bwboundaries(box);
 
    min_stroke_length = 20;
    step_size = 25;
   
    degrees = [];
    [boxX,boxY] = find(box == 1);
    boxX = size(box,1)-boxX;
%     imshow(im)
%     hold on;
%     title('Relevant Lines');
   
    for i = 1 : size(Cbox,1)
       
        points = unique(cell2mat(Cbox(i)),'rows');
        if size(points,1) <= min_stroke_length
            continue
        end
        X = size(box,1) - points(:,1);
        Y = size(box,2) - points(:,2);
       
        VX = points(:,2);
        VY = size(box,1) - points(:,1);
       
        mux = mean(X);
        muy = mean(Y);
        oa = sum((X-mux).*(Y-muy))/sum((X-mux).^2);
        ob = muy - oa*mux;
        error = (oa * X + ob - Y) .^ 2;
        e = sqrt(sum(error)) / size(X,1);
       
        if e > 0.3
            continue
        else
            radian = atan(oa);
            degree = radian * 180 / pi;
            degree = 90 + degree;
            degrees = [degrees,degree];
%             plot([size(box,2)-ob,size(box,2)-(oa*size(box,1)+ob)],[size(box,1),0],'b');
%             degree
%             hold on;
%             plot(VX,size(box,1)-VY,'r');
%             hold on;
        end
       
    end
       
        a = histc(degrees,0:step_size:180);
        [maxa,idx] = max(a);
        if ~isempty(idx)
            degrees(degrees<(idx-1)*step_size|degrees>idx*step_size) = [];
            angle = mean(degrees);
        else
            angle = 0;
        end
       
end
