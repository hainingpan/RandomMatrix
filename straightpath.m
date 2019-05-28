%%straight line assign
% x1=0.01;
% y1=0.719;
% x2=0.318;
% y2=0.22188;
% k=(y2-y1)/(x2-x1);
% l=@(x) k*(x-x1)+y1;
% alphalistx=linspace(0.4,x1,100);
% alphalisty=l(alphalistx);

%%straight line fit (x->y)
% fitlinex=zbcpx(1:end)';
% fitliney=zbcpy(1:end)';
% f=polyfit(fitlinex,fitliney,1);
% alphalistx=linspace(0.2823,fitlinex(end),500);
% alphalisty=polyval(f,alphalistx);


%%straight line fit (y->x)
% fitlinex=zbcpx(1:end)';
% fitliney=zbcpy(1:end)';
% f=polyfit(fitliney,fitlinex,1);
% alphalisty=linspace(0.35,fitliney(end),500);
% alphalistx=polyval(f,alphalisty);


% %%polynomial fit (x->y)
fitlinex=zbcpx(1:end)';
fitliney=zbcpy(1:end)';
f=polyfit(fitlinex,fitliney,3);
alphalistx=linspace(0.3,fitlinex(end),500);
alphalisty=polyval(f,alphalistx);

%%polynomial fit (y->x)
% fitlinex=zbcpx(1:end)';
% fitliney=zbcpy(1:end)';
% f=polyfit(fitliney,fitlinex,10);
% alphalisty=linspace(0.54,fitliney(end),500);
% alphalistx=polyval(f,alphalisty);


%%original contour line
% alphalistx=[prex,zbcpx(1:330)];
% alphalisty=[prey,zbcpy(1:330)];