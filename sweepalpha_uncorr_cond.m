function cond=sweepalpha_uncorr_cond(m,gamman)
num=1000;
H=cell(num,3);
n=4;
[~,ww]=hwg(m,n,gamman);  
for i=1:num
    [hh,~]=hwg(m,n,gamman);    
    H{i,1}=hh;
    [hh,~]=hwg(m,n,gamman);    
    H{i,2}=hh;
    [hh,~]=hwg(m,n,gamman);   
    H{i,3}=hh;
end

alpha1list=0:0.01:1;
alpha2list=0:0.01:1;
cond=zeros(length(alpha1list),length(alpha2list),num);
for i=1:num
    H1=H{i,1};
    H2=H{i,2};
    H3=H{i,3};
    condmap=zeros(length(alpha1list));
    parfor alpha1index=1:length(alpha1list)
        alpha1=alpha1list(alpha1index); 
        condlist=zeros(alpha1index,1);
        for alpha2index=1:length(alpha2list)
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
            condlist(alpha2index)=G(0,hh,ww);
        end
        condmap(alpha1index,:)=condlist;
    end
    cond(:,:,i)=condmap;   
end
save(sprintf("M80/N4/Gn%.1f/cond_ensemble.mat",gamman),'cond','-v7.3');
end
