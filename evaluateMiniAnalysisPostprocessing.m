cleanUp
params

recID = 'p108b';

basepath = fullfile(dataRepo,recFolder,recID);
csvDir = fullfile(basepath, 'csv_MA');
realDataDir = fullfile(basepath, 'mat_minis');
noiseFilename = fullfile(basepath, [recID '_0019_sw1-5.abf']);
matDir = fullfile(basepath, 'mat_MA');
settingsFile = fullfile(basepath, 'settings.mat');

load(settingsFile);
[initialised, noiseExcludedTimes] = initExclTimesNoise(settings);
if ~initialised
  error('Excluded times were not set');
end

files = dir(realDataDir);
for iFile = 3:numel(files)
  baseFilename = files(iFile).name(1:end-4);
  inp1 = [realDataDir filesep baseFilename]; inp2 = [csvDir filesep baseFilename]; evaluateMiniAnalysis(inp1,inp2,noiseFilename,noiseExcludedTimes);
  if contains(baseFilename, 'n4000') || contains(baseFilename, 'n8000') || contains(baseFilename, 'n16000')
    copyfile([csvDir filesep baseFilename '_MiniAnalysis.mat'], [fileparts(csvDir) filesep matDir '_select' filesep baseFilename '_MiniAnalysis.mat'], 'f');
  end
  movefile([csvDir filesep baseFilename '_MiniAnalysis.mat'], [fileparts(csvDir) filesep matDir filesep baseFilename '_MiniAnalysis.mat'], 'f');
end

realDataDir = [realDataDir '2'];
files = dir(realDataDir);
for iFile = 3:numel(files)
  baseFilename = files(iFile).name(1:end-4);
  inp1 = [realDataDir filesep baseFilename]; inp2 = [csvDir filesep baseFilename]; evaluateMiniAnalysis(inp1,inp2,noiseFilename,noiseExcludedTimes);
  movefile([csvDir filesep baseFilename '_MiniAnalysis.mat'], [fileparts(csvDir) filesep matDir '2' filesep baseFilename '_MiniAnalysis.mat'], 'f');
end