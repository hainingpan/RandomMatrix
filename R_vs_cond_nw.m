function R_vs_cond_nw(t,L)
ensemblesize=10000;
% fig=figure;
batchsize=100;
% t=0;
% L=2;
for index=1:ensemblesize
    F(index)=parfeval(@loaddata,4,'./M80/N4/Gn0.1',t,L,index+0);
end
figL=figure;
figR=figure;

for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,rmapL,rmapR,condzbcpL,condzbcpR]=fetchNext(F);
        rmapLcell{ii}=rmapL';
        condzbcpLcell{ii}=condzbcpL';
        rmapRcell{ii}=rmapR';
        condzbcpRcell{ii}=condzbcpR';
    end
    fprintf("%f\r\n",index/ensemblesize*batchsize);
    figure(figL);
    scatter([rmapLcell{:}],[condzbcpLcell{:}],.1,'k','filled');
    hold on;   
    figure(figR);
    scatter([rmapRcell{:}],[condzbcpRcell{:}],.1,'k','filled');
    hold on;
end
figure(figL);

xlabel("R");
ylabel("G(e^2/h)");
title("Left");
savefig(figL,sprintf("R_vs_cond_nwL_t%.2fL%d.fig",t,L));
saveas(figL,sprintf("R_vs_cond_nwL_t%.2fL%d.png",t,L));

figure(figR);
xlabel("R");
ylabel("G(e^2/h)");
title("Right");
savefig(figR,sprintf("R_vs_cond_nwR_t%.2fL%d.fig",t,L));
saveas(figR,sprintf("R_vs_cond_nwR_t%.2fL%d.png",t,L));

function [rmapL,rmapR,condzbcpL,condzbcpR]=loaddata(filedir,t,L,index)
crit=0.00;
alpha1list=0:0.001:1;
alpha2list=alpha1list;
l1=load(strcat(filedir,sprintf('/condmapt%.2fL%d/condmapt%.2fL%d_',t,L,t,L),num2str(index),'.mat'));
l2=load(strcat(filedir,sprintf('/eigvalmapt%.2fL%d/eigvalmapt%.2fL%d_',t,L,t,L),num2str(index),'.mat'));
condmap=l1.condmap;
eigvalmap=l2.eigvalmap;
condmapL=condmap(:,:,1);
condmapR=condmap(:,:,4);
eigvalmapL=eigvalmap.*(condmapL>=condmapR);
eigvalmapR=eigvalmap.*(condmapL<=condmapR);

[ilist,jlist,~]=find(eigvalmapL); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmapL,[0.5,1.5],'k');
 [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
 d=tanh(d);  %scale to [0,1]
rmapL=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
condzbcpL=(rmapL>crit).*(eigvalmapL==1).*condmapL;
rmapL=nonzeros(rmapL(rmapL>crit));
condzbcpL=nonzeros(condzbcpL);

[ilist,jlist,~]=find(eigvalmapR); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmapR,[0.5,1.5],'k');
 [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
 d=tanh(d);  %scale to [0,1]
rmapR=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
condzbcpR=(rmapR>crit).*(eigvalmapR==1).*condmapR;
rmapR=nonzeros(rmapR(rmapR>crit));
condzbcpR=nonzeros(condzbcpR);
end
end