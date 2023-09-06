cleanUp
params

recID = 'p129a';

basepath = fullfile(dataRepo,recFolder,recID);
csvDir = fullfile(basepath, 'csv_pC_raw2');
realDataDir = fullfile(basepath, 'mat_minis');
noiseFilename = fullfile(basepath, ['0017_' recID '_0019_sw1-5.abf']);
matDir = fullfile(basepath, 'mat_pC_raw');
settingsFile = fullfile(basepath, 'settings.mat');

load(settingsFile);
[initialised, noiseExcludedTimes] = initExclTimesNoise(settings);
if ~initialised
  error('Excluded times were not set');
end

files = dir(realDataDir);
for iFile = 3:numel(files)
  baseFilename = files(iFile).name(1:end-4);
  evaluatepClamp([csvDir filesep baseFilename], realDataDir, noiseFilename, noiseExcludedTimes);
  if contains(baseFilename, 'n4000') || contains(baseFilename, 'n8000') || contains(baseFilename, 'n16000')
    copyfile([csvDir filesep baseFilename '_pClamp.mat'], [fileparts(csvDir) filesep matDir '_select' filesep baseFilename '_pClamp.mat'], 'f');
  end
  movefile([csvDir filesep baseFilename '_pClamp.mat'], [fileparts(csvDir) filesep matDir filesep baseFilename '_pClamp.mat'], 'f');
end

realDataDir = [realDataDir '2'];
files = dir(realDataDir);
for iFile = 3:numel(files)
  baseFilename = files(iFile).name(1:end-4);
  evaluatepClamp([csvDir filesep baseFilename], realDataDir, noiseFilename, noiseExcludedTimes);
  movefile([csvDir filesep baseFilename '_pClamp.mat'], [fileparts(csvDir) filesep matDir '_2' filesep baseFilename '_pClamp.mat'], 'f');
end