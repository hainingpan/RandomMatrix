function re=loaddata_nc(filedir,index)
%re.ZBCP:ZBCP fraction stat    
%re.cond10L/R: conductance 10% fraction stat
%re.cor: correlation stat
%conductance vs R stat

addpath('mi');
% crit=0;
% alpha1list=0:0.001:1;
% alpha2list=alpha1list;
% l1=load(strcat(filedir,'/condmap_nc/condmap_nc_',num2str(index),'.mat'));
% l2=load(strcat(filedir,'/eigvalmap_nc/eigvalmap_nc_',num2str(index),'.mat'));
data=load(sprintf('%s/ensemble_nc_%d.mat',filedir,index));

condmap=data.condmap;
% eigvalmap=data.eigvalmap;
detSmap=data.detSmap;
condmapL=condmap(:,:,1);
condmapR=condmap(:,:,4);
detSmapL=detSmap(:,:,1);

topo_crit=-0.95;
topo_index=(detSmapL<topo_crit);
trivial_index=(detSmapL>topo_crit);

re.topo=sum(topo_index,'all');
re.trivial=sum(trivial_index,'all');

% re.ZBCP=nnz(eigvalmap)/length(alpha1list)^2;
% re.cond10L=nnz(condmapL>1.8 & condmapL<2.2 )/length(alpha1list)^2;
% re.cond10R=nnz(condmapR>1.8 & condmapR<2.2 )/length(alpha1list)^2;
% corrmat=corrcoef(condmapL(:),condmapR(:));
% re.cor=corrmat(1,2);

% edges=linspace(0,4,21);
% re.condL=histcounts(condmapL(:),edges,'Normalization','probability');
% re.condR=histcounts(condmapR(:),edges,'Normalization','probability');
% re.edges=edges;

% [ilist,jlist,~]=find(eigvalmap); % i is y-axis, j is x-axis
% [matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
%  [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
%  d=tanh(d);  %scale to [0,1]
% rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
% 
% condzbcpL=(rmap>crit).*(eigvalmap==1).*condmapL;
% condzbcpR=(rmap>crit).*(eigvalmap==1).*condmapR;
% 
% rmap2=nonzeros(rmap(rmap>crit));
% condzbcp2L=nonzeros(condzbcpL);
% condzbcp2R=nonzeros(condzbcpR);

condmapL_topo=condmapL(topo_index);
condmapL_trivial=condmapL(trivial_index);
condmapR_topo=condmapR(topo_index);
condmapR_trivial=condmapR(trivial_index);

if re.topo>0
    re.mi_topo=mutualinfo(double(condmapL_topo),double(condmapR_topo));
    re.je_topo=jointentropy(double(condmapL_topo),double(condmapR_topo));
else
    re.mi_topo=nan;
    re.je_topo=nan;
end

if re.trivial>0
    re.mi_trivial=mutualinfo(double(condmapL_trivial),double(condmapR_trivial));
    re.je_trivial=jointentropy(double(condmapL_trivial),double(condmapR_trivial));
else
    re.mi_trivial=nan;
    re.je_trivial=nan;
end

end