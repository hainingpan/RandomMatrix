function R_vs_cond_nc_kde_tall()
ensemblesize=2;
% fig=figure;
% batchsize=1000;
addpath('kde2d');
for index=1:ensemblesize
    fprintf("%d\n",index);
    F(index)=parfeval(@loaddata_nc,4,'./M80/N4/Gn0.1',index+0);
end

rmapLcell=[];
rmapRcell=[];
condzbcpLcell=[];
condzbcpRcell=[];

for ii=1:ensemblesize
    [~,rmapL,rmapR,condzbcpL,condzbcpR]=fetchNext(F);
    if ii==1
        rmapLcell=tall([rmapLcell;rmapL]);
        condzbcpLcell=tall([condzbcpLcell;condzbcpL]);
        rmapRcell=tall([rmapRcell;rmapR]);
        condzbcpRcell=tall([condzbcpRcell;condzbcpR]);
    else
        rmapLcell=[rmapLcell;tall(rmapL)];
        condzbcpLcell=[condzbcpLcell;tall(condzbcpL)];
        rmapRcell=[rmapRcell;tall(rmapR)];
        condzbcpRcell=[condzbcpRcell;tall(condzbcpR)];
    end
    fprintf("%f\n",ii/ensemblesize);
end
    

    
% robustness = linspace(0,max(max(rmapLcell),max(rmapRcell)),100);
% conductance = linspace(0,4,100);
Rmax=gather(max(max(rmapLcell),max(rmapRcell)));

[bandwidthL,fL,XL,YL]=kde2d([rmapLcell,condzbcpLcell],128,[0,0],[Rmax,4]);
[bandwidthR,fR,XR,YR]=kde2d([rmapRcell,condzbcpRcell],128,[0,0],[Rmax,4]);



figL=figure;
surf(XL,YL,fL,'edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("PDF Left");
axis tight;
saveas(figL,'R_vs_cond_ncL_pdf.png');


figR=figure;
surf(XR,YR,fR,'edgecolor','none');
view(2);
colorbar;
xlabel("R");
ylabel("G(e^2/h)");
title("PDF Right");
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

save('R_vs_cond_nc_pdf.mat','fL','fR','robustness','conductance');


function [rmapL,rmapR,condzbcpL,condzbcpR]=loaddata_nc(filedir,index)
crit=0.00;
alpha1list=0:0.001:1;
alpha2list=alpha1list;
l1=load(strcat(filedir,'/condmap_nc/condmap_nc_',num2str(index),'.mat'));
l2=load(strcat(filedir,'/eigvalmap_nc/eigvalmap_nc_',num2str(index),'.mat'));
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
condzbcpL=(rmapL>=crit).*(eigvalmapL==1).*condmapL;
rmapL=nonzeros(rmapL(rmapL>=crit));
condzbcpL=nonzeros(condzbcpL);

[ilist,jlist,~]=find(eigvalmapR); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmapR,[0.5,1.5],'k');
 [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
 d=tanh(d);  %scale to [0,1]
rmapR=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
condzbcpR=(rmapR>=crit).*(eigvalmapR==1).*condmapR;
rmapR=nonzeros(rmapR(rmapR>=crit));
condzbcpR=nonzeros(condzbcpR);
end
end