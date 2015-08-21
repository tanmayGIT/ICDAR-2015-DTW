clear all;
close all;
clc;

% Generating the process for performing experiments with each cluster of reference images  
[~,makeWordCluster] = getGT_GWComplete();
keepAllGT = cell(1,1);
cnt = 1;
noOfTimesExp = 5;
for ichk = 1:length(makeWordCluster)
    len = length(makeWordCluster{ichk,3});
    if( (makeWordCluster{ichk,4} >3) )
        if((len >=10))
            myGT = makeWordCluster{ichk,3};
            keepAllGT{cnt,1} = myGT;
            
            % choose a random index i.e the random image
            randRefImgIndex = randperm(length(myGT),noOfTimesExp);
            for tt = 1:1:noOfTimesExp
                copyMyGT = myGT;
                randVal = randRefImgIndex(tt);
                copyMyGT(randVal) = []; % remove the reference image from the GT
                copyMyGT(myGT==0) = [];
                keepAllGT{cnt,2}{tt,1} = myGT(randVal);
                keepAllGT{cnt,2}{tt,2} = copyMyGT;
            end
            cnt = cnt +1;
        end
    end
end
seperateGTforAllRef = cell(1,1);
for iu = 1:1:noOfTimesExp
    tempGTKeeper = cell(1,1);
    for yu = 1:1:size(keepAllGT,1)
       refImgIndex = keepAllGT{yu,2}{iu,1};
       refImgGT = keepAllGT{yu,2}{iu,2};
       tempGTKeeper{yu,1} = refImgIndex;
       tempGTKeeper{yu,2} = refImgGT; 
    end
     seperateGTforAllRef{iu,1} = tempGTKeeper;
end
% repeat the experiment 5 times

   
    
technique = 'DTW';
allResult = subDemoForGW_ACPR_2(technique,seperateGTforAllRef);
save([technique,'ICDARGW'],'allResult');
disp([technique,'ICDARGW']);
%

technique = 'CDP1';
allResult = subDemoForGW_ACPR_2(technique,seperateGTforAllRef);
save([technique,'ICDARGW'],'allResult');
disp([technique,'ICDARGW']);

% technique = 'MVM';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);

% technique = 'SSDTW';
% allResult = DemoForGW_ACPR_1(technique,1);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);

% technique = 'DDTW';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);

% technique = '3_LDTW';
% allResult = DemoForGW_ACPR_1(technique);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);
% %
% technique = 'PDTW';
% allResult = DemoForGW_ACPR_1(technique);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);
% %
% technique = 'PDDTW';
% allResult = DemoForGW_ACPR_1(technique);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);
%
% technique = 'JawaharDTW';
% allResult = DemoForGW_ACPR_1(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);
%
% technique = 'OSB';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_ResultNextNext'],'allResult');
% disp([technique,'GW_Result']);

% technique = '3_LDTW';
% allResult = DemoForGW_ACPR_1(technique,1);
% save([technique,'ICDAR_LDTW'],'allResult');
% disp([technique,'ICDAR_LDTW']);

% technique = 'Itekura_Band';
% allResult = DemoForGW_ACPR_1(technique,1);
% save([technique,'ICDAR'],'allResult');
