x1 = [7 6 5 4 3 2];
y1 = [14 18 15 12 12 14];

x2 = [8 7 6 5 4 3 2];
y2 = [16 14 18 15 12 12 14];

plot(x1,y1,'-.r*','LineWidth',1.5,'MarkerSize',10);

set(gca,'fontsize',12, 'FontWeight','Bold');
xticks(linspace(0, 8, 9));
yticks(linspace(0, 18, 19));
xlabel('Width','FontName','Arial','FontWeight','Bold','FontSize',16);
ylabel('Area','FontName','Arial','FontWeight','Bold','FontSize',16);