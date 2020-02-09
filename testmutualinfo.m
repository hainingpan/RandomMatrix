addpath('mi')
milist=zeros(1000,11);
rlist=0:0.1:1;
for i=1:size(milist,1)
    for j=1:size(milist,2)
        milist(i,j)=MI(rlist(j));
    end
end

% milist=zeros(1000,1);
% jelist=zeros(1000,1);
% 
% for i=1:size(milist,1)
%     [milist(i),jelist(i)]=MI(0.5);
% end

function [mi,je]=MI(r)
mux=0;
muy=0;
sigmax=1;
sigmay=1;
% r=0.9;

mu=[mux,muy];
sigma=[sigmax^2,r*sigmax*sigmay;r*sigmax*sigmay,sigmay^2];
list=mvnrnd(mu,sigma,4000);

gL=list(:,1);
gR=list(:,2);

% mi=mutualinfo(gL,gR);
% je=jointentropy(gL,gR);
mi=muting(list);
end