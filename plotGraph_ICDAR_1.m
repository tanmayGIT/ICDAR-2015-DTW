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
figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.6 0.8 0.2];...
  [0.4 0.58 0.9];[0.75 0 0.75];[0.72 0.52 0.04];[0.8 0.7 0.6];[0.6 0.5 0.4 ];...
  [0.8 0.6 1 ];[0 1 1];[0.619 1 0.4 ];[1 0.6 0.8]};

q = plot(Z4,Y4,'m--');
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