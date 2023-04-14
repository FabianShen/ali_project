function [increase, dert] = idabar(FP_inc_re,EP_inc,sector,HH,pop)
FP_inc_re = FP_inc_re./pop.*100./31.*5;
EP_inc = EP_inc./pop./31;

[~,derX] = inc_ida(fliplr(FP_inc_re),fliplr(EP_inc),HH);
disp(derX)
dert = derX./sum(derX,2);
disp(sum(derX,2))

increase = sum(FP_inc_re,1);
disp(sum(FP_inc_re,1))
my_waterfall(derX,sector,fliplr(FP_inc_re),["Household size","Expenditure","GHG intensity"])
disp(derX)