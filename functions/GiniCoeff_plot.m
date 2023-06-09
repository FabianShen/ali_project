
function [G,gra]=GiniCoeff_plot(Pop, Resource,pflag)
%function G=GiniCoeff_plot(Pop, Resource)
%
%computes the Gini coefficient
%Pop is a vector of population (of countries for instance)
%Resource is a vector of resource use NOT PER CAPITA, total for that
%country
%function removes NaNs, and  <0 values for Resource



D= size(Pop); if D(1)<D(2); Pop=Pop'; end
D= size(Resource); if D(1)<D(2); Resource=Resource'; end
iuse = (isnan(Pop)~=1) & (isnan(Resource)~=1) & (Resource>0);
pw = [Pop(iuse),Resource(iuse)./Pop(iuse)];
[pw,~] = sortrows(pw,2);

%ii
fy = pw(:,1)./sum(pw(:,1));
%size(pw)

F = zeros(1,length(fy)+1);S=F;L=F;
F(1,2:end)= cumsum(fy);
S(1,2:end)=cumsum(fy.*pw(:,2));
L = S/S(end);

partarea1= sum(fy(:)'.*L(1:end-1));
partarea2=sum(fy(:)'.*L(2:end));
G= 1 - partarea1-partarea2;

if pflag==1
    
%     figure(40);
%     subplot(m,n,p)
    gra = plot(F,L,'r', 'Linewidth', 2);
    set(gca,'XTick',0:.1:1)
    set(gca,'XTickLabel',{'0','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'})
    set(gca,'YTick',0:.1:1)
    set(gca,'YTickLabel',{'0','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'})
    xlabel('Population')
    ylabel('Resource use')
    grid on
end