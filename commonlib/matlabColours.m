function colourCode = matlabColours(colourNumber)
% colourCode = matlabColours(colourNumber)
%
% Function outputs a colour code of one of the default Matlab colours.
% There are 16 of them. Bigger number would recycle the previous colours.
% Input: colourNumber - a number from 1 to 16:
%                       1  - Light blue;
%                       2  - Dark orange;
%                       3  - Orange yellow;
%                       4  - Violet;
%                       5  - Light green;
%                       6  - Cyan;
%                       7  - Burgundy;
%                       8  - Proper blue;
%                       9  - Dark green;
%                       10 - Proper red;
%                       11 - Blue-green;
%                       12 - Purple;
%                       13 - Grass green;
%                       14 - Dark grey;
%                       15 - Vomit green;
%                       16 - Pink or magenta, if you like.
% Output: colourCode - a vector with RBG values.

colourNumber = rem(colourNumber, 16);
if colourNumber == 0
  colourNumber = 16;
end

if colourNumber == 1      % Light blue
  colourCode = [0, 0.4470, 0.7410];
elseif colourNumber == 2  % Dark orange
  colourCode = [0.8500, 0.3250, 0.0980];
elseif colourNumber == 3  % Orange yellow
  colourCode = [0.9290, 0.6940, 0.1250];
elseif colourNumber == 4  % Violet
  colourCode = [0.4940, 0.1840, 0.5560];
elseif colourNumber == 5  % Light green
  colourCode = [0.4660, 0.6740, 0.1880];
elseif colourNumber == 6  % Cyan
  colourCode = [0.3010, 0.7450, 0.9330];
elseif colourNumber == 7  % Burgundy
  colourCode = [0.6350, 0.0780, 0.1840];
elseif colourNumber == 8  % Proper blue
  colourCode = [0, 0, 1];
elseif colourNumber == 9  % Dark green
  colourCode = [0, 0.5, 0];
elseif colourNumber == 10 % Proper red
  colourCode = [1, 0, 0];
elseif colourNumber == 11 % Blue-green
  colourCode = [0, 0.75, 0.75];
elseif colourNumber == 12 % Purple
  colourCode = [0.75, 0, 0.75];
elseif colourNumber == 13 % Grass green
  colourCode = [0.75, 0.75, 0];
elseif colourNumber == 14 % Dark grey
  colourCode = [0.25, 0.25, 0.25];
elseif colourNumber == 15 % Vomit green
  colourCode = [0, 1, 0];
elseif colourNumber == 16 % Pink or magenta, if you like
  colourCode = [1, 0.1034, 0.7241];
end