function [final_line,grey_corrected] = slantCorrection(line,grey_img, angle)

    % We increase the image to avoid the black pixels of the transformation
%     [h w d] = size(line);
%     new_line = uint8(zeros(h, w*2, d));
%     new_line(:) = 255;
%    
%     new_line(:, floor(w/2):floor(w/2) + w - 1, :) = line(:,:,:);
   
    % To avoid the black corners of rotation make the image bigger
%     inv_line = invertBwImage(line);

    % Transformation
    tf = [1 0 0; tand(90 - angle) 1 0; 0 0 1];
    tform = maketform('affine', tf);
    corrected_line = imtransform(line, tform);
    grey_corrected = imtransform(grey_img, tform);
    final_line = corrected_line;
%     final_line = removeBlackCorners(corrected_line);
    
    
    
    
    
%     final_line = invertBwImage(corrected_line);
   
%     borders = extractBoundingBox(corrected_line, 1);
%     final_line = corrected_line(borders(3):borders(4), borders(1):borders(2));
%    
%     % We extract the final line from the increased image
%     stepX = floor(0.1 * w);
%     final_line = corrected_line(:, floor(w/2) - stepX : 3*floor(w/2)-1 + stepX, :);
     
%     figure, imshow(final_line,[]);
%     title('After Slant Correction');

end