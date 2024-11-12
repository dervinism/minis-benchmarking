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
parametric = false;
normalise = false;
mergeBins = false;
match2mean = false;

% Excluded times and excluded time durations per sweep
excludedSweepTimes = {[0.00 1.10; 1.65 2.20];  % p103a
                      [0.00 0.90; 1.60 2.20];  % p106b
                      [0.00 1.15; 1.85 2.40];  % p108a
                      [0.00 1.25; 1.85 2.40];  % p108b
                      [0.00 1.20; 1.85 2.40];  % p108c
                      [0.00 1.20; 1.85 2.40];  % p120b
                      [0.00 1.25; 1.85 2.40];  % p122a
                      [0.00 1.15; 1.85 2.40];  % p124b
                      [0.00 1.20; 1.85 2.40];  % p125a
                      [0.00 1.20; 1.85 2.40];  % p127c
                      [0.00 1.20; 1.85 2.40];  % p128c
                      [0.00 1.20; 1.85 2.40];  % p129a
                      [0.00 2.25; 2.85 3.40];  % p131a
                      [0.00 1.00; 2.90 3.40]}; % p131c
excludedTimeDurations = zeros(1, numel(excludedSweepTimes));
for iRec = 1:numel(excludedSweepTimes)
  excludedTimeDurations(iRec) = (excludedSweepTimes{iRec}(1,2) - excludedSweepTimes{iRec}(1,1)) + ...
    (excludedSweepTimes{iRec}(2,2) - excludedSweepTimes{iRec}(2,1));
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

% Old excluded times and excluded time durations per sweep
oldExcludedSweepTimes = {[0.00 1.10; 1.65 2.20];  % p103a
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
oldExcludedTimeDurations = zeros(1, numel(oldExcludedSweepTimes));
for iRec = 1:numel(oldExcludedSweepTimes)
  oldExcludedTimeDurations(iRec) = (oldExcludedSweepTimes{iRec}(1,2) - oldExcludedSweepTimes{iRec}(1,1)) + ...
    (oldExcludedSweepTimes{iRec}(2,2) - oldExcludedSweepTimes{iRec}(2,1));
end

% Simulated file durations after accounting for excluded times
oldDurations = [endTimes(1)-nSweeps(1)*oldExcludedTimeDurations(1)       % p103a
                endTimes(2)-nSweeps(2)*oldExcludedTimeDurations(2)       % p106b
                endTimes(3)-nSweeps(3)*oldExcludedTimeDurations(3)       % p108a
                endTimes(4)-nSweeps(4)*oldExcludedTimeDurations(4)       % p108b
                endTimes(5)-nSweeps(5)*oldExcludedTimeDurations(5)       % p108c
                endTimes(6)-nSweeps(6)*oldExcludedTimeDurations(6)       % p120b
                endTimes(7)-nSweeps(7)*oldExcludedTimeDurations(7)       % p122a
                endTimes(8)-nSweeps(8)*oldExcludedTimeDurations(8)       % p124b
                endTimes(9)-nSweeps(9)*oldExcludedTimeDurations(9)       % p125a
                endTimes(10)-nSweeps(10)*oldExcludedTimeDurations(10)    % p127c
                endTimes(11)-nSweeps(11)*oldExcludedTimeDurations(11)    % p128c
                endTimes(12)-nSweeps(12)*oldExcludedTimeDurations(12)    % p129a
                endTimes(13)-nSweeps(13)*oldExcludedTimeDurations(13)    % p131a
                endTimes(14)-nSweeps(14)*oldExcludedTimeDurations(14)]'; % p131c

% Scaling factors
scalingFactors = oldDurations./durations;

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


%% Get the bin locations
ampBinSize = 0.01;
rtBinSize = 0.5;
ampEdges = 0:ampBinSize:5;
rtEdges = 0:rtBinSize:11;
ampBins = (ampBinSize:ampBinSize:5) - ampBinSize/2;
rtBins = (rtBinSize:rtBinSize:11) - rtBinSize/2;

if normalise && mergeBins
  ampBinSize1 = ampBinSize;
  ampBinEnd1 = 0.1;
  ampBins1 = (ampBinSize1:ampBinSize1:ampBinEnd1) - ampBinSize1/2;
  ampBins1Inds = 1:numel(ampBins1);
  ampBins1Mask = false(size(ampBins));
  ampBins1Mask(ampBins1Inds) = true;
  ampBinSize2 = ampBinSize*2;
  ampBinEnd2 = 0.2;
  ampBins2 = ((ampBinEnd1+ampBinSize2):ampBinSize2:ampBinEnd2) - ampBinSize2;
  ampBins2Inds = ampBins1Inds + numel(ampBins1);
  ampBins2Mask = false(size(ampBins));
  ampBins2Mask(ampBins2Inds) = true;
  ampBinSize3 = ampBinSize*4;
  ampBinEnd3 = 5;
  ampBins3 = ((ampBinEnd2+ampBinSize3):ampBinSize3:ampBinEnd3) - ampBinSize3;
  ampBins3Inds = (ampBins2Inds(end) + 1):numel(ampBins);
  ampBins3Mask = false(size(ampBins));
  ampBins3Mask(ampBins3Inds) = true;
  ampBinsMerged = [ampBins1 ampBins2 ampBins3];
end


%% Display distribution fitting performance for individual recordings: With stats
skewness = [];
for iRec = 8 %1:nRecs
  % Load settings
  load(fullfile(fitFolder, recIDs{iRec}, 'settings.mat'));

  % Load simulated data
  recFolder = fullfile(fitFolder, recIDs{iRec});
  simFile = dir(fullfile(recFolder, 'fit*.mat'));
  simFile = fullfile(recFolder, simFile.name);
  fitData = load(simFile);

  % Detect minis in the simulated data
  [~, excludedTimes] = initExclTimesTarget(settings);
  waveform.estimate = 0;
  filtering.state = 'spectrum';
  filtering.excludedTimes = excludedTimes;
  filtering.filtfs = {'50, 150'};
  filtering.nSweeps = nSweeps(iRec);
  sweepDuration = (length(fitData.V)*fitData.detectionParametersSim.sampleInterval ...
    - fitData.detectionParametersSim.sampleInterval)/nSweeps(iRec);
  startPulse = excludedTimes.startPulse;
  excludedTimes = calcExcludedTimes(sweepDuration, nSweeps(iRec), ...
    1000*excludedTimes.startPulse, 1000*excludedTimes.endPulse, ...
    1000*excludedTimes.startGlitch, 1000*excludedTimes.endGlitch, ...
    fitData.detectionParametersSim.sampleInterval);
  eventArray = detectMinis(fitData.V, excludedTimes, fitData.detectionParametersSim, filtering, waveform, 8);
  skewness = [skewness; (mean(eventArray(:,12)) - median(eventArray(:,12)))/std(eventArray(:,12))];

  % Load intermediate error bounds file
  distroFile = fullfile(fitFolder, recIDs{iRec}, 'intermediateErrorBounds');
  intermediateErrorBounds = load(distroFile);

  % Bin detected simulated events into a histogram
  [simEventAmpDistro, simEventRTDistro, simEventDistro] = classifyMinis( ...
    eventArray(:,4), eventArray(:,12), intermediateErrorBounds.classificationParameters);
  if startPulse == 0
    scaleFactor = scalingFactors(iRec);
  else
    scaleFactor = 1;
  end
  simEventAmpDistro = simEventAmpDistro.*scaleFactor;
  simEventRTDistro = simEventRTDistro.*scaleFactor;
  simEventDistro = simEventDistro.*scaleFactor;

  % Load real detection data
  fileSize = endTimes(iRec);
  realData = [];
  detectionFolder = fullfile(dataFolderReal, recIDs{iRec}, 'txt_minis_real');
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt')
      iFileAdjusted = iFile-2;
      T = readtable(detectionFile);
      if iFileAdjusted == 1
        fileStartTime = 0;
      else
        fileStartTime = fileStartTime + nSweepsReal{iRec}(iFileAdjusted-1)*sweepDurations(iRec);
      end
      times = (T.PeakTime./1000)+fileStartTime;
      grouping = ceil(times./fileSize);
      realData = [realData; [grouping times T.Amplitude T.x10_90_RT]];
      [~, recFilename] = fileparts(files(iFile).name);
      if contains(settings.loadTargetFileInput, recFilename)
        targetFileOrder = iFileAdjusted;
      end
    end
  end

  % Calculate amplitude and rise time of real data distributions (for 95% CI calculation)
  nDistros = realData(end,1);
  scaleFactors = ones(nDistros,1).*(endTimes(iRec)/fileSize);
  lastDistroTimes = realData(realData(:,1) == nDistros, 2);
  if lastDistroTimes(end) - lastDistroTimes(1) > 1
    scaleFactors(end) = scaleFactors(end)/((lastDistroTimes(end) - lastDistroTimes(1))/fileSize);
  end
  realEventAmpDistrosForStats = [];
  realEventRTDistrosForStats = [];
  for iDistro = 1:nDistros
    distroData = realData(realData(:,1) == iDistro, :);
    [realEventAmpDistroForStats, realEventRTDistroForStats] = classifyMinis( ...
      distroData(:,3), distroData(:,4), intermediateErrorBounds.classificationParameters);
    realEventAmpDistrosForStats = [realEventAmpDistrosForStats; realEventAmpDistroForStats.*scaleFactors(iDistro)]; %#ok<*AGROW>
    realEventRTDistrosForStats = [realEventRTDistrosForStats; realEventRTDistroForStats.*scaleFactors(iDistro)];
  end

  % Work out real data distribution limits
  lowerAmpLimit = min(realEventAmpDistrosForStats);
  upperAmpLimit = max(realEventAmpDistrosForStats);
  lowerRTLimit = min(realEventRTDistrosForStats);
  upperRTLimit = max(realEventRTDistrosForStats);

  ci95plot = false;
  [realEventAmpDistroMean, realEventAmpDistroCI] = datamean(realEventAmpDistrosForStats);
    [realEventRTDistroMean, realEventRTDistroCI] = datamean(realEventRTDistrosForStats);
  if ci95plot
    lowerAmpLimit2 = realEventAmpDistroMean + realEventAmpDistroCI(1,:); %#ok<*UNRCH>
    upperAmpLimit2 = realEventAmpDistroMean + realEventAmpDistroCI(2,:);
    lowerRTLimit2 = realEventRTDistroMean + realEventRTDistroCI(1,:);
    upperRTLimit2 = realEventRTDistroMean + realEventRTDistroCI(2,:);
  else
    CI = upperAmpLimit - lowerAmpLimit;
    lowerAmpLimit2 = lowerAmpLimit - CI;
    upperAmpLimit2 = upperAmpLimit + CI;
    CI = upperRTLimit - lowerRTLimit;
    lowerRTLimit2 = lowerRTLimit - CI;
    upperRTLimit2 = upperRTLimit + CI;
  end

  % Perform underfitting and overfitting tests
  combs = nchoosek(1:nDistros,2);
  ampDistancesSum = zeros(nDistros,nDistros-1);
  rtDistancesSum = zeros(nDistros,nDistros-1);
  ampDistancesSumSim = zeros(1,nDistros);
  rtDistancesSumSim = zeros(1,nDistros);
  if normalise
    ampCutoff = 5;
    ampInds = ampBins <= ampCutoff;
    if mergeBins
      ampBins1Mask = ampBins1Mask & ampInds;
      ampBins2Mask = ampBins2Mask & ampInds;
      ampBins3Mask = ampBins3Mask & ampInds;
      period1 = realEventAmpDistroMean(ampBins1Mask);
      period2 = resampleSpikeCounts(realEventAmpDistroMean( ...
        ampBins2Mask), stepsize=ampBinSize, newStepsize=ampBinSize2);
      period3 = resampleSpikeCounts(realEventAmpDistroMean( ...
        ampBins3Mask), stepsize=ampBinSize, newStepsize=ampBinSize3);
      realEventAmpDistroMean = [period1 period2 period3];
      ampInds = 1:numel(realEventAmpDistroMean);
    end
    realEventAmpDistroMean(realEventAmpDistroMean < 1e-9) = 1;
    rtCutoff = 9;
    rtInds = rtBins <= rtCutoff;
    realEventRTDistroMean(realEventRTDistroMean < 1e-9) = 1;
  else
    ampInds = true(1, numel(ampBins));
  end
  for iDistro = 1:nDistros
    combsOI = combs(logical(combs(:,1) == iDistro | combs(:,2) == iDistro),:);
    for iCombo = 1:size(combsOI,1)
      if normalise
        if mergeBins
          period1 = realEventAmpDistrosForStats(combsOI(iCombo,1), ampBins1Mask);
          period2 = resampleSpikeCounts(realEventAmpDistrosForStats( ...
            combsOI(iCombo,1), ampBins2Mask), stepsize=ampBinSize, newStepsize=ampBinSize2);
          period3 = resampleSpikeCounts(realEventAmpDistrosForStats( ...
            combsOI(iCombo,1), ampBins3Mask), stepsize=ampBinSize, newStepsize=ampBinSize3);
          realEventAmpDistro1 = [period1 period2 period3];
          period1 = realEventAmpDistrosForStats(combsOI(iCombo,2), ampBins1Mask);
          period2 = resampleSpikeCounts(realEventAmpDistrosForStats( ...
            combsOI(iCombo,2), ampBins2Mask), stepsize=ampBinSize, newStepsize=ampBinSize2);
          period3 = resampleSpikeCounts(realEventAmpDistrosForStats( ...
            combsOI(iCombo,2), ampBins3Mask), stepsize=ampBinSize, newStepsize=ampBinSize3);
          realEventAmpDistro2 = [period1 period2 period3];
          ampDistancesSum(iDistro,iCombo) = sum(abs( ...
            realEventAmpDistro1 - realEventAmpDistro2)./ ...
            realEventAmpDistroMean(ampInds),'omitnan');
        else
          ampDistancesSum(iDistro,iCombo) = sum(abs( ...
            (realEventAmpDistrosForStats(combsOI(iCombo,1),ampInds) - ...
            realEventAmpDistrosForStats(combsOI(iCombo,2),ampInds)))./ ...
            realEventAmpDistroMean(ampInds),'omitnan');
        end
        rtDistancesSum(iDistro,iCombo) = sum(abs( ...
          (realEventRTDistrosForStats(combsOI(iCombo,1),rtInds) - ...
          realEventRTDistrosForStats(combsOI(iCombo,2),rtInds)))./realEventRTDistroMean(rtInds),'omitnan');
      else
        ampDistancesSum(iDistro,iCombo) = sum(abs( ...
          realEventAmpDistrosForStats(combsOI(iCombo,1),:) - ...
          realEventAmpDistrosForStats(combsOI(iCombo,2),:)),'omitnan');
        rtDistancesSum(iDistro,iCombo) = sum(abs( ...
          realEventRTDistrosForStats(combsOI(iCombo,1),:) - ...
          realEventRTDistrosForStats(combsOI(iCombo,2),:)),'omitnan');
      end
    end
    if normalise
      if mergeBins
        period1 = realEventAmpDistrosForStats(iDistro, ampBins1Mask);
        period2 = resampleSpikeCounts(realEventAmpDistrosForStats( ...
          iDistro, ampBins2Mask), stepsize=ampBinSize, newStepsize=ampBinSize2);
        period3 = resampleSpikeCounts(realEventAmpDistrosForStats( ...
          iDistro, ampBins3Mask), stepsize=ampBinSize, newStepsize=ampBinSize3);
        realEventAmpDistro = [period1 period2 period3];
        period1 = simEventAmpDistro(ampBins1Mask);
        period2 = resampleSpikeCounts(simEventAmpDistro( ...
          ampBins2Mask), stepsize=ampBinSize, newStepsize=ampBinSize2);
        period3 = resampleSpikeCounts(simEventAmpDistro( ...
          ampBins3Mask), stepsize=ampBinSize, newStepsize=ampBinSize3);
        simEventAmpDistroTemp = [period1 period2 period3];
        ampDistancesSumSim(iDistro) = sum(abs( ...
          realEventAmpDistro - simEventAmpDistroTemp)./ ...
          realEventAmpDistroMean(ampInds), 'omitnan');
      else
        ampDistancesSumSim(iDistro) = sum(abs(realEventAmpDistrosForStats(iDistro,ampInds) - ...
          simEventAmpDistro(ampInds))./realEventAmpDistroMean(ampInds),'omitnan');
      end
      rtDistancesSumSim(iDistro) = sum(abs(realEventRTDistrosForStats(iDistro,rtInds) - ...
        simEventRTDistro(rtInds))./realEventRTDistroMean(rtInds),'omitnan');
    else
      ampDistancesSumSim(iDistro) = sum(abs(realEventAmpDistrosForStats(iDistro,:) - ...
        simEventAmpDistro));
      rtDistancesSumSim(iDistro) = sum(abs(realEventRTDistrosForStats(iDistro,:) - ...
        simEventRTDistro));
    end
  end
  ampDistancesGrandSum = sum(ampDistancesSum,2,'omitnan');
  if match2mean
    bestAmpDistroDistances = reshape(ampDistancesSum, [1 numel(ampDistancesSum)]);
    worstAmpDistroDistances = reshape(ampDistancesSum, [1 numel(ampDistancesSum)]);
  else
    [~, bestAmpDistroInd] = min(ampDistancesGrandSum);
    bestAmpDistroDistances = ampDistancesSum(bestAmpDistroInd,:);
    [~, worstAmpDistroInd] = max(ampDistancesGrandSum);
    worstAmpDistroDistances = ampDistancesSum(worstAmpDistroInd,:);
  end
  rtDistancesGrandSum = sum(rtDistancesSum,2,'omitnan');
  if match2mean
    bestRTDistroDistances = reshape(rtDistancesSum, [1 numel(rtDistancesSum)]);
    worstRTDistroDistances = reshape(rtDistancesSum, [1 numel(rtDistancesSum)]);
  else
    [~, bestRTDistroInd] = min(rtDistancesGrandSum);
    bestRTDistroDistances = rtDistancesSum(bestRTDistroInd,:);
    [~, worstRTDistroInd] = max(rtDistancesGrandSum);
    worstRTDistroDistances = ampDistancesSum(worstRTDistroInd,:);
  end
  ampDistancesGrandSumSim = sum(ampDistancesSumSim,'omitnan');
  rtDistancesGrandSumSim = sum(rtDistancesSumSim,'omitnan');

  if parametric
    [~, pvalUnderfitTestAmp,~,stats] = ttest2(worstAmpDistroDistances', ampDistancesSumSim', 'Vartype','unequal');
    fUnderfitTestAmp = stats.tstat;
    dfUnderfitTestAmp = stats.df;
    if (ampDistancesGrandSumSim/numel(ampDistancesSumSim) > mean(worstAmpDistroDistances)) && pvalUnderfitTestAmp < 0.1
      underfitAmp = true;
    else
      underfitAmp = false;
    end
    [~, pvalOverfitTestAmp,~,stats] = ttest2(bestAmpDistroDistances', ampDistancesSumSim', 'Vartype','unequal');
    fOverfitTestAmp = stats.tstat;
    dfOverfitTestAmp = stats.df;
    if (ampDistancesGrandSumSim/numel(ampDistancesSumSim) < mean(bestAmpDistroDistances)) && pvalOverfitTestAmp < 0.1
      overfitAmp = true;
    else
      overfitAmp = false;
    end
  else
    [pvalUnderfitTestAmp,~,stats] = ranksum(ampDistancesSumSim', worstAmpDistroDistances', ...
      'tail','right', 'method','exact');
    fUnderfitTestAmp = stats.ranksum;
    if (ampDistancesGrandSumSim/numel(ampDistancesSumSim) > median(worstAmpDistroDistances)) && pvalUnderfitTestAmp < 0.05
      underfitAmp = true;
    else
      underfitAmp = false;
    end
    [pvalOverfitTestAmp,~,stats] = ranksum(ampDistancesSumSim', bestAmpDistroDistances', ...
      'tail','left', 'method','exact');
    fOverfitTestAmp = stats.ranksum;
    if (ampDistancesGrandSumSim/numel(ampDistancesSumSim) < median(bestAmpDistroDistances)) && pvalOverfitTestAmp < 0.05
      overfitAmp = true;
    else
      overfitAmp = false;
    end
  end
  %figure; qqplot(worstAmpDistroDistances);
  %figure; qqplot(bestAmpDistroDistances);
  %figure; qqplot(ampDistancesSumSim);
  
  if parametric
    [~, pvalUnderfitTestRT,~,stats] = ttest2(worstRTDistroDistances', rtDistancesSumSim', 'Vartype','unequal');
    fUnderfitTestRT = stats.tstat;
    dfUnderfitTestRT = stats.df;
    if (rtDistancesGrandSumSim/numel(rtDistancesSumSim) > mean(worstRTDistroDistances)) && pvalUnderfitTestRT < 0.1
      underfitRT = true;
    else
      underfitRT = false;
    end
    [~, pvalOverfitTestRT,~,stats] = ttest2(bestRTDistroDistances', rtDistancesSumSim', 'Vartype','unequal');
    fOverfitTestRT = stats.tstat;
    dfOverfitTestRT = stats.df;
    if (rtDistancesGrandSumSim/numel(rtDistancesSumSim) < mean(bestRTDistroDistances)) && pvalOverfitTestRT < 0.1
      overfitRT = true;
    else
      overfitRT = false;
    end
  else
    [pvalUnderfitTestRT,~,stats] = ranksum(rtDistancesSumSim', worstRTDistroDistances', ...
      'tail','right', 'method','exact');
    fUnderfitTestRT = stats.ranksum;
    if (rtDistancesGrandSumSim/numel(rtDistancesSumSim) > median(worstRTDistroDistances)) && pvalUnderfitTestRT < 0.05
      underfitRT = true;
    else
      underfitRT = false;
    end
    [pvalOverfitTestRT,~,stats] = ranksum(rtDistancesSumSim', bestRTDistroDistances', ...
      'tail','left', 'method','exact');
    fOverfitTestRT = stats.ranksum;
    if (rtDistancesGrandSumSim/numel(rtDistancesSumSim) < median(bestRTDistroDistances)) && pvalOverfitTestRT < 0.05
      overfitRT = true;
    else
      overfitRT = false;
    end
  end
  %figure; qqplot(worstRTDistroDistances);
  %figure; qqplot(bestRTDistroDistances);
  %figure; qqplot(rtDistancesSumSim);

  % Interpolate distributions
  bins = intermediateErrorBounds.classificationParameters.amplitudeArrayExt(2:end)-ampBinSize/2;
  ampBinsInterp = bins(1):ampBinSize/10:bins(end);
  simEventAmpDistroInterp = interp1(bins, simEventAmpDistro, ampBinsInterp, 'linear');
  smoothSpan = 5;
  simEventAmpDistroInterp = smooth(simEventAmpDistroInterp, smoothSpan);
  lowerAmpLimitInterp = interp1(bins, lowerAmpLimit, ampBinsInterp, 'linear');
  lowerAmpLimitInterp = smooth(lowerAmpLimitInterp, smoothSpan);
  upperAmpLimitInterp = interp1(bins, upperAmpLimit, ampBinsInterp, 'linear');
  upperAmpLimitInterp = smooth(upperAmpLimitInterp, smoothSpan);
  %targetAmpDistroInterp = interp1(bins, realEventAmpDistrosForStats(targetFileOrder,:), ampBinsInterp, 'linear');
  %targetAmpDistroInterp = smooth(targetAmpDistroInterp, smoothSpan);

  bins = intermediateErrorBounds.classificationParameters.riseTimeArrayExt(2:end)-rtBinSize/2;
  rtBinsInterp = bins(1):rtBinSize/10:bins(end);
  simEventRTDistroInterp = interp1(bins, simEventRTDistro, rtBinsInterp, 'linear');
  smoothSpan = 5;
  simEventRTDistroInterp = smooth(simEventRTDistroInterp, smoothSpan);
  lowerRTLimitInterp = interp1(bins, lowerRTLimit, rtBinsInterp, 'linear');
  lowerRTLimitInterp = smooth(lowerRTLimitInterp, smoothSpan);
  upperRTLimitInterp = interp1(bins, upperRTLimit, rtBinsInterp, 'linear');
  upperRTLimitInterp = smooth(upperRTLimitInterp, smoothSpan);
  %targetRTDistroInterp = interp1(bins, realEventRTDistrosForStats(targetFileOrder,:), rtBinsInterp, 'linear');
  %targetRTDistroInterp = smooth(targetRTDistroInterp, smoothSpan);

  % % Create a multipanelled figure comparing to the target distribution
  % fT = figure; tiledlayout(1,2, 'Padding','none', 'TileSpacing','tight')
  % set(fT, 'Color', [1, 1, 1]);
  % 
  % fontSize = 18;
  % 
  % ax1 = nexttile(1);
  % xLim = [0 250];
  % xLabel = 'Amplitude (\muV)';
  % yLabel = 'Count';
  % p1 = plot(ampBinsInterp.*1000, targetAmpDistroInterp, 'g', 'LineWidth',1.25); hold on
  % p2 = plot(ampBinsInterp.*1000, simEventAmpDistroInterp, 'b', 'LineWidth',1.25); hold off
  % xlim(xLim)
  % ylim([0 max([targetAmpDistroInterp; simEventAmpDistroInterp])+50])
  % 
  % xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
  % ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
  % 
  % set(ax1, 'box', 'off');
  % set(ax1, 'TickDir', 'out');
  % yTicks = get(ax1, 'YTick');
  % if numel(yTicks) > 8
  %   set(ax1, 'YTick', yTicks(1:2:end));
  % end
  % ax1.FontSize = fontSize - 4;
  % set(get(ax1, 'XAxis'), 'FontWeight','bold');
  % set(get(ax1, 'YAxis'), 'FontWeight','bold');
  % set(ax1,'linewidth',1.5);
  % 
  % legend([p2 p1], 'Fitted ''simulated'' distribution', '''Real'' distribution');
  % legend('boxoff');
  % 
  % xAxisSize = xLim(2) - xLim(1);
  % yLim = ylim;
  % yAxisSize = yLim(2) - yLim(1);
  % if yLim(2) < 1000
  %   text(-0.19*xAxisSize, yLim(2)-0.025*yAxisSize, 'A', 'FontSize',26, 'FontWeight','bold');
  % else
  %   text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'A', 'FontSize',26, 'FontWeight','bold');
  % end
  % 
  % ax2 = nexttile(2);
  % xLim = [0 10];
  % xLabel = '10-90% rise time (ms)';
  % yLabel = 'Count';
  % plot(rtBinsInterp, targetRTDistroInterp, 'g', 'LineWidth',1.25); hold on
  % plot(rtBinsInterp, simEventRTDistroInterp, 'b', 'LineWidth',1.25); hold off
  % xlim(xLim)
  % ylim([0 max([targetRTDistroInterp; simEventRTDistroInterp])+20])
  % 
  % xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
  % ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')
  % 
  % set(ax2, 'box', 'off');
  % set(ax2, 'TickDir', 'out');
  % yTicks = get(ax2, 'YTick');
  % if numel(yTicks) > 8
  %   set(ax2, 'YTick', yTicks(1:2:end));
  % end
  % ax2.FontSize = fontSize - 4;
  % set(get(ax2, 'XAxis'), 'FontWeight', 'bold');
  % set(get(ax2, 'YAxis'), 'FontWeight', 'bold');
  % set(ax2,'linewidth',1.5);
  % 
  % xAxisSize = xLim(2) - xLim(1);
  % yLim = ylim;
  % yAxisSize = yLim(2) - yLim(1);
  % text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'B', 'FontSize',26, 'FontWeight','bold');
  % 
  % % Adjust the size of the figure
  % set(fT, 'Position',[415 174 920 500]);
  % 
  % % Save the figure
  % figName = ['DistroFittingTargetFigures_' recIDs{iRec}];
  % if ~exist(figFolder, 'dir')
  %   mkdir(figFolder);
  % end
  % figName = fullfile(figFolder, figName);
  % savefig(fT, figName,'compact');
  % exportgraphics(fT,[figName, '.png'], 'Resolution',900);
  % exportgraphics(fT,[figName, '.pdf'], 'ContentType','vector');
  % close(fT);

  % Create the multipanelled figure with stats
  fT = figure; tiledlayout(1,2, 'Padding','none', 'TileSpacing','tight')
  set(fT, 'Color', [1, 1, 1]);

  fontSize = 18;

  ax1 = nexttile(1);
  xLim = [0 250];
  xLabel = 'Amplitude (\muV)';
  yLabel = 'Count';
  bins = intermediateErrorBounds.classificationParameters.amplitudeArrayExt(2:end)-ampBinSize/2;
  lowerAmpLimitInterp(lowerAmpLimitInterp < 0) = 0;
  lowerAmpLimitInterp2 = interp1(bins, lowerAmpLimit2, ampBinsInterp, 'linear');
  lowerAmpLimitInterp2 = smooth(lowerAmpLimitInterp2, smoothSpan);
  upperAmpLimitInterp2 = interp1(bins, upperAmpLimit2, ampBinsInterp, 'linear');
  upperAmpLimitInterp2 = smooth(upperAmpLimitInterp2, smoothSpan);
  if ci95plot
    c2 = ciplot(lowerAmpLimitInterp2, upperAmpLimitInterp2, ampBinsInterp.*1000, 'r', 0.4);
  else
    c2 = ciplot(lowerAmpLimitInterp2, upperAmpLimitInterp2, ampBinsInterp.*1000, 'y', 0.4);
  end
  hold on; c1 = ciplot(lowerAmpLimitInterp, upperAmpLimitInterp, ampBinsInterp.*1000, 'g', 0.3);
  p = plot(ampBinsInterp.*1000, simEventAmpDistroInterp, 'b', 'LineWidth',1.25); hold off
  xlim(xLim)
  ylim([0 max([upperAmpLimitInterp2; simEventAmpDistroInterp])+50])
  
  xAxisSize = diff(xlim);
  yAxisSize = diff(ylim);
  if parametric
    if underfitAmp
      txtStrUnder = ['Underfit Amp: F(' num2str(round(dfUnderfitTestAmp,1,'decimal')) ')=' ...
        num2str(round(fUnderfitTestAmp,2,'significant')) ...
        ', p=' num2str(round(pvalUnderfitTestAmp,2,'significant')) ' \uparrow'];
      tuAmp = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrUnder);
    elseif overfitAmp
      txtStrOver = ['Overfit Amp: F(' num2str(round(dfOverfitTestAmp,1,'decimal')) ')=' ...
        num2str(round(fOverfitTestAmp,2,'significant')) ...
        ', p=' num2str(round(pvalOverfitTestAmp,2,'significant')) ' \downarrow'];
      toAmp = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrOver);
    else
      if ampDistancesGrandSumSim/numel(ampDistancesSumSim) > mean(worstAmpDistroDistances)
        txtStrUnder = ['Fit Amp: F_{under}(' num2str(round(dfUnderfitTestAmp,1,'decimal')) ')=' ...
          num2str(round(fUnderfitTestAmp,2,'significant')) ...
          ', p=' num2str(round(pvalUnderfitTestAmp,2,'significant')) ' \uparrow'];
        tuAmp = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrUnder);
      else
        txtStrUnder = ['Fit Amp: F_{under}(' num2str(round(dfUnderfitTestAmp,1,'decimal')) ')=' ...
          num2str(round(fUnderfitTestAmp,2,'significant')) ...
          ', p=' num2str(round(pvalUnderfitTestAmp,2,'significant')) ' \downarrow'];
        tuAmp = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrUnder);
      end
      if ampDistancesGrandSumSim/numel(ampDistancesSumSim) < mean(bestAmpDistroDistances)
        txtStrOver = ['               F_{over}(' num2str(round(dfOverfitTestAmp,1,'decimal')) ')=' ...
          num2str(round(fOverfitTestAmp,2,'significant')) ...
          ', p=' num2str(round(pvalOverfitTestAmp,2,'significant')) ' \downarrow'];
        toAmp = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.85, txtStrOver);
      else
        txtStrOver = ['               F_{over}(' num2str(round(dfOverfitTestAmp,1,'decimal')) ')=' ...
          num2str(round(fOverfitTestAmp,2,'significant')) ...
          ', p=' num2str(round(pvalOverfitTestAmp,2,'significant')) ' \uparrow'];
        toAmp = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.85, txtStrOver);
      end
    end
  else
    if underfitAmp
      txtStrUnder = ['Underfit Amp: U=' num2str(round(fUnderfitTestAmp,1,'decimal')) ...
        ', p=' num2str(round(pvalUnderfitTestAmp,2,'significant')) ' \uparrow'];
      tuAmp = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrUnder);
    elseif overfitAmp
      txtStrOver = ['Overfit Amp: U=' num2str(round(fOverfitTestAmp,1,'decimal')) ...
        ', p=' num2str(round(pvalOverfitTestAmp,2,'significant')) ' \downarrow'];
      toAmp = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrOver);
    else
      if ampDistancesGrandSumSim/numel(ampDistancesSumSim) > median(worstAmpDistroDistances)
        txtStrUnder = ['Fit Amp: U_{under}=' num2str(round(fUnderfitTestAmp,1,'decimal')) ...
          ', p=' num2str(round(pvalUnderfitTestAmp,2,'significant')) ' \uparrow'];
        tuAmp = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrUnder);
      else
        txtStrUnder = ['Fit Amp: U_{under}=' num2str(round(fUnderfitTestAmp,1,'decimal')) ...
          ', p=' num2str(round(pvalUnderfitTestAmp,2,'significant')) ' \downarrow'];
        tuAmp = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrUnder);
      end
      if ampDistancesGrandSumSim/numel(ampDistancesSumSim) < median(bestAmpDistroDistances)
        txtStrOver = ['               U_{over}=' num2str(round(fOverfitTestAmp,1,'decimal')) ...
          ', p=' num2str(round(pvalOverfitTestAmp,2,'significant')) ' \downarrow'];
        toAmp = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.85, txtStrOver);
      else
        txtStrOver = ['               U_{over}=' num2str(round(fOverfitTestAmp,1,'decimal')) ...
          ', p=' num2str(round(pvalOverfitTestAmp,2,'significant')) ' \uparrow'];
        toAmp = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.85, txtStrOver);
      end
    end
  end

  xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
  ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')

  set(ax1, 'box', 'off');
  set(ax1, 'TickDir', 'out');
  yTicks = get(ax1, 'YTick');
  if numel(yTicks) > 8
    set(ax1, 'YTick', yTicks(1:2:end));
  end
  ax1.FontSize = fontSize - 4;
  set(get(ax1, 'XAxis'), 'FontWeight','bold');
  set(get(ax1, 'YAxis'), 'FontWeight','bold');
  set(ax1,'linewidth',1.5);

  xAxisSize = xLim(2) - xLim(1);
  yLim = ylim;
  yAxisSize = yLim(2) - yLim(1);
  if yLim(2) < 1000
    text(-0.19*xAxisSize, yLim(2)-0.025*yAxisSize, 'A', 'FontSize',26, 'FontWeight','bold');
  else
    text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'A', 'FontSize',26, 'FontWeight','bold');
  end

  if ci95plot
    legend([p c1 c2], {'Fitted ''simulated'' distribution', 'Range of ''real'' distributions', ...
      '95% CI on mean ''real'' distribution'}, 'Location','East');
  else
    legend([p c1 c2], {'Fitted ''simulated'' distribution', 'Range of ''real'' distributions', ...
      '3xRange of ''real'' distributions'}, 'Location','East');
  end
  legend('boxoff');

  ax2 = nexttile(2);
  xLim = [0 10];
  xLabel = '10-90% rise time (ms)';
  yLabel = 'Count';
  bins = intermediateErrorBounds.classificationParameters.riseTimeArrayExt(2:end)-rtBinSize/2;
  lowerRTLimitInterp(lowerRTLimitInterp < 0) = 0;
  lowerRTLimitInterp2 = interp1(bins, lowerRTLimit2, rtBinsInterp, 'linear');
  lowerRTLimitInterp2 = smooth(lowerRTLimitInterp2, smoothSpan);
  upperRTLimitInterp2 = interp1(bins, upperRTLimit2, rtBinsInterp, 'linear');
  upperRTLimitInterp2 = smooth(upperRTLimitInterp2, smoothSpan);
  if ci95plot
    ciplot(lowerRTLimitInterp2, upperRTLimitInterp2, rtBinsInterp, 'r', 0.4);
  else
    ciplot(lowerRTLimitInterp2, upperRTLimitInterp2, rtBinsInterp, 'y', 0.4);
  end
  hold on; ciplot(lowerRTLimitInterp, upperRTLimitInterp, rtBinsInterp, 'g', 0.3);
  plot(rtBinsInterp, simEventRTDistroInterp, 'b', 'LineWidth',1.25); hold off
  xlim(xLim)
  ylim([0 max([upperRTLimitInterp2; simEventRTDistroInterp])+20])

  xAxisSize = diff(xlim);
  yAxisSize = diff(ylim);
  if parametric
    if underfitRT
      txtStrUnder = ['Underfit RT: F(' num2str(round(dfUnderfitTestRT,1,'decimal')) ')=' ...
        num2str(round(fUnderfitTestRT,2,'significant')) ...
        ', p=' num2str(round(pvalUnderfitTestRT,2,'significant')) ' \uparrow'];
      tuRT = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrUnder);
    elseif overfitRT
      txtStrOver = ['Overfit RT: F(' num2str(round(dfOverfitTestRT,1,'decimal')) ')=' ...
        num2str(round(fOverfitTestRT,2,'significant')) ...
        ', p=' num2str(round(pvalOverfitTestRT,2,'significant')) ' \downarrow'];
      toRT = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrOver);
    else
      if rtDistancesGrandSumSim/numel(rtDistancesSumSim) > mean(worstRTDistroDistances)
        txtStrUnder = ['Fit RT: F_{under}(' num2str(round(dfUnderfitTestRT,1,'decimal')) ')=' ...
          num2str(round(fUnderfitTestRT,2,'significant')) ...
          ', p=' num2str(round(pvalUnderfitTestRT,2,'significant')) ' \uparrow'];
        tuRT = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrUnder);
      else
        txtStrUnder = ['Fit RT: F_{under}(' num2str(round(dfUnderfitTestRT,1,'decimal')) ')=' ...
          num2str(round(fUnderfitTestRT,2,'significant')) ...
          ', p=' num2str(round(pvalUnderfitTestRT,2,'significant')) ' \downarrow'];
        tuRT = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.95, txtStrUnder);
      end
      if rtDistancesGrandSumSim/numel(rtDistancesSumSim) < mean(bestRTDistroDistances)
        txtStrOver = ['            F_{over}(' num2str(round(dfOverfitTestRT,1,'decimal')) ')=' ...
          num2str(round(fOverfitTestRT,2,'significant')) ...
          ', p=' num2str(round(pvalOverfitTestRT,2,'significant')) ' \downarrow'];
        toRT = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.85, txtStrOver);
      else
        txtStrOver = ['            F_{over}(' num2str(round(dfOverfitTestRT,1,'decimal')) ')=' ...
          num2str(round(fOverfitTestRT,2,'significant')) ...
          ', p=' num2str(round(pvalOverfitTestRT,2,'significant')) ' \uparrow'];
        toRT = text(xLim(1)+xAxisSize*0.35, yAxisSize*0.85, txtStrOver);
      end
    end
  else
    if underfitRT
      txtStrUnder = ['Underfit RT: U=' num2str(round(fUnderfitTestRT,1,'decimal')) ...
        ', p=' num2str(round(pvalUnderfitTestRT,2,'significant')) ' \uparrow'];
      tuRT = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrUnder);
    elseif overfitRT
      txtStrOver = ['Overfit RT: U=' num2str(round(fOverfitTestRT,1,'decimal')) ...
        ', p=' num2str(round(pvalOverfitTestRT,2,'significant')) ' \downarrow'];
      toRT = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrOver);
    else
      if rtDistancesGrandSumSim/numel(rtDistancesSumSim) > median(worstRTDistroDistances)
        txtStrUnder = ['Fit RT: U_{under}=' ...
          num2str(round(fUnderfitTestRT,1,'decimal')) ...
          ', p=' num2str(round(pvalUnderfitTestRT,2,'significant')) ' \uparrow'];
        tuRT = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrUnder);
      else
        txtStrUnder = ['Fit RT: U_{under}=' num2str(round(fUnderfitTestRT,1,'decimal')) ...
          ', p=' num2str(round(pvalUnderfitTestRT,2,'significant')) ' \downarrow'];
        tuRT = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.95, txtStrUnder);
      end
      if rtDistancesGrandSumSim/numel(rtDistancesSumSim) < median(bestRTDistroDistances)
        txtStrOver = ['            U_{over}=' num2str(round(fOverfitTestRT,1,'decimal')) ...
          ', p=' num2str(round(pvalOverfitTestRT,2,'significant')) ' \downarrow'];
        toRT = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.85, txtStrOver);
      else
        txtStrOver = ['            U_{over}=' num2str(round(fOverfitTestRT,1,'decimal')) ...
          ', p=' num2str(round(pvalOverfitTestRT,2,'significant')) ' \uparrow'];
        toRT = text(xLim(1)+xAxisSize*0.45, yAxisSize*0.85, txtStrOver);
      end
    end
  end

  xlabel(xLabel, 'FontSize',fontSize, 'FontWeight','bold')
  ylabel(yLabel, 'FontSize',fontSize, 'FontWeight','bold')

  set(ax2, 'box', 'off');
  set(ax2, 'TickDir', 'out');
  yTicks = get(ax2, 'YTick');
  if numel(yTicks) > 8
    set(ax2, 'YTick', yTicks(1:2:end));
  end
  ax2.FontSize = fontSize - 4;
  set(get(ax2, 'XAxis'), 'FontWeight', 'bold');
  set(get(ax2, 'YAxis'), 'FontWeight', 'bold');
  set(ax2,'linewidth',1.5);

  xAxisSize = xLim(2) - xLim(1);
  yLim = ylim;
  yAxisSize = yLim(2) - yLim(1);
  text(-0.22*xAxisSize, yLim(2)-0.025*yAxisSize, 'B', 'FontSize',26, 'FontWeight','bold');

  % Adjust the size of the figure
  set(fT, 'Position',[415 174 920 500]);

  % Save the figure
  if normalise
    figName = ['DistroFittingStatsNormalisedFigures_' recIDs{iRec}];
  else
    figName = ['DistroFittingStatsFigures_' recIDs{iRec}];
  end
  if ~exist(figFolder, 'dir')
    mkdir(figFolder);
  end
  figName = fullfile(figFolder, figName);savefig(fT, figName,'compact'); % Stop here
  exportgraphics(fT,[figName, '.png'], 'Resolution',900);
  exportgraphics(fT,[figName, '.pdf'], 'ContentType','vector');
  close(fT);

  % Create real-real SAD matrices
  ampSADMatrix = nan(size(ampDistancesSum,1),size(ampDistancesSum,2)+2);
  rtSADMatrix = nan(size(ampDistancesSum,1),size(ampDistancesSum,2)+2);
  [~, ampSortOrder] = sort(median(ampDistancesSum,2),'descend');
  [~, rtSortOrder] = sort(median(rtDistancesSum,2),'descend');
  for iFile = 1:size(ampDistancesSum,1)
    if iFile == 1
      ampSADMatrix(iFile, 2:end) = [ampDistancesSum(ampSortOrder(iFile),:) median(ampDistancesSum(ampSortOrder(iFile),:))];
      rtSADMatrix(iFile, 2:end) = [rtDistancesSum(rtSortOrder(iFile),:) median(rtDistancesSum(rtSortOrder(iFile),:))];
    else
      ampSADMatrix(iFile, [1:iFile-1 iFile+1:size(ampDistancesSum,2)+2]) = ...
        [ampDistancesSum(ampSortOrder(iFile),:) median(ampDistancesSum(ampSortOrder(iFile),:))];
      rtSADMatrix(iFile, [1:iFile-1 iFile+1:size(rtDistancesSum,2)+2]) = ...
        [rtDistancesSum(rtSortOrder(iFile),:) median(rtDistancesSum(rtSortOrder(iFile),:))];
    end
  end
  ampSADMatrix = [round(triu(ampSADMatrix(:,1:end-1),1)' + triu(ampSADMatrix(:,1:end-1),1)) round(ampSADMatrix(:,end),1,'decimals')];
  rtSADMatrix = [round(triu(rtSADMatrix(:,1:end-1),1)' + triu(rtSADMatrix(:,1:end-1),1)) round(rtSADMatrix(:,end),1,'decimals')];

  % Display real-real SAD tables
  cellFormat = 'longG';
  cellWidth = 'fit';
  figAmp = uifigure;
  uitAmp = uitable(figAmp, 'Units','normalized', 'ColumnWidth',cellWidth, 'Data',ampSADMatrix);
  uitAmp.ColumnFormat = {};
  for iCol = 1:size(ampSADMatrix,2)
    uitAmp.ColumnFormat{numel(uitAmp.ColumnFormat)+1} = cellFormat;
  end

  figRT = uifigure;
  uitRT = uitable(figRT, 'Units','normalized', 'ColumnWidth',cellWidth, 'Data',rtSADMatrix);
  uitRT.ColumnFormat = {};
  for iCol = 1:size(rtSADMatrix,2)
    uitRT.ColumnFormat{numel(uitRT.ColumnFormat)+1} = cellFormat;
  end

  % Colour real-real SAD table cells
  maxAmpSAD = max([max(max(ampSADMatrix)) max(round(ampDistancesSumSim))]);
  maxRTSAD = max([max(max(rtSADMatrix)) max(round(rtDistancesSumSim))]);
  colourMap = parula(256);
  for iCell = 1:numel(ampSADMatrix)
    if isnan(ampSADMatrix(iCell))
      [row, col] = ind2sub(size(ampSADMatrix), iCell);
      addStyle(uitAmp, uistyle('FontColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitAmp, uistyle('BackgroundColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitAmp, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
      addStyle(uitRT, uistyle('FontColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitRT, uistyle('BackgroundColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitRT, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
    else
      [row, col] = ind2sub(size(ampSADMatrix), iCell);
      addStyle(uitAmp, uistyle('BackgroundColor', ...
        colourMap(max([1 ceil((256*ampSADMatrix(iCell))/maxAmpSAD)]),:)), 'cell', [row col]);
      addStyle(uitAmp, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
      addStyle(uitRT, uistyle('BackgroundColor', ...
        colourMap(max([1 ceil((256*rtSADMatrix(iCell))/maxRTSAD)]),:)), 'cell', [row col]);
      addStyle(uitRT, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
    end
  end

  % Save real-real SAD table figures
  figName = ['SAD_amplitude_sets_' recIDs{iRec}];
  if ~exist(figFolder, 'dir')
    mkdir(figFolder);
  end
  figName = fullfile(figFolder, figName);
  savefig(figAmp, figName,'compact');
  close(figAmp);

  figName = ['SAD_riseTime_sets_' recIDs{iRec}];
  if ~exist(figFolder, 'dir')
    mkdir(figFolder);
  end
  figName = fullfile(figFolder, figName);
  savefig(figRT, figName,'compact');
  close(figRT);

  % Create simulated-real SAD vectors
  ampSADMatrix = [round(ampDistancesSumSim) round(median(ampDistancesSumSim),1,'decimals')];
  rtSADMatrix = [round(rtDistancesSumSim) round(median(rtDistancesSumSim),1,'decimals')];

  % Display simulated-real SAD tables
  cellFormat = 'longG';
  cellWidth = 'fit';
  figAmp = uifigure;
  uitAmp = uitable(figAmp, 'Units','normalized', 'ColumnWidth',cellWidth, 'Data',ampSADMatrix);
  uitAmp.ColumnFormat = {};
  for iCol = 1:size(ampSADMatrix,2)
    uitAmp.ColumnFormat{numel(uitAmp.ColumnFormat)+1} = cellFormat;
  end

  figRT = uifigure;
  uitRT = uitable(figRT, 'Units','normalized', 'ColumnWidth',cellWidth, 'Data',rtSADMatrix);
  uitRT.ColumnFormat = {};
  for iCol = 1:size(rtSADMatrix,2)
    uitRT.ColumnFormat{numel(uitRT.ColumnFormat)+1} = cellFormat;
  end

  % Colour simulated-real SAD table cells
  for iCell = 1:numel(ampSADMatrix)
    if isnan(ampSADMatrix(iCell))
      [row, col] = ind2sub(size(ampSADMatrix), iCell);
      addStyle(uitAmp, uistyle('FontColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitAmp, uistyle('BackgroundColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitAmp, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
      addStyle(uitRT, uistyle('FontColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitRT, uistyle('BackgroundColor', [1 1 1]), 'cell', [row col]);
      addStyle(uitRT, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
    else
      [row, col] = ind2sub(size(ampSADMatrix), iCell);
      addStyle(uitAmp, uistyle('BackgroundColor', ...
        colourMap(max([1 ceil((256*ampSADMatrix(iCell))/maxAmpSAD)]),:)), 'cell', [row col]);
      addStyle(uitAmp, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
      addStyle(uitRT, uistyle('BackgroundColor', ...
        colourMap(max([1 ceil((256*rtSADMatrix(iCell))/maxRTSAD)]),:)), 'cell', [row col]);
      addStyle(uitRT, uistyle('HorizontalAlignment', 'center'), 'cell', [row col]);
    end
  end

  % Save simulated-real SAD table figures
  figName = ['SAD_amplitude_simSet_' recIDs{iRec}];
  if ~exist(figFolder, 'dir')
    mkdir(figFolder);
  end
  figName = fullfile(figFolder, figName);
  savefig(figAmp, figName,'compact');
  close(figAmp);

  figName = ['SAD_riseTime_simSet_' recIDs{iRec}];
  if ~exist(figFolder, 'dir')
    mkdir(figFolder);
  end
  figName = fullfile(figFolder, figName);
  savefig(figRT, figName,'compact');
  close(figRT);
end
disp(skewness);