clear;
close all;

t=1;
L=2;
i=9;
load(sprintf('./M80/N4/Gn0.1/condmapt%.2fL%d/condmapt%.2fL%d_%d.mat',t,L,t,L,i))
load(sprintf('./M80/N4/Gn0.1/eigvalmapt%.2fL%d/eigvalmapt%.2fL%d_%d.mat',t,L,t,L,i))

nnz(1.8<condmap(:,:,1) & condmap(:,:,1)<2.2)/length(condmap(:,:,1))^2;
nnz(1.8<condmap(:,:,4) & condmap(:,:,4)<2.2)/length(condmap(:,:,4))^2;
nnz(eigvalmap(:))/length(eigvalmap(:));
corrcoef(condmap(:,:,1),condmap(:,:,4));
alpha1list=linspace(0,1,size(condmap,1));
alpha2list=linspace(0,1,size(condmap,2));

condmapL=condmap(:,:,1);
condmapR=condmap(:,:,4);
eigvalmapL=eigvalmap.*(condmapL>=condmapR);
eigvalmapR=eigvalmap.*(condmapL<=condmapR);

rmap=zeros(length(alpha1list),length(alpha2list));
figR_L=figure();
hold on;
[ilist,jlist,klist]=find(eigvalmapL); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmapL,[0.5,1.5],'k');
[idx,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
% d=tanh(d);  %scale to [0,1]
rmap(:,:)=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
surf(alpha1list,alpha2list,rmap(:,:),'edgecolor','none');view(2);
title('Robustness_L');
xlabel('\alpha_1');
ylabel('\alpha_2');
cb=colorbar;
caxis([0, max(rmap,[],'all')]);
% savefig(figR_L,sprintf("Rmap%.2fL%dL.fig",t,L),'compact')
% saveas(figR_L,sprintf("Rmap%.2fL%dL.png",t,L))

figR_R=figure();
hold on;
[ilist,jlist,klist]=find(eigvalmapR); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmapR,[0.5,1.5],'k');
[idx,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
% d=tanh(d);  %scale to [0,1]
rmap(:,:)=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
surf(alpha1list,alpha2list,rmap(:,:),'edgecolor','none');view(2);
title('Robustness_R');
xlabel('\alpha_1');
ylabel('\alpha_2');
cb=colorbar;
caxis([0, max(rmap,[],'all')]);
% savefig(figR_R,sprintf("Rmap%.2fL%dR.fig",t,L),'compact')
% saveas(figR_R,sprintf("Rmap%.2fL%dR.png",t,L))

figGLL=figure();
surf(alpha1list,alpha2list,condmap(:,:,1),'edgecolor','none');view(2)
title('G_{LL}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
caxis([0, max(condmap,[],'all')]);
hold on;
contour3(alpha1list,alpha2list,eigvalmapL*10,[5.5,6.5],'k');
% savefig(figGLL,sprintf("condmapt%.2fL%dLL.fig",t,L),'compact')
% saveas(figGLL,sprintf("condmapt%.2fL%dLL.png",t,L))

% figGLR=figure();
% surf(alpha1list,alpha2list,condmap(:,:,2),'edgecolor','none');view(2)
% title('G_{LR}')
% xlabel('\alpha_1')
% ylabel('\alpha_2')
% cb=colorbar;
% title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
% savefig(figGLR,sprintf("condmapt%.2fL%dLR.fig",t,L),'compact')
% saveas(figGLR,sprintf("condmapt%.2fL%dLR.png",t,L))

% figGRL=figure();
% surf(alpha1list,alpha2list,condmap(:,:,3),'edgecolor','none');view(2)
% title('G_{RL}')
% xlabel('\alpha_1')
% ylabel('\alpha_2')
% cb=colorbar;
% title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
% savefig(figGRL,sprintf("condmapt%.2fL%dRL.fig",t,L),'compact')
% saveas(figGRL,sprintf("condmapt%.2fL%dRL.png",t,L))

figGRR=figure();
surf(alpha1list,alpha2list,condmap(:,:,4),'edgecolor','none');view(2)
title('G_{RR}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
caxis([0, max(condmap,[],'all')]);
hold on;
contour3(alpha1list,alpha2list,eigvalmapR*10,[5.5,6.5],'k');
% savefig(figGRR,sprintf("condmapt%.2fL%dRR.fig",t,L),'compact')
% saveas(figGRR,sprintf("condmapt%.2fL%dRR.png",t,L))

figeig=figure();
surf(alpha1list,alpha2list,eigvalmap(:,:),'edgecolor','none');view(2)
title('ZBCP')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
savefig(figeig,sprintf("eigvalmapt%.2fL%d.fig",t,L),'compact')
saveas(figeig,sprintf("eigvalmapt%.2fL%d.png",t,L))

figeigL=figure();
surf(alpha1list,alpha2list,eigvalmapL,'edgecolor','none');view(2)
title('ZBCP_L')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
% savefig(figeigL,sprintf("eigvalmapt%.2fL%dL.fig",t,L),'compact')
% saveas(figeigL,sprintf("eigvalmapt%.2fL%dL.png",t,L))

figeigR=figure();
surf(alpha1list,alpha2list,eigvalmapR,'edgecolor','none');view(2)
title('ZBCP_R')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
% savefig(figeigR,sprintf("eigvalmapt%.2fL%dR.fig",t,L),'compact')
% saveas(figeigR,sprintf("eigvalmapt%.2fL%dR.png",t,L))