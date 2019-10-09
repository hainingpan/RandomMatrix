ensemblesize=300;
fig=figure;

for index=1:ensemblesize
%     if mod(index,10)==0
% %         disp(index)
%     end
    F(index)=parfeval(@loaddata,2,index);
end
figure(fig);
for index=1:ensemblesize    
    [completedIdx,rmap,condzbcp]=fetchNext(F);
    scatter(nonzeros(rmap),nonzeros(condzbcp),.1,'k');
    hold on;    
end
xlabel("R");
ylabel("G(e^2/h)");
savefig('R_vs_cond.fig');
saveas(fig,'R_vs_cond.png');
% [xx,yy]=loaddata(1);

function [rmap2,condzbcp2]=loaddata(index)
crit=0.06;
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
