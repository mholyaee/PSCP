function [m,tou,EPS]=determin_phase_space_eps_xls(seri)
% This function takes a time series and detemines its phase space
% experimentally
% This function requires CRP toolbox
tou_min=1;
tou_max=4;
Mmax=10;
Mmin=4;
for m=Mmin:Mmax
    for t=tou_min:tou_max
        for EPS=0.2:0.1:2
            temp=crqa(seri,m,t,EPS);
            if temp(1,1)>0 && temp(1,1)<=0.5
                
                tou=t;
                if isnan(temp(1,12))~=1
                    return
                end
            end
        end
    end
end
end

