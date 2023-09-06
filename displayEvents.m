cleanUp


%% User input
params

for rec = 1:2
  if rec == 1
    recID = 'p108a';
    noiseFile = fullfile(dataRepo,recFolder,recID, 'p108a_0025_sw1-5.abf');
    targetFile = fullfile(dataRepo,recFolder,recID,'abf', 'algorithm_performance_data__amp0p3_sAmp0p05_n2000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__10_Jan_2021_23_30_07_0001.abf');
    targetRawFile = fullfile(dataRepo,recFolder,recID,'abf_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n2000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__10_Jan_2021_23_30_07_0001.abf');
    eventFileSim = fullfile(dataRepo,recFolder,recID,'mat_minis', 'algorithm_performance_data__amp0p3_sAmp0p05_n2000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__10_Jan_2021_23_30_07.mat');
    eventFileMiniAnalysis = fullfile(dataRepo,recFolder,recID,'mat_MA', 'algorithm_performance_data__amp0p3_sAmp0p05_n2000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__10_Jan_2021_23_30_07_MiniAnalysis.mat');
    eventFilepClampRaw = fullfile(dataRepo,recFolder,recID,'mat_pC_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n2000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__10_Jan_2021_23_30_07_pClamp.mat');
    yRange = [-62.55 -58.8];
  else
    recID = 'p108b';
    noiseFile = fullfile(dataRepo,recFolder,recID, 'p108b_0019_sw1-5.abf');
    targetFile = fullfile(dataRepo,recFolder,recID,'abf', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001.abf');
    targetRawFile = fullfile(dataRepo,recFolder,recID,'abf_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_0001.abf');
    eventFileSim = fullfile(dataRepo,recFolder,recID,'mat_minis', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31.mat');
    eventFileMiniAnalysis = fullfile(dataRepo,recFolder,recID,'mat_MA', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_MiniAnalysis.mat');
    eventFilepClampRaw = fullfile(dataRepo,recFolder,recID,'mat_pC_raw', 'algorithm_performance_data__amp0p3_sAmp0p05_n8000_RT0p5_sRT2p8_rho0_thr0p1_noiseScaleFactor1_smoothWindow1p5__11_Jan_2021_13_57_31_pClamp.mat');
    yRange = [-58 -53.96];
  end


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
  [noiseSweep, ~, f2] = filterMinis(noiseProperties.sweep, dt, filtN, true);
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
  adjustedSimulationSweep = simulationSweep+baselineSmooth - (mean(simulationSweep+baselineSmooth) - mean(noiseSweep)) - downwardShift;


  %% Display voltage traces
  downwardShift = 0.83; %1;
  lineWidth = 1.5;
  % figure; plot(time,noiseSweep, 'b'); hold on
  targetSweep1 = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - downwardShift;
  fH = figure('Units', 'Normalized', 'Position', [0.005 0.06 0.99 0.83]);
  %plot(time,targetSweep1, 'b', 'LineWidth',lineWidth); hold on
  plot(time,targetSweep1, 'Color',matlabColours(8), 'LineWidth',lineWidth*(2/3)); hold on
  targetSweep2 = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - 2*downwardShift;
  %plot(time,targetSweep2, 'b', 'LineWidth',lineWidth);
  plot(time,targetSweep2, 'r', 'LineWidth',lineWidth*(2/3));
  targetSweep3 = targetSweep - (mean(targetSweep) - mean(noiseSweep)) - 3*downwardShift;
  %plot(time,targetSweep3, 'b', 'LineWidth',lineWidth);
  plot(time,targetSweep3, 'm', 'LineWidth',lineWidth*(2/3));
  plot(time, adjustedSimulationSweep, 'k', 'LineWidth',lineWidth);
  %yRange = ylim;
  ylim(yRange);


  %% Get event info
  load(eventFileSim);
  fileOrder = str2double(targetFile(end-4));
  allTrue = performance{fileOrder}(1,:);


  %% Mark simulated events
  %plot(time(logical(allTrue)),adjustedSimulationSweep(logical(allTrue)), 'r.', 'MarkerSize',5); hold off
  xLim = xlim;
  yLim = ylim;
  allTrueInds = find(allTrue);
  for iEvent = 1:numel(allTrueInds)
    plot([time(allTrueInds(iEvent)) time(allTrueInds(iEvent))],yLim, 'g:', 'LineWidth',1);
  end
  for iEvent = 1:numel(allTrueInds)
    ciplot([yLim(1) yLim(1)], [yLim(2) yLim(2)], [time(allTrueInds(iEvent))-5 time(allTrueInds(iEvent))+5], [230 255 230]./255, 1);
  end
  xlim(xLim);
  ylim(yLim);
  set(gca, 'Children', flipud(get(gca, 'Children')))


  %% Mark detected events by minis
  markerSize = 15;
  lineWidth = 1.25;
  markerFaceColourHits = 'none';
  markerFaceColourFA = 'none';
  truePositive = performance{fileOrder}(4,:);
  pHit = plot(time(logical(truePositive)), targetSweep1(logical(truePositive)),...
    'g^', 'MarkerFaceColor',markerFaceColourHits, 'MarkerEdgeColor',matlabColours(9), 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  falsePositive = performance{fileOrder}(6,:);
  pFA = plot(time(logical(falsePositive)), targetSweep1(logical(falsePositive)),...
    'r^', 'MarkerFaceColor',markerFaceColourFA, 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  falseNegative = performance{fileOrder}(5,:);
  pMiss = plot(time(logical(falseNegative)), targetSweep1(logical(falseNegative)), 'ro', 'MarkerSize',markerSize, 'LineWidth',lineWidth);


  %% Mark detected events by Mini Analysis
  load(eventFileMiniAnalysis);
  truePositive = performance{fileOrder}(4,:);
  plot(time(logical(truePositive)), targetSweep2(logical(truePositive)),...
    'g^', 'MarkerFaceColor',markerFaceColourHits, 'MarkerEdgeColor',matlabColours(9), 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  falsePositive = performance{fileOrder}(6,:);
  plot(time(logical(falsePositive)), targetSweep2(logical(falsePositive)),...
    'r^', 'MarkerFaceColor',markerFaceColourFA, 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  falseNegative = performance{fileOrder}(5,:);
  plot(time(logical(falseNegative)), targetSweep2(logical(falseNegative)), 'ro', 'MarkerSize',markerSize, 'LineWidth',lineWidth);


  %% Mark detected events in unsmoothed data by pClamp
  load(eventFilepClampRaw);
  truePositive = performance{fileOrder}(4,:);
  plot(time(logical(truePositive)), targetSweep3(logical(truePositive)),...
    'g^', 'MarkerFaceColor',markerFaceColourHits, 'MarkerEdgeColor',matlabColours(9), 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  falsePositive = performance{fileOrder}(6,:);
  plot(time(logical(falsePositive)), targetSweep3(logical(falsePositive)),...
    'r^', 'MarkerFaceColor',markerFaceColourFA, 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  falseNegative = performance{fileOrder}(5,:);
  plot(time(logical(falseNegative)), targetSweep3(logical(falseNegative)), 'ro', 'MarkerSize',markerSize, 'LineWidth',lineWidth);
  hold off
  % legend([pHit pFA pMiss], {'Hit','False alarm','Miss'});
  % legend boxoff


  %% Save trace chunk images
  [abfFilePath, imageFileName] = fileparts(targetFile);
  recordingPath = fileparts(abfFilePath);
  %loopSize = 1000; %ms
  %imageLoop(fH, loopSize, time, recordingPath, imageFileName, yLim);
  imageChunk(fH, getChunkTimes(recID), recordingPath, imageFileName, yLim);


  %% Tidy and save the figure
  legend([pHit pFA pMiss], {'Hit','False alarm','Miss'});
  legend boxoff
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
    '_volt_range_' num2str(yLim(1)) '_' num2str(yLim(2))];
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

  figFileName = [imageFileName '_interv_' num2str(xLim(1)) '_' num2str(xLim(2))...
    '_volt_range_' num2str(yLim(1)) '_' num2str(yLim(2))];
  set(fH, 'Name',figFileName);
  voltageTraceFolder = [recordingPath filesep 'traces'];
  if ~exist(voltageTraceFolder, 'file')
    mkdir(voltageTraceFolder);
  end
  figFileName = [voltageTraceFolder filesep figFileName]; %#ok<*AGROW>
  saveas(fH, [figFileName '.png'], 'png');
end
end

function chunkTimes = getChunkTimes(recID)

if strcmpi(recID, 'p108b')
  chunkTimes = [00350 00500;...
    01500 01800;...
    03200 03600;...
    03600 04000;...
    04500 04700;...
    05600 06000;...
    06000 07000;...
    07100 07300;...
    07400 07700;...
    08600 08800;...
    10300 10500;...
    11650 11750;...
    13200 13600;...
    15650 15750;...
    19000 19300;...
    19700 19800;...
    21300 21400;...
    23600 24000;...
    24200 24500;...
    26300 26500;...
    28500 28700;...
    31300 31400;...
    34400 34600;...
    36850 36950;...
    37750 37850;...
    41300 41800;...
    52500 52700];
elseif strcmpi(recID, 'p108a')
  chunkTimes = [38500 38700;...
    59000 60000];
else
  error(['Recording ID ' recID ' is currently not supported.']);
end
end

function imageChunk(fH, chunkTimes, recordingPath, imageFileName, yLim)

%legend boxoff
for iChunk = 1:size(chunkTimes,1)
  xlim(chunkTimes(iChunk,:));
  xLim = xlim;

  figFileName = [imageFileName '_interv_' num2str(xLim(1)) '_' num2str(xLim(2))...
    '_volt_range_' num2str(yLim(1)) '_' num2str(yLim(2))];
  set(fH, 'Name',figFileName);
  voltageTraceFolder = [recordingPath filesep 'traces'];
  if ~exist(voltageTraceFolder, 'file')
    mkdir(voltageTraceFolder);
  end
  figFileName = [voltageTraceFolder filesep figFileName]; %#ok<*AGROW>

  label = [0 0];
  margin = [0 0];
  width = ((chunkTimes(iChunk,2)-chunkTimes(iChunk,1))/500)*22.5-label(1)-margin(1);
  %width = ((chunkTimes(iChunk,2)-chunkTimes(iChunk,1))/500)*15-label(1)-margin(1);
  height = 15-label(2)-margin(2);
  paperSize = resizeFig(fH, gca, width, height, label, margin, 0);
  %savefig(fH, [figFileName '.fig'], 'compact');

  set(gca, 'Box', 'off');
  set(gca, 'TickLength', [0; 0]);
  exportFig(fH, [figFileName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH, [figFileName '.eps'],'-depsc','-r1200', paperSize);
end
end