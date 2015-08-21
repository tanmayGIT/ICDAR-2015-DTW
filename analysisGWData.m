clear all
close all
clc;
load makeWordCluster.mat;
cnt = 1;
totlen = 0;
goodlen = 0;
for ii = 1:1:size(makeWordCluster,1)
    len = length(makeWordCluster{ii,3});
    totlen = totlen + len;
    if( (makeWordCluster{ii,4} >3) )
        if((len >=10))
            cnt = cnt+1;
            goodlen = goodlen + len;
        end
    end
end
disp(cnt);
disp(totlen);
disp(goodlen);