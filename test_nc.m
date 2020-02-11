[H1,W1]=hwg_nc(80,4,.1);
figure;
hold on
enlist=linspace(-1,1,1000);
condlist=arrayfun(@(x) Gm(x,H1,W1),enlist,'UniformOutput',false); 
condmat=cat(3,condlist{:});
plot(enlist,squeeze(condmat(1,1,:)),'DisplayName','G_{LL}','Color','c');
plot(enlist,squeeze(condmat(1,2,:)),'DisplayName','G_{LR}','Color','r');
plot(enlist,squeeze(condmat(2,1,:)),'DisplayName','G_{RL}','Color','k');
plot(enlist,squeeze(condmat(2,2,:)),'DisplayName','G_{RR}','Color','b');
cor=corrcoef([squeeze(condmat(1,1,:)),squeeze(condmat(2,2,:))]);
title(sprintf('correlation=%.4f\n',cor(1,2)));
xlabel('Energy');
ylabel('$G(\frac{e^2}{h})$','Interpreter','latex');
legend;
% savefig(gcf,'D:\CMTC\Rp_RM\Rp13\t1L5_1.fig');
% saveas(gcf,'D:\CMTC\Rp_RM\Rp13\t1L5_1.png');

