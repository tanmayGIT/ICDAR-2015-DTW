function [moo,m1oSum,n_pq] = cent_moment(p,q,A)

[m n]=size(A);
moo=sum(sum(A));

m1o=zeros(m*n,1);
mo1=zeros(m*n,1);
cnt1 = 1;
cnt2 =1;
for x=1:m
    for y=1:n
        m1o(cnt1,1)=(double(x)*double(A(x,y)));
        mo1(cnt2,1)=(double(y)*double(A(x,y)));
        cnt1 = cnt1+1;
        cnt2 = cnt2+1;
    end
end

m1oSum = sum(m1o) ;
mo1Sum = sum(mo1);
xx=double(double(m1oSum)/double(moo));
%   yy=double(double(mo1Sum)/double(moo));


mu_pq = zeros(m*n,1);

cnt3 = 1;
for ii=1:m
    %         x=ii-xx;
    for jj=1:n
        
        mu_pq(cnt3,1)=((ii^p) -xx)*(A(ii,jj));
        cnt3 = cnt3 +1;
    end
end
mu_pqSum = sum(mu_pq);
gamma=0.5*(p+q)+1;
n_pq=mu_pqSum /moo^(gamma);
return;

