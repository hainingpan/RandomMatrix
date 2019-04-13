function cond=G(e,H,W)
n=size(W,2);
m=size(W,1);
sy=[0,-1i;1i,0];
S=eye(n)+2*pi*1i*W.'*((H-1i*pi*(W*W.')-e*eye(m))\W);
ty=kron(sy,eye(n/2));
cond=n/2-1/2*trace(S*ty*S'*ty);
end