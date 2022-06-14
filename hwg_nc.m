function [H,W]=hwg_nc(m,n,gamman)
%nc for non-commute W_L and W_R
%output H in Majorana basis
delta0=1;
% Hall=cell(L,1); %H all in Majorana basis
% for ii=1:L
Arand=sqrt(m)*delta0/pi*randn(m);
H=(1i*(Arand-Arand.')/sqrt(2));  %test is sparse necessary?
% end
% t=delta0*t0;


% T=blkdiag(t*ones(m/2),-t*ones(m/2)); %T in particle-hole basis
% U=kron(sqrt(1/2)*[1,1;1i,-1i],eye(m/2));
% T=U*T*U'; %T in majorana basis

% T=kron([0,-1i;1i,0],t*ones(m/2)); %directly construct T in Majorana basis

% H=kron(spdiags(ones(L,2),[-1,1],L,L),T)+blkdiag(Hall{:});
wn=sqrt(m*delta0/(pi^2*gamman)*(2-gamman-2*sqrt(1-gamman)));

W1=spdiags(wn*ones(n,1),0,m,n);

% ranH=rand(size(W1,1));
% ranH=ranH+ranH';
% UR=expm(1i*ranH);

UR=eye(4);
W2=W1;
% W2=W1*UR;
% W2=UR*W1;

% W2=UR*W1;

W2=circshift(W2,4);
W=[W1,W2];

end