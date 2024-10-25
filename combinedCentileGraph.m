% Load the figure
figFolder = 'C:\Users\44079\code_repositories\minis-benchmarking\fitFigures';
fH = openfig('C:\Users\44079\Phd\Paper4\Fits\best_fits_new_15score\p103a\error_bounds\EPSP 15-score combined SAD 50th centile.fig');

% Get the data
axObjs = fH.Children;
dataObjs = axObjs(2).Children;
x = dataObjs(7).XData;
y = dataObjs(7).YData;

% Bin the data
[N,Xedges,Yedges] = histcounts2(x,y);
xBinSize = Xedges(2) - Xedges(1);
yBinSize = Yedges(2) - Yedges(1);
[X,Y] = meshgrid(Xedges(2:end)-xBinSize, Yedges(2:end)-yBinSize);

% Plot the contours
hold on;
p = plot(x,y, '.', 'Color',[0.5 0.5 0.5], 'MarkerSize',5);
[ci, c] = contour(X,Y,N', ':', 'LineWidth',1, 'ShowText','on');
colormap(copper);
hold off

% Adjust line widths
lines = findall(gcf,'type','line');
set(lines(2), 'LineStyle','-.');
set(lines(3), 'LineStyle','-.');
set(lines(4), 'LineStyle','-.');
set(lines(5), 'LineStyle','-.');
set(lines(6), 'LineStyle','-.');
set(lines(7), 'LineStyle','-.');
set(lines(2), 'LineWidth',1.1);
set(lines(3), 'LineWidth',1.1);
set(lines(4), 'LineWidth',1.1);
set(lines(5), 'LineWidth',1.1);
set(lines(6), 'LineWidth',1.1);
set(lines(7), 'LineWidth',1.1);

% Adjust axes' ranges
xLim = xlim;
xlim([xLim(1) 120]);
yLim = ylim;
ylim([yLim(1) 110]);

% Adjust the legend
legend([p, lines(6), lines(4), lines(2), c], ...
  {'Single sweep file combinations', 'Mean', 'Median', 'Combined 50^{th} centile', 'Data count density contours'}, ...
  'Location','NorthWest');
legend('boxoff')

% Label the figure and axes
fontSize = 18;
fTitle = 'SAD contours';
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
xlabel('Amplitude SAD (count)', 'FontSize',fontSize, 'FontWeight','bold')
ylabel('Rise time SAD (count)', 'FontSize',fontSize, 'FontWeight','bold')

% Tidy the figure
set(fH, 'Color', 'white');
ax = gca;
set(ax, 'box', 'off');
set(ax, 'TickDir', 'out');
yTicks = get(ax, 'YTick');
if numel(yTicks) > 8
  set(ax, 'YTick', yTicks(1:2:end));
end
ax.FontSize = fontSize - 4;
set(get(ax, 'XAxis'), 'FontWeight', 'bold');
set(get(ax, 'YAxis'), 'FontWeight', 'bold');
set(ax,'linewidth',1.5);

% Save the figure
if ~exist(figFolder, 'dir')
  mkdir(figFolder);
end
figName = strrep(fTitle, ' ', '_');
figName = strrep(figName, '(', '_');
figName = strrep(figName, ')', '_');
figName = strrep(figName, '/', '_');
figName = strrep(figName, '.', '_');
figName = fullfile(figFolder, figName);
savefig(fH, figName,'compact');
title('');
saveas(fH, figName, 'png');
saveas(fH, figName, 'pdf');
close(fH);