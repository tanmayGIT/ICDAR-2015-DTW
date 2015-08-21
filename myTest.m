clear all;
close all;
clc;
g = 0.05;
Wmax = 20;
totEle = 1000;
cenEle = round(totEle/2);

Y = zeros(totEle,1);
cnt = 1;

for i = 1:1:totEle
Y(cnt,1) = Wmax ./ (1.0 + (exp(-g*(i - cenEle))) );
cnt = cnt +1;
end

X = [1:totEle];
X = X';
plot(X,Y);
axis([0 totEle 0 Wmax])