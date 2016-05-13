function temp=DM_Matrix_xls2(seri,m,tou,EPS)
% This function takes time series named seri and extracts 12 features
% accroding to determined measures for phase space
% This function needs CRP Toolbox
temp=zeros(1,16);
if m==-1
    temp(1,:)=-1;
else
    temp=crqa(seri,m,tou,EPS);
    if isempty(temp)    
        temp=ones(1,16)*(-1);
    else
        RP=crp(seri,m,tou,EPS,'euclidean');
        [mean_distance,maxsumd,maxd]=AverageOfSumOfAllPAthes(RP);
        temp=[temp(1:8),temp(12),mean_distance,maxsumd,maxd];
    end

end
end