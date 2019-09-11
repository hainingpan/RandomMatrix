ensemblesize=size(eigval,3);
rmap=zeros(length(alpha1list),length(alpha2list),ensemblesize);
for index=1:ensemblesize
    if mod(index,10)==0
        disp(index)
    end
    eigmap=eigval(:,:,index);
    [ilist,jlist,klist]=find(eigmap); % i is y-axis, j is x-axis
    [matcont,~]=contour(alpha1list,alpha2list,eigmap,[0.5,1.5],'k');
    [idx,d]=knnsearch(matcont',[alpha1list(jlist);alpha2list(ilist)]');
    d=tanh(d);  %scale to [0,1]
    rmap(:,:,index)=sparse(ilist,jlist,d,length(alpha1list),length(alpha2list));
end

% crit=0.03;
% condzbcp=(rmap>crit).*(eigval==1).*cond;
% histogram(nonzeros(condzbcp(:)),0:0.4:4,'Normalization','probability');
% xlabel('G(e^2/h)');ylabel('Probability');
% title(strcat('Candidate region for R>',num2str(crit),' : ',num2str(nnz(condzbcp)/length(cond(:)))))
% nnz(condzbcp)

% crit=0.02;
% condzbcp=(rmap>crit).*(eigval==1).*cond;
% gzbcp=sort(nonzeros(condzbcp(:)));
% p=polyfit(gzbcp',(1:length(gzbcp))/length(gzbcp),7)
% q=polyder(p);
% glist=linspace(0,4,50);
% plist=polyval(q,glist);
% figure;
% plot(glist,plist);
% hold on;
% plot(gzbcp,(1:length(gzbcp))/length(gzbcp));
% plot(glist,polyval(p,glist));
% axis([0,4,0,1])
% title(strcat('Candidate # for R>',num2str(crit),' : ',num2str(nnz(condzbcp))))



crit=0;
condzbcp=(rmap>crit).*(eigval==1).*cond;
fig=figure;
scatter(nonzeros(rmap),nonzeros(condzbcp),'.');
saveas(fig,'R_vs_cond.png');
% gzbcp=sort(nonzeros(condzbcp(:)));
% fit=griddedInterpolant(gzbcp,(1:length(gzbcp))/length(gzbcp));
% glist=linspace(0,4,50);
% eps=0.01;
% glist=glist(2:end-1);
% glistforward=glist-eps;
% glistafterward=glist+eps;
% plist=(fit(glistafterward)-fit(glistforward))/(2*eps);
% figure;
% plot(glist,plist);
% axis([0,4,0,0.5])