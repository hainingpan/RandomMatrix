list=0:0.05:0.5;
prob=zeros(length(list),1);
ub=2*(1+list);
lb=2*(1-list);
for i=1:length(list)
ratio=list(i);
prob(i)=nnz(cond(:)>lb(i) & cond(:)<ub(i))/nnz(cond(:));
end
plot(2*list,prob);
xlabel('\pm G (e^2/h)');
ylabel('Probability');