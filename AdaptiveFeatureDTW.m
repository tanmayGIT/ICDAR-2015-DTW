function [DistanceVal,indxCol,indxRw] = AdaptiveFeatureDTW(Data_Ref,Data_Target)

Data_Target = Data_Target';
Data_Ref = Data_Ref';
[Target_Row, Target_Col] = size(Data_Target);
[Ref_Row, Ref_Col] = size(Data_Ref);

D_targetDataLocal = cell(Target_Row,Target_Col);
D_refDataLocal = cell(Ref_Row,Ref_Col);

D_targetDataGlobal = cell(Target_Row,Target_Col);
D_refDataGlobal = cell(Ref_Row,Ref_Col);

for i=1:Target_Row
    for j=2:(Target_Col-1)
        D_point_xLocal = Data_Target(i,j) - Data_Target(i,j-1);
        D_point_yLocal = Data_Target(i,j) - Data_Target(i,j+1);      
        D_targetDataLocal{i,j} = [D_point_xLocal,D_point_yLocal];
        
        D_point_xGlobal = Data_Target(i,j) - sum(Data_Target(i,1:j-1)./(j-1));
        D_point_yGlobal = Data_Target(i,j) - sum(Data_Target(i,j+1:Target_Col)./(Target_Col-j));      
        D_targetDataGlobal{i,j} = [D_point_xGlobal,D_point_yGlobal];
    end
end

for i=1:Ref_Row
    for j=2:(Ref_Col-1)        
        D_point_xLocal = Data_Ref(i,j) - Data_Ref(i,j-1);
        D_point_yLocal = Data_Ref(i,j) - Data_Ref(i,j+1);   
        D_refDataLocal{i,j} = [D_point_xLocal,D_point_yLocal];
        
        D_point_xGlobal = Data_Ref(i,j) - sum(Data_Ref(i,1:j-1)./(j-1));
        D_point_yGlobal = Data_Ref(i,j) - sum(Data_Ref(i,j+1:Ref_Col)./(Ref_Col-j));      
        D_refDataGlobal{i,j} = [D_point_xGlobal,D_point_yGlobal];
    end
end
D_targetDataLocal = D_targetDataLocal';
D_refDataLocal = D_refDataLocal';
[Target_Row, Target_Col] = size(D_targetDataLocal);
[Ref_Row, Ref_Col] = size(D_refDataLocal);

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
                dist_local = (double(D_refDataLocal{i,goFeature}(1,1)-D_targetDataLocal{j,goFeature}(1,1))) + ... 
                        (double(D_refDataLocal{i,goFeature}(1,2)-D_targetDataLocal{j,goFeature}(1,2)));
%                  dist_local = sqrt( (double(D_refDataLocal{i,goFeature}(1,1)-D_targetDataLocal{j,goFeature}(1,1)))^2 + ... 
%                         (double(D_refDataLocal{i,goFeature}(1,2)-D_targetDataLocal{j,goFeature}(1,2)))^2);
                    
                dist_global = (double(D_refDataGlobal{i,goFeature}(1,1)-D_targetDataGlobal{j,goFeature}(1,1))) + ... 
                        (double(D_refDataGlobal{i,goFeature}(1,2)-D_targetDataGlobal{j,goFeature}(1,2)));
%                 dist_global = ( (double(D_refDataGlobal{i,goFeature}(1,1)-D_targetDataGlobal{j,goFeature}(1,1)))^2 + ... 
%                         (double(D_refDataGlobal{i,goFeature}(1,2)-D_targetDataGlobal{j,goFeature}(1,2)))^2);    
                total(goFeature,1) = dist_local + dist_global;
            end
            Dist(i,j) =  ((sum(total)));
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
