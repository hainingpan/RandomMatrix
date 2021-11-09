function R_vs_cond_nc_kde()
ensemblesize=10000;
% fig=figure;
batchsize=10000;
addpath('kde2d');
for index=1:ensemblesize
    fprintf("%d\n",index);
    F(index)=parfeval(@loaddata_nc,3,'./M80/N4/Gn0.1',index+0000);
end

rmapcell=[];
condzbcpLcell=[];
condzbcpRcell=[];

for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,rmap,condzbcpL,condzbcpR]=fetchNext(F);
        rmapcell=[rmapcell,rmap'];
        condzbcpLcell=[condzbcpLcell,condzbcpL'];
        condzbcpRcell=[condzbcpRcell,condzbcpR'];   
    end
    fprintf("%f\r\n",index/ensemblesize*batchsize);   
end

[bandwidthL,fL,XL,YL]=kde2d([rmapcell;condzbcpLcell]',128,[0,0],[max(max(rmapcell),max(rmapcell)),4]);
[bandwidthR,fR,XR,YR]=kde2d([rmapcell;condzbcpRcell]',128,[0,0],[max(max(rmapcell),max(rmapcell)),4]);

figL=figure;
surf(XL,YL,fL,'edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("PDF 1");
axis tight;
saveas(figL,'R_vs_cond_ncL_pdf.png');


figR=figure;
surf(XR,YR,fR,'edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("PDF 2");
axis tight;
saveas(figR,'R_vs_cond_ncR_pdf.png');

figLlog=figure;
surf(XL,YL,log(fL+1),'edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("log(PDF+1) Left");
axis tight;
saveas(figLlog,'R_vs_cond_ncL_pdf_log.png');


figRlog=figure;
surf(XR,YR,log(fR+1),'edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("log(PDF+1) Right");
axis tight;
saveas(figRlog,'R_vs_cond_ncR_pdf_log.png');

save('R_vs_cond_nc_pdf.mat','fL','fR','XL','XR','YL','YR');


function [rmap,condzbcpL,condzbcpR]=loaddata_nc(filedir,index)
crit=0.00;
alpha1list=0:0.001:1;
alpha2list=alpha1list;
l1=load(strcat(filedir,'/condmap_nc/condmap_nc_',num2str(index),'.mat'));
l2=load(strcat(filedir,'/eigvalmap_nc/eigvalmap_nc_',num2str(index),'.mat'));
condmap=l1.condmap;
eigvalmap=l2.eigvalmap;
condmapL=condmap(:,:,1);
condmapR=condmap(:,:,4);

[ilist,jlist,~]=find(eigvalmap); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
[~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
%  d=tanh(d);  %scale to [0,1]
rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
condzbcpL=(rmap>=crit).*(eigvalmap==1).*condmapL;
condzbcpR=(rmap>=crit).*(eigvalmap==1).*condmapR;
rmap=nonzeros(rmap(rmap>=crit));
condzbcpL=nonzeros(condzbcpL);
condzbcpR=nonzeros(condzbcpR);
end
end