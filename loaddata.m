function re=loaddata(filedir,t,L,index)
%re.ZBCP:ZBCP fraction stat    
%re.cond10L/R: conductance 10% fraction stat
%re.cor: correlation stat
%conductance vs R stat

% crit=0;
alpha1list=0:0.001:1;
alpha2list=alpha1list;
l1=load(strcat(filedir,sprintf('/condmapt%.2fL%d/condmapt%.2fL%d_',t,L,t,L),num2str(index),'.mat'));
l2=load(strcat(filedir,sprintf('/eigvalmapt%.2fL%d/eigvalmapt%.2fL%d_',t,L,t,L),num2str(index),'.mat'));
condmap=l1.condmap;
eigvalmap=l2.eigvalmap;
condmapL=condmap(:,:,1);
condmapR=condmap(:,:,4);
step=0.1;
re.ZBCP=nnz(eigvalmap)/length(alpha1list)^2;
re.cond10L=nnz(condmapL>1.8 & condmapL<2.2 )/length(alpha1list)^2;
re.cond10R=nnz(condmapR>1.8 & condmapR<2.2 )/length(alpha1list)^2;
corrmat=corrcoef(condmapL(:),condmapR(:));
re.cor=corrmat(1,2);

edges=linspace(0,4,21);
re.condL=histcounts(condmapL(:),edges,'Normalization','probability');
re.condR=histcounts(condmapR(:),edges,'Normalization','probability');
re.edges=edges;
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

end