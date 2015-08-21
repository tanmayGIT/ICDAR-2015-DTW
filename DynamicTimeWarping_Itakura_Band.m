function [DistanceVal,indxCol,indxRw] = DynamicTimeWarping_Itakura_Band(refSample,testSample,intekura_Radius)
% intekura_Radius = size(testSample,1) -  size(refSample,1);
% 
% 
% 
% %**************
% intekura_Radius = round(size(testSample,1) /2);






[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);
% intekura_Radius = min(noOfSamplesInRefSample,noOfSamplesInTestSample);
if(N == M) % each set containing same no. of feature
    
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    for i=1:noOfSamplesInRefSample % xSize
        for j= 1:1:noOfSamplesInTestSample%ySize
%             bool = checkTheLimit(i,j,noOfSamplesInRefSample,noOfSamplesInTestSample);
%             if(bool ==1)
                total = zeros(N,1);
                for goFeature=1:N %or M as N & M are same
                    total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
                end
                Dist(i,j) =  sqrt(sum(total));
%             end
        end
    end
    
    D=Inf(size(Dist));
    D(1,1)=Dist(1,1);
    
    for n = 2:1:noOfSamplesInRefSample
        bool = checkTheLimit(n,1,noOfSamplesInRefSample,noOfSamplesInTestSample);
        if(bool ==1)
            D(n,1)=Dist(n,1)+D(n-1,1);
        end
    end
    for m = 2:1:noOfSamplesInTestSample
        bool = checkTheLimit(1,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
        if(bool ==1)
            D(1,m)=Dist(1,m)+D(1,m-1);
        end
    end
    for n = 2:noOfSamplesInRefSample
        for m = 2:1:noOfSamplesInTestSample
            bool = checkTheLimit(n,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
            if(bool ==1)
                D(n,m)=Dist(n,m)+min([D(n-1,m),(min([D(n-1,m-1),D(n,m-1)]))]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central
            end
        end
        if(isempty(find(isfinite(D(n,:)))))
            DistanceVal = -5;
            indxRw = 0;
            indxCol = 0;
            return;
        end
    end
    
    % Once the accumulated cost matrix built the warping path could be found
    % by the simple backtracking from the point pEnd = (M,N) to the pstart=(1,1)
    % following the greedy strategy as described by the below Algorithm; ref:
    % "Dynamic Time Warping Algorithm Review" by Pavel Senin
    
    X = noOfSamplesInRefSample;
    Y = noOfSamplesInTestSample;
    k=1;
    Wrapped(1,:) = [X,Y];
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

function bool = checkTheLimit(rwNum,colNum,noOfSamplesInRefSample,noOfSamplesInTestSample)

if((colNum<(2*rwNum))&&(rwNum<=(2*colNum))&&...
        (rwNum>=(noOfSamplesInRefSample-1-2*(noOfSamplesInTestSample-colNum)))...
        &&(colNum>=(noOfSamplesInTestSample-1-2*(noOfSamplesInRefSample-rwNum))))
    bool = 1;
else
    bool = 0;
end
end