sweeptdata{1}=load('D:\CMTC\Rp_RM\Rp17\L2sweeptLMI.mat');
sweeptdata{2}=load('D:\CMTC\Rp_RM\Rp17\L5sweeptLMI.mat');
sweeptdata{3}=load('D:\CMTC\Rp_RM\Rp17\L10sweeptLMI.mat');


figure;plot(-1:0.1:1,mean(sweeptdata{1}.NMIvstlist,1),'DisplayName','L=2');
hold on;
plot(-1:0.1:1,mean(sweeptdata{2}.NMIvstlist,1),'DisplayName','L=5')
plot(-1:0.1:1,mean(sweeptdata{3}.NMIvstlist,1),'DisplayName','L=10')
xlabel('t/\delta_0');
ylabel('NMI');
title('Mean NMI')
legend;