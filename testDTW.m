% This algorithm is about checking MVM algorithm with a set of numbers
clear all;
% close all;
clc;

query1 = [1,2,8,16,16]';
target1 = [1,2,9,16,9,25,37]';

query2 = [1,2,8,4,6,8,5,6,7]';
target2 = [1,2,3,8,6,8,9,12,8]';

query3 = [1,2,8,8,8]';
target3 = [1,2,9,95,79,26,39,31]';

query4 = [1,2,8,8]';
target4 = [1,2,95,95,95,8,8]';

queryIso = [-0.6,4.6,-6.4,-22.3,0.9,0.4,0.3,9,12]';
targetIso = [0.1,5.3,-5.8,-22.1,1.5,0.7,0.4,9.2]';

% refWordMat = [1 2 8 16]';
% testWordMat = [1 2 9 9 9 16]';

% refWordMat = [1 2 8 4 6 8 5 6 7]';
% testWordMat = [1 2 3 8 6 8 9 12 8]';

% refWordMat = [1 2 8 6 8]';
% testWordMat = [1 2 9 3 3 5 9]';

% refWordMat =  [1 2 8 8]';
% testWordMat = [1 95 2 95 8 95 8 95]';

% refWordMat =  [1 2 8 16 81]';
% testWordMat = [1 2 9 9 9 25 81]';

% refWordMat = [1 2 8 8 8]';
% testWordMat = [1 2 9 95 79 26 39 31]';
 
% refWordMat = [2 8 6 8]';
% testWordMat = [2 9 5 3 5 9]';

refWordMat = [2 8 6 8 4 5 6]';
testWordMat = [2 8 6 8 66 565 4 5 6]';
 
% refWordMat = [11 1 29 4 6 9 22 79 36]';
% testWordMat = [77 22 9 21 5 27 3 19 25 5 8 63 31]';

% refWordMat = [11 1 29 4 6 9 22 22 22]';
% testWordMat = [77 22 9 21 5 27 3 19 25 5 8 63 31]';
 
% OSB_Updated_1(refWordMat,testWordMat,2);
% OSBv5(refWordMat,testWordMat,2,2,2);

% [Dist,indexRw, indexCol] = WDTW(refWordMat,testWordMat);

[min_distance,indxRw1,indxCol1] = IsometricDynamicTimeWarping(queryIso,targetIso,1);


%  refWordMat = fg;
%  testWordMat = tf;
% tic
% [indxcol,indxrow,distSum]  = fastDTW(refWordMat,testWordMat,5);
% toc

% [~,~,indxcol,indxrow,distSum]  = MVM_Updated_7(query3,target3,1);

% [~,~,indxcol,indxrow,distSum]  = MinimalVarianceMatching(refWordMat,testWordMat,1);
% tic
 [DistanceVal,indxCol,indxRw]  = DynamicTimeWarping(queryIso,targetIso,1);
 disp('see me');
% toc

