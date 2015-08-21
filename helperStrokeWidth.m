function strokeWidthImage = helperStrokeWidth(DistanceImage)
% helperStrokeWidth Transforms distance image into stroke width image
%   This function helperStrokeWidth is only in support of the
%   TextDetectionExample. It may change in a future release.
%
%   StrokeWidthImage = helperStrokeWidth(DistanceImage);
%   returns a Stroke Width Image computed from DistanceImage, containing a
%   value for stroke width at each non-zero pixel in the DistanceImage.
%   DistanceImage is a Euclidean distance transform of a binary image
%   computed by bwdist.
%

% References
%
% [1] Chen, Huizhong, et al. "Robust Text Detection in Natural Images with
%     Edge-Enhanced Maximally Stable Extremal Regions." Image Processing
%     (ICIP), 2011 18th IEEE International Conference on. IEEE, 2011.

DistanceImage = round(DistanceImage); % bins distances into integer values for comparison

% Define 8-connected neighbors
connectivity = [ 1 0; -1 0; 1 1; 0 1; -1 1; 1 -1; 0 -1; -1 -1]';

% Create padded version of distance image for matrix-wise neighbors comparison
paddedDistanceImage = padarray(DistanceImage,[1,1]);
Dind = find(paddedDistanceImage ~= 0);
sz=size(paddedDistanceImage);

% Compare whether eight neighbors are less than current pixel for all
% pixels in image
neighborIndices = repmat(Dind,[1,8]);
[I,J] = ind2sub(sz,neighborIndices);
I = bsxfun(@plus,I,connectivity(1,:));
J = bsxfun(@plus,J,connectivity(2,:));
neighborIndices = sub2ind(sz,I,J);
lookup = bsxfun(@lt,paddedDistanceImage(neighborIndices),paddedDistanceImage(Dind));
lookup(paddedDistanceImage(neighborIndices) == 0) = false;

% Propagate local maximum stroke values to neighbors recursively
maxStroke = max(max(paddedDistanceImage));
for Stroke = maxStroke:-1:1
    neighborIndextemp = ...
        neighborIndices(paddedDistanceImage(Dind) == Stroke,:);
    lookupTemp = lookup(paddedDistanceImage(Dind) == Stroke,:);
    neighborIndex = neighborIndextemp(lookupTemp);
    while ~isempty(neighborIndex)
        paddedDistanceImage(neighborIndex) = Stroke;
        [~,ia,~] = intersect(Dind,neighborIndex);
        neighborIndextemp = neighborIndices(ia,:);
        lookupTemp = lookup(ia,:);
        neighborIndex = neighborIndextemp(lookupTemp);
    end
end

% Remove pad to restore original image size
strokeWidthImage = paddedDistanceImage(2:end-1,2:end-1);
