H1=H{1};
H2=H{10};
W1=W{1};

alphalist=0:0.005:1;
enlist=-1:0.01:1;
enmap=zeros(length(alphalist),length(enlist));
eiglist=zeros(length(alphalist),length(H1));
eigroot=zeros(length(alphalist),length(H1));
count=0;
for alphaindex=1:length(alphalist)
    alpha=alphalist(alphaindex);
    hh=(1-alpha)*H1+alpha*H2;
    enmap(alphaindex,:)=arrayfun(@(x)G(x,hh,W1),enlist); 
    eiglist(alphaindex,:)=eig(hh);
    count=count+isimag(hh,W1);
    hheff=heff(hh,W1);
    eigroot(alphaindex,:)=eig(hheff);
end
disp(count/length(alphalist))
enmap=real(enmap);
figure;
surf(alphalist,enlist,enmap','edgecolor','none');view(2)
colorbar
hold on
plot3(alphalist,eiglist,10*ones(length(alphalist),1),'k');ylim([-1,1])