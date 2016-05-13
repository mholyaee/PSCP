function BHDA(data)
[r c]=size(data);
   Num=unique(data(:,c));
   numberclass=size(Num,1);
   M1=0;SW=0;SB=0;
  %% Separate classes   
   for i=1:size(Num,1)
       indd=find(data(:,c)==Num(i));
        Class{i}=data(indd,1:end);
        Class_nonlab{i}=data(indd,1:c-1);
         if i==1
          XINP=Class{i};
         else
          XINP=cat(1,XINP,Class{i});
         end
        M{i}=mean(Class_nonlab{i});
        M1=M1+M{i};
        N{i}=size(Class{i},1);
   end
  s11=0;s22=0;SH=0;SW=0;SH1=0;
  %% Construction scattering matrix
  for i=1:size(Num,1)
       for j=i+1:size(Num,1)
           CI=Class_nonlab{i};CII=Class{i};MI=mean(CI);
           CJ=Class_nonlab{j};CJJ=Class{j};MJ=mean(CJ);
           M_T=(MI+MJ)/2;
           D=[CII;CJJ];
           [Ind Indbound]=BoundaryRegion3(Class{i},Class{j});
            Xb=D(Ind,1:end);
            Xnonb=D(Indbound,1:end);
            Xb=D(Ind,1:end);
            Xnonb=D(Indbound,1:end);
            
           c1Xnonb=find(Xnonb(:,c)== Num(i));
           c1Xnonb=D(c1Xnonb,1:c-1);
           c2Xnonb=find(Xnonb(:,c)==Num(j));
           c2Xnonb=D(c2Xnonb,1:c-1);
           
           c1Xb=find(Xb(:,c)==Num(i));
           c1Xb=D(c1Xb,1:c-1);
           
           c2Xb=find(Xb(:,c)==Num(j));
           c2Xb=D(c2Xb,1:c-1);
           Xb=[c1Xb;c2Xb];
           sb1=0;sb2=0;SB=0;
            for i1=1:size(Xb,1)
               sb1=sb1+(Xb(i1,:)-M{i})'*(Xb(i1,:)-M{i});
               sb2=sb2+(Xb(i1,:)-M{j})'*(Xb(i1,:)-M{j});
            end                      
           SB=sb1+sb2;
           if SB==0
               SB1=0;SB2=0;
               SB1=SB1+(N{i}*((MI-M_T)'*(MI-M_T)));
               SB2=SB2+(N{j}*((MJ-M_T)'*(MJ-M_T)));
               SB=SB1+SB2;
           end
           s1=0;s2=0;
            for i1=1:size(c1Xnonb,1)
               s1=s1+(c1Xnonb(i1,:)-M{i})'*(c1Xnonb(i1,:)-M{i});            
           end
           for i1=1:size(c2Xnonb,1)
               s2=s2+(c2Xnonb(i1,:)-M{j})'*(c2Xnonb(i1,:)-M{j});     
           end
           Pi=N{i}/(N{i}+N{j});
           Pj=N{j}/(N{i}+N{j});
           SW=N{i}*s1+N{j}*s2;
           
           if  rank(SW)~=size(SW,2)
             I=eye(size(SW,1));
             SW= SW+0.001*I;
           end 
           SW_IJ=s1*Pi+s2*Pj;
           sw_transform_orginal=(a_p_m(SW));
               sw_transform=a_p(SW);
               partS=real(a_p(sw_transform*SW_IJ*sw_transform));
               partSEij=sw_transform*SB*sw_transform;
               partFIFJ=a_log(sw_transform*SW_IJ*sw_transform);
               partFI=Pi*(a_log(sw_transform*s1*sw_transform));
               partFJ=Pj*(a_log(sw_transform*s2*sw_transform));
              
           SH=sw_transform_orginal*((partS*partSEij*partS)+( 1/(Pi+Pj)*(partFIFJ-partFI-partFJ)))*sw_transform_orginal;
       end
       SH1=SH1+SH;
  end
  M_total=M1/numberclass;
     for k=1:size(M,2)-1
      M_total_2c{k}=(M{k}+M{k+1})./2;  
     end
    
     [Evec1,Eval1]=eig(SH*SW);
     [Eval1 ind1]=sort(diag(Eval1),'descend');
       w3=Evec1(:,ind1);
          W2=w3(:,1);
 %% Classification process         
          x=data(:,1:end-1);
            m1=M{1,1};m2=M{1,2};m3=M{1,3};
            m1_2=(m1+m2)./2; m2_3=(m2+m3)./2;
             y=0;y1=0;c1=0;c2=0;c3=0;c4=0;c11=0;c22=0;c33=0;c44=0;
             for h=1:size(x,1)
               y(:,h)=W2'*(x(h,:)-m1_2)';
               y1(:,h)=W2'*(x(h,:)-m2_3)';
                if y(:,h) <= 0
                  c1=c1+1;    
                elseif (y(:,h)> 0) && (y1(:,h)<=0)
                  c2=c2+1;
                elseif (y1(:,h)>0) 
                  c3=c3+1;
                end          
               if y(:,h) > 0
                c11=c11+1;
               elseif (y(:,h)<= 0) && (y1(:,h)>0)
                c22=c22+1;
               elseif (y1(:,h)<=0) 
                c33=c33+1;
               end
                    
             end
            out_CI={c1,c2,c3};
            out_CII={c11,c22,c33};
             L=[size(Class{1,1},1);size(Class{1,2},1);size(Class{1,3},1)];
             LL=0;out_a=0;
             for i=1:3
               if out_CI{i}>out_CII{i}
                  out(i,:)=out_CI{i};
               else
                  out(i,:)=out_CII{i};
               end
     
               if out(i,:)<L(i,:)
                  out(i,:)=out(i,:);
               else
                  out(i,:)=L(i,:);
               end
                 LL=LL+L(i,:);
                 out_a=out_a+out(i,:);
             end
             out_a=(out_a/LL)*100
             
end
function [Ind Indbound]=BoundaryRegion3(x1,x2)
%% Separation process pattern border and non-border pattern
x=[x1;x2];
d=[ones(length(x1),1);zeros(length(x2),1)];
N=length(x);
Y=pdist(x,'euclidean');
Z = squareform(Y);
 MZ=max(Z(:));
 Zn=(Z==0).*(MZ+1)+(Z~=0).*Z;
 
 K=5;
 for i=1:length(Zn)
     [R,ind]=sort(Zn(i,:));
     L=d(ind(1:K));
     p0=sum(L==0)/(K);
     p1=sum(L==1)/(K);
     if p0==0
         t0=0;
     else
         t0=p0*log(p0);
     end
     if p1==0
         t1=0;
     else
         t1=p1*log(p1);
     end
      prox(i)=-(t0+t1);
         
end
Ind= find(prox~=0);
Indbound=find(prox==0);
NonU=x(Ind,:);
h=1;
end
function [XXT]=a_p(X)
%% Inverse action
[A V]=eig(X);
V=m(V);
[m n]=size(V);
for i=1 : m
  for j=1 : n
        if i==j
             V(i,j)=V(i,j)^(-1/2);
        end
 end
end
XXT=A*V*(inv(A));
end
function [XXT]=a_p_m(X)

[A V]=eig(X);
V=m(V);
XX=(diag(V));

[m n]=size(V);
for i=1 : n
  for j=1 : m
        if i==j        
         V(i,j)=V(i,j)^(1/2);
        end
 end
end
XXT=A*V*(inv(A));
end
function [XXT]=a_log(X)

[A V]=eig(X);
V=m((V));
[m n]=size(V);
for i=1 : m
  for j=1 : n
        if i==j          
          V(i,j)=log(V(i,j));
        end
 end
end
XXT=real(A*V*(inv(A)));
end
function [V]=m(V)
AA=V;
for i= 1:size(AA,1)
    for j= 1:size(AA,2)
     if (i==j)&& (AA(i,j)<=0)
           AA(i,j)=AA(i,j)+10^-6;
     
    end
    end
end
V=AA;
end