function [H,W]=hw(m,n)
delta0=1;
gamman=.3;
Arand=sqrt(m)*delta0/pi*randn(m);
H=1i*(Arand-Arand.')/sqrt(2);
wn=sqrt(m*delta0/(pi^2*gamman)*(2-gamman-2*sqrt(1-gamman)));
W=spdiags(wn*ones(n,1),0,m,n);
end