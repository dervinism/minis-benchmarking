function paperSize = resizeFig(f, ax, width, height, label, margin, gap)
% Function for resizing and cropping the figure.
% Input: f - figure handle;
%        ax - axes objects corresponding to the figure handle;
%        width, height in cm;
%        label - y and x label area size ([y x]);
%        margin on the right-hand side and at the top ([right top]);
%        distance between graphs if there are more than one axes object to
%          display in the figure
% Output: paperSize - figure size vector for saving: [width height].
%

paperSize = [label(1)+width+margin(1) label(2)+height+margin(2)];

width = width*40;
height = height*40;
label = label*40;
margin = margin*40;
gap = gap*40;
screenSize = get(0, 'ScreenSize');
screenSize = [screenSize(3) screenSize(4) screenSize(3) screenSize(4)];

fPos(1) = (screenSize(1)-width)/2 - label(1);
fPos(2) = (screenSize(2)-height)/2 - label(2);
fPos(3) = label(1)+width+margin(1);
fPos(4) = label(2)+height+margin(2);
set(f, 'Units', 'pixels', 'Position', fPos);
set(f, 'Units', 'normalized');

for i = 1:length(ax)
    axPos(1) = label(1);
    axPos(2) = label(2) + (length(ax)-i)*((height-gap*(length(ax)-1))/length(ax)+gap);
    axPos(3) = width;
    axPos(4) = (height-gap*(length(ax)-1))/length(ax);
    set(ax(i), 'Units', 'pixels', 'Position', axPos);
    set(ax(i), 'Units', 'normalized');
end