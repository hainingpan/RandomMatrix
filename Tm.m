function [cond,Sm,S]=Tm(e,H,W)
%thermal conductance matrix dI_i/dV_j
n=size(W,2);
m=size(W,1);
Sm=speye(n)+2*pi*1i*W'/(H-(1i*pi*(W*W')+e*speye(m)))*W; %Sm in Majorana basis
U=kron(eye(2),kron(sqrt(1/2)*[1,1;1i,-1i],eye(n/4)));
S=U'*Sm*U; % S in particle hole basis
% cond=zeros(2,1);
ree=cell(2);
rhe=cell(2);
SS=cell(2);
for i=1:2
    for j=1:2
    SS{i,j}=S(1+(i-1)*(n/2):n/2+(i-1)*(n/2),1+(j-1)*(n/2):n/2+(j-1)*n/2);
    ree{i,j}=SS{i,j}(1:n/4,1:n/4);
    rhe{i,j}=SS{i,j}(1:n/4,n/4+1:n/2);
    end
end
cond=trace(ree{1,2}*ree{1,2}')+trace(rhe{1,2}*rhe{1,2}');
% cond(1)=trace(ree{1,2}*ree{1,2}')+trace(rhe{1,2}*rhe{1,2}');
% cond(2)=trace(ree{2,1}*ree{2,1}')+trace(rhe{2,1}*rhe{2,1}');
end