H1=H{9784};
H2=H{2};
W1=W{1};

alphalist=0:0.005:1;
enlist=-1:0.01:1;
enmap=zeros(length(alphalist),length(enlist));
eiglist=zeros(length(alphalist),length(H1));
eigroot=zeros(length(alphalist),length(H1));
count=0;
parfor alphaindex=1:length(alphalist)
    alpha=alphalist(alphaindex);
    hh=(1-alpha)*H1+alpha*H2;
    enmap(alphaindex,:)=arrayfun(@(x)G(x,hh,W1),enlist); 
    eiglist(alphaindex,:)=eig(hh);
    count=count+isimag(hh,W1);
    hheff=heff(hh,W1);
    eigroot(alphaindex,:)=eig(hheff)
end
disp(count/length(alphalist))
enmap=real(enmap);
figure;
surf(alphalist,enlist,enmap'-2,'edgecolor','none');view(2)
hold on
plot(alphalist,eiglist,'k');
ylim([-1,1])