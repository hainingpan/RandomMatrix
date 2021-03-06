H1=H{30};
H2=H{40};
H3=H{49};
W1=ww;
% 
alpha1list=0:0.005:1;
alpha2list=0:0.005:1;
eigmap=zeros(length(alpha1list),length(alpha2list));

parfor alpha1index=1:length(alpha1list)
    entmp=zeros(1,length(alpha2list));
    for alpha2index=1:length(alpha2list)
        alpha1=alpha1list(alpha1index);
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        [flag,~,~,root]=isimag(hh,W1);  
        entmp(alpha2index)=flag;
    end
    eigmap(alpha1index,:)=entmp;
end

[vm,vpos]=max(sum(eigmap,2)); %determine the position of alpha1, sweep alpha2
[hm,hpos]=max(sum(eigmap,1)); %determine the position of alpha2, sweep alpha1
fprintf("horizontal(%d at %d)\n vertical(%d at %d)",hm,hpos,vm,vpos);

enlist=-2:0.01:2;

if hm>vm
    Hi=alpha1list(1)*H1+alpha2list(hpos)*H2+(1-alpha1list(1)-alpha2list(hpos))*H3;
    Hf=alpha1list(end)*H1+alpha2list(hpos)*H2+(1-alpha1list(end)-alpha2list(hpos))*H3;    
else
    Hi=alpha1list(vpos)*H1+alpha2list(1)*H2+(1-alpha1list(vpos)-alpha2list(1))*H3;
    Hf=alpha1list(vpos)*H1+alpha2list(end)*H2+(1-alpha1list(vpos)-alpha2list(end))*H3;
end
alphalist=0:0.005:1;    
W1=ww;
enmap=zeros(length(alphalist),length(enlist));
enmap1=zeros(length(alphalist),length(enlist));

eigroot=zeros(length(alpha1list),length(H1));
count=0;
for alphaindex=1:length(alphalist)
    alpha=alphalist(alphaindex);
    hh=(1-alpha)*Hi+alpha*Hf;
    condlist=arrayfun(@(x)G(x,hh,W1),enlist); 
    %Finite temperature
    [flag,~,~,root]=isimag(hh,W1);
        if flag==1
            T=root(1)/(2*0.7717);
        else
            T=0;
        end      
    condlist1=GE(T,enlist,condlist);
    
    enmap(alphaindex,:)=condlist;
    enmap1(alphaindex,:)=condlist1;
    count=count+isimag(hh,W1);
    hheff=heff(hh,W1);
    eigroot(alphaindex,:)=eig(hheff);
end
disp(count/length(alphalist))
enmap=real(enmap);
enmap1=real(enmap1);
figure;
surf(alphalist,enlist,enmap','edgecolor','none');view(2)
cb=colorbar;
title(cb,"G(e^2/h)");
if hm>vm
    xlabel("\alpha_1");
    title(strcat("\alpha_2=",num2str(alpha2list(hpos))));
else
    xlabel("\alpha_2");
    title(strcat("\alpha_1=",num2str(alpha1list(vpos))))
end
ylabel("E/\delta_0");

enmap=real(enmap);
figure;
surf(alphalist,enlist,enmap1','edgecolor','none');view(2)
cb=colorbar;
title(cb,"G(e^2/h)");
if hm>vm
    xlabel("\alpha_1");
    title(strcat("\alpha_2=",num2str(alpha2list(hpos))));
else
    xlabel("\alpha_2");
    title(strcat("\alpha_1=",num2str(alpha1list(vpos))))
end
ylabel("E/\delta_0");

if hm>vm
    line([0,1],[alpha2list(hpos),alpha2list(hpos)],[10,10],'color','r','linewidth',2);
else
    line([alpha1list(vpos),alpha1list(vpos)],[0,1],[10,10],'color','r','linewidth',2);
end


    