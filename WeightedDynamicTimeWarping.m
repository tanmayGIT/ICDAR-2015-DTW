function [DistanceVal,indxCol,indxRw] = WeightedDynamicTimeWarping(refSample,testSample,tip)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used for calculating Weighted Dynamic Time Warping between two
% sets of vectors. Each set can be thought of in a form of matrix where the
% rows of the matrix represents each seperate samples and cols represents
% the features extracted from each sample. So each row can be considered as
% seperate vector.

% Exam. below depicts exam. of samples & extracted features frm each sample


[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

% weight coefficients
g = tip;
e = zeros(noOfSamplesInTestSample,1);
for i = 1:noOfSamplesInTestSample
    e(i,1) = 1/(1+exp(-g*(i-round(noOfSamplesInTestSample/2))));
end 

if(N == M) % each set containing same no. of feature    
   Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
   for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                 total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            Dist(i,j) = (((e((abs(j-i)) + 1))/(sum(e))) * ((sum(total))));
        end
    end
    
    D=zeros(size(Dist));
    D(1,1)=Dist(1,1);

    for n=2:noOfSamplesInRefSample
        D(n,1)=Dist(n,1)+D(n-1,1);
    end
    for m=2:noOfSamplesInTestSample
        D(1,m)=Dist(1,m)+D(1,m-1);
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
    Y = noOfSamplesInTestSample;
    k=1;
    Wrapped(1,:)=[X,Y];
    while ((X>1)&&(Y>1))
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
