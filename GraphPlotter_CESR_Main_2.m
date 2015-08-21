clear all;
% close all;
clc;

load('OSB_Old_Normalize_columnFeature_makeDoubleHeightFinal.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(RefallAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X1,Y1,Z1,M1]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('OSB');
disp(mean_avg_pre);
clear RefallAccuracyArr
clear allAccuracyArr

load('LCSS_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X5,Y5,Z5,M5]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('LCSS');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('CDP1_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X10,Y10,Z10,M10]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('CDP');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr

load('MVM_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X15,Y15,Z15,M15]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('MVM');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('SSDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X16,Y16,Z16,M16]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('SSDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('DTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X11,Y11,Z11,M11]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('JawaharDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X9,Y9,Z9,M9]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('JawaharDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('DTW_CW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X12,Y12,Z12,M12]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DTW_CW');
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
plot(Z1,Y1,'c-',Z5,Y5,'r-',Z10,Y10,'m-',Z15,Y15,'b-',Z16,Y16,'g-',Z11,Y11,'k-');
hold on;
plot(Z9,Y9,'Color', colorspec{3});
hold on;
plot(Z12,Y12,'Color', colorspec{17});
hold on;
% hleg1 = legend('OSB','Fast-DTW','SC-Band','Itekura-Band','LCSS','CDP');
hleg1 = legend('OSB (0.7982)','LCSS (0.1554)','CDP (0.9176)','MVM (0.5168)','SSDTW (0.8409)','DTW (0.8486)','MJ-DTW (0.7779)','DTW-CW (0.8756)');

line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthWest')
set(hleg1,'FontSize',7.2)
set(gca,'FontSize',10);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');

set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');
axis([0 1 0 1])