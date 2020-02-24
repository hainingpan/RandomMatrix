mu=[0,0];
sigma=[.1,0.;0.,.1];
R = mvnrnd(mu,sigma,1000);
% R(:,2)=tanh(R(:,2));
figure;
scatter(R(:,1),R(:,2),'.');
R=tall(R);

gridx1 = linspace(-5,5,100);
gridx2 = linspace(-5,5,100);
[X1,X2]=ndgrid(gridx1,gridx2);
X1=X1(:,:)';
X2=X2(:,:)';
xi=[X1(:),X2(:)];
f = mvksdensity(R,xi,'Bandwidth',0.8,'Kernel','normpdf','Support',[-Inf,-1;Inf,1]);
fgrid=reshape(f,[100,100]);
figure;surf(gridx1,gridx2,fgrid,'EdgeColor','none');view(2);