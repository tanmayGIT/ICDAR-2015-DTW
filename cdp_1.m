function [indxcol,indxrow,mini] = cdp_1(ref, stream,straight)
% Continuous DP algorithm for spotting reference frames
% in a stream.See article :
% Spotting Method for Classification of Real World Data, by Ryuichi Oka
% Original Author Tommy Strmhaug, 2008

% Modified By Tanmoy Mondal, 2014.
global JC
global sJC
noOfSamplesInTestSample = size(stream,1);
[~,N] = size(ref);
Dist = zeros((size(stream,1)),(size(ref,1))); % Initializing the array
for i = 1:(size(stream,1)) %ySize
    for j = 1:(size(ref,1)) % xSize
        total = zeros(N,1);
        for goFeature = 1:N %or M as N & M are same
            total(goFeature,1) = (double((stream(i,goFeature) - ref(j,goFeature))^2));
        end
        Dist(i,j) = sqrt(sum(total));
    end
end
% clear P;
%init variables
tau = 1;
mini = inf;
P = zeros((size(stream,1)),size(ref,1));
%According to algorith these must be inf.
P(1,:) = inf;
P(2,:) = inf;
tic
p = Inf(size(stream,1),1);
minPos  = 1;
for t2 = 3:1:(size(stream,1))
    %     t = t2;
    %     if (t2 > 4)
    %         t = 4;
    %         P(1,:) = [];
    %     end
    for tau = 1:1:size(ref,1)
        
        if (tau == 1)
            P(t2,1) = 3*(Dist(t2,1));
        end
        
        if (tau == 2)
            temp = min(    P(t2-2,1)+2*(Dist(t2-1,2))+(Dist(t2,2))    ,     P(t2-1,1) + 3*(Dist(t2,2))     );
            P(t2,2) = min(     temp,      P(t2,1)+3*abs(Dist(t2,2))     );
        end
        
        if(tau > 2)
            temp = min(  P(t2-2,tau-1)+2*(Dist(t2-1,tau))+(Dist(t2,tau)),    P(t2-1,tau-1)+3*(Dist(t2,tau))  );
            P(t2,tau)= min(   temp,    P(t2-1,tau-2)+3*(Dist(t2,tau-1))+3*(Dist(t2,tau))    );
        end
        
    end
    compaDeno =  P(t2,tau)/(3*(tau));
    if(compaDeno <mini)
        mini = compaDeno;
        minPos = t2;
    end
    p(t2) = compaDeno;
end
indxrow  = zeros(size(ref,1),1);
indxcol = zeros(size(ref,1),1);
if (minPos < size(ref,1))
    minPos = size(ref,1);
end
for rwCol = size(ref,1):-1:1
    indxrow(rwCol,1) = rwCol;
    indxcol(rwCol,1) = minPos;
    minPos = minPos -1 ;
end
if (straight == 2)
    mini = mini + ( (   (indxcol(1,1)-1) + (noOfSamplesInTestSample - indxcol(1,1)) ) * JC );
end
%At last plot the contour of spotting
% figure,plot(p)
return;
end

