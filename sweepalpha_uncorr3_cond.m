function cond=sweepalpha_uncorr3_cond(m,gamman)
num=10;
H=cell(num,4);
n=4;
[~,ww]=hwg(m,n,gamman);  
for i=1:num
    [hh,~]=hwg(m,n,gamman);    
    H{i,1}=hh;
    [hh,~]=hwg(m,n,gamman);    
    H{i,2}=hh;
    [hh,~]=hwg(m,n,gamman);   
    H{i,3}=hh;  
    [hh,~]=hwg(m,n,gamman);   
    H{i,4}=hh;

end

alpha1list=0:0.01:1;
alpha2list=0:0.01:1;
alpha3list=0:0.01:1;
cond=zeros(length(alpha1list),length(alpha2list),length(alpha3list),num);
for i=1:num
    H1=H{i,1};
    H2=H{i,2};
    H3=H{i,3};
    H4=H{i,4};
    condmap=zeros(length(alpha1list),length(alpha2list),length(alpha3list));
    parfor alpha1index=1:length(alpha1list)
        alpha1=alpha1list(alpha1index); 
        condlist=zeros(length(alpha2list));
        for alpha2index=1:length(alpha2list)
            for alpha3index=1:length(alpha3list)
            alpha2=alpha2list(alpha2index);
            alpha3=alpha3list(alpha3index);
              hh=alpha1*H1+alpha2*H2+alpha3*H3+(1-alpha1-alpha2-alpha3)*H4;
            condlist(alpha2index,alpha3index)=G(0,hh,ww);
            end
        end
        condmap(:,:,alpha1index)=condlist;
    end
    cond(:,:,:,i)=condmap;   
end
save(sprintf("M80/N4/Gn%.1f/cond_ensemble3.mat",gamman),'cond','-v7.3');
end
