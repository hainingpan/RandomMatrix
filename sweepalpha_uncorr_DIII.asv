function sweepalpha_uncorr_DIII(m,gamman)
num=3000;
H=cell(num,3);
n=4;
[~,ww]=hwg_DIII(m,n,gamman);  

for i=1:num
    [hh,~]=hwg_DIII(m,n,gamman);    
    H{i,1}=hh;
    [hh,~]=hwg_DIII(m,n,gamman);    
    H{i,2}=hh;
    [hh,~]=hwg_DIII(m,n,gamman);   
    H{i,3}=hh;
end
countsave=-1*ones(num,1); % save all purely imaginary eigenvalues
alpha1list=0:0.01:1;
alpha2list=0:0.01:1;
countmax=0;
cond=zeros(length(alpha1list),length(alpha2list),num); %save all conductance map
for i=1:num
    H1=H{i,1};
    H2=H{i,2};
    H3=H{i,3};
    condmap=zeros(length(alpha1list));

    count=0;
    parfor alpha1index=1:length(alpha1list)
        alpha1=alpha1list(alpha1index);
        condlist=zeros(alpha1index,1);
        for alpha2index=1:length(alpha2list)            
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
            count=count+isimag(hh,ww);
            condlist(alpha2index)=G(0,hh,ww);
        end
        condmap(alpha1index,:)=condlist;
    end
    cond(:,:,i)=condmap;   
    countsave(i)=count;
    if  count>countmax
        countmax=count;
        fprintf("%d:%f\n",i,count/(length(alpha1list)*length(alpha2list)));
    end      

end
prob=mean(countsave(countsave~=-1))/(length(alpha1list)*length(alpha2list));
save(sprintf('M%d//N%d//Gn%1.1f//probalpha%d_uncorr_DIII.dat',m,n,gamman,num),'prob','-ascii');
save(sprintf('M%d//N%d//Gn%1.1f//sweepalpha%d_uncorr_DIII.mat',m,n,gamman,num), '-v7.3');
end
