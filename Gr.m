function cond=Gr(e,H,W)
n=size(W,2);
m=size(W,1);
sy=[0,-1i;1i,0];
S=eye(n)+2*pi*1i*W.'*((H-1i*pi*(W*W.')-e*eye(m))\W);
U=kron(sqrt(1/2)*[1,1;1i,-1i],eye(n/2));
S=U'*S*U;
ree=S(1:n/2,1:n/2);
rhe=S(1:n/2,n/2+1:n);
cond=n/2-trace(ree*ree')+trace(rhe*rhe');
end