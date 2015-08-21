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

% WordMatching('generateFeatureMatICDARCompetetion','CSER','columnFeature','Old_Normalize','makeDoubleHeight','MVM');
% WordMatching('generateFeatureMatICDARCompetetion','CSER','HOGFeature','Old_Normalize','keepOriginalHeight','MVM');
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
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','Itekura_Band');
% 
% 
% technique = 'Itekura_Band';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);


% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','WDTW',0.03);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','WDDTW',0.01);
WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','sparseDTW',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','1_Symmetric',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','1_Asymmetric',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','2_Symmetric',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','2_Asymmetric',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','50_Symmetric',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','50_Asymmetric',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','3_LDTW',1);
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','4_SomethingNew',1);
% clear all;
% 
% 
% 
% 
% %% start of one part   from 6-10 ref img
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','OSB',1);
% clear all;
% 1-3 ref img
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','OSB',1);
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','DTW',1);
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','DTW_CW',1);
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','JawaharDTW',1);
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','PDTW',1);
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','PDDTW',1);
% clear all;
% WordMatching('matchOffline','CSER','columnFeature','Old_Normalize','makeDoubleHeight','SSDTW',1);
% clear all;
%% End of one part

