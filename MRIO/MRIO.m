
NUM_SECTORS = 42;
NUM_PROVINCE = 31;
NUM_CONSUMPTION = 5;

opts = detectImportOptions("MRIO2017_42 CEADS.xlsx");
coefficient_matrix = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='D5:AXE1306');
demand_matrix = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='AXG5:BDE1306');
total_input_row = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='D1314:AXE1314');
total_import_row = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='D1307:AXE1307');
total_out_put = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='BDI5:BDI1306');
value_ad_row = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='D1313:AXE1313');
f = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='D1316:AXE1316');
tech_coe_matrix = zeros(NUM_PROVINCE*NUM_SECTORS,NUM_PROVINCE*NUM_SECTORS);
FD = zeros(NUM_PROVINCE*NUM_SECTORS,NUM_PROVINCE);
I = eye(NUM_PROVINCE*NUM_SECTORS);
Y_t = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Table_2017_consistent",Range='BDG5:BDG1306');
X_t = total_out_put;
N_t = value_ad_row;
C_t = X_t' - N_t;
U_t = X_t - Y_t;
%% Transforming coefficient_matrix into technical coefficient matrix %%
for i = 1:NUM_PROVINCE*NUM_SECTORS
    tech_coe_matrix(:,i) = coefficient_matrix(:,i)/total_input_row(1,i);
end

%% Derive Final Demand matrix %%
for i = 1:NUM_PROVINCE
    FD(:,i) = sum(demand_matrix(:,i*NUM_CONSUMPTION - 4:i*NUM_CONSUMPTION-2),2);
end
% FD(FD == 0) = 10e-18;

%% Derive direct intensity vector %%
% clean unzero term
for i = 1:1302
    if f(i) < 0.0001
        f(i) = 0;
    end
end
for i = 1:1302
    if total_input_row(i) < 10
        f(i) = 0;
    end
end
f_intensity_matrix = f*10e6./total_input_row;

% %% Final computation
% footprint_product = diag(f_intensity_matrix)/(I-tech_coe_matrix)*FD;
% footprint_product_two = f_intensity_matrix/(I - tech_coe_matrix)*FD;

%% Do RAS
% X = coefficient_matrix*diag(X_t);
% X(X ==0) = 0.00000000000001;
% A_t = tech_coe_matrix;
% for i = 500  
%     r = U_t./sum(X,2);
%     X = diag(r)*X;
%     s = C_t./sum(X,1);
%     X = X*diag(s);
%     A_t = diag(r)*A_t*diag(s);
% end

footprint_product = zeros(NUM_PROVINCE,NUM_PROVINCE*NUM_SECTORS);

%% Do the rest
% footprint_matrix derives country_1 demand for industry_j of country_i
% footprint_product derives country_i demand for industry_j of country_i
e = inv(I - tech_coe_matrix);
for i = 1:31
    footprint_matrix = f_intensity_matrix * e .* (FD(:,i)');
    footprint_product(i,:) = footprint_matrix;
end

footprint_product = sum(footprint_product,1);
footprint_product_refined = zeros(NUM_PROVINCE,NUM_SECTORS);

for i = 1:31
    footprint_product_refined(i,:) = footprint_product(1,i*42-41:i*42);
end