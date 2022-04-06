function [condmap,eigvalmap,detSmap]=sweepalpha_single(m,gamman,seed)
rng(seed);
n=4;
[H1,ww]=hwg(m,n,gamman);    
[H2,~]=hwg(m,n,gamman);    
[H3,~]=hwg(m,n,gamman);  
step=0.001;
alpha1list=0:step:1;
alpha2list=0:step:1;
condmap=zeros(length(alpha1list));
detSmap=zeros(length(alpha1list));
eigvalmap=zeros(length(alpha1list));

len1=length(alpha1list);
len2=length(alpha2list);
parfor alpha1index=1:len1
    alpha1=alpha1list(alpha1index);
    alpha2list=0:step:1;
    for alpha2index=1:len2
        alpha2=alpha2list(alpha2index);
        hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
        [condmap(alpha1index,alpha2index),detSmap(alpha1index,alpha2index)]=G(0,hh,ww);
        eigvalmap(alpha1index,alpha2index)=isimag(hh,ww);
    end
end
% parfor alpha1index=1:length(alpha1list)
%     alpha1=alpha1list(alpha1index);
%     condlist=zeros(alpha1index,1);
%     eigvallist=zeros(alpha1index,1);    
%     for alpha2index=1:length(alpha2list)
%         alpha2=alpha2list(alpha2index);
%         hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
%         isimagvalue=isimag(hh,ww);
%         condlist(alpha2index)=G(0,hh,ww);
%         eigvallist(alpha2index)=isimagvalue;
%     end
%     condmap(alpha1index,:)=condlist;
%     eigvalmap(alpha1index,:)=eigvallist;
% end

% downscale numeric type for efficiency of storage
eigvalmap=logical(eigvalmap);
condmap=single(condmap);
detSmap_err=max(abs(imag(detSmap)),[],'all');
assert(detSmap_err<1e-7,sprintf('detS %e is not real',detSmap_err));
detSmap=single(real(detSmap));

save(sprintf('M%d//N%d//Gn%1.1f//ensemble%d.mat',m,n,gamman,seed),'eigvalmap','condmap','detSmap', '-v7.3');

% save(sprintf('M%d//N%d//Gn%1.1f//eigvalmap%d.mat',m,n,gamman,seed),'eigvalmap', '-v7.3');
% save(sprintf('M%d//N%d//Gn%1.1f//condmap%d.mat',m,n,gamman,seed),'condmap', '-v7.3');
% save(sprintf('M%d//N%d//Gn%1.1f//detSmap%d.mat',m,n,gamman,seed),'detSmap', '-v7.3');
end
