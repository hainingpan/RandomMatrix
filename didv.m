figure;
plot(enlist,condmap0(5,:),'DisplayName','A');xlabel('E/\delta_0');ylabel('G(e^2/h)');
hold on;
plot(enlist,condmap0(30,:),'DisplayName','B');
plot(enlist,condmap0(60,:),'DisplayName','C');
legend

