function [DistanceVal,indxCol,indxRw] = DynamicTimeWarping(refSample,testSample,straight)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used for calculating Dynamic Time Warping between two
% sets of vectors. Each set can be thought of in a form of matrix where the
% rows of the matrix represents each seperate samples and cols represents
% the features extracted from each sample. So each row can be considered as
% seperate vector.

% Exam. below depicts exam. of samples & extracted features frm each sample

%-----------------------------------------  refSample  -----------------------------------------------
%            Feature1  Feature2    Feature3    Feature4    Feature5    Feature6    Feature7    Feature8 
% Sample_1 -> 218.763   1383.23     2814.63     3698.46     283.366     398.209     554.283     344.022
% Sample_2 -> 1211.34   2271.84     3175.66     3887.79     688.329     394.739     438.149     548.188
% Sample_3 -> 944.728   2135.56     2698.35     3641.12     525.242     760.779     485.149     520.193
% Sample_4 -> 213.91    1280.9      2201.54     4396.4      580.349     571.959     589.167     516.748
% Sample_5 -> 782.347   1578.81     2562.91     3965.88     862.244     613.181     362.169     995.676
% Sample_6 -> 1177.65   2179.5      2787.38     4360.61     308.567     364.734     591.679     458.492
% Sample_7 -> 878.674   2224.2      2844.5      4427.47     708.421     241.865     357.375     242.539
% Sample_8 -> 625.975   2222.71     2971.39     4279.88     304.251     303.16      440.516     325.867
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------  testSample  -------------------------------------------------  

%            Feature1  Feature2    Feature3    Feature4    Feature5    Feature6    Feature7    Feature8 
% Sample_1 -> 288.813   2382.73     2694.47     3974.36     152.68      282.199     434.053     421.237 
% Sample_2 -> 264.133   2290.89     2700.63     3919.16     131.615     839.425     222.812     508.723 
% Sample_3 -> 264.274   2304.16     2707.82     3914.13     156.721     915.116     297.805     495.989 
% Sample_4 -> 249.604   2188.2      2777.91     3882.64     124.841     776.532     163.761     405.021 
% Sample_5 -> 242.457   2232.08     2763.96     3875.29     125.288     965.51      204.148     435.093 
% Sample_6 -> 229.916   2300.28     2888.61     3930.54     139.239     545.863     589.41      872.219 
% Sample_7 -> 216.683   2235.82     2819.21     4175.41     121.877     529.907     283.876     456.535 
% Sample_8 -> 270.242   2312.01     2775.75     4016.54     203.384     623.547     251.015     352.289 

[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

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
