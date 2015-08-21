function [DistanceVal] = FTW(D_refData,D_targetData)
[Target_Row, Target_Col] = size(D_targetData);
[Ref_Row, Ref_Col] = size(D_refData);

N = Ref_Col;
M = Target_Col;
noOfSamplesInTestSample = Target_Row;
noOfSamplesInRefSample = Ref_Row;

if(N == M) % each set containing same no. of feature
    Dist = Inf(noOfSamplesInTestSample,noOfSamplesInRefSample); % Initializing the array
    keepMinLen = Inf(noOfSamplesInTestSample,noOfSamplesInRefSample); % Initializing the array
    for j=1:noOfSamplesInTestSample %ySize
        for i=1:noOfSamplesInRefSample % xSize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                if(D_targetData{i,goFeature}(1,1) > D_refData{i,goFeature}(1,2))
                    total(goFeature,1) = mod(D_targetData{i,goFeature}(1,1) - D_refData{i,goFeature}(1,2));
                    total(goFeature,2) = min(D_targetData{i,goFeature}(1,3),D_refData{i,goFeature}(1,3));
                elseif(D_refData{i,goFeature}(1,1) > D_targetData{i,goFeature}(1,1))
                    total(goFeature,1) = mod(D_refData{i,goFeature}(1,1) - D_targetData{i,goFeature}(1,2));
                    total(goFeature,2) = min(D_targetData{i,goFeature}(1,3),D_refData{i,goFeature}(1,3));
                end
            end
            Dist(i,j) =  sum(total(:,1));
            keepMinLen(i,j) = min(total);
        end
    end
else
    return;
end
end
function [DistanceVal] = earlyStopping(P_A,Q_A,Dist,d_cb)
[targetRw,targetCol] = size(P_A);
[refRw,refCol] = size(Q_A);
if(targetCol ~= refCol)
    error('The number of features dimention are not same');
end
% Set the initial values of begin(i) and end(i) according to the global constraint
beginMe = Inf(targetRw,1);
endMe = Inf(targetRw,1);
for ii = 1:1:targetRw
    beginMe(1,ii) = 1;
    endMe(1,ii) = refRw;
end
D = Inf(size(Dist));
D(1,1) = 0;

for in = 2:1:targetRw
    for jm = beginMe(1,in):1:endMe(1,in)
        g_cell = Dist(in,jm) * keepMinLen(in,jm);
        D(in,jm) = g_cell + min([D(in-1,jm),(min([D(in-1,jm-1),D(in,jm-1)]))]);
        if ( (in ~= 1) && (in ~= noOfSamplesInTestSample) )
            if ( (jm > endMe(1,in-1)) && (D(in,jm) > d_cb) )
                endMe(1,in) = jm;
                break;
            end
        end
    end
    if (isempty(find(D(in,:) <= d_cb, 1)))
        DistanceVal = D(in,endMe(1,in));
        return ;
    else
        goodIndex = (find(D(in,:) <= d_cb, 1));
        beginMe(1,in) = min(goodIndex);
        endMe(1,in) = max(goodIndex);
        if ( (in ~= refRw) && (beginMe(1,in+1) < beginMe(1,in)) )
            beginMe(1,in+1) = beginMe(1,in);
        end
    end
end
DistanceVal = (D(noOfSamplesInTestSample,noOfSamplesInRefSample)) ;
end
