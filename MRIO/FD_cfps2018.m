%%% make Final demand from cfps2018
%% output: FD_fam FD_inc FD_total E_2018
[value_F,model_F] = xlsread("model_F.xls");
[~,sector] = xlsread("sector.xlsx");
%%
pop_inv = xlsread("Consumption_Expenditure_2018.xlsx",'Sheet1');
[~,sector_inc] = xlsread("ida.xlsx","Sheet2");
[~,sector_inc_qua] = xlsread("ida_qua.xlsx","Sheet2");
HH = xlsread("ida.xlsx","Sheet1"); % Household size
HH_qua = xlsread("ida_qua.xlsx","Sheet1"); % Household size
pop = zeros(31,5);
for i = 1:5
    pop(:,i) = pop_inv(:,6-i);
end
%%
FD_total = reshape(value_F,[248,40]);

FD_inc = zeros(248,5);
FD_fam = zeros(248,8);
for i = 1:5
    FD_inc(:,i) = sum(FD_total(:,i*8-7:i*8),2);
end

for i = 1:8
    FD_fam(:,i) = sum(FD_total(:,i:8:40),2);
end

% delete the extra entry
% form 1302^2 into 248^2
trans1_mx = zeros(1302,248);
trans2_mx = zeros(248,1302);
trans3_mx = zeros(1302,1);

% picked vector from CEADS2017
pick_value = [6;7;29;30;34;38;40;41];
col = 1;
for i = 1:31
    for j = pick_value(1:1:8,1)'
        trans1_mx(i*j,col) = 1;
        col = col + 1;
    end
end
row = 1;
for i = 1:31
    for j = pick_value(1:1:8,1)'
        trans2_mx(row,i*j) = 1;
        row = row + 1;
    end
end
E_2018 = trans2_mx*e*trans1_mx;
col = 1;


for i = 1:31
    for j = pick_value(1:1:8,1)'
        trans3_mx(i*j,col) = 1;
        col = col + 1;
    end
end

%% MRIO
I_2018 = f_intensity_matrix*trans3_mx;
Cons_2018 = I_2018*E_2018.*FD_total';
Cons_2018 = Cons_2018';
Cons_fam = I_2018*E_2018.*FD_fam';
Cons_fam = Cons_fam';
Cons_inc = I_2018*E_2018.*FD_inc';
Cons_inc = Cons_inc';


%% reshape the output
% reshape final demand

% reshape income demand
Cons_inc_re = zeros(31,40);
for i = 1:31
    for j = 1:5
        for k = 1:8
            Cons_inc_re(i,(j-1)*8+k) = Cons_inc((i-1)*8+k,j);
        end
    end
end
FP_inc_re = zeros(31,5);
for i = 1:5
    FP_inc_re(:,i) = sum(Cons_inc_re(:,i*8-7:i*8),2);
end

% reshape family demand
Cons_fam_re = zeros(31,40);
for i = 1:31
    for j = 1:8
        for k = 1:8
            Cons_fam_re(i,(j-1)*8+k) = Cons_fam((i-1)*8+k,j);
        end
    end
end
FP_fam_re = zeros(31,8);
for i = 1:8
    FP_fam_re(:,i) = sum(Cons_fam_re(:,i*8-7:i*8),2);
end

% reshape sector demand
FP_sec_re = zeros(31,8);
for i = 1:8
    FP_sec_re(:,i) = sum(Cons_inc_re(:,i:5:40),2);
end

%% reshape expenditure
Expen_i = zeros(31,40);
for i = 1:31
    for j = 1:5
        for k = 1:8
            Expen_i(i,(j-1)*8+k) = FD_inc((i-1)*8+k,j);
        end
    end
end

Expen_f = zeros(31,64);
for i = 1:31
    for j = 1:8
        for k = 1:8
            Expen_f(i,(j-1)*8+k) = FD_fam((i-1)*8+k,j);
        end
    end
end
EP_inc = zeros(31,5);
for i = 1:5
    EP_inc(:,i) = sum(Expen_i(:,i*8-7:i*8),2);
end
EP_sec = zeros(31,8);
for i = 1:8
    EP_sec(:,i) = sum(Expen_i(:,i:8:40),2);
end
EP_fam = zeros(31,8);
for i = 1:8
    EP_fam(:,i) = sum(Expen_f(:,i*8-7:i*8),2);
end