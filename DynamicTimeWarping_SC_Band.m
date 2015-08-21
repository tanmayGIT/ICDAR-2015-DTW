function [DistanceVal,indxCol,indxRw] = DynamicTimeWarping_SC_Band(refSample,testSample,percent)
SC_Radius = size(testSample,1) -  size(refSample,1);

% global percent
%*******************
SC_Radius = round((size(refSample,1)*percent)/100);

[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

if(N == M) % each set containing same no. of feature
    % check whether SC-Band will actually valid or not 
    endLimit = (min((noOfSamplesInRefSample + SC_Radius),noOfSamplesInTestSample));
    if(endLimit < noOfSamplesInTestSample) % it means the SC- band does not reach uptill the bottom right of the matrix 
        DistanceVal = -5;
        indxCol = 0;
        indxRw = 0;
        return;
    end
    
   Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
   for i=1:noOfSamplesInRefSample % xSize
        for j= (max((i-SC_Radius),1)):1:(min((i+SC_Radius),noOfSamplesInTestSample)) %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                 total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            Dist(i,j) =  sqrt(sum(total));
        end
    end
    
    D=Inf(size(Dist));
    D(1,1)=Dist(1,1);

    for n = 2:1:(min(SC_Radius,noOfSamplesInRefSample))
        D(n,1)=Dist(n,1)+D(n-1,1);
    end
    for m = 2:1:(min(SC_Radius,noOfSamplesInTestSample))
        D(1,m)=Dist(1,m)+D(1,m-1);
    end
    for n = 2:noOfSamplesInRefSample
        for m = (max((n-SC_Radius),2)):1:(min((n+SC_Radius),noOfSamplesInTestSample))
            D(n,m)=Dist(n,m)+min([D(n-1,m),(min([D(n-1,m-1),D(n,m-1)]))]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central 
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
            [~,place] = min([D(X-1,Y),D(X,Y-1),D(X-1,Y-1)]);
            switch place
                case 1
                    X = X-1;
                case 2
                    Y = Y-1;
                case 3
                    X = X-1;
                    Y = Y-1;
            end
        end
        k=k+1; % The number of steps it took to come to the place [1,1]
        Wrapped = cat(1,Wrapped,[X,Y]);
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
