function [vertex,seen]=nextvertex(seen)
vertex=-1;
L=length(seen);
f=0;
for l=1:L
    if seen(l)==1 && f==0 
        vertex=l;
        seen(l)=-1;
        f=1;
    end
end