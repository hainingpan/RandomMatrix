function [H,W]=hwg_nw(m,n,gamman,L,t0)
%output H in Majorana basis
delta0=1;
Hall=cell(L,1); %H all in Majorana basis
for ii=1:L
    Arand=sqrt(m)*delta0/pi*randn(m);
    Hall{ii}=(1i*(Arand-Arand.')/sqrt(2));  %test is sparse necessary?
end
t=delta0*t0;
% T=blkdiag(t*ones(m/2),-t*ones(m/2)); %T in particle-hole basis
% U=kron(sqrt(1/2)*[1,1;1i,-1i],eye(m/2));
% T=U*T*U'; %T in majorana basis

T=kron([0,-1i;1i,0],t*ones(m/2)); %directly construct T in Majorana basis

H=kron(spdiags(ones(L,2),[-1,1],L,L),T)+blkdiag(Hall{:});
wn=sqrt(m*delta0/(pi^2*gamman)*(2-gamman-2*sqrt(1-gamman)));

W1=spdiags(wn*ones(n,1),0,m,n);
lead=zeros(L,2);
lead(1)=1;
lead(end)=1;
W=kron(lead,W1);

% %change W2 position
% leadL=lead;
% leadR=lead;
% leadL(1)=1;
% leadR(end)=1;
% W2=spdiags(wn*ones(n,1),-(m-n),m,n);
% W=kron(leadL,W1)+kron(leadR,W2);
end