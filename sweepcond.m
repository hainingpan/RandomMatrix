H1=H{1};
H2=H{6};
W1=W{1};

alphalist=0:0.01:1;
enlist=-2:0.02:2;
enmap=zeros(length(alphalist),length(enlist));
eiglist=zeros(length(alphalist),length(H1));

parfor alphaindex=1:length(alphalist)
    alpha=alphalist(alphaindex);
    enmap(alphaindex,:)=arrayfun(@(x)G(x,(1-alpha)*H1+alpha*H2,W1),enlist); 
    eiglist(alphaindex,:)=eig((1-alpha)*H1+alpha*H2);
end
enmap=real(enmap);
figure;
surf(alphalist,enlist,enmap'-2,'edgecolor','none');view(2)
hold on
plot(alphalist,eiglist,'k');
ylim([-1,1])