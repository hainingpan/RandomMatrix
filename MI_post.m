sweeptdata{1}=load('D:\CMTC\Rp_RM\Rp17\L2sweeptLMI.mat');
sweeptdata{2}=load('D:\CMTC\Rp_RM\Rp17\L5sweeptLMI.mat');
sweeptdata{3}=load('D:\CMTC\Rp_RM\Rp17\L10sweeptLMI.mat');


sweepLdata{1}=load('D:\CMTC\Rp_RM\Rp17\t0sweeptLMI.mat');
sweepLdata{2}=load('D:\CMTC\Rp_RM\Rp17\t0.25sweeptLMI.mat');
sweepLdata{3}=load('D:\CMTC\Rp_RM\Rp17\t0.5sweeptLMI.mat');
sweepLdata{4}=load('D:\CMTC\Rp_RM\Rp17\t0.75sweeptLMI.mat');
sweepLdata{5}=load('D:\CMTC\Rp_RM\Rp17\t1sweeptLMI.mat');


figure;plot(-1:0.1:1,mean(sweeptdata{1}.NMIvstlist,1),'DisplayName','L=2');
hold on;
plot(-1:0.1:1,mean(sweeptdata{2}.NMIvstlist,1),'DisplayName','L=5')
plot(-1:0.1:1,mean(sweeptdata{3}.NMIvstlist,1),'DisplayName','L=10')
xlabel('t/\delta_0');
ylabel('NMI');
title('Mean NMI')
legend;

figure;plot(2:20,mean(sweepLdata{1}.NMIvsLlist),'DisplayName','t=0');
hold on;
plot(2:20,mean(sweepLdata{2}.NMIvsLlist),'DisplayName','t=0.25');
plot(2:20,mean(sweepLdata{3}.NMIvsLlist),'DisplayName','t=0.5');
plot(2:20,mean(sweepLdata{4}.NMIvsLlist),'DisplayName','t=0.75');
plot(2:20,mean(sweepLdata{5}.NMIvsLlist),'DisplayName','t=1');
legend;