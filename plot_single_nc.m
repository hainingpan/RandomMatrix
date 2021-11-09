clear;
close all;

i=3;
load(sprintf('./M80/N4/Gn0.1/condmap_nc/condmap_nc_%d.mat',i))
load(sprintf('./M80/N4/Gn0.1/eigvalmap_nc/eigvalmap_nc_%d.mat',i))

nnz(1.8<condmap(:,:,1) & condmap(:,:,1)<2.2)/length(condmap(:,:,1))^2;
nnz(1.8<condmap(:,:,4) & condmap(:,:,4)<2.2)/length(condmap(:,:,4))^2;
nnz(eigvalmap(:))/length(eigvalmap(:));
corrcoef(condmap(:,:,1),condmap(:,:,4));
alpha1list=linspace(0,1,size(condmap,1));
alpha2list=linspace(0,1,size(condmap,2));

% condmapL=condmap(:,:,1);
% condmapR=condmap(:,:,4);
% eigvalmap=eigvalmap.*(condmapL>=condmapR);
% eigvalmap=eigvalmap.*(condmapL<=condmapR);

rmap=zeros(length(alpha1list),length(alpha2list));
figR=figure();
hold on;
[ilist,jlist,klist]=find(eigvalmap); % i is y-axis, j is x-axis
[matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
[idx,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
% d=tanh(d);  %scale to [0,1]
rmap(:,:)=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
surf(alpha1list,alpha2list,rmap(:,:),'edgecolor','none');view(2);
title('Robustness');
xlabel('\alpha_1');
ylabel('\alpha_2');
cb=colorbar;
caxis([0, max(rmap,[],'all')]);
% savefig(figR,sprintf("Rmap_nc.fig"),'compact')
% saveas(figR,sprintf("Rmap_nc.png"))




figGLL=figure();
surf(alpha1list,alpha2list,condmap(:,:,1),'edgecolor','none');view(2)
title('G_{LL}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');

caxis([0, max(condmap,[],'all')]);
hold on;
contour3(alpha1list,alpha2list,eigvalmap*10,[5.5,6.5],'k');
% savefig(figGLL,sprintf("condmap_nc_LL.fig"),'compact')
% saveas(figGLL,sprintf("condmap_nc_LL.png"))

% figGLR=figure();
% surf(alpha1list,alpha2list,condmap(:,:,2),'edgecolor','none');view(2)
% title('G_{LR}')
% xlabel('\alpha_1')
% ylabel('\alpha_2')
% cb=colorbar;
% title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
% savefig(figGLR,sprintf("condmap_nc_LR.fig"),'compact')
% saveas(figGLR,sprintf("condmap_nc_LR.png"))

% figGRL=figure();
% surf(alpha1list,alpha2list,condmap(:,:,3),'edgecolor','none');view(2)
% title('G_{RL}')
% xlabel('\alpha_1')
% ylabel('\alpha_2')
% cb=colorbar;
% title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
% savefig(figGRL,sprintf("condmap_nc_RL.fig"),'compact')
% saveas(figGRL,sprintf("condmap_nc_RL.png"))

figGRR=figure();
hold on;
surf(alpha1list,alpha2list,condmap(:,:,4),'edgecolor','none');view(2)
title('G_{RR}')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
caxis([0, max(condmap,[],'all')]);
hold on;
contour3(alpha1list,alpha2list,eigvalmap*10,[5.5,6.5],'k');
% savefig(figGRR,sprintf("condmap_nc_RR.fig"),'compact')
% saveas(figGRR,sprintf("condmap_nc_RR.png"))



figeigL=figure();
surf(alpha1list,alpha2list,eigvalmap,'edgecolor','none');view(2)
title('ZBCP')
xlabel('\alpha_1')
ylabel('\alpha_2')
cb=colorbar;
% savefig(figeigL,sprintf("eigvalmap_nc.fig"),'compact')
% saveas(figeigL,sprintf("eigvalmap_nc.png"))








