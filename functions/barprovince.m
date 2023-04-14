function [province,pro_fp] = barprovince(footprint_table,pop)
province = readmatrix("MRIO2017_42 CEADS.xlsx",Sheet="Province",Range='C2:C32',OutputType='string');
pro_fp = sum(footprint_table,2);
pro_fp = pro_fp./pop.*100;
pro_1 = province(1:8);
pro_2 = province(9:16);
pro_3 = province(17:24);
pro_4 = province(25:31);

figure
set(gca, 'YTick', 1:8)
ylim([0 8])

subplot(2,2,1)
barh(pro_fp(1:8))
set(gca, 'YTickLabel', pro_1)
xlabel('tCO2 per capita')
xlim([0,10])

subplot(2,2,2)
barh(pro_fp(9:16))
set(gca, 'YTickLabel', pro_2)
xlabel('tCO2 per capita')
xlim([0,10])

subplot(2,2,3)
barh(pro_fp(17:24))
set(gca, 'YTickLabel', pro_3)
xlabel('tCO2 per capita')
xlim([0,10])

subplot(2,2,4)
barh(pro_fp(25:31))
set(gca, 'YTickLabel', pro_4)
xlabel('tCO2 per capita')
xlim([0,10])
%%
figure
[pro_fp,idx] = sort(pro_fp);
province = province(idx);

ylim([0 31])
barh(pro_fp)
set(gca, 'YTick', 1:31)
set(gca,'YTickLabel',province)

xlabel('tCO2 per capita')
xlim([0,10])