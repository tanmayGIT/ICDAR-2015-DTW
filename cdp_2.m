% the dp path is same as DTW

function [indxcol,indxrow,mini,P] = cdp_2(ref, stream)
% Continuous DP algorithm for spotting reference frames
% in a stream.See article :
% Spotting Method for Classification of Real World Data, by Ryuichi Oka
% Author Tommy Strmhaug, 2008
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






% P(1,1)=Dist(1,1);
%
% for n = 2:(size(stream,1))
%     P(n,1) = Dist(n,1)+P(n-1,1);
% end
% for m = 2:size(ref,1)
%     P(1,m) = Dist(1,m)+P(1,m-1);
%     temp = min(    (P(2-1,m))+(Dist(2,m))    ,     P(2-1,m-1) + (Dist(2,m))     );
%     P(2,m) = min(     temp,      P(2,m-1)+abs(Dist(2,m))     );
% end


P(1,:) = inf;
P(2,:) = inf;


tic
p = Inf(size(stream,1),1);
minPos  = 1;
for t2 = 3:1:(size(stream,1))
    
    for tau = 1:1:size(ref,1)
        
        if (tau == 1)
            P(t2,tau) = (Dist(t2,tau));
            
            
            %         if (tau == 2)
            %             temp = min(    P(t2-1,2)+(Dist(t2,2))    ,     P(t2-1,1) + (Dist(t2,2))     );
            %             P(t2,2) = min(     temp,      P(t2,1)+(Dist(t2,2))     );
            %         end
        else
            %         if(tau > 2)
            temp = min(  P(t2-1,tau-1)+(Dist(t2,tau)),    P(t2-1,tau)+(Dist(t2,tau))  );
            P(t2,tau)= min(   temp,    P(t2,tau-1)+(Dist(t2,tau))    );
            %         end
        end
    end
    compaDeno =  P(t2,tau)/((tau)); % they do tau-1 just to get the last row as when tau leaves the loop it get increamented by 1
    % so for getting the last row we have to decremented it by 1
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
return;
end
%At last plot the contour of spotting
% figure,plot(p)
