function flag=isimag_C(Heff_real)  %#codegen 
%Here the trick is make Heff real(assuming Heff is purely imaginary) and
%then multiplied by a i to rotate the spectrum back.

eiglist=eig(Heff_real);
% eiglist=1i*eiglist;

thr=1e-10;

if (min(abs(imag(eiglist)))<thr)
    flag=1;
else
    flag=0;
end
end
    
