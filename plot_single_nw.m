clear;
t=1;
L=10;
load(sprintf('./M80/N4/Gn0.1/condmapt%.2fL%d_1.mat',t,L))
load(sprintf('./M80/N4/Gn0.1/eigvalmapt%.2fL%d_1.mat',t,L))

nnz(1.8<condmap(:,:,1) & condmap(:,:,1)<2.2)/length(condmap(:,:,1))^2
nnz(1.8<condmap(:,:,4) & condmap(:,:,4)<2.2)/length(condmap(:,:,4))^2
nnz(eigvalmap(:))/length(eigvalmap(:))
corrcoef(condmap(:,:,1),condmap(:,:,4))
alpha1list=linspace(0,1,size(condmap,1));
alpha2list=linspace(0,1,size(condmap,2));
figGLL=figure();
surf(alpha1list,alpha2list,condmap(:,:,1),'edgecolor','none');view(2)
title('G_{LL}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
savefig(figGLL,sprintf("condmapt%.2fL%dLL.fig",t,L),'compact')
saveas(figGLL,sprintf("condmapt%.2fL%dLL.png",t,L))

figGLR=figure();
surf(alpha1list,alpha2list,condmap(:,:,2),'edgecolor','none');view(2)
title('G_{LR}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
savefig(figGLR,sprintf("condmapt%.2fL%dLR.fig",t,L),'compact')
saveas(figGLR,sprintf("condmapt%.2fL%dLR.png",t,L))

figGRL=figure();
surf(alpha1list,alpha2list,condmap(:,:,3),'edgecolor','none');view(2)
title('G_{RL}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
savefig(figGRL,sprintf("condmapt%.2fL%dRL.fig",t,L),'compact')
saveas(figGRL,sprintf("condmapt%.2fL%dRL.png",t,L))

figGRR=figure();
surf(alpha1list,alpha2list,condmap(:,:,4),'edgecolor','none');view(2)
title('G_{RR}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
savefig(figGRR,sprintf("condmapt%.2fL%dRR.fig",t,L),'compact')
saveas(figGRR,sprintf("condmapt%.2fL%dRR.png",t,L))

figeig=figure();
surf(alpha1list,alpha2list,eigvalmap(:,:),'edgecolor','none');view(2)
title('ZBCP')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
savefig(figeig,sprintf("eigvalmapt%.2fL%d.fig",t,L),'compact')
saveas(figeig,sprintf("eigvalmapt%.2fL%d.png",t,L))
