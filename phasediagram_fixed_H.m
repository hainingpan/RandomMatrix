m=80;
n=4;
t0=1;
L=5;
gamman=0.1;

[H1,ww]=hwg_nw_fix(m,n,gamman,L,t0);
[H2,~]=hwg_nw_fix(m,n,gamman,L,t0);
[H3,~]=hwg_nw_fix(m,n,gamman,L,t0);
 
step=0.01;
alpha1list=0:step:1;
alpha2list=0:step:1;
condmap=zeros(length(alpha1list),length(alpha1list),4); %GLL,GLR,GRL,GRR

eigvalmap=zeros(length(alpha1list));

len1=length(alpha1list);
len2=length(alpha2list);
% immap=cell(length(alpha1list));

k=optimalk(t0,L);
parfor alpha1index=1:len1
    warning('off','all');
    alpha1=alpha1list(alpha1index);
    alpha2list=0:step:1;
    for alpha2index=1:len2
%         fprintf("%d %d\n",alpha1index,alpha2index);
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        condmat=Gm(0,hh,ww);
        condmap(alpha1index,alpha2index,:)=condmat(:);
        [eigval,~,~,~]=isimag_benchmark(hh,ww,k);
        eigvalmap(alpha1index,alpha2index)=eigval;
%         immap{alpha1index,alpha2index}=im.';
    end
end
figure;
surf(alpha1list,alpha2list,eigvalmap','edgecolor','none');view(2)
% hold on
% contour3(alpha1list,alpha2list, eigvalmap'+10,[11.8,12.2],'k')
caxis([0,1]);

cb=colorbar;
set(cb,'YTick',[0,1]);
title(cb,'isZBCP')
xlabel('\alpha_1');
ylabel('\alpha_2');
title(sprintf("non-quantized ZBCP fraction:%0.3f",nnz(eigvalmap)/length(eigvalmap)^2));
saveas(gcf,'ZBCP.png')

figure;
surf(alpha1list,alpha2list,squeeze(condmap(:,:,1))','edgecolor','none');view(2)
% hold on
% contour3(alpha1list,alpha2list, eigmap'+10,[11.8,12.2],'k')
caxis([0,4]);
cb=colorbar;
title(cb,'G(e^2/h)')
xlabel('\alpha_1');
ylabel('\alpha_2');
title('G_{LL}');
saveas(gcf,'GLL.png')

figure;
surf(alpha1list,alpha2list,squeeze(condmap(:,:,2))','edgecolor','none');view(2)
% hold on
% contour3(alpha1list,alpha2list, eigmap'+10,[11.8,12.2],'k')
caxis([0,4])
cb=colorbar;
title(cb,'G(e^2/h)')
xlabel('\alpha_1');
ylabel('\alpha_2');
title('G_{LR}');
saveas(gcf,'GLR.png')

figure;
surf(alpha1list,alpha2list,squeeze(condmap(:,:,3))','edgecolor','none');view(2)
% hold on
% contour3(alpha1list,alpha2list, eigmap'+10,[11.8,12.2],'k')
caxis([0,4]);
cb=colorbar;
title(cb,'G(e^2/h)')
xlabel('\alpha_1');
ylabel('\alpha_2');
title('G_{RL}');
saveas(gcf,'GRL.png')

figure;
surf(alpha1list,alpha2list,squeeze(condmap(:,:,4))','edgecolor','none');view(2)
% hold on
% contour3(alpha1list,alpha2list, eigmap'+10,[11.8,12.2],'k')
caxis([0,4]);
cb=colorbar;
title(cb,'G(e^2/h)')
xlabel('\alpha_1');
ylabel('\alpha_2');
title('G_{RR}');
saveas(gcf,'GRR.png')