clear all;
close all;
clc;
RefallAccuracyArr = cell(1,1);
load('OSBGW_ResultNext.mat');
% clear all -except allAccuracyArr
cnt = 1;
for ii = 1:1:size(allResult,1)
    if(~isempty(allResult{ii,1}))
        RefallAccuracyArr{cnt,1} = allResult{ii,1};
        cnt = cnt +1;
    end
end
load('OSBGW_ResultNextNext.mat');
for ii = 1:1:size(allResult,1)
    if(~isempty(allResult{ii,1}))
        RefallAccuracyArr{cnt,1} = allResult{ii,1};
        cnt = cnt +1;
    end
end
% load('OSB_Old_Normalize_columnFeature_makeDoubleHeight_EndSide.mat');
% for ii = 1:1:size(allAccuracyArr,1)
%     if(~isempty(allAccuracyArr{ii,1}))
%         RefallAccuracyArr{cnt,1} = allAccuracyArr{ii,1};
%         cnt = cnt +1;
%     end
% end
save('OSB_ResultGWComplete','RefallAccuracyArr');