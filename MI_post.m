sweeptdata{1}=load('D:\CMTC\Rp_RM\Rp17\L2sweeptLMI.mat');
sweeptdata{2}=load('D:\CMTC\Rp_RM\Rp17\L5sweeptLMI.mat');

figure;plot(-1:0.1:1,mean(sweeptdata{1}.NMIvstlist,1));
hold on;
plot(-1:0.1:1,mean(sweeptdata{2}.NMIvstlist,1))