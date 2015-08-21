function [beforeRLSA] = wordSpottingBasicOperationRefNoRLSA(Img)
level = graythresh(Img);
Img1 = im2bw(Img,level);
Img1 = imcomplement(Img1);
beforeRLSA = ApplyMorphology(Img1);
return;
end
function[BW2] =  ApplyMorphology(BW2)
BW2 = bwmorph(BW2,'clean');
BW2 = bwmorph(BW2,'clean');
return;
end
