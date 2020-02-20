function R_vs_cond_nw_pdf(t,L,start)
ensemblesize=1000;
% fig=figure;
batchsize=1000;
% t=0;
% L=2;
for index=1:ensemblesize
    fprintf("%d\n",index);
    F(index)=parfeval(@loaddata,4,'./M80/N4/Gn0.1',t,L,index+start);
end

rmapLcell=[];
rmapRcell=[];
condzbcpLcell=[];
condzbcpRcell=[];

for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,rmapL,rmapR,condzbcpL,condzbcpR]=fetchNext(F);
        rmapLcell=[rmapLcell,rmapL'];
        condzbcpLcell=[condzbcpLcell,condzbcpL'];
        rmapRcell=[rmapRcell,rmapR'];
        condzbcpRcell=[condzbcpRcell,condzbcpR'];   
    end
    fprintf("%f\r\n",index/ensemblesize*batchsize);   
end
robustness = linspace(0,max(max(rmapLcell),max(rmapRcell)),100);
conductance = linspace(0,4,100);
[robustnessgrid,conductancegrid]=ndgrid(robustness,conductance);
xi=[robustnessgrid(:),conductancegrid(:)];
fL = mvksdensity([rmapLcell;condzbcpLcell]',xi,'Bandwidth',0.1,'Kernel','normpdf','Support',[0,0;Inf,4]);
fR = mvksdensity([rmapRcell;condzbcpRcell]',xi,'Bandwidth',0.1,'Kernel','normpdf','Support',[0,0;Inf,4]);
fL=reshape(fL,[100,100]);
fR=reshape(fR,[100,100]);

figL=figure;
surf(robustness,conductance,fL','edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("Left");
axis tight;
saveas(figL,sprintf("R_vs_cond_nwL_t%.2fL%d.png",t,L));

figR=figure;
surf(robustness,conductance,fR','edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("Right");
axis tight;
saveas(figR,sprintf("R_vs_cond_nwR_t%.2fL%d.png",t,L));

figLlog=figure;
surf(robustness,conductance,log(fL+1)','edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("log(PDF+1) Left");
axis tight;
saveas(figLlog,sprintf("R_vs_cond_nwL_t%.2fL%d_pdf.png",t,L));


figRlog=figure;
surf(robustness,conductance,log(fR+1)','edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("log(PDF+1) Right");
axis tight;
saveas(figRlog,sprintf("R_vs_cond_nwR_t%.2fL%d_pdf.png",t,L));


save(sprintf("R_vs_cond_nw_t%.2fL%d.mat",t,L),'fL','fR','robustness','conductance');



function [rmapL,rmapR,condzbcpL,condzbcpR]=loaddata(filedir,t,L,index)
crit=0.06;
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