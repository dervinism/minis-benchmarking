function f = figProperties(titleStr, units, pos, col, visible)
% A function for creating an empty figure window.
% Input: titleStr
%        units - units to measure the screen size (string: 'pixels'
%                (default), 'normalized', 'inches', 'centimeters',
%                'points', 'characters'
%        pos - position vector: [displacement from the left side of the screen
%              displacement from the bottom of the screen width height];
%              col - background colour;
%              visible - figure visibility string ('on' or 'off').
%

f = figure('Units', units, 'Position', pos);
f.Name = titleStr;
f.Color = col;
f.Visible = visible;