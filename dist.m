function [flag,H,W,im,vecim]=dist(H,W)
Heff=heff(H,W);
[vec,eiglist]=eig(Heff);
eiglist=diag(eiglist);
thr=1e-10;
if (min(abs(real(eiglist)))<thr)
    flag=1;
    [~,pos]=mink(abs(real(eiglist)),2);
    im=-imag(eiglist(pos));
    vecim=vec(:,pos);
else
    flag=0;
    im=0;
    vecim=0;
end
end
    
