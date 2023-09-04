function exportFig(f, titleStr, format, dpi, paperSize)
% exportFig function saves a figure in a chosen format and resolution.
% Input: f - figure handle;
%        titleStr - figure title string;
%        format - available formats are listed in >>help print and navigate to fomattype
%        dpi - resolution (dots per inch). 300 dpi is the standard and is sufficient for most purposes.
%        paperSize - figure size in centimetres: [width height];
%

set(f, 'Units', 'centimeters');
set(f, 'PaperUnits', 'centimeters');
set(f, 'PaperSize', paperSize)
set(f, 'PaperPosition', [0, 0, paperSize(1), paperSize(2)])

print(f, titleStr, format, dpi);
set(f, 'Units', 'normalized');