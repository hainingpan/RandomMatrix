function [flag,H,W,im]=isimag_benchmark(H,W,k)
%Here the trick is make Heff real(assuming Heff is purely imaginary) and
%then multiplied by a i to rotate the spectrum back.


Heff=heff(H,W);
Heff_real=imag(Heff);
cutoff=pi*W(1)^2;

eiglist=eigs(Heff_real,k,-cutoff/2);%The criteria now becomes eigenvalues with zero imag
thr=1e-10;

if (min(abs(imag(eiglist)))<thr)
    flag=1;
    imeig=-real(eiglist);
    im=sort(imeig(abs(imag(eiglist))<thr));
else
    flag=0;
    im=0;
end
count=1;
while (cutoff/2>max(abs(eiglist+cutoff/2)) && flag==0) 
    count=count+1;
    eiglist=eigs(Heff_real,k*count,-cutoff/2);

    if (min(abs(imag(eiglist)))<thr)
        flag=1;
        imeig=real(eiglist);
        im=sort(imeig(abs(imag(eiglist))<thr));
    else
        flag=0;
        im=0;
    end
end
end
    
