function [DistanceVal,indxCol,indxRw] = WeightedHybrid_DTW(Data_Ref,Data_Target)

Data_Target = Data_Target';
Data_Ref = Data_Ref';

D_refData = doDerivatives(Data_Ref);
D_targetData = doDerivatives(Data_Target);

D_refDataDouble = doDerivatives(D_refData);
D_targetDataDouble = doDerivatives(D_targetData);

D_targetData = D_targetData';
D_refData = D_refData';

D_refDataDouble = D_refDataDouble';
D_targetDataDouble = D_targetDataDouble';

[Target_Row, Target_Col] = size(D_targetData);
[Ref_Row, Ref_Col] = size(D_refData);

N = Ref_Col;
M = Target_Col;
noOfSamplesInTestSample = Target_Row;
noOfSamplesInRefSample = Ref_Row;

Data_Ref = Data_Ref';
Data_Target = Data_Target';
if(N == M) % each set containing same no. of feature
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            total_1 = zeros(N,1);
            total_2 = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                total(goFeature,1) = (double((Data_Ref(i,goFeature)-Data_Target(j,goFeature))^2));
                total_1(goFeature,1) = (double((D_refData(i,goFeature)-D_targetData(j,goFeature))^2));
                total_2(goFeature,1) = (double((D_refDataDouble(i,goFeature)-D_targetDataDouble(j,goFeature))^2));
            end
            Dist(i,j) =  (sqrt(sum(total))) +  2*(sqrt(sum(total_1))) +  2*(sqrt(sum(total_2)));
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
function D_targetData = doDerivatives(Data_Target)
[Target_Row,Target_Col] = size(Data_Target);
D_targetData = zeros(Target_Row,Target_Col);
for i=1:Target_Row
    for j=2:(Target_Col-1)-1
        D_point=((Data_Target(i,j)-Data_Target(i,j-1))+((Data_Target(i,j+1)-Data_Target(i,j-1))/2))/2;
        if j == 2
            D_targetData(i,1)=D_point;
        end
        if j == (Target_Col-1)-1
            D_targetData(i,Target_Col-1)=D_point;
        end
        D_targetData(i,j)=D_point;
    end
end
return;
end