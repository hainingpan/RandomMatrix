function xmax=findmax(func,x0,x1)
% x0=0;
% x1=2;
step=(x1-x0)/2; 
x=(x1+x0)/2;
% func=@(x) sin(x);
count=0;
while(step>1e-5)
    xr=x+step/2;
    xl=x-step/2;
    yr=func(xr);
    yl=func(xl);
    if (yr>yl)
        x=xr;
    else
        x=xl;
    end
    step=step/2;      
    count=count+1;
end
xmax=x;
end
    