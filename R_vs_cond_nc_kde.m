function R_vs_cond_nc_kde(filedir)
ensemblesize=1000;
% fig=figure;
batchsize=100;
addpath('kde2d');
% filedir='./M80/N4/Gn0.1';
for index=1:ensemblesize
    fprintf("%d\n",index);
    F(index)=parfeval(@loaddata_nc,1,filedir,index+0000);
end

rmap_topo=[];
condzbcpL_topo=[];
condzbcpR_topo=[];
rmap_trivial=[];
condzbcpL_trivial=[];
condzbcpR_trivial=[];

for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,re]=fetchNext(F);
        rmap_topo=[rmap_topo,re.rmap_topo'];
        rmap_trivial=[rmap_trivial,re.rmap_trivial'];
        condzbcpL_topo=[condzbcpL_topo,re.condzbcpL_topo'];
        condzbcpL_trivial=[condzbcpL_trivial,re.condzbcpL_trivial'];
        condzbcpR_topo=[condzbcpR_topo,re.condzbcpR_topo'];
        condzbcpR_trivial=[condzbcpR_trivial,re.condzbcpR_trivial'];
    end
    fprintf("%f\r\n",index/ensemblesize*batchsize);   
end
len_topo=length(rmap_topo);
if len_topo>0
    [bandwidth_topo_L,pdf_topo_L,rmap_topo_L,cond_topo_L]=kde2d([rmap_topo;condzbcpL_topo]',128,[0,0],[max(rmap_topo),4]);
    [bandwidth_topo_R,pdf_topo_R,rmap_topo_R,cond_topo_R]=kde2d([rmap_topo;condzbcpR_topo]',128,[0,0],[max(rmap_topo),4]);
else
    pdf_topo_L=nan;
    rmap_topo_L=nan;
    cond_topo_L=nan;
    pdf_topo_R=nan;
    rmap_topo_R=nan;
    cond_topo_R=nan;
end
len_trivial=length(rmap_trivial);
if len_trivial>0
    [bandwidth_trivial_L,pdf_trivial_L,rmap_trivial_L,cond_trivial_L]=kde2d([rmap_trivial;condzbcpL_trivial]',128,[0,0],[max(rmap_trivial),4]);
    [bandwidth_trivial_R,pdf_trivial_R,rmap_trivial_R,cond_trivial_R]=kde2d([rmap_trivial;condzbcpR_trivial]',128,[0,0],[max(rmap_trivial),4]);
else
    pdf_trivial_L=nan;
    rmap_trivial_L=nan;
    cond_trivial_L=nan;
    pdf_trivial_R=nan;
    rmap_trivial_R=nan;
    cond_trivial_R=nan;
end
% figL=figure;
% surf(rmap_topo_L,cond_topo_L,pdf_topo_L,'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("PDF 1");
% axis tight;
% saveas(figL,'R_vs_cond_ncL_pdf.png');


% figR=figure;
% surf(rmap_topo_R,cond_topo_R,pdf_topo_R,'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("PDF 2");
% axis tight;
% saveas(figR,'R_vs_cond_ncR_pdf.png');

% figLlog=figure;
% surf(rmap_topo_L,cond_topo_L,log(pdf_topo_L+1),'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("log(PDF+1) Left");
% axis tight;
% saveas(figLlog,'R_vs_cond_ncL_pdf_log.png');


% figRlog=figure;
% surf(rmap_topo_R,cond_topo_R,log(pdf_topo_R+1),'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("log(PDF+1) Right");
% axis tight;
% saveas(figRlog,'R_vs_cond_ncR_pdf_log.png');

save('R_vs_cond_nc_pdf.mat','pdf_topo_L','pdf_topo_R','rmap_topo_L','rmap_topo_R','cond_topo_L','cond_topo_R','pdf_trivial_L','pdf_trivial_R','rmap_trivial_L','rmap_trivial_R','cond_trivial_L','cond_trivial_R','len_topo','len_trivial');


function re=loaddata_nc(filedir,index)

crit=0.00;
alpha1list=0:0.001:1;
alpha2list=alpha1list;
% l1=load(strcat(filedir,'/condmap_nc/condmap_nc_',num2str(index),'.mat'));
% l2=load(strcat(filedir,'/eigvalmap_nc/eigvalmap_nc_',num2str(index),'.mat'));
data=load(sprintf('%s/ensemble_nc_%d.mat',filedir,index));

condmap=data.condmap;
eigvalmap=data.eigvalmap;
detSmap=data.detSmap;

% condmap=l1.condmap;
% eigvalmap=l2.eigvalmap;
condmapL=condmap(:,:,1);
condmapR=condmap(:,:,4);
detSmapL=detSmap(:,:,1);

topo_crit=-0.95;
topo_index=(detSmapL<topo_crit);
trivial_index=(detSmapL>=topo_crit);

% [ilist,jlist,~]=find(eigvalmap); % i is y-axis, j is x-axis
% [matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
% [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
% %  d=tanh(d);  %scale to [0,1]
% rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));

rmap=get_r(alpha1list,alpha2list,eigvalmap,crit);
re.rmap_topo=nonzeros(rmap.*topo_index);
re.rmap_trivial=nonzeros(rmap.*trivial_index);

re.condzbcpL_topo=nonzeros((eigvalmap==1).*condmapL.*topo_index);
re.condzbcpR_topo=nonzeros((eigvalmap==1).*condmapR.*topo_index);

re.condzbcpL_trivial=nonzeros((eigvalmap==1).*condmapL.*trivial_index);
re.condzbcpR_trivial=nonzeros((eigvalmap==1).*condmapR.*trivial_index);

end
end