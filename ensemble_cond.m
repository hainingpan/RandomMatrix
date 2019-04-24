function cond=ensemble_cond(m,gamman)
num=100000;
H=cell(num,1);
W=cell(num,1);
T=0.05;
for i=1:num
    [hh,ww]=hwg(m,2,gamman);  
    H{i}=hh;
    W{i}=ww;
end
cond=zeros(num,1);
enlist=-1:0.01:1;
flist=exp(enlist/T)./((1+exp(enlist/T)).^2*T);
nor=real(ifft(fft(flist).*fft(ones(1,length(enlist)))));
parfor i=1:num
%     condlist=arrayfun(@(x) G(x,H{i},W{i}),-0.05:0.005:0.05);
%     cond(i)=real(mean(condlist));
      condlist=arrayfun(@(x) G(x,H{i},W{i}),-1:0.01:1);
      condlist2=real(fftshift(ifft(fft(flist).*fft(condlist))))./nor;
      cond(i)=condlist2(ceil(length(condlist2)/2));
end
save(sprintf('M%d//Gn%1.1f//cond.dat',m,gamman),'cond','-ascii');
save(sprintf('M%d//Gn%1.1f//ensemble%d.mat',m,gamman,num), '-v7.3');
end

