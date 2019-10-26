for i=1:20
%     disp(i);   
%     [teigs{i},teig{i}]=runtest(i);

%     figure;
%     plot(1:length(teigs{i}),teigs{i});
%     hold on;
%     line([1,length(teigs{i})],[teig{i},teig{i}]);
%     title(strcat('dim:',num2str(80*i)))
%     xlim([1,length(teigs{i})])

    zz(i)=teigs{i}(20);
end

    figure;
    plot(sqrt(zz));
    hold on;
    plot(sqrt(cell2mat(teig)),'k');

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

end