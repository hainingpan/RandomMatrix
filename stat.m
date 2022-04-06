function stat()
ensemblesize=1000;
% t=1;
% L=10;
batchsize=100;
for index=1:ensemblesize
    F(index)=parfeval(@loaddata_rm,1,'./M80/N4/Gn0.1',index+0);
end
ZBCPensemble=zeros(length(ensemblesize),1);
cond10ensemble=zeros(length(ensemblesize),1);
% cond10Rensemble=zeros(length(ensemblesize),1);
% corensemble=zeros(length(ensemblesize),1);
condensemble=zeros(length(ensemblesize),20);
% condRensemble=zeros(length(ensemblesize),20);
% miensemble=zeros(length(ensemblesize),1);
% jeensemble=zeros(length(ensemblesize),1);
for index=1:ensemblesize/batchsize
    for ii=1:batchsize
        [idx,re]=fetchNext(F);
        ZBCPensemble(idx)=re.ZBCP;
        cond10ensemble(idx)=re.cond10;
%         cond10Rensemble(idx)=re.cond10R;
%         corensemble(idx)=re.cor;
        condensemble(idx,:)=re.cond;
%         condRensemble(idx,:)=re.condR;
%         miensemble(idx,:)=re.mi;
%         jeensemble(idx,:)=re.je;
    end
       fprintf("%f\n",index/ensemblesize*batchsize);
end

%Conductance statistics
% edges=linspace(0,4,21); % needs to manually match loaddata.m
edges=re.edges;
fig1=figure;
histogram('BinEdges',edges,'BinCounts',mean(condensemble,1),'FaceColor','r','FaceAlpha',0.4,'DisplayName','G');
xlabel('$G(\frac{e^2}{h})$','Interpreter','latex');
ylabel('Probility');
title("Conductance statistics");
% hold on;
% histogram('BinEdges',edges,'BinCounts',mean(condRensemble,1),'FaceColor','b','FaceAlpha',0.2,'DisplayName','G_{RR}');
% legend
saveas(fig1,sprintf("cond.png"));
savefig(fig1,sprintf("cond.fig"));


%Conductance with 10%
fig3=figure;
histogram(cond10ensemble,'Normalization','probability','FaceColor','r','FaceAlpha',0.4,'DisplayName','G');
% hold on;
% histogram(cond10Rensemble,'Normalization','probability','FaceColor','b','FaceAlpha',0.2,'DisplayName','G_{RR}');
xlabel('Fraction of the nearly quantized region');
ylabel('Probility');
title("Conductance within 10%% of 2 e^2/h");
% legend;
saveas(fig3,sprintf("Cond10.png"));
savefig(fig3,sprintf("Cond10.fig"));

%ZBCP
fig4=figure;
histogram(ZBCPensemble,'Normalization','probability');
xlabel('Fraction of the ZBCP');
ylabel('Probility');
title("ZBCP statistics");
saveas(fig4,sprintf("ZBCP.png"));
savefig(fig4,sprintf("ZBCP.fig"));



end