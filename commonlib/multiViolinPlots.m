function fH = multiViolinPlots(scatterGroups, areas, dataMean, dataCI95, stats, options)
% fH = multiViolinPlots(scatterGroups, areas, dataMean, dataCI95, stats, options)
%
% Function produces violin plots for multiple brain areas.
% Input: scatterGroups - a cell array of individual data points. Each
%                        element in the array corresponds to a different
%                        brain area. If it is a matrix instead, each column
%                        corresponds to a different area.
%        areas - a cell array of area names of interest.
%        dataMean - a row vector of data means.
%        dataCI95 - a double row vector of 95% confidence intervals (upper
%                   and lower).
%        stats - a structure with the following fields:
%          pval or pval_ttest - a vector with p value for a comparison of
%                               two areas.
%          area1 - an order (areas variable) of the first area in the
%                  comparison.
%          area2 - an order (areas variable) of the second area in the
%                  comparison.
%        options - a structure with the following fields:
%          yLim
%          yLabel - a y-axis label string.
%          yScale - y-axis scale type: either 'regular' or 'log'. Default
%                   is 'regular'.
%          textStr - a text string to print at the top of the figure.
%          showNotches - either true (default) or false.
%          medianPlot - either true (default) or false.
%          colours - if supplied, uses this cell array to read violin
%                    colour codes and overrides other colour choice
%                    algorithms.
%          markerFaceAlpha - a scalar ranging from 0 to 1 with 1 meaning no
%                            transparency of individual data points.
%          nSample - if not empty, indicates the size of individual samples
%                    underlying each data point. The field should contain
%                    cells with sample sizes. By default the numbers are
%                    not displayed.
%          violinVisibility - if false, the contours of the violin are
%                             eliminated. Default is true.

% Parse user input
if isempty(scatterGroups)
  fH = [];
  return
end
if ~isfield(options, 'showNotches')
  options.showNotches = true;
end
if ~isfield(options, 'medianPlot')
  options.medianPlot = true;
end
if ~isfield(options, 'colours')
  options.colours = [];
end
if ~isfield(options, 'markerFaceAlpha')
  options.markerFaceAlpha = 0.3;
end
if ~isfield(options, 'nSample')
  options.nSample = [];
end
if ~isfield(options, 'violinVisibility')
  options.violinVisibility = 'on';
end

% Plot violins
violinVectors = struct();
if iscell(scatterGroups)
  for iArea = 1:numel(areas)
    violinVectors.(areas{iArea}) = scatterGroups{iArea}(~isnan(scatterGroups{iArea}) & ~isinf(scatterGroups{iArea}));
  end
else
  for iArea = 1:numel(areas)
    violinVectors.(areas{iArea}) = scatterGroups(~isnan(scatterGroups(:,iArea)) & ~isinf(scatterGroups(:,iArea)),iArea);
  end
end
fH = figProperties('Violin plot for units', 'normalized', [0, .005, .97, .90], 'w', 'on');
violins = violinplot(violinVectors, areas);

for iArea = 1:numel(areas)
  
  if contains(areas{iArea},'Pos') || contains(areas{iArea},'Neg')
    areasShort{iArea} = strrep(areas{iArea}, 'Pos', '');
    areasShort{iArea} = strrep(areasShort{iArea}, 'Neg', '');
    areasLong{iArea} = strrep(areas{iArea}, 'Pos', '+');
    areasLong{iArea} = strrep(areasLong{iArea}, 'Neg', '-');
  else
    areasShort{iArea} = strrep(areas{iArea}, 'Awake', '');
    areasShort{iArea} = strrep(areasShort{iArea}, 'Anaest', '');
    areasLong{iArea} = areas{iArea};
  end
  
  % Adjust violin properties
  if ~isempty(options.colours)
    violins(iArea).ViolinColor = options.colours{iArea};
    violins(iArea).EdgeColor = options.colours{iArea};
  else
    try
      violins(iArea).ViolinColor = areaColours2(areasShort{iArea});
      violins(iArea).EdgeColor = areaColours2(areasShort{iArea});
    catch
      violins(iArea).ViolinColor = matlabColours(iArea);
      violins(iArea).EdgeColor = matlabColours(iArea);
    end
  end
  if ~isfield(options, 'medianPlot') || options.medianPlot
    violins(iArea).MedianColor = [1 1 1];
  else
    violins(iArea).MedianColor = [0.5 0.5 0.5];
    violins(iArea).MedianPlot.SizeData = 1;
  end
  violins(iArea).ViolinAlpha = 0.25;
  violins(iArea).ShowNotches = options.showNotches;
  violins(iArea).ShowMean = true;
  violins(iArea).ScatterPlot.MarkerFaceAlpha = options.markerFaceAlpha;
  %violins(iArea).ScatterPlot.MarkerEdgeColor = 'k';
  if ~options.violinVisibility
    violins(iArea).ViolinPlot.Visible  = 'on';
    violins(iArea).BoxPlot.Visible  = 'off';
    violins(iArea).WhiskerPlot.Visible  = 'off';
  end
  
  % Produce 95% confidene intervals on means
  sideSizeY = round(size(violins(iArea).ViolinPlot.Vertices,1)/2);
  if sideSizeY < 2
    continue
  end
  rightSideY = violins(iArea).ViolinPlot.Vertices(1:sideSizeY,2);
  interpRightSideY = sort([rightSideY; dataMean(iArea)+dataCI95(:,iArea)], 'ascend');
  leftSideY = violins(iArea).ViolinPlot.Vertices(sideSizeY+1:end,2);
  interpLeftSideY = sort([leftSideY; dataMean(iArea)+dataCI95(:,iArea)], 'descend');
  
  sideSizeX = round(size(violins(iArea).ViolinPlot.Vertices,1)/2);
  if sideSizeX < 2
    continue
  end
  rightSideX = violins(iArea).ViolinPlot.Vertices(1:sideSizeX,1);
  interpRightSideX = interp1(rightSideY, rightSideX, interpRightSideY);
  leftSideX = violins(iArea).ViolinPlot.Vertices(sideSizeX+1:end,1);
  interpLeftSideX = interp1(leftSideY, leftSideX, interpLeftSideY);
  
  lowerLimit1 = interpLeftSideX(interpLeftSideY == dataMean(iArea)+dataCI95(1,iArea));
  lowerLimit2 = interpRightSideX(interpRightSideY == dataMean(iArea)+dataCI95(1,iArea));
  upperLimit1 = interpLeftSideX(interpLeftSideY == dataMean(iArea)+dataCI95(2,iArea));
  upperLimit2 = interpRightSideX(interpRightSideY == dataMean(iArea)+dataCI95(2,iArea));
  
  if ~isempty(options.colours)
    plot([lowerLimit1 lowerLimit2], [dataMean(iArea)+dataCI95(1) dataMean(iArea)+dataCI95(1)], '--', 'Color',options.colours{iArea});
    plot([upperLimit1 upperLimit2], [dataMean(iArea)+dataCI95(2) dataMean(iArea)+dataCI95(2)], '--', 'Color',options.colours{iArea});
  else
    try
      plot([lowerLimit1 lowerLimit2], [dataMean(iArea)+dataCI95(1) dataMean(iArea)+dataCI95(1)], '--', 'Color',areaColours2(areasShort{iArea}));
      plot([upperLimit1 upperLimit2], [dataMean(iArea)+dataCI95(2) dataMean(iArea)+dataCI95(2)], '--', 'Color',areaColours2(areasShort{iArea}));
    catch
      plot([lowerLimit1 lowerLimit2], [dataMean(iArea)+dataCI95(1) dataMean(iArea)+dataCI95(1)], '--', 'Color',matlabColours(iArea));
      plot([upperLimit1 upperLimit2], [dataMean(iArea)+dataCI95(2) dataMean(iArea)+dataCI95(2)], '--', 'Color',matlabColours(iArea));
    end
  end
end

% Indicate individual sample sizes next to each point
if ~isempty(options.nSample)
  for iViolin = 1:numel(violins)
    text(violins(iViolin).ScatterPlot.XData, violins(iViolin).ScatterPlot.YData,...
      num2str(options.nSample{iViolin}));
  end
end

% Adjust figure properties
xLim = xlim;
xAxisLength = xLim(2)-xLim(1);
yLim = ylim;
if ~isempty(options.yLim)
  yLim(1) = max([yLim(1) options.yLim(1)]);
  yLim(2) = min([yLim(2) options.yLim(2)]);
  ylim(yLim);
end
if isfield(options,'yScale') && strcmp(options.yScale,'log')
  set(gca,'Yscale','log')
end
yAxisLength = yLim(2)-yLim(1);

if ~isempty(stats) && (~isfield(options, 'textStr') || isempty(options.textStr))
  textStr = [];
  for iArea = 1:numel(areas)
    textStr = [textStr 'v' num2str(iArea)]; %#ok<*AGROW>
  end
  textStr = ['comp ' textStr(2:end) 'v1 p-val: '];
  for iArea = 1:numel(areas)-1
    try
      textStr = [textStr num2str(stats.pval(ismember(stats.area1,areas{iArea}) & ismember(stats.area2,areas{iArea+1}))) ' '];
    catch
      textStr = [textStr num2str(stats.pval_ttest(ismember(stats.area1,areas{iArea}) & ismember(stats.area2,areas{iArea+1}))) ' '];
    end
  end
  try
    textStr = [textStr num2str(stats.pval(ismember(stats.area1,areas{1}) & ismember(stats.area2,areas{iArea+1})))];
  catch
    textStr = [textStr num2str(stats.pval_ttest(ismember(stats.area1,areas{1}) & ismember(stats.area2,areas{iArea+1})))];
  end
  text(xLim(2)-xAxisLength*0.95, yLim(2)-yAxisLength*0.05, textStr, 'FontSize',20);
elseif isfield(options, 'textStr') && ~isempty(options.textStr)
  text(xLim(2)-xAxisLength*0.95, yLim(2)-yAxisLength*0.05, options.textStr, 'FontSize',20);
end

ax1 = axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 55, 4/3, 2, [0.003 0.003], 'out', 'on', 'k', {}, xLim,...
  xticks, 'on', 'k', {options.yLabel}, yLim, yticks);
xTickLabel = areasLong;
for iLabel = 1:numel(xTickLabel)
  xTickLabel{iLabel} = strrep(xTickLabel{iLabel}, 'l','');
  xTickLabel{iLabel} = strrep(xTickLabel{iLabel}, 'r','');
end
ax1.XTickLabel = xTickLabel;
end