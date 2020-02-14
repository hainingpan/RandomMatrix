fig0=figure;
surf(alpha1list,alpha2list,enmap0','edgecolor','none');view(2)
hold on
contour3(alpha1list,alpha2list, enmap0'+10,[11.8,12.2],'k')
caxis([0,4])
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
xlabel('\alpha_1');
ylabel('\alpha_2');
title(sprintf("fraction within 10%% of 2e^2/h: %0.3f",nnz(enmap0<2.2&enmap0>1.8)/length(enmap0)^2));
plot3(alphalistx,alphalisty,10*ones(length(alphalistx)));
saveas(fig0,'D:\CMTC\Rp_RM\Rp18\Phasediagram_F.png')


fig1=figure;
plot(alphalength,condmap0(:,201));xlabel('distance of \alpha');ylabel('G(e^2/h)');title('V_{bias}=0');
[~,I]=max(condmap0(:,201));
hold on;
line([alphalength(I),alphalength(I)],[0,4],'linestyle','--');
saveas(fig1,'D:\CMTC\Rp_RM\Rp18\vbias_F.png');

fig2=figure;plot(enlist,condmap0(I,:));xlabel('v_{bias}=0');ylabel('G(e^2/h)');title('max peak');

saveas(fig2,'D:\CMTC\Rp_RM\Rp18\vmax_F.png');

