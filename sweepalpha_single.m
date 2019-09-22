function sweepalpha_single(m,gamman,seed)
rng(seed);
% num=12;
% H=cell(num,3);
n=4;
[~,ww]=hwg(m,n,gamman);  

    [hh,~]=hwg(m,n,gamman);    
    H1=hh;
    [hh,~]=hwg(m,n,gamman);    
    H2=hh;
    [hh,~]=hwg(m,n,gamman);   
    H3=hh;

% countsave=-1*ones(num,1);
alpha1list=0:0.01:1;
alpha2list=0:0.01:1;
% countmax=0;
% cond=zeros(length(alpha1list),length(alpha2list),num); %save all conductance map
% eigval=zeros(length(alpha1list),length(alpha2list),num); %save all conductance map
% for i=1:num
%     H1=H{i,1};
%     H2=H{i,2};
%     H3=H{i,3};
    condmap=zeros(length(alpha1list));
    eigvalmap=zeros(length(alpha1list));
%     count=0;
    parfor alpha1index=1:length(alpha1list)
        alpha1=alpha1list(alpha1index);
        condlist=zeros(alpha1index,1);
        eigvallist=zeros(alpha1index,1);
        for alpha2index=1:length(alpha2list)
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
            isimagvalue=isimag(hh,ww);
%             count=count+isimagvalue;
            condlist(alpha2index)=G(0,hh,ww);
            eigvallist(alpha2index)=isimagvalue;
        end
        condmap(alpha1index,:)=condlist;
        eigvalmap(alpha1index,:)=eigvallist;
    end
%     cond(:,:,i)=condmap; 
%     eigval(:,:,i)=eigvalmap;
%     countsave(i)=count;
%     if  count>countmax
%         countmax=count;
%         fprintf("%d:%f\n",i,count/(length(alpha1list)*length(alpha2list)));
%     end      
% end
% prob=mean(countsave(countsave~=-1))/(length(alpha1list)*length(alpha2list));
% save(sprintf('M%d//N%d//Gn%1.1f//probalpha%d_uncorr.dat',m,n,gamman,num),'prob','-ascii');
save(sprintf('M%d//N%d//Gn%1.1f//eigvalmap%d.mat',m,n,gamman,seed),'eigvalmap', '-v7.3');
save(sprintf('M%d//N%d//Gn%1.1f//condmap%d.mat',m,n,gamman,seed),'condmap', '-v7.3');
end
