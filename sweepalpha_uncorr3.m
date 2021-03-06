function sweepalpha_uncorr3(m,gamman)
num=200;
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
countsave=-1*ones(num,1);

countmax=0;
for i=1:num
    disp(i);
    H1=H{i,1};
    H2=H{i,2};
    H3=H{i,3};
    H4=H{i,4};
    
    alpha1list=0:0.01:1;
    alpha2list=0:0.01:1;
    alpha3list=0:0.01:1;
    count=0;
    parfor alpha1index=1:length(alpha1list)
        for alpha2index=1:length(alpha2list)
            for alpha3index=1:length(alpha3list)
                alpha1=alpha1list(alpha1index);
                alpha2=alpha2list(alpha2index);
                alpha3=alpha3list(alpha3index);
                hh=alpha1*H1+alpha2*H2+alpha3*H3+(1-alpha1-alpha2-alpha3)*H4;
                count=count+isimag(hh,ww);
            end
        end
    end
    countsave(i)=count;
    if  count>countmax
        countmax=count;
        fprintf("%d:%f\n",i,count/(length(alpha1list)*length(alpha2list)*length(alpha3list)));
    end      
end
prob=mean(countsave(countsave~=-1))/(length(alpha1list)*length(alpha2list)*length(alpha3list));

save(sprintf('M%d//N%d//Gn%s//probalpha%d_uncorr3.dat',m,n,num2str(gamman),num),'prob','-ascii');
save(sprintf('M%d//N%d//Gn%s//sweepalpha%d_uncorr3.mat',m,n,num2str(gamman),num), '-v7.3');
end
