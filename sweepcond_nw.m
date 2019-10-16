L=5;
% [H1,W1]=hwg_nw(80,4,0.1,L,0.5);
% [H2,~]=hwg_nw(80,4,0.1,L,0.5);


alphalist=0:0.002:1;
enlist=-1:0.002:1;
GLL=zeros(length(alphalist),length(enlist));
GRR=zeros(length(alphalist),length(enlist));
GLR=zeros(length(alphalist),length(enlist));
GRL=zeros(length(alphalist),length(enlist));

eiglist=zeros(length(alphalist),length(H1));
eigroot=zeros(length(alphalist),length(H1));
count=0;
parfor alphaindex=1:length(alphalist)
    alpha=alphalist(alphaindex);
    hh=(1-alpha)*H1+alpha*H2;
    condlist=arrayfun(@(x)Gm(x,hh,W1),enlist,'UniformOutput',false); 
    condmat=cat(3,condlist{:});
    
    GLL(alphaindex,:)=squeeze(condmat(1,1,:));
    GRR(alphaindex,:)=squeeze(condmat(2,2,:));
    GLR(alphaindex,:)=squeeze(condmat(1,2,:));
    GRL(alphaindex,:)=squeeze(condmat(2,1,:));

    eiglist(alphaindex,:)=eig(hh);
    count=count+isimag(hh,W1);
%     hheff=heff(hh,W1);
%     eigroot(alphaindex,:)=eig(hheff);
end
disp(count/length(alphalist))
GLL=real(GLL);
figure;
surf(alphalist,enlist,GLL','edgecolor','none');view(2)
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
hold on
plot3(alphalist,eiglist,10*ones(length(alphalist),1),'k');
ylim([enlist(1),enlist(end)])
title("G_{LL}")
xlabel('\alpha');
ylabel('Energy(\delta_0)');


disp(count/length(alphalist))
GRR=real(GRR);
figure;
surf(alphalist,enlist,GRR','edgecolor','none');view(2)
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
hold on
plot3(alphalist,eiglist,10*ones(length(alphalist),1),'k');
ylim([enlist(1),enlist(end)])
title("G_{RR}")
xlabel('\alpha');
ylabel('Energy(\delta_0)');

disp(count/length(alphalist))
GLR=real(GLR);
figure;
surf(alphalist,enlist,GLR','edgecolor','none');view(2)
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
hold on
plot3(alphalist,eiglist,10*ones(length(alphalist),1),'k');
ylim([enlist(1),enlist(end)])
title("G_{LR}")
xlabel('\alpha');
ylabel('Energy(\delta_0)');

disp(count/length(alphalist))
GRL=real(GRL);
figure;
surf(alphalist,enlist,GRL','edgecolor','none');view(2)
cb=colorbar;
title(cb,'$G(\frac{e^2}{h})$','Interpreter','latex');
hold on
plot3(alphalist,eiglist,10*ones(length(alphalist),1),'k');
ylim([enlist(1),enlist(end)])
title("G_{RL}")
xlabel('\alpha');
ylabel('Energy(\delta_0)');