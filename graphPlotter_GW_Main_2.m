clear all;
% close all;
clc;

load('OSBGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X1,Y1,Z1,M1]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('OSB');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('LCSSGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X5,Y5,Z5,M5]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('LCSS');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('CDP1GW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X10,Y10,Z10,M10]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('CDP');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('DTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X11,Y11,Z11,M11]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('MVMGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X15,Y15,Z15,M15]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('MVM');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('SSDTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X16,Y16,Z16,M16]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('SSDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('DTW_CWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X12,Y12,Z12,M12]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DTW-CW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('JawaharDTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X9,Y9,Z9,M9]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('JawaharDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.6 0.8 0.2];...
  [0.4 0.58 0.9];[0.75 0 0.75];[0.72 0.52 0.04];[0.8 0.7 0.6];[0.6 0.5 0.4 ];...
  [0.8 0.6 1 ];[0 1 1];[0.619 1 0.4 ];[1 0.6 0.8]};

% plot(Z1,Y1,'r-',Z2,Y2,'b-',Z3,Y3,'m-',Z4,Y4,'c-',Z5,Y5,'g-.',Z10,Y10,'k-');
plot(Z1,Y1,'c-',Z5,Y5,'r-',Z10,Y10,'m-',Z11,Y11,'k-',Z15,Y15,'b-',Z16,Y16,'g-');
hold on;
plot(Z12,Y12,'Color', colorspec{17});
hold on;
plot(Z9,Y9,'Color', colorspec{3});
hold on;
% hleg1 = legend('OSB','Fast-DTW','SC-Band','Itekura-Band','LCSS','CDP');

hleg1 = legend('OSB (0.2785)','LCSS (0.0032)','CDP (0.3619)','DTW (0.4557)','MVM (0.2026)','SSDTW (0.3349)','DTW-CW (0.3603)','MJ-DTW (0.3413)');

line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',7.2)
set(gca,'FontSize',10);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');

set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');
axis([0 1 0 1])