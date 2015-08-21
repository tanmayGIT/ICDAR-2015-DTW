% generateFeatureMat  :-  Here is the following operation for generating
% offline features like
% column features and HOG features. Here the input to the function is
% the path of the folder where all other folders are present named after
% the name of the reference images. The folders with the name of the
% reference images having many segmented component images. So using these
% images we will create feature matrix and will save it for future use.



% matchOffline: Here this function will have the facility to match the
% function offline after the features are generated anb stored


tic;
clear all;
% close all;
clc;

% WordMatching('generateFeatureMat','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% WordMatching('matchOfflineNewCSER','CSER','columnFeature','Old_Normalize','makeDoubleHeight','DTW');
% WordMatching('generateFeatureMat','CSER','columnFeature','Old_Normalize','makeDoubleHeight');
% clear all;

% WordMatching('generateFeatureMat','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% clear all;






%***************************************************************************
%***************************************************************************
% this code was written for finding the best parameter for WDTW and WDDTW 
% arra1 = cell(1,2);
% arra2 = cell(1,2);
% cnt = 1;
% global tip
% for ii = 1:10:100
% tip = ii/100;
% resu1 = WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','WDTW');
% resu2 = WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','WDDTW');
% arra1{cnt,1} = resu1;
% arra1{cnt,2} = tip;
% arra2{cnt,1} = resu2;
% arra2{cnt,2} = tip;
% disp('my loop');
% disp(ii);
% cnt = cnt +1;
% end
% save('arra1');
% save('arra2');
%***************************************************************************
%***************************************************************************

%global percent
% cnt = 1;
% tkArr2 = cell(1,1);
% for ii = 39:-3:10
%  percent = ii;
%  myArr = WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','SC_Band',percent);
%  tkArr2{cnt,1} = myArr;
%  cnt = cnt +1;
% end
% save tkArr2;
% 
% cnt = 1;
% tkArr2Itekura = cell(1,1);
% for ii = 100:-3:10
%  percent = ii;
%  myArr = WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','Itekura_Band',percent);
%  tkArr2Itekura{cnt,1} = myArr;
%  cnt = cnt +1;
% end
% save tkArr2Itekura;

 percent = 1;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','CDP1',percent);

WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM',percent);

WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','OSB',percent);
clear all;




