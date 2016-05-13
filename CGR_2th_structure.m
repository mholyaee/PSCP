function [serix,seriy]=CGR_2th_structure(str,fs)
%This function takes a string called str and make chaos game representation (CGR)
% of the input string. serix and seriy are two time series which contain
% all the information of CGR
%tringle:H=(0,0),E=(1,0),C=(0.5,0.75^0.5)
px=[0.5,0,1];
py=[0.866,0,0];
l=length(str);
prex=0.25;prey=0.25;
serix=0;seriy=0;str;j=1;
for i=1:l
    x=-1;counter=0;
    if str(i)=='H'
        x=(prex)/2;
        if prex==0
            prex=0.0001;
        end
        y=(prey/prex)*x;
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif str(i)=='C'
        x=(prex+0.5)/2;
        if prex==0.5
            prex=0.4999;
        end
        y=0.866+(prey-0.866)/(prex-0.5)*(x-0.5);
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif str(i)=='E'
        x=(prex+1)/2;
        if prex==1
            prex=0.9999;
        end
        y=(prey)/(prex-1)*(x-1);
        serix(j)=x;seriy(j)=y;
        prex=x;prey=y;
        j=j+1;
    end
end

if fs==1
    figure;plot(serix,'-s','LineWidth',1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',2);xlabel('Position');ylabel('CGRX');
    figure;plot(seriy,'-s','LineWidth',1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',2);xlabel('Position');ylabel('CGRY');
  figure;
  x = [0,0.5,1]; 
  y = [0,0.866,0]; 
  TRI = delaunay(x,y);
  triplot(TRI,x,y,'red');
  hold on
  plot(px,py,'k.',serix,seriy,'k.');
end
len=length(serix);



    
    