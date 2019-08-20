H1=H{20};
H2=H{99};
% W1=W{1};

alphalist=0:0.001:1;
enlist=-1:0.001:1;
enmap=zeros(length(alphalist),length(enlist));
eiglist=zeros(length(alphalist),length(H1));
eigroot=zeros(length(alphalist),length(H1));
count=0;
parfor alphaindex=1:length(alphalist)
    alpha=alphalist(alphaindex);
    hh=(1-alpha)*H1+alpha*H2;
    condlist=arrayfun(@(x)G(x,hh,W1),enlist); 
%     %Finite temperature
%     [flag,~,~,root]=isimag(hh,W1);
%         if flag==1
%             T=root(1)/(2*0.7717);
%         else
%             T=0;
%         end      
%     condlist=GE(T,enlist,condlist);
    
    enmap(alphaindex,:)=condlist;
    eiglist(alphaindex,:)=eig(hh);
    count=count+isimag(hh,W1);
    hheff=heff(hh,W1);
    eigroot(alphaindex,:)=eig(hheff);
end
disp(count/length(alphalist))
enmap=real(enmap);
figure;
surf(alphalist,enlist,enmap','edgecolor','none');view(2)
colorbar
hold on
plot3(alphalist,eiglist,10*ones(length(alphalist),1),'k');
ylim([enlist(1),enlist(end)])