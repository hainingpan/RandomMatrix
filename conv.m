% load('M40/Gn0.9/num100000.mat')
% num=100000;
% H={};
% W={};
% gamma=[];
% for i=1:num
%     [hh,ww]=hwg(m,2,gamman);  
%     [flag,hh,ww,gg]=isimag(hh,ww);
%     if flag==1
%         H{end+1}=hh;
%         W{end+1}=ww;
%         gamma=[gamma,sort(gg)];
%     end
% end
T=0.05;
cond=zeros(length(gamma),1);
enlist=-1:0.005:1;
flist=exp(enlist/T)./((1+exp(enlist/T)).^2*T);
nor=real(ifft(fft(flist).*fft(ones(1,length(enlist)))));
for i=1:length(gamma)
%     condlist=arrayfun(@(x) G(x,H{i},W{i}),-0.05:0.005:0.05);
%     cond(i)=real(mean(condlist));
    condlist=arrayfun(@(x) G(x,H{i},W{i}),enlist);
    condlist2=real(fftshift(ifft(fft(flist).*fft(condlist))))./nor;
    cond(i)=condlist2(ceil(length(condlist2)/2));
end
figure;scatter(cond,log(gamma(2,:)./gamma(1,:)),'.');
title(sprintf('%d out of %d = %f',length(gamma),num,length(gamma)/num));
xlabel('G(e^2/h)');
ylabel('log(\gamma_2/\gamma_1)');
savefig(sprintf('M%d//Gn%1.1f//ratio%dT%.2f.fig',m,gamman,num,T));
figure;scatter3(gamma(1,:),gamma(2,:),cond,'.');
title(sprintf('%d out of %d = %f',length(gamma),num,length(gamma)/num));
xlabel('\gamma_1');
ylabel('\gamma_2');
zlabel('G(e^2/h)');
savefig(sprintf('M%d//Gn%1.1f//gamma%dT%.2f.fig',m,gamman,num,T));
% save(sprintf('M%d//Gn%1.1f//num%d.mat',m,gamman,num), '-v7.3');
% prob=length(gamma)/num;
% save(sprintf('M%d//Gn%1.1f//prob.dat',m,gamman),'prob','-ascii');
% end