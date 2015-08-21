function mean_avg_pre = meanAveragePrecision(allAccuracyArr)
mean_avg_pre  = 0;
for i=1:1:size(allAccuracyArr,1) 
    temp_data = allAccuracyArr{i,1};
    avgPrecision = 0;
    for j = 1:1:size(temp_data,1)
        avgPrecision = avgPrecision  + temp_data(j,1)*temp_data(j,4);
    end
    avgPrecision = avgPrecision/allAccuracyArr{i,2};
    mean_avg_pre  = mean_avg_pre + avgPrecision;
end
mean_avg_pre = mean_avg_pre/length(allAccuracyArr) ;
return;
end