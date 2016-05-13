function distance=dijkastra2(A,index,flag)
A=double(A);
[R,C]=size(A);
distance=A(index,:);
seen=zeros(1,C);

for c=1:C
    A(c,c)=0;
end
for c=1:C
    if A(index,c)==1
        seen(c)=1;
    elseif flag==1
        distance(1,c)=double(C-1);
    end
    
end

r=1;
vertex=0;
while(unseen(seen,index)==1)&& r<=R && vertex~=-1% is there any vertex that hasnt seen upto now
r=r+1;
    [vertex, seen]=nextvertex(seen);% Select next vertex inorder to determine shortest path
    if vertex~=-1
    [distance,seen]=update_distance(distance,seen,vertex,A,index); %update distance and seen matrix based on vertex
    end
end
if r>R
    'error'
end
distance(index)=0;
end
