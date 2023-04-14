function [x_n,y_n,sort_number] = plot_sort(x,y)
%% [x,y] = plot_sort(x,y) sort discord pot into smooth curve

% initializing
x = reshape(x,1,length(x));
y = reshape(y,1,length(y));
x_n = sort(x);
y_n = zeros(1,length(y));

sort_number = zeros(length(x),length(x));

for i = 1:length(x)
    sort_number(i,:) = logical(x_n(i) == x);
end

% disp(sort_number)

% disp(size(y))

for i = 1:length(x)
    count = sum(sort_number(i,(sort_number(i,:)==1)));
    sort_number(i,:) = sort_number(i,:)/count;
end
for i = 1:length(x)
    y_n(i) = sort_number(i,:)*y';
end
x_n = x_n';
y_n = y_n';
%% test
% disp(y)
% disp(y_n)
% plot(x,y)
% figure
% plot(x_n,y_n,'g-')
