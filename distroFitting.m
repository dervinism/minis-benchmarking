%% User input/parameters
params
cd(fileparts(mfilename('fullpath')));
dataFolder = fullfile(dataRepo, recFolder);
dataFolderReal = fullfile(dataRepo, recFolder);
fitFolder = 'C:\Users\44079\PhD\Paper4\Fits\best_fits';
figFolder = 'C:\Users\44079\code_repositories\minis-benchmarking\fitFigures';
recIDs = {'p103a','p106b','p108a','p108b','p108c','p120b','p122a','p124b', ...
  'p125a','p127c','p128c','p129a','p131a','p131c'};
capacitance = [335 430 535 343 379 302 263 228 258 167 358 246 197 205]; % pF
invCapacitance = 1000./capacitance;
L5 = logical([1 1 1 1 1 0 0 1 0 0 0 1 0 0]); % cells in L5
nRecs = numel(recIDs);

% Excluded times and excluded time durations per sweep
excludedSweepTimes = {[0.00 1.10; 1.65 2.20];  % p103a
                      [0.25 0.90; 1.60 2.20];  % p106b
                      [0.50 1.15; 1.85 2.40];  % p108a
                      [0.50 1.25; 1.85 2.40];  % p108b
                      [0.50 1.20; 1.85 2.40];  % p108c
                      [0.50 1.20; 1.85 2.40];  % p120b
                      [0.00 1.25; 1.85 2.40];  % p122a
                      [0.00 1.15; 1.85 2.40];  % p124b
                      [0.00 1.20; 1.85 2.40];  % p125a
                      [0.00 1.20; 1.85 2.40];  % p127c
                      [0.50 1.20; 1.85 2.40];  % p128c
                      [0.00 1.20; 1.85 2.40];  % p129a
                      [0.00 2.25; 2.85 3.40];  % p131a
                      [0.00 1.00; 2.90 3.40]}; % p131c
excludedTimeDurations = zeros(1, numel(excludedSweepTimes));
for iRec = 1:numel(excludedSweepTimes)
  excludedTimeDurations(iRec) = (excludedSweepTimes{iRec}(1,2) - excludedSweepTimes{iRec}(1,1)) + (excludedSweepTimes{iRec}(2,2) - excludedSweepTimes{iRec}(2,1));
end

% End times of simulated files for each recording
endTimes = [200 40 repmat(100, 1, 12)];

% Number of sweeps per simulated file for each recording
nSweeps = [50 10 repmat(5, 1, 12)];

% Simulated file durations after accounting for excluded times
durations = [endTimes(1)-nSweeps(1)*excludedTimeDurations(1)       % p103a
             endTimes(2)-nSweeps(2)*excludedTimeDurations(2)       % p106b
             endTimes(3)-nSweeps(3)*excludedTimeDurations(3)       % p108a
             endTimes(4)-nSweeps(4)*excludedTimeDurations(4)       % p108b
             endTimes(5)-nSweeps(5)*excludedTimeDurations(5)       % p108c
             endTimes(6)-nSweeps(6)*excludedTimeDurations(6)       % p120b
             endTimes(7)-nSweeps(7)*excludedTimeDurations(7)       % p122a
             endTimes(8)-nSweeps(8)*excludedTimeDurations(8)       % p124b
             endTimes(9)-nSweeps(9)*excludedTimeDurations(9)       % p125a
             endTimes(10)-nSweeps(10)*excludedTimeDurations(10)    % p127c
             endTimes(11)-nSweeps(11)*excludedTimeDurations(11)    % p128c
             endTimes(12)-nSweeps(12)*excludedTimeDurations(12)    % p129a
             endTimes(13)-nSweeps(13)*excludedTimeDurations(13)    % p131a
             endTimes(14)-nSweeps(14)*excludedTimeDurations(14)]'; % p131c

% Number of sweeps per real files for each recording
nSweepsReal = {[repmat(10, 1, 17) 9 10 10 10 4 5 10 10 9 repmat(10, 1, 14) 9 repmat(10, 1, 6) 50 50 50]; % p103a
               [repmat(10, 1, 11) 9 repmat(10, 1, 5)];                                                   % p106b
               [2 4 4 5];                                                                                % p108a
               [6 9 4 5 7];                                                                              % p108b
               [repmat(5, 1, 6) 6];                                                                      % p108c
               [5 5 7 6 4 5 6];                                                                          % p120b
               [10 8 9 5 5 6];                                                                           % p122a
               repmat(5, 1, 7);                                                                          % p124b
               [7 6 7 2 5 3];                                                                            % p125a
               [10 5 5 5 8];                                                                             % p127c
               [2 7 5 4 5 4];                                                                            % p128c
               [10 5 5 6];                                                                               % p129a
               [10 9 5 1 1];                                                                             % p131a
               repmat(5, 1, 8)};                                                                         % p131c

% Simulated sweep durations for each recording
sweepDurations = [4     % p103a
                  4     % p106b
                  20    % p108a
                  20    % p108b
                  20    % p108c
                  20    % p120b
                  20    % p122a
                  20    % p124b
                  20    % p125a
                  20    % p127c
                  20    % p128c
                  20    % p129a
                  20    % p131a
                  20]'; % p131c

% Incidence rates
externalIncidenceRates = [4.1 6.35 4.592 7.96 1.6 1 1.43 2.965 6.25 3.11 3.1 2 2.5];


%% Get the means of fitted distributions
meanFittedAmplitudes = zeros(1,nRecs);
meanFittedRTs = zeros(1,nRecs);
fittedIncidenceRates = zeros(1,nRecs);
for iRec = 1:nRecs
  recFolder = fullfile(fitFolder, recIDs{iRec});
  simFile = dir(fullfile(recFolder, 'fit*.mat'));
  simFile = fullfile(recFolder, simFile.name);
  fitData = load(simFile);
  meanFittedAmplitudes(iRec) = mean(fitData.shapes(:,2));
  meanFittedRTs(iRec) = mean(fitData.shapes(:,3));
  fittedIncidenceRates(iRec) = size(fitData.shapes,1)/durations(iRec);
end 

% % Draw capacitance vs fitted amplitude correlation
% fTitle = 'Fitted amplitudes vs capacitance';
% xLabel = 'Capacitance (pF)';
% yLabel = 'Mean fitted amplitude (\muV)';
% invCapacitanceVamp(capacitance, meanFittedAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, false);
% 
% % Draw 1/capacitance vs fitted amplitude correlation
% fTitle = 'Fitted amplitudes vs 1/capacitance';
% xLabel = '1/capacitance (1/nF)';
% yLabel = 'Mean fitted amplitude (\muV)';
% invCapacitanceVamp(invCapacitance, meanFittedAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, true);
% %qqplot(invCapacitance);
% %qqplot(meanFittedAmplitudes.*1000);
[L23mean, L23CI] = datamean(meanFittedAmplitudes(~L5)');    % Keep this at all times
[L5mean, L5CI] = datamean(meanFittedAmplitudes(L5)');       % Keep this at all times
[overallMean, overallCI] = datamean(meanFittedAmplitudes'); % Keep this at all times
% disp(['L2/3 ' num2str(L23mean) ' -/+ ' num2str(L23CI(2))]);
% disp(['L5 ' num2str(L5mean) ' -/+ ' num2str(L5CI(2))]);
% disp(['Cx ' num2str(overallMean) ' -/+ ' num2str(overallCI(2))]);
% 
% % Draw 1/capacitance vs 10-90% rise time correlation
% fTitle = 'Fitted 10-90% rise times vs 1/capacitance';
% xLabel = '1/capacitance (1/nF)';
% yLabel = 'Mean 10-90% rise time (ms)';
% invCapacitanceVamp(invCapacitance, meanFittedRTs, L5, ...
%   fTitle, xLabel, yLabel, figFolder, false);
% %qqplot(meanFittedRTs);
% 
% % Draw 1/capacitance vs incidence rate correlation
% fTitle = 'Fitted incidence rates vs 1/capacitance';
% xLabel = '1/capacitance (1/nF)';
% yLabel = 'Incidence rate (minis/s)';
% invCapacitanceVamp(invCapacitance, fittedIncidenceRates, L5, ...
%   fTitle, xLabel, yLabel, figFolder, false);


%% Get the means of real distributions + incidence rates
ampBinSize = 0.01;                                  % Keep this at all times
rtBinSize = 0.5;                                    % Keep this at all times
ampEdges = 0:ampBinSize:5;                          % Keep this at all times
rtEdges = 0:rtBinSize:11;                           % Keep this at all times
ampBins = (ampBinSize:ampBinSize:5) - ampBinSize/2; % Keep this at all times
rtBins = (rtBinSize:rtBinSize:11) - rtBinSize/2;    % Keep this at all times
targetDistributions = zeros(nRecs,numel(ampBins),numel(rtBins));
noiseDistributions = zeros(nRecs,numel(ampBins),numel(rtBins));
subtractedDistributions = zeros(nRecs,numel(ampBins));
meanRealAmplitudes = zeros(1,nRecs);
meanThrAmplitudes = zeros(1,nRecs);
meanMixedAmplitudes = zeros(1,nRecs);
subtractedIncidenceRates = zeros(1,nRecs);
thrIncidenceRates = zeros(1,nRecs);
for iRec = 1:nRecs
  recFolder = fullfile(fitFolder, recIDs{iRec});
  targetFile = fullfile(recFolder, 'target.txt');
  noiseFile = fullfile(recFolder, 'noise.txt');
  targetTable = readtable(targetFile);
  targetDistributions(iRec,:,:) = histcounts2( ...
    targetTable.Amplitude, targetTable.x10_90_RT, ampEdges, rtEdges);
  targetAmplitudeCounts = hist(targetTable.Amplitude, ampBins); %#ok<*HIST> 
  noiseTable = readtable(noiseFile);
  noiseDistributions(iRec,:,:) = histcounts2( ...
    noiseTable.Amplitude, noiseTable.x10_90_RT, ampEdges, rtEdges);
  noiseAmplitudeCounts = hist(noiseTable.Amplitude, ampBins);
  subtractedAmplitudeCounts = targetAmplitudeCounts - noiseAmplitudeCounts;
  subtractedAmplitudeCounts(subtractedAmplitudeCounts < 0) = 0;
  %figure; plot(ampBins, subtractedAmplitudeCounts); hold on
  %plot(ampBins, targetAmplitudeCounts);
  %plot(ampBins, noiseAmplitudeCounts); hold off
  %legend('subtracted','target','noise')
  subtractedDistributions(iRec,:) = subtractedAmplitudeCounts;
  meanRealAmplitudes(iRec) = sum(subtractedAmplitudeCounts.*ampBins)/sum(subtractedAmplitudeCounts);
  meanThrAmplitudes(iRec) = mean(targetTable.Amplitude(targetTable.Amplitude >= 0.08));
  meanMixedAmplitudes(iRec) = mean(targetTable.Amplitude);
  subtractedIncidenceRates(iRec) = sum(subtractedAmplitudeCounts)/durations(iRec);
  thrIncidenceRates(iRec) = sum(targetTable.Amplitude >= 0.08)/durations(iRec);
end

% % Draw 1/capacitance vs mixed real minis + noise amplitude correlation
% fTitle = 'Thresholded amplitudes vs 1/capacitance';
% xLabel = '1/capacitance (1/nF)';
% yLabel = 'Mean thresholded amplitude (\muV)';
% invCapacitanceVamp(invCapacitance, meanThrAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, true);
% 
% % Draw 1/capacitance vs subtracted real amplitude correlation
% fTitle = 'Subtracted amplitudes vs 1/capacitance';
% xLabel = '1/capacitance (1/nF)';
% yLabel = 'Mean subtracted amplitude (\muV)';
% invCapacitanceVamp(invCapacitance, meanRealAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, true);
% %qqplot(meanRealAmplitudes.*1000);
% 
% % Draw fitted amplitude vs thresholded amplitude correlation
% fTitle = 'Fitted vs thresholded amplitudes';
% xLabel = 'Mean thresholded amplitude (\muV)';
% yLabel = 'Mean fitted amplitude (\muV)';
% invCapacitanceVamp(meanThrAmplitudes.*1000, meanFittedAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, false);
% 
% % Draw fitted amplitude vs subtracted real amplitude correlation
% fTitle = 'Fitted vs subtracted amplitudes';
% xLabel = 'Mean subtracted amplitude (\muV)';
% yLabel = 'Mean fitted amplitude (\muV)';
% invCapacitanceVamp(meanRealAmplitudes.*1000, meanFittedAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, false);
% 
% % Draw subtracted amplitude vs thresholded amplitude correlation
% fTitle = 'Subtracted vs thresholded amplitudes';
% xLabel = 'Mean thresholded amplitude (\muV)';
% yLabel = 'Mean subtracted amplitude (\muV)';
% invCapacitanceVamp(meanThrAmplitudes.*1000, meanRealAmplitudes.*1000, L5, ...
%   fTitle, xLabel, yLabel, figFolder, false);


%% Incidence rates
[meanRates, meanRateCIs] = datamean([thrIncidenceRates; subtractedIncidenceRates; fittedIncidenceRates]');
meanRateCIs = meanRates + meanRateCIs;
fH = figure; plot([1 1; 3 3], [min(externalIncidenceRates) max(externalIncidenceRates); ...
                               min(externalIncidenceRates) max(externalIncidenceRates)], ...
                               'r:', 'LineWidth',1.25);
hold on; plot([thrIncidenceRates; subtractedIncidenceRates; fittedIncidenceRates], ...
  'Color',[0.7 0.7 0.7]);
plot(meanRates, 'k.', 'MarkerSize',10);
plot([1 2 3; 1 2 3], meanRateCIs, 'k-', 'LineWidth',1.25);
xlim([0.9 3.1]);
%figure; qqplot(thrIncidenceRates);
%figure; qqplot(subtractedIncidenceRates);
%figure; qqplot(fittedIncidenceRates);

% Label the figure and axes
fontSize = 18;
fTitle = 'Minis'' incidence rates';
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
ylabel('Incidence rate (minis/s)', 'FontSize',fontSize, 'FontWeight','bold')

% Tidy the figure
set(fH, 'Color', 'white');
ax = gca;
set(ax, 'box', 'off');
set(ax, 'TickDir', 'out');
set(ax, 'XTick', 1:3);
set(ax, 'XTickLabel', {'Thresholded','Subtracted','Fitted'});
yTicks = get(ax, 'YTick');
if numel(yTicks) > 8
  set(ax, 'YTick', yTicks(1:2:end));
end
ax.FontSize = fontSize - 4;
set(get(ax, 'XAxis'), 'FontWeight', 'bold');
set(get(ax, 'YAxis'), 'FontWeight', 'bold');
set(ax,'linewidth',2);

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

% stats
[~, pval, ~, stats] = ttest(thrIncidenceRates, subtractedIncidenceRates);
disp(['Thresholded vs subtracted incidence rates: p=' num2str(pval), ' t=' num2str(stats.tstat)]);
[~, pval, ~, stats] = ttest(subtractedIncidenceRates, fittedIncidenceRates);
disp(['Subtracted vs fitted incidence rates: p=' num2str(pval), ' t=' num2str(stats.tstat)]);
[~, pval, ~, stats] = ttest(thrIncidenceRates, fittedIncidenceRates);
disp(['Thresholded vs fitted incidence rates: p=' num2str(pval), ' t=' num2str(stats.tstat)]);


% %% Draw individual 2D (amplitudes vs rise times) minis distributions
% for iRec = 8 %1:nRecs
%   fontSize = 15.5;
%   recFolder = fullfile(fitFolder, recIDs{iRec});
%   simFile = dir(fullfile(recFolder, 'fit*.mat'));
%   simFile = fullfile(recFolder, simFile.name);
%   fitData = load(simFile);
%   fH = figure; histogram2(fitData.shapes(:,2), fitData.shapes(:,3), ...
%     ampEdges, rtEdges, 'FaceColor','flat');
%   xlim([0 0.5])
%   ylim([0 10])
% 
%   % Label the figure and axes
%   fTitle = ['Minis distribution for recording ' recIDs{iRec}];
%   title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
%   xlabel('Amplitude (mV)', 'FontSize',fontSize, 'FontWeight','bold')
%   ylabel('10-90% rise time (ms)', 'FontSize',fontSize, 'FontWeight','bold')
%   zlabel('Count', 'FontSize',fontSize, 'FontWeight','bold')
% 
%   % Tidy the figure
%   set(fH, 'Color', 'white');
%   ax = gca;
%   set(ax, 'box', 'off');
%   set(ax, 'TickDir', 'out');
%   yTicks = get(ax, 'YTick');
%   if numel(yTicks) > 8
%     set(ax, 'YTick', yTicks(1:2:end));
%   end
%   ax.FontSize = fontSize - 2;
%   set(get(ax, 'XAxis'), 'FontWeight', 'bold');
%   set(get(ax, 'YAxis'), 'FontWeight', 'bold');
%   set(get(ax, 'ZAxis'), 'FontWeight', 'bold');
%   set(ax,'linewidth',1.5);
% 
%   % Save the figure
%   if ~exist(figFolder, 'dir')
%     mkdir(figFolder);
%   end
%   figName = strrep(fTitle, ' ', '_');
%   figName = strrep(figName, '(', '_');
%   figName = strrep(figName, ')', '_');
%   figName = strrep(figName, '/', '_');
%   figName = strrep(figName, '.', '_');
%   figName = fullfile(figFolder, figName);
%   savefig(fH, figName,'compact'); % Stop here
%   %title('');
%   saveas(fH, figName, 'png');
%   saveas(fH, figName, 'pdf');
% 
%   % Rotate and save the figure again
%   view(37.5, 30);
%   figName = [figName '_rotated']; %#ok<*AGROW>
%   savefig(fH, figName,'compact');
%   saveas(fH, figName, 'png');
%   saveas(fH, figName, 'pdf');
%   close(fH);
% 
%   % Create the multipanelled figure
%   fT = figure; tiledlayout(2,2, 'Padding','tight', 'TileSpacing','compact')
%   set(fT, 'Position',[100 0 952 952]);
%   set(fT, 'Color', [1, 1, 1]);
% 
%   % 2D with default view
%   ax1 = nexttile(1);
%   histogram2(fitData.shapes(:,2).*1000, fitData.shapes(:,3), ...
%     ampEdges.*1000, rtEdges, 'FaceColor','flat');
%   xlim([0 400])
%   ylim([0 10])
% 
%   xlh = xlabel('Amplitude (\muV)', 'FontSize',fontSize-1, 'FontWeight','bold');
%   xLabelPos = xlh.Position;
%   set(xlh, 'Rotation',21, 'Position',[xLabelPos(1) -0.6 xLabelPos(3)]);
%   ylh = ylabel('10-90% rise time (ms)', 'FontSize',fontSize-1, 'FontWeight','bold');
%   yLabelPos = ylh.Position;
%   set(ylh, 'Rotation',-34, 'VerticalAlignment','middle', ...
%     'HorizontalAlignment','right', 'Position',[0 3 yLabelPos(3)]);
%   zlabel('Count', 'FontSize',fontSize, 'FontWeight','bold')
% 
%   set(ax1, 'box', 'off');
%   set(ax1, 'TickDir', 'out');
%   yTicks = get(ax1, 'YTick');
%   if numel(yTicks) > 8
%     set(ax1, 'YTick', yTicks(1:2:end));
%   end
%   ax1.FontSize = fontSize - 2;
%   set(get(ax1, 'XAxis'), 'FontWeight', 'bold');
%   set(get(ax1, 'YAxis'), 'FontWeight', 'bold');
%   set(get(ax1, 'ZAxis'), 'FontWeight', 'bold');
%   set(ax1,'linewidth',1.5);
% 
%   xLim = xlim;
%   xAxisSize = xLim(2) - xLim(1);
%   yLim = ylim;
%   yAxisSize = yLim(2) - yLim(1);
%   zLim = zlim;
%   zAxisSize = zLim(2) - zLim(1);
%   if iRec == 1
%     text(0*xAxisSize, 1.5*yAxisSize, 1.06*zAxisSize, ...
%       'A', 'FontSize',26, 'FontWeight','bold');
%   else
%     text(0*xAxisSize, 1.39*yAxisSize, 1.115*zAxisSize, ...
%       'A', 'FontSize',26, 'FontWeight','bold');
%   end
% 
%   % 2D with view rotation
%   ax2 = nexttile(2);
%   histogram2(fitData.shapes(:,2).*1000, fitData.shapes(:,3), ...
%     ampEdges.*1000, rtEdges, 'FaceColor','flat');
%   xlim([0 400])
%   ylim([0 10])
%   view(37.5, 30);
% 
%   xlh = xlabel('Amplitude (\muV)', 'FontSize',fontSize-1, 'FontWeight','bold');
%   xLabelPos = xlh.Position;
%   set(xlh, 'Rotation',-20, 'Position',[xLabelPos(1) xLabelPos(2) xLabelPos(3)]);
%   ylh = ylabel('10-90% rise time (ms)', 'FontSize',fontSize-1, 'FontWeight','bold');
%   yLabelPos = ylh.Position;
%   set(ylh, 'Rotation',33, 'VerticalAlignment','middle', ...
%     'HorizontalAlignment','right', 'Position',[370 12.4 yLabelPos(3)]);
%   zlabel('Count', 'FontSize',fontSize, 'FontWeight','bold')
% 
%   set(ax2, 'box', 'off');
%   set(ax2, 'TickDir', 'out');
%   yTicks = get(ax2, 'YTick');
%   if numel(yTicks) > 8
%     set(ax2, 'YTick', yTicks(1:2:end));
%   end
%   ax2.FontSize = fontSize - 2;
%   set(get(ax2, 'XAxis'), 'FontWeight', 'bold');
%   set(get(ax2, 'YAxis'), 'FontWeight', 'bold');
%   set(get(ax2, 'ZAxis'), 'FontWeight', 'bold');
%   set(ax2,'linewidth',1.5);
% 
%   xLim = xlim;
%   xAxisSize = xLim(2) - xLim(1);
%   yLim = ylim;
%   yAxisSize = yLim(2) - yLim(1);
%   zLim = zlim;
%   zAxisSize = zLim(2) - zLim(1);
%   text(-0.3*xAxisSize, 0*yAxisSize, 1.29*zAxisSize, ...
%     'B', 'FontSize',26, 'FontWeight','bold');
% 
%   % Marginal amplitude distribution
%   fontSize = 18;
%   ax3 = nexttile(3);
%   xLim = [0 400];
%   xLabel = 'Amplitude (\muV)';
%   yLabel = 'Count';
%   ampHisto1D = histcounts(fitData.shapes(:,2).*1000, ampEdges.*1000);
%   bins = ampEdges(2:end)-ampBinSize/2;
%   ampBinsInterp = bins(1):ampBinSize/10:bins(end);
%   ampHisto1DInterp = interp1(bins.*1000, ampHisto1D, ampBinsInterp.*1000, 'linear');
%   smoothSpan = 5;
%   ampHisto1DInterp = smooth(ampHisto1DInterp, smoothSpan);
%   plot(ampBinsInterp.*1000, ampHisto1DInterp, 'b', 'LineWidth',1.25); hold off
%   xlim(xLim)
%   ylim([0 max(ampHisto1DInterp)+10])
% 
%   xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
%   ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
% 
%   set(ax3, 'box', 'off');
%   set(ax3, 'TickDir', 'out');
%   yTicks = get(ax3, 'YTick');
%   if numel(yTicks) > 8
%     set(ax3, 'YTick', yTicks(1:2:end));
%   end
%   ax3.FontSize = fontSize - 4;
%   set(get(ax3, 'XAxis'), 'FontWeight','bold');
%   set(get(ax3, 'YAxis'), 'FontWeight','bold');
%   set(ax3,'linewidth',1.5);
% 
%   xAxisSize = xLim(2) - xLim(1);
%   yLim = ylim;
%   yAxisSize = yLim(2) - yLim(1);
%   if yLim(2) < 100
%     text(-0.17*xAxisSize, yLim(2)-0.025*yAxisSize, 'C', 'FontSize',26, 'FontWeight','bold');
%   elseif yLim(2) < 1000
%     text(-0.19*xAxisSize, yLim(2)-0.025*yAxisSize, 'C', 'FontSize',26, 'FontWeight','bold');
%   else
%     text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'C', 'FontSize',26, 'FontWeight','bold');
%   end
% 
%   % Marginal rise time distribution
%   ax4 = nexttile(4);
%   xLim = [0 10];
%   xLabel = '10-90% rise time (ms)';
%   yLabel = 'Count';
%   rtHisto1D = histcounts(fitData.shapes(:,3), rtEdges);
%   bins = rtEdges(2:end)-rtBinSize/2;
%   rtBinsInterp = bins(1):rtBinSize/10:bins(end);
%   rtHisto1DInterp = interp1(bins, rtHisto1D, rtBinsInterp, 'linear');
%   smoothSpan = 5;
%   rtHisto1DInterp = smooth(rtHisto1DInterp, smoothSpan);
%   plot(rtBinsInterp, rtHisto1DInterp, 'b', 'LineWidth',1.25); hold off
%   xlim(xLim)
%   ylim([0 max(rtHisto1DInterp)+10])
% 
%   xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
%   ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
% 
%   set(ax4, 'box', 'off');
%   set(ax4, 'TickDir', 'out');
%   yTicks = get(ax4, 'YTick');
%   if numel(yTicks) > 8
%     set(ax4, 'YTick', yTicks(1:2:end));
%   end
%   ax4.FontSize = fontSize - 4;
%   set(get(ax4, 'XAxis'), 'FontWeight','bold');
%   set(get(ax4, 'YAxis'), 'FontWeight','bold');
%   set(ax4,'linewidth',1.5);
% 
%   xAxisSize = xLim(2) - xLim(1);
%   yLim = ylim;
%   yAxisSize = yLim(2) - yLim(1);
%   if yLim(2) < 1000
%     text(-0.19*xAxisSize, yLim(2)-0.025*yAxisSize, 'D', 'FontSize',26, 'FontWeight','bold');
%   else
%     text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'D', 'FontSize',26, 'FontWeight','bold');
%   end
% 
%   % Save the figure
%   figName = ['SourceDistros4pFigures_' recIDs{iRec}];
%   if ~exist(figFolder, 'dir')
%     mkdir(figFolder);
%   end
%   figName = strrep(figName, ' ', '_');
%   figName = strrep(figName, '(', '_');
%   figName = strrep(figName, ')', '_');
%   figName = strrep(figName, '/', '_');
%   figName = strrep(figName, '.', '_');
%   figName = fullfile(figFolder, figName);
%   savefig(fT, figName,'compact');
%   exportgraphics(fT,[figName, '.png'], 'Resolution',900);
%   exportgraphics(fT,[figName, '.pdf'], 'ContentType','vector');
%   close(fT);
% end
% 

%% Draw the generic minis' distribution
% Normalise distributions
fittedMinisDistros = zeros(nRecs,numel(ampBins),numel(rtBins));
normalisedAmplitudeScales = zeros(nRecs, numel(ampBins));
for iRec = 1:nRecs
  fittedMinisDistros(iRec,:,:) = histcounts2( ...
    fitData.shapes(:,2), fitData.shapes(:,3), ampEdges, rtEdges);
  normalisedAmplitudeScales(iRec,:) = ampBins./meanFittedAmplitudes(iRec);
end

% Interpolate and average minis' distributions
[~, maxAmpRecInd] = max(meanFittedAmplitudes);
genericDistro = zeros(numel(ampBins),numel(rtBins));
nEvents = 0;
for iRec = 1:nRecs
  ampRangeOI = normalisedAmplitudeScales(iRec,:) <= normalisedAmplitudeScales(maxAmpRecInd,end);
  [ampsGrid, rtGrid] = meshgrid(normalisedAmplitudeScales(iRec,ampRangeOI), rtBins);
  [ampsGridQ, rtGridQ] = meshgrid(normalisedAmplitudeScales(maxAmpRecInd,:), rtBins);
  distroOI = interp2(ampsGrid, rtGrid, ...
    squeeze(fittedMinisDistros(iRec,ampRangeOI,:))', ampsGridQ, rtGridQ, ...
    'linear',0)';
  genericDistro = genericDistro + distroOI./sum(sum(distroOI));
  nEvents = nEvents + sum(sum(distroOI));
end
genericDistro = (genericDistro./nRecs).*(nEvents/nRecs);
genericDistroMean = sum(sum(genericDistro,2)'.*normalisedAmplitudeScales(maxAmpRecInd,:))/sum(sum(genericDistro));
normalisedAmplitudeScales = ((normalisedAmplitudeScales(maxAmpRecInd,:)./genericDistroMean)).*(overallMean*1000);

% Draw distributions
normalisedAmpEdges = [0 normalisedAmplitudeScales + ...
  normalisedAmplitudeScales(1)/2];
fTitle = 'Generic minis distribution';
xLabel = 'Amplitude (\muV)';
yLabel = '10-90% rise time (ms)';
zLabel = 'Count';
plot2Dhisto(genericDistro, normalisedAmpEdges, rtEdges, [0 400], [0 10], ...
  fTitle, xLabel, yLabel, zLabel, figFolder);

ampDistro = sum(genericDistro,2);
fTitle = 'Generic minis amplitude distribution';
xLabel = 'Amplitude (\muV)';
yLabel = 'Count';
plot1Dhisto(ampDistro, normalisedAmplitudeScales, ...
  [0 400], fTitle, xLabel, yLabel, figFolder);

rtDistro = sum(genericDistro,1);
fTitle = 'Generic minis 10-90% rise time distribution';
xLabel = '10-90% rise time (ms)';
yLabel = 'Count';
plot1Dhisto(rtDistro, rtBins, [0 10], fTitle, xLabel, yLabel, figFolder);

% Draw smoothed distributions
xLabel = 'Amplitude (\muV)';
yLabel = '10-90% rise time (ms)';
zLabel = 'Count';
windowSize = 3;
smoothGenericDistro = smoothdata2(genericDistro./nRecs, 'gaussian', windowSize);
smoothGenericDistro = (smoothGenericDistro./max(max(smoothGenericDistro))).*max(max(genericDistro));
fTitle = 'Smoothed generic minis distribution';
plot2Dhisto(smoothGenericDistro, normalisedAmpEdges, rtEdges, [0 400], [0 10], ...
  fTitle, xLabel, yLabel, zLabel, figFolder);

ampDistro = sum(smoothGenericDistro,2);
fTitle = 'Smoothed generic minis amplitude distribution';
xLabel = 'Amplitude (\muV)';
yLabel = 'Count';
plot1Dhisto(ampDistro, normalisedAmplitudeScales, ...
  [0 400], fTitle, xLabel, yLabel, figFolder);

rtDistro = sum(smoothGenericDistro,1);
fTitle = 'Smoothed generic minis 10-90% rise time distribution';
xLabel = '10-90% rise time (ms)';
yLabel = 'Count';
plot1Dhisto(rtDistro, rtBins, [0 10], fTitle, xLabel, yLabel, figFolder);


% %% Display distribution fitting performance for individual recordings: No stats
% for iRec = 14 %1:nRecs
%   load(fullfile(fitFolder, recIDs{iRec}, 'settings.mat'));
% 
%   if iRec == 10
%     simFile1 = 'C:\Users\44079\Phd\Paper4\Fits\best_fits\p127c\fit_files\fit_006975_9309.mat';
%   elseif iRec == 13
%     simFile1 = 'C:\Users\44079\Phd\Paper4\Fits\best_fits\p131a\fit_files\fit_004489_8912.mat';
%   elseif iRec == 14
%     simFile1 = 'C:\Users\44079\Phd\Paper4\Fits\best_fits\p131c\fit_files\fit_004552_5461.mat';
%   end
%   fitData1 = load(simFile1);
% 
%   % Load simulated data
%   recFolder = fullfile(fitFolder, recIDs{iRec});
%   simFile2 = dir(fullfile(recFolder, 'fit*.mat'));
%   simFile2 = fullfile(recFolder, simFile2.name);
%   fitData2 = load(simFile2);
% 
%   % Detect minis in the simulated data
%   [~, excludedTimes] = initExclTimesTarget(settings);
%   waveform.estimate = 0;
%   filtering.state = 'spectrum';
%   filtering.excludedTimes = excludedTimes;
%   filtering.filtfs = {'50, 150'};
%   filtering.nSweeps = nSweeps(iRec);
%   sweepDuration = (length(fitData2.V)*fitData2.detectionParametersSim.sampleInterval ...
%     - fitData2.detectionParametersSim.sampleInterval)/nSweeps(iRec);
%   excludedTimes = calcExcludedTimes(sweepDuration, nSweeps(iRec), ...
%     1000*excludedTimes.startPulse, 1000*excludedTimes.endPulse, ...
%     1000*excludedTimes.startGlitch, 1000*excludedTimes.endGlitch, ...
%     fitData2.detectionParametersSim.sampleInterval);
%   eventArray2 = detectMinis(fitData2.V, excludedTimes, fitData2.detectionParametersSim, filtering, waveform, 8);
%   if exist('fitData1', 'var')
%     eventArray1 = detectMinis(fitData1.V, excludedTimes, fitData1.detectionParametersSim, filtering, waveform, 8);
%   end
% 
%   % Bin detected simulated events into a histogram
%   %simEventDistro = histcounts2(eventArray(:,4), eventArray(:,12), ampEdges, rtEdges);
%   %simEventAmpDistro = sum(simEventDistro,2);
%   %simEventRTDistro = sum(simEventDistro,1);
% 
%   % Bin detected real events into a histogram
%   distroFile = fullfile(fitFolder, recIDs{iRec}, 'intermediateErrorBounds');
%   intermediateErrorBounds = load(distroFile);
%   realEventAmpDistro = intermediateErrorBounds.fileAmps;
%   realEventRTDistro = intermediateErrorBounds.fileRTs;
%   for iFile = 1:numel(nSweepsReal{iRec})
%     realEventAmpDistro(iFile,:) = realEventAmpDistro(iFile,:) .* (nSweeps(iRec)./nSweepsReal{iRec}(iFile));
%     realEventRTDistro(iFile,:) = realEventRTDistro(iFile,:) .* (nSweeps(iRec)./nSweepsReal{iRec}(iFile));
%   end
% 
%   % Bin detected simulated events into a histogram
%   [simEventAmpDistro2, simEventRTDistro2, simEventDistro2] = classifyMinis( ...
%     eventArray2(:,4), eventArray2(:,12), intermediateErrorBounds.classificationParameters);
%   if exist('fitData1', 'var')
%     [simEventAmpDistro1, simEventRTDistro1, simEventDistro1] = classifyMinis( ...
%       eventArray1(:,4), eventArray1(:,12), intermediateErrorBounds.classificationParameters);
%   end
% 
%   % Work out real data distribution limits
%   lowerAmpLimit = min(realEventAmpDistro);
%   upperAmpLimit = max(realEventAmpDistro);
%   lowerRTLimit = min(realEventRTDistro);
%   upperRTLimit = max(realEventRTDistro);
% 
%   % Draw fitting error figures
%   fTitle = ['Amplitude distribution fit for recording ' recIDs{iRec}];
%   xLabel = 'Amplitude (\muV)';
%   yLabel = 'Count';
%   xLim = [0 0.4].*1000;
%   bins = intermediateErrorBounds.classificationParameters.amplitudeArrayExt(2:end)-ampBinSize/2;
%   ampBinsInterp = bins(1):ampBinSize/10:bins(end);
%   simEventAmpDistroInterp2 = interp1(bins, simEventAmpDistro2, ampBinsInterp, 'linear');
%   smoothSpan = 5;
%   simEventAmpDistroInterp2 = smooth(simEventAmpDistroInterp2, smoothSpan);
%   if exist('fitData1', 'var')
%     simEventAmpDistroInterp1 = interp1(bins, simEventAmpDistro1, ampBinsInterp, 'linear');
%     simEventAmpDistroInterp1 = smooth(simEventAmpDistroInterp1, smoothSpan);
%     simEventAmpDistroInterp = [simEventAmpDistroInterp1(:)'; simEventAmpDistroInterp2(:)'];
%   else
%     simEventAmpDistroInterp = simEventAmpDistroInterp2;
%   end
%   lowerAmpLimitInterp = interp1(bins, lowerAmpLimit, ampBinsInterp, 'linear');
%   lowerAmpLimitInterp = smooth(lowerAmpLimitInterp, smoothSpan);
%   upperAmpLimitInterp = interp1(bins, upperAmpLimit, ampBinsInterp, 'linear');
%   upperAmpLimitInterp = smooth(upperAmpLimitInterp, smoothSpan);
%   ciPlot1Dhisto(simEventAmpDistroInterp, ampBinsInterp.*1000, lowerAmpLimitInterp, ...
%     upperAmpLimitInterp, ampBinsInterp.*1000, xLim, fTitle, xLabel, yLabel, figFolder);
% 
%   fTitle = ['Rise time distribution fit for recording ' recIDs{iRec}];
%   xLabel = '10-90% rise time (ms)';
%   yLabel = 'Count';
%   xLim = [0 10];
%   bins = intermediateErrorBounds.classificationParameters.riseTimeArrayExt(2:end)-rtBinSize/2;
%   rtBinsInterp = bins(1):rtBinSize/10:bins(end);
%   simEventRTDistroInterp = interp1(bins, simEventRTDistro2, rtBinsInterp, 'linear');
%   smoothSpan = 5;
%   simEventRTDistroInterp = smooth(simEventRTDistroInterp, smoothSpan);
%   lowerRTLimitInterp = interp1(bins, lowerRTLimit, rtBinsInterp, 'linear');
%   lowerRTLimitInterp = smooth(lowerRTLimitInterp, smoothSpan);
%   upperRTLimitInterp = interp1(bins, upperRTLimit, rtBinsInterp, 'linear');
%   upperRTLimitInterp = smooth(upperRTLimitInterp, smoothSpan);
%   ciPlot1Dhisto(simEventRTDistroInterp, rtBinsInterp, lowerRTLimitInterp, ...
%     upperRTLimitInterp, rtBinsInterp, xLim, fTitle, xLabel, yLabel, figFolder);
% 
%   % Create the multipanelled figure
%   fT = figure; tiledlayout(1,2, 'Padding','none', 'TileSpacing','tight')
%   set(fT, 'Color', [1, 1, 1]);
% 
%   fontSize = 18;
% 
%   ax1 = nexttile(1);
%   xLim = [0 0.25];
%   xLabel = 'Amplitude (mV)';
%   CI = upperAmpLimitInterp - lowerAmpLimitInterp;
%   lowerAmpLimitInterp(lowerAmpLimitInterp < 0) = 0;
%   lowerAmpLimitInterp2 = lowerAmpLimitInterp - CI;
%   lowerAmpLimitInterp2(lowerAmpLimitInterp2 < 0) = 0;
%   upperAmpLimitInterp2 = upperAmpLimitInterp + CI;
%   ciplot(lowerAmpLimitInterp2, upperAmpLimitInterp2, ampBinsInterp, 'y', 0.4);
%   hold on; ciplot(lowerAmpLimitInterp, upperAmpLimitInterp, ampBinsInterp, 'g', 0.3);
%   plot(ampBinsInterp, simEventAmpDistroInterp2, 'b', 'LineWidth',1.25); hold off
%   xlim(xLim)
%   ylim([0 max([upperAmpLimitInterp2; simEventAmpDistroInterp2])+50])
% 
%   xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
%   ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
% 
%   set(ax1, 'box', 'off');
%   set(ax1, 'TickDir', 'out');
%   yTicks = get(ax1, 'YTick');
%   if numel(yTicks) > 8
%     set(ax1, 'YTick', yTicks(1:2:end));
%   end
%   ax1.FontSize = fontSize - 4;
%   set(get(ax1, 'XAxis'), 'FontWeight','bold');
%   set(get(ax1, 'YAxis'), 'FontWeight','bold');
%   set(ax1,'linewidth',1.5);
% 
%   xAxisSize = xLim(2) - xLim(1);
%   yLim = ylim;
%   yAxisSize = yLim(2) - yLim(1);
%   if yLim(2) < 1000
%     text(-0.19*xAxisSize, yLim(2)-0.025*yAxisSize, 'A', 'FontSize',26, 'FontWeight','bold');
%   else
%     text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'A', 'FontSize',26, 'FontWeight','bold');
%   end
% 
%   ax2 = nexttile(2);
%   xLim = [0 10];
%   xLabel = '10-90% rise time (ms)';
%   CI = upperRTLimitInterp - lowerRTLimitInterp;
%   lowerRTLimitInterp(lowerRTLimitInterp < 0) = 0;
%   lowerRTLimitInterp2 = lowerRTLimitInterp - CI;
%   lowerRTLimitInterp2(lowerRTLimitInterp2 < 0) = 0;
%   upperRTLimitInterp2 = upperRTLimitInterp + CI;
%   ciplot(lowerRTLimitInterp2, upperRTLimitInterp2, rtBinsInterp, 'y', 0.4);
%   hold on; ciplot(lowerRTLimitInterp, upperRTLimitInterp, rtBinsInterp, 'g', 0.3);
%   plot(rtBinsInterp, simEventRTDistroInterp, 'b', 'LineWidth',1.25); hold off
%   xlim(xLim)
%   ylim([0 max([upperRTLimitInterp2; simEventRTDistroInterp])+20])
% 
%   xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
%   ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
% 
%   set(ax2, 'box', 'off');
%   set(ax2, 'TickDir', 'out');
%   yTicks = get(ax2, 'YTick');
%   if numel(yTicks) > 8
%     set(ax2, 'YTick', yTicks(1:2:end));
%   end
%   ax2.FontSize = fontSize - 4;
%   set(get(ax2, 'XAxis'), 'FontWeight', 'bold');
%   set(get(ax2, 'YAxis'), 'FontWeight', 'bold');
%   set(ax2,'linewidth',1.5);
% 
%   xAxisSize = xLim(2) - xLim(1);
%   yLim = ylim;
%   yAxisSize = yLim(2) - yLim(1);
%   text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'B', 'FontSize',26, 'FontWeight','bold');
% 
%   % Adjust the size of the figure
%   set(fT, 'Position',[415 174 920 500]);
% 
%   % Save the figure
%   figName = ['DistroFittingFigures_' recIDs{iRec}];
%   if ~exist(figFolder, 'dir')
%     mkdir(figFolder);
%   end
%   figName = strrep(figName, ' ', '_');
%   figName = strrep(figName, '(', '_');
%   figName = strrep(figName, ')', '_');
%   figName = strrep(figName, '/', '_');
%   figName = strrep(figName, '.', '_');
%   figName = fullfile(figFolder, figName);
%   savefig(fT, figName,'compact');
%   exportgraphics(fT,[figName, '.png'], 'Resolution',900);
%   exportgraphics(fT,[figName, '.pdf'], 'ContentType','vector');
%   close(fT);
% end
% 
% 
% %% Display amplitude and rise time distributions of 'noise + minis' and 'noise-alone' files for a recording of choice
% % Bin detected real events into a histogram
% % Target files
% iRec = 4;
% realFile = 4;
% distroFile = fullfile(fitFolder, recIDs{iRec}, 'intermediateErrorBounds');
% intermediateErrorBounds = load(distroFile);
% realEventAmpDistro = intermediateErrorBounds.fileAmps;
% realEventRTDistro = intermediateErrorBounds.fileRTs;
% for iFile = 1:numel(nSweepsReal{iRec})
%   realEventAmpDistro(iFile,:) = realEventAmpDistro(iFile,:) .* (nSweeps(iRec)./nSweepsReal{iRec}(iFile));
%   realEventRTDistro(iFile,:) = realEventRTDistro(iFile,:) .* (nSweeps(iRec)./nSweepsReal{iRec}(iFile));
% end
% 
% % Noise files
% noiseFile = 2;
% distroFile = fullfile(fitFolder, recIDs{iRec}, 'detectedNoiseEvents.mat');
% detectedNoiseEvents = load(distroFile);
% noiseEventAmpDistro = detectedNoiseEvents.fileAmps;
% noiseEventRTDistro = detectedNoiseEvents.fileRTs;
% for iFile = 1:numel(detectedNoiseEvents.fileSweeps)
%   noiseEventAmpDistro(iFile,:) = noiseEventAmpDistro(iFile,:) .* (nSweeps(iRec)./detectedNoiseEvents.fileSweeps(iFile));
%   noiseEventRTDistro(iFile,:) = noiseEventRTDistro(iFile,:) .* (nSweeps(iRec)./detectedNoiseEvents.fileSweeps(iFile));
% end
% 
% % Draw distribution figures
% fTitle = ['Amplitude distributions for recording ' recIDs{iRec}];
% xLabel = 'Amplitude (\muV)';
% yLabel = 'Count';
% xLim = [0 250];
% bins = intermediateErrorBounds.classificationParameters.amplitudeArrayExt(2:end)-ampBinSize/2;
% binsInterp = bins(1):ampBinSize/10:bins(end);
% realEventAmpDistroInterp = interp1(bins, realEventAmpDistro(realFile,:), binsInterp, 'linear');
% noiseEventAmpDistroInterp = interp1(bins, noiseEventAmpDistro(noiseFile,:), binsInterp, 'linear');
% smoothSpan = 5;
% realEventAmpDistroInterp = smooth(realEventAmpDistroInterp, smoothSpan);
% noiseEventAmpDistroInterp = smooth(noiseEventAmpDistroInterp, smoothSpan);
% subtractedEvents = realEventAmpDistroInterp - noiseEventAmpDistroInterp;
% distributions = [realEventAmpDistroInterp'; noiseEventAmpDistroInterp'; subtractedEvents'];
% plot1Dhisto3(distributions, binsInterp*1000, xLim, fTitle, xLabel, yLabel, figFolder);
% 
% fTitle = ['Rise time distributions for recording ' recIDs{iRec}];
% xLabel = '10-90% rise time (ms)';
% yLabel = 'Count';
% xLim = [0 10];
% bins = intermediateErrorBounds.classificationParameters.riseTimeArrayExt(2:end)-rtBinSize/2;
% binsInterp = bins(1):rtBinSize/10:bins(end);
% realEventRTDistroInterp = interp1(bins, realEventRTDistro(realFile,:), binsInterp, 'linear');
% noiseEventRTDistroInterp = interp1(bins, noiseEventRTDistro(noiseFile,:), binsInterp, 'linear');
% smoothSpan = 5;
% realEventRTDistroInterp = smooth(realEventRTDistroInterp, smoothSpan);
% noiseEventRTDistroInterp = smooth(noiseEventRTDistroInterp, smoothSpan);
% subtractedEvents = realEventRTDistroInterp - noiseEventRTDistroInterp;
% distributions = [realEventRTDistroInterp'; noiseEventRTDistroInterp'; subtractedEvents'];
% plot1Dhisto3(distributions, binsInterp, xLim, fTitle, xLabel, yLabel, figFolder);
% 
% 
% %% Compare thresholded and non-thresholded fits for p127c recording
% % Load data
% iRec = 14;
% if iRec == 10
%   simFile1 = 'C:\Users\44079\Phd\Paper4\Fits\best_fits\p127c\fit_files\fit_006975_9309.mat';
% elseif iRec == 13
%   simFile1 = 'C:\Users\44079\Phd\Paper4\Fits\best_fits\p131a\fit_files\fit_004489_8912.mat';
% elseif iRec == 14
%   simFile1 = 'C:\Users\44079\Phd\Paper4\Fits\best_fits\p131c\fit_files\fit_004552_5461.mat';
% end
% fitData1 = load(simFile1);
% 
% recFolder = fullfile(fitFolder, recIDs{iRec});
% simFile2 = dir(fullfile(recFolder, 'fit*.mat'));
% simFile2 = fullfile(recFolder, simFile2.name);
% fitData2 = load(simFile2);
% 
% % Marginal amplitude distribution
% fH1 = figure;
% fontSize = 18;
% xLim = [0 400];
% xLabel = 'Amplitude (\muV)';
% yLabel = 'Count';
% 
% ampHisto1D = histcounts(fitData1.shapes(:,2).*1000, ampEdges.*1000);
% bins = ampEdges(2:end)-ampBinSize/2;
% ampBinsInterp = bins(1):ampBinSize/10:bins(end);
% ampHisto1DInterp = interp1(bins.*1000, ampHisto1D, ampBinsInterp.*1000, 'linear');
% smoothSpan = 5;
% ampHisto1DInterp = smooth(ampHisto1DInterp, smoothSpan);
% fitMean1 = mean(fitData1.shapes(:,2))*1000;
% [~, meanLoc] = min(abs(ampBinsInterp .*1000- fitMean1));
% plot(ampBinsInterp.*1000, ampHisto1DInterp, 'r', 'LineWidth',1.75); hold on
% plot([ampBinsInterp(meanLoc) ampBinsInterp(meanLoc)].*1000, [0 ampHisto1DInterp(meanLoc)], ...
%   'r:', 'LineWidth',1);
% 
% ampHisto1D_th = histcounts(fitData2.shapes(:,2).*1000, ampEdges.*1000);
% ampHisto1DInterp_th = interp1(bins.*1000, ampHisto1D_th, ampBinsInterp.*1000, 'linear');
% ampHisto1DInterp_th = smooth(ampHisto1DInterp_th, smoothSpan);
% fitMean2 = mean(fitData2.shapes(:,2))*1000;
% [~, meanLoc] = min(abs(ampBinsInterp .*1000- fitMean2));
% plot(ampBinsInterp.*1000, ampHisto1DInterp_th, 'b', 'LineWidth',1.75);
% plot([ampBinsInterp(meanLoc) ampBinsInterp(meanLoc)].*1000, [0 ampHisto1DInterp_th(meanLoc)], ...
%   'b:', 'LineWidth',1); hold off
% 
% xlim(xLim)
% ylim([0 max(ampHisto1DInterp)+10])
% 
% xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
% ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
% 
% legend('Minis distribution w/o sim. threshold', 'Mean amplitude', ...
%   'Minis distribution w/ sim. threshold', 'Mean amplitude');
% legend('boxoff');
% 
% % Tidy the figure
% set(fH1, 'Color', 'white');
% ax = gca;
% set(ax, 'box', 'off');
% set(ax, 'TickDir', 'out');
% yTicks = get(ax, 'YTick');
% if numel(yTicks) > 8
%   set(ax, 'YTick', yTicks(1:2:end));
% end
% ax.FontSize = fontSize - 4;
% set(get(ax, 'XAxis'), 'FontWeight','bold');
% set(get(ax, 'YAxis'), 'FontWeight','bold');
% set(ax,'linewidth',1.5);
% 
% % Save the figure
% figName = ['AmpThrEffect_' recIDs{iRec}];
% if ~exist(figFolder, 'dir')
%   mkdir(figFolder);
% end
% figName = strrep(figName, ' ', '_');
% figName = strrep(figName, '(', '_');
% figName = strrep(figName, ')', '_');
% figName = strrep(figName, '/', '_');
% figName = strrep(figName, '.', '_');
% figName = fullfile(figFolder, figName);
% savefig(fH1, figName,'compact');
% exportgraphics(fH1,[figName, '.png'], 'Resolution',900);
% exportgraphics(fH1,[figName, '.pdf'], 'ContentType','vector');
% exportgraphics(fH1,[figName, '.eps'], 'Resolution',900);
% %exportFig(fH5, [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
% close(fH1);



%% Local functions
function fH = invCapacitanceVamp(invCapacitance, amps, L5, fTitle, xLabel, yLabel, figFolder, showOrigin)

% Parameters
fontSize = 18;
markerSize = 1.5;

% Draw capacitance vs amplitude correlation
fH = figure; plot(invCapacitance(L5), amps(L5), 'r.', 'MarkerSize',20); hold on
plot(invCapacitance(~L5), amps(~L5), '.', 'Color',[0.9290 0.6940 0.1250], 'MarkerSize',20); hold off
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold');
ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold');

% Calculate correlation coefficients
%[r, pval] = corrLinearCircular(invCapacitance, amps, type='Spearman');
[r, pval] = corrLinearCircular(invCapacitance, amps, type='Pearson');
xLim = xlim;
yLim = ylim;
if showOrigin
  xLim(1) = 0;
  yLim(1) = 0;
end
xAxisLength = xLim(end) - xLim(1);
yAxisLength = 1.075*(yLim(end) - yLim(1));
yLim = [yLim(1) yLim(1)+yAxisLength];
txtStr = ['r=' num2str(r) '  p=' num2str(pval)];
txtList(1) = text(xLim(1)+0.05*xAxisLength, yLim(1)+0.95*yAxisLength, txtStr);
xlim(xLim);
ylim(yLim);

% Fit a line to data
[~, ~, coefficients] = fitLine(invCapacitance, amps, type='linear-linear');
yFit = xLim.*coefficients(1) + coefficients(2);
hold on; p1 = plot(xLim, yFit, 'b:', 'LineWidth',markerSize); hold off
if coefficients(2) >= 0 
  txtStr = ['y=' num2str(coefficients(1)) 'x+' num2str(coefficients(2))];
else
  txtStr = ['y=' num2str(coefficients(1)) 'x' num2str(coefficients(2))];
end
txtList(2) = text(xLim(1)+0.6*xAxisLength, yLim(1)+0.95*yAxisLength, txtStr);
xlim(xLim);
ylim(yLim);

% Fit a line to data passing through origin
if showOrigin
  slope = invCapacitance(:)\amps(:);
  yFit = xLim.*slope;
  hold on; p2 = plot(xLim, yFit, 'k:', 'LineWidth',markerSize); hold off
  %txtStr = ['Q=' num2str(round(slope, 1,'decimal')) 'fC'];
  txtStr = ['y=' num2str(round(slope, 1,'decimal')) 'x (via origin)'];
  %txtList(3) = text(xLim(1)+0.75*xAxisLength, yLim(1)+0.05*yAxisLength, txtStr);
  txtList(3) = text(xLim(1)+0.6*xAxisLength, yLim(1)+0.9*yAxisLength, txtStr);
  xlim(xLim);
  ylim(yLim);
end

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
set(ax,'linewidth',2);

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
savefig(fH, figName,'compact'); % Stop here

title('');
%delete(txtList);
legend('L5','L2/3', 'Location','Southeast');
legend('boxoff');
uistack(p1,'bottom');
if showOrigin
  uistack(p2,'bottom');
end
figName = [figName '_noTxt'];
savefig(fH, figName,'compact');
saveas(fH, figName, 'png');
saveas(fH, figName, 'pdf');
close(fH);
end


function fH = plot2Dhisto(distribution, xEdges, yEdges, xLim, yLim, fTitle, ...
  xLabel, yLabel, zLabel, figFolder)

% Parameters
fontSize = 16;

% Draw the figure
fH = figure; histogram2('XBinEdges',xEdges, 'YBinEdges',yEdges, ...
  'BinCounts',distribution, 'FaceColor','flat');
xlim(xLim)
ylim(yLim)

% Label the figure and axes
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
xlh = xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold');
xLabelPos = xlh.Position;
set(xlh, 'Rotation',16, 'Position',[150 0.13 xLabelPos(3)]);
ylh = ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold');
yLabelPos = ylh.Position;
set(ylh, 'Rotation',-27, 'VerticalAlignment','middle', ...
  'HorizontalAlignment','right', 'Position',[30 3 yLabelPos(3)]);
zlabel(zLabel, 'FontSize',fontSize, 'FontWeight','bold')

% Tidy the figure
set(fH, 'Color', 'white');
ax = gca;
set(ax, 'box', 'off');
set(ax, 'TickDir', 'out');
yTicks = get(ax, 'YTick');
if numel(yTicks) > 8
  set(ax, 'YTick', yTicks(1:2:end));
end
ax.FontSize = fontSize - 2;
set(get(ax, 'XAxis'), 'FontWeight', 'bold');
set(get(ax, 'YAxis'), 'FontWeight', 'bold');
set(get(ax, 'ZAxis'), 'FontWeight', 'bold');
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

% Rotate and save the figure again
view(37.5, 30);
xlh = xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold');
xLabelPos = xlh.Position;
set(xlh, 'Rotation',-15, 'Position',[275 -0.25 xLabelPos(3)]);
ylh = ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold');
yLabelPos = ylh.Position;
set(ylh, 'Rotation',27, 'VerticalAlignment','middle', ...
  'HorizontalAlignment','right', 'Position',[360 13.8 yLabelPos(3)]);
figName = [figName '_rotated']; %#ok<*AGROW>
savefig(fH, figName,'compact');
saveas(fH, figName, 'png');
saveas(fH, figName, 'pdf');
close(fH);
end


function fH = plot1Dhisto(distribution, xBins, xLim, fTitle, xLabel, yLabel, figFolder)

% Parameters
fontSize = 18;

% Draw the figure
fH = figure; plot(xBins, distribution, 'LineWidth',1.5);
xlim(xLim)

% Label the figure and axes
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')

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
end


function fH = ciPlot1Dhisto(distribution, xBins, lowLim, upLim, xBinsCI, xLim, ...
  fTitle, xLabel, yLabel, figFolder)

% Parameters
fontSize = 18;

% Draw the figure
CI = upLim - lowLim;
lowLim(lowLim < 0) = 0;
lowLim2 = lowLim - CI;
lowLim2(lowLim2 < 0) = 0;
upLim2 = upLim + CI;
fH = figure; c2 = ciplot(lowLim2, upLim2, xBinsCI, 'y', 0.4);
hold on; c1 = ciplot(lowLim, upLim, xBinsCI, 'g', 0.3);
if size(distribution, 1) == 2
  p1 = plot(xBins, distribution(1,:), 'r', 'LineWidth',1.25);
  p2 = plot(xBins, distribution(2,:), 'b', 'LineWidth',1.25);
else
  plot(xBins, distribution, 'b', 'LineWidth',1.25);
end
hold off
xlim(xLim)
ylim([0 2750])

% Label the figure and axes
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')

% Put the legend on
if size(distribution, 1) == 2
  legend([p1 p2 c1 c2], {'Noise+minis distribution w/o sim. threshold', ...
    'Noise+minis distribution w/ sim. threshold', 'Range of ''real'' distributions', ...
    '3xRange of ''real'' distributions'}, 'Location','NorthEast');
  legend('boxoff');
end

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
end


function fH = plot1Dhisto3(distributions, xBins, xLim, fTitle, xLabel, yLabel, figFolder)

% Parameters
fontSize = 18;

% Draw the figure
fH = figure; plot(xBins, distributions(1,:), 'g', 'LineWidth',1.5); hold on
plot(xBins, distributions(2,:), 'b', 'LineWidth',1.5);
plot(xBins, distributions(3,:), 'r', 'LineWidth',1.5);
p = plot([xBins(1) xBins(end)], zeros(1,2), 'k:'); hold off
xlim(xLim)
ylim([min(min(distributions))-10 max(max(distributions))+10])

% Label the figure and axes
title(fTitle, 'FontSize',fontSize, 'FontWeight','bold');
xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')

% Creat the legend
legend('Noise with minis', 'Noise-alone', 'Subtracted');
legend('boxoff');
uistack(p,'bottom');

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
end