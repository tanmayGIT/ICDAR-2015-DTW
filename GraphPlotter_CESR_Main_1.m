clear all;
% close all;
clc;
% load('arra4.mat');
% myArrt = arra4;
% storFMesure = zeros(length(myArrt),1);
% for i=1:1:length(myArrt)
%     cellVal = myArrt{i,1}{1,1};
%     totCellLen = length(cellVal);
%     
%     myArr = cellVal;
%     width = 3;
%     onlyArr = zeros(length(myArr),width);
%     for iu = 1:1:length(myArr)
%         onlyArr(iu,1) = myArr{iu,1};
%         onlyArr(iu,2) = myArr{iu,2};
%         onlyArr(iu,3) = myArr{iu,3};
%     end
%     totlArr = onlyArr;
%     maxFMeasure = max(totlArr(:,3));
%     storFMesure(i,1) = maxFMeasure;
% end
% [val,Index] = sort(storFMesure);
% X = 1:10;
% Y = storFMesure;
% figure,plot(X,Y);
load('FastDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X2,Y2,Z2,M2]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('FastDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('tkArr2.mat'); % SC_Band
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(tkArr2{4,1});
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X3,Y3,Z3,M3]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('SC-Band');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('Itekura_Band_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X4,Y4,Z4,M4]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('Itekura_Band');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('WDDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X6,Y6,Z6,M6]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('WDDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('WDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X7,Y7,Z7]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('WDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('PDDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X8,Y8,Z8,M8]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('PDDTW');
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

load('PDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X13,Y13,Z13,M13]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('PDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
clear RefallAccuracyArr;

load('DDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
[allAccuracyArr,RefallAccuracyArr] = cellToArrForPlot(allAccuracyArr);
mean_avg_pre = meanAveragePrecision(allAccuracyArr);
[X14,Y14,Z14,M14]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('DDTW');
disp(mean_avg_pre);
clear allAccuracyArr;
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
plot(Z11,Y11,'Color', colorspec{7});
hold on;
plot(Z13,Y13,'Color', colorspec{17});
hold on;
plot(Z14,Y14,'Color', colorspec{10},'LineStyle','-');
hold on;
% plot(Z16,Y16,'Color', colorspec{16},'LineStyle','-')

hleg1 = legend('Fast-DTW (0.7806)','SC-Band (0.7961)','Itakura-Band (0.8013)','WDDTW (0.2319)','WDTW (0.5854)','PDDTW (0.9564)','DTW (0.8486)','PDTW (0.8929)','DDTW (0.5645)');


line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthWest')
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