clear all;
% close all;
clc;


load('DTWGW_Result.mat');
allResult = cellToArrForPlot(allResult);
[X8,Y8,Z8,M8]  = plotAccuracyGraph(allResult);

load('OSBGW_Result.mat');
allResult = cellToArrForPlot(allResult);
[X9,Y9,Z9,M9]  = plotAccuracyGraph(allResult);

load('CDP1GW_Result.mat');
allResult = cellToArrForPlot(allResult);
[X11,Y11,Z11,M11]  = plotAccuracyGraph(allResult);
clear allResult;

load('MVMGW_Result.mat');
allResult = cellToArrForPlot(allResult);
[X12,Y12,Z12,M12]  = plotAccuracyGraph(allResult);
clear allResult;

load('MVM_Updated_12GW_Result.mat');
allResult = cellToArrForPlot(allResult);
[X13,Y13,Z13,M13]  = plotAccuracyGraph(allResult);
clear allResult;

load('MVM_Updated_17GW_Result.mat');
allResult = cellToArrForPlot(allResult);
[X14,Y14,Z14,M14]  = plotAccuracyGraph(allResult);
clear allResult;

figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.6 0.8 0.2];...
  [0.4 0.58 0.9];[0.75 0 0.75];[0.72 0.52 0.04];[0.8 0.7 0.6];[0.6 0.5 0.4 ];...
  [0.8 0.6 1 ];[0 1 1];[0.619 1 0.4 ];[1 0.6 0.8]};

q = plot(Z8,Y8,'c-',Z9,Y9,'r-',Z11,Y11,'m-',Z12,Y12,'b-',...
    Z13,Y13,'k-',Z14,Y14,'g-');

hleg1 = legend('DTW','OSB','CDP','MVM','FSM','ESC');


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