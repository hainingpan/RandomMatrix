function sweepalpha(m,gamman)
num=50;
H=cell(num,1);

[~,ww]=hwg(m,2,gamman);  

for i=1:num
    [hh,~]=hwg(m,2,gamman);  
    H{i}=hh;
%     Heff{i}=heff(hh,ww);
end
countsave=-1*ones(length(H),length(H),length(H));

countmax=0;
for i=1:length(H)
    H1=H{i};
    for j=i+1:length(H)
    H2=H{j};
        for k=j+1:length(H)
        H3=H{k};
        alpha1list=0:0.01:1;
        alpha2list=0:0.01:1;
%     eiglist=zeros(length(alpha1list),length(H1));
        count=0;
        parfor alpha1index=1:length(alpha1list)
            for alpha2index=1:length(alpha2list)
                alpha1=alpha1list(alpha1index);
                alpha2=alpha2list(alpha2index);
                hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
                count=count+isimag(hh,ww);
        %         eiglist(alpha1index,:)=eig(hheff)
            end
        end
        countsave(i,j,k)=count;
        if  count>countmax
            countmax=count;
            fprintf("%d,%d,%d:%f\n",i,j,k,count/(length(alpha1list)*length(alpha2list)));
        end
        end
    end
end
prob=mean(countsave(countsave~=-1))/(length(alpha1list)*length(alpha2list));
save(sprintf('M%d//Gn%1.1f//probalpha.dat',m,gamman),'prob','-ascii');
save(sprintf('M%d//Gn%1.1f//sweepalpha%d.mat',m,gamman,num), '-v7.3');
end
