function [flag,H,W,im]=isimag(H,W)
%Here the trick is make Heff real(assuming Heff is purely imaginary) and
%then multiplied by a i to rotate the spectrum back.

Heff=heff(H,W);
Heff_r=max(abs(real(Heff)),[],'all');
assert(Heff_r<1e-10,sprintf('H_eff %e is not purely imaginary',Heff_r))
Heff_real=imag(Heff);

eiglist=eig(Heff_real);
eiglist=1i*eiglist;
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
    
