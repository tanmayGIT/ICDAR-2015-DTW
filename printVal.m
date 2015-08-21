function printVal(X81,Y81,Z81,M81,feature)
[~,r]= max(M81);
disp(feature);
disp('Precision');
disp(Y81(r,1));
disp('Recall');
disp(Z81(r,1));
disp('Fscore');
disp(M81(r,1));
disp('Location');
disp(X81(r,1));
end