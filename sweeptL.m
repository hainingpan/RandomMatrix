function sweeptL(t0)
Llist=2:20;
mulist=zeros(length(Llist),1);
sigmalist=zeros(length(Llist),1);
for i=1:length(Llist)
    disp(i)
    [mulist(i),sigmalist(i)]=correlation(Llist(i),t0);
end
savelist=[mulist,sigmalist];
save(strcat('t',num2str(t0),'sweepL.mat'),'savelist','-ascii');
end