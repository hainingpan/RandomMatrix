H1=H{4};
H2=H{44};
H3=H{45};
W1=ww;

alpha1list=0:0.005:1;
alpha2list=0:0.005:1;
enlist=-1:0.01:1;
enmap0=zeros(length(alpha1list),length(alpha2list));
enmap=zeros(length(alpha1list),length(alpha2list));

count=0;
parfor alpha1index=1:length(alpha1list)
    entmp0=zeros(1,length(alpha2list));
    entmp=zeros(1,length(alpha2list));
    for alpha2index=1:length(alpha2list)
        alpha1=alpha1list(alpha1index);
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        condlist=arrayfun(@(x)G(x,hh,W1),enlist); 
        [flag,~,~,root]=isimag(hh,W1);
        if flag==1
            T=root(1)/(2*0.7717);
            count=count+1;
        else
            T=0;
        end    
        entmp0(alpha2index)=G0(0,enlist,condlist);
        entmp(alpha2index)=G0(T,enlist,condlist);
    end
    enmap0(alpha1index,:)=entmp0;
    enmap(alpha1index,:)=entmp;
end
disp(count/(length(alpha1list)*length(alpha2list)));
%finite T
enmap=real(enmap);
figure;
surf(alpha1list,alpha2list, enmap','edgecolor','none');view(2)
hold on
contour3(alpha1list,alpha2list, enmap'+10,[11.8,12.2],'k')
caxis([0,4])
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
xlabel('\alpha_1');
ylabel('\alpha_2');
title(sprintf("fraction within 10%% of 2e^2/h: %0.3f",nnz(enmap<2.2&enmap>1.8)/length(enmap)^2));
%zero T
enmap0=real(enmap0);
figure;
surf(alpha1list,alpha2list,enmap0','edgecolor','none');view(2)
caxis([0,4])
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
xlabel('\alpha_1');
ylabel('\alpha_2');
hold on
contour3(alpha1list,alpha2list, enmap0'+10,[11.8,12.2],'k')
title(sprintf("fraction within 10%% of 2e^2/h: %0.3f",nnz(enmap0<2.2&enmap0>1.8)/length(enmap0)^2));
