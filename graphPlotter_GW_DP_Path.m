clear all;
% close all;
clc;
load('0_SymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X6,Y6,Z6,M6]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('0_Symmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('0_ASymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X7,Y7,Z7,M7]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('0_Asymmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('1_SymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X8,Y8,Z8,M8]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('1_Symmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;


load('1_AsymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X9,Y9,Z9,M9]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('1_Asymmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;


load('2_SymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X10,Y10,Z10,M10]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('2_Symmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('2_AsymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X11,Y11,Z11,M11]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('2_Asymmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('3_LDTWGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X12,Y12,Z12,M12]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('3_LDTW');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;

load('4_SomethingNewGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X13,Y13,Z13,M13]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('4_Something');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;


load('50_SymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X15,Y15,Z15,M15]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('50_Symmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;


load('50_AsymmetricGW_Result.mat');
[allResult,RefallAccuracyArr] = cellToArrForPlot(allResult);
mean_avg_pre = meanAveragePrecision(allResult);
[X16,Y16,Z16,M16]  = plotAccuracyGraph_2(RefallAccuracyArr);
disp('50_Asymmetric');
disp(mean_avg_pre);
clear allResult;
clear RefallAccuracyArr;



figure();
h(1) = subplot(1,1,1);

colorspec = {[0.9 0.9 0.9]; [0.8 0.8 0.8]; [0.6 0.6 0.6]; ...
  [0.4 0.4 0.4]; [0.2 0.2 0.2];[0 0.75 0.75];[0 0.5 0];[0.75 0.75 0];...
  [1 0.50 0.25];[0.75 0 0.75];[0.7 0.7 0.7];[0.8 0.7 0.6];[0.6 0.5 0.4 ]};

q = plot(Z6,Y6,'r-.',Z7,Y7,'r-',Z8,Y8,'b-.',...
    Z9,Y9,'b-',Z10,Y10,'c-.',Z11,Y11,'c-',Z12,Y12,'g-',Z13,Y13,'m-',Z15,Y15,'k-.',Z16,Y16,'k-');
hold on;

hleg1 = legend('0-Sym (0.3668)','0-Asym (0.4576)','1-Sym (0.3074)','1-Asym (0.2188)','2-Sym (0.2038)','2-Asym (0.1936)','LDTW (0.5374)','3-Symm (0.4324)','0.5-Sym (0.2776)','0.5-Asym (0.4642)');


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
disp('see me');