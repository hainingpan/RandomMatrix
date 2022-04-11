function stat_nw(directory,t,L)
% directory='./M80/N4/Gn0.1'
fn=dir(sprintf('%s/ensemble_t%.2fL%d_*.mat',directory,t,L));
ensemblesize=size(fn,1);
% t=1;
% L=10;
batchsize=min(100,ensemblesize);
for index=1:ensemblesize
    F(index)=parfeval(@loaddata_nw,1,directory,t,L,index+0);
end
% ZBCPensemble=zeros(length(ensemblesize),1);
% cond10Lensemble=zeros(length(ensemblesize),1);
% cond10Rensemble=zeros(length(ensemblesize),1);
% corensemble=zeros(length(ensemblesize),1);
% condLensemble=zeros(length(ensemblesize),20);
% condRensemble=zeros(length(ensemblesize),20);

mi_topo_ensemble=zeros(length(ensemblesize),1);
je_topo_ensemble=zeros(length(ensemblesize),1);
mi_trivial_ensemble=zeros(length(ensemblesize),1);
je_trivial_ensemble=zeros(length(ensemblesize),1);
topo_ensemble=zeros(length(ensemblesize),1);
trivial_ensemble=zeros(length(ensemblesize),1);
for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [idx,re]=fetchNext(F);
        % ZBCPensemble(idx)=re.ZBCP;
        % cond10Lensemble(idx)=re.cond10L;
        % cond10Rensemble(idx)=re.cond10R;
        % corensemble(idx)=re.cor;
        % condLensemble(idx,:)=re.condL;
        % condRensemble(idx,:)=re.condR;
        mi_topo_ensemble(idx,:)=re.mi_topo;
        je_topo_ensemble(idx,:)=re.je_topo;
        mi_trivial_ensemble(idx,:)=re.mi_trivial;
        je_trivial_ensemble(idx,:)=re.je_trivial;
        topo_ensemble(idx,:)=re.topo;
        trivial_ensemble(idx,:)=re.trivial;
    end
       fprintf("%f\n",index/ensemblesize*batchsize);
end

%Conductance statistics
% edges=linspace(0,4,21); % needs to manually match loaddata.m
% fig1=figure;
% histogram('BinEdges',edges,'BinCounts',mean(condLensemble,1),'FaceColor','r','FaceAlpha',0.4,'DisplayName','G_{LL}');
% xlabel('$G(\frac{e^2}{h})$','Interpreter','latex');
% ylabel('Probility');
% title(sprintf("t=%.2f,L=%d Conductance statistics",t,L));
% hold on;
% histogram('BinEdges',edges,'BinCounts',mean(condRensemble,1),'FaceColor','b','FaceAlpha',0.2,'DisplayName','G_{RR}');
% legend
% saveas(fig1,sprintf("cond_t%.2fL%d.png",t,L));
% savefig(fig1,sprintf("cond_t%.2fL%d.fig",t,L));

%Correlation 
% fig2=figure;
% histogram(corensemble,'Normalization','probability');
% xlabel('Correlation');
% ylabel('Probability');
% title(sprintf("t=%.2f,L=%d Correlation statistics",t,L));
% saveas(fig2,sprintf("Cor_t%.2fL%d.png",t,L));
% savefig(fig2,sprintf("Cor_t%.2fL%d.fig",t,L));


%Conductance with 10%
% fig3=figure;
% histogram(cond10Lensemble,'Normalization','probability','FaceColor','r','FaceAlpha',0.4,'DisplayName','G_{LL}');
% hold on;
% histogram(cond10Rensemble,'Normalization','probability','FaceColor','b','FaceAlpha',0.2,'DisplayName','G_{RR}');
% xlabel('Fraction of the nearly quantized region');
% ylabel('Probility');
% title(sprintf("t=%.2f,L=%d Conductance within 10%% of 2 e^2/h",t,L));
% legend;
% saveas(fig3,sprintf("Cond10_t%.2fL%d.png",t,L));
% savefig(fig3,sprintf("Cond10_t%.2fL%d.fig",t,L));

%ZBCP
% fig4=figure;
% histogram(ZBCPensemble,'Normalization','probability');
% xlabel('Fraction of the ZBCP');
% ylabel('Probility');
% title(sprintf("t=%.2f,L=%d ZBCP statistics",t,L));
% saveas(fig4,sprintf("ZBCP_t%.2fL%d.png",t,L));
% savefig(fig4,sprintf("ZBCP_t%.2fL%d.fig",t,L));

%Mutual information
% fig5=figure;
% histogram(miensemble,'Normalization','probability');
% xlabel('Mutual information');
% ylabel('Probility');
% title(sprintf("t=%.2f,L=%d Mutual information (mean=%f) statistics",t,L,mean(miensemble)));
% saveas(fig5,sprintf("MI_t%.2fL%d.png",t,L));
% savefig(fig5,sprintf("MI_t%.2fL%d.fig",t,L));

%Normalized mutual information
% fig6=figure;
% histogram(miensemble./jeensemble,'Normalization','probability');
% xlabel('Normalized mutual information');
% ylabel('Probility');
% title(sprintf("t=%.2f,L=%d Normalized mutual information (mean=%f) statistics",t,L,mean(miensemble./jeensemble)));
% saveas(fig6,sprintf("NMI_t%.2fL%d.png",t,L));
% savefig(fig6,sprintf("NMI_t%.2fL%d.fig",t,L));

% save(sprintf('stat_t%.2fL%d.mat',t,L),'batchsize','cond10Lensemble','cond10Rensemble','condLensemble','condRensemble','corensemble','edges','ensemblesize','jeensemble','miensemble','ZBCPensemble')
save(sprintf('stat_t%.2fL%d.mat',t,L),'batchsize','ensemblesize','je_topo_ensemble','mi_topo_ensemble','je_trivial_ensemble','mi_trivial_ensemble','topo_ensemble','trivial_ensemble');

end