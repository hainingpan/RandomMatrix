filedir='d:\CMTC\Rp_RM\Rp20';
for seed=1:1000
    disp(seed)
    combine_(filedir,seed)
end

function combine_(filedir,seed)
try
    l1=load(strcat(filedir,'/condmap',num2str(seed),'.mat'));
    l2=load(strcat(filedir,'/eigvalmap',num2str(seed),'.mat'));
    l3=load(strcat(filedir,'/detSmap',num2str(seed),'.mat'));
catch
    fprintf('%d does not exist',seed);
    return
end
condmap=l1.condmap;
eigvalmap=l2.eigvalmap;
detSmap=l3.detSmap;

eigvalmap=logical(eigvalmap);
condmap=single(condmap);
detSmap_err=max(abs(imag(detSmap)),[],'all');
assert(detSmap_err<1e-7,sprintf('detS %e is not real',detSmap_err));
detSmap=single(real(detSmap));

save(sprintf('%s//ensemble_%d.mat',filedir,seed),'eigvalmap', 'condmap','detSmap','-v7.3');
end
