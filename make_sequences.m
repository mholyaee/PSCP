function make_sequences()

directory_name = uigetdir();% Set save path for created databases
[filename, pathname] = uigetfile('*.*', 'Pick a HEC_database file');%HEC sequences should be saved in excel format
filename_HEC=strcat(pathname,filename);
[ndata,all_HEC]=xlsread(filename_HEC);
L1=length(all_HEC);
index=1;
for i=1:2:L1
    name_HEC=all_HEC(i,:);
    seq_HEC=char(all_HEC(i+1,:));
    [seri_hec_x,seri_hec_y]=CGR_2th_structure(seq_HEC,1);% create 3CGR
    %-------------------------------------------------
     tou_hec_x=1;% inital set for m and tau
     tou_hec_y=1;
     m_hec_x=3;
     m_hec_y=3;
     [m_hec_x,tou_hec_x,EPS_hec_x]=determin_phase_space_eps_xls(seri_hec_x);
     [m_hec_y,tou_hec_y,EPS_hec_y]=determin_phase_space_eps_xls(seri_hec_y);

    %-------------------------------------------------------------------
    temp_hec_x=ones(1,16)*(-1);
    temp_hec_y=ones(1,16)*(-1);
    
    if m_hec_x~=-1
        temp_hec_x=DM_Matrix_xls2(seri_hec_x,m_hec_x,tou_hec_x,EPS_hec_x);
     end
    if m_hec_y~=-1
       temp_hec_y=DM_Matrix_xls2(seri_hec_y,m_hec_y,tou_hec_y,EPS_hec_y);
    end
    
    %-------------------------------------------------------------------
    lable=get_labe2(name_HEC);
    phase(index,:)=[m_hec_x,m_hec_y,lable];
    features_hec(index,:)=[temp_hec_x,temp_hec_y,lable];
    index=index+1;
    clc
    
    path0=strcat(directory_name,'\phase.mat');
    save(path0, 'phase');
    path1=strcat(directory_name,'\features_hec.mat');
    save(path1, 'features_hec');
end

    path0=strcat(directory_name,'\phase.mat');
    save(path0, 'phase');
    path1=strcat(directory_name,'\features_hec.mat');
    save(path1, 'features_hec');

    
    