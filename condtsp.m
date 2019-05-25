load('M80/N4/Gn0.2/sweepalpha50.mat','H','ww')
H1=H{5};
H2=H{25};
H3=H{39};
W1=ww;


% alpha1list=0:0.005:1;
% alpha2list=0:0.005:1;
enlist=-2:0.01:2;
condmap0=zeros(length(alphalistx),length(enlist));
% eiglist=zeros(length(alphalist),length(H1));
% eigroot=zeros(length(alphalist),length(H1));
% count=0;
alphalength=zeros(1,length(alphalistx));
totdist=0;
alphalength(1)=0;
for alphaindex=2:length(alphalistx)
    totdist=totdist+hypot(alphalistx(alphaindex)-alphalistx(alphaindex-1),alphalisty(alphaindex)-alphalisty(alphaindex-1));
    alphalength(alphaindex)=totdist;
end
    
parfor alphaindex=1:length(alphalistx)
    alpha1=alphalistx(alphaindex);
    alpha2=alphalisty(alphaindex);
    hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
    condlist=arrayfun(@(x)G(x,hh,W1),enlist); 
    %Finite temperature
%     [flag,~,~,root]=isimag(hh,W1);
%         if flag==1
%             T=root(1)/(2*0.7717);
%         else
            T=0;
%         end      
%     condlist=GE(T,enlist,condlist);
    
    condmap0(alphaindex,:)=condlist;
%     eiglist(alphaindex,:)=eig(hh);
%     count=count+isimag(hh,W1);
%     hheff=heff(hh,W1);g
%     eigroot(alphaindex,:)=eig(hheff);
end
% disp(count/length(alphalist))
condmap0=real(condmap0);
figure;
surf(alphalength,enlist,condmap0','edgecolor','none');view(2)
xlabel('distance of \alpha')
ylabel('E/\delta_0')
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex')
axis tight