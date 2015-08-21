function [DistanceVal,indxCol,indxRw] = subsequenceDynamicTimeWarping(refSample,testSample,straight)

[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);
global JC
global sJC

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
        D(1,m)=Dist(1,m);%+D(1,m-1);
    end
    for n=2:noOfSamplesInRefSample
        for m=2:noOfSamplesInTestSample
            D(n,m)=Dist(n,m)+min([D(n-1,m),(min([D(n-1,m-1),D(n,m-1)]))]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central
        end
    end
    
    
    
    % Once the accumulated cost matrix built the warping path could be found
    % by the simple backtracking from the point pEnd = (M,N) to the pstart=(1,1)
    % following the greedy strategy as described by the below Algorithm; ref:
    % "Dynamic Time Warping Algorithm Review" by Pavel Senin
    
    X = noOfSamplesInRefSample;
    [~,indxSh] = min(D(X,X:end));
    Y = (X-1)+indxSh;  % indxSh
    k=1;
    Wrapped(1,:)=[X,Y];
    while ((X>1)&&(Y>1))
        
        if ((X-1)==0) % for this line it will ignore the left side elements. When you have come to 1st row then finish
            break;
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
    indxRw = flipud(indxRw);
    %  indxRw = indxRw';
    indxCol = Wrapped(:,2);%1:(size(testSample,1));
    indxCol = flipud(indxCol);
    %  indxCol = indxCol';
    DistanceVal = (D(indxRw(end,1),indxCol(end,1)))/ length(indxCol) ;
    if (straight == 2)
        DistanceVal = DistanceVal + ( (   (indxCol(1,1)-1) + (noOfSamplesInTestSample - indxCol(1,1)) ) * JC );
    end
else
    return;
end
end
