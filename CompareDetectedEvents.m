%% Parameters
% I/O
dataFolder = 'C:\Users\44079\Phd\Paper3\Benchmarking_data\amplitude0.3';
dataFolderReal = 'C:\Users\44079\Phd\Paper3\Benchmarking_data\real_data';
recs = {'p103a','p106b','p108a','p108b','p108c','p120b','p122a','p124b','p125a', ...
  'p127c','p128c','p129a','p131a','p131c'};
simDetectionType1Files = 'algorithm_performance_data__amp0p3_sAmp0p05';
simDetectionType2Files = 'algorithm_performance_data__amp0p3_sAmp1e_09';
dataSubfolder1.minis = 'txt_minis1';
dataSubfolder1.MiniAnalysis = 'csv_MiniAnalysis';
dataSubfolder1.pClamp = 'csv_pClamp_raw2';
dataSubfolder2.minis = 'txt_minis2';
dataSubfolder2.MiniAnalysis = 'csv_MiniAnalysis';
dataSubfolder2.pClamp = 'csv_pClamp_raw2';
dataSubfolderReal.minis = 'minis';
dataSubfolderReal.MiniAnalysis = 'MiniAnalysis';
dataSubfolderReal.pClamp = 'pClamp';

% Half-width to exponential decay conversion factor
half2expConversionFactor = 1/0.69315;

% Frequency conditions
highFreqMinis = {'4000', '8000', '16000', '32000', '64000', '128000'};
lowFreqMinis = '500';
realFreqMinis = {'500', '1000', '2000'};

% Detection conditions
detectionConditions = {'Type 1 All'; 'Type 1 High Freq'; 'Type 1 Low Freq'; ...
                       'Type 1 Real Freq'; 'Type 2 Real Freq'; 'Real'};

% Excluded times and excluded time durations per sweep
excludedSweepTimes = {[0.05 1.10; 1.65 2.20];  % p103a
                      [0.25 0.90; 1.60 2.20];  % p106b
                      [0.50 1.15; 1.85 2.40];  % p108a
                      [0.50 1.25; 1.85 2.40];  % p108b
                      [0.50 1.20; 1.85 2.40];  % p108c
                      [0.50 1.20; 1.85 2.40];  % p120b
                      [0.50 1.25; 1.85 2.40];  % p122a
                      [0.50 1.15; 1.85 2.40];  % p124b
                      [0.50 1.20; 1.85 2.40];  % p125a
                      [0.50 1.20; 1.85 2.40];  % p127c
                      [0.50 1.20; 1.85 2.40];  % p128c
                      [0.50 1.20; 1.85 2.40];  % p129a
                      [0.50 2.25; 2.85 3.40];  % p131a
                      [0.50 1.00; 2.90 3.40]}; % p131c
excludedTimeDurations = zeros(1, numel(excludedSweepTimes));
for iRec = 1:numel(excludedSweepTimes)
  excludedTimeDurations(iRec) = (excludedSweepTimes{iRec}(1,2) - excludedSweepTimes{iRec}(1,1)) + (excludedSweepTimes{iRec}(2,2) - excludedSweepTimes{iRec}(2,1));
end

% End times of simulated files for each recording
endTimes = [repmat(200, 1, 2), repmat(100, 1, 12)];

% Number of sweeps per simulated file for each recording
nSweeps = [repmat(50, 1, 2), repmat(5, 1, 12)];

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

% Number of simulated files per condition
nFiles = 4;

% Number of simulation conditions for the two experiments
nConditions = [14 3];

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

% Excluded times for simulated files for each recording
excludedTimes = {};
for iRec = 1:numel(excludedSweepTimes)
  excludedTimes{iRec} = excludedSweepTimes{iRec};
  for iSweep = 2:nSweeps(iRec)
    excludedTimes{iRec} = [excludedTimes{iRec}; ...
      excludedSweepTimes{iRec} + sweepDurations(iRec)*(iSweep-1)];
  end
end

% Number of sweeps per real files for each recording
nSweepsReal = {[repmat(10, 1, 17) 9 10 10 10 4 5 10 10 9 repmat(10, 1, 14) 9 repmat(10, 1, 6) 50 50 50]; % p103a
              [repmat(10, 1, 11) 9 repmat(10, 1, 5)];                                                    % p106b
              [2 4 4 5];                                                                                 % p108a
              [6 9 4 5 7];                                                                               % p108b
              [repmat(5, 1, 6) 6];                                                                       % p108c
              [5 5 7 6 4 5 6];                                                                           % p120b
              [10 8 9 5 5 6];                                                                            % p122a
              repmat(5, 1, 7);                                                                           % p124b
              [7 6 7 2 5 3];                                                                             % p125a
              [10 5 5 5 8];                                                                              % p127c
              [2 7 5 4 5 4];                                                                             % p128c
              [10 5 5 6];                                                                                % p129a
              [10 9 5 1 1];                                                                              % p131a
              repmat(5, 1, 8)};                                                                          % p131c
nFilesRealpClamp = nSweepsReal;

% Sum duration of all real files for each recording
durationsReal = zeros(1, numel(excludedSweepTimes));
for iRec = 1:numel(excludedSweepTimes)
  durationsReal(iRec) = sum(nSweepsReal{iRec}.*(sweepDurations(iRec) - excludedTimeDurations(iRec)));
end
durationsRealpClamp = durationsReal;

% Excluded times for all real files for each recording
excludedTimesReal = {};
for iRec = 1:numel(excludedSweepTimes)
  for iFile = 1:numel(nSweepsReal{iRec})
    excludedTimesReal{iRec}{iFile} = excludedSweepTimes{iRec}; %#ok<*SAGROW> 
    for iSweep = 2:nSweepsReal{iRec}(iFile)
      excludedTimesReal{iRec}{iFile} = [excludedTimesReal{iRec}{iFile}; ...
        excludedSweepTimes{iRec} + sweepDurations(iRec)*(iSweep-1)];
    end
  end
end

% End times for all real files for each recording
endTimesReal = {};
for iRec = 1:numel(excludedSweepTimes)
  endTimesReal{iRec} = nSweepsReal{iRec}.*sweepDurations(iRec);
end


%% Containers
% Extract info about detected events by the three algorithms
% Data aggregate containers
simulatedDetectionType1All.minis.data = [];
simulatedDetectionType1All.MiniAnalysis.data = [];
simulatedDetectionType1All.pClamp.data = [];
simulatedDetectionType1HighFreq.minis.data = [];
simulatedDetectionType1HighFreq.MiniAnalysis.data = [];
simulatedDetectionType1HighFreq.pClamp.data = [];
simulatedDetectionType1LowFreq.minis.data = [];
simulatedDetectionType1LowFreq.MiniAnalysis.data = [];
simulatedDetectionType1LowFreq.pClamp.data = [];
simulatedDetectionType1RealFreq.minis.data = [];
simulatedDetectionType1RealFreq.MiniAnalysis.data = [];
simulatedDetectionType1RealFreq.pClamp.data = [];
simulatedDetectionType2.minis.data = [];
simulatedDetectionType2.MiniAnalysis.data = [];
simulatedDetectionType2.pClamp.data = [];
realDetection.minis.data = [];
realDetection.MiniAnalysis.data = [];
realDetection.pClamp.data = [];


%% simulatedDetectionType1All
% Type 1 simulation: minis across all conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.minis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt')
      T = readtable(detectionFile);
      simulatedDetectionType1All.minis.data = [simulatedDetectionType1All.minis.data; ...
        [ones(size(T,1),1)*iRec T.Amplitude T.x10_90_RT T.decayTime T.tau]];
    end
  end
end

% Type 1 simulation: MiniAnalysis across all conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.MiniAnalysis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv')
      T = readtable(detectionFile);
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      try
        times = cellfun(@str2double, T.Time_ms_)./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        T = T(inds2include,:);
        simulatedDetectionType1All.MiniAnalysis.data = [simulatedDetectionType1All.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        times = cellfun(@str2double, T.Var2(2:end))./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        inds2include = inds2include + 1;
        T = T(inds2include,:);
        simulatedDetectionType1All.MiniAnalysis.data = [simulatedDetectionType1All.MiniAnalysis.data; ...
          [ones(size(T,1)-1,1)*iRec T.Var3(2:end) T.Var11(2:end) T.Var5(2:end)]];
      end
    end
  end
end

% Type 1 simulation: pClamp across all conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.pClamp);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv')
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      T = readtable(detectionFile);
      times = T.Var5./1000;
      [~, inds2include] = selectArrayValues(times, includedTimesRec);
      T = T(inds2include,:);
      RTs = NaN(size(T,1),1);
      for rt = 1:numel(RTs)
        if iscell(T.Var25)
          if ~strcmpi(T.Var25{rt}, 'Not found')
            RTs(rt) = str2double(T.Var25{rt})*half2expConversionFactor;
          end
        else
          RTs = T.Var25.*half2expConversionFactor;
        end
      end
      simulatedDetectionType1All.pClamp.data = [simulatedDetectionType1All.pClamp.data; ...
        [ones(size(T,1),1)*iRec T.Var8 RTs T.Var17]];
    end
  end
end


%% simulatedDetectionType1HighFreq
% Type 1 simulation: minis across high frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.minis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt') && ...
        contains(detectionFile, highFreqMinis) && contains(detectionFile, 'noiseScaleFactor1')
      T = readtable(detectionFile);
      simulatedDetectionType1HighFreq.minis.data = [simulatedDetectionType1HighFreq.minis.data; ...
        [ones(size(T,1),1)*iRec T.Amplitude T.x10_90_RT T.decayTime T.tau]];
    end
  end
end

% Type 1 simulation: MiniAnalysis across high frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.MiniAnalysis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv') && ...
        contains(detectionFile, highFreqMinis) && contains(detectionFile, 'noiseScaleFactor1')
      T = readtable(detectionFile);
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      try
        times = cellfun(@str2double, T.Time_ms_)./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        T = T(inds2include,:);
        simulatedDetectionType1HighFreq.MiniAnalysis.data = [simulatedDetectionType1HighFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        times = cellfun(@str2double, T.Var2(2:end))./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        inds2include = inds2include + 1;
        T = T(inds2include,:);
        simulatedDetectionType1HighFreq.MiniAnalysis.data = [simulatedDetectionType1HighFreq.MiniAnalysis.data; ...
          [ones(size(T,1)-1,1)*iRec T.Var3(2:end) T.Var11(2:end) T.Var5(2:end)]];
      end
    end
  end
end

% Type 1 simulation: pClamp across high frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.pClamp);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv') && ...
        contains(detectionFile, highFreqMinis) && contains(detectionFile, 'noiseScaleFactor1')
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      T = readtable(detectionFile);
      times = T.Var5./1000;
      [~, inds2include] = selectArrayValues(times, includedTimesRec);
      T = T(inds2include,:);
      RTs = NaN(size(T,1),1);
      for rt = 1:numel(RTs)
        if iscell(T.Var25)
          if ~strcmpi(T.Var25{rt}, 'Not found')
            RTs(rt) = str2double(T.Var25{rt})*half2expConversionFactor;
          end
        else
          RTs = T.Var25.*half2expConversionFactor;
        end
      end
      simulatedDetectionType1HighFreq.pClamp.data = [simulatedDetectionType1HighFreq.pClamp.data; ...
        [ones(size(T,1),1)*iRec T.Var8 RTs T.Var17]];
    end
  end
end


%% simulatedDetectionType1LowFreq
% Type 1 simulation: minis across low frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.minis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt') && contains(detectionFile, lowFreqMinis)
      T = readtable(detectionFile);
      simulatedDetectionType1LowFreq.minis.data = [simulatedDetectionType1LowFreq.minis.data; ...
        [ones(size(T,1),1)*iRec T.Amplitude T.x10_90_RT T.decayTime T.tau]];
    end
  end
end

% Type 1 simulation: MiniAnalysis across low frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.MiniAnalysis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv') && ...
        contains(detectionFile, lowFreqMinis)
      T = readtable(detectionFile);
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      try
        times = cellfun(@str2double, T.Time_ms_)./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        T = T(inds2include,:);
        simulatedDetectionType1LowFreq.MiniAnalysis.data = [simulatedDetectionType1LowFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        times = cellfun(@str2double, T.Var2(2:end))./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        inds2include = inds2include + 1;
        T = T(inds2include,:);
        simulatedDetectionType1LowFreq.MiniAnalysis.data = [simulatedDetectionType1LowFreq.MiniAnalysis.data; ...
          [ones(size(T,1)-1,1)*iRec T.Var3(2:end) T.Var11(2:end) T.Var5(2:end)]];
      end
    end
  end
end

% Type 1 simulation: pClamp across low frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.pClamp);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv') && ...
        contains(detectionFile, lowFreqMinis)
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      T = readtable(detectionFile);
      times = T.Var5./1000;
      [~, inds2include] = selectArrayValues(times, includedTimesRec);
      T = T(inds2include,:);
      RTs = NaN(size(T,1),1);
      for rt = 1:numel(RTs)
        if iscell(T.Var25)
          if ~strcmpi(T.Var25{rt}, 'Not found')
            RTs(rt) = str2double(T.Var25{rt})*half2expConversionFactor;
          end
        else
          RTs = T.Var25.*half2expConversionFactor;
        end
      end
      simulatedDetectionType1LowFreq.pClamp.data = [simulatedDetectionType1LowFreq.pClamp.data; ...
        [ones(size(T,1),1)*iRec T.Var8 RTs T.Var17]];
    end
  end
end


%% simulatedDetectionType1RealFreq
% Type 1 simulation: minis across realistic frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.minis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt') && ...
        contains(detectionFile, realFreqMinis) && contains(detectionFile, 'noiseScaleFactor1')
      T = readtable(detectionFile);
      simulatedDetectionType1RealFreq.minis.data = [simulatedDetectionType1RealFreq.minis.data; ...
        [ones(size(T,1),1)*iRec T.Amplitude T.x10_90_RT T.decayTime T.tau]];
    end
  end
end

% Type 1 simulation: MiniAnalysis across realistic frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.MiniAnalysis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv') && ...
        contains(detectionFile, realFreqMinis) && contains(detectionFile, 'noiseScaleFactor1')
      T = readtable(detectionFile);
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      try
        times = cellfun(@str2double, T.Time_ms_)./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        T = T(inds2include,:);
        simulatedDetectionType1RealFreq.MiniAnalysis.data = [simulatedDetectionType1RealFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        times = cellfun(@str2double, T.Var2(2:end))./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        inds2include = inds2include + 1;
        T = T(inds2include,:);
        simulatedDetectionType1RealFreq.MiniAnalysis.data = [simulatedDetectionType1RealFreq.MiniAnalysis.data; ...
          [ones(size(T,1)-1,1)*iRec T.Var3(2:end) T.Var11(2:end) T.Var5(2:end)]];
      end
    end
  end
end

% Type 1 simulation: pClamp across realistic frequency conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder1.pClamp);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType1Files) && endsWith(detectionFile, '.csv') && ...
        contains(detectionFile, realFreqMinis) && contains(detectionFile, 'noiseScaleFactor1')
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      T = readtable(detectionFile);
      times = T.Var5./1000;
      [~, inds2include] = selectArrayValues(times, includedTimesRec);
      T = T(inds2include,:);
      RTs = NaN(size(T,1),1);
      for rt = 1:numel(RTs)
        if iscell(T.Var25)
          if ~strcmpi(T.Var25{rt}, 'Not found')
            RTs(rt) = str2double(T.Var25{rt})*half2expConversionFactor;
          end
        else
          RTs = T.Var25.*half2expConversionFactor;
        end
      end
      simulatedDetectionType1RealFreq.pClamp.data = [simulatedDetectionType1RealFreq.pClamp.data; ...
        [ones(size(T,1),1)*iRec T.Var8 RTs T.Var17]];
    end
  end
end


%% simulatedDetectionType2
% Type 2 simulation: minis across realistic frequency and amplitude conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder2.minis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt')
      T = readtable(detectionFile);
      simulatedDetectionType2.minis.data = [simulatedDetectionType2.minis.data; ...
        [ones(size(T,1),1)*iRec T.Amplitude T.x10_90_RT T.decayTime T.tau]];
    end
  end
end

% Type 2 simulation: MiniAnalysis across realistic frequency and amplitude conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder2.MiniAnalysis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType2Files) && endsWith(detectionFile, '.csv')
      T = readtable(detectionFile);
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      try
        times = cellfun(@str2double, T.Time_ms_)./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        T = T(inds2include,:);
        simulatedDetectionType2.MiniAnalysis.data = [simulatedDetectionType2.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        times = cellfun(@str2double, T.Var2(2:end))./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        inds2include = inds2include + 1;
        T = T(inds2include,:);
        simulatedDetectionType2.MiniAnalysis.data = [simulatedDetectionType2.MiniAnalysis.data; ...
          [ones(size(T,1)-1,1)*iRec T.Var3(2:end) T.Var11(2:end) T.Var5(2:end)]];
      end
    end
  end
end

% Type 2 simulation: pClamp across realistic frequency and amplitude conditions
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolder, recs{iRec}, dataSubfolder2.pClamp);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if startsWith(files(iFile).name, simDetectionType2Files) && endsWith(detectionFile, '.csv')
      includedTimesRec = invertIntervals(excludedTimes{iRec}, endTimes(iRec));
      T = readtable(detectionFile);
      times = T.Var5./1000;
      [~, inds2include] = selectArrayValues(times, includedTimesRec);
      T = T(inds2include,:);
      RTs = NaN(size(T,1),1);
      for rt = 1:numel(RTs)
        if iscell(T.Var25)
          if ~strcmpi(T.Var25{rt}, 'Not found')
            RTs(rt) = str2double(T.Var25{rt})*half2expConversionFactor;
          end
        else
          RTs = T.Var25.*half2expConversionFactor;
        end
      end
      simulatedDetectionType2.pClamp.data = [simulatedDetectionType2.pClamp.data; ...
        [ones(size(T,1),1)*iRec T.Var8 RTs T.Var17]];
    end
  end
end


%% Real data detection
% minis
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolderReal, recs{iRec}, dataSubfolderReal.minis);
  files = dir(detectionFolder);
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.txt')
      T = readtable(detectionFile);
      realDetection.minis.data = [realDetection.minis.data; ...
        [ones(size(T,1),1)*iRec T.Amplitude T.x10_90_RT T.decayTime T.tau]];
    end
  end
end

% MiniAnalysis
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolderReal, recs{iRec}, dataSubfolderReal.MiniAnalysis);
  files = dir(detectionFolder);
  fileCounter = 0;
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.csv')
      fileCounter = fileCounter + 1;
      includedTimesRec = invertIntervals(excludedTimesReal{iRec}{fileCounter}, endTimesReal{iRec}(fileCounter));
      T = readtable(detectionFile);
      try
        times = cellfun(@str2double, T.Time_ms_)./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        T = T(inds2include,:);
        simulatedDetectionType2.MiniAnalysis.data = [simulatedDetectionType2.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        times = cellfun(@str2double, T.Var2(2:end))./1000;
        [~, inds2include] = selectArrayValues(times, includedTimesRec);
        inds2include = inds2include + 1;
        T = T(inds2include,:);
        realDetection.MiniAnalysis.data = [realDetection.MiniAnalysis.data; ...
          [ones(size(T,1)-1,1)*iRec T.Var3(2:end) T.Var11(2:end) T.Var5(2:end)]];
      end
    end
  end
end

% pClamp
for iRec = 1:numel(recs)
  detectionFolder = fullfile(dataFolderReal, recs{iRec}, dataSubfolderReal.pClamp);
  files = dir(detectionFolder);
  fileCounter = 0;
  for iFile = 1:numel(files)
    detectionFile = fullfile(detectionFolder, files(iFile).name);
    if endsWith(detectionFile, '.csv')
      fileCounter = fileCounter + 1;
      includedTimesRec = invertIntervals(excludedTimesReal{iRec}{fileCounter}, endTimesReal{iRec}(fileCounter));
      T = readtable(detectionFile);
      times = T.Var5./1000;
      ISIs = diff(times);
      missingPeriodSum = sum(floor(ISIs(ISIs>1)));
      durationsRealpClamp(iRec) = durationsRealpClamp(iRec) - missingPeriodSum;
      [~, inds2include] = selectArrayValues(times, includedTimesRec);
      T = T(inds2include,:);
      RTs = NaN(size(T,1),1);
      for rt = 1:numel(RTs)
        if iscell(T.Var25)
          if ~strcmpi(T.Var25{rt}, 'Not found')
            RTs(rt) = str2double(T.Var25{rt})*half2expConversionFactor;
          end
        else
          RTs = T.Var25.*half2expConversionFactor;
        end
      end
      realDetection.pClamp.data = [realDetection.pClamp.data; ...
        [ones(size(T,1),1)*iRec T.Var8 RTs T.Var17]];
    end
  end
end


%% Calculate detected event means and incidence rates
% Means
simulatedDetectionType1All.minis.means = zeros(numel(recs), size(simulatedDetectionType1All.minis.data,2)-1);
simulatedDetectionType1All.MiniAnalysis.means = zeros(numel(recs), size(simulatedDetectionType1All.MiniAnalysis.data,2)-1);
simulatedDetectionType1All.pClamp.means = zeros(numel(recs), size(simulatedDetectionType1All.pClamp.data,2)-1);
simulatedDetectionType1HighFreq.minis.means = zeros(numel(recs), size(simulatedDetectionType1HighFreq.minis.data,2)-1);
simulatedDetectionType1HighFreq.MiniAnalysis.means = zeros(numel(recs), size(simulatedDetectionType1HighFreq.MiniAnalysis.data,2)-1);
simulatedDetectionType1HighFreq.pClamp.means = zeros(numel(recs), size(simulatedDetectionType1HighFreq.pClamp.data,2)-1);
simulatedDetectionType1LowFreq.minis.means = zeros(numel(recs), size(simulatedDetectionType1LowFreq.minis.data,2)-1);
simulatedDetectionType1LowFreq.MiniAnalysis.means = zeros(numel(recs), size(simulatedDetectionType1LowFreq.MiniAnalysis.data,2)-1);
simulatedDetectionType1LowFreq.pClamp.means = zeros(numel(recs), size(simulatedDetectionType1LowFreq.pClamp.data,2)-1);
simulatedDetectionType1RealFreq.minis.means = zeros(numel(recs), size(simulatedDetectionType1RealFreq.minis.data,2)-1);
simulatedDetectionType1RealFreq.MiniAnalysis.means = zeros(numel(recs), size(simulatedDetectionType1RealFreq.MiniAnalysis.data,2)-1);
simulatedDetectionType1RealFreq.pClamp.means = zeros(numel(recs), size(simulatedDetectionType1RealFreq.pClamp.data,2)-1);
simulatedDetectionType2.minis.means = zeros(numel(recs), size(simulatedDetectionType2.minis.data,2)-1);
simulatedDetectionType2.MiniAnalysis.means = zeros(numel(recs), size(simulatedDetectionType2.MiniAnalysis.data,2)-1);
simulatedDetectionType2.pClamp.means = zeros(numel(recs), size(simulatedDetectionType2.pClamp.data,2)-1);
realDetection.minis.means = zeros(numel(recs), size(realDetection.minis.data,2)-1);
realDetection.MiniAnalysis.means = zeros(numel(recs), size(realDetection.MiniAnalysis.data,2)-1);
realDetection.pClamp.means = zeros(numel(recs), size(realDetection.pClamp.data,2)-1);

for iRec = 1:numel(recs)
  inds = simulatedDetectionType1All.minis.data(:,1) == iRec & simulatedDetectionType1All.minis.data(:,2) > 0 & ...
    simulatedDetectionType1All.minis.data(:,3) > 0;
  simulatedDetectionType1All.minis.means(iRec,:) = mean(simulatedDetectionType1All.minis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1All.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1All.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1All.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1All.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1All.MiniAnalysis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1All.pClamp.data(:,1) == iRec & simulatedDetectionType1All.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1All.pClamp.data(:,3) > 0;
  simulatedDetectionType1All.pClamp.means(iRec,:) = mean(simulatedDetectionType1All.pClamp.data(inds,2:end), 'omitnan');

  inds = simulatedDetectionType1HighFreq.minis.data(:,1) == iRec & simulatedDetectionType1HighFreq.minis.data(:,2) > 0 & ...
    simulatedDetectionType1HighFreq.minis.data(:,3) > 0;
  simulatedDetectionType1HighFreq.minis.means(iRec,:) = mean(simulatedDetectionType1HighFreq.minis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1HighFreq.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1HighFreq.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1HighFreq.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1HighFreq.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1HighFreq.MiniAnalysis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1HighFreq.pClamp.data(:,1) == iRec & simulatedDetectionType1HighFreq.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1HighFreq.pClamp.data(:,3) > 0;
  simulatedDetectionType1HighFreq.pClamp.means(iRec,:) = mean(simulatedDetectionType1HighFreq.pClamp.data(inds,2:end), 'omitnan');

  inds = simulatedDetectionType1LowFreq.minis.data(:,1) == iRec & simulatedDetectionType1LowFreq.minis.data(:,2) > 0 & ...
    simulatedDetectionType1LowFreq.minis.data(:,3) > 0;
  simulatedDetectionType1LowFreq.minis.means(iRec,:) = mean(simulatedDetectionType1LowFreq.minis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1LowFreq.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1LowFreq.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1LowFreq.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1LowFreq.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1LowFreq.MiniAnalysis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1LowFreq.pClamp.data(:,1) == iRec & simulatedDetectionType1LowFreq.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1LowFreq.pClamp.data(:,3) > 0;
  simulatedDetectionType1LowFreq.pClamp.means(iRec,:) = mean(simulatedDetectionType1LowFreq.pClamp.data(inds,2:end), 'omitnan');

  inds = simulatedDetectionType1RealFreq.minis.data(:,1) == iRec & simulatedDetectionType1RealFreq.minis.data(:,2) > 0 & ...
    simulatedDetectionType1RealFreq.minis.data(:,3) > 0;
  simulatedDetectionType1RealFreq.minis.means(iRec,:) = mean(simulatedDetectionType1RealFreq.minis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1RealFreq.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1RealFreq.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1RealFreq.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1RealFreq.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1RealFreq.MiniAnalysis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType1RealFreq.pClamp.data(:,1) == iRec & simulatedDetectionType1RealFreq.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1RealFreq.pClamp.data(:,3) > 0;
  simulatedDetectionType1RealFreq.pClamp.means(iRec,:) = mean(simulatedDetectionType1RealFreq.pClamp.data(inds,2:end), 'omitnan');

  inds = simulatedDetectionType2.minis.data(:,1) == iRec & simulatedDetectionType2.minis.data(:,2) > 0 & ...
    simulatedDetectionType2.minis.data(:,3) > 0;
  simulatedDetectionType2.minis.means(iRec,:) = mean(simulatedDetectionType2.minis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType2.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType2.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType2.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType2.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType2.MiniAnalysis.data(inds,2:end), 'omitnan');
  inds = simulatedDetectionType2.pClamp.data(:,1) == iRec & simulatedDetectionType2.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType2.pClamp.data(:,3) > 0;
  simulatedDetectionType2.pClamp.means(iRec,:) = mean(simulatedDetectionType2.pClamp.data(inds,2:end), 'omitnan');

  inds = realDetection.minis.data(:,1) == iRec & realDetection.minis.data(:,2) > 0 & ...
    realDetection.minis.data(:,3) > 0;
  realDetection.minis.means(iRec,:) = mean(realDetection.minis.data(inds,2:end), 'omitnan');
  inds = realDetection.MiniAnalysis.data(:,1) == iRec & realDetection.MiniAnalysis.data(:,2) > 0 & ...
    realDetection.MiniAnalysis.data(:,3) > 0;
  realDetection.MiniAnalysis.means(iRec,:) = mean(realDetection.MiniAnalysis.data(inds,2:end), 'omitnan');
  inds = realDetection.pClamp.data(:,1) == iRec & realDetection.pClamp.data(:,2) > 0 & ...
    realDetection.pClamp.data(:,3) > 0;
  realDetection.pClamp.means(iRec,:) = mean(realDetection.pClamp.data(inds,2:end), 'omitnan');
end

[simulatedDetectionType1All.minis.overallMean, simulatedDetectionType1All.minis.overallMeanCI] = datamean(simulatedDetectionType1All.minis.means);
[simulatedDetectionType1All.MiniAnalysis.overallMean, simulatedDetectionType1All.MiniAnalysis.overallMeanCI] = datamean(simulatedDetectionType1All.MiniAnalysis.means);
[simulatedDetectionType1All.pClamp.overallMean, simulatedDetectionType1All.pClamp.overallMeanCI] = datamean(simulatedDetectionType1All.pClamp.means);
[simulatedDetectionType1HighFreq.minis.overallMean, simulatedDetectionType1HighFreq.minis.overallMeanCI] = datamean(simulatedDetectionType1HighFreq.minis.means);
[simulatedDetectionType1HighFreq.MiniAnalysis.overallMean, simulatedDetectionType1HighFreq.MiniAnalysis.overallMeanCI] = datamean(simulatedDetectionType1HighFreq.MiniAnalysis.means);
[simulatedDetectionType1HighFreq.pClamp.overallMean, simulatedDetectionType1HighFreq.pClamp.overallMeanCI] = datamean(simulatedDetectionType1HighFreq.pClamp.means);
[simulatedDetectionType1LowFreq.minis.overallMean, simulatedDetectionType1LowFreq.minis.overallMeanCI] = datamean(simulatedDetectionType1LowFreq.minis.means);
[simulatedDetectionType1LowFreq.MiniAnalysis.overallMean, simulatedDetectionType1LowFreq.MiniAnalysis.overallMeanCI] = datamean(simulatedDetectionType1LowFreq.MiniAnalysis.means);
[simulatedDetectionType1LowFreq.pClamp.overallMean, simulatedDetectionType1LowFreq.pClamp.overallMeanCI] = datamean(simulatedDetectionType1LowFreq.pClamp.means);
[simulatedDetectionType1RealFreq.minis.overallMean, simulatedDetectionType1RealFreq.minis.overallMeanCI] = datamean(simulatedDetectionType1RealFreq.minis.means);
[simulatedDetectionType1RealFreq.MiniAnalysis.overallMean, simulatedDetectionType1RealFreq.MiniAnalysis.overallMeanCI] = datamean(simulatedDetectionType1RealFreq.MiniAnalysis.means);
[simulatedDetectionType1RealFreq.pClamp.overallMean, simulatedDetectionType1RealFreq.pClamp.overallMeanCI] = datamean(simulatedDetectionType1RealFreq.pClamp.means);
[simulatedDetectionType2.minis.overallMean, simulatedDetectionType2.minis.overallMeanCI] = datamean(simulatedDetectionType2.minis.means);
[simulatedDetectionType2.MiniAnalysis.overallMean, simulatedDetectionType2.MiniAnalysis.overallMeanCI] = datamean(simulatedDetectionType2.MiniAnalysis.means);
[simulatedDetectionType2.pClamp.overallMean, simulatedDetectionType2.pClamp.overallMeanCI] = datamean(simulatedDetectionType2.pClamp.means);
[realDetection.minis.overallMean, realDetection.minis.overallMeanCI] = datamean(realDetection.minis.means);
[realDetection.MiniAnalysis.overallMean, realDetection.MiniAnalysis.overallMeanCI] = datamean(realDetection.MiniAnalysis.means);
[realDetection.pClamp.overallMean, realDetection.pClamp.overallMeanCI] = datamean(realDetection.pClamp.means);

% Incidence rates
simulatedDetectionType1All.minis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1All.MiniAnalysis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1All.pClamp.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1HighFreq.minis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1HighFreq.MiniAnalysis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1HighFreq.pClamp.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1LowFreq.minis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1LowFreq.MiniAnalysis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1LowFreq.pClamp.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1RealFreq.minis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1RealFreq.MiniAnalysis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType1RealFreq.pClamp.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType2.minis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType2.MiniAnalysis.incidenceRates = zeros(numel(recs),1);
simulatedDetectionType2.pClamp.incidenceRates = zeros(numel(recs),1);
realDetection.minis.incidenceRates = zeros(numel(recs),1);
realDetection.MiniAnalysis.incidenceRates = zeros(numel(recs),1);
realDetection.pClamp.incidenceRates = zeros(numel(recs),1);

for iRec = 1:numel(recs)
  inds = simulatedDetectionType1All.minis.data(:,1) == iRec & simulatedDetectionType1All.minis.data(:,2) > 0 & ...
    simulatedDetectionType1All.minis.data(:,3) > 0;
  simulatedDetectionType1All.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(1));
  inds = simulatedDetectionType1All.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1All.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1All.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1All.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(1));
  inds = simulatedDetectionType1All.pClamp.data(:,1) == iRec & simulatedDetectionType1All.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1All.pClamp.data(:,3) > 0;
  simulatedDetectionType1All.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(1));

  inds = simulatedDetectionType1HighFreq.minis.data(:,1) == iRec & simulatedDetectionType1HighFreq.minis.data(:,2) > 0 & ...
    simulatedDetectionType1HighFreq.minis.data(:,3) > 0;
  simulatedDetectionType1HighFreq.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(highFreqMinis));
  inds = simulatedDetectionType1HighFreq.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1HighFreq.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1HighFreq.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1HighFreq.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(highFreqMinis));
  inds = simulatedDetectionType1HighFreq.pClamp.data(:,1) == iRec & simulatedDetectionType1HighFreq.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1HighFreq.pClamp.data(:,3) > 0;
  simulatedDetectionType1HighFreq.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(highFreqMinis));

  inds = simulatedDetectionType1LowFreq.minis.data(:,1) == iRec & simulatedDetectionType1LowFreq.minis.data(:,2) > 0 & ...
    simulatedDetectionType1LowFreq.minis.data(:,3) > 0;
  simulatedDetectionType1LowFreq.minis.incidenceRates(iRec) = ...
    sum(inds)/(durations(iRec)*4*(nConditions(1)-numel(highFreqMinis)-numel(realFreqMinis)));
  inds = simulatedDetectionType1LowFreq.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1LowFreq.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1LowFreq.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1LowFreq.MiniAnalysis.incidenceRates(iRec) = ...
    sum(inds)/(durations(iRec)*4*(nConditions(1)-numel(highFreqMinis)-numel(realFreqMinis)));
  inds = simulatedDetectionType1LowFreq.pClamp.data(:,1) == iRec & simulatedDetectionType1LowFreq.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1LowFreq.pClamp.data(:,3) > 0;
  simulatedDetectionType1LowFreq.pClamp.incidenceRates(iRec) = ...
    sum(inds)/(durations(iRec)*4*(nConditions(1)-numel(highFreqMinis)-numel(realFreqMinis)));

  inds = simulatedDetectionType1RealFreq.minis.data(:,1) == iRec & simulatedDetectionType1RealFreq.minis.data(:,2) > 0 & ...
    simulatedDetectionType1RealFreq.minis.data(:,3) > 0;
  simulatedDetectionType1RealFreq.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(realFreqMinis));
  inds = simulatedDetectionType1RealFreq.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType1RealFreq.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType1RealFreq.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType1RealFreq.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(realFreqMinis));
  inds = simulatedDetectionType1RealFreq.pClamp.data(:,1) == iRec & simulatedDetectionType1RealFreq.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType1RealFreq.pClamp.data(:,3) > 0;
  simulatedDetectionType1RealFreq.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(realFreqMinis));

  inds = simulatedDetectionType2.minis.data(:,1) == iRec & simulatedDetectionType2.minis.data(:,2) > 0 & ...
    simulatedDetectionType2.minis.data(:,3) > 0;
  simulatedDetectionType2.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(2));
  inds = simulatedDetectionType2.MiniAnalysis.data(:,1) == iRec & simulatedDetectionType2.MiniAnalysis.data(:,2) > 0 & ...
    simulatedDetectionType2.MiniAnalysis.data(:,3) > 0;
  simulatedDetectionType2.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(2));
  inds = simulatedDetectionType2.pClamp.data(:,1) == iRec & simulatedDetectionType2.pClamp.data(:,2) > 0 & ...
    simulatedDetectionType2.pClamp.data(:,3) > 0;
  simulatedDetectionType2.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(2));

  inds = realDetection.minis.data(:,1) == iRec & realDetection.minis.data(:,2) > 0 & ...
    realDetection.minis.data(:,3) > 0;
  realDetection.minis.incidenceRates(iRec) = sum(inds)/(durationsReal(iRec));
  inds = realDetection.MiniAnalysis.data(:,1) == iRec & realDetection.MiniAnalysis.data(:,2) > 0 & ...
    realDetection.MiniAnalysis.data(:,3) > 0;
  realDetection.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durationsReal(iRec));
  inds = realDetection.pClamp.data(:,1) == iRec & realDetection.pClamp.data(:,2) > 0 & ...
    realDetection.pClamp.data(:,3) > 0;
  realDetection.pClamp.incidenceRates(iRec) = sum(inds)/(durationsRealpClamp(iRec));
end

[simulatedDetectionType1All.minis.meanIncidenceRate, simulatedDetectionType1All.minis.meanIncidenceRateCI] = datamean(simulatedDetectionType1All.minis.incidenceRates);
[simulatedDetectionType1All.MiniAnalysis.meanIncidenceRate, simulatedDetectionType1All.MiniAnalysis.meanIncidenceRateCI] = datamean(simulatedDetectionType1All.MiniAnalysis.incidenceRates);
[simulatedDetectionType1All.pClamp.meanIncidenceRate, simulatedDetectionType1All.pClamp.meanIncidenceRateCI] = datamean(simulatedDetectionType1All.pClamp.incidenceRates);
[simulatedDetectionType1HighFreq.minis.meanIncidenceRate, simulatedDetectionType1HighFreq.minis.meanIncidenceRateCI] = datamean(simulatedDetectionType1HighFreq.minis.incidenceRates);
[simulatedDetectionType1HighFreq.MiniAnalysis.meanIncidenceRate, simulatedDetectionType1HighFreq.MiniAnalysis.meanIncidenceRateCI] = datamean(simulatedDetectionType1HighFreq.MiniAnalysis.incidenceRates);
[simulatedDetectionType1HighFreq.pClamp.meanIncidenceRate, simulatedDetectionType1HighFreq.pClamp.meanIncidenceRateCI] = datamean(simulatedDetectionType1HighFreq.pClamp.incidenceRates);
[simulatedDetectionType1LowFreq.minis.meanIncidenceRate, simulatedDetectionType1LowFreq.minis.meanIncidenceRateCI] = datamean(simulatedDetectionType1LowFreq.minis.incidenceRates);
[simulatedDetectionType1LowFreq.MiniAnalysis.meanIncidenceRate, simulatedDetectionType1LowFreq.MiniAnalysis.meanIncidenceRateCI] = datamean(simulatedDetectionType1LowFreq.MiniAnalysis.incidenceRates);
[simulatedDetectionType1LowFreq.pClamp.meanIncidenceRate, simulatedDetectionType1LowFreq.pClamp.meanIncidenceRateCI] = datamean(simulatedDetectionType1LowFreq.pClamp.incidenceRates);
[simulatedDetectionType1RealFreq.minis.meanIncidenceRate, simulatedDetectionType1RealFreq.minis.meanIncidenceRateCI] = datamean(simulatedDetectionType1RealFreq.minis.incidenceRates);
[simulatedDetectionType1RealFreq.MiniAnalysis.meanIncidenceRate, simulatedDetectionType1RealFreq.MiniAnalysis.meanIncidenceRateCI] = datamean(simulatedDetectionType1RealFreq.MiniAnalysis.incidenceRates);
[simulatedDetectionType1RealFreq.pClamp.meanIncidenceRate, simulatedDetectionType1RealFreq.pClamp.meanIncidenceRateCI] = datamean(simulatedDetectionType1RealFreq.pClamp.incidenceRates);
[simulatedDetectionType2.minis.meanIncidenceRate, simulatedDetectionType2.minis.meanIncidenceRateCI] = datamean(simulatedDetectionType2.minis.incidenceRates);
[simulatedDetectionType2.MiniAnalysis.meanIncidenceRate, simulatedDetectionType2.MiniAnalysis.meanIncidenceRateCI] = datamean(simulatedDetectionType2.MiniAnalysis.incidenceRates);
[simulatedDetectionType2.pClamp.meanIncidenceRate, simulatedDetectionType2.pClamp.meanIncidenceRateCI] = datamean(simulatedDetectionType2.pClamp.incidenceRates);
[realDetection.minis.meanIncidenceRate, realDetection.minis.meanIncidenceRateCI] = datamean(realDetection.minis.incidenceRates);
[realDetection.MiniAnalysis.meanIncidenceRate, realDetection.MiniAnalysis.meanIncidenceRateCI] = datamean(realDetection.MiniAnalysis.incidenceRates);
[realDetection.pClamp.meanIncidenceRate, realDetection.pClamp.meanIncidenceRateCI] = datamean(realDetection.pClamp.incidenceRates);


%% Analysis results tables
% Amplitudes
true_amplitudes = [0.3 0.3 0.3 0.3 mean(0.05:0.05:0.6) NaN]';
minis_amplitudes = [simulatedDetectionType1All.minis.overallMean(1) ...
                    simulatedDetectionType1HighFreq.minis.overallMean(1) ...
                    simulatedDetectionType1LowFreq.minis.overallMean(1) ...
                    simulatedDetectionType1RealFreq.minis.overallMean(1) ...
                    simulatedDetectionType2.minis.overallMean(1) ...
                    realDetection.minis.overallMean(1)]';
minis_amplitude_95CI = [simulatedDetectionType1All.minis.overallMeanCI(2,1) ...
                        simulatedDetectionType1HighFreq.minis.overallMeanCI(2,1) ...
                        simulatedDetectionType1LowFreq.minis.overallMeanCI(2,1) ...
                        simulatedDetectionType1RealFreq.minis.overallMeanCI(2,1) ...
                        simulatedDetectionType2.minis.overallMeanCI(2,1) ...
                        realDetection.minis.overallMeanCI(2,1)]';
MiniAnalysis_amplitudes = [simulatedDetectionType1All.MiniAnalysis.overallMean(1) ...
                           simulatedDetectionType1HighFreq.MiniAnalysis.overallMean(1) ...
                           simulatedDetectionType1LowFreq.MiniAnalysis.overallMean(1) ...
                           simulatedDetectionType1RealFreq.MiniAnalysis.overallMean(1) ...
                           simulatedDetectionType2.MiniAnalysis.overallMean(1) ...
                           realDetection.MiniAnalysis.overallMean(1)]';
MiniAnalysis_amplitude_95CI = [simulatedDetectionType1All.MiniAnalysis.overallMeanCI(2,1) ...
                               simulatedDetectionType1HighFreq.MiniAnalysis.overallMeanCI(2,1) ...
                               simulatedDetectionType1LowFreq.MiniAnalysis.overallMeanCI(2,1) ...
                               simulatedDetectionType1RealFreq.MiniAnalysis.overallMeanCI(2,1) ...
                               simulatedDetectionType2.MiniAnalysis.overallMeanCI(2,1) ...
                               realDetection.MiniAnalysis.overallMeanCI(2,1)]';
pClamp_amplitudes = [simulatedDetectionType1All.pClamp.overallMean(1) ...
                     simulatedDetectionType1HighFreq.pClamp.overallMean(1) ...
                     simulatedDetectionType1LowFreq.pClamp.overallMean(1) ...
                     simulatedDetectionType1RealFreq.pClamp.overallMean(1) ...
                     simulatedDetectionType2.pClamp.overallMean(1) ...
                     realDetection.pClamp.overallMean(1)]';
pClamp_amplitude_95CI = [simulatedDetectionType1All.pClamp.overallMeanCI(2,1) ...
                         simulatedDetectionType1HighFreq.pClamp.overallMeanCI(2,1) ...
                         simulatedDetectionType1LowFreq.pClamp.overallMeanCI(2,1) ...
                         simulatedDetectionType1RealFreq.pClamp.overallMeanCI(2,1) ...
                         simulatedDetectionType2.pClamp.overallMeanCI(2,1) ...
                         realDetection.pClamp.overallMeanCI(2,1)]';

amplitudesTable = table(detectionConditions, true_amplitudes, ...
                        minis_amplitudes, minis_amplitude_95CI, ...
                        MiniAnalysis_amplitudes, MiniAnalysis_amplitude_95CI, ...
                        pClamp_amplitudes, pClamp_amplitude_95CI)

% 10-90% rise times
%RTs = .5:.25:11;
%counts = normpdf(RTs,0.5,2.5);
%counts(1) = counts(1)/2;
%meanRT = sum(RTs.*counts)/sum(counts);
%true_RTs = [repmat(meanRT, 1, 5) NaN]';
true_RTs = [repmat(2.6, 1, 5) NaN]';
minis_RTs = [simulatedDetectionType1All.minis.overallMean(2) ...
             simulatedDetectionType1HighFreq.minis.overallMean(2) ...
             simulatedDetectionType1LowFreq.minis.overallMean(2) ...
             simulatedDetectionType1RealFreq.minis.overallMean(2) ...
             simulatedDetectionType2.minis.overallMean(2) ...
             realDetection.minis.overallMean(2)]';
minis_RT_95CI = [simulatedDetectionType1All.minis.overallMeanCI(2,2) ...
                 simulatedDetectionType1HighFreq.minis.overallMeanCI(2,2) ...
                 simulatedDetectionType1LowFreq.minis.overallMeanCI(2,2) ...
                 simulatedDetectionType1RealFreq.minis.overallMeanCI(2,2) ...
                 simulatedDetectionType2.minis.overallMeanCI(2,2) ...
                 realDetection.minis.overallMeanCI(2,2)]';
MiniAnalysis_RTs = [simulatedDetectionType1All.MiniAnalysis.overallMean(2) ...
                    simulatedDetectionType1HighFreq.MiniAnalysis.overallMean(2) ...
                    simulatedDetectionType1LowFreq.MiniAnalysis.overallMean(2) ...
                    simulatedDetectionType1RealFreq.MiniAnalysis.overallMean(2) ...
                    simulatedDetectionType2.MiniAnalysis.overallMean(2) ...
                    realDetection.MiniAnalysis.overallMean(2)]';
MiniAnalysis_RT_95CI = [simulatedDetectionType1All.MiniAnalysis.overallMeanCI(2,2) ...
                        simulatedDetectionType1HighFreq.MiniAnalysis.overallMeanCI(2,2) ...
                        simulatedDetectionType1LowFreq.MiniAnalysis.overallMeanCI(2,2) ...
                        simulatedDetectionType1RealFreq.MiniAnalysis.overallMeanCI(2,2) ...
                        simulatedDetectionType2.MiniAnalysis.overallMeanCI(2,2) ...
                        realDetection.MiniAnalysis.overallMeanCI(2,2)]';
pClamp_RTs = [simulatedDetectionType1All.pClamp.overallMean(2) ...
              simulatedDetectionType1HighFreq.pClamp.overallMean(2) ...
              simulatedDetectionType1LowFreq.pClamp.overallMean(2) ...
              simulatedDetectionType1RealFreq.pClamp.overallMean(2) ...
              simulatedDetectionType2.pClamp.overallMean(2) ...
              realDetection.pClamp.overallMean(2)]';
pClamp_RT_95CI = [simulatedDetectionType1All.pClamp.overallMeanCI(2,2) ...
                  simulatedDetectionType1HighFreq.pClamp.overallMeanCI(2,2) ...
                  simulatedDetectionType1LowFreq.pClamp.overallMeanCI(2,2) ...
                  simulatedDetectionType1RealFreq.pClamp.overallMeanCI(2,2) ...
                  simulatedDetectionType2.pClamp.overallMeanCI(2,2) ...
                  realDetection.pClamp.overallMeanCI(2,2)]';

riseTimesTable = table(detectionConditions, true_RTs, ...
                       minis_RTs, minis_amplitude_95CI, ...
                       MiniAnalysis_RTs, MiniAnalysis_amplitude_95CI, ...
                       pClamp_RTs, pClamp_amplitude_95CI)

% Decay times
simTau_m = [13.5288 12.4926 8.95132 10.9887 9.99453 9.06286 10.3236 9.3484 ...
            7.54192 8.32906 10.0965 13.8749 13.395 14.3358]';
[trueDecay, trueDecay95CI] = datamean(simTau_m);
true_decays = [repmat(trueDecay, 1, 6)]';
true_decay_95CI = [repmat(trueDecay95CI(2), 1, 6)]';
minisDecayType = 4;
minis_fitted_decays = [simulatedDetectionType1All.minis.overallMean(minisDecayType) ...
                       simulatedDetectionType1HighFreq.minis.overallMean(minisDecayType) ...
                       simulatedDetectionType1LowFreq.minis.overallMean(minisDecayType) ...
                       simulatedDetectionType1RealFreq.minis.overallMean(minisDecayType) ...
                       simulatedDetectionType2.minis.overallMean(minisDecayType) ...
                       realDetection.minis.overallMean(minisDecayType)]';
minis_fitted_decay_95CI = [simulatedDetectionType1All.minis.overallMeanCI(2,minisDecayType) ...
                           simulatedDetectionType1HighFreq.minis.overallMeanCI(2,minisDecayType) ...
                           simulatedDetectionType1LowFreq.minis.overallMeanCI(2,minisDecayType) ...
                           simulatedDetectionType1RealFreq.minis.overallMeanCI(2,minisDecayType) ...
                           simulatedDetectionType2.minis.overallMeanCI(2,minisDecayType) ...
                           realDetection.minis.overallMeanCI(2,minisDecayType)]';
minisDecayType = 3;
minis_effective_decays = [simulatedDetectionType1All.minis.overallMean(minisDecayType) ...
                          simulatedDetectionType1HighFreq.minis.overallMean(minisDecayType) ...
                          simulatedDetectionType1LowFreq.minis.overallMean(minisDecayType) ...
                          simulatedDetectionType1RealFreq.minis.overallMean(minisDecayType) ...
                          simulatedDetectionType2.minis.overallMean(minisDecayType) ...
                          realDetection.minis.overallMean(minisDecayType)]';
minis_effective_decay_95CI = [simulatedDetectionType1All.minis.overallMeanCI(2,minisDecayType) ...
                              simulatedDetectionType1HighFreq.minis.overallMeanCI(2,minisDecayType) ...
                              simulatedDetectionType1LowFreq.minis.overallMeanCI(2,minisDecayType) ...
                              simulatedDetectionType1RealFreq.minis.overallMeanCI(2,minisDecayType) ...
                              simulatedDetectionType2.minis.overallMeanCI(2,minisDecayType) ...
                              realDetection.minis.overallMeanCI(2,minisDecayType)]';
minis_averaged_decays = (minis_fitted_decays + minis_effective_decays)/2;
minis_averaged_decay_95CI = (minis_fitted_decay_95CI + minis_effective_decay_95CI)/2;
MiniAnalysis_decays = [simulatedDetectionType1All.MiniAnalysis.overallMean(3) ...
                       simulatedDetectionType1HighFreq.MiniAnalysis.overallMean(3) ...
                       simulatedDetectionType1LowFreq.MiniAnalysis.overallMean(3) ...
                       simulatedDetectionType1RealFreq.MiniAnalysis.overallMean(3) ...
                       simulatedDetectionType2.MiniAnalysis.overallMean(3) ...
                       realDetection.MiniAnalysis.overallMean(3)]';
MiniAnalysis_decay_95CI = [simulatedDetectionType1All.MiniAnalysis.overallMeanCI(2,3) ...
                           simulatedDetectionType1HighFreq.MiniAnalysis.overallMeanCI(2,3) ...
                           simulatedDetectionType1LowFreq.MiniAnalysis.overallMeanCI(2,3) ...
                           simulatedDetectionType1RealFreq.MiniAnalysis.overallMeanCI(2,3) ...
                           simulatedDetectionType2.MiniAnalysis.overallMeanCI(2,3) ...
                           realDetection.MiniAnalysis.overallMeanCI(2,3)]';
pClamp_decays = [simulatedDetectionType1All.pClamp.overallMean(3) ...
                 simulatedDetectionType1HighFreq.pClamp.overallMean(3) ...
                 simulatedDetectionType1LowFreq.pClamp.overallMean(3) ...
                 simulatedDetectionType1RealFreq.pClamp.overallMean(3) ...
                 simulatedDetectionType2.pClamp.overallMean(3) ...
                 realDetection.pClamp.overallMean(3)]';
pClamp_decay_95CI = [simulatedDetectionType1All.pClamp.overallMeanCI(2,3) ...
                     simulatedDetectionType1HighFreq.pClamp.overallMeanCI(2,3) ...
                     simulatedDetectionType1LowFreq.pClamp.overallMeanCI(2,3) ...
                     simulatedDetectionType1RealFreq.pClamp.overallMeanCI(2,3) ...
                     simulatedDetectionType2.pClamp.overallMeanCI(2,3) ...
                     realDetection.pClamp.overallMeanCI(2,3)]';

decaysTable = table(detectionConditions, true_decays, true_decay_95CI, ...
                    minis_fitted_decays, minis_fitted_decay_95CI, ...
                    minis_effective_decays, minis_effective_decay_95CI, ...
                    minis_averaged_decays, minis_averaged_decay_95CI, ...
                    MiniAnalysis_decays, MiniAnalysis_amplitude_95CI, ...
                    pClamp_decays, pClamp_amplitude_95CI)

% Incidence rates
true_incidenceRates = ([mean([640 320 160 80 40 20 10 5 2.5 2.5 2.5 2.5 2.5 2.5]) ...
  mean([640 320 160]) mean([10 5 2.5 2.5 2.5 2.5 2.5 2.5]) mean([80 40 20]) ...
  mean([53, 33, 13]) NaN]').*(1 - 1/14);
minis_incidenceRates = [simulatedDetectionType1All.minis.meanIncidenceRate ...
                        simulatedDetectionType1HighFreq.minis.meanIncidenceRate ...
                        simulatedDetectionType1LowFreq.minis.meanIncidenceRate ...
                        simulatedDetectionType1RealFreq.minis.meanIncidenceRate ...
                        simulatedDetectionType2.minis.meanIncidenceRate ...
                        realDetection.minis.meanIncidenceRate]';
minis_incidenceRate_95CI = [simulatedDetectionType1All.minis.meanIncidenceRateCI(2) ...
                            simulatedDetectionType1HighFreq.minis.meanIncidenceRateCI(2) ...
                            simulatedDetectionType1LowFreq.minis.meanIncidenceRateCI(2) ...
                            simulatedDetectionType1RealFreq.minis.meanIncidenceRateCI(2) ...
                            simulatedDetectionType2.minis.meanIncidenceRateCI(2) ...
                            realDetection.minis.meanIncidenceRateCI(2)]';
MiniAnalysis_incidenceRates = [simulatedDetectionType1All.MiniAnalysis.meanIncidenceRate ...
                               simulatedDetectionType1HighFreq.MiniAnalysis.meanIncidenceRate ...
                               simulatedDetectionType1LowFreq.MiniAnalysis.meanIncidenceRate ...
                               simulatedDetectionType1RealFreq.MiniAnalysis.meanIncidenceRate ...
                               simulatedDetectionType2.MiniAnalysis.meanIncidenceRate ...
                               realDetection.MiniAnalysis.meanIncidenceRate]';
MiniAnalysis_incidenceRate_95CI = [simulatedDetectionType1All.MiniAnalysis.meanIncidenceRateCI(2) ...
                                   simulatedDetectionType1HighFreq.MiniAnalysis.meanIncidenceRateCI(2) ...
                                   simulatedDetectionType1LowFreq.MiniAnalysis.meanIncidenceRateCI(2) ...
                                   simulatedDetectionType1RealFreq.MiniAnalysis.meanIncidenceRateCI(2) ...
                                   simulatedDetectionType2.MiniAnalysis.meanIncidenceRateCI(2) ...
                                   realDetection.MiniAnalysis.meanIncidenceRateCI(2)]';
pClamp_incidenceRates = [simulatedDetectionType1All.pClamp.meanIncidenceRate ...
                         simulatedDetectionType1HighFreq.pClamp.meanIncidenceRate ...
                         simulatedDetectionType1LowFreq.pClamp.meanIncidenceRate ...
                         simulatedDetectionType1RealFreq.pClamp.meanIncidenceRate ...
                         simulatedDetectionType2.pClamp.meanIncidenceRate ...
                         realDetection.pClamp.meanIncidenceRate]';
pClamp_incidenceRate_95CI = [simulatedDetectionType1All.pClamp.meanIncidenceRateCI(2) ...
                             simulatedDetectionType1HighFreq.pClamp.meanIncidenceRateCI(2) ...
                             simulatedDetectionType1LowFreq.pClamp.meanIncidenceRateCI(2) ...
                             simulatedDetectionType1RealFreq.pClamp.meanIncidenceRateCI(2) ...
                             simulatedDetectionType2.pClamp.meanIncidenceRateCI(2) ...
                             realDetection.pClamp.meanIncidenceRateCI(2)]';

incidenceRatesTable = table(detectionConditions, true_incidenceRates, ...
                            minis_incidenceRates, minis_incidenceRate_95CI, ...
                            MiniAnalysis_incidenceRates, MiniAnalysis_incidenceRate_95CI, ...
                            pClamp_incidenceRates, pClamp_incidenceRate_95CI)