% L=2;
% [H1,W1]=hwg_nw(80,4,0.1,L,1);
% figure;
% hold on
% enlist=linspace(-1,1,1000);
% condlist=arrayfun(@(x) Gm(x,H1,W1),enlist,'UniformOutput',false); 
% condmat=cat(3,condlist{:});
% plot(enlist,squeeze(condmat(1,1,:)),'DisplayName','G_{LL}','Color','c');
% plot(enlist,squeeze(condmat(1,2,:)),'DisplayName','G_{LR}','Color','r');
% plot(enlist,squeeze(condmat(2,1,:)),'DisplayName','G_{RL}','Color','k');
% plot(enlist,squeeze(condmat(2,2,:)),'DisplayName','G_{RR}','Color','b');
% cor=corrcoef([squeeze(condmat(1,1,:)),squeeze(condmat(2,2,:))]);
% title(sprintf('correlation=%.4f\nLength=%d',cor(1,2),L));
% xlabel('Energy');
% ylabel('$G(\frac{e^2}{h})$','Interpreter','latex');
% legend;
% savefig(gcf,'D:\CMTC\Rp_RM\Rp13\t1L5_1.fig');
% saveas(gcf,'D:\CMTC\Rp_RM\Rp13\t1L5_1.png');
% fnold=fieldnames(zold);
% for i=1:length(fnold)
%     fieldname=fnold(i);
%     tmp_old=zold.(fieldname);
%     tmp_new=znew.(fieldname);
%     isequal(zold.(fnold{1}),znew.(fnold{1}));
% end

% for seed=1:10
%     sweepalpha_single_nw_T(80,0.1,2,0.5,seed);
% end

for t=0.01:0.1:.1
    disp(t)
    tic
    for seed=1:10
        sweepalpha_single_nw_T(80,1,2,t,seed);
    end
    toc
end



