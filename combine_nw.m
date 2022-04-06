% filedir='d:\CMTC\Rp_RM\Rp20';
% t=0;
% L=2;
function combine_nw(filedir,t,L)
for seed=1:1000
    disp(seed)
    combine_nw_(filedir,t,L,seed)
end
end

function combine_nw_(filedir,t,L,seed)
try
    l1=load(strcat(filedir,sprintf('/condmapt%.2fL%d_',t,L),num2str(seed),'.mat'));
    l2=load(strcat(filedir,sprintf('/eigvalmapt%.2fL%d_',t,L),num2str(seed),'.mat'));
    l3=load(strcat(filedir,sprintf('/detSmapt%.2fL%d_',t,L),num2str(seed),'.mat'));
catch
    fprintf('t%.2fL%d_%d does not exist',t,L,seed)
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

save(sprintf('%s//ensemble_t%.2fL%d_%d.mat',filedir,t,L,seed),'eigvalmap', 'condmap','detSmap','-v7.3');
end
