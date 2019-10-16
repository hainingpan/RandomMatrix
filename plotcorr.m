t{1}=load('t0sweepL.mat');
t{2}=load('t0.25sweepL.mat');
t{3}=load('t0.5sweepL.mat');
t{4}=load('t0.75sweepL.mat');
t{5}=load('t1sweepL.mat');

figure;
errorbar(2:20,t{1}.mulist,t{1}.sigmalist,'DisplayName','t=0')
hold on;
errorbar(2:20,t{2}.mulist,t{2}.sigmalist,'DisplayName','t=0.25\delta_0')
errorbar(2:20,t{3}.mulist,t{3}.sigmalist,'DisplayName','t=0.5\delta_0')
errorbar(2:20,t{4}.mulist,t{4}.sigmalist,'DisplayName','t=0.75\delta_0')
errorbar(2:20,t{5}.mulist,t{5}.sigmalist,'DisplayName','t=\delta_0')

legend