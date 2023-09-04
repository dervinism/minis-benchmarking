function [outputFilename, performance] = evaluateMiniAnalysis(realDataBaseFilename, performanceDataBaseFilename, noiseFilename, excludedTimesNoise)


%% Load real event data
realData = load([realDataBaseFilename '.mat']);
dt = realData.dt;
filename = realData.filename;
excludedTimes = realData.excludedTimes;
detectionParameters = realData.detectionParameters;
simulationParameters = realData.simulationParameters;
optimisationParameters = realData.optimisationParameters;
classificationParameters = realData.classificationParameters;
filtering  = realData.filtering;
hitWindow = 10; % ms
noiseWindow = 20; % ms


%% Load noise data in case noise data is missing
if true %~isfield(realData, 'falseI') && ~isfield(realData, 'falseT')
    
    % Load the file:
    if nargin < 3
        error('noiseFilename input variable is not set.');
    else
        noiseProperties = loadABF(noiseFilename);
    end
    
    % Determine filtering mode:
    filtN.state = 'on';
    filtN.nSweeps = noiseProperties.hd.lActualEpisodes;
    if nargin < 4
        filtN.excludedTimes.startPulse = [0.2000 1.6500];
        filtN.excludedTimes.endPulse = [1.1000 2.2000];
        filtN.excludedTimes.startGlitch = [];
        filtN.excludedTimes.endGlitch = [];
        %error('excludedTimesNoise input variable is not set.');
    else
        filtN.excludedTimes = excludedTimesNoise;
    end
    
    % Filter the voltage trace:
    if strcmpi(filtN.state, 'on')
        %[noiseProperties.sweep, ~, f2] = filterMinis(noiseProperties.sweep, noiseProperties.dt, filtN, true);
        [noiseProperties.sweep, ~, f2] = filterMinis(noiseProperties.sweep, noiseProperties.dt, filtN, true, [], {'50, 150'});
        close(f2);
    end
    
    noiseProperties.baseline = length(realData.classificationParameters.amplitudeArray);
    
    % Detect noise events
    detectionParametersSim = realData.detectionParameters;
    detectionParametersSim.sampleInterval = noiseProperties.dt;
    detectionParametersSim.smoothWindow = round(detectionParametersSim.smoothWindow/detectionParametersSim.sampleInterval);
    waveform.estimate = false;
    filtN.state = 'spectrum';
    options.summaryPlot = false;
    options.edit = false;
    [~, ~, ~, ~, ~, noiseV] = detectMinis(noiseProperties.sweep, excludedTimes, detectionParametersSim, filtN, waveform, 1, options);
    % excludedInds = zeros(size(noiseProperties.sweep));
    % excludedInds(round(excludedTimes(excludedTimes > 0)./noiseProperties.dt)) = 1;
    % noiseSD = std(noiseV(~logical(excludedInds)));
    minPeakWidth = 0.5/noiseProperties.dt;
    minPeakAmp = 0.01;
    % [~, falseI] = findpeaks(noiseV, 'MinPeakWidth',minPeakWidth, 'MinPeakProminence',minPeakAmp);
    filtNoiseV = movmean(noiseV,noiseWindow/noiseProperties.dt);
    [~, falseI] = findpeaks(filtNoiseV, 'MinPeakWidth',minPeakWidth, 'MinPeakProminence',minPeakAmp);
    [~, adjustedFalseI] = max(noiseV(falseI - noiseWindow/2 + 1 : falseI + noiseWindow/2));
    falseI = falseI - noiseWindow/2 + adjustedFalseI;
    falseT = falseI.*dt;
    falseI(logical(ismember(round(falseT./dt),round((excludedTimes+dt)./dt)))) = [];
    falseT(logical(ismember(round(falseT./dt),round((excludedTimes+dt)./dt)))) = [];
else
    falseI = realData.falseI; %#ok<*UNRCH>
    falseT = realData.falseT;
end


%% Initialise output variables
d = dir([performanceDataBaseFilename '*.csv']);
nRuns = numel(d);
sensitivity = cell(nRuns,1);
specificity = cell(nRuns,1);
FPR = cell(nRuns,1);
dPrime = cell(nRuns,1);
performance = cell(nRuns,1);


%% Evaluate Mini Analysis performance
for iRun = 1:nRuns
    
    % Get real data for a particular simulation instance
    allTrue = realData.performance{iRun}(1,:);
    trueI = find(allTrue);
    trueT = trueI.*dt;
    
    % Calculate the time to the nearest neighbour
    distanceToTheRight = abs([trueT(2:end) inf] - trueT);
    distanceToTheLeft = abs([inf trueT(1:end-1)] - trueT);
    distance2neighbour{iRun} = min([distanceToTheRight; distanceToTheLeft],[],1); %#ok<*NASGU>
    
    % Get detection data for a particular simulation instance
    filename = d(iRun).name;
    opts = detectImportOptions([d(iRun).folder filesep filename]);
    opts.DataLines = [2,Inf];
    opts.VariableTypes(1, 1:end) = {'char'};
    data = readtable([d(iRun).folder filesep filename], opts);
    try
        positivesT = data.('Time_ms_'); %#ok<*FNDSB>
    catch
        positivesT = data.('Var2');
    end
    if iscell(positivesT)
        for iCell = 1:numel(positivesT)
            positivesT{iCell} = str2double(strrep(positivesT{iCell},',',''));
        end
        positivesT = cell2mat(positivesT)';
    elseif ~isnumeric(positivesT)
        error('positivesT variable is of unsupported type');
    else
        positivesT = positivesT';
    end
    positivesT(isnan(positivesT)) = [];
    positivesI = round(positivesT./dt);
    excludedI = round(excludedTimes./dt);
    positivesT(ismember(positivesI, excludedI)) = [];
    positivesI(ismember(positivesI, excludedI)) = [];
    
    % Associate detected events with true and false events
    positivesAssociated2true = zeros(size(positivesI));
    positivesAssociated2false = zeros(size(positivesI));
    for iPositive = 1:numel(positivesI)
        trueDist = abs(trueT - positivesT(iPositive));
        [~, nearestTrueI] = min(trueDist);
        positivesAssociated2true(iPositive) = trueI(nearestTrueI);
        falseDist = abs(falseT - positivesT(iPositive));
        [~, nearestFalseI] = min(falseDist);
        positivesAssociated2false(iPositive) = falseI(nearestFalseI);
    end
    
    % Locate hits and misses
    truePositives = zeros(1,numel(allTrue));
    falseNegatives = zeros(1,numel(allTrue));
    for iMini = 1:numel(trueI)
        detectedPositivesT = positivesT(trueI(iMini) == positivesAssociated2true);
        detectedPositivesI = positivesI(trueI(iMini) == positivesAssociated2true);
        if ~isempty(detectedPositivesT)
            detectedPositivesDist = abs(detectedPositivesT - trueT(iMini));
            [minDist, minDistI] = min(detectedPositivesDist);
            if minDist <= hitWindow/2
                truePositives(detectedPositivesI(minDistI)) = 1;
            else
                falseNegatives(trueI(iMini)) = 1;
            end
        else
            falseNegatives(trueI(iMini)) = 1;
        end
    end
    
    % Locate false alarms
    falsePositives = zeros(1,numel(allTrue));
    falsePositives(positivesI) = 1;
    falsePositives(logical(truePositives)) = 0;
    
    % Locate correct rejections
    positivesAssociated2false(logical(ismember(positivesI, find(truePositives)))) = [];
    trueNegatives = zeros(1,numel(allTrue));
    trueNegatives(falseI) = 1;
    for iMini = 1:numel(falseI)
        iPositivesAssociated2false = positivesAssociated2false(falseI(iMini) == positivesAssociated2false);
        tPositivesAssociated2false = falseT(ismember(falseI, iPositivesAssociated2false));
        if ~isempty(tPositivesAssociated2false)
            detectedPositivesDist = abs(tPositivesAssociated2false - positivesT);
            minDist = min(detectedPositivesDist);
            if minDist <= hitWindow/2
                trueNegatives(falseI(iMini)) = 0;
            end
        end
    end
    trueNegatives(logical(falseNegatives) | logical(truePositives) | logical(falsePositives)) = 0; % just as an insurance
    
    % Calculate performance measures
    sensitivity{iRun} = sum(truePositives)/(sum(truePositives) + sum(falseNegatives)); %#ok<*AGROW,*PFOUS> % True positive rate
    specificity{iRun} = sum(trueNegatives)/(sum(trueNegatives) + sum(falsePositives)); % Correct rejection rate
    FPR{iRun} = sum(falsePositives)/(sum(trueNegatives) + sum(falsePositives)); % False positive rate
    if sensitivity{iRun} == 1
        sensitivityApprox = 1-(1e-6);
    else
        sensitivityApprox = sensitivity{iRun};
    end
    if FPR{iRun} == 0
        FPRapprox = 1e-6;
    else
        FPRapprox = FPR{iRun};
    end
    dPrime{iRun} = dprime_simple(sensitivityApprox, FPRapprox);
    
    allTrue = zeros(1,numel(allTrue));
    allTrue(trueI) = 1;
    allTrue2 = zeros(1,numel(allTrue));
    allTrue2(logical(truePositives) | logical(falseNegatives)) = 1;
    allPositive = zeros(1,numel(allTrue));
    allPositive(positivesI) = 1;
    performance{iRun} = sparse([allTrue; allTrue2; allPositive; truePositives; falseNegatives; falsePositives; trueNegatives]);
    % simulated event positions; hits (detected positions) + misses; hits (detected positions) + false alarms;
    % hits (detected positions); misses; false alarms; correct rejections
    
%     time = (1:numel(smoothV)).*dt;
%     figure; plot(time, smoothV); hold on;
%     plot(time(falseI), smoothV(falseI), '.r', 'MarkerSize',10);
%     plot(time(trueI), smoothV(trueI), '.g', 'MarkerSize',10);
%     plot(time(logical(truePositives)), smoothV(logical(truePositives)), 'og', 'MarkerSize',10);
%     plot(time(logical(falsePositives)), smoothV(logical(falsePositives)), 'oy', 'MarkerSize',10);
%     plot(time(logical(trueNegatives)), smoothV(logical(trueNegatives)), 'or', 'MarkerSize',10);
%     plot(time(logical(falseNegatives)), smoothV(logical(falseNegatives)), 'ob', 'MarkerSize',10);
%     legend('V_m','False events','True events','True positive','False positive','Correct rejection','False rejection');
end


%% Save pClamp performance data
[outputDir, fileName] = fileparts(performanceDataBaseFilename);
outputFilename = [outputDir filesep fileName '_MiniAnalysis.mat'];
% save(outputFilename, 'sensitivity','specificity','FPR','dPrime','performance','falseI','falseT','dt',...
%     'filename','excludedTimes','detectionParameters','simulationParameters','optimisationParameters',...
%     'classificationParameters','filtering','distance2neighbour', '-v7.3');
save(outputFilename, 'sensitivity','specificity','FPR','dPrime','performance','falseI','falseT','dt',...
    'filename','excludedTimes','detectionParameters','simulationParameters','optimisationParameters',...
    'classificationParameters','filtering', '-v7.3');