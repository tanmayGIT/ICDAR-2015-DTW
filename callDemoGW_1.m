clear all;
close all;
clc;

% technique = '0_Symmetric';
% allResult = DemoForGW(technique,1);
% save([technique,'GW_Result'],'allResult');
% disp([technique,'GW_Result']);

technique = '0_Asymmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '1_Symmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '1_Asymmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '2_Symmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '2_Asymmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '50_Asymmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '50_Symmetric';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '3_LDTW';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);

technique = '4_SomethingNew';
allResult = DemoForGW(technique,1);
save([technique,'GW_Result'],'allResult');
disp([technique,'GW_Result']);
