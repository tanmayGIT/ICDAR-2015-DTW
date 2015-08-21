function [DistanceVal,indxCol,indxRw] = DynamicTimeWarping_VariousWarpingPath(refSample,testSample,valP,biasing)

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
    switch (valP)
        case 0
            D = Inf(size(Dist));
            phi = zeros(size(Dist));
            D(1,1) = Dist(1,1);
            
            for n = 2:noOfSamplesInRefSample
                D(n,1) = Dist(n,1)+D(n-1,1);
                phi(n,1) = 1;
            end
            for m = 2:noOfSamplesInTestSample
                D(1,m) = Dist(1,m)+D(1,m-1);
                phi(1,m) = 2;
            end
            
            for n = 2:noOfSamplesInRefSample
                for m = 2:noOfSamplesInTestSample
                    
                    if(strcmp(biasing,'Asymmetric'))
                        [minSDist,indxD] = min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                        if(indxD == 1)
                            myPhi = 1;
                        elseif(indxD == 2)
                            myPhi = 3;
                        elseif(indxD == 3)
                            myPhi = 2;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    elseif(strcmp(biasing,'Symmetric'))
                        % same as giving weight to the diagonal path, so
                        % that this path can be heavy and there will be less probability to go this path.
                        [minSDist,indxD] = min([ (D(n-1,m) + Dist(n,m)) , (D(n-1,m-1)+2*Dist(n,m)), (D(n,m-1)+Dist(n,m)) ]);
                        if(indxD == 1)
                            myPhi = 1;
                        elseif(indxD == 2)
                            myPhi = 3;
                        elseif(indxD == 3)
                            myPhi = 2;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                    
                    
                end
            end
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
            indxRw =  Wrapped(:,1);
            indxCol = Wrapped(:,2);
            DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
            return;
        case 0.5
            if(noOfSamplesInRefSample>4 && noOfSamplesInTestSample>4)
                D=Inf(size(Dist));
                D(1,1) = Dist(1,1);
                phi = zeros(size(Dist));
                
                for n = 2:noOfSamplesInRefSample
                    D(n,1) = Dist(n,1)+D(n-1,1);
                    phi(n,1) = 1;
                end
                for m = 2:noOfSamplesInTestSample
                    D(1,m) = Dist(1,m)+D(1,m-1);
                    phi(1,m) = 2;
                end
                
                % follow the same rule as classical DTW for these cells
                for n = 2:3
                    for m = 2:noOfSamplesInTestSample
                        [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                        if(indxD == 1)
                            myPhi = 1;
                        elseif(indxD == 2)
                            myPhi = 3;
                        elseif(indxD == 3)
                            myPhi = 2;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                end
                
                % follow the same rule as classical DTW for these cells
                for n = 2:noOfSamplesInRefSample
                    for m = 2:3
                        [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                        if(indxD == 1)
                            myPhi = 1;
                        elseif(indxD == 2)
                            myPhi = 3;
                        elseif(indxD == 3)
                            myPhi = 2;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                end
                
                
                for n = 4:noOfSamplesInRefSample
                    for m = 4:noOfSamplesInTestSample
                        if(strcmp(biasing,'Asymmetric'))
                            [minSDist,indxD] = min([ (D(n-1,m-3)+( (Dist(n,m-2)+Dist(n,m-1)+Dist(n,m))/3) ) ,(D(n-1,m-2)+( (Dist(n,m-1)+Dist(n,m))/2 )),( D(n-1,m-1)+(Dist(n,m)) ),...
                                (D(n-2,m-1)+(Dist(n-1,m)+Dist(n,m))),(D(n-3,m-1)+(Dist(n-2,m)+Dist(n-1,m)+Dist(n,m)) ) ]);
                            
                        elseif(strcmp(biasing,'Symmetric'))
                            [minSDist,indxD] = min([  (D(n-1,m-3)+((2*Dist(n,m-2))+Dist(n,m-1)+Dist(n,m))),  (D(n-1,m-2)+(2*Dist(n,m-1))+Dist(n,m))  ,(D(n-1,m-1)+(2*Dist(n,m))),...
                                (D(n-2,m-1)+((2*Dist(n-1,m))+Dist(n,m))),  (D(n-3,m-1)+((2*Dist(n-2,m))+Dist(n-1,m)+Dist(n,m)))  ]);
                            
                        end
                        if(indxD == 1)
                            myPhi = 4;
                        elseif(indxD == 2)
                            myPhi = 5;
                        elseif(indxD == 3)
                            myPhi = 3;
                        elseif(indxD == 4)
                            myPhi = 6;
                        elseif(indxD == 5)
                            myPhi = 7;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                end
            else
                [DistanceVal,indxRw,indxCol] = DynamicTimeWarping(refSample,testSample);
                return
            end
            % Traceback from top left
            i = noOfSamplesInRefSample;
            j = noOfSamplesInTestSample;
            
            k = 1;
            Wrapped(1,:)=[i,j];
            while (i > 1 && j > 1)
                tb = phi(i,j);
                if (tb == 1)
                    i = i-1;
                elseif (tb == 2)
                    j = j-1;
                elseif (tb == 3)
                    i = i-1;
                    j = j-1;
                elseif (tb == 4)
                    i = i-1;
                    j = j-3;
                elseif (tb == 5)
                    i = i-1;
                    j = j-2;
                elseif (tb == 6)
                    i = i-2;
                    j = j-1;
                elseif (tb == 7)
                    i = i-3;
                    j = j-1;
                else
                    error('You have some problem Sir !! ')
                end
                Wrapped = cat(1,Wrapped,[i,j]);
                k = k+1;
            end
            indxRw =  Wrapped(:,1);
            indxCol = Wrapped(:,2);
            DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
            return;
        case 1
            D = Inf(size(Dist));
            D(1,1) = Dist(1,1);
            phi = zeros(size(Dist));
            
            for n = 2:noOfSamplesInRefSample
                D(n,1) = Dist(n,1)+D(n-1,1);
                myPhi = 1;
                phi(n,1) = myPhi;
            end
            for m = 2:noOfSamplesInTestSample
                D(1,m) = Dist(1,m)+D(1,m-1);
                myPhi = 1;
                phi(1,m) = myPhi;
            end
            % follow the same rule as classical DTW for these cells
            for n = 2:3
                for m = 2:noOfSamplesInTestSample
                    [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                    if(indxD == 1)
                        myPhi = 1;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 2;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            
            % follow the same rule as classical DTW for these cells
            for n = 2:noOfSamplesInRefSample
                for m = 2:3
                    [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                    if(indxD == 1)
                        myPhi = 1;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 2;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            
            for n = 4:noOfSamplesInRefSample
                for m = 4:noOfSamplesInTestSample
                    if(strcmp(biasing,'Asymmetric'))
                        [minSDist,indxD] = min([(D(n-1,m-2)+((Dist(n,m-1)+Dist(n,m))/2)),  (D(n-1,m-1)+Dist(n,m)),...
                            ((Dist(n-2,m-1))+Dist(n-1,m)+Dist(n,m))  ]);
                    elseif(strcmp(biasing,'Symmetric'))
                        [minSDist,indxD] = min([(D(n-1,m-2)+ ( ((2*Dist(n,m-1))+Dist(n,m)) ) )  ,(D(n-1,m-1)+(2*Dist(n,m))),...
                            (D(n-2,m-1)+((Dist(n-1,m))+Dist(n,m)))]);
                    end
                    if(indxD == 1)
                        myPhi = 5;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 6;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                    
                end
            end
            
            i = noOfSamplesInRefSample;
            j = noOfSamplesInTestSample;
            
            k = 1;
            Wrapped(1,:)=[i,j];
            while (i > 1 && j > 1)
                tb = phi(i,j);
                if (tb == 1)
                    i = i-1;
                elseif (tb == 2)
                    j = j-1;
                elseif (tb == 3)
                    i = i-1;
                    j = j-1;
                elseif (tb == 4)
                    i = i-1;
                    j = j-3;
                elseif (tb == 5)
                    i = i-1;
                    j = j-2;
                elseif (tb == 6)
                    i = i-2;
                    j = j-1;
                elseif (tb == 7)
                    i = i-3;
                    j = j-1;
                else
                    error('You have some problem Sir !! ')
                end
                Wrapped = cat(1,Wrapped,[i,j]);
                k = k+1;
            end
            indxRw =  Wrapped(:,1);
            indxCol = Wrapped(:,2);
            DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
            return;
        case 2
            D = Inf(size(Dist));
            D(1,1) = Dist(1,1);
            phi = zeros(size(Dist));
            
            for n = 2:noOfSamplesInRefSample
                D(n,1) = Dist(n,1)+D(n-1,1);
                myPhi = 1;
                phi(n,1) = myPhi;
            end
            for m = 2:noOfSamplesInTestSample
                D(1,m) = Dist(1,m)+D(1,m-1);
                myPhi = 1;
                phi(1,m) = myPhi;
            end
            % follow the same rule as classical DTW for these cells
            for n = 2:3
                for m = 2:noOfSamplesInTestSample
                    [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                    if(indxD == 1)
                        myPhi = 1;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 2;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            
            % follow the same rule as classical DTW for these cells
            for n = 2:noOfSamplesInRefSample
                for m = 2:3
                    [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                    if(indxD == 1)
                        myPhi = 1;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 2;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            
            
            for n = 4:noOfSamplesInRefSample
                for m = 4:noOfSamplesInTestSample
                    if(strcmp(biasing,'Asymmetric'))
                        [minSDist,indxD] = min ([  (D(n-2,m-3)+((2*Dist(n-1,m-2)+Dist(n,m-1)+Dist(n,m))/3)),  (D(n-1,m-1)+Dist(n,m)),...
                            ((Dist(n-3,m-2))+Dist(n-2,m-1)+Dist(n-1,m)+Dist(n,m))  ]);
                        
                        %good
                    elseif(strcmp(biasing,'Symmetric'))
                        [minSDist,indxD] = min ([(D(n-2,m-3)+(2*Dist(n-1,m-2))+(2*Dist(n,m-1))+Dist(n,m)),  (D(n-1,m-1)+(2*Dist(n,m))),...
                            (D(n-3,m-2)+(2*Dist(n-2,m-1))+2*Dist(n-1,m)+Dist(n,m))  ]);
                    end
                    if(indxD == 1)
                        myPhi = 8;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 9;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            i = noOfSamplesInRefSample;
            j = noOfSamplesInTestSample;
            
            k = 1;
            Wrapped(1,:)=[i,j];
            while (i > 1 && j > 1)
                tb = phi(i,j);
                
                if (tb == 1)
                    i = i-1;
                elseif (tb == 2)
                    j = j-1;
                elseif (tb == 3)
                    i = i-1;
                    j = j-1;
                elseif (tb == 4)
                    i = i-1;
                    j = j-3;
                elseif (tb == 5)
                    i = i-1;
                    j = j-2;
                elseif (tb == 6)
                    i = i-2;
                    j = j-1;
                elseif (tb == 7)
                    i = i-3;
                    j = j-1;
                elseif (tb == 8)
                    i = i-2;
                    j = j-3;
                elseif (tb == 9)
                    i = i-3;
                    j = j-2;
                else
                    error('You have some problem Sir !! ')
                end
                Wrapped = cat(1,Wrapped,[i,j]);
                k = k+1;
            end
            indxRw =  Wrapped(:,1);
            indxCol = Wrapped(:,2);
            DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
            return;
        case 3
            D = Inf(size(Dist));
            D(1,1) = Dist(1,1);
            phi = zeros(size(Dist));
            
            for n = 2:noOfSamplesInRefSample % for first column and the rows from 2nd to 2nd last
                D(n,1) = Dist(n,1)+D(n-1,1);
                myPhi = 1;
                phi(n,1) = myPhi;
            end
            for m = 2:noOfSamplesInTestSample % for first row and column from 2nd to 2nd last
                D(1,m) = Dist(1,m)+D(1,m-1);
                myPhi = 1;
                phi(1,m) = myPhi;
            end
            % follow the same rule as classical DTW for these cells
            for n = 2:3 % 2nd and 3rd row
                for m = 2:noOfSamplesInTestSample % column from 2nd to 2nd last
                    [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                    if(indxD == 1)
                        myPhi = 1;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 2;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            
            % follow the same rule as classical DTW for these cells
            for n = 4:noOfSamplesInRefSample % from 2nd row to 2nd last row
                for m = 2:3 % 2nd and 3rd column
                    [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                    if(indxD == 1)
                        myPhi = 1;
                    elseif(indxD == 2)
                        myPhi = 3;
                    elseif(indxD == 3)
                        myPhi = 2;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            % from 4th row and 4th col upto 2nd last row and 2nd last col
            for n = 4:1:(noOfSamplesInRefSample-1)
                for m = 4:1:(noOfSamplesInTestSample-1)
                    [minSDist,indxD] =  min([(Dist(n,m)+D(n-1,m-1)),  (Dist(n,m)+(D(n-2,m-1)+Dist(n-1,m)+(1/3))),...
                        (Dist(n,m)+(D(n-1,m-2)+Dist(n,m-1)+(1/3))),  (Dist(n,m)+(D(n-3,m-1)+Dist(n-2,m)+Dist(n-1,m)+(2/3))),...
                        (Dist(n,m)+(D(n-1,m-3)+Dist(n,m-2)+Dist(n,m-1)+(2/3))) ]);
                    if(indxD == 1)
                        myPhi = 3;
                    elseif(indxD == 2)
                        myPhi = 6;
                    elseif(indxD == 3)
                        myPhi = 5;
                    elseif(indxD == 4)
                        myPhi = 7;
                    elseif(indxD == 5)
                        myPhi = 4;
                    end
                    D(n,m) = minSDist;
                    phi(n,m) = myPhi;
                end
            end
            % for last column
            for n = 4:1:noOfSamplesInRefSample-1
                [minSDist,indxD] = min([D(n-1,m-1),   (D(n-2,m-1)+Dist(n-1,m)),...
                    (D(n-1,m-2)+Dist(n,m-1)+(1/3)), (D(n-3,m-1)+Dist(n-2,m)),...
                    (D(n-1,m-3)+Dist(n,m-2)+Dist(n,m-1)+(2/3)) ]);
                if(indxD == 1)
                    myPhi = 3;
                elseif(indxD == 2)
                    myPhi = 6;
                elseif(indxD == 3)
                    myPhi = 5;
                elseif(indxD == 4)
                    myPhi = 7;
                elseif(indxD == 5)
                    myPhi = 4;
                end
                D(n,noOfSamplesInTestSample) = minSDist;
                phi(n,noOfSamplesInTestSample) = myPhi;
            end
            % for last row
            for m = 4:1:noOfSamplesInTestSample-1
                [minSDist,indxD] = min([D(n-1,m-1),  (D(n-2,m-1)+Dist(n-1,m)+(1/3)),...
                    (D(n-1,m-2)+Dist(n,m-1)), (D(n-1,m-3)+Dist(n,m-2)),...
                    (D(n-3,m-1)+Dist(n-2,m)+Dist(n-1,m)+(2/3))  ]);
                if(indxD == 1)
                    myPhi = 3;
                elseif(indxD == 2)
                    myPhi = 6;
                elseif(indxD == 3)
                    myPhi = 5;
                elseif(indxD == 4)
                    myPhi = 4;
                elseif(indxD == 5)
                    myPhi = 7;
                end
                D(noOfSamplesInRefSample,m) = minSDist;
                phi(noOfSamplesInRefSample,m) = myPhi;
            end
            
            n = noOfSamplesInRefSample;
            m = noOfSamplesInTestSample;
            [minSDist,indxD] = min([D(n-1,m-1),  (D(n-2,m-1)+Dist(n-1,m)),...
                (D(n-1,m-2)+Dist(n,m-1)), (D(n-3,m-1)+Dist(n-2,m)),...
                (D(n-1,m-3)+Dist(n,m-2)) ]);
            if(indxD == 1)
                myPhi = 3;
            elseif(indxD == 2)
                myPhi = 6;
            elseif(indxD == 3)
                myPhi = 5;
            elseif(indxD == 4)
                myPhi = 7;
            elseif(indxD == 5)
                myPhi = 4;
            end
            D(noOfSamplesInRefSample,noOfSamplesInTestSample) = minSDist;
            phi(noOfSamplesInRefSample,noOfSamplesInTestSample) = myPhi;
            
            
            i = noOfSamplesInRefSample;
            j = noOfSamplesInTestSample;
            
            k = 1;
            Wrapped(1,:)=[i,j];
            while (i > 1 && j > 1)
                tb = phi(i,j);
                if (tb == 1)
                    i = i-1;
                elseif (tb == 2)
                    j = j-1;
                elseif (tb == 3)
                    i = i-1;
                    j = j-1;
                elseif (tb == 4)
                    i = i-1;
                    j = j-3;
                elseif (tb == 5)
                    i = i-1;
                    j = j-2;
                elseif (tb == 6)
                    i = i-2;
                    j = j-1;
                elseif (tb == 7)
                    i = i-3;
                    j = j-1;
                elseif (tb == 8)
                    i = i-2;
                    j = j-3;
                elseif (tb == 9)
                    i = i-3;
                    j = j-2;
                else
                    error('You have some problem Sir !! ')
                end
                Wrapped = cat(1,Wrapped,[i,j]);
                k = k+1;
            end
            indxRw =  Wrapped(:,1);
            indxCol = Wrapped(:,2);
            DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
            return;
        case 4
            M = Dist;
            [r,c] = size(M);
            
            % costs
            D = Inf(r+1, c+1);
            D(1,:) = NaN;
            D(:,1) = NaN;
            D(1,1) = 0;
            D(2:(r+1), 2:(c+1)) = M;
            
            % traceback
            phi = zeros(r+1,c+1);
            
            for i = 2:r+1;
                for j = 2:c+1;
                    % Scale the 'longer' steps to discourage skipping ahead
                    kk1 = 2;
                    kk2 = 1;
                    dd = D(i,j);
                    [dmax, tb] = min([D(i-1, j-1)+dd, D(max(1,i-2), j-1)+dd*kk1, D(i-1, max(1,j-2))+dd*kk1, D(i-1,j)+kk2*dd, D(i,j-1)+kk2*dd]);
                    D(i,j) = dmax;
                    phi(i,j) = tb;
                end
            end
            
            % Traceback from top left
            i = r+1;
            j = c+1;
            
            k = 1;
            Wrapped(1,:)=[i,j];
            while (i > 2 && j > 2)
                tb = phi(i,j);
                if (tb == 1)
                    i = i-1;
                    j = j-1;
                elseif (tb == 2)
                    i = i-2;
                    j = j-1;
                elseif (tb == 3)
                    j = j-2;
                    i = i-1;
                elseif (tb == 4)
                    i = i-1;
                    
                elseif (tb == 5)
                    j = j-1;
                    
                else
                    error('You have some problem Sir !! ')
                end
                Wrapped = cat(1,Wrapped,[i,j]);
                k = k+1;
                % Strip off the edges of the D matrix before returning
            end
            D = D(2:(r+1),2:(c+1));
            indxRw =  Wrapped(:,1);
            indxRw = indxRw - 1;
            indxCol = Wrapped(:,2);
            indxCol = indxCol - 1;
            DistanceVal = (D(end,end))/ k ;
            return;
        case 5
            D = Inf(size(Dist));
            D(1,1) = Dist(1,1);
            phi = zeros(size(Dist));
            
            for n = 2:noOfSamplesInRefSample
                bool = checkTheLimit(n,1,noOfSamplesInRefSample,noOfSamplesInTestSample);
                if(bool ==1)
                    D(n,1) = Dist(n,1)+D(n-1,1);
                    myPhi = 1;
                    phi(n,1) = myPhi;
                end
            end
            for m = 2:noOfSamplesInTestSample
                bool = checkTheLimit(1,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
                if(bool ==1)
                    D(1,m) = Dist(1,m)+D(1,m-1);
                    myPhi = 1;
                    phi(1,m) = myPhi;
                end
            end
            % follow the same rule as classical DTW for these cells
            for n = 2:3
                for m = 2:noOfSamplesInTestSample
                    bool = checkTheLimit(n,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
                    if(bool ==1)
                        [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                        if(indxD == 1)
                            myPhi = 1;
                        elseif(indxD == 2)
                            myPhi = 3;
                        elseif(indxD == 3)
                            myPhi = 2;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                end
                if(isempty(find(isfinite(D(n,:)))))
                    DistanceVal = -5;
                    indxRw = 0;
                    indxCol = 0;
                    return;
                end
            end
            
            % follow the same rule as classical DTW for these cells
            for n = 4:noOfSamplesInRefSample
                for m = 2:3
                    bool = checkTheLimit(n,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
                    if(bool ==1)
                        [minSDist,indxD] =  min([  (D(n-1,m)+Dist(n,m)),  (D(n-1,m-1)+Dist(n,m)),  (D(n,m-1)+Dist(n,m))  ]);
                        if(indxD == 1)
                            myPhi = 1;
                        elseif(indxD == 2)
                            myPhi = 3;
                        elseif(indxD == 3)
                            myPhi = 2;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                end
            end
            % from 2nd row and 2nd col upto 2nd last row and 2nd last col
            for n = 4:1:(noOfSamplesInRefSample-1)
                for m = 4:1:(noOfSamplesInTestSample-1)
                    bool = checkTheLimit(n,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
                    if(bool ==1)
                        [minSDist,indxD] =  min([(Dist(n,m)+D(n-1,m-1)),  (Dist(n,m)+(D(n-2,m-1)+Dist(n-1,m)+(1/3))),...
                            (Dist(n,m)+(D(n-1,m-2)+Dist(n,m-1)+(1/3))),  (Dist(n,m)+(D(n-3,m-1)+Dist(n-2,m)+Dist(n-1,m)+(2/3))),...
                            (Dist(n,m)+(D(n-1,m-3)+Dist(n,m-2)+Dist(n,m-1)+(2/3))) ]);
                        if(indxD == 1)
                            myPhi = 3;
                        elseif(indxD == 2)
                            myPhi = 6;
                        elseif(indxD == 3)
                            myPhi = 5;
                        elseif(indxD == 4)
                            myPhi = 7;
                        elseif(indxD == 5)
                            myPhi = 4;
                        end
                        D(n,m) = minSDist;
                        phi(n,m) = myPhi;
                    end
                end
                if(isempty(find(isfinite(D(n,:)))))
                    DistanceVal = -5;
                    indxRw = 0;
                    indxCol = 0;
                    return;
                end
            end
            % for last column
            for n = 1:1:noOfSamplesInRefSample-1
                bool = checkTheLimit(n,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
                if(bool ==1)
                    [minSDist,indxD] = min([D(n-1,m-1),   (D(n-2,m-1)+Dist(n-1,m)),...
                        (D(n-1,m-2)+Dist(n,m-1)+(1/3)), (D(n-3,m-1)+Dist(n-2,m)),...
                        (D(n-1,m-3)+Dist(n,m-2)+Dist(n,m-1)+(2/3)) ]);
                    if(indxD == 1)
                        myPhi = 3;
                    elseif(indxD == 2)
                        myPhi = 6;
                    elseif(indxD == 3)
                        myPhi = 5;
                    elseif(indxD == 4)
                        myPhi = 7;
                    elseif(indxD == 5)
                        myPhi = 4;
                    end
                    D(n,noOfSamplesInTestSample) = minSDist;
                    phi(n,noOfSamplesInTestSample) = myPhi;
                end
                if(isempty(find(isfinite(D(n,:)))))
                    DistanceVal = -5;
                    indxRw = 0;
                    indxCol = 0;
                    return;
                end
            end
            % for last row
            for m = 1:1:noOfSamplesInTestSample-1
                bool = checkTheLimit(n,m,noOfSamplesInRefSample,noOfSamplesInTestSample);
                if(bool ==1)
                    [minSDist,indxD] = min([D(n-1,m-1),  (D(n-2,m-1)+Dist(n-1,m)+(1/3)),...
                        (D(n-1,m-2)+Dist(n,m-1)), (D(n-1,m-3)+Dist(n,m-2)),...
                        (D(n-3,m-1)+Dist(n-2,m)+Dist(n-1,m)+(2/3))  ]);
                    if(indxD == 1)
                        myPhi = 3;
                    elseif(indxD == 2)
                        myPhi = 6;
                    elseif(indxD == 3)
                        myPhi = 5;
                    elseif(indxD == 4)
                        myPhi = 4;
                    elseif(indxD == 5)
                        myPhi = 7;
                    end
                    D(noOfSamplesInRefSample,m) = minSDist;
                    phi(noOfSamplesInRefSample,m) = myPhi;
                end
            end
            
            bool = checkTheLimit(noOfSamplesInRefSample,noOfSamplesInTestSample,noOfSamplesInRefSample,noOfSamplesInTestSample);
            n = noOfSamplesInRefSample;
            m = noOfSamplesInTestSample;
            if(bool ==1)
                [minSDist,indxD] = min([D(n-1,m-1),  (D(n-2,m-1)+Dist(n-1,m)),...
                    (D(n-1,m-2)+Dist(n,m-1)), (D(n-3,m-1)+Dist(n-2,m)),...
                    (D(n-1,m-3)+Dist(n,m-2)) ]);
                if(indxD == 1)
                    myPhi = 3;
                elseif(indxD == 2)
                    myPhi = 6;
                elseif(indxD == 3)
                    myPhi = 5;
                elseif(indxD == 4)
                    myPhi = 7;
                elseif(indxD == 5)
                    myPhi = 4;
                end
                D(noOfSamplesInRefSample,noOfSamplesInTestSample) = minSDist;
                phi(noOfSamplesInRefSample,noOfSamplesInTestSample) = myPhi;
            end
            if(isempty(find(isfinite(D(n,:)))))
                DistanceVal = -5;
                indxRw = 0;
                indxCol = 0;
                return;
            end
            
            i = noOfSamplesInRefSample;
            j = noOfSamplesInTestSample;
            
            k = 1;
            Wrapped(1,:)=[i,j];
            while (i > 1 && j > 1)
                tb = phi(i,j);
                if (tb == 1)
                    i = i-1;
                elseif (tb == 2)
                    j = j-1;
                elseif (tb == 3)
                    i = i-1;
                    j = j-1;
                elseif (tb == 4)
                    i = i-1;
                    j = j-3;
                elseif (tb == 5)
                    i = i-1;
                    j = j-2;
                elseif (tb == 6)
                    i = i-2;
                    j = j-1;
                elseif (tb == 7)
                    i = i-3;
                    j = j-1;
                elseif (tb == 8)
                    i = i-2;
                    j = j-3;
                elseif (tb == 9)
                    i = i-3;
                    j = j-2;
                else
                    error('You have some problem Sir !! ')
                end
                Wrapped = cat(1,Wrapped,[i,j]);
                k = k+1;
            end
            indxRw =  Wrapped(:,1);
            indxCol = Wrapped(:,2);
            DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
            if(noOfSamplesInTestSample > 2*noOfSamplesInRefSample)
                %                 disp('The distance should be observed');
                fprintf('The distance is : %d',DistanceVal);
            end
            return;
    end
else
    return;
end
end
function bool = checkTheLimit(rwNum,colNum,noOfSamplesInRefSample,noOfSamplesInTestSample)

if((colNum<(2*rwNum))&&(rwNum<=(2*colNum))&&...
        (rwNum>=(noOfSamplesInRefSample-(2*(noOfSamplesInTestSample-colNum))))...
        &&(colNum>=(noOfSamplesInTestSample-(2*(noOfSamplesInRefSample-rwNum)))))
    bool = 1;
else
    bool = 0;
end
end
