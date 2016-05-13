function [ss,Maxs,tmp]=AverageOfSumOfAllPAthes(A)
L=length(A);
s=zeros(1,L);
ss=0;
tmp=0;
for l=1:L
    d=dijkastra2(A,l,1);
    s(l)=sum(d);
    if tmp<max(d)
        tmp=max(d);
    end
end
Maxs=max(s);% max of sum of all pathes
ss=sum(s)/2;% Sum of all distances
