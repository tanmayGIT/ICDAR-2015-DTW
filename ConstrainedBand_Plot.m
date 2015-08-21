clear all;
% close all;
clc;
load('tkArr2GW_SCUpdated.mat');
tkArr2Itekura = tkArr2GW_SC;
for ii = 1:1:length(tkArr2Itekura)
    allAccuracyArr = tkArr2Itekura{ii,1};
    allAccuracyArr = cellToArrForPlot(allAccuracyArr);
    [X13,Y13,Z13,M13]  = plotAccuracyGraph(allAccuracyArr);
    figure();
    h(1) = subplot(1,1,1);
    q = plot(Z13,Y13,'k');
    hleg1 = legend(num2str(tkArr2Itekura{ii,2}));
    hold on;
    clear allAccuracyArr;
end
% hleg1 = legend('SSDTW','PDTW','PDDTW','J-DTW','CDP','DTW','DTW-CW','WDTW','WDDTW','WDDTWgh');

line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',7.2)
set(hleg1,'Location','NorthEast')
set(gca,'FontSize',10);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');
yl = ylabel('Precision');
set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');
set(yl,'FontSize',14,'FontWeight','bold','FontName','Courier');
set(get(gca,'ylabel'),'Rotation',180);

axis([0 1 0 1])

load('tkArr2.mat');
figure();
h(1) = subplot(1,1,1);
for ii = 6:1:length(tkArr2)
    allAccuracyArr = tkArr2{ii,1};
    allAccuracyArr = cellToArrForPlot(allAccuracyArr);
    [X13,Y13,Z13,M13]  = plotAccuracyGraph(allAccuracyArr);
    q = plot(Z13,Y13,'k');
    hold on;
    clear allAccuracyArr;
end
hleg1 = legend('SSDTW','PDTW','PDDTW','J-DTW','CDP','DTW','DTW-CW','WDTW','WDDTW','WDDTWgh');
line([0 1],[0 1],'LineWidth',1, 'LineStyle','--'),hold on
hold off;

set(hleg1,'Location','NorthEast')
set(hleg1,'FontSize',7.2)
set(hleg1,'Location','NorthEast')
set(gca,'FontSize',10);
set(gca,'YTick',0:0.1:1);
set(gca,'YTickLabel',{'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0'})

xl = xlabel('Recall');
yl = ylabel('Precision');
set(xl,'FontSize',12,'FontWeight','bold','FontName','Courier');
set(yl,'FontSize',14,'FontWeight','bold','FontName','Courier');
set(get(gca,'ylabel'),'Rotation',180);

axis([0 1 0 1])