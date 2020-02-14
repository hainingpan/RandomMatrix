%%straight line assign
x1=0.6325;
y1=0.5;
x2=0.6325;
y2=0.43;
alphalistx=linspace(x1,x2,500)-0.18;
alphalisty=linspace(y1,y2,500)+0.0;
% k=(y2-y1)/(x2-x1);
% l=@(x) k*(x-x1)+y1;
% alphalistx=linspace(x,x1,400);
% alphalisty=l(alphalistx);

%%straight line fit (x->y)
% fitlinex=zbcpx(1:206)';
% fitliney=zbcpy(1:206)';
% f=polyfit(fitlinex,fitliney,1);
% alphalistx=linspace(0.4942,fitlinex(end),500);
% alphalisty=polyval(f,alphalistx);


%%straight line fit (y->x)
% fitlinex=zbcpx(1:354)';
% fitliney=zbcpy(1:354)';
% f=polyfit(fitliney,fitlinex,1);
% alphalisty=linspace(0.4662,fitliney(end),500);
% alphalistx=polyval(f,alphalisty);

%%straight line shift
% alphalistx=alphalistx-0.004;
% alphalisty=alphalisty+0.02;


% %%polynomial fit (x->y)
% fitlinex=zbcpx(1:206)';
% fitliney=zbcpy(1:206)';
% f=polyfit(fitlinex,fitliney,2);
% alphalistx=linspace(0.53,fitlinex(end),500);
% alphalisty=polyval(f,alphalistx);

%%polynomial fit (y->x)
% fitlinex=zbcpx(1:288)';
% fitliney=zbcpy(1:288)';
% f=polyfit(fitliney,fitlinex,4);
% alphalisty=linspace(0.2679,fitliney(end),500);
% alphalistx=polyval(f,alphalisty);


%%original contour line
% alphalistx=[prex,zbcpx(1:354)];
% alphalisty=[prey,zbcpy(1:354)];