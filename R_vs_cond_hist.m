function R_vs_cond_hist(crit)
ensemblesize=50000;
% fig=figure;
batchsize=100;
% crit=0;
for index=1:ensemblesize
    F(index)=parfeval(@loaddata,2,index+0,crit);
end
fig=figure();
% fig=openfig('R_vs_cond.fig');
num_all=0;
for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,rmap1,condzbcp1]=fetchNext(F);
        rmapcell{ii}=rmap1';
        condzbcpcell{ii}=condzbcp1';
    end
       fprintf("%f\r\n",index/ensemblesize*batchsize);
%     scatter([rmapcell{:}],[condzbcpcell{:}],.1,'k','filled');
%     hold on;    
    edges=linspace(0,4,17);
    [num,~]=histcounts([condzbcpcell{:}],edges);
    num_all=num_all+num;
end

histogram('BinEdges',edges,'BinCounts',num_all,'Normalization','probability');
title(strcat('R>',num2str(crit)));
xlabel("G(e^2/h)");
ylabel("Probability");
savefig(strcat('R_vs_cond_R',num2str(crit),'.fig'));
saveas(fig,strcat('R_vs_cond_R',num2str(crit),'.png'));
% [xx,yy]=loaddata(1);

function [rmap2,condzbcp2]=loaddata(index,crit)
% crit=0.06;
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
end