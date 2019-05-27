figure;
plot(enlist,condmap0(10,:),'DisplayName','A');xlabel('E/\delta_0');ylabel('G(e^2/h)');
hold on;
plot(enlist,condmap0(210,:),'DisplayName','B');
plot(enlist,condmap0(310,:),'DisplayName','C');
legend

