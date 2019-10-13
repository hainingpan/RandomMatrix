Llist=2:30;

for i=1:length(Llist)
    disp(i)
    [mulist(i),muminlist(i),mumaxlist(i)]=correlation(Llist(i));
end

save('t0sweepL.mat','mulist','muminlist','mumaxlist');