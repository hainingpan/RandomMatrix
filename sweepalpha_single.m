function sweepalpha_single(m,gamman,seed)
rng(seed);
n=4;
[~,ww]=hwg(m,n,gamman);  
[hh,~]=hwg(m,n,gamman);    
H1=hh;
[hh,~]=hwg(m,n,gamman);    
H2=hh;
[hh,~]=hwg(m,n,gamman);   
H3=hh;
alpha1list=0:0.001:1;
alpha2list=0:0.001:1;
condmap=zeros(length(alpha1list));
eigvalmap=zeros(length(alpha1list));
parfor alpha1index=1:length(alpha1list)
    alpha1=alpha1list(alpha1index);
    condlist=zeros(alpha1index,1);
    eigvallist=zeros(alpha1index,1);
    for alpha2index=1:length(alpha2list)
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        isimagvalue=isimag(hh,ww);
        condlist(alpha2index)=G(0,hh,ww);
        eigvallist(alpha2index)=isimagvalue;
    end
    condmap(alpha1index,:)=condlist;
    eigvalmap(alpha1index,:)=eigvallist;
end
save(sprintf('M%d//N%d//Gn%1.1f//eigvalmap%d.mat',m,n,gamman,seed),'eigvalmap', '-v7.3');
save(sprintf('M%d//N%d//Gn%1.1f//condmap%d.mat',m,n,gamman,seed),'condmap', '-v7.3');
end
