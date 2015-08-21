function[BW2] =  ApplyMorphology(BW2,applyFlag)
if(size(BW2,3)==3)
    BW2 = rgb2gray(BW2);
end
% SE = strel('square', 3); % generating a structuring element of 3*3 square
% BW2 = bwmorph(BW2,'bridge');
% BW2 = bwmorph(BW2,'fill');
% BW2 = bwmorph(BW2,'majority');
BW2 = bwmorph(BW2,'clean');
% BW2 = bwmorph(BW2,'spur');

% if(applyFlag)
%     se = strel('line',6,90);
%     BW2 = imdilate(BW2,se);
% end
% BW2 = bwmorph(BW2,'majority');
BW2 = bwmorph(BW2,'clean');
% BW2 = bwmorph(BW2,'spur');
return;
end