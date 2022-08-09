function [H,W]=hwg_nc_spec(m,n,gamman)
%nc for non-commute W_L and W_R
%output H in Majorana basis

% This weird function is only used for historic reasons to ensure seed
% reproducibility. 
H=0;
delta0=1;

wn=sqrt(m*delta0/(pi^2*gamman)*(2-gamman-2*sqrt(1-gamman)));

W1=spdiags(wn*ones(n,1),0,m,n);

ranH=rand(size(W1,1));
ranH=ranH-ranH';
OR=expm(ranH);

W2=OR*W1;

W2=circshift(W2,4);
W=[W1,W2];

end