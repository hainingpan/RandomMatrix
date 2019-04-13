vvdist=zeros(size(gamma,2),1);
parfor i=1:size(gamma,2)
    [~,~,~,im,vecim]=dist(H{i},W{i});
    vvdist(i)=mean(abs(diff(abs(vecim).^2,1,2)));
end
 scatter((gamma(2,:)./gamma(1,:)),vvdist,'k.')