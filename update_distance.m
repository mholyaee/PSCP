function [distance,seen]=update_distance(distance,seen,vertex,A,index)
L=length(A);
for l=1:L
    if A(vertex,l)==1 && seen(l)~=-1 && index~=l && seen(l)~=1
        seen(l)=1;
        distance(l)=distance(vertex)+1;
    end
end
        
        
