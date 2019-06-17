function sweepalpha_rand(m,gamman)
num=5;
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
countsave=-1*ones(num,1);

for i=1:num
    H1=H{i,1};
    H2=H{i,2};
    H3=H{i,3};
    alpha1list=0:0.001:1;
    alpha2list=0:0.001:1;
    count=0;
    enmap0=zeros(length(alpha1list),length(alpha2list));
    parfor alpha1index=1:length(alpha1list)
        entmp0=zeros(1,length(alpha2list));
        for alpha2index=1:length(alpha2list)
            alpha1=alpha1list(alpha1index);
            alpha2=alpha2list(alpha2index);
            hh=alpha1*H1+alpha2*H2+(1-alpha1-alpha2)*H3;
            count=count+isimag(hh,ww);
            cond0=G(0,hh,ww); 
            entmp0(alpha2index)=cond0;
        end
        enmap0(alpha1index,:)=entmp0;
    end
    countsave(i)=count;
%     if  count>countmax
%         countmax=count;
%         fprintf("%d:%f\n",i,count/(length(alpha1list)*length(alpha2list)));
%     end      
    disp(count/(length(alpha1list)*length(alpha2list)));
    enmap0=real(enmap0);
    save(sprintf("M80/N4/Gn%.1f/enmap0_rand_%d.mat",gamman,i),'-v7.3');
end
end
