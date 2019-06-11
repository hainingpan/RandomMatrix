figure;
plot(enlist,condmap0(10,:),'DisplayName','A_1');xlabel('E/\delta_0');ylabel('G(e^2/h)');
hold on;
plot(enlist,condmap0(210,:),'DisplayName','A_2');
plot(enlist,condmap0(410,:),'DisplayName','A_3');
legend

