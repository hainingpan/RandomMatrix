function cond=ensemble_cond(m,gamman)
num=100000;
H=cell(num,1);
W=cell(num,1);
for i=1:num
    [hh,ww]=hwg(40,2,gamman);  
    H{i}=hh;
    W{i}=ww;
end
cond=zeros(num,1);
parfor i=1:num
    condlist=arrayfun(@(x) G(x,H{i},W{i}),-0.05:0.005:0.05);
    cond(i)=real(mean(condlist));
end
save(sprintf('M%d//Gn%1.1f//cond.dat',m,gamman),'cond','-ascii');
save(sprintf('M%d//Gn%1.1f//ensemble%d.mat',m,gamman,num), '-v7.3');
end

