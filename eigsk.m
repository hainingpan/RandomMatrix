for i=1:20
    disp(i);   
    [teigs{i},teig{i}]=runtest(i);
end


function [tlist,teig]=runtest(L)
[H,W]=hwg_nw(80,4,0.1,L,1);
tlist=zeros(1,80*L/4);
Heff=heff(H,W);
Heff_real=imag(Heff);
cutoff=pi*W(1)^2;
for k=1:length(tlist)
    tlist(k)=timeit(@() eigs(Heff_real,k,-cutoff/2));
end
teig=timeit(@() eig(Heff_real));
% figure;
% plot(1:length(tlist),tlist);
% hold on;
% line([1,length(tlist)],[teig,teig]);
% title(strcat('dim:',num2str(80*L)))
end