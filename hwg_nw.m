function [H,W]=hwg_nw(m,n,gamman,L)
delta0=1;
Hall=cell(L,1);
for ii=1:L
    Arand=sqrt(m)*delta0/pi*randn(m);
    Hall{ii}=(1i*(Arand-Arand.')/sqrt(2));  %test is sparse necessary?
end
t=delta0*1;
H=kron(spdiags(ones(L,2),[-1,1],L,L),t*ones(m))+blkdiag(Hall{:});
wn=sqrt(m*delta0/(pi^2*gamman)*(2-gamman-2*sqrt(1-gamman)));

W1=spdiags(wn*ones(n,1),0,m,n);
lead=zeros(L,2);
lead(1)=1;
lead(end)=1;
W=kron(lead,W1);
end