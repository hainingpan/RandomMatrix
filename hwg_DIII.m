function [H,W]=hwg_DIII(m,n,gamman)
%TRS, H= sigma_y conj(H) sigma_y in particle-hole basis; 
%H_{n,m}=i c_{n,m} sigma_x+i d_{n,m} sigma_z
delta0=1;
hm=m/2;
rmat=randn(hm)*sqrt(m)*delta0/(2*pi);
cmat=triu(rmat,1)-transpose(triu(rmat,1));
dmat=-tril(rmat,-1)+transpose(tril(rmat,-1));
H=1i*kron(cmat,[0,1;1,0])+1i*kron(dmat,[1,0;0,-1]);
% assert(isequal(H,kron(eye(hm),[0,-1;1,0])*conj(H)*kron(eye(hm),[0,1;-1,0])));
wn=sqrt(m*delta0/(pi^2*gamman)*(2-gamman-2*sqrt(1-gamman)));
W=spdiags(wn*ones(n,1),0,m,n);
end