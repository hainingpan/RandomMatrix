Llist=2:20;

for i=1:length(Llist)
    disp(i)
    [mulist(i),sigmalist(i)]=correlation(Llist(i));
end

save('t0.5sweepL.mat','mulist','muminlist','mumaxlist');