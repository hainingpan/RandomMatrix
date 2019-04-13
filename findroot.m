eigmapf=cell(num,1);
% eigmaps=cell(num,1);


% full spectrum
for i=1:num
    eigmapf{i}=eig(Heff{i});
end
% 
% % re nearest to 0 spectrum
% for i=1:num
%     eigmaps{i}=1./eigs(@(x) Heff{i}\x,length(Heff{1}),2,'be');
% end

%full spectrum, test nearest to 0. threshold =1e-10
thr=1e-10;
imlist=[];
gammamap=[];
for i=1:num
    if (min(abs(real(eigmapf{i})))<thr)
        imlist=[imlist,i];
        [val,pos]=mink(abs(real(eigmapf{i})),2);
        im=-imag(eigmapf{i}(pos));
        gammamap=[gammamap,sort(im)];
    end
end
cond=zeros(length(imlist),1);
for i=1:length(imlist)
    ind=imlist(i);
    condlist=arrayfun(@(x) G(x,H{ind},W{ind}),-0.05:0.005:0.05);
    cond(i)=real(mean(condlist));
end
figure;scatter(cond,log(gammamap(2,:)./gammamap(1,:)),'.')
% figure;
% eigmapmat=cell2mat(eigmapf(4));
% re=real(eigmapmat);
% im=imag(eigmapmat);
% scatter(re(:),im(:),'k.');
% xlim([-1,1]);


% for i=1:num
%     re=real(eigmap{i});
%     im=imag(eigmap{i});
% %     scatter(re,im,'k.')
% %     hold on
% end
