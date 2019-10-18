function sweept(L)
tlist=-1:0.1:1;
mulist=zeros(length(tlist),1);
sigmalist=zeros(length(tlist),1);
for i=1:length(tlist)
    disp(i)
    [mulist(i),sigmalist(i)]=correlation(L,tlist(i));
end
savelist=[mulist,sigmalist];
save(strcat('L',num2str(L),'sweeptL.dat'),'savelist','-ascii');
end