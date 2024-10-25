%% User input parameters
figFolder = 'C:\Users\44079\code_repositories\minis-benchmarking\fitFigures';
recIDs = {'p103a','p106b','p108a','p108b','p108c','p120b','p122a','p124b', ...
  'p125a','p127c','p128c','p129a','p131a','p131c'};
markerSize = 2;
sweepColour = 'y';
transparency = 0.3;
tTransparency = 1;
rec = 11;



%% Set the legend position
if rec == 1
  legendPosition1 = [0.80 0.880 0.1 0.035];
  legendPosition2 = [0.80 0.825 0.1 0.035];
  legendPosition3 = [0.80 0.685 0.1 0.035];
  legendPosition5 = [0.77 0.390 0.1 0.035];
  legendPosition6 = [0.77 0.250 0.1 0.035];
elseif rec == 2
  legendPosition1 = [0.84 0.880 0.1 0.035];
  legendPosition2 = [0.84 0.825 0.1 0.035];
  legendPosition3 = [0.84 0.685 0.1 0.035];
  legendPosition5 = [0.81 0.390 0.1 0.035];
  legendPosition6 = [0.81 0.250 0.1 0.035];
elseif rec == 3
  legendPosition1 = [0.72 0.880 0.1 0.035];
  legendPosition2 = [0.72 0.825 0.1 0.035];
  legendPosition3 = [0.72 0.685 0.1 0.035];
  legendPosition5 = [0.69 0.390 0.1 0.035];
  legendPosition6 = [0.69 0.250 0.1 0.035];
elseif rec == 4
  legendPosition1 = [0.80 0.880 0.1 0.035];
  legendPosition2 = [0.80 0.825 0.1 0.035];
  legendPosition3 = [0.80 0.685 0.1 0.035];
  legendPosition5 = [0.77 0.390 0.1 0.035];
  legendPosition6 = [0.77 0.250 0.1 0.035];
elseif rec == 5
  legendPosition1 = [0.84 0.880 0.1 0.035];
  legendPosition2 = [0.84 0.825 0.1 0.035];
  legendPosition3 = [0.84 0.685 0.1 0.035];
  legendPosition5 = [0.81 0.390 0.1 0.035];
  legendPosition6 = [0.81 0.250 0.1 0.035];
elseif rec == 6
  legendPosition1 = [0.84 0.880 0.1 0.035];
  legendPosition2 = [0.84 0.825 0.1 0.035];
  legendPosition3 = [0.84 0.685 0.1 0.035];
  legendPosition5 = [0.81 0.390 0.1 0.035];
  legendPosition6 = [0.81 0.250 0.1 0.035];
elseif rec == 7
  legendPosition1 = [0.79 0.880 0.1 0.035];
  legendPosition2 = [0.79 0.825 0.1 0.035];
  legendPosition3 = [0.79 0.685 0.1 0.035];
  legendPosition5 = [0.76 0.390 0.1 0.035];
  legendPosition6 = [0.76 0.250 0.1 0.035];
elseif rec == 8
  legendPosition1 = [0.81 0.880 0.1 0.035];
  legendPosition2 = [0.81 0.825 0.1 0.035];
  legendPosition3 = [0.81 0.685 0.1 0.035];
  legendPosition5 = [0.78 0.390 0.1 0.035];
  legendPosition6 = [0.78 0.250 0.1 0.035];
elseif rec == 9
  legendPosition1 = [0.80 0.880 0.1 0.035];
  legendPosition2 = [0.80 0.825 0.1 0.035];
  legendPosition3 = [0.80 0.685 0.1 0.035];
  legendPosition5 = [0.77 0.390 0.1 0.035];
  legendPosition6 = [0.77 0.250 0.1 0.035];
elseif rec == 10
  legendPosition1 = [0.77 0.880 0.1 0.035];
  legendPosition2 = [0.77 0.825 0.1 0.035];
  legendPosition3 = [0.77 0.685 0.1 0.035];
  legendPosition5 = [0.74 0.390 0.1 0.035];
  legendPosition6 = [0.74 0.250 0.1 0.035];
elseif rec == 11
  legendPosition1 = [0.80 0.880 0.1 0.035];
  legendPosition2 = [0.80 0.825 0.1 0.035];
  legendPosition3 = [0.80 0.685 0.1 0.035];
  legendPosition5 = [0.77 0.390 0.1 0.035];
  legendPosition6 = [0.77 0.250 0.1 0.035];
elseif rec == 12
  legendPosition1 = [0.85 0.880 0.1 0.035];
  legendPosition2 = [0.85 0.825 0.1 0.035];
  legendPosition3 = [0.85 0.685 0.1 0.035];
  legendPosition5 = [0.82 0.390 0.1 0.035];
  legendPosition6 = [0.82 0.250 0.1 0.035];
elseif rec == 13
  legendPosition1 = [0.81 0.880 0.1 0.035];
  legendPosition2 = [0.81 0.825 0.1 0.035];
  legendPosition3 = [0.81 0.685 0.1 0.035];
  legendPosition5 = [0.78 0.390 0.1 0.035];
  legendPosition6 = [0.78 0.250 0.1 0.035];
elseif rec == 14
  legendPosition1 = [0.74 0.880 0.1 0.035];
  legendPosition2 = [0.74 0.825 0.1 0.035];
  legendPosition3 = [0.74 0.685 0.1 0.035];
  legendPosition5 = [0.72 0.390 0.1 0.035];
  legendPosition6 = [0.72 0.160 0.1 0.035];
end



%% Set appropriate y-axis scales for diffefrent recordings
if rec == 1
  yLim = [-70.0  000  050  000  10.0  300  00.0
          -67.0  250  300  100  20.0  390  10.0];
elseif rec == 2
  yLim = [-65.0  000  050  010  10.0  330  00.0
          -56.0  150  200  076  16.0  470  10.0];
elseif rec == 3
  yLim = [-65.0  000  050  010  07.0  455  00.0
          -58.0  150  200  081  14.0  580  10.0];
elseif rec == 4
  yLim = [-61.0  000  050  010  09.0  295  00.0
          -54.0  200  200  047  12.0  350  10.0];
elseif rec == 5
  yLim = [-63.0  000  050  010  08.5  320  00.0
          -61.0  180  200  050  11.4  400  10.0];
elseif rec == 6
  yLim = [-66.0  000  050  010  08.0  255  00.0
          -57.5  200  200  090  11.0  350  10.0];
elseif rec == 7
  yLim = [-72.0  000  050  010  08.5  210  00.0
          -69.0  300  250  070  13.0  320  10.0];
elseif rec == 8
  yLim = [-63.5  000  050  010  08.0  170  00.0
          -54.0  300  270  050  10.5  210  10.1];
elseif rec == 9
  yLim = [-70.0  000  050  008  04.0  190  00.0
          -63.7  250  230  031  09.5  395  10.0];
elseif rec == 10
  yLim = [-73.0  000  050  010  05.5  120  00.0
          -65.5  300  280  045  09.5  200  10.0];
elseif rec == 11
  yLim = [-72.0  000  050  010  04.0  295  00.0
          -65.5  300  210  082  13.0  440  10.0];
elseif rec == 12
  yLim = [-74.0  000  050  020  08.2  185  00.0
          -66.0  200  150  080  16.0  255  10.0];
elseif rec == 13
  yLim = [-77.0  000  050  017  10.0  125  00.0
          -69.0  500  300  082  17.0  200  10.0];
elseif rec == 14
  yLim = [-74.0  000  050  020  11.0  130  00.0
          -66.0  300  250  085  19.0  210  10.0];
end



%% Set file ranges
if rec == 1
  sweeps = [260 435; 437 474; 486 511; 513 661; 663 880; 990 1040] - 20;
  targetSweeps = [830 880] - 20;
  noiseSweeps = [990 1040] - 20;
elseif rec == 2
  sweeps = [340 455; 457 475; 477 530; 720 730] - 20;
  targetSweeps = [430 440] - 20;
  noiseSweeps = [720 730] - 20;
elseif rec == 3
  sweeps = [201 201; 205 205; 217 222; 225 235; 251 255] - 200;
  targetSweeps = [221 222; 225 226; 231 231] - 200;
  noiseSweeps = [251 255] - 200;
elseif rec == 4
  sweeps = [135 143; 145 151; 153 167; 191 195] - 120;
  targetSweeps = [156 160] - 120;
  noiseSweeps = [191 195] - 120;
elseif rec == 5
  sweeps = [151 196; 211 215] - 160;
  targetSweeps = [186 190] - 160;
  noiseSweeps = [211 215] - 160;
elseif rec == 6
  sweeps = [241 252; 254 256; 259 261; 264 265; 268 277; 279 286; 311 314; 316 316] - 240;
  targetSweeps = [275 277; 279 280] - 240;
  noiseSweeps = [311 314; 316 316] - 240;
elseif rec == 7
  sweeps = [211 228; 232 256; 297 301] - 210;
  targetSweeps = [246 250] - 210;
  noiseSweeps = [297 301] - 210;
elseif rec == 8
  sweeps = [151 185; 201 205] - 150;
  targetSweeps = [176 180] - 150;
  noiseSweeps = [201 205] - 150;
elseif rec == 9
  sweeps = [153 155; 157 161; 163 164; 166 168; 172 177; 180 182; 184 189; 191 193; 227 230; 232 232] - 150;
  targetSweeps = [185 189] - 150;
  noiseSweeps = [227 230; 232 232] - 150;
elseif rec == 10
  sweeps = [161 175; 181 198; 231 235] - 160;
  targetSweeps = [186 190] - 160;
  noiseSweeps = [231 235] - 160;
elseif rec == 11
  sweeps = [111 112; 123 129; 132 134; 139 144; 146 154; 260 265] - 110;
  targetSweeps = [146 150] - 110;
  noiseSweeps = [260 265] - 110;
elseif rec == 12
  sweeps = [130 156; 171 175] - 110;
  targetSweeps = [146 150] - 110;
  noiseSweeps = [171 175] - 110;
elseif rec == 13
  sweeps = [1 15; 17 21; 24 24; 26 28; 30 31; 57 58; 65 65; 70 71];
  targetSweeps = [21 21; 24 24; 26 28];
  noiseSweeps = [57 58; 65 65; 70 71];
elseif rec == 14
  sweeps = [91 130; 161 165] - 90;
  targetSweeps = [116 120] - 90;
  noiseSweeps = [161 165] - 90;
end



%% Load the data:
[dataFilename, dataPathname, filterIndex] = uigetfile({'*.mat','MAT files (*.mat)'}, 'Provide data file for figure retrieval', path);
if filterIndex
  dataFilename = fullfile(dataPathname, dataFilename);
  path = dataPathname;
  load(dataFilename);
  if ~exist('tHalfF', 'var')
    uiwait(msgbox('The supplied data file is corrupt. Please provide another file.','modal'));
    return
  end
  if rec == 10
    minisInfuse = minisInfuse - 100; %#ok<*NASGU>
  elseif rec == 13
    minisInfuse = minisInfuse - 100;
  end



  %% Plot the data:
  % Create an empty multipanelled figure
  fT = figure; tiledlayout(7,1, 'Padding','none', 'TileSpacing','tight')
  set(fT, 'Color', [1, 1, 1]);



  % Plot the average and median amplitude value of the top 10% of detected events:
  pane = 3;
  ax = nexttile(pane);
  p1 = plot(tSweep,medianAmp10'.*1000, 'LineStyle',':', 'LineWidth',1.5, 'Color','r'); hold on
  ylabel('Amp (\muV)', 'FontWeight','bold');

  p2 = plot(tSweep,averageAmp10'.*1000, 'LineStyle',':', 'LineWidth',1.5, 'Color','g');
  
  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end

  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');
  legend([p1 p2],'Median','Mean', 'Position',legendPosition3);
  legend('boxoff');



  % Plot tau_m:
  pane = 4;
  ax = nexttile(pane);
  plot(tHalfF,tau_m, 'Color','g', 'LineStyle',':', 'Marker','o', 'MarkerSize',markerSize, ...
    'MarkerEdgeColor','g', 'MarkerFaceColor','g'); hold on
  ylabel('\tau_{PSP} (ms)', 'FontWeight','bold');

  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end

  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');



  % Plot SD (15ms window):
  pane = 2;
  ax = nexttile(pane);
  p1 = plot(0.001*tSTD15, STD15.*1000, 'Color','g'); hold on
  ylabel('SD (\muV)', 'FontWeight','bold');

  %p2 = plot(0.001*tSTD15,STDsmooth15.*1000, 'Color','g');

  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end
  
  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');
  %legend([p1 p2],'Raw','Smoothed', 'Position',legendPosition2);
  %legend('boxoff');



  % Plot the baseline:
  pane = 1;
  ax = nexttile(pane);
  p1 = plot(0.001*tSTD100, mean100, 'Color','g'); hold on
  ylabel('V_m (mV)', 'FontWeight','bold');

  %p2 = plot(0.001*tSTD100,meanSmooth100, 'Color','g');
  
  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end
  
  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');
  %legend([p1 p2],'Raw','Smoothed', 'Position',legendPosition1);
  %legend('boxoff');



  % Plot pulse-based tau_m:
  pane = 5;
  ax = nexttile(pane);
  p1 = plot(tHalfF,tauPulseEff, 'Color','r', 'LineStyle',':', 'Marker','o', 'MarkerSize',markerSize, ...
    'MarkerEdgeColor','r', 'MarkerFaceColor','r'); hold on
  ylabel('\tau (ms)', 'FontWeight','bold');

  p2 = plot(tHalfF,tauPulse, 'Color','g', 'LineStyle',':', 'Marker','o', 'MarkerSize',markerSize, ...
    'MarkerEdgeColor','g', 'MarkerFaceColor','g');
  
  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end
  
  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');
  legend([p1 p2],'Exponential fit','Effective decay', 'Position',legendPosition5);
  legend('boxoff');



  % Plot capacitance:
  pane = 6;
  ax = nexttile(pane);
  p1 = plot(tHalfF,capacitanceEff, 'Color','r', 'LineStyle',':', 'Marker','o', 'MarkerSize',markerSize, ...
    'MarkerEdgeColor','r', 'MarkerFaceColor','r'); hold on
  ylabel('C (pF)', 'FontWeight','bold');

  p2 = plot(tHalfF,capacitance, 'Color','g', 'LineStyle',':', 'Marker','o', 'MarkerSize',markerSize, ...
    'MarkerEdgeColor','g', 'MarkerFaceColor','g');
  
  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end
  
  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');
  legend([p1 p2],'Exponential fit','Effective decay', 'Position',legendPosition6);
  legend('boxoff');



  % Plot Pipette's series resistance:
  pane = 7;
  ax = nexttile(pane);
  p1 = plot(tHalfF,Rseries, 'Color','g', 'LineStyle',':', 'Marker','o', 'MarkerSize',markerSize, ...
    'MarkerEdgeColor','g', 'MarkerFaceColor','g'); hold on
  ylabel('R_{Ser} (M\Omega)', 'FontWeight','bold');

  xTimeMarks = [APinfuse APblock minisInfuse];
  nTimeMarks = length(xTimeMarks);
  for iMark = 1:nTimeMarks
    plot([xTimeMarks(iMark) xTimeMarks(iMark)],[yLim(1,pane) yLim(2,pane)], 'Color','r');
  end
  
  lowerMark = [yLim(1,pane) yLim(1,pane)];
  upperMark = [yLim(2,pane) yLim(2,pane)];
  for iSweep = 1:size(targetSweeps,1)
    fileRange = [tSweep(targetSweeps(iSweep,1)-1) tSweep(targetSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(sweeps,1)
    fileRange = [tSweep(max([1 sweeps(iSweep,1)-1])) tSweep(sweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, transparency);
    uistack(c,'bottom')
  end
  for iSweep = 1:size(noiseSweeps,1)
    fileRange = [tSweep(noiseSweeps(iSweep,1)-1) tSweep(noiseSweeps(iSweep,2))];
    c = ciplot(lowerMark, upperMark, fileRange, sweepColour, tTransparency);
    uistack(c,'bottom')
  end
  hold off

  ylim([yLim(1,pane) yLim(2,pane)]);
  set(gca, 'XColor', 'none');
  box(ax, 'off');



  % Adjust the size of the figure
  set(fT, 'Position',[488 49.8 732.8/1.3 732.8]);



  % Save the figure
  figName = ['preprocessingFigures_' recIDs{rec}];
  if ~exist(figFolder, 'dir')
    mkdir(figFolder);
  end
  figName = strrep(figName, ' ', '_');
  figName = strrep(figName, '(', '_');
  figName = strrep(figName, ')', '_');
  figName = strrep(figName, '/', '_');
  figName = strrep(figName, '.', '_');
  figName = fullfile(figFolder, figName);
  savefig(fT, figName,'compact');
  exportgraphics(fT,[figName, '.png'], 'Resolution',900);
  exportgraphics(fT,[figName, '.pdf'], 'ContentType','vector');
  %saveas(fT, figName, 'png');
  %saveas(fT, figName, 'pdf');
  close(fT);
end