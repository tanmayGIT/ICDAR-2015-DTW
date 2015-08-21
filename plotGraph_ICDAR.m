clear all;
% close all;
clc;

load('5_LDTWICDAR.mat');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp('5_LDTWICDAR');
disp(mean_avg_pre);
[X4,Y4,Z4,M4]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('DTWICDAR.mat');
disp('DTWICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X6,Y6,Z6,M6]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('PDTWICDAR.mat');
disp('PDTWICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X7,Y7,Z7]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('3_LDTWICDAR.mat');
disp('3_LDTWICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X8,Y8,Z8]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('Itekura_BandICDAR.mat');
disp('Itekura_BandICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X9,Y9,Z9]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('SSDTWICDAR.mat');
disp('SSDTWICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X10,Y10,Z10]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('CDP1ICDAR.mat');
disp('CDP1ICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X11,Y11,Z11]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('PDDTWICDAR.mat');
disp('PDDTWICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X13,Y13,Z13]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

load('DDTWICDAR.mat');
disp('DDTWICDAR');
[allAccuracyArr,mytotarr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
disp(mean_avg_pre);
[X14,Y14,Z14]  = plotAccuracyGraph_2(mytotarr);
clear allResult;
clear allAccuracyArr;

figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.6 0.8 0.2];...
  [0.4 0.58 0.9];[0.75 0 0.75];[0.72 0.52 0.04];[0.8 0.7 0.6];[0.6 0.5 0.4 ];...
  [0.8 0.6 1 ];[0 1 1];[0.619 1 0.4 ];[1 0.6 0.8]};

q = plot(Z4,Y4,'m--',Z6,Y6,'b-',Z7,Y7,'k--',Z8,Y8,'r-',Z9,Y9,'c-',Z10,Y10,'g-');
hold on;
plot(Z11,Y11,'Color', colorspec{3});
hold on;
plot(Z13,Y13,'Color', colorspec{9});
hold on;
plot(Z14,Y14,'Color', colorspec{17});
hold on;
hleg1 = legend('5-LDTW','DTW','PDTW','3-LDTW','Itekura Band','SSDTW','CDP','PDDTW','DDTW');


line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',9)

set(gca,'FontSize',7);

set(gca,'YTick',0:0.1:1);

set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');

set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');
axis([0 1 0 1])