function [R,a,b] = FPvsEXP(ep,fp,sector,pop)
%% Derive the equality of expenditure and footprint
% Use E_2018 to caulculate footprint
% only input is expenditure(Not final_demand)
% Use logy = ax + b
% exp X*Y
ep = ep./pop;
fp = fp./pop.*100;
logfp = log(fp);
logexp = log(ep);
X = reshape(logexp,[],1);
X(:,2) = 1;
Y = reshape(logfp,[],1);
B = inv(X'*X)*X'*Y;
a = B(1);b = B(2);
logexp = X(:,1);

%% get R^2
mx = mean(logexp);
my = mean(Y);
ss_xx = sum((logexp-mx).^2);
ss_yy = sum((Y-my).^2);
ss_xy = sum((logexp-mx).*(Y-my));
%b=ss_xy/ss_xx;
%a = my - b*mx;
R = sqrt(ss_xy^2/(ss_xx*ss_yy));
R = R.^2;

%% plot chart
c = winter(size(ep,2));
%%
figure
logexp = sort(logexp);
logyfit = logexp*a +b;
loglog(exp(logexp),exp(logyfit),'--r')
hold on
for i = 1:size(ep,2)
    g = scatter(ep(:,i),fp(:,i));
    set(g,'Marker','^')
    set(g,'MarkerEdgeColor',c(i,:))
    set(g,'MarkerFaceColor',c(i,:))
    hold on
end


legend(sector)

xlabel('Expenditure /year /capita')
ylabel('Energy footprint /year /capita')