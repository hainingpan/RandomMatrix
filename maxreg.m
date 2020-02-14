% ind={[26,31,33],[5,25,39],[16,31,49],[16,31,49],[16,31,49],[16,31,49],[12,20,40],[16,19,29],[30,40,49],[4,44,45]};
%2nd largest:(2nd and 3rd are used to compare with the first with same H but different Gamma_n)
% ind={[5,25,39],[26,31,33],[26,31,33]};
%other largest:
% ind={[24,39,46],[10,18,40],[6,12,33]};
ind=3771;
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
    eigvalmap=zeros(length(alpha1list),length(alpha2list));
    count=0;
    parfor alpha1index=1:length(alpha1list)
        entmp0=zeros(1,length(alpha2list));
        entmp=zeros(1,length(alpha2list));
        eigvaltmp=zeros(1,length(alpha2list));
        for alpha2index=1:length(alpha2list)
            alpha1=alpha1list(alpha1index);
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
%             condlist=arrayfun(@(x)G(x,hh,W1),enlist); 
            [flag,~,~,root]=isimag(hh,W1);
            if flag==1
%                 T=root(1)/(2*0.7717);
                count=count+1;
%             else
%                 T=0;
            end    
            entmp0(alpha2index)=G(0,hh,W1);
            eigvaltmp(alpha2index)=flag;
%             entmp0(alpha2index)=G0(0,enlist,condlist);
%             entmp(alpha2index)=G0(T,enlist,condlist);
        end
        enmap0(alpha1index,:)=entmp0;
        eigvalmap(alpha1index,:)=eigvaltmp;
%         enmap(alpha1index,:)=entmp;
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
enmap0=real(enmap0);
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
save(strrep(fn,'sweepalpha','enmap0_3771_'),'enmap0','eigvalmap','H1','H2','H3','W1','alpha1list','alpha2list','-v7.3');
end
    