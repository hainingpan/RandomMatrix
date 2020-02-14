% load('M80/N4/Gn0.1/enmap0_f.mat')
alpha1list=0:0.01:1;
alpha2list=0:0.01:1;
figure;

[matcont,valcont]=contour(alpha1list,alpha2list,enmap0',[2,6],'k');
xlabel('\alpha_1');
ylabel('\alpha_2');
matcontx=matcont(1,:);
matconty=matcont(2,:);
stopx=matcontx(0<=matcontx&matcontx<=1);
stopy=matconty(0<=matcontx&matcontx<=1);

pinx=.3790;
piny=0.4662;
pin2x=.37347;
pin2y=0.598;
% pin2x=pinx;
% pin2y=piny;
idx=knnsearch([stopx;stopy]',[pin2x,pin2y]);
remainingstop=[stopx;stopy]';
remainingstop(idx,:)=[10,10];
visit=zeros(1,length(stopx));
visit(idx)=1;
traj=[idx];
cur=idx;
[next,nextdist]=knnsearch(remainingstop,[stopx(cur),stopy(cur)]);
while visit(next)==0 && nextdist<0.005
    cur=next;
    visit(cur)=1;
    traj=[traj,cur];
    remainingstop(cur,:)=[10,10];
    [next,nextdist]=knnsearch(remainingstop,[stopx(cur),stopy(cur)]);
end


prestart=hypot((pinx-stopx(idx)),(piny-stopy(idx)));
prenum=ceil(prestart/0.001);
prex=linspace(pinx,stopx(idx),prenum);
prey=linspace(piny,stopy(idx),prenum);
prex=prex(1:end-1);
prey=prey(1:end-1);
zbcpx=stopx(traj);
zbcpy=stopy(traj);
alphalistx=[prex,zbcpx];
alphalisty=[prey,zbcpy];

figure;scatter(stopx,stopy,'.');xlabel('\alpha_1');ylabel('\alpha_2');
hold on;
plot(alphalistx,alphalisty,'r')