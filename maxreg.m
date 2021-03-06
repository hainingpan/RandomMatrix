% ind={[26,31,33],[5,25,39],[16,31,49],[16,31,49],[16,31,49],[16,31,49],[12,20,40],[16,19,29],[30,40,49],[4,44,45]};
%2nd largest:(2nd and 3rd are used to compare with the first with same H but different Gamma_n)
% ind={[5,25,39],[26,31,33],[26,31,33]};
%other largest:
% ind={[24,39,46],[10,18,40],[6,12,33]};
% ind=3771; %1st largest
% ind=5295;
for index=1:1
%     fn=sprintf('M80/N4/Gn%.1f/sweepalpha50.mat',index/10)
      fn=sprintf('M80/N4/Gn%.1f/sweepalpha10000_uncorr.mat',index/10);
%     load(fn);
%     H1=H{ind{index}(1)};
%     H2=H{ind{index}(2)};
%     H3=H{ind{index}(3)};
    H1=H{ind,1};
    H2=H{ind,2};
    H3=H{ind,3};
    W1=ww;

    alpha1list=0:0.001:1;
    alpha2list=0:0.001:1;
%     enlist=-1:0.01:1;
    enmap0=zeros(length(alpha1list),length(alpha2list));
%     enmap=zeros(length(alpha1list),length(alpha2list));
    enmapp=zeros(length(alpha1list),length(alpha2list));
    eigvalmap=zeros(length(alpha1list),length(alpha2list));
    count=0;
    len1=length(alpha1list);
    len2=length(alpha2list);
    parfor alpha1index=1:len1
%         entmp0=zeros(1,length(alpha2list));
%         entmp=zeros(1,length(alpha2list));
%         eigvaltmp=zeros(1,length(alpha2list));
        for alpha2index=1:len2
            alpha1=alpha1list(alpha1index);
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
            [flag,~,~,root]=isimag(hh,W1);
            if flag==1
                count=count+1;
            end    
            enmap0(alpha1index,alpha2index)=real(G(0,hh,W1));
            enmapp(alpha1index,alpha2index)=real(G(0.01,hh,W1));
            eigvalmap(alpha1index,alpha2index)=flag;
        end
    end
% disp(count/(length(alpha1list)*length(alpha2list)));
%finite T
% enmap=real(enmap);
% figure;
% surf(alpha1list,alpha2list, enmap','edgecolor','none');view(2)
% hold on
% contour3(alpha1list,alpha2list, enmap'+10,[11.8,12.2],'k')
% caxis([0,4])
% cb=colorbar;
% title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
% xlabel('\alpha_1');
% ylabel('\alpha_2');
% title(sprintf("fraction within 10%% of 2e^2/h: %0.3f",nnz(enmap<2.2&enmap>1.8)/length(enmap)^2));
%zero T
figure;
surf(alpha1list,alpha2list,enmap0','edgecolor','none');view(2)
hold on
contour3(alpha1list,alpha2list, enmap0'+10,[11.8,12.2],'k')
caxis([0,4])
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
xlabel('\alpha_1');
ylabel('\alpha_2');
title(sprintf("fraction within 10%% of 2e^2/h: %0.3f",nnz(enmap0<2.2&enmap0>1.8)/length(enmap0)^2));
% save(strrep(fn,'sweepalpha50','enmap_2_f'),'enmap','-v7.3');
% save(strrep(fn,'sweepalpha50','enmap0_2_f'),'enmap0','-v7.3');
save(strrep(fn,'sweepalpha',strcat('enmap0_',num2str(ind),'_')),'enmap0','enmapp','eigvalmap','H1','H2','H3','W1','alpha1list','alpha2list','-v7.3');
end
    