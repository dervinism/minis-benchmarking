x = 0:0.00001:10;
y = exp(-x);

figure; plot(x,y); hold on
plot([x(1) x(end)], [1/exp(1) 1/exp(1)]);
plot([x(1) x(end)], [1/2 1/2]); hold off