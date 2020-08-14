function stat_nc()
ensemblesize=10000;
batchsize=100;
for index=1:ensemblesize
    F(index)=parfeval(@loaddata_nc,1,'./M80/N4/Gn0.1',index+0);
end
ZBCPensemble=zeros(length(ensemblesize),1);
cond10Lensemble=zeros(length(ensemblesize),1);
cond10Rensemble=zeros(length(ensemblesize),1);
corensemble=zeros(length(ensemblesize),1);
condLensemble=zeros(length(ensemblesize),20);
condRensemble=zeros(length(ensemblesize),20);
miensemble=zeros(length(ensemblesize),1);
jeensemble=zeros(length(ensemblesize),1);
for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [idx,re]=fetchNext(F);
        ZBCPensemble(idx)=re.ZBCP;
        cond10Lensemble(idx)=re.cond10L;
        cond10Rensemble(idx)=re.cond10R;
        corensemble(idx)=re.cor;
        condLensemble(idx,:)=re.condL;
        condRensemble(idx,:)=re.condR;
        miensemble(idx,:)=re.mi;
        jeensemble(idx,:)=re.je;
    end
       fprintf("%f\n",index/ensemblesize*batchsize);
end

%Conductance statistics
edges=linspace(0,4,21); % needs to manually match loaddata.m
fig1=figure;
histogram('BinEdges',edges,'BinCounts',mean(condLensemble,1),'FaceColor','r','FaceAlpha',0.4,'DisplayName','G_{LL}');
xlabel('$G(\frac{e^2}{h})$','Interpreter','latex');
ylabel('Probility');
title("Non-commutative lead: Conductance statistics");
hold on;
histogram('BinEdges',edges,'BinCounts',mean(condRensemble,1),'FaceColor','b','FaceAlpha',0.2,'DisplayName','G_{RR}');
legend
saveas(fig1,"cond_nc.png");
savefig(fig1,"cond_nc.fig");

%Correlation 
fig2=figure;
histogram(corensemble,'Normalization','probability');
xlabel('Correlation');
ylabel('Probability');
title("Non-commutative lead: Correlation statistics");
saveas(fig2,"Cor_nc.png");
savefig(fig2,"Cor_nc.fig");


%Conductance with 10%
fig3=figure;
histogram(cond10Lensemble,'Normalization','probability','FaceColor','r','FaceAlpha',0.4,'DisplayName','G_{LL}');
hold on;
histogram(cond10Rensemble,'Normalization','probability','FaceColor','b','FaceAlpha',0.2,'DisplayName','G_{RR}');
xlabel('Fraction of the nearly quantized region');
ylabel('Probility');
title("Non-commutative lead: Conductance within 10%% of 2 e^2/h");
legend;
saveas(fig3,"Cond10_nc.png");
savefig(fig3,"Cond10_nc.fig");

%ZBCP
fig4=figure;
histogram(ZBCPensemble,'Normalization','probability');
xlabel('Fraction of the ZBCP');
ylabel('Probility');
title("Non-commutative lead: ZBCP statistics");
saveas(fig4,"ZBCP_nc.png");
savefig(fig4,"ZBCP_nc.fig");

%Mutual information
fig5=figure;
histogram(miensemble,'Normalization','probability');
xlabel('Mutual information');
ylabel('Probility');
title(sprintf("Non-commutative lead: Mutual information (mean=%f) statistics",mean(miensemble)));
saveas(fig5,"MI_nc.png");
savefig(fig5,"MI_nc.fig");

%Normalized mutual information
fig6=figure;
histogram(miensemble./jeensemble,'Normalization','probability');
xlabel('Normalized mutual information');
ylabel('Probility');
title(sprintf("Non-commutative lead: Normalized mutual information (mean=%f) statistics",mean(miensemble./jeensemble)));
saveas(fig6,"NMI_nc.png");
savefig(fig6,"NMI_nc.fig");

end