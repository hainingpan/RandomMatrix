function MI=NMI(gL,gR)
% gL=squeeze(condmat(1,1,:));
% gR=squeeze(condmat(2,2,:));
gLs=sort(gL);
gRs=sort(gR);

N=200;
s=length(gLs)/N;
binL=[0,gLs((1:N)*s)'];
binR=[0,gRs((1:N)*s)'];

figure;scatter(gL,gR,'.');
for i=1:length(binL)
    line([binL(i),binL(i)],[0,2]);
end

for i=1:length(binR)
    line([0,2],[binR(i),binR(i)]);
end
% axis([0,binL(end),0,binR(end)])
axis([0,2,0,2])

AB=zeros(length(binL)-1,1);
for i=1:length(binL)-1
    AB(i)=nnz(gL<=binL(i+1)&gL>binL(i)&gR<=binR(i+1)&gR>binR(i))/length(gL);
end

AR=zeros(length(binL)-1,1);
for i=1:length(binL)-1
    AR(i)=nnz(gL<=binL(i+1)&gL>binL(i))/length(gL);
end

BR=zeros(length(binL)-1,1);
for i=1:length(binR)-1
    BR(i)=nnz(gR<=binR(i+1)&gR>binR(i))/length(gR);
end

KL=zeros(length(binL)-1,1);
for i=1:length(binL)-1
    if AB(i)==0
        KL(i)=0;
    else
        KL(i)=AB(i)*log(AB(i)/(AR(i)*BR(i)));
    end
end

norH=zeros(length(binL)-1,1);
for i=1:length(binL)-1
    if AB(i)==0
        norH(i)=0;
    else
        norH(i)=-AB(i)*log(AB(i));
    end
end       
        MI=sum(KL);
%         MI=sum(KL)/sum(norH);
    
title(strcat('MI=',num2str(MI)));
end