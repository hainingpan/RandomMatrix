function [flag,H,W,im]=isimag(H,W)
Heff=heff(H,W);
eiglist=eig(Heff);
thr=1e-10;
if (min(abs(real(eiglist)))<thr)
    flag=1;
%     [~,pos]=mink(abs(real(eiglist)),2);
%     im=sort(-imag(eiglist(pos)));
    imeig=-imag(eiglist);
    im=sort(imeig(abs(real(eiglist))<thr));
else
    flag=0;
    im=0;
end
end
    
