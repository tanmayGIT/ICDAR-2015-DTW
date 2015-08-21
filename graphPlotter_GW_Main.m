clear all;
% close all;
clc;

load('FastDTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X2,Y2,Z2,M2]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('FastDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('tkArr2GW_SCUpdated.mat'); % SC_Band
[allResult,RefallAccuracyArr] = cellToArrForPlot(tkArr2GW_SC{10,1});
mean_avg_pre = meanAveragePrecision(allResult);
[X3,Y3,Z3,M3]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('SC-Band');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('Itekura_BandGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X4,Y4,Z4,M4]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('Itekura_Band');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('arra2GW_WDDTWUpda.mat');
allResult = arra2GW_WDDTWUpda{6,1};
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X6,Y6,Z6,M6]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('WDDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('arra1GW_WDTWUpda.mat');
allResult = arra1GW_WDTWUpda{7,1};
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X7,Y7,Z7]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('WDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('PDDTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X8,Y8,Z8,M8]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('PDDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;


load('DTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X11,Y11,Z11,M11]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('MVM_Updated_12GW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X13,Y13,Z13,M13]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('PDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('MVM_Updated_17GW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X14,Y14,Z14,M14]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;


figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.6 0.8 0.2];...
  [0.4 0.58 0.9];[0.75 0 0.75];[0.72 0.52 0.04];[0.8 0.7 0.6];[0.6 0.5 0.4 ];...
  [0.8 0.6 1 ];[0 1 1];[0.619 1 0.4 ];[1 0.6 0.8]};

q = plot(Z2,Y2,'c-',Z3,Y3,'r-',Z4,Y4,'m-',Z6,Y6,'b-',...
    Z7,Y7,'k-');

hold on;
plot(Z8,Y8,'Color', colorspec{3});
hold on;
plot(Z11,Y11,'Color', colorspec{9});
hold on;
plot(Z13,Y13,'Color', colorspec{17});
hold on;
plot(Z14,Y14,'Color', colorspec{10},'LineStyle','-');
hold on;

hleg1 = legend('Fast-DTW (0.4348)','SC-Band (0.5876)','Itakura-Band (0.6017)','WDDTW (0.2431)','WDTW (0.3309)','PDDTW (0.2563)','DTW (0.4557)','PDTW (0.3466)','DDTW (0.2760)');


line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',7.2)

% set(gca,'XTick', [20,40,60,80,100])
% set(gca,'XTickLabel',{'20','40','60','80','100'})
% set(gca,'YMinorGrid','on','YMinorTick','on');
% set(hleg1,'Location','NorthEast')
% set(hleg1,'FontSize',6)
% set(gca,'XMinorGrid','on','XMinorTick','on');
set(gca,'FontSize',10);
% text(Xlabel, trainRetrieve,'\rightarrow sin(-\pi\div4)',...
%      'HorizontalAlignment','right')
set(gca,'YTick',0:0.1:1);
% set(gca,'YTick', [200,400,600,800,1000,1200,1400,1600,1800,2000,2200,2381])
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');
% yl = ylabel('Precision');
set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');
% set(yl,'FontSize',14,'FontWeight','bold','FontName','Courier');
% set(get(gca,'ylabel'),'Rotation',180);

axis([0 1 0 1])