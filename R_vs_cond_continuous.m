ensemblesize=10000;
crit=0;
filedir='./M80/N4/Gn0.1/';
alpha1list=0:0.001:1;
alpha2list=alpha1list;
etaR=1e-3;
etaG=1e-2;
Rlist=linspace(0,0.14,1000);
Glist=linspace(0,4,400);
[Rmap,Gmap]=meshgrid(Rlist,Glist);
PDF=0;
count=0;
for index=1:ensemblesize
    if mod(index,10)==0
        disp(index)
    end
    load(strcat(filedir,'condmap/condmap',num2str(index),'.mat'));
    load(strcat(filedir,'eigvalmap/eigvalmap',num2str(index),'.mat'));
    [ilist,jlist,klist]=find(eigvalmap); % i is y-axis, j is x-axis
    [matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
     [idx,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
     d=tanh(d);  %scale to [0,1]
    rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
    condzbcp=(rmap>crit).*(eigvalmap==1).*condmap;
    rmapnnz=nonzeros(rmap);
    condzbcpnnz=nonzeros(condzbcp);
    
%     rmapnnz=rmapnnz(1:2);
%     condzbcpnnz=condzbcpnnz(1:2);
    
%     rmapnnz=reshape(rmapnnz,1,1,[]);
%     condzbcpnnz=reshape(condzbcpnnz,1,1,[]);
%     Rcube=repmat(Rmap,1,1,length(rmapnnz));
%     Gcube=repmat(Gmap,1,1,length(condzbcpnnz));
% %     tmp=sum((((Rcube-rmapnnz).^2+etaR^2).*((Gcube-condzbcpnnz).^2+etaG^2)),3);
%     PDF=PDF+1/pi^2*etaR*etaG.*sum(1./(((Rcube-rmapnnz).^2+etaR^2).*((Gcube-condzbcpnnz).^2+etaG^2)),3);
%     count=count+length(rmapnnz);
    
    parfor pindex=1:length(rmapnnz)
        count=count+1;
        PDF=PDF+1/pi^2*etaG*etaR*(1./((Rmap-rmapnnz(pindex)).^2+etaR^2).*1./((Gmap-condzbcpnnz(pindex)).^2+etaG^2));        
    end
end
PDF=PDF/count;
fig=figure;
surf(Rlist,Glist,PDF,'edgecolor','none');view(2);
xlabel("R");
ylabel("G(e^2/h)");
colorbar
% saveas(fig,'R_vs_cond.png');
