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

load('WDDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X6,Y6,Z6,M6]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('WDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X7,Y7,Z7]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('PDDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X8,Y8,Z8,M8]  = plotAccuracyGraph(allAccuracyArr);

load('JawaharDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X9,Y9,Z9,M9]  = plotAccuracyGraph(allAccuracyArr);

load('CDP1_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X10,Y10,Z10,M10]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('DTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X11,Y11,Z11,M11]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('DTW_CW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X12,Y12,Z12,M12]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('PDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X13,Y13,Z13,M13]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('DDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X14,Y14,Z14,M14]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('MVM_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X15,Y15,Z15,M15]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('SSDTW_Old_Normalize_columnFeature_makeDoubleHeight.mat');
allAccuracyArr = cellToArrForPlot(allAccuracyArr);
[X16,Y16,Z16,M16]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

load('tkArr2.mat'); % SC_Band
allAccuracyArr = cellToArrForPlot(tkArr2{4,1});
[X17,Y17,Z17,M17]  = plotAccuracyGraph(allAccuracyArr);
clear allAccuracyArr;

figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.75 0.75 0];...
  [1 0.50 0.25];[0.75 0 0.75];[0.7 0.7 0.7];[0.8 0.7 0.6];[0.6 0.5 0.4 ]};

q = plot(Z12,Y12,'r-',Z13,Y13,'m-',Z8,Y8,'b-',...
    Z9,Y9,'g-',Z10,Y10,'c-',Z11,Y11,'k-');

hold on;
plot(Z6,Y6,'Color', colorspec{3});
hold on;
plot(Z7,Y7,'Color', colorspec{7});
hold on;
plot(Z14,Y14,'Color', colorspec{11});
hold on;
plot(Z15,Y15,'Color', colorspec{10});
hold on;
plot(Z16,Y16,'Color', colorspec{8});
hold on;
plot(Z17,Y17,'Color', colorspec{6});
hleg1 = legend('DTW-CW','PDTW','PDTW','MJ-DTW','CDP','DTW','WDTW','WDDTW','DDTW','MVM','SSDTW','SC-Band');


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