[H1,W1]=hwg_nw(80,4,0.1,20);
figure;
hold on
enlist=-1:1e-2:1;
condlist=arrayfun(@(x) Gm(x,H1,W1),enlist,'UniformOutput',false); 
condmat=cat(3,condlist{:});
plot(enlist,squeeze(condmat(1,1,:)),'DisplayName','G_{LL}','Color','c');
plot(enlist,squeeze(condmat(1,2,:)),'DisplayName','G_{LR}','Color','r');
plot(enlist,squeeze(condmat(2,1,:)),'DisplayName','G_{RL}','Color','k');
plot(enlist,squeeze(condmat(2,2,:)),'DisplayName','G_{RR}','Color','b');
legend;