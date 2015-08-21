function [DistanceVal,indxCol,indxRw] = WDTW(r,t)
%Dynamic Time Warping Algorithm
%Dist is unnormalized distance between t and r
%D is the accumulated distance matrix
%k is the normalizing factor
%w is the optimal path
%t is the vector you are testing against (training data, one correlogram)
%r is the vector you are testing (testing data, one correlogram)
t = t';
r = r';
[rows,N]=size(t);
[rows,M]=size(r);

% weight coefficients
g = 0;
for i=1:N
    e(i)=1/(1+exp(-g*(i-round(N/2))));
end


for m=1:M
    for n=1:N
        index=abs(n-m);
        d(m,n)=(e(index+1)/sum(e))*(sum((t(:,n)-r(:,m)).^2)); % L2 Norm
        %d(n,m)=(e(index+1)/sum(e))*(abs(t(n)-r(m)));  % L1 Norm
    end
end

%d=(repmat(t(:),1,M)-repmat(r(:)',N,1)).^2; %this replaces the nested for loops from above Thanks Georg Schmitz

D=zeros(size(d));
D(1,1)=d(1,1);

for m=2:M
    D(m,1)=(d(m,1)+D(m-1,1));
end
for n=2:N
    D(1,n)=(d(1,n)+D(1,n-1));
end

for m=2:M
    for n=2:N
        D(m,n)=(d(m,n)+min([D(m-1,n),D(m-1,n-1),D(m,n-1)]));
    end
end

% Once the accumulated cost matrix built the warping path could be found
% by the simple backtracking from the point pEnd = (M,N) to the pstart=(1,1)
% following the greedy strategy as described by the below Algorithm; ref:
% "Dynamic Time Warping Algorithm Review" by Pavel Senin

X = M;
Y = N;
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
DistanceVal = (D(M,N))/ k ;

return;
end
