function [condmap,eigvalmap,detSmap]=sweepalpha_single_nw(m,gamman,L,t0,seed)
rng(seed);
n=4;
[H1,ww]=hwg_nw(m,n,gamman,L,t0);    
[H2,~]=hwg_nw(m,n,gamman,L,t0);    
[H3,~]=hwg_nw(m,n,gamman,L,t0);  
step=0.001;
alpha1list=0:step:1;
alpha2list=0:step:1;
condmap=zeros(length(alpha1list),length(alpha1list),4); %GLL,GLR,GRL,GRR
detSmap=zeros(length(alpha1list),length(alpha1list),2); % SL,SR
eigvalmap=zeros(length(alpha1list));

len1=length(alpha1list);
len2=length(alpha2list);
% immap=cell(length(alpha1list));

k=optimalk(t0,L);
parfor alpha1index=1:len1
    warning('off','all');
    alpha1=alpha1list(alpha1index);
    alpha2list=0:step:1;
    for alpha2index=1:len2
%         fprintf("%d %d\n",alpha1index,alpha2index);
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        [condmat,~,~,detS1,detS2]=Gm(0,hh,ww);        
        condmap(alpha1index,alpha2index,:)=condmat(:);
        detSmap(alpha1index,alpha2index,:)=[detS1,detS2];
        [eigval,~,~,~]=isimag_benchmark(hh,ww,k);
        eigvalmap(alpha1index,alpha2index)=eigval;
%         immap{alpha1index,alpha2index}=im.';
    end
end
% downscale numeric type for efficiency of storage
eigvalmap=logical(eigvalmap);
condmap=single(condmap);
detSmap_err=max(abs(imag(detSmap)),[],'all');
assert(detSmap_err<1e-7,sprintf('detS %e is not real',detSmap_err));
detSmap=single(real(detSmap));


save(sprintf('M%d//N%d//Gn%1.1f//ensemble_t%.2fL%d_%d.mat',m,n,gamman,t0,L,seed),'eigvalmap', 'condmap','detSmap','-v7.3');

% save(sprintf('M%d//N%d//Gn%1.1f//eigvalmapt%.2fL%d_%d.mat',m,n,gamman,t0,L,seed),'eigvalmap', '-v7.3');
% save(sprintf('M%d//N%d//Gn%1.1f//condmapt%.2fL%d_%d.mat',m,n,gamman,t0,L,seed),'condmap', '-v7.3');
% save(sprintf('M%d//N%d//Gn%1.1f//detSmapt%.2fL%d_%d.mat',m,n,gamman,t0,L,seed),'detSmap', '-v7.3');

% save(sprintf('M%d//N%d//Gn%1.1f//imagmapt%.2fL%d_%d.mat',m,n,gamman,t0,L,seed),'imagmap', '-v7.3');
end