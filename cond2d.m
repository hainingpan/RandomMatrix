H1=H{3};
H2=H{25};
H3=H{40};
W1=ww;

alpha1list=0:0.005:1;
alpha2list=0:0.005:1;
enlist=-1:0.01:1;
enmap=zeros(length(alpha1list),length(alpha2list));

count=0;
parfor alpha1index=1:length(alpha1list)
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
        entmp(alpha2index)=G0(T,enlist,condlist);
    end
    enmap(alpha1index,:)=entmp;
end
disp(count/(length(alpha1list)*length(alpha2list)));
enmap=real(enmap);
figure;
surf(alpha1list,alpha2list,enmap,'edgecolor','none');view(2)
colorbar