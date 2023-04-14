function [G_f,G_e,tb20] = caulgini(Cons_inc_re,Expen_i,pop,sector) 

%%
% load MRIO.m
% get footprint_product_refined
G_f = zeros([8,1]);
G_e = zeros([8,1]);
marker = {'^'};
color = parula(8);
tb20 = zeros(8,2);
%%
figure
for i = 1:8
    Cons_sec = Cons_inc_re(:,i:8:length(Cons_inc_re(1,:)));
    [G_f(i),g] = GiniCoeff_plot(pop,Cons_sec,1);
    set(g,'Marker',marker,"markersize",2)
    set(g,'LineStyle','none')
    set(g,'MarkerEdgeColor',color(i,:))
    hold on
    disp(sum(Cons_sec,"all"))
    disp([sum(Cons_sec(:,1),1),sum(Cons_sec(:,2),1)])
    disp(sum(Cons_sec,1))
    tb20(i,:) = [sum(Cons_sec(:,1),1),sum(Cons_sec(:,5),1)]; 
end
tb20 = sum(tb20,1)./sum(Cons_inc_re,"all");
legend(sector)
line([0,1],[0,1])
%%
figure
for i = 1:8
    Exp_sec = Expen_i(:,i:8:length(Expen_i(1,:)));
    [G_e(i),g] = GiniCoeff_plot(pop,Exp_sec,1);
    set(g,'Marker',marker,"markersize",2)
    set(g,'LineStyle','none')
    set(g,'MarkerEdgeColor',color(i,:))
    hold on
end
legend(sector)
line([0,1],[0,1])
end