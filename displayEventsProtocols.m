cleanUp


%% User input
params
recID = 'p108b';

for interval = 1:2
  if interval == 1
    noiseFile = fullfile(dataRepo,recFolder,recID, 'p108b_0019_sw1-5.abf');
    targetFile = fullfile(dataRepo,recFolder,recID,'abf', 'algorithm_performance_data__amp0p3_sAmp0p05_n4000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_56_48_0001.abf');
    targetRawFile = fullfile(dataRepo,recFolder,recID,'abf_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n4000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_56_48_0001.abf');
    eventFileSim = fullfile(dataRepo,recFolder,recID,'mat_minis', 'algorithm_performance_data__amp0p3_sAmp0p05_n4000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_56_48.mat');
    eventFileMiniAnalysis = fullfile(dataRepo,recFolder,recID,'mat_MA', 'algorithm_performance_data__amp0p3_sAmp0p05_n4000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_56_48_MiniAnalysis.mat');
    eventFilepClampRaw = fullfile(dataRepo,recFolder,recID,'mat_pC_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n4000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_56_48_pClamp.mat');
  elseif interval == 2
    noiseFile = fullfile(dataRepo,recFolder,recID, 'p108b_0019_sw1-5.abf');
    targetFile = fullfile(dataRepo,recFolder,recID,'abf', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001.abf');
    targetRawFile = fullfile(dataRepo,recFolder,recID,'abf_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001.abf');
    eventFileSim = fullfile(dataRepo,recFolder,recID,'mat_minis', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31.mat');
    eventFileMiniAnalysis = fullfile(dataRepo,recFolder,recID,'mat_MA', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_MiniAnalysis.mat');
    eventFilepClampRaw = fullfile(dataRepo,recFolder,recID,'mat_pC_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_pClamp.mat');
  end

  yRange = [-60.55 -53.45];


  %% Load files
  [noiseProperties, dt, sweepDuration] = loadabfWrap(noiseFile);
  targetProperties = loadabfWrap(targetFile);
  targetRawProperties = loadabfWrap(targetRawFile);
  load(eventFileSim);


  %% Get noise voltage traces
  noiseRawSweep = noiseProperties.sweep;
  filtN.state = filtering.state;
  filtN.nSweeps = noiseProperties.hd.lActualEpisodes;
  filtN.excludedTimes = filtering.noiseExcludedTimes;
  scaleFactorIndStart = strfind(targetRawFile,'noiseScaleFactor') + 16;
  scaleFactorIndEnd = strfind(targetRawFile,'smoothWindow') - 2;
  scaleFactor = targetRawFile(scaleFactorIndStart:scaleFactorIndEnd);
  scaleFactor = strrep(scaleFactor, 'p', '.');
  scaleFactor = str2double(scaleFactor);
  [noiseSweep, ~, f2] = filterMinis(noiseRawSweep, dt, filtN, true);
  close(f2);
  noiseMean = mean(noiseSweep);
  noiseSweep = (noiseSweep-noiseMean).*scaleFactor + noiseMean;


  %% Estimate the baseline
  time = (1:numel(noiseSweep)).*dt;
  excludedInds = false(size(time));
  excludedInds(round(excludedTimes./dt)+1) = true;
  d = designFilterLP(0.05, 0.075, 0.5, 16, 1000/dt);
  baseline = filtfilt(d, double(noiseSweep(~excludedInds)));
  baselineInterp = interp1(time(~excludedInds), baseline, time, 'linear','extrap');
  averagingWindowSize = 8000/dt;
  baselineSmooth = movmean(baselineInterp, averagingWindowSize, 'EndPoints','shrink');
  %figure; plot(time,baselineSmooth);


  %% Get target and simulation voltage traces
  targetSweep = targetProperties.sweep;
  targetRawSweep = targetRawProperties.sweep;
  simulationSweep = targetRawSweep - noiseSweep;
  downwardShift = 0;
  simulationSweepAdjusted = simulationSweep+baselineSmooth - (mean(simulationSweep+baselineSmooth) - mean(noiseSweep)) - downwardShift;


  %% Position the noise target traces
  downwardShift = 1.1;
  detectionParameters.sampleInterval = noiseProperties.dt;
  detectionParameters.smoothWindow = round(detectionParameters.smoothWindow/detectionParameters.sampleInterval);
  waveform.estimate = false;
  options.summaryPlot = false;
  options.edit = false;
  [~, ~, ~, ~, ~, noiseSweepSmooth] = detectMinis(noiseRawSweep, excludedTimes, detectionParameters, filtN, waveform, 4, options); %#ok<*ASGLU>
  noiseSweepAdjusted = noiseSweepSmooth - 0.5*downwardShift;
  targetSweepAdjusted = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - 1.5*downwardShift;


  %% Display voltage traces
  lineWidth = 2;
  % figure; plot(time,noiseSweep, 'b'); hold on
  targetSweep1 = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - 2.5*downwardShift;
  fH = figure('Units', 'Normalized', 'Position', [0.005 0.06 0.99 0.83], 'GraphicsSmoothing','on');
  set(0, 'DefaultFigureRenderer', 'painters');
  %plot(time,targetSweep1, 'b', 'LineWidth',lineWidth); hold on
  plot(time,targetSweep1, 'Color',matlabColours(8), 'LineWidth',lineWidth*(2/3)); hold on
  targetSweep2 = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - 3.5*downwardShift;
  %plot(time,targetSweep2, 'b', 'LineWidth',lineWidth);
  plot(time,targetSweep2, 'r', 'LineWidth',lineWidth*(2/3));
  targetSweep3 = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - 4.5*downwardShift;
  %plot(time,targetSweep3, 'b', 'LineWidth',lineWidth);
  plot(time,targetSweep3, 'm', 'LineWidth',lineWidth*(2/3));
  plot(time, simulationSweepAdjusted, 'k', 'LineWidth',lineWidth);
  plot(time, noiseSweepAdjusted, 'k', 'LineWidth',lineWidth);
  plot(time, targetSweepAdjusted, 'k', 'LineWidth',lineWidth);
  %yRange = ylim;
  ylim(yRange);


  %% Get event info
  load(eventFileSim);
  fileOrder = str2double(targetFile(end-4));
  allTrue = performance{fileOrder}(1,:);


  %% Mark simulated and noise events
  shift = 0.2;
  xLim = xlim;
  yLim = ylim;
  allTrueInds = find(allTrue);
  for iEvent = 1:numel(allTrueInds)
    plot([time(allTrueInds(iEvent)) time(allTrueInds(iEvent))],[yLim(2)-2*downwardShift yLim(2)] + shift, 'g:', 'LineWidth',2);
    %     plot([time(allTrueInds(iEvent)) time(allTrueInds(iEvent))],[yLim(2)-3.5*downwardShift yLim(2)-2.5*downwardShift] + shift, 'g:', 'LineWidth',1);
    plot([time(allTrueInds(iEvent)) time(allTrueInds(iEvent))],[yLim(2)-7*downwardShift yLim(2)-2.5*downwardShift] + shift, 'g:', 'LineWidth',2);
  end
  for iEvent = 1:numel(falseI)
    %     plot([time(falseI(iEvent)) time(falseI(iEvent))],[yLim(2)-3.5*downwardShift yLim(2)-2*downwardShift] + shift, 'c:', 'LineWidth',1);
    plot([time(falseI(iEvent)) time(falseI(iEvent))],[yLim(2)-7*downwardShift yLim(2)-2*downwardShift] + shift, 'c:', 'LineWidth',2);
  end
  for iEvent = 1:numel(allTrueInds)
    ciplot([yLim(2) yLim(2)] -2*downwardShift + shift, [yLim(2) yLim(2)] + shift, [time(allTrueInds(iEvent))-5 time(allTrueInds(iEvent))+5], [230 255 230]./255, 1);
    %     ciplot([yLim(2) yLim(2)] -3.5*downwardShift + shift, [yLim(2) yLim(2)] -2.5*downwardShift + shift, [time(allTrueInds(iEvent))-5 time(allTrueInds(iEvent))+5], 'g', 0.1);
    ciplot([yLim(2) yLim(2)] -7*downwardShift + shift, [yLim(2) yLim(2)] -2.5*downwardShift + shift, [time(allTrueInds(iEvent))-5 time(allTrueInds(iEvent))+5], [230 255 230]./255, 1);
  end
  for iEvent = 1:numel(falseI)
    %     ciplot([yLim(2) yLim(2)] -3.5*downwardShift + shift, [yLim(2) yLim(2)] -2*downwardShift + shift, [time(falseI(iEvent))-5 time(falseI(iEvent))+5], 'c', 0.1);
    p = ciplot([yLim(2) yLim(2)] -7*downwardShift + shift, [yLim(2) yLim(2)] -2*downwardShift + shift, [time(falseI(iEvent))-5 time(falseI(iEvent))+5], [230 255 255]./255, 1);
  end
  set(gca, 'Children', flipud(get(gca, 'Children')))


  %% Mark detected events by minis
  markerSize = 20;
  lineWidth = 1.25;
  markerFaceColourHits = 'none';
  markerFaceColourFA = 'none';
  truePositive = performance{fileOrder}(4,:);
  pHit = plot(time(logical(truePositive)), targetSweep1(logical(truePositive)),...
    'g^', 'MarkerFaceColor',markerFaceColourHits, 'MarkerEdgeColor',matlabColours(9), 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  falsePositive = performance{fileOrder}(6,:);
  pFA = plot(time(logical(falsePositive)), targetSweep1(logical(falsePositive)),...
    'r^', 'MarkerFaceColor',markerFaceColourFA, 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  falseNegative = performance{fileOrder}(5,:);
  pMiss = plot(time(logical(falseNegative)), targetSweep1(logical(falseNegative)), 'ro', 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  trueNegative = performance{fileOrder}(7,:);
  pCR = plot(time(logical(trueNegative)), targetSweep1(logical(trueNegative)), 'x', 'Color',matlabColours(11), 'MarkerSize',markerSize+5, 'Linewidth',lineWidth*2); %#ok<*NASGU>


  %% Mark detected events by Mini Analysis
  load(eventFileMiniAnalysis);
  truePositive = performance{fileOrder}(4,:);
  plot(time(logical(truePositive)), targetSweep2(logical(truePositive)),...
    'g^', 'MarkerFaceColor',markerFaceColourHits, 'MarkerEdgeColor',matlabColours(9), 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  falsePositive = performance{fileOrder}(6,:);
  plot(time(logical(falsePositive)), targetSweep2(logical(falsePositive)),...
    'r^', 'MarkerFaceColor',markerFaceColourFA, 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  falseNegative = performance{fileOrder}(5,:);
  plot(time(logical(falseNegative)), targetSweep2(logical(falseNegative)), 'ro', 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  trueNegative = performance{fileOrder}(7,:);
  plot(time(logical(trueNegative)), targetSweep2(logical(trueNegative)), 'x', 'Color',matlabColours(11), 'MarkerSize',markerSize+5, 'Linewidth',lineWidth*2);


  %% Mark detected events in unsmoothed data by pClamp
  load(eventFilepClampRaw);
  truePositive = performance{fileOrder}(4,:);
  plot(time(logical(truePositive)), targetSweep3(logical(truePositive)),...
    'g^', 'MarkerFaceColor',markerFaceColourHits, 'MarkerEdgeColor',matlabColours(9), 'MarkerSize',markerSize, 'Linewidth',lineWidth, 'Linewidth',lineWidth);
  falsePositive = performance{fileOrder}(6,:);
  plot(time(logical(falsePositive)), targetSweep3(logical(falsePositive)),...
    'r^', 'MarkerFaceColor',markerFaceColourFA, 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  falseNegative = performance{fileOrder}(5,:);
  plot(time(logical(falseNegative)), targetSweep3(logical(falseNegative)), 'ro', 'MarkerSize',markerSize, 'Linewidth',lineWidth);
  trueNegative = performance{fileOrder}(7,:);
  pCR = plot(time(logical(trueNegative)), targetSweep3(logical(trueNegative)), 'x', 'Color',matlabColours(11), 'MarkerSize',markerSize+5, 'Linewidth',lineWidth*2);
  hold off
  %legend([pHit pFA pMiss], {'Hit','False alarm','Miss'});
  %legend boxoff


  %% Save trace chunk images
  [abfFilePath, imageFileName] = fileparts(targetFile);
  recordingPath = fileparts(abfFilePath);
  loopSize = 2000; %ms
  %imageLoop(fH, loopSize, time, recordingPath, imageFileName, yLim);
  imageChunk(fH, getChunkTimes(), recordingPath, imageFileName, yLim);


  %% Tidy and save the figure
  %legend([pHit pFA pMiss], {'Hit','False alarm','Miss'});
  %legend boxoff
  yWindowSize = 4.2;
  yShift = 0.25;
  yLim = yRange;
  xLim = [0 time(end)];
  ax1 = axesProperties({}, 1, 'normal', 'off', 'w', 'Calibri', 12, 4/3, 2, [0.005 0], 'out',...
    'off', 'w', {}, xLim, xticks,...
    'off', 'w', {}, yLim, yticks);
  [abfFilePath, imageFileName] = fileparts(targetFile);
  recordingPath = fileparts(abfFilePath);
  figFileName = [imageFileName '_interv_' num2str(xLim(1)) '_' num2str(xLim(2))...
    '_voltage_range_' num2str(yLim(1)) '_' num2str(yLim(2))];
  set(fH, 'Name',figFileName);
  voltageTraceFolder = [recordingPath filesep 'traces'];
  if ~exist(voltageTraceFolder, 'file')
    mkdir(voltageTraceFolder);
  end
  figFileName = [voltageTraceFolder filesep figFileName];
  label = [0 0];
  margin = [0 0];
  width = 15-label(1)-margin(1);
  height = 1.5*15-label(2)-margin(2);
  paperSize = resizeFig(fH, ax1, width, height, label, margin, 0);
  %exportFig(fH, [figFileName '.png'],'-dpng','-r300', paperSize);
  %exportFig(fH, [figFileName '.eps'],'-depsc','-r1200', paperSize);
  hgsave(gcf, [figFileName '.fig']);
end
close all



%% Local functions
function [fileProperties, dt, sweepDuration] = loadabfWrap(filename)

fileProperties = loadABF(filename);
dt = fileProperties.dt;
sweepDuration = (length(fileProperties.sweep)*dt - dt)/fileProperties.hd.lActualEpisodes;
end

function imageLoop(fH, loopSize, time, recordingPath, imageFileName, yLim) %#ok<*DEFNU>

nChunks = ceil(time(end)/loopSize);
for iChunk = 1:nChunks
  if iChunk == nChunks
    chunkTime = [(iChunk-1)*loopSize time(end)];
  else
    chunkTime = [(iChunk-1)*loopSize iChunk*loopSize];
  end
  xlim(chunkTime);
  xLim = xlim;

  figFileName = [imageFileName '_time_interval_' num2str(xLim(1)) '_' num2str(xLim(2))...
    '_voltage_range_' num2str(yLim(1)) '_' num2str(yLim(2))];
  set(fH, 'Name',figFileName);
  voltageTraceFolder = [recordingPath filesep 'traces'];
  if ~exist(voltageTraceFolder, 'file')
    mkdir(voltageTraceFolder);
  end
  figFileName = [voltageTraceFolder filesep figFileName]; %#ok<*AGROW>
  saveas(fH, [figFileName '.png'], 'png');
end
end

function chunkTimes = getChunkTimes()

%chunkTimes = [26850 28250];
%chunkTimes = [26940 27670];
%chunkTimes = [12100 13400];
chunkTimes = [12570 13350];
end

function imageChunk(fH, chunkTimes, recordingPath, imageFileName, yLim)

%legend boxoff
for iChunk = 1:size(chunkTimes,1)
  xlim(chunkTimes(iChunk,:));
  xLim = xlim;

  figFileName = [imageFileName '_interv_' num2str(xLim(1)) '_' num2str(xLim(2))...
    '_voltage_range_' num2str(yLim(1)) '_' num2str(yLim(2))];
  set(fH, 'Name',figFileName);
  voltageTraceFolder = [recordingPath filesep 'traces'];
  if ~exist(voltageTraceFolder, 'file')
    mkdir(voltageTraceFolder);
  end
  figFileName = [voltageTraceFolder filesep figFileName]; %#ok<*AGROW>

  label = [0 0];
  margin = [0 0];
  width = ((chunkTimes(iChunk,2)-chunkTimes(iChunk,1))/1000)*60-label(1)-margin(1);
  height = 2*15-label(2)-margin(2);
  paperSize = resizeFig(fH, gca, width, height, label, margin, 0);
  %savefig(fH, [figFileName '.fig'], 'compact');

  set(gca, 'Box', 'off');
  set(gca, 'TickLength', [0; 0]);
  exportFig(fH, [figFileName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH, [figFileName '.eps'],'-depsc','-r1200', paperSize);
end
end