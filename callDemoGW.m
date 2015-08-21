clear all;
close all;
clc;


% technique = 'MVM_Updated_12';
% allResult = DemoForGW(technique,1);
% save([technique,'test','GW_Result'],'allResult');
% disp([technique,'test','GW_Result']);

% technique = 'MVM_Updated_17';
% allResult = DemoForGW(technique,1);
% save([technique,'test','test','GW_Result'],'allResult');
% disp([technique,'GW_Result']);


% technique = 'FSM';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);


technique = 'DTW';
allResult = DemoForGW_ICDAR(technique,1);
save([technique,'ICDAR'],'allResult');
disp([technique,'ICDAR']);
%

% technique = 'CDP1';
% allResult = DemoForGW_ICDAR(technique,1);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);

% technique = 'MVM';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);

% technique = 'SSDTW';
% allResult = DemoForGW_ICDAR(technique,1);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);

% technique = 'DDTW';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);

% technique = '3_LDTW';
% allResult = DemoForGW_ICDAR(technique);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);
% %
% technique = 'PDTW';
% allResult = DemoForGW_ICDAR(technique);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);
% %
% technique = 'PDDTW';
% allResult = DemoForGW_ICDAR(technique);
% save([technique,'ICDAR'],'allResult');
% disp([technique,'ICDAR']);
%
% technique = 'JawaharDTW';
% allResult = DemoForGW_ICDAR(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);
%
% technique = 'OSB';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_ResultNextNext'],'allResult');
% disp([technique,'GW_Result']);

% technique = '3_LDTW';
% allResult = DemoForGW_ICDAR(technique,1);
% save([technique,'ICDAR_LDTW'],'allResult');
% disp([technique,'ICDAR_LDTW']);

% technique = 'Itekura_Band';
% allResult = DemoForGW_ICDAR(technique,1);
% save([technique,'ICDAR'],'allResult');
% ........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................disp([technique,'ICDAR']);

% %***************************************************************************
% % This code was written for finding the best parameter for WDTW and WDDTW
% arra1GW_WDTW = cell(1,2);
% arra2GW_WDTW = cell(1,2);
% cnt = 1;

% for ii = 1:1:20
% tip = ii/100;
% resu1 = DemoForGW('WDTW',tip);
% resu2 = DemoForGW('WDDTW',tip);
% arra1GW_WDTW{cnt,1} = resu1;
% arra1GW_WDTW{cnt,2} = tip;
% arra2GW_WDTW{cnt,1} = resu2;
% arra2GW_WDTW{cnt,2} = tip;
% disp('my loop');
% disp(ii);
% cnt = cnt +1;
% end
% save('arra1GW_WDTW');
% save('arra2GW_WDTW');
% %***************************************************************************


%global percent
% cnt = 1;
% tkArr2GW_SC = cell(1,1);
% for ii = 50:-3:10
%  percent = ii;
%  myArr = DemoForGW('SC_Band',percent);
%  tkArr2GW_SC{cnt,1} = myArr;
%  tkArr2GW_SC{cnt,2} = percent;
%  cnt = cnt +1;
% end
% save tkArr2GW_SC;

% cnt = 1;
% tkArr2_GW_Itekura = cell(1,1);
% for ii = 100:-3:10
% percent = ii;
% myArr = DemoForGW('Itekura_Band',percent);
% tkArr2Itekura{cnt,1} = myArr;
% tkArr2Itekura{cnt,2} = percent;
% cnt = cnt +1;
% end
% save tkArr2_GW_Itekura;

