t_list=0.01:0.1:.1;
g_list=zeros(length(t_list),10);
for idx=1:length(t_list)
    t0=t_list(idx);
    m=80;
    n=4;
    gamman=1;
    L=2;
    
    for seed=1:10
        pth=sprintf('M%d//N%d//Gn%1.1f//ensemble_T_t%.2fL%d_%d.mat',m,n,gamman,t0,L,seed);
        ensemble=load(pth);
        g_list(idx,seed)=mean(abs(ensemble.condmap),'all');
    end
end
figure;
plot(t_list,mean(g_list,2))
xlabel('t')
ylabel('T_{ee}+T_{eh}')

gL_list=zeros(1,10);
for seed=1:10
    gamman=.1;
    t0=0.5;
    
    pth=sprintf('M%d//N%d//Gn%1.1f//ensemble_T_t%.2fL%d_%d.mat',m,n,gamman,t0,L,seed);
    ensemble=load(pth);
    gL_list(1,seed)=mean(abs(ensemble.condmap),'all');
end
% gL_list=gL_list*2;