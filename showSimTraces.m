% Demonstrate how 'noise + simulated minis' traces are generated

% User input
figFolder = 'C:\Users\marty\code_repositories\minis-benchmarking\fitFigures';
fitFolder = 'C:\Users\marty\PhD\Paper4\Fits\best_fits';
recID = 'p131a';

% Load simulated data
recFolder = fullfile(fitFolder, recID);
simFile = dir(fullfile(recFolder, 'fit*.mat'));
simFile = fullfile(recFolder, simFile.name);
fitData = load(simFile);

% Load noise data
settingsFile = fullfile(recFolder, 'settings.mat');
load(settingsFile);
% [data,si,hd] = abf2load(settings.loadNoiseFileInput);
[data,si,hd] = abf2load(strrep(settings.loadNoiseFileInput, '44079', 'marty'));

% Display data
fT = figure; tiledlayout(7,1, 'Padding','none', 'TileSpacing','tight')
set(fT, 'Color', [1, 1, 1]);

addV = 0.9;
addV2 = -70.45;
dt = fitData.detectionParametersSim.sampleInterval/1000;
time = dt:dt:(numel(fitData.V)*dt);
plot(time, fitData.V+addV, 'k'); hold on
plot(time, fitData.simV+addV2, 'k', 'LineWidth',1);

noiseData = reshape(data(:,1,:), [1 size(data,1)*size(data,3)]);
plot(time(1:numel(noiseData)), noiseData, 'k'); hold off

xlim([77.3908 78.5347])
ylim([-70.94 -69.33]);

% Tidy the figure
set(gca, 'XColor', 'none');
set(gca, 'YColor', 'none');
box(gca, 'off');
set(fT, 'Position',[261.0000 242.0000 940.8000 420.0000]);

% Save the figure
figName = ['noisePlusSimMinis_' recID];
if ~exist(figFolder, 'dir')
  mdir(figFolder);
end
figName = strrep(figName, ' ', '_');
figName = strrep(figName, '(', '_');
figName = strrep(figName, ')', '_');
figName = strrep(figName, '/', '_');
figName = strrep(figName, '.', '_');
figName = fullfile(figFolder, figName);
savefig(fT, figName,'compact');
exportgraphics(fT,[figName, '.png'], 'Resolution',900);
exportgraphics(fT,[figName, '.pdf'], 'ContentType','vector');
close(fT);
fclose all;