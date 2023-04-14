function INFPbar(FP_inc_re,EP_inc,sector_inc,HH,pop)
FP_inc_re = FP_inc_re./pop*100;
EP_inc = EP_inc./pop;
figure
% [IN,~] = inc_ida(FP_inc_re,EP_inc,HH);
yyaxis left
c = summer(size(EP_inc,2));
a = fliplr(sum(FP_inc_re,1));
a = a./31.*5;
b = diag(a);
disp(a)
d = bar(b,'stacked');
for i = 1:size(EP_inc,2)
    set(d(i),"facecolor",c(i,:))
end
ylabel("Per capita carbon footprint(t CO2)");
set(gca,'xticklabel',sector_inc)
xlabel("Income class");

IN = sum(FP_inc_re.*pop*10e4,1)./sum(EP_inc.*pop,1);

IN = fliplr(IN);

yyaxis right
len = size(EP_inc,2);
x = 1:len;
sca = scatter(x,IN',"^","filled");
legend(sca,"Intensity")
ylabel("Emission intensity(t CO2/10K CNY)")
% ylim([12,14])
