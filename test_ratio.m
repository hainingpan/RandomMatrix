n=10000;
ratio=zeros(n,1);
for i=1:n
    [H,W]=hwg_nc(80,4,0.1);
    ratio(i)=bare_eig(H);
end

figure;
hist(log(ratio))
