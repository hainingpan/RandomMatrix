function [flag,H,W,im]=isimag(H,W)
Heff=heff(H,W);
eiglist=eig(Heff);
thr=1e-10;
if (min(abs(real(eiglist)))<thr)
    flag=1;
    [~,pos]=mink(abs(real(eiglist)),2);
    im=-imag(eiglist(pos));
else
    flag=0;
    im=0;
end
end
    
