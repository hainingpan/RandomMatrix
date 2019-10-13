Llist=2:2;
%t0=0;

for i=1:length(Llist)
    disp(i)
    [mulist(i),sigmalist(i)]=correlation(Llist(i),t0);
end

save(strcat('t',num2str(t0),'sweepL.mat'),'mulist','sigmalist');