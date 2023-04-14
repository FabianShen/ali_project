load("FD_per_sep.mat")
load("demand.mat")
FD_urban = zeros(31*42,31*30);
FD_rural = zeros(31*42,31*30);
a = demand_matrix(:,1:5:155);
b = demand_matrix(:,2:5:155);
UR = FD_per_sep{1};
RU = FD_per_sep{2};
for i = 1:31
    FD_urban(:,i*30-29:i*30) = UR(:,i*30-29:i*30).*b(:,i);
    FD_rural(:,i*30-29:i*30) = RU(:,i*30-29:i*30).*a(:,i);
end
for i = 1:31
    FD(:,i*60-59:i*60) = [FD_urban(:,i*30-29:i*30),FD_rural(:,i*30-29:i*30)];
end
