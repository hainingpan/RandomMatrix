function R_vs_cond_pdf(start)
ensemblesize=1000;
batchsize=1000;
for index=1:ensemblesize
    F(index)=parfeval(@loaddata,2,index+start);
end

rmapcell=[];
condzbcpcell=[];

for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,rmap,condzbcp]=fetchNext(F);
        rmapcell=[rmapcell,rmap'];
        condzbcpcell=[condzbcpcell,condzbcp'];

    end
    fprintf("%f\r\n",index/ensemblesize*batchsize);
end
figscatter=figure;
scatter(rmapcell(:),condzbcpcell(:),0.1,'k','filled');
xlabel("R");
ylabel("G(e^2/h)");
saveas(figscatter,sprintf('R_vs_cond_%d.png',start));

robustness = linspace(0,max(max(rmapLcell),max(rmapRcell)),100);
conductance = linspace(0,4,100);
[robustnessgrid,conductancegrid]=ndgrid(robustness,conductance);
xi=[robustnessgrid(:),conductancegrid(:)];
f = mvksdensity([rmapcell;condzbcpcell]',xi,'Bandwidth',[0.01,0.1],'Kernel','normpdf','Support',[0,0;Inf,4]);


end

function [rmap2,condzbcp2]=loaddata(index)
crit=0.00;
filedir='./M80/N4/Gn0.1/';
alpha1list=0:0.001:1;
alpha2list=alpha1list;
l1=load(strcat(filedir,'condmap/condmap',num2str(index),'.mat'));
l2=load(strcat(filedir,'eigvalmap/eigvalmap',num2str(index),'.mat'));
condmap=l1.condmap;
eigvalmap=l2.eigvalmap;
[ilist,jlist,~]=find(eigvalmap); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
 [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
 d=tanh(d);  %scale to [0,1]
rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
condzbcp=(rmap>crit).*(eigvalmap==1).*condmap;
rmap2=nonzeros(rmap(rmap>crit));
condzbcp2=nonzeros(condzbcp);
end
