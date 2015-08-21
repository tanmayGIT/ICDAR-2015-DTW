function [X,Y,Z,M,highIndex]  = plotAccuracyGraph_2(storResultOfAllRef)
samplingRate = 0:0.01:1;
keepAllInterpol = cell(1,1);
for eachQuery = 1:1:length(storResultOfAllRef)
    cellEntry = storResultOfAllRef{eachQuery,1};
    [xVal,index] = sort(cellEntry(:,2));
    yVal = cellEntry(index,1);
    % remove redundancy
    nonRedunXY = zeros(1,1);
    goodCnt = 1;
    for allx = 1:1:length(xVal)
        if(allx == 1)
            nonRedunXY(goodCnt,1) = xVal(allx,1);
            nonRedunXY(goodCnt,2) = yVal(allx,1);
            nonRedunXY(goodCnt,3) = 1;
            goodCnt = goodCnt +1;
        else
            if(nonRedunXY(goodCnt-1,1) == xVal(allx,1) )
                nonRedunXY(goodCnt-1,2) = nonRedunXY(goodCnt-1,2) + yVal(allx,1);
                nonRedunXY(goodCnt-1,3) = nonRedunXY(goodCnt-1,3) + 1;
            else
                nonRedunXY(goodCnt,1) = xVal(allx,1);
                nonRedunXY(goodCnt,2) = yVal(allx,1);
                nonRedunXY(goodCnt,3) = 1;
                goodCnt = goodCnt +1;
            end
        end
    end
    nonRedunXY(:,2) = nonRedunXY(:,2)./ nonRedunXY(:,3);
    interpolatedVal = interp1(nonRedunXY(:,1),nonRedunXY(:,2),samplingRate);
    interpolatedVal = interpolatedVal';
    interpolatedVal(1,1) = 0;
    % replace value of precision by 0 when recall is 0 and then all NaN presion by the first value of precision
    getFiniteIndex = 0;
    for ght = 2:1:length(interpolatedVal)
        if (isfinite(interpolatedVal(ght,1)))
            getFiniteIndex = ght;
            break;
        end
    end
    interpolatedVal(2:(getFiniteIndex-1),1) = interpolatedVal(getFiniteIndex,1);
    interpolatedVal(:,2) = samplingRate;
    keepAllInterpol{eachQuery,1} = interpolatedVal;
    keepAllInterpol{eachQuery,2} = nonRedunXY;
    keepAllInterpol{eachQuery,3}{1,1} = xVal;
    keepAllInterpol{eachQuery,3}{1,2} = yVal;
end
makeAvg = zeros(length(samplingRate),2);
for eachSampling = 1:1:length(samplingRate)
    nanCnt = 0;
    for eachQuery = 1:1:length(keepAllInterpol) % for each query image 
        if((~isnan(keepAllInterpol{eachQuery,1}(eachSampling,1)))  && ...
            ((keepAllInterpol{eachQuery,1}(eachSampling,1)) ~= 0) )
        
            makeAvg(eachSampling,1) = makeAvg(eachSampling,1) + keepAllInterpol{eachQuery,1}(eachSampling,1);
            makeAvg(eachSampling,2) = makeAvg(eachSampling,2) + keepAllInterpol{eachQuery,1}(eachSampling,2);
            nanCnt = nanCnt +1;
        elseif ((isnan(keepAllInterpol{eachQuery,1}(eachSampling,1))))
            if(eachSampling == 1)
                error('The value should not be NaN or 0 ')
            end
        end
    end
    makeAvg(eachSampling,3) = nanCnt;
end
makeAvg(1:end,1) = makeAvg(1:end,1)./makeAvg(1:end,3);
makeAvg(1:end,2) = makeAvg(1:end,2)./makeAvg(1:end,3);

% remove the NAN values
refinedMeanAvg = zeros(1,3);
simpleCnt = 1;
for ij = 1:1:size(makeAvg,1)
    if(~isnan(makeAvg(ij,2))) 
       refinedMeanAvg(simpleCnt,1) = makeAvg(ij,1);
       refinedMeanAvg(simpleCnt,2) = makeAvg(ij,2);
       calP = refinedMeanAvg(simpleCnt,1);
       calR = refinedMeanAvg(simpleCnt,2);
       fMeasure = (2*calP*calR)/(calP+calR);
       refinedMeanAvg(simpleCnt,3) = fMeasure;
       simpleCnt = simpleCnt +1;
%     else
%         error('The NaN can not exists here');
    end
end
highIndex = size(refinedMeanAvg,1);
X = (1:highIndex);
X = X';
Y = refinedMeanAvg(:,1);
Z = refinedMeanAvg(:,2);
M = refinedMeanAvg(:,3) ;
end