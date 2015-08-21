function [DistanceVal,indxCol,indxRw] = IsometricTransformDTW(Data_Ref,Data_Target,method)
if(strcmp(method,'sine'))
    D_targetData = dst(Data_Target);
    D_refData = dst(Data_Ref);
elseif(strcmp(method,'cos'))
    D_targetData = dct(Data_Target);
    D_refData = dct(Data_Ref);
elseif(strcmp(method,'hilbert'))
    D_targetData = hilbert(Data_Target);
    D_refData = hilbert(Data_Ref);
end

[Target_Row, Target_Col] = size(D_targetData);
[Ref_Row, Ref_Col] = size(D_refData);

N = Ref_Col;
M = Target_Col;
noOfSamplesInTestSample = Target_Row;
noOfSamplesInRefSample = Ref_Row;


if(N == M) % each set containing same no. of feature
    
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            Dist(i,j) =  sqrt(sum(total));
        end
    end
    
    D=Inf(size(Dist));
    D(1,1)=Dist(1,1);
    
    for n=2:noOfSamplesInRefSample
        D(n,1)=Dist(n,1)+D(n-1,1);
    end
    for m=2:noOfSamplesInTestSample
        D(1,m)=Dist(1,m)+D(1,m-1);
    end
    for n=2:noOfSamplesInRefSample
        for m=2:noOfSamplesInTestSample
            D(n,m)=Dist(n,m)+min([D(n-1,m-1),D(n,m-1),D(n-1,m)]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central
        end
    end
    
    % Once the accumulated cost matrix built the warping path could be found
    % by the simple backtracking from the point pEnd = (M,N) to the pstart=(1,1)
    % following the greedy strategy as described by the below Algorithm; ref:
    % "Dynamic Time Warping Algorithm Review" by Pavel Senin
    
    X = noOfSamplesInRefSample;
    Y = noOfSamplesInTestSample;
    k=1;
    Wrapped(1,:)=[X,Y];
    while ((X>1)||(Y>1))
        if ((X-1)==0)
            Y = Y-1;
        elseif ((Y-1)==0)
            X = X-1;
        else
            [~,place] = min([D(X-1,Y-1),D(X,Y-1),D(X-1,Y)]);
            switch place
                case 1
                    X = X-1;
                    Y = Y-1;
                case 2
                    Y = Y-1;
                case 3
                    X = X-1;
            end
        end
        k=k+1; % The number of steps it took to come to the place [1,1]
        Wrapped = cat(1,[X,Y],Wrapped);
    end
    indxRw =  Wrapped(:,1);%1:(size(refSample,1));
    %  indxRw = indxRw';
    indxCol = Wrapped(:,2);%1:(size(testSample,1));
    %  indxCol = indxCol';
    DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
    
else
    return;
end
end
function changedSignal = hilbert(signal)
changedSignal = Inf(size(signal));
for jj = 1:1:size(signal,2)
    for ii = 1:1:size(signal,1)
        mySum = 0;
        for tt  = 1:1:size(signal,1)
            if( tt ~= ii)
                mySum = mySum + signal(tt,jj)/(ii-tt);
            end
        end
        changedSignal(ii,jj) = mySum;
    end
end
return;
end
