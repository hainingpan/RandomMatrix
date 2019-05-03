% for i=1:100
i=29;
H1=H{end};
W1=W{end};
% H1=hh;
% W1=ww;
Heff=heff(H1,W1);
eiglist=eig(Heff);
figure;
scatter(real(eiglist(:)),imag(eiglist(:)),'.');
grid
% xlim([-1,1])
[flag,~,~,im]=isimag(H1,W1);
if flag==1
    disp(im);
end
% end