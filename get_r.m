function rmap=get_r(alpha1list,alpha2list,eigvalmap,crit)
    [ilist,jlist,~]=find(eigvalmap); % i is y-axis, j is x-axis
    [matcont,~]=contour(alpha1list,alpha2list,eigvalmap,[0.5,1.5],'k');
    [~,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
    %  d=tanh(d);  %scale to [0,1]
    d=d.*(d>=crit);
    rmap=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
end
