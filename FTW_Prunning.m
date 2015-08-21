function FTW_Prunning(queryFeature, allTargetFeatureLists,avgWidth)
[queryFeature_PAA,~] = PAA_FTW(queryFeature,avgWidth);
% for each target images in the list
keepAllDistTarget = Inf(ize(allTargetFeatureLists,1),1);
for ii = 1:1:size(allTargetFeatureLists,1)
    targetFeature = allTargetFeatureLists{ii,1};
    [targetFeature_PAA,~] = PAA_FTW(targetFeature,avgWidth);
    DistanceVal = FTW(queryFeature_PAA,targetFeature_PAA);
    keepAllDistTarget(ii,1) = DistanceVal;
end
end