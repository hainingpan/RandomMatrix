clear
start=1;
k=10;
for i=start:k
    fprintf("\r%d",i);
    st{i}=tic;
    [condmap{i},eigvalmap{i},immap{i}]=sweepalpha_single_nw(80,0.1,3,0.5,i,982214);
    elapse(i)=toc(st{i});
end

figure;
plot(start:k,elapse(start:k));
[mm,ind]=min(elapse(start:k));
title(strcat('min=',num2str(ind+start-1)));

for i=start:k-1
    errcondmap=condmap{i}-condmap{i+1};
    erreigvalmap=eigvalmap{i}-eigvalmap{i+1};
%     errimmap=[immap{i}{:}]-[immap{i+1}{:}];
    if sum(abs(errcondmap(:)))>1e-10 || sum(abs(erreigvalmap(:)))>1e-10
        fprintf("err(%d->%d):%f\t%f\n",i,i+1,sum(abs(errcondmap(:))),...
        sum(abs(erreigvalmap(:))))
    end
end
    
