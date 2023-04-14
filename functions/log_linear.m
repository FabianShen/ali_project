function [R] = log_linear(ep,fp)
%% Derive the equality of expenditure and footprint
% Use E_2018 to caulculate footprint
% only input is expenditure(Not final_demand)
% Use logy = ax + b
% exp X*Y
logfp = log(fp);
X = reshape(ep,[],1);
X(:,2) = 1;
Y = reshape(logfp,[],1);
B = inv(X'*X)*X'*Y;
a = B(1);b = B(2);
ep = X(:,1);

%% test
% disp(size(X))
% disp(size(Y))

%% get R^2
mx = mean(ep);
my = mean(Y);
ss_xx = sum((ep-mx).^2);
ss_yy = sum((Y-my).^2);
ss_xy = sum((ep-mx).*(Y-my));
%b=ss_xy/ss_xx;
%a = my - b*mx;
R = sqrt(ss_xy^2/(ss_xx*ss_yy));
R = R.^2;

%% plot the chart
figure
scatter(reshape(ep,[],1),reshape(fp,[],1))
%ylim([0,10^12])
hold on
ep = sort(ep);
logyfit = ep*a +b;
plot(ep,exp(logyfit))

daspect auto