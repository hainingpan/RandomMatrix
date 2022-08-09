function [condmap,eigvalmap,detSmap]=sweepalpha_single_nw_T(m,gamman,L,t0,seed)
% sweep for thermal conductance
rng(seed);
n=4;
[H1,ww]=hwg_nw(m,n,gamman,L,t0);
% [H1,ww]=hwg_nw_asymm(m,n,gamman,L,t0);    
[H2,~]=hwg_nw(m,n,gamman,L,t0);    
[H3,~]=hwg_nw(m,n,gamman,L,t0);  
step=0.01;
alpha1list=0:step:1;
alpha2list=0:step:1;

len1=length(alpha1list);
len2=length(alpha2list);
% immap=cell(length(alpha1list));

condmap=zeros(len1,len2); %GLL,GLR,GRL,GRR
% eigvalmap=zeros(len1,len2);

k=optimalk(t0,L);
parfor alpha1index=1:len1
    warning('off','all');
    alpha1=alpha1list(alpha1index);
    alpha2list=0:step:1;
    for alpha2index=1:len2
%         fprintf("%d %d\n",alpha1index,alpha2index);
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        [condmat,~,~]=Tm(0,hh,ww);        
        condmap(alpha1index,alpha2index)=condmat;
%         [eigval,~,~,~]=isimag_benchmark(hh,ww,k);
%         eigvalmap(alpha1index,alpha2index)=eigval;
%         immap{alpha1index,alpha2index}=im.';
    end
end
% downscale numeric type for efficiency of storage
% eigvalmap=logical(eigvalmap);
condmap=single(condmap);
% detSmap_err=max(abs(imag(detSmap)),[],'all');
% assert(detSmap_err<1e-7,sprintf('detS %e is not real',detSmap_err));
% detSmap=single(real(detSmap));


save(sprintf('M%d//N%d//Gn%1.1f//ensemble_T_t%.2fL%d_%d.mat',m,n,gamman,t0,L,seed),'condmap','-v7.3');

end