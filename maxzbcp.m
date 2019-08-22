%maximal region of non-quantized zbcp (purely imaginary eigenvalues)
ind=6914;
for index=1:1
%     fn=sprintf('M80/N4/Gn%.1f/sweepalpha10000_uncorr.mat',index/10);
    H1=H{ind,1};
    H2=H{ind,2};
    H3=H{ind,3};
    W1=ww;

    alpha1list=0:0.001:1;
    alpha2list=0:0.001:1;
    eigmap=zeros(length(alpha1list),length(alpha2list));

    parfor alpha1index=1:length(alpha1list)
        entmp0=zeros(1,length(alpha2list));
        entmp=zeros(1,length(alpha2list));
        for alpha2index=1:length(alpha2list)
            alpha1=alpha1list(alpha1index);
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
            [flag,~,~,root]=isimag(hh,W1);
 
            entmp0(alpha2index)=flag;
        end
        eigmap(alpha1index,:)=entmp0;
    end

eigmap=real(eigmap);
figure;
surf(alpha1list,alpha2list,eigmap','edgecolor','none');view(2)
hold on
contour3(alpha1list,alpha2list, eigmap'+10,[11.8,12.2],'k')
caxis([0,1])
cb=colorbar;
title(cb,'isZBCP')
set(cb,'YTick',[0,1])
xlabel('\alpha_1');
ylabel('\alpha_2');
title(sprintf("non-quantized ZBCP fraction:%0.3f",nnz(eigmap)/length(eigmap)^2));

save(strrep(fn,'sweepalpha','eig0_'),'eigmap','-v7.3');
end
    