function ca = axesProperties(titleStr, titleSzMult, titleWeight, boxStr,...
  col, font, fontSz, labelSzMult, width, tickLength, tickDir, xVisible,...
  xCol, xLab, xRange, xTicks, yVisible, yCol, yLab, yRange, yTicks)
% This function controls figure properties.
% Input: titleStr - figure title (string);
%        titleSzMult - title font size multiplier (scalar);
%        titleWeight - title Weight (string: 'normal', 'bold');
%        boxStr - figure border (string: 'on' or 'off');
%        col - frame colour (colour string or vector code);
%        font - text font type;
%        fontSz - font size;
%        labelSzMult - label font size multiplier;
%        width - coordinate axis width;
%        tickLength;
%        tickDir - tick pointing direction: inside ('in') or outside ('out');
%        xVisible - x axis visibility (string: 'on', 'off');
%        xCol - x axis colour;
%        xLab - x axis label string;
%        xRange - x axis range (vector);
%        xTicks - a vector indicating where to draw ticks on the x axis;
%        yVisible, yCol, yLab, yRange, yTicks
%
% Output: ca - a figure handle.
%

ca = gca;
set(gca, 'Box', boxStr);
set(gca, 'Color', col);
set(gca, 'FontName', font);
set(gca, 'FontSize', fontSz);
set(gca, 'LabelFontSizeMultiplier', labelSzMult);
set(gca, 'LineWidth', width);
set(gca, 'TickLength', tickLength);
set(gca, 'TickDir', tickDir);
title(titleStr);
set(gca, 'TitleFontSizeMultiplier', titleSzMult);
set(gca, 'TitleFontWeight', titleWeight);
try
  ca.XRuler.Axle.Visible = xVisible;
catch
  pause(0.1)
  ca.XRuler.Axle.Visible = xVisible;
end
set(gca, 'XColor', xCol);
xlabel(xLab);
if ~isempty(xRange)
    xlim(xRange);
end
if ~isempty(xTicks)
  set(gca, 'XTick', xTicks);
end
ca.YRuler.Axle.Visible = yVisible;
set(gca, 'YColor', yCol);
ylabel(yLab);
if ~isempty(yRange)
    ylim(yRange);
end
if ~isempty(yTicks)
  set(gca, 'YTick', yTicks);
end