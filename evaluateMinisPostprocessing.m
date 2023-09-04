cleanUp
params

algorithm = 'minis';
recID = 'p108b';

basepath = fullfile(dataRepo,recFolder,recID);
realDataDir = fullfile(basepath, 'mat_minis');
noiseFilename = fullfile(basepath, [recID '_0019_sw1-5.abf']);
matDir = fullfile(basepath, ['mat_' algorithm]);
settingsFile = fullfile(basepath, 'settings.mat');

load(settingsFile);
[initialised, noiseExcludedTimes] = initExclTimesNoise(settings);
if ~initialised
  error('Excluded times were not set');
end

files = dir(realDataDir);
for iFile = 3:numel(files)
  fileName = [realDataDir filesep files(iFile).name(1:end-4)];
  evaluateMinis(fileName, noiseFilename, noiseExcludedTimes);
  if contains(fileName, 'n4000') || contains(fileName, 'n8000') || contains(fileName, 'n16000')
    copyfile([realDataDir filesep files(iFile).name], [realDataDir '_select' filesep files(iFile).name], 'f');
  end
end

realDataDir = [realDataDir '2'];
files = dir(realDataDir);
for iFile = 3:numel(files)
  fileName = [realDataDir filesep files(iFile).name(1:end-4)];
  evaluateMinis(fileName, noiseFilename, noiseExcludedTimes);
end