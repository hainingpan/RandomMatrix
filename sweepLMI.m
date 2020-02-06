function sweepLMI(t)
addpath('mi');
Llist=2:20;
NMIvsLlist=zeros(500,length(Llist));
JEvstlist=zeros(500,length(Llist));

for j=1:length(Llist)
    parfor i=1:size(NMIvsLlist,1)
        [NMIvsLlist(i,j),JEvsLlist(i,j)]=normalizedMI(80,4,0.1,Llist(j),t);
    end
end
save(strcat('t',num2str(t),'sweeptLMI.mat'),'NMIvsLlist','JEvsLlist');
end

function [MI,JE]=normalizedMI(m,n,gn,L,t)
[H1,W1]=hwg_nw(m,n,gn,L,t);
enlist=linspace(-5,5,1000);
condlist=arrayfun(@(x) Gm(x,H1,W1),enlist,'UniformOutput',false); 
condmat=cat(3,condlist{:});

gL=squeeze(condmat(1,1,:));
gR=squeeze(condmat(2,2,:));

MI=mutualinfo(gL,gR);
JE=jointentropy(gL,gR);

% gLs=sort(gL);
% gRs=sort(gR);
% 
% N=50;
% s=length(gLs)/N;
% binL=[0,gLs((1:N)*s)'];
% binR=[0,gRs((1:N)*s)'];
% 
% figure;scatter(gL,gR,'.');
% for i=1:length(binL)
%     line([binL(i),binL(i)],[0,2]);
% end
% 
% for i=1:length(binR)
%     line([0,2],[binR(i),binR(i)]);
% end
% axis([0,binL(end),0,binR(end)])
% 
% AB=zeros(length(binL)-1,1);
% for i=1:length(binL)-1
%     AB(i)=nnz(gL<=binL(i+1)&gL>binL(i)&gR<=binR(i+1)&gR>binR(i))/length(gL);
% end
% 
% AR=zeros(length(binL)-1,1);
% for i=1:length(binL)-1
%     AR(i)=nnz(gL<=binL(i+1)&gL>binL(i))/length(gL);
% end
% 
% BR=zeros(length(binL)-1,1);
% for i=1:length(binR)-1
%     BR(i)=nnz(gR<=binR(i+1)&gR>binR(i))/length(gR);
% end
% 
% KL=zeros(length(binL)-1,1);
% for i=1:length(binL)-1
%     if AB(i)==0
%         KL(i)=0;
%     else
%         KL(i)=AB(i)*log(AB(i)/(AR(i)*BR(i)));
%     end
% end
% 
% norH=zeros(length(binL)-1,1);
% for i=1:length(binL)-1
%     if AB(i)==0
%         norH(i)=0;
%     else
%         norH(i)=-AB(i)*log(AB(i));
%     end
% end       
%         MI=sum(KL)/sum(norH);
end
    
    
