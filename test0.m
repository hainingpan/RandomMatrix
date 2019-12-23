n=100000;
dev=zeros(n,1);
normH=zeros(n,1);
parfor i=1:n
    [dev(i),normH(i)]=deviation();
end
figure;
% scatter(dev,zeros(size(dev)),'.')
scatter(normH,dev,'.')



% function re=deviation()
% [H,W]=hwg(80,4,0.1);
% Heff=heff(H,W);
% val=eig(Heff);
% re=max(-imag(val));
% end

function [re,normH]=deviation()
m=100;
H=1*rand(m);
H=1i*(H-H');
normH=sum((H(:)));
W=zeros(m);
W(1,1)=1;
W(2,2)=1;
W(3,3)=1;
W(4,4)=1;
Heff=H-1i*W;
val=eig(Heff);
re=max(-imag(val));
end

