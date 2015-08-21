function [DistanceVal,indxCol,indxRw] = AccurateFastDynamicTimeWarping(refSample,testSample,straight)

[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

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
    if(noOfSamplesInTestSample < (2*noOfSamplesInRefSample)) % then you can apply itekura band
        theta = calSmallItekura(Dist,noOfSamplesInRefSample,noOfSamplesInTestSample);
    else
        theta = Small_SC_Band(refSample,testSample);
    end
    if(theta == -5) % then itekura and SC-band both of them has not worked
        [theta,~,~] = smallDTW(refSample,testSample,1);
    end
    D=Inf(size(Dist)+1);
    D(noOfSamplesInRefSample+1,noOfSamplesInTestSample+1) = theta;
    D(noOfSamplesInRefSample+1,1:noOfSamplesInTestSample) = -Inf;
    D(1:noOfSamplesInRefSample,noOfSamplesInTestSample+1) = -Inf;
    
    for n = noOfSamplesInRefSample:-1:1
        for m = noOfSamplesInTestSample:-1:1
            if ( (D(n,m+1)>0)&&(D(n+1,m)>0)&&(D(n+1,m+1)>0) ) % if all the adjacent cells are positive then only do the process
                D(n,m) = (max([D(n+1,m+1),D(n,m+1),D(n+1,m)]) ) -  Dist(n,m) ;
                if(D(n,m) < 0) % if the value is negative then makeit zero
                    D(n,m) = 0;
                end
            elseif( (D(n,m+1) == 0)  &&  (D(n+1,m) == 0)  &&  (D(n+1,m+1) == 0) ) % if all the cells are zero then make the current cell also zero
                D(n,m) = 0;
                break;
            end
        end
    end
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
    indxRw =  Wrapped(:,1);
    indxCol = Wrapped(:,2);
    DistanceVal = (D(1,1)) ;
    
else
    return;
end
end

function [DistanceVal,indxCol,indxRw] = smallDTW(refSample,testSample)
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
    indxRw =  Wrapped(:,1);
    indxCol = Wrapped(:,2);
    DistanceVal = 0;
    for yu = 1:1:size(indxRw,1)
        DistanceVal = DistanceVal + D(indxRw(yu,1),indxCol(yu,1));
    end
    
else
    error('The dimention of the feature are not same');
end
end

function DistanceVal = calSmallItekura(Dist,noOfSamplesInRefSample,noOfSamplesInTestSample)
D = Inf(size(Dist));
D(1,1) = Dist(1,1);

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
    if(isempty(find(isfinite(D(n,:)),1))) % if there is no finite element in this row
        DistanceVal = -5;
        return;
    end
end

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
indxRw =  Wrapped(:,1);
indxCol = Wrapped(:,2);
DistanceVal = 0;
for yu = 1:1:size(indxRw,1)
    DistanceVal = DistanceVal + D(indxRw(yu,1),indxCol(yu,1));
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


function [DistanceVal] = Small_SC_Band(refSample,testSample)
SC_Radius = size(testSample,1) -  size(refSample,1);

[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

if(N == M)
    endLimit = (min((noOfSamplesInRefSample + SC_Radius),noOfSamplesInTestSample));
    if(endLimit < noOfSamplesInTestSample)
        DistanceVal = -5;
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
    indxRw =  Wrapped(:,1);
    indxCol = Wrapped(:,2);
    DistanceVal = 0;
    for yu = 1:1:size(indxRw,1)
        DistanceVal = DistanceVal + D(indxRw(yu,1),indxCol(yu,1));
    end
else
    error('The dimention of the feature are not same');
end
end
