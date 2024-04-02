%% Parameters

dataFolder = 'C:\Users\44079\Phd\Paper3\Benchmarking_data\amplitude0.3';
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
half2expConversionFactor = 1/0.69315;
highFreqMinis = {'4000', '8000', '16000', '32000', '64000', '128000'};
lowFreqMinis = '500';
realFreqMinis = {'500', '1000', '2000'};
durations = [200-50*(1.65-0.05+2.2-1.1) % p103a
             200-50*(1.6-0.25+2.2-0.9)  % p106b
             100-5*(1.85-0.5+2.4-1.15)  % p108a
             100-5*(1.85-0.5+2.4-1.25)  % p108b
             100-5*(1.85-0.5+2.4-1.2)   % p108c
             100-5*(1.85-0.5+2.4-1.2)   % p120b
             100-5*(1.85-0.5+2.4-1.25)  % p122a
             100-5*(1.85-0.5+2.4-1.15)  % p124b
             100-5*(1.85-0.5+2.4-1.2)   % p125a
             100-5*(1.85-0.5+2.4-1.2)   % p127c
             100-5*(1.85-0.5+2.4-1.2)   % p128c
             100-5*(1.85-0.5+2.4-1.2)   % p129a
             100-5*(2.85-0.5+3.4-1.25)  % p131a
             100-5*(2.9-0.5+3.4-1)]';   % p131c
nFiles = 4;
nConditions = [14 3];


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
      try
        simulatedDetectionType1All.MiniAnalysis.data = [simulatedDetectionType1All.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        simulatedDetectionType1All.MiniAnalysis.data = [simulatedDetectionType1All.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Var3 T.Var11 T.Var5]];
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
      T = readtable(detectionFile);
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
      try
        simulatedDetectionType1HighFreq.MiniAnalysis.data = [simulatedDetectionType1HighFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        simulatedDetectionType1HighFreq.MiniAnalysis.data = [simulatedDetectionType1HighFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Var3 T.Var11 T.Var5]];
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
      T = readtable(detectionFile);
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
      try
        simulatedDetectionType1LowFreq.MiniAnalysis.data = [simulatedDetectionType1LowFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        simulatedDetectionType1LowFreq.MiniAnalysis.data = [simulatedDetectionType1LowFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Var3 T.Var11 T.Var5]];
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
      T = readtable(detectionFile);
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
      try
        simulatedDetectionType1RealFreq.MiniAnalysis.data = [simulatedDetectionType1RealFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        simulatedDetectionType1RealFreq.MiniAnalysis.data = [simulatedDetectionType1RealFreq.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Var3 T.Var11 T.Var5]];
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
      T = readtable(detectionFile);
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
      try
        simulatedDetectionType2.MiniAnalysis.data = [simulatedDetectionType2.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Amplitude T.x10_90Rise T.Decay_ms_]];
      catch
        simulatedDetectionType2.MiniAnalysis.data = [simulatedDetectionType2.MiniAnalysis.data; ...
          [ones(size(T,1),1)*iRec T.Var3 T.Var11 T.Var5]];
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
      T = readtable(detectionFile);
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
  inds = simulatedDetectionType1All.minis.data(:,1) == iRec;
  simulatedDetectionType1All.minis.means(iRec,:) = mean(simulatedDetectionType1All.minis.data(inds,2:end));
  inds = simulatedDetectionType1All.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1All.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1All.MiniAnalysis.data(inds,2:end));
  inds = simulatedDetectionType1All.pClamp.data(:,1) == iRec;
  simulatedDetectionType1All.pClamp.means(iRec,:) = mean(simulatedDetectionType1All.pClamp.data(inds,2:end));

  inds = simulatedDetectionType1HighFreq.minis.data(:,1) == iRec;
  simulatedDetectionType1HighFreq.minis.means(iRec,:) = mean(simulatedDetectionType1HighFreq.minis.data(inds,2:end));
  inds = simulatedDetectionType1HighFreq.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1HighFreq.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1HighFreq.MiniAnalysis.data(inds,2:end));
  inds = simulatedDetectionType1HighFreq.pClamp.data(:,1) == iRec;
  simulatedDetectionType1HighFreq.pClamp.means(iRec,:) = mean(simulatedDetectionType1HighFreq.pClamp.data(inds,2:end));

  inds = simulatedDetectionType1LowFreq.minis.data(:,1) == iRec;
  simulatedDetectionType1LowFreq.minis.means(iRec,:) = mean(simulatedDetectionType1LowFreq.minis.data(inds,2:end));
  inds = simulatedDetectionType1LowFreq.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1LowFreq.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1LowFreq.MiniAnalysis.data(inds,2:end));
  inds = simulatedDetectionType1LowFreq.pClamp.data(:,1) == iRec;
  simulatedDetectionType1LowFreq.pClamp.means(iRec,:) = mean(simulatedDetectionType1LowFreq.pClamp.data(inds,2:end));

  inds = simulatedDetectionType1RealFreq.minis.data(:,1) == iRec;
  simulatedDetectionType1RealFreq.minis.means(iRec,:) = mean(simulatedDetectionType1RealFreq.minis.data(inds,2:end));
  inds = simulatedDetectionType1RealFreq.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1RealFreq.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType1RealFreq.MiniAnalysis.data(inds,2:end));
  inds = simulatedDetectionType1RealFreq.pClamp.data(:,1) == iRec;
  simulatedDetectionType1RealFreq.pClamp.means(iRec,:) = mean(simulatedDetectionType1RealFreq.pClamp.data(inds,2:end));

  inds = simulatedDetectionType2.minis.data(:,1) == iRec;
  simulatedDetectionType2.minis.means(iRec,:) = mean(simulatedDetectionType2.minis.data(inds,2:end));
  inds = simulatedDetectionType2.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType2.MiniAnalysis.means(iRec,:) = mean(simulatedDetectionType2.MiniAnalysis.data(inds,2:end));
  inds = simulatedDetectionType2.pClamp.data(:,1) == iRec;
  simulatedDetectionType2.pClamp.means(iRec,:) = mean(simulatedDetectionType2.pClamp.data(inds,2:end));

  inds = realDetection.minis.data(:,1) == iRec;
  realDetection.minis.means(iRec,:) = mean(realDetection.minis.data(inds,2:end));
  inds = realDetection.MiniAnalysis.data(:,1) == iRec;
  realDetection.MiniAnalysis.means(iRec,:) = mean(realDetection.MiniAnalysis.data(inds,2:end));
  inds = realDetection.pClamp.data(:,1) == iRec;
  realDetection.pClamp.means(iRec,:) = mean(realDetection.pClamp.data(inds,2:end));
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
  inds = simulatedDetectionType1All.minis.data(:,1) == iRec;
  simulatedDetectionType1All.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(1));
  inds = simulatedDetectionType1All.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1All.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(1));
  inds = simulatedDetectionType1All.pClamp.data(:,1) == iRec;
  simulatedDetectionType1All.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(1));

  inds = simulatedDetectionType1HighFreq.minis.data(:,1) == iRec;
  simulatedDetectionType1HighFreq.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(highFreqMinis));
  inds = simulatedDetectionType1HighFreq.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1HighFreq.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(highFreqMinis));
  inds = simulatedDetectionType1HighFreq.pClamp.data(:,1) == iRec;
  simulatedDetectionType1HighFreq.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(highFreqMinis));

  inds = simulatedDetectionType1LowFreq.minis.data(:,1) == iRec;
  simulatedDetectionType1LowFreq.minis.incidenceRates(iRec) = ...
    sum(inds)/(durations(iRec)*4*(nConditions(1)-numel(highFreqMinis)-numel(realFreqMinis)));
  inds = simulatedDetectionType1LowFreq.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1LowFreq.MiniAnalysis.incidenceRates(iRec) = ...
    sum(inds)/(durations(iRec)*4*(nConditions(1)-numel(highFreqMinis)-numel(realFreqMinis)));
  inds = simulatedDetectionType1LowFreq.pClamp.data(:,1) == iRec;
  simulatedDetectionType1LowFreq.pClamp.incidenceRates(iRec) = ...
    sum(inds)/(durations(iRec)*4*(nConditions(1)-numel(highFreqMinis)-numel(realFreqMinis)));

  inds = simulatedDetectionType1RealFreq.minis.data(:,1) == iRec;
  simulatedDetectionType1RealFreq.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(realFreqMinis));
  inds = simulatedDetectionType1RealFreq.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType1RealFreq.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(realFreqMinis));
  inds = simulatedDetectionType1RealFreq.pClamp.data(:,1) == iRec;
  simulatedDetectionType1RealFreq.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*numel(realFreqMinis));

  inds = simulatedDetectionType2.minis.data(:,1) == iRec;
  simulatedDetectionType2.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(2));
  inds = simulatedDetectionType2.MiniAnalysis.data(:,1) == iRec;
  simulatedDetectionType2.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(2));
  inds = simulatedDetectionType2.pClamp.data(:,1) == iRec;
  simulatedDetectionType2.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec)*4*nConditions(2));

  inds = realDetection.minis.data(:,1) == iRec;
  realDetection.minis.incidenceRates(iRec) = sum(inds)/(durations(iRec));
  inds = realDetection.MiniAnalysis.data(:,1) == iRec;
  realDetection.MiniAnalysis.incidenceRates(iRec) = sum(inds)/(durations(iRec));
  inds = realDetection.pClamp.data(:,1) == iRec;
  realDetection.pClamp.incidenceRates(iRec) = sum(inds)/(durations(iRec));
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