fig0=figure;
% surf(alpha1list,alpha2list,enmap0','edgecolor','none');view(2);
surf(alpha1list,alpha2list,(enmap0.*((enmap0-enmapp)>0).*eigvalmap)','edgecolor','none');view(2)
hold on
contour3(alpha1list,alpha2list,enmap0'+10,[8,10.4],'r');
contour3(alpha1list,alpha2list,enmap0'+10,[8,12],'k');
caxis([0,4])
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
xlabel('\alpha_1');
ylabel('\alpha_2');
title(sprintf("fraction within 10%% of 2e^2/h: %0.3f",nnz(enmap0<2.2&enmap0>1.8)/length(enmap0)^2));
plot3(alphalistx,alphalisty,10*ones(length(alphalistx)));
saveas(fig0,strcat('D:\CMTC\Rp_RM\Rp18\Phasediagram_(',num2str(alphalistx(1)),',',num2str(alphalisty(1)),')-(',num2str(alphalistx(end)),',',num2str(alphalisty(end)),').png'))


fig1=figure;
plot(alphalength,condmap0(:,201));xlabel('distance of \alpha');ylabel('G(e^2/h)');title('V_{bias}=0');
[~,I]=max(condmap0(:,201));
hold on;
line([alphalength(I),alphalength(I)],[0,4],'linestyle','--');
saveas(fig1,strcat('D:\CMTC\Rp_RM\Rp18\vbias_(',num2str(alphalistx(1)),',',num2str(alphalisty(1)),')-(',num2str(alphalistx(end)),',',num2str(alphalisty(end)),').png'));

fig2=figure;plot(enlist,condmap0(I,:),'DisplayName','Max');xlabel('v_{bias}=0');ylabel('G(e^2/h)');title('max peak');
hold on;
plot(enlist,condmap0(1,:),'DisplayName','0');
legend;

saveas(fig2,strcat('D:\CMTC\Rp_RM\Rp18\vmax_(',num2str(alphalistx(1)),',',num2str(alphalisty(1)),')-(',num2str(alphalistx(end)),',',num2str(alphalisty(end)),').png'));

