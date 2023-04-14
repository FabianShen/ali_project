newFD
f_intensity_matrix = f./total_input_row;
bm = readmatrix('数据分类.xlsx',Sheet='Sheet1',Range='F3:M44');
pop_UR = readmatrix("8分类.xlsx",Sheet='Sheet4',Range='H3:I33');
pop_HH = readmatrix("8分类.xlsx",Sheet='Sheet4',Range='K3:P33');
pop_NUM = readmatrix("8分类.xlsx",Sheet='Sheet4',Range='S3:S33');
FP_UR_inc_fam = zeros(31,60);
for i = 1:31
    FD_i = FD(:,i*60-59:i*60);
    FP_i = zeros(42,60);
    a = (f_intensity_matrix*e)'.*FD_i;
    for j = 1:42
        FP_i(j,:) = sum(a(j:31:31*42,:),1);
        Cons_i(j,:) = sum(FD_i(j:31:31*42,:),1);
    end
    FP_i = (FP_i'*bm)';
    Cons_i = (Cons_i'*bm)';

    % 5 consumpsion
    FP_UR_inc_fam(i,:) = sum(FP_i,1);
    EP_UR_inc_fam(i,:) = sum(Cons_i,1);
    FP_total(i*8-7:i*8,:) = FP_i;
    EP_total(i*8-7:i*8,:) = Cons_i;
end
HH_UR = readmatrix("ida.xlsx",Sheet = "Sheet3",Range = 'A1:A2'); % Household size
HH_HH = readmatrix('ida.xlsx',Sheet ='Sheet4',Range = 'A1:A6');
sector_UR = readcell('ida.xlsx',Sheet ='Sheet3',Range = 'A4:B4');
sector_HH = readcell('ida.xlsx',Sheet ='Sheet4',Range = 'A8:F8');

%% Get FP_inc_re, FP_sec_re
% FP_inc_re
FP_fam = zeros(31,6);
FP_U = FP_UR_inc_fam(:,1:30);
FP_R = FP_UR_inc_fam(:,31:60);
FP_inc_re = zeros(31,5);
for j = 1:5
    FP_inc_1 = sum(FP_U(:,j*6-5:j*6),2);
    FP_inc_2 = sum(FP_U(:,j*6-5:j*6),2);
    FP_inc_re(:,j) = FP_inc_2 + FP_inc_1;
end

for j = 1:6
    FP_fam(:,j) = sum(FP_UR_inc_fam(:,j:6:60),2);
end

% FP_sec_re
for i =1:31
    FP_sec_i = sum(FP_total(i*8-7:i*8,:),2);
    FP_sec_re(i,:) = FP_sec_i';
end

% FP_UR_sec
for i = 1:31
    FP_U_sec = sum(FP_total(i*8-7:i*8,1:30),2);
    FP_R_sec = sum(FP_total(i*8-7:i*8,31:60),2);
    FP_UR_sec(i,:) = [FP_U_sec',FP_R_sec'];
end
FP_UR = [sum(FP_UR_sec(:,1:8),2),sum(FP_UR_sec(:,9:16),2)];
pop_NUM_UR = pop_NUM.*pop_UR;
FP_UR_cap = FP_UR./pop_NUM_UR;
% FP_House_sec
FP_House_sec = [];
for i = 1:31
    for j = 1:6
        FP_AAA_sec = sum(FP_total(i*8-7:i*8,j:6:60),2);
        FP_House_sec(i,j*8-7:j*8) = FP_AAA_sec';
    end
end
%%
for i = 1:6
    FP_House(:,i) = sum(FP_House_sec(:,i*8-7:i*8),2);
end
pop_NUM_HH = pop_NUM.*pop_HH;
FP_HH_cap = FP_House./pop_NUM_HH;
%%
% Cons_inc_re
for i = 1:31
    Expen_pro = FP_total(i*8-7:i*8,:);
    for j = 1:2
        Exp_pro_UR = Expen_pro(:,j*30-29:j*30);
        for k = 1:5
            Exp_inc_sec(:,k) = sum(Exp_pro_UR(:,k*6-5:k*6),2);
        end
        if j ==1
            Expen_2(:,j*5-4:j*5) = Exp_inc_sec;
        else
            Expen_2 = Expen_2 + Exp_inc_sec;
        end
    end
    for j = 1:5
        sec = Expen_2(:,j)';
        Cons_inc_re(i,j*8-7:j*8) = sec;
    end
end

%% Get EP
% EP_sec
for i =1:31
    EP_sec_i = sum(EP_total(i*8-7:i*8,:),2);
    EP_sec(i,:) = EP_sec_i';
end

% Expen_i
EP_House_sec = [];
for i = 1:31
    Expen_pro = EP_total(i*8-7:i*8,:);
    for j = 1:2
        Exp_pro_UR = Expen_pro(:,j*30-29:j*30);
        for k = 1:5
            Exp_inc_sec(:,k) = sum(Exp_pro_UR(:,k*6-5:k*6),2);
        end
        if j ==1
            Expen_2(:,j*5-4:j*5) = Exp_inc_sec;
        else
            Expen_2 = Expen_2 + Exp_inc_sec;
        end
    end
    for j = 1:5
        sec = Expen_2(:,j)';
        Expen_i(i,j*8-7:j*8) = sec;
    end
    EP_U_sec = sum(Expen_pro(:,1:30),2);
    EP_R_sec = sum(Expen_pro(:,31:60),2);
    EP_UR_sec(i,:) = [EP_U_sec',EP_R_sec'];
    for j = 1:6
        EP_AAA_sec = sum(EP_total(i*8-7:i*8,j:6:60),2);
        EP_House_sec(i,j*8-7:j*8) = EP_AAA_sec';
    end
end
%%
for i = 1:6
    EP_House(:,i) = sum(EP_House_sec(:,i*8-7:i*8),2);
end
pop_NUM_HH = pop_NUM.*pop_HH;
EP_HH_cap = EP_House./pop_NUM_HH;
%%
% EP_inc
% EP_inc_re
EP_fam = zeros(31,6);
EP_U = EP_UR_inc_fam(:,1:30);
EP_R = EP_UR_inc_fam(:,31:60);
EP_inc_re = zeros(31,5);
for j = 1:5
    EP_inc_1 = sum(EP_U(:,j*6-5:j*6),2);
    EP_inc_2 = sum(EP_R(:,j*6-5:j*6),2);
    EP_inc_re(:,j) = EP_inc_2 + EP_inc_1;

end

EP_inc = EP_inc_re;
EP_UR = [sum(EP_U,2),sum(EP_R,2)];
EP_UR_cap = EP_UR./pop_NUM_UR;
