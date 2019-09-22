ensemblesize=10000;
fig=figure;
tmpcont=figure;
crit=0;
filedir='./M80/N4/Gn0.1/';
alpha1list=0:0.001:1;
alpha2list=alpha1list;
for index=1:ensemblesize
    if mod(index,10)==0
        disp(index)
    end
    load(strcat(filedir,'condmap/condmap',num2str(index),'.mat'));
    load(strcat(filedir,'eigvalmap/eigvalmap',num2str(index),'.mat'));
    [ilist,jlist,klist]=find(eigvalmap); % i is y-axis, j is x-axis
    figure(tmpcont);
    [matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
     [idx,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
     d=tanh(d);  %scale to [0,1]
    rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
    condzbcp=(rmap>crit).*(eigvalmap==1).*condmap;
    figure(fig);
    scatter(nonzeros(rmap),nonzeros(condzbcp),'.','k');
    hold on;
end
figure(fig);
xlabel("R");
ylabel("G(e^2/h)");
saveas(fig,'R_vs_cond.png');
