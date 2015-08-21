clear all;
% close all;
clc;

load('0_Asymmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X6,Y6,Z6,M6]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('0_Asymmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('0_Symmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X7,Y7,Z7] = plotAccuracyGraph_2(RefallAccuracyArr);
disp('0_Symmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('1_Asymmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X8,Y8,Z8,M8]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('1_Asymmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('1_Symmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X9,Y9,Z9,M9]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('1_Symmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('2_Asymmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X10,Y10,Z10,M10]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('2_Asymmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('2_Symmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X11,Y11,Z11,M11]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('2_Symmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('3_LDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X12,Y12,Z12,M12]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('3_LDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('4_SomethingNew_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X13,Y13,Z13,M13]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('4_SomethingNew');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('50_Asymmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X15,Y15,Z15,M15]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('50_Asymmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('50_Symmetric_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X16,Y16,Z16,M16]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('50_Symmetric');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.6 0.8 0.2];...
  [0.4 0.58 0.9];[0.75 0 0.75];[0.72 0.52 0.04];[0.8 0.7 0.6];[0.6 0.5 0.4 ];...
  [0.8 0.6 1 ];[0 1 1];[0.619 1 0.4 ];[1 0.6 0.8]};

q = plot(Z6,Y6,'r-',Z7,Y7,'r-.',Z8,Y8,'b-',...
    Z9,Y9,'b-.',Z10,Y10,'c-',Z11,Y11,'c-.',Z12,Y12,'g-',Z13,Y13,'m-',Z15,Y15,'k-',Z16,Y16,'k-.');
hold on;

% plot(Z16,Y16,'Color', colorspec{8});
% hold on;
hleg1 = legend('0-Asym (0.8503)','0-Sym (0.6449)','1-Asym (0.220)','1-Sym (0.6922)','2-Asym (0.2029)','2-Sym (0.5512)','LDTW (0.7577)','3-Symm (0.8515)','0.5-Asym (0.8402)','0.5-Sym (0.7168)');

line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','SouthWest')
set(hleg1,'FontSize',7.2)

set(gca,'FontSize',10);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');
set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');

axis([0 1 0 1])