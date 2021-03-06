corlist=zeros(500,1);
parfor i=1:length(corlist)
    corlist(i)=corfunc(80,4,0.1,2,-1);
end
figure;
hist=histogram(corlist,linspace(-1,1,20),'Normalization','probability');
xlabel('Correlation');
ylabel('Probability');

x=sort(corlist);
y=(1:length(corlist))'/length(corlist);
% ft=fittype('1/2*(erf(x-mu/(sqrt(2)*sigma))+erf(1+mu/(sqrt(2)*sigma)))','independent','x','dependent','y');
ft=fittype('1/2*(erf(k*(x-mu))+erf(k*(1+mu)))','independent','x','dependent','y');
fitresult=fit(x,y,ft,'StartPoint',[0,0.2]);
coeff=coeffvalues(fitresult);
k=coeff(1);
sigma=1/(sqrt(2)*k);
mu=coeff(2);
gaussianx=-1:0.01:1;
gaussiany=k/sqrt(pi)*exp(-k^2.*(gaussianx-mu).^2);
hold on;
plot(gaussianx,gaussiany/(max(gaussiany)/max(hist.Values)));
title(sprintf('System parameters:$t=\\delta_0$,$L=10$\nGaussian Fitting Parameters:$\\sigma$=%.3f,$\\mu$=%.3f',sigma,mu),'Interpreter','latex');


function cor=corfunc(m,n,gn,L,t)
[H1,W1]=hwg_nw(m,n,gn,L,t);
enlist=-5:5e-2:5;
condlist=arrayfun(@(x) Gm(x,H1,W1),enlist,'UniformOutput',false); 
condmat=cat(3,condlist{:});
cor=corrcoef([squeeze(condmat(1,1,:)),squeeze(condmat(2,2,:))]);
cor=cor(1,2);
end
