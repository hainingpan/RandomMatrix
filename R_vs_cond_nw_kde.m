function R_vs_cond_nw_kde(filedir,t,L)
ensemblesize=1000;
% fig=figure;
batchsize=100;
addpath('kde2d');
% filedir='./M80/N4/Gn0.1';
for index=1:ensemblesize
    fprintf("%d\n",index);
    F(index)=parfeval(@loaddata_nw,1,filedir,t,L,index+0);
end

rmapL_topo=[];
rmapR_topo=[];
condzbcpL_topo=[];
condzbcpR_topo=[];
rmapL_trivial=[];
rmapR_trivial=[];
condzbcpL_trivial=[];
condzbcpR_trivial=[];

for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [~,re]=fetchNext(F);
        rmapL_topo=[rmapL_topo,re.rmapL_topo'];
        rmapL_trivial=[rmapL_trivial,re.rmapL_trivial'];
        rmapR_topo=[rmapR_topo,re.rmapR_topo'];
        rmapR_trivial=[rmapR_trivial,re.rmapR_trivial'];
        condzbcpL_topo=[condzbcpL_topo,re.condzbcpL_topo'];
        condzbcpL_trivial=[condzbcpL_trivial,re.condzbcpL_trivial'];
        condzbcpR_topo=[condzbcpR_topo,re.condzbcpR_topo'];
        condzbcpR_trivial=[condzbcpR_trivial,re.condzbcpR_trivial'];
    end
    fprintf("%f\r\n",index/ensemblesize*batchsize);   
end
% robustness = linspace(0,max(max(rmapLcell),max(rmapRcell)),100);
% conductance = linspace(0,4,100);
% [robustnessgrid,conductancegrid]=ndgrid(robustness,conductance);
% xi=[robustnessgrid(:),conductancegrid(:)];
% fL = mvksdensity([rmapLcell;condzbcpLcell]',xi,'Bandwidth',[0.01,0.1],'Kernel','normpdf','Support',[0,0;Inf,4]);
% fR = mvksdensity([rmapRcell;condzbcpRcell]',xi,'Bandwidth',[0.01,0.1],'Kernel','normpdf','Support',[0,0;Inf,4]);
% fL=reshape(fL,[100,100]);
% fR=reshape(fR,[100,100]);

rmap_topo_max=max(max(rmapL_topo),max(rmapR_topo));
len_topoL=length(rmapL_topo);
len_topoR=length(rmapR_topo);
if len_topoL>0
    [bandwidth_topo_L,pdf_topo_L,rmap_topo_L,cond_topo_L]=kde2d([rmapL_topo;condzbcpL_topo]',128,[0,0],[rmap_topo_max,4]);
else
    pdf_topo_L=nan;
    rmap_topo_L=nan;
    cond_topo_L=nan;
end

if len_topoR>0
    [bandwidth_topo_R,pdf_topo_R,rmap_topo_R,cond_topo_R]=kde2d([rmapR_topo;condzbcpR_topo]',128,[0,0],[rmap_topo_max,4]);
else
    pdf_topo_R=nan;
    rmap_topo_R=nan;
    cond_topo_R=nan;
end

rmap_trivial_max=max(max(rmapL_trivial),max(rmapR_trivial));
len_trivialL=length(rmapL_trivial);
len_trivialR=length(rmapR_trivial);
if len_trivialL>0
    [bandwidth_trivial_L,pdf_trivial_L,rmap_trivial_L,cond_trivial_L]=kde2d([rmapL_trivial;condzbcpL_trivial]',128,[0,0],[rmap_trivial_max,4]);
else
    pdf_trivial_L=nan;
    rmap_trivial_L=nan;
    cond_trivial_L=nan;
end

if len_trivialR>0
    [bandwidth_trivial_R,pdf_trivial_R,rmap_trivial_R,cond_trivial_R]=kde2d([rmapR_trivial;condzbcpR_trivial]',128,[0,0],[rmap_trivial_max,4]);
else
    pdf_trivial_R=nan;
    rmap_trivial_R=nan;
    cond_trivial_R=nan;
end

% figL=figure;
% surf(XL,YL,fL,'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("Left");
% axis tight;
% saveas(figL,sprintf("R_vs_cond_nwL_t%.2fL%d_pdf.png",t,L));

% figR=figure;
% surf(XR,YR,fR,'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("Right");
% axis tight;
% saveas(figR,sprintf("R_vs_cond_nwR_t%.2fL%d_pdf.png",t,L));

% figLlog=figure;
% surf(XL,YL,log(fL+1),'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("log(PDF+1) Left");
% axis tight;
% saveas(figLlog,sprintf("R_vs_cond_nwL_t%.2fL%d_pdf_log.png",t,L));


% figRlog=figure;
% surf(XR,YR,log(fR+1),'edgecolor','none');
% view(2);
% colorbar;
% xlabel("R");
% ylabel("G(e^2/h)");
% title("log(PDF+1) Right");
% axis tight;
% saveas(figRlog,sprintf("R_vs_cond_nwR_t%.2fL%d_pdf_log.png",t,L));


% save(sprintf("R_vs_cond_nw_t%.2fL%d.mat",t,L),'fL','fR','XL','YL','XR','YR');
save(sprintf("R_vs_cond_nw_t%.2fL%d.mat",t,L),'pdf_topo_L','pdf_topo_R','rmap_topo_L','rmap_topo_R','cond_topo_L','cond_topo_R','pdf_trivial_L','pdf_trivial_R','rmap_trivial_L','rmap_trivial_R','cond_trivial_L','cond_trivial_R','len_topoL','len_topoR','len_trivialL','len_trivialR');



function re=loaddata_nw(filedir,t,L,index)
crit=0.00;
alpha1list=0:0.001:1;
alpha2list=alpha1list;
% l1=load(strcat(filedir,sprintf('/condmapt%.2fL%d/condmapt%.2fL%d_',t,L,t,L),num2str(index),'.mat'));
% l2=load(strcat(filedir,sprintf('/eigvalmapt%.2fL%d/eigvalmapt%.2fL%d_',t,L,t,L),num2str(index),'.mat'));
data=load(sprintf('%s/ensemble_t%.2fL%d_%d.mat',filedir,t,L,index));

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

eigvalmapL=eigvalmap.*(condmapL>=condmapR);
eigvalmapR=eigvalmap.*(condmapL<=condmapR);

% [ilist,jlist,~]=find(eigvalmapL); % i is y-axis, j is x-axis
% [matcont,~]=contour(alpha1list,alpha2list,eigvalmapL,[0.5,1.5],'k');
%  [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
% %  d=tanh(d);  %scale to [0,1]
% rmapL=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));

rmapL=get_r(alpha1list,alpha2list,eigvalmapL,crit);
rmapR=get_r(alpha1list,alpha2list,eigvalmapR,crit);


re.rmapL_topo=nonzeros(rmapL.*topo_index);
re.rmapL_trivial=nonzeros(rmapL.*trivial_index);

re.rmapR_topo=nonzeros(rmapR.*topo_index);
re.rmapR_trivial=nonzeros(rmapR.*trivial_index);

re.condzbcpL_topo=nonzeros((eigvalmapL==1).*condmapL.*topo_index);
re.condzbcpR_topo=nonzeros((eigvalmapR==1).*condmapR.*topo_index);

re.condzbcpL_trivial=nonzeros((eigvalmapL==1).*condmapL.*trivial_index);
re.condzbcpR_trivial=nonzeros((eigvalmapR==1).*condmapR.*trivial_index);



% condzbcpL=(rmapL>crit).*(eigvalmapL==1).*condmapL;
% rmapL=nonzeros(rmapL(rmapL>crit));
% condzbcpL=nonzeros(condzbcpL);

% [ilist,jlist,~]=find(eigvalmapR); % i is y-axis, j is x-axis
% [matcont,~]=contour(alpha1list,alpha2list,eigvalmapR,[0.5,1.5],'k');
%  [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
% %  d=tanh(d);  %scale to [0,1]
% rmapR=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
% condzbcpR=(rmapR>crit).*(eigvalmapR==1).*condmapR;
% rmapR=nonzeros(rmapR(rmapR>crit));
% condzbcpR=nonzeros(condzbcpR);
end
end