clear
k=40;
for i=1:k
    st{i}=tic;
    [condmap{i},eigvalmap{i},immap{i}]=sweepalpha_single_nw(80,0.1,10,0.5,i,2);
    elapse(i)=toc(st{i});
end

figure;
plot(elapse);
[mm,ind]=min(elapse);
title(strcat('min=',num2str(ind)));

for i=1:k-1
    errcondmap=condmap{i}-condmap{i+1};
    erreigvalmap=eigvalmap{i}-eigvalmap{i+1};
%     errimmap=[immap{i}{:}]-[immap{i+1}{:}];
    if sum(abs(errcondmap(:)))>1e-10 || sum(abs(erreigvalmap(:)))>1e-10
        fprintf("err(%d->%d):%f\t%f\n",i,i+1,sum(abs(errcondmap(:))),...
        sum(abs(erreigvalmap(:))))
    end
end
    
