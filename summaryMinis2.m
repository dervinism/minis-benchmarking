cleanUp
params

fullRun = false;
testType = {'test1';'testSelect';'test2'};
displayCount = false;
displayLegends = false;


%% Analyses
% Noise files
noiseFile{1} = fullfile(dataRepo,recFolder,'p103a','p103a_0100-0104.abf');
noiseFile{2} = fullfile(dataRepo,recFolder,'p106b','p106b_0066-69sw7,69sw10-70,71sw2-3.abf');
noiseFile{3} = fullfile(dataRepo,recFolder,'p108a','p108a_0025_sw1-5.abf');
noiseFile{4} = fullfile(dataRepo,recFolder,'p108b','p108b_0019_sw1-5.abf');
noiseFile{5} = fullfile(dataRepo,recFolder,'p108c','p108c_0021_sw1-5.abf');
noiseFile{6} = fullfile(dataRepo,recFolder,'p120b','p120b_0031_sw1-4,6.abf');
noiseFile{7} = fullfile(dataRepo,recFolder,'p122a','p122a_0029_sw7-0030_sw1.abf');
noiseFile{8} = fullfile(dataRepo,recFolder,'p124b','p124b_0020_sw1-5.abf');
noiseFile{9} = fullfile(dataRepo,recFolder,'p125a','p125a_0022_sw7-10,0023_sw2.abf');
noiseFile{10} = fullfile(dataRepo,recFolder,'p127c','0022_p127c_0025_sw1-5.abf');
noiseFile{11} = fullfile(dataRepo,recFolder,'p128c','0017_p128c_0026_sw1-5.abf');
noiseFile{12} = fullfile(dataRepo,recFolder,'p129a','0017_p129a_0019_sw1-5.abf');
noiseFile{13} = fullfile(dataRepo,recFolder,'p131a','p131a_0015_sw7,8,0016_sw5,10,0017sw1.abf');
noiseFile{14} = fullfile(dataRepo,recFolder,'p131c','p131c_0016_sw1-5.abf');

% minis performance
for iTest = 1:numel(testType)
  if strcmpi(testType{iTest}, 'test1')
    adjustRates = false;
  elseif strcmpi(testType{iTest}, 'testSelect')
    adjustRates = true;
  elseif strcmpi(testType{iTest}, 'test2')
    adjustRates = false;
  end
  if strcmpi(testType{iTest}, 'test1')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_minis');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_minis');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_minis');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_minis');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_minis');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_minis');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_minis');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_minis');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_minis');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_minis');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_minis');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_minis');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_minis');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_minis');
    targetDir = performanceTestDir1;
  elseif strcmpi(testType{iTest}, 'testSelect')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_minis_select');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_minis_select');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_minis_select');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_minis_select');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_minis_select');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_minis_select');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_minis_select');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_minis_select');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_minis_select');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_minis_select');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_minis_select');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_minis_select');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_minis_select');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_minis_select');
    targetDir = performanceTestDirSelect;
  elseif strcmpi(testType{iTest}, 'test2')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_minis2');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_minis2');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_minis2');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_minis2');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_minis2');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_minis2');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_minis2');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_minis2');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_minis2');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_minis2');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_minis2');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_minis2');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_minis2');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_minis2');
    targetDir = performanceTestDir2;
  end
  if fullRun
    [figures, legends, decayDetectionPerformanceMinis] = summaryDecay(noiseFile, folder, [], [], matlabColours(8), [], [], dt, adjustRates); %#ok<*UNRCH>
    save([targetDir filesep 'decayDetectionPerformance.mat'], 'decayDetectionPerformanceMinis', '-v7.3');
    fclose all;
  else
    [figures, legends, decayDetectionPerformanceMinis] = summaryDecay(noiseFile, folder, [], [], matlabColours(8),...
      [targetDir filesep 'decayDetectionPerformance.mat'], 'decayDetectionPerformanceMinis', dt, adjustRates);
  end

  % Mini Analysis performance
  if strcmpi(testType{iTest}, 'test1')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_MiniAnalysis');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_MiniAnalysis');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_MiniAnalysis');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_MiniAnalysis');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_MiniAnalysis');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_MiniAnalysis');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_MiniAnalysis');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_MiniAnalysis');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_MiniAnalysis');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_MiniAnalysis');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_MiniAnalysis');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_MiniAnalysis');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_MiniAnalysis');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_MiniAnalysis');
  elseif strcmpi(testType{iTest}, 'testSelect')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_MiniAnalysis_select');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_MiniAnalysis_select');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_MiniAnalysis_select');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_MiniAnalysis_select');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_MiniAnalysis_select');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_MiniAnalysis_select');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_MiniAnalysis_select');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_MiniAnalysis_select');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_MiniAnalysis_select');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_MiniAnalysis_select');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_MiniAnalysis_select');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_MiniAnalysis_select');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_MiniAnalysis_select');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_MiniAnalysis_select');
  elseif strcmpi(testType{iTest}, 'test2')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_MiniAnalysis2');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_MiniAnalysis2');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_MiniAnalysis2');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_MiniAnalysis2');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_MiniAnalysis2');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_MiniAnalysis2');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_MiniAnalysis2');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_MiniAnalysis2');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_MiniAnalysis2');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_MiniAnalysis2');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_MiniAnalysis2');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_MiniAnalysis2');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_MiniAnalysis2');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_MiniAnalysis2');
  end
  if fullRun
    [figures, legends, decayDetectionPerformanceMiniAnalysis] = summaryDecay(noiseFile, folder, figures, legends, 'r', [], [], dt, adjustRates);
    save([targetDir filesep 'decayDetectionPerformance.mat'], 'decayDetectionPerformanceMiniAnalysis', '-append');
    fclose all;
  else
    [figures, legends, decayDetectionPerformanceMiniAnalysis] = summaryDecay(noiseFile, folder, figures, legends, 'r',...
      [targetDir filesep 'decayDetectionPerformance.mat'], 'decayDetectionPerformanceMiniAnalysis', dt, adjustRates);
  end

  if strcmpi(testType{iTest}, 'test1')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_pClamp_raw');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_pClamp_raw');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_pClamp_raw');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_pClamp_raw');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_pClamp_raw');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_pClamp_raw');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_pClamp_raw');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_pClamp_raw');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_pClamp_raw');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_pClamp_raw');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_pClamp_raw');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_pClamp_raw');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_pClamp_raw');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_pClamp_raw');
  elseif strcmpi(testType{iTest}, 'testSelect')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_pClamp_raw_select');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_pClamp_raw_select');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_pClamp_raw_select');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_pClamp_raw_select');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_pClamp_raw_select');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_pClamp_raw_select');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_pClamp_raw_select');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_pClamp_raw_select');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_pClamp_raw_select');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_pClamp_raw_select');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_pClamp_raw_select');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_pClamp_raw_select');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_pClamp_raw_select');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_pClamp_raw_select');
  elseif strcmpi(testType{iTest}, 'test2')
    folder{1} =  fullfile(dataRepo,recFolder,'p103a','mat_pClamp_raw2');
    folder{2} =  fullfile(dataRepo,recFolder,'p106b','mat_pClamp_raw2');
    folder{3} =  fullfile(dataRepo,recFolder,'p108a','mat_pClamp_raw2');
    folder{4} =  fullfile(dataRepo,recFolder,'p108b','mat_pClamp_raw2');
    folder{5} =  fullfile(dataRepo,recFolder,'p108c','mat_pClamp_raw2');
    folder{6} =  fullfile(dataRepo,recFolder,'p120b','mat_pClamp_raw2');
    folder{7} =  fullfile(dataRepo,recFolder,'p122a','mat_pClamp_raw2');
    folder{8} =  fullfile(dataRepo,recFolder,'p124b','mat_pClamp_raw2');
    folder{9} =  fullfile(dataRepo,recFolder,'p125a','mat_pClamp_raw2');
    folder{10} = fullfile(dataRepo,recFolder,'p127c','mat_pClamp_raw2');
    folder{11} = fullfile(dataRepo,recFolder,'p128c','mat_pClamp_raw2');
    folder{12} = fullfile(dataRepo,recFolder,'p129a','mat_pClamp_raw2');
    folder{13} = fullfile(dataRepo,recFolder,'p131a','mat_pClamp_raw2');
    folder{14} = fullfile(dataRepo,recFolder,'p131c','mat_pClamp_raw2');
  end
  if fullRun
    [figures, legends, decayDetectionPerformancepClampRaw2] = summaryDecay(noiseFile, folder, figures, legends, 'm', [], [], dt, adjustRates);
    save([targetDir filesep 'decayDetectionPerformance.mat'], 'decayDetectionPerformancepClampRaw2', '-append');
    fclose all;
  else
    [figures, legends, decayDetectionPerformancepClampRaw2] = summaryDecay(noiseFile, folder, figures, legends, 'm',...
      [targetDir filesep 'decayDetectionPerformance.mat'], 'decayDetectionPerformancepClampRaw2', dt, adjustRates);
  end


  %% Figures
  % Common parameters
  legendString = {'minis', 'Mini Analysis', 'Clampfit'};
  figSize = 17;

  %% 1. Detection on the rising phase: PDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.65];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.9];
    yTicks = 0:0.2:1;
    legendLocation = 'SouthEast';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.875];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(1));
  legend(legends{1},legendString, 'Location',legendLocation);
  legend boxoff
  %title('Probability of mini detection as a function of V_M rate of change: Rising phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'TPR', yLim, yTicks);
  xticklabels(xTickLabels);
  set(figures(1), 'color','w');
  figName = 'risingPDF';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    nEvents = 0;
    nEventsMinis = 0;
    nEventsMiniAnalysis = 0;
    nEventspClamp = 0;
    for iRec = 1:numel(decayDetectionPerformanceMinis.hitsRiseDiffRecording)
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.hitsRiseDiffRecording{iRec});
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.missesRiseDiffRecording{iRec});
      nEventsMinis = nEventsMinis + numel(decayDetectionPerformanceMinis.hitsRiseDiffRecording{iRec});
      nEventsMiniAnalysis = nEventsMiniAnalysis + numel(decayDetectionPerformanceMiniAnalysis.hitsRiseDiffRecording{iRec});
      nEventspClamp = nEventspClamp + numel(decayDetectionPerformancepClampRaw2.hitsRiseDiffRecording{iRec});
    end
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(1), gca, width, height, label, margin, 0);
  hgsave(figures(1), [targetDir filesep figName '.fig']);
  exportFig(figures(1), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(1), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(1));

  %% 2. Detection on the rising phase: CDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.26];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.7];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.73];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(2));
  if displayLegends
    legend(legends{2},legendString, 'Location',legendLocation);
    legend boxoff
  end
  %title('Cumulative probability of mini detection as a function of V_M rate of change: Rising phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'Cumulative TPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(2), 'color','w');
  figName = 'risingCDF';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(2), gca, width, height, label, margin, 0);
  hgsave(figures(2), [targetDir filesep figName '.fig']);
  exportFig(figures(2), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(2), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(2));

  %% 3. Detection on the decay phase: PDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.8];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.92];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.85];
    yTicks = 0:0.2:1;
    legendLocation = 'SouthEast';
  end
  figure(figures(3));
  legend(legends{3},legendString, 'Location',legendLocation);
  legend boxoff
  %title('Probability of mini detection as a function of V_M rate of change: Decay phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'TPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(3), 'color','w');
  figName = 'decayPDF';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    nEvents = 0;
    nEventsMinis = 0;
    nEventsMiniAnalysis = 0;
    nEventspClamp = 0;
    for iRec = 1:numel(decayDetectionPerformanceMinis.hitsDecayDiffRecording)
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.hitsDecayDiffRecording{iRec});
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.missesDecayDiffRecording{iRec});
      nEventsMinis = nEventsMinis + numel(decayDetectionPerformanceMinis.hitsDecayDiffRecording{iRec});
      nEventsMiniAnalysis = nEventsMiniAnalysis + numel(decayDetectionPerformanceMiniAnalysis.hitsDecayDiffRecording{iRec});
      nEventspClamp = nEventspClamp + numel(decayDetectionPerformancepClampRaw2.hitsDecayDiffRecording{iRec});
    end
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(3), gca, width, height, label, margin, 0);
  hgsave(figures(3), [targetDir filesep figName '.fig']);
  exportFig(figures(3), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(3), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(3));

  %% 4. Detection on the decay phase: CDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.27];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.72];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.72];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(4));
  if displayLegends
    legend(legends{4},legendString, 'Location',legendLocation);
    legend boxoff
  end
  %title('Cumulative probability of mini detection as a function of V_M rate of change: Decay phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'Cumulative TPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(4), 'color','w');
  figName = 'decayCDF';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(4), gca, width, height, label, margin, 0);
  hgsave(figures(4), [targetDir filesep figName '.fig']);
  exportFig(figures(4), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(4), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(4));

  %% 5. Detection on the flat phase: PDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 1];
    yTicks = 0:0.2:1;
    legendLocation = 'SouthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 1];
    yTicks = 0:0.2:1;
    legendLocation = 'SouthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 1];
    yTicks = 0:0.2:1;
    legendLocation = 'SouthWest';
  end
  figure(figures(5));
  legend(legends{5},legendString, 'Location',legendLocation);
  legend boxoff
  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'Time to neighbour (ms)', xLim, xTicks,...
    'on', 'k', 'TPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(5), 'color','w');
  figName = 'flatPDF';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    nEvents = 0;
    nEventsMinis = 0;
    nEventsMiniAnalysis = 0;
    nEventspClamp = 0;
    for iRec = 1:numel(decayDetectionPerformanceMinis.hitsFlatDiffRecording)
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.hitsFlatDiffRecording{iRec});
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.missesFlatDiffRecording{iRec});
      nEventsMinis = nEventsMinis + numel(decayDetectionPerformanceMinis.hitsFlatDiffRecording{iRec});
      nEventsMiniAnalysis = nEventsMiniAnalysis + numel(decayDetectionPerformanceMiniAnalysis.hitsFlatDiffRecording{iRec});
      nEventspClamp = nEventspClamp + numel(decayDetectionPerformancepClampRaw2.hitsFlatDiffRecording{iRec});
    end
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(5), gca, width, height, label, margin, 0);
  hgsave(figures(5), [targetDir filesep figName '.fig']);
  exportFig(figures(5), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(5), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(5));

  %% 6. Detection on the flat phase: CDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.85];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 1];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.9];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(6));
  if displayLegends
    legend(legends{6},legendString, 'Location',legendLocation);
    legend boxoff
  end
  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'Time to neighbour (ms)', xLim, xTicks,...
    'on', 'k', 'Cumulative TPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.006','0.01','0.1','0.3'});
  set(figures(6), 'color','w');
  figName = 'flatCDF';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(6), gca, width, height, label, margin, 0);
  hgsave(figures(6), [targetDir filesep figName '.fig']);
  exportFig(figures(6), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(6), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(6));

  %% 7. False alarms on the rising phase: PDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.2];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthEast';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.35];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthEast';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.45];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthEast';
  end
  figure(figures(7));
  if displayLegends
    legend(legends{7},legendString, 'Location',legendLocation);
    legend boxoff
  end
  %title('Probability of mini detection as a function of V_M rate of change: Rising phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'FPR', yLim, yTicks);
  xticklabels(xTickLabels);
  set(figures(7), 'color','w');
  figName = 'risingPDF_fa';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    nEvents = 0;
    nEventsMinis = 0;
    nEventsMiniAnalysis = 0;
    nEventspClamp = 0;
    for iRec = 1:numel(decayDetectionPerformanceMinis.falseAlarmsRiseDiffRecording)
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.falseAlarmsRiseDiffRecording{iRec});
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.correctRejectionsRiseDiffRecording{iRec});
      nEventsMinis = nEventsMinis + numel(decayDetectionPerformanceMinis.falseAlarmsRiseDiffRecording{iRec});
      nEventsMiniAnalysis = nEventsMiniAnalysis + numel(decayDetectionPerformanceMiniAnalysis.falseAlarmsRiseDiffRecording{iRec});
      nEventspClamp = nEventspClamp + numel(decayDetectionPerformancepClampRaw2.falseAlarmsRiseDiffRecording{iRec});
    end
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(7), gca, width, height, label, margin, 0);
  hgsave(figures(7), [targetDir filesep figName '.fig']);
  exportFig(figures(7), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(7), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(7));

  %% 8. False alarms on the rising phase: CDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.1501];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.185];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 0.26];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(8));
  if displayLegends
    legend(legends{8},legendString, 'Location',legendLocation);
    legend boxoff
  end
  %title('Cumulative probability of mini detection as a function of V_M rate of change: Rising phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'Cumulative FPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(8), 'color','w');
  figName = 'risingCDF_fa';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(8), gca, width, height, label, margin, 0);
  hgsave(figures(8), [targetDir filesep figName '.fig']);
  exportFig(figures(8), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(8), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(8));

  %% 9. False alarm on the decay phase: PDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.52];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthEast';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.45];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthEast';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.485];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthEast';
  end
  figure(figures(9));
  if displayLegends
    legend(legends{9},legendString, 'Location',legendLocation);
    legend boxoff
  end
  %title('Probability of mini detection as a function of V_M rate of change: Decay phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'FPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(9), 'color','w');
  figName = 'decayPDF_fa';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    nEvents = 0;
    nEventsMinis = 0;
    nEventsMiniAnalysis = 0;
    nEventspClamp = 0;
    for iRec = 1:numel(decayDetectionPerformanceMinis.falseAlarmsDecayDiffRecording)
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.falseAlarmsDecayDiffRecording{iRec});
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.correctRejectionsDecayDiffRecording{iRec});
      nEventsMinis = nEventsMinis + numel(decayDetectionPerformanceMinis.falseAlarmsDecayDiffRecording{iRec});
      nEventsMiniAnalysis = nEventsMiniAnalysis + numel(decayDetectionPerformanceMiniAnalysis.falseAlarmsDecayDiffRecording{iRec});
      nEventspClamp = nEventspClamp + numel(decayDetectionPerformancepClampRaw2.falseAlarmsDecayDiffRecording{iRec});
    end
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(9), gca, width, height, label, margin, 0);
  hgsave(figures(9), [targetDir filesep figName '.fig']);
  exportFig(figures(9), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(9), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(9));

  %% 10. False alarm on the decay phase: CDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.275];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.35];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 0.42];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(10));
  if displayLegends
    legend(legends{10},legendString, 'Location',legendLocation);
    legend boxoff
  end
  %title('Cumulative probability of mini detection as a function of V_M rate of change: Decay phase');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'Cumulative FPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(10), 'color','w');
  figName = 'decayCDF_fa';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(10), gca, width, height, label, margin, 0);
  hgsave(figures(10), [targetDir filesep figName '.fig']);
  exportFig(figures(10), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(10), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(10));

  %% 11. Detection on the flat phase: PDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.45];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.45];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.61];
    yTicks = 0:0.2:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(11));
  if displayLegends
    legend(legends{11},legendString, 'Location',legendLocation);
    legend boxoff
  end
  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'Time to neighbour (ms)', xLim, xTicks,...
    'on', 'k', 'FPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.1','0.5','1'});
  set(figures(11), 'color','w');
  figName = 'flatPDF_fa';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    nEvents = 0;
    nEventsMinis = 0;
    nEventsMiniAnalysis = 0;
    nEventspClamp = 0;
    for iRec = 1:numel(decayDetectionPerformanceMinis.falseAlarmsFlatDiffRecording)
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.falseAlarmsFlatDiffRecording{iRec});
      nEvents = nEvents + numel(decayDetectionPerformanceMinis.correctRejectionsFlatDiffRecording{iRec});
      nEventsMinis = nEventsMinis + numel(decayDetectionPerformanceMinis.falseAlarmsFlatDiffRecording{iRec});
      nEventsMiniAnalysis = nEventsMiniAnalysis + numel(decayDetectionPerformanceMiniAnalysis.falseAlarmsFlatDiffRecording{iRec});
      nEventspClamp = nEventspClamp + numel(decayDetectionPerformancepClampRaw2.falseAlarmsFlatDiffRecording{iRec});
    end
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(11), gca, width, height, label, margin, 0);
  hgsave(figures(11), [targetDir filesep figName '.fig']);
  exportFig(figures(11), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(11), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(11));

  %% 12. Detection on the flat phase: CDF
  if strcmpi(testType{iTest}, 'test1')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.1501];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.1501];
    yTicks = 0:0.05:1;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 0.45];
    yTicks = 0:0.1:1;
    legendLocation = 'NorthWest';
  end
  figure(figures(12));
  if displayLegends
    legend(legends{12},legendString, 'Location',legendLocation);
    legend boxoff
  end
  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'Time to neighbour (ms)', xLim, xTicks,...
    'on', 'k', 'Cumulative FPR', yLim, yTicks);
  xticklabels(xTickLabels);
  %yticklabels({'0.006','0.01','0.1','0.3'});
  set(figures(12), 'color','w');
  figName = 'flatCDF_fa';

  if displayCount
    xLimLocal = xlim;
    xAxisLength = xLimLocal(2)-xLimLocal(1);
    yLim = ylim;
    yAxisLength = yLim(2)-yLim(1);
    text(xLimLocal(1)+xAxisLength*0.025, yLim(1)+yAxisLength*0.05,...
      ['n=' num2str(nEventsMinis) '/' num2str(nEventsMiniAnalysis) '/' num2str(nEventspClamp) '/' num2str(nEvents)], 'FontSize',16);
  end

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(12), gca, width, height, label, margin, 0);
  hgsave(figures(12), [targetDir filesep figName '.fig']);
  exportFig(figures(12), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(12), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(12));

  %% 13. Performance on the rising phase: d'
  smoothingWindowSize = 41;
  [dPrimeRiseMeanMinis, dPrimeRiseCI95Minis, centresMinis] = dPrimeCalcRise(decayDetectionPerformanceMinis);
  [centresMinisInterp, dPrimeRiseMeanMinisInterpSmooth] = interpSmooth(centresMinis, dPrimeRiseMeanMinis, smoothingWindowSize, true);
  dPrimeRiseCI95MinisInterpSmooth = zeros(1,numel(dPrimeRiseMeanMinisInterpSmooth));
  [~, dPrimeRiseCI95MinisInterpSmooth(1,:)] = interpSmooth(centresMinis, dPrimeRiseCI95Minis(1,:), smoothingWindowSize, true);
  [~, dPrimeRiseCI95MinisInterpSmooth(2,:)] = interpSmooth(centresMinis, dPrimeRiseCI95Minis(2,:), smoothingWindowSize, true);
  [dPrimeRiseMeanMiniAnalysis, dPrimeRiseCI95MiniAnalysis, centresMiniAnalysis] = dPrimeCalcRise(decayDetectionPerformanceMiniAnalysis);
  [centresMiniAnalysisInterp, dPrimeRiseMeanMiniAnalysisInterpSmooth] = interpSmooth(centresMiniAnalysis, dPrimeRiseMeanMiniAnalysis, smoothingWindowSize, true);
  dPrimeRiseCI95MiniAnalysisInterpSmooth = zeros(1,numel(dPrimeRiseMeanMiniAnalysisInterpSmooth));
  [~, dPrimeRiseCI95MiniAnalysisInterpSmooth(1,:)] = interpSmooth(centresMiniAnalysis, dPrimeRiseCI95MiniAnalysis(1,:), smoothingWindowSize, true);
  [~, dPrimeRiseCI95MiniAnalysisInterpSmooth(2,:)] = interpSmooth(centresMiniAnalysis, dPrimeRiseCI95MiniAnalysis(2,:), smoothingWindowSize, true);
  [dPrimeRiseMeanpClampRaw2, dPrimeRiseCI95pClampRaw2, centrespClampRaw2] = dPrimeCalcRise(decayDetectionPerformancepClampRaw2);
  [centrespClampRaw2Interp, dPrimeRiseMeanpClampRaw2InterpSmooth] = interpSmooth(centrespClampRaw2, dPrimeRiseMeanpClampRaw2, smoothingWindowSize, true);
  dPrimeRiseCI95pClampRaw2InterpSmooth = zeros(1,numel(dPrimeRiseMeanpClampRaw2InterpSmooth));
  [~, dPrimeRiseCI95pClampRaw2InterpSmooth(1,:)] = interpSmooth(centrespClampRaw2, dPrimeRiseCI95pClampRaw2(1,:), smoothingWindowSize, true);
  [~, dPrimeRiseCI95pClampRaw2InterpSmooth(2,:)] = interpSmooth(centrespClampRaw2, dPrimeRiseCI95pClampRaw2(2,:), smoothingWindowSize, true);
  colours = {matlabColours(8),'r','m'};
  figures(13) = figure;
  p = semilogx(centresMinisInterp, dPrimeRiseMeanMinisInterpSmooth, 'LineWidth',1, 'Color',colours{1}); hold on
  legends{13} = [legends{13} p];
  ciplot(dPrimeRiseMeanMinisInterpSmooth+dPrimeRiseCI95MinisInterpSmooth(1,:),...
    dPrimeRiseMeanMinisInterpSmooth+dPrimeRiseCI95MinisInterpSmooth(2,:),...
    centresMinisInterp,colours{1},0.2);
  p = semilogx(centresMiniAnalysisInterp, dPrimeRiseMeanMiniAnalysisInterpSmooth, 'LineWidth',1, 'Color',colours{2});
  legends{13} = [legends{13} p];
  ciplot(dPrimeRiseMeanMiniAnalysisInterpSmooth+dPrimeRiseCI95MiniAnalysisInterpSmooth(1,:),...
    dPrimeRiseMeanMiniAnalysisInterpSmooth+dPrimeRiseCI95MiniAnalysisInterpSmooth(2,:),...
    centresMiniAnalysisInterp,colours{2},0.2);
  p = semilogx(centrespClampRaw2Interp, dPrimeRiseMeanpClampRaw2InterpSmooth, 'LineWidth',1, 'Color',colours{3});
  legends{13} = [legends{13} p];
  ciplot(dPrimeRiseMeanpClampRaw2InterpSmooth+dPrimeRiseCI95pClampRaw2InterpSmooth(1,:),...
    dPrimeRiseMeanpClampRaw2InterpSmooth+dPrimeRiseCI95pClampRaw2InterpSmooth(2,:),...
    centrespClampRaw2Interp,colours{3},0.2);
  hold off

  if strcmpi(testType{iTest}, 'test1')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 2.6];
    yTicks = 0:0.5:3;
    legendLocation = 'SouthEast';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 3.5];
    yTicks = -1:7;
    legendLocation = 'SouthEast';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-1 -1e-3];
    xTicks = [-1 -0.1 -0.01 -1e-3];
    xTickLabels = {'1000','100','10','1'};
    yLim = [0 3];
    yTicks = 0:3;
    legendLocation = 'SouthEast';
  end
  if displayLegends
    legend(legends{13},legendString, 'Location',legendLocation);
    legend boxoff
  end

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'd''', yLim, yTicks);
  xticklabels(xTickLabels);
  set(figures(13), 'color','w');
  figName = 'risingdPrime';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(13), gca, width, height, label, margin, 0);
  hgsave(figures(13), [targetDir filesep figName '.fig']);
  exportFig(figures(13), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(13), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(13));

  %% 14. Performance on the decay phase: d'
  smoothingWindowSize = 41;
  [dPrimeDecayMeanMinis, dPrimeDecayCI95Minis, centresMinis] = dPrimeCalcDecay(decayDetectionPerformanceMinis);
  [centresMinisInterp, dPrimeDecayMeanMinisInterpSmooth] = interpSmooth(centresMinis, dPrimeDecayMeanMinis, smoothingWindowSize, true);
  dPrimeDecayCI95MinisInterpSmooth = zeros(1,numel(dPrimeDecayMeanMinisInterpSmooth));
  [~, dPrimeDecayCI95MinisInterpSmooth(1,:)] = interpSmooth(centresMinis, dPrimeDecayCI95Minis(1,:), smoothingWindowSize, true);
  [~, dPrimeDecayCI95MinisInterpSmooth(2,:)] = interpSmooth(centresMinis, dPrimeDecayCI95Minis(2,:), smoothingWindowSize, true);
  [dPrimeDecayMeanMiniAnalysis, dPrimeDecayCI95MiniAnalysis, centresMiniAnalysis] = dPrimeCalcDecay(decayDetectionPerformanceMiniAnalysis);
  [centresMiniAnalysisInterp, dPrimeDecayMeanMiniAnalysisInterpSmooth] = interpSmooth(centresMiniAnalysis, dPrimeDecayMeanMiniAnalysis, smoothingWindowSize, true);
  dPrimeDecayCI95MiniAnalysisInterpSmooth = zeros(1,numel(dPrimeDecayMeanMiniAnalysisInterpSmooth));
  [~, dPrimeDecayCI95MiniAnalysisInterpSmooth(1,:)] = interpSmooth(centresMiniAnalysis, dPrimeDecayCI95MiniAnalysis(1,:), smoothingWindowSize, true);
  [~, dPrimeDecayCI95MiniAnalysisInterpSmooth(2,:)] = interpSmooth(centresMiniAnalysis, dPrimeDecayCI95MiniAnalysis(2,:), smoothingWindowSize, true);
  [dPrimeDecayMeanpClampRaw2, dPrimeDecayCI95pClampRaw2, centrespClampRaw2] = dPrimeCalcDecay(decayDetectionPerformancepClampRaw2);
  [centrespClampRaw2Interp, dPrimeDecayMeanpClampRaw2InterpSmooth] = interpSmooth(centrespClampRaw2, dPrimeDecayMeanpClampRaw2, smoothingWindowSize, true);
  dPrimeDecayCI95pClampRaw2InterpSmooth = zeros(1,numel(dPrimeDecayMeanpClampRaw2InterpSmooth));
  [~, dPrimeDecayCI95pClampRaw2InterpSmooth(1,:)] = interpSmooth(centrespClampRaw2, dPrimeDecayCI95pClampRaw2(1,:), smoothingWindowSize, true);
  [~, dPrimeDecayCI95pClampRaw2InterpSmooth(2,:)] = interpSmooth(centrespClampRaw2, dPrimeDecayCI95pClampRaw2(2,:), smoothingWindowSize, true);
  colours = {matlabColours(8),'r','m'};
  figures(14) = figure;
  p = semilogx(centresMinisInterp, dPrimeDecayMeanMinisInterpSmooth, 'LineWidth',1, 'Color',colours{1}); hold on
  legends{14} = [legends{14} p];
  ciplot(dPrimeDecayMeanMinisInterpSmooth+dPrimeDecayCI95MinisInterpSmooth(1,:),...
    dPrimeDecayMeanMinisInterpSmooth+dPrimeDecayCI95MinisInterpSmooth(2,:),...
    centresMinisInterp,colours{1},0.2);
  p = semilogx(centresMiniAnalysisInterp, dPrimeDecayMeanMiniAnalysisInterpSmooth, 'LineWidth',1, 'Color',colours{2});
  legends{14} = [legends{14} p];
  ciplot(dPrimeDecayMeanMiniAnalysisInterpSmooth+dPrimeDecayCI95MiniAnalysisInterpSmooth(1,:),...
    dPrimeDecayMeanMiniAnalysisInterpSmooth+dPrimeDecayCI95MiniAnalysisInterpSmooth(2,:),...
    centresMiniAnalysisInterp,colours{2},0.2);
  p = semilogx(centrespClampRaw2Interp, dPrimeDecayMeanpClampRaw2InterpSmooth, 'LineWidth',1, 'Color',colours{3});
  legends{14} = [legends{14} p];
  ciplot(dPrimeDecayMeanpClampRaw2InterpSmooth+dPrimeDecayCI95pClampRaw2InterpSmooth(1,:),...
    dPrimeDecayMeanpClampRaw2InterpSmooth+dPrimeDecayCI95pClampRaw2InterpSmooth(2,:),...
    centrespClampRaw2Interp,colours{3},0.2);
  hold off

  if strcmpi(testType{iTest}, 'test1')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [-0.5 3.75];
    yTicks = -1:0.5:7;
    legendLocation = 'SouthEast';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [0 3.5];
    yTicks = 0:7;
    legendLocation = 'NorthEast';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [-0.2 -1e-3];
    xTicks = [-0.1 -1e-2 -1e-3];
    xTickLabels = {'-100','-10','-1'};
    yLim = [-0.1 3.5];
    yTicks = -2:3;
    legendLocation = 'NorthEast';
  end
  if displayLegends
    legend(legends{14},legendString, 'Location',legendLocation);
    legend boxoff
  end

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'V_M rate of change (\muV/ms)', xLim, xTicks,...
    'on', 'k', 'd''', yLim, yTicks);
  xticklabels(xTickLabels);
  set(figures(14), 'color','w');
  figName = 'decaydPrime';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(14), gca, width, height, label, margin, 0);
  hgsave(figures(14), [targetDir filesep figName '.fig']);
  exportFig(figures(14), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(14), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(14));

  %% 15. Performance on the flat phase: d'
  smoothingWindowSize = 41;
  [dPrimeFlatMeanMinis, dPrimeFlatCI95Minis, centresMinis] = dPrimeCalcFlat(decayDetectionPerformanceMinis);
  [centresMinisInterp, dPrimeFlatMeanMinisInterpSmooth] = interpSmooth(centresMinis, dPrimeFlatMeanMinis, smoothingWindowSize, true);
  dPrimeFlatCI95MinisInterpSmooth = zeros(1,numel(dPrimeFlatMeanMinisInterpSmooth));
  [~, dPrimeFlatCI95MinisInterpSmooth(1,:)] = interpSmooth(centresMinis, dPrimeFlatCI95Minis(1,:), smoothingWindowSize, true);
  [~, dPrimeFlatCI95MinisInterpSmooth(2,:)] = interpSmooth(centresMinis, dPrimeFlatCI95Minis(2,:), smoothingWindowSize, true);
  [dPrimeFlatMeanMiniAnalysis, dPrimeFlatCI95MiniAnalysis, centresMiniAnalysis] = dPrimeCalcFlat(decayDetectionPerformanceMiniAnalysis);
  [centresMiniAnalysisInterp, dPrimeFlatMeanMiniAnalysisInterpSmooth] = interpSmooth(centresMiniAnalysis, dPrimeFlatMeanMiniAnalysis, smoothingWindowSize, true);
  dPrimeFlatCI95MiniAnalysisInterpSmooth = zeros(1,numel(dPrimeFlatMeanMiniAnalysisInterpSmooth));
  [~, dPrimeFlatCI95MiniAnalysisInterpSmooth(1,:)] = interpSmooth(centresMiniAnalysis, dPrimeFlatCI95MiniAnalysis(1,:), smoothingWindowSize, true);
  [~, dPrimeFlatCI95MiniAnalysisInterpSmooth(2,:)] = interpSmooth(centresMiniAnalysis, dPrimeFlatCI95MiniAnalysis(2,:), smoothingWindowSize, true);
  [dPrimeFlatMeanpClampRaw2, dPrimeFlatCI95pClampRaw2, centrespClampRaw2] = dPrimeCalcFlat(decayDetectionPerformancepClampRaw2);
  [centrespClampRaw2Interp, dPrimeFlatMeanpClampRaw2InterpSmooth] = interpSmooth(centrespClampRaw2, dPrimeFlatMeanpClampRaw2, smoothingWindowSize, true);
  dPrimeFlatCI95pClampRaw2InterpSmooth = zeros(1,numel(dPrimeFlatMeanpClampRaw2InterpSmooth));
  [~, dPrimeFlatCI95pClampRaw2InterpSmooth(1,:)] = interpSmooth(centrespClampRaw2, dPrimeFlatCI95pClampRaw2(1,:), smoothingWindowSize, true);
  [~, dPrimeFlatCI95pClampRaw2InterpSmooth(2,:)] = interpSmooth(centrespClampRaw2, dPrimeFlatCI95pClampRaw2(2,:), smoothingWindowSize, true);
  colours = {matlabColours(8),'r','m'};
  figures(15) = figure;
  p = semilogx(centresMinisInterp, dPrimeFlatMeanMinisInterpSmooth, 'LineWidth',1, 'Color',colours{1}); hold on
  legends{15} = [legends{15} p];
  ciplot(dPrimeFlatMeanMinisInterpSmooth+dPrimeFlatCI95MinisInterpSmooth(1,:),...
    dPrimeFlatMeanMinisInterpSmooth+dPrimeFlatCI95MinisInterpSmooth(2,:),...
    centresMinisInterp,colours{1},0.2);
  p = semilogx(centresMiniAnalysisInterp, dPrimeFlatMeanMiniAnalysisInterpSmooth, 'LineWidth',1, 'Color',colours{2});
  legends{15} = [legends{15} p];
  ciplot(dPrimeFlatMeanMiniAnalysisInterpSmooth+dPrimeFlatCI95MiniAnalysisInterpSmooth(1,:),...
    dPrimeFlatMeanMiniAnalysisInterpSmooth+dPrimeFlatCI95MiniAnalysisInterpSmooth(2,:),...
    centresMiniAnalysisInterp,colours{2},0.2);
  p = semilogx(centrespClampRaw2Interp, dPrimeFlatMeanpClampRaw2InterpSmooth, 'LineWidth',1, 'Color',colours{3});
  legends{15} = [legends{15} p];
  ciplot(dPrimeFlatMeanpClampRaw2InterpSmooth+dPrimeFlatCI95pClampRaw2InterpSmooth(1,:),...
    dPrimeFlatMeanpClampRaw2InterpSmooth+dPrimeFlatCI95pClampRaw2InterpSmooth(2,:),...
    centrespClampRaw2Interp,colours{3},0.2);
  hold off

  if strcmpi(testType{iTest}, 'test1')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 4];
    yTicks = 0:5;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 3.5];
    yTicks = 0:5;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [0 3.5];
    yTicks = -1:5;
    legendLocation = 'NorthEast';
  end
  if displayLegends
    legend(legends{15},legendString, 'Location',legendLocation);
    legend boxoff
  end

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'Time to neighbour (ms)', xLim, xTicks,...
    'on', 'k', 'd''', yLim, yTicks);
  xticklabels(xTickLabels);
  set(figures(15), 'color','w');
  figName = 'flatdPrime';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(figures(15), gca, width, height, label, margin, 0);
  hgsave(figures(15), [targetDir filesep figName '.fig']);
  exportFig(figures(15), [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(figures(15), [targetDir filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(figures(15));
end
close all



%% Local functions
function [figures, legends, outputData] = summaryDecay(noiseFile, folder, figures, legends, colour, performanceFile, performanceField, dt, adjustRates)

if nargin < 7
  performanceField = 'decayDetectionPerformanceMinis';
end
if nargin < 6
  performanceFile = [];
end
if nargin < 5
  colour = matlabColours(8);
end
if nargin < 4 || isempty(legends)
  legends{1} =  [];
  legends{2} =  [];
  legends{3} =  [];
  legends{4} =  [];
  legends{5} =  [];
  legends{6} =  [];
  legends{7} =  [];
  legends{8} =  [];
  legends{9} =  [];
  legends{10} = [];
  legends{11} = [];
  legends{12} = [];
  legends{13} = [];
  legends{14} = [];
  legends{15} = [];
end

if isempty(performanceFile) || ~exist(performanceFile, 'file')
  hitsRiseDiffRecording = {};
  missesRiseDiffRecording = {};
  falseAlarmsRiseDiffRecording = {};
  correctRejectionsRiseDiffRecording = {};
  hitsDecayDiffRecording = {};
  missesDecayDiffRecording = {};
  falseAlarmsDecayDiffRecording = {};
  correctRejectionsDecayDiffRecording = {};
  hitsFlatDiffRecording = {};
  missesFlatDiffRecording = {};
  falseAlarmsFlatDiffRecording = {};
  correctRejectionsFlatDiffRecording = {};
  hitsFlatD2NRecording = {};
  missesFlatD2NRecording = {};
  falseAlarmsFlatD2NRecording = {};
  correctRejectionsFlatD2NRecording = {};
  nConditions = 9;
  sensitivityRiseRecording = NaN(numel(folder),nConditions);
  specificityRiseRecording = NaN(numel(folder),nConditions);
  FPRRiseRecording = NaN(numel(folder),nConditions);
  dPrimeRiseRecording = NaN(numel(folder),nConditions);
  sensitivityDecayRecording = NaN(numel(folder),nConditions);
  specificityDecayRecording = NaN(numel(folder),nConditions);
  FPRDecayRecording = NaN(numel(folder),nConditions);
  dPrimeDecayRecording = NaN(numel(folder),nConditions);
  sensitivityFlatRecording = NaN(numel(folder),nConditions);
  specificityFlatRecording = NaN(numel(folder),nConditions);
  FPRFlatRecording = NaN(numel(folder),nConditions);
  dPrimeFlatRecording = NaN(numel(folder),nConditions);
  for iF = 1:numel(folder)
    % Load the noise file
    [noiseProperties, dt] = loadabfWrap(noiseFile{iF});

    simFilt = designFilterLP(500, 750, 0.5, 2, 1000/dt);
    noiseRawSweep = [];
    hitsRiseDiff = [];
    missesRiseDiff = [];
    falseAlarmsRiseDiff = [];
    correctRejectionsRiseDiff = [];
    hitsDecayDiff = [];
    missesDecayDiff = [];
    falseAlarmsDecayDiff = [];
    correctRejectionsDecayDiff = [];
    hitsFlatDiff = [];
    missesFlatDiff = [];
    falseAlarmsFlatDiff = [];
    correctRejectionsFlatDiff = [];
    hitsFlatD2N = [];
    missesFlatD2N = [];
    falseAlarmsFlatD2N = [];
    correctRejectionsFlatD2N = [];
    d = dir(folder{iF});

    [hitsRiseDiff, missesRiseDiff, falseAlarmsRiseDiff, correctRejectionsRiseDiff,...
      sensitivityRiseRecording, specificityRiseRecording, FPRRiseRecording, dPrimeRiseRecording,...
      hitsRiseRecording, missesRiseRecording, falseAlarmsRiseRecording, correctRejectionsRiseRecording] = risePerformance(...
      folder, iF, d, noiseProperties, dt, simFilt, noiseRawSweep,...
      hitsRiseDiff, missesRiseDiff, falseAlarmsRiseDiff, correctRejectionsRiseDiff,...
      sensitivityRiseRecording, specificityRiseRecording, FPRRiseRecording, dPrimeRiseRecording);
    hitsRiseDiffRecording = [hitsRiseDiffRecording; hitsRiseDiff];
    missesRiseDiffRecording = [missesRiseDiffRecording; missesRiseDiff];
    falseAlarmsRiseDiffRecording = [falseAlarmsRiseDiffRecording; falseAlarmsRiseDiff];
    correctRejectionsRiseDiffRecording = [correctRejectionsRiseDiffRecording; correctRejectionsRiseDiff];

    [hitsDecayDiff, missesDecayDiff, falseAlarmsDecayDiff, correctRejectionsDecayDiff,...
      hitsFlatDiff, missesFlatDiff, falseAlarmsFlatDiff, correctRejectionsFlatDiff,...
      hitsFlatD2N, missesFlatD2N, falseAlarmsFlatD2N, correctRejectionsFlatD2N,...
      sensitivityDecayRecording, specificityDecayRecording, FPRDecayRecording, dPrimeDecayRecording] = decayPerformance(...
      folder, iF, d, noiseProperties, dt, simFilt, noiseRawSweep,...
      hitsDecayDiff, missesDecayDiff, falseAlarmsDecayDiff, correctRejectionsDecayDiff,...
      hitsFlatDiff, missesFlatDiff, falseAlarmsFlatDiff, correctRejectionsFlatDiff,...
      hitsFlatD2N, missesFlatD2N, falseAlarmsFlatD2N, correctRejectionsFlatD2N,...
      sensitivityDecayRecording, specificityDecayRecording, FPRDecayRecording, dPrimeDecayRecording,...
      hitsRiseRecording, missesRiseRecording, falseAlarmsRiseRecording, correctRejectionsRiseRecording);
    hitsDecayDiffRecording = [hitsDecayDiffRecording; hitsDecayDiff];
    missesDecayDiffRecording = [missesDecayDiffRecording; missesDecayDiff];
    falseAlarmsDecayDiffRecording = [falseAlarmsDecayDiffRecording; falseAlarmsDecayDiff];
    correctRejectionsDecayDiffRecording = [correctRejectionsDecayDiffRecording; correctRejectionsDecayDiff];
    hitsFlatDiffRecording = [hitsFlatDiffRecording; hitsFlatDiff];
    missesFlatDiffRecording = [missesFlatDiffRecording; missesFlatDiff];
    falseAlarmsFlatDiffRecording = [falseAlarmsFlatDiffRecording; falseAlarmsFlatDiff];
    correctRejectionsFlatDiffRecording = [correctRejectionsFlatDiffRecording; correctRejectionsFlatDiff];
    hitsFlatD2NRecording = [hitsFlatD2NRecording; hitsFlatD2N];
    missesFlatD2NRecording = [missesFlatD2NRecording; missesFlatD2N];
    falseAlarmsFlatD2NRecording = [falseAlarmsFlatD2NRecording; falseAlarmsFlatD2N];
    correctRejectionsFlatD2NRecording = [correctRejectionsFlatD2NRecording; correctRejectionsFlatD2N];
  end

  % Calculate distributions
  [nHitsPDFPerRecordingMeanRise, nHitsPDFPerRecordingCI95Rise, nHitsCDFPerRecordingMeanRise, nHitsCDFPerRecordingCI95Rise, edgesRise, centresRise, nHitsPDFPerRecordingRise] = calcDistros(hitsRiseDiffRecording, missesRiseDiffRecording, folder, 0.0001);
  [nFalseAlarmsPDFPerRecordingMeanRise, nFalseAlarmsPDFPerRecordingCI95Rise, nFalseAlarmsCDFPerRecordingMeanRise, nFalseAlarmsCDFPerRecordingCI95Rise, edgesRise2, centresRise2, nFalseAlarmsPDFPerRecordingRise] = calcDistros(falseAlarmsRiseDiffRecording, correctRejectionsRiseDiffRecording, folder, 0.0001);
  [nHitsPDFPerRecordingMeanDecay, nHitsPDFPerRecordingCI95Decay, nHitsCDFPerRecordingMeanDecay, nHitsCDFPerRecordingCI95Decay, edgesDecay, centresDecay, nHitsPDFPerRecordingDecay] = calcDistros(hitsDecayDiffRecording, missesDecayDiffRecording, folder, 0.0001);
  [nFalseAlarmsPDFPerRecordingMeanDecay, nFalseAlarmsPDFPerRecordingCI95Decay, nFalseAlarmsCDFPerRecordingMeanDecay, nFalseAlarmsCDFPerRecordingCI95Decay, edgesDecay2, centresDecay2, nFalseAlarmsPDFPerRecordingDecay] = calcDistros(falseAlarmsDecayDiffRecording, correctRejectionsDecayDiffRecording, folder, 0.0001);
  [nHitsPDFPerRecordingMeanFlat, nHitsPDFPerRecordingCI95Flat, nHitsCDFPerRecordingMeanFlat, nHitsCDFPerRecordingCI95Flat, edgesFlat, centresFlat, nHitsPDFPerRecordingFlat] = calcDistros(hitsFlatDiffRecording, missesFlatDiffRecording, folder, 0.0001);
  [nFalseAlarmsPDFPerRecordingMeanFlat, nFalseAlarmsPDFPerRecordingCI95Flat, nFalseAlarmsCDFPerRecordingMeanFlat, nFalseAlarmsCDFPerRecordingCI95Flat, edgesFlat2, centresFlat2, nFalseAlarmsPDFPerRecordingFlat] = calcDistros(falseAlarmsFlatDiffRecording, correctRejectionsFlatDiffRecording, folder, 0.0001);
  [nHitsPDFPerRecordingMeanFlatD2N, nHitsPDFPerRecordingCI95FlatD2N, nHitsCDFPerRecordingMeanFlatD2N, nHitsCDFPerRecordingCI95FlatD2N, edgesFlatD2N, centresFlatD2N, nHitsPDFPerRecordingFlatD2N] = calcDistanceDistros(hitsFlatD2NRecording, missesFlatD2NRecording, folder, 0.1);
  [nFalseAlarmsPDFPerRecordingMeanFlatD2N, nFalseAlarmsPDFPerRecordingCI95FlatD2N, nFalseAlarmsCDFPerRecordingMeanFlatD2N, nFalseAlarmsCDFPerRecordingCI95FlatD2N, edgesFlatD2N2, centresFlatD2N2, nFalseAlarmsPDFPerRecordingFlatD2N] = calcDistanceDistros(falseAlarmsFlatD2NRecording, correctRejectionsFlatD2NRecording, folder, 1);
else
  inputData = load(performanceFile); %#ok<*LOAD>
  hitsRiseDiffRecording = inputData.(performanceField).hitsRiseDiffRecording;
  missesRiseDiffRecording = inputData.(performanceField).missesRiseDiffRecording;
  falseAlarmsRiseDiffRecording = inputData.(performanceField).falseAlarmsRiseDiffRecording;
  correctRejectionsRiseDiffRecording = inputData.(performanceField).correctRejectionsRiseDiffRecording;
  hitsDecayDiffRecording = inputData.(performanceField).hitsDecayDiffRecording;
  missesDecayDiffRecording = inputData.(performanceField).missesDecayDiffRecording;
  falseAlarmsDecayDiffRecording = inputData.(performanceField).falseAlarmsDecayDiffRecording;
  correctRejectionsDecayDiffRecording = inputData.(performanceField).correctRejectionsDecayDiffRecording;
  hitsFlatDiffRecording = inputData.(performanceField).hitsFlatDiffRecording;
  missesFlatDiffRecording = inputData.(performanceField).missesFlatDiffRecording;
  falseAlarmsFlatDiffRecording = inputData.(performanceField).falseAlarmsFlatDiffRecording;
  correctRejectionsFlatDiffRecording = inputData.(performanceField).correctRejectionsFlatDiffRecording;
  sensitivityRiseRecording = inputData.(performanceField).sensitivityRiseRecording; %#ok<*NODEF>
  specificityRiseRecording = inputData.(performanceField).specificityRiseRecording;
  FPRRiseRecording = inputData.(performanceField).FPRRiseRecording;
  dPrimeRiseRecording = inputData.(performanceField).dPrimeRiseRecording;
  sensitivityDecayRecording = inputData.(performanceField).sensitivityDecayRecording; %#ok<*NODEF>
  specificityDecayRecording = inputData.(performanceField).specificityDecayRecording;
  FPRDecayRecording = inputData.(performanceField).FPRDecayRecording;
  dPrimeDecayRecording = inputData.(performanceField).dPrimeDecayRecording;
  sensitivityFlatRecording = inputData.(performanceField).sensitivityFlatRecording;
  specificityFlatRecording = inputData.(performanceField).specificityFlatRecording;
  FPRFlatRecording = inputData.(performanceField).FPRFlatRecording;
  dPrimeFlatRecording = inputData.(performanceField).dPrimeFlatRecording;
  nHitsPDFPerRecordingMeanRise = inputData.(performanceField).nHitsPDFPerRecordingMeanRise;
  nHitsPDFPerRecordingRise = inputData.(performanceField).nHitsPDFPerRecordingRise;
  nHitsPDFPerRecordingCI95Rise = inputData.(performanceField).nHitsPDFPerRecordingCI95Rise;
  nHitsCDFPerRecordingMeanRise = inputData.(performanceField).nHitsCDFPerRecordingMeanRise;
  nHitsCDFPerRecordingCI95Rise = inputData.(performanceField).nHitsCDFPerRecordingCI95Rise;
  nHitsPDFPerRecordingMeanDecay = inputData.(performanceField).nHitsPDFPerRecordingMeanDecay;
  nHitsPDFPerRecordingDecay = inputData.(performanceField).nHitsPDFPerRecordingDecay;
  nHitsPDFPerRecordingCI95Decay = inputData.(performanceField).nHitsPDFPerRecordingCI95Decay;
  nHitsCDFPerRecordingMeanDecay = inputData.(performanceField).nHitsCDFPerRecordingMeanDecay;
  nHitsCDFPerRecordingCI95Decay = inputData.(performanceField).nHitsCDFPerRecordingCI95Decay;
  nHitsPDFPerRecordingMeanFlat = inputData.(performanceField).nHitsPDFPerRecordingMeanFlat;
  nHitsPDFPerRecordingFlat = inputData.(performanceField).nHitsPDFPerRecordingFlat;
  nHitsPDFPerRecordingCI95Flat = inputData.(performanceField).nHitsPDFPerRecordingCI95Flat;
  nHitsCDFPerRecordingMeanFlat = inputData.(performanceField).nHitsCDFPerRecordingMeanFlat;
  nHitsCDFPerRecordingCI95Flat = inputData.(performanceField).nHitsCDFPerRecordingCI95Flat;
  nHitsPDFPerRecordingMeanFlatD2N = inputData.(performanceField).nHitsPDFPerRecordingMeanFlatD2N;
  nHitsPDFPerRecordingFlatD2N = inputData.(performanceField).nHitsPDFPerRecordingFlatD2N;
  nHitsPDFPerRecordingCI95FlatD2N = inputData.(performanceField).nHitsPDFPerRecordingCI95FlatD2N;
  nHitsCDFPerRecordingMeanFlatD2N = inputData.(performanceField).nHitsCDFPerRecordingMeanFlatD2N;
  nHitsCDFPerRecordingCI95FlatD2N = inputData.(performanceField).nHitsCDFPerRecordingCI95FlatD2N;
  edgesRise = inputData.(performanceField).edgesRise;
  centresRise = inputData.(performanceField).centresRise;
  edgesDecay = inputData.(performanceField).edgesDecay;
  centresDecay = inputData.(performanceField).centresDecay;
  edgesFlat = inputData.(performanceField).edgesFlat;
  centresFlat = inputData.(performanceField).centresFlat;
  edgesFlatD2N = inputData.(performanceField).edgesFlatD2N;
  centresFlatD2N = inputData.(performanceField).centresFlatD2N;
  nFalseAlarmsPDFPerRecordingMeanRise = inputData.(performanceField).nFalseAlarmsPDFPerRecordingMeanRise;
  nFalseAlarmsPDFPerRecordingRise = inputData.(performanceField).nFalseAlarmsPDFPerRecordingRise;
  nFalseAlarmsPDFPerRecordingCI95Rise = inputData.(performanceField).nFalseAlarmsPDFPerRecordingCI95Rise;
  nFalseAlarmsCDFPerRecordingMeanRise = inputData.(performanceField).nFalseAlarmsCDFPerRecordingMeanRise;
  nFalseAlarmsCDFPerRecordingCI95Rise = inputData.(performanceField).nFalseAlarmsCDFPerRecordingCI95Rise;
  nFalseAlarmsPDFPerRecordingMeanDecay = inputData.(performanceField).nFalseAlarmsPDFPerRecordingMeanDecay;
  nFalseAlarmsPDFPerRecordingDecay = inputData.(performanceField).nFalseAlarmsPDFPerRecordingDecay;
  nFalseAlarmsPDFPerRecordingCI95Decay = inputData.(performanceField).nFalseAlarmsPDFPerRecordingCI95Decay;
  nFalseAlarmsCDFPerRecordingMeanDecay = inputData.(performanceField).nFalseAlarmsCDFPerRecordingMeanDecay;
  nFalseAlarmsCDFPerRecordingCI95Decay = inputData.(performanceField).nFalseAlarmsCDFPerRecordingCI95Decay;
  nFalseAlarmsPDFPerRecordingMeanFlat = inputData.(performanceField).nFalseAlarmsPDFPerRecordingMeanFlat;
  nFalseAlarmsPDFPerRecordingFlat = inputData.(performanceField).nFalseAlarmsPDFPerRecordingFlat;
  nFalseAlarmsPDFPerRecordingCI95Flat = inputData.(performanceField).nFalseAlarmsPDFPerRecordingCI95Flat;
  nFalseAlarmsCDFPerRecordingMeanFlat = inputData.(performanceField).nFalseAlarmsCDFPerRecordingMeanFlat;
  nFalseAlarmsCDFPerRecordingCI95Flat = inputData.(performanceField).nFalseAlarmsCDFPerRecordingCI95Flat;
  nFalseAlarmsPDFPerRecordingMeanFlatD2N = inputData.(performanceField).nFalseAlarmsPDFPerRecordingMeanFlatD2N;
  nFalseAlarmsPDFPerRecordingFlatD2N = inputData.(performanceField).nFalseAlarmsPDFPerRecordingFlatD2N;
  nFalseAlarmsPDFPerRecordingCI95FlatD2N = inputData.(performanceField).nFalseAlarmsPDFPerRecordingCI95FlatD2N;
  nFalseAlarmsCDFPerRecordingMeanFlatD2N = inputData.(performanceField).nFalseAlarmsCDFPerRecordingMeanFlatD2N;
  nFalseAlarmsCDFPerRecordingCI95FlatD2N = inputData.(performanceField).nFalseAlarmsCDFPerRecordingCI95FlatD2N;
  edgesRise2 = inputData.(performanceField).edgesRise2;
  centresRise2 = inputData.(performanceField).centresRise2;
  edgesDecay2 = inputData.(performanceField).edgesDecay2;
  centresDecay2 = inputData.(performanceField).centresDecay2;
  edgesFlat2 = inputData.(performanceField).edgesFlat2;
  centresFlat2 = inputData.(performanceField).centresFlat2;
  edgesFlatD2N2 = inputData.(performanceField).edgesFlatD2N2;
  centresFlatD2N2 = inputData.(performanceField).centresFlatD2N2;
end

% Probability of detecting a mini as a function of membrane potential rate of change (with 95% CI): Rising phase
if nargin < 2 || isempty(figures) || numel(figures) < 1
  figures(1) = figure;
else
  figure(figures(1)); hold on
end
smoothingWindowSize = 41;
[centresRiseInterp, nHitsPDFPerRecordingMeanRiseInterpSmooth] = interpSmooth(centresRise, nHitsPDFPerRecordingMeanRise, smoothingWindowSize, true);
if adjustRates
  centresRiseInterp = centresRiseInterp./dt;
end
nHitsPDFPerRecordingCI95RiseInterpSmooth = zeros(1,numel(centresRiseInterp));
[~, nHitsPDFPerRecordingCI95RiseInterpSmooth(1,:)] = interpSmooth(centresRise, nHitsPDFPerRecordingCI95Rise(1,:), smoothingWindowSize, true);
[~, nHitsPDFPerRecordingCI95RiseInterpSmooth(2,:)] = interpSmooth(centresRise, nHitsPDFPerRecordingCI95Rise(2,:), smoothingWindowSize, true);
p = semilogx(centresRiseInterp(~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth)), nHitsPDFPerRecordingMeanRiseInterpSmooth(~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{1} = [legends{1} p];
ciplot(nHitsPDFPerRecordingMeanRiseInterpSmooth(~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95RiseInterpSmooth(1,:))) +...
  nHitsPDFPerRecordingCI95RiseInterpSmooth(1,~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95RiseInterpSmooth(1,:))),...
  nHitsPDFPerRecordingMeanRiseInterpSmooth(~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95RiseInterpSmooth(2,:))) +...
  nHitsPDFPerRecordingCI95RiseInterpSmooth(2,~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95RiseInterpSmooth(2,:))),...
  centresRiseInterp(~isnan(nHitsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95RiseInterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of detecting a mini as a function of membrane potential rate of change (with 95% CI): Rising phase
if nargin < 2 || isempty(figures) || numel(figures) < 2
  figures(2) = figure;
else
  figure(figures(2)); hold on
end
if adjustRates
  centresRise = centresRise./dt;
end
p = semilogx(centresRise, nHitsCDFPerRecordingMeanRise, 'LineWidth',1, 'Color',colour); hold on
legends{2} = [legends{2} p];
ciplot(nHitsCDFPerRecordingMeanRise+nHitsCDFPerRecordingCI95Rise(1,:),...
  nHitsCDFPerRecordingMeanRise+nHitsCDFPerRecordingCI95Rise(2,:),centresRise,colour,0.2);
hold off

% Probability of detecting a mini as a function of membrane potential rate of change (with 95% CI): Decay phase
if nargin < 2 || isempty(figures) || numel(figures) < 3
  figures(3) = figure;
else
  figure(figures(3)); hold on
end
smoothingWindowSize = 41;
[centresDecayInterp, nHitsPDFPerRecordingMeanDecayInterpSmooth] = interpSmooth(centresDecay, nHitsPDFPerRecordingMeanDecay, smoothingWindowSize, true);
if adjustRates
  centresDecayInterp = centresDecayInterp./dt;
end
nHitsPDFPerRecordingCI95DecayInterpSmooth = zeros(1,numel(centresDecayInterp));
[~, nHitsPDFPerRecordingCI95DecayInterpSmooth(1,:)] = interpSmooth(centresDecay, nHitsPDFPerRecordingCI95Decay(1,:), smoothingWindowSize, true);
[~, nHitsPDFPerRecordingCI95DecayInterpSmooth(2,:)] = interpSmooth(centresDecay, nHitsPDFPerRecordingCI95Decay(2,:), smoothingWindowSize, true);
p = semilogx(centresDecayInterp(~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth)), nHitsPDFPerRecordingMeanDecayInterpSmooth(~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{3} = [legends{3} p];
ciplot(nHitsPDFPerRecordingMeanDecayInterpSmooth(~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95DecayInterpSmooth(1,:))) +...
  nHitsPDFPerRecordingCI95DecayInterpSmooth(1,~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95DecayInterpSmooth(1,:))),...
  nHitsPDFPerRecordingMeanDecayInterpSmooth(~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95DecayInterpSmooth(2,:))) +...
  nHitsPDFPerRecordingCI95DecayInterpSmooth(2,~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95DecayInterpSmooth(2,:))),...
  centresDecayInterp(~isnan(nHitsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95DecayInterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of detecting a mini as a function of membrane potential rate of change (with 95% CI): Decay phase
if nargin < 2 || isempty(figures) || numel(figures) < 4
  figures(4) = figure;
else
  figure(figures(4)); hold on
end
if adjustRates
  centresDecay = centresDecay./dt;
end
p = semilogx(centresDecay, nHitsCDFPerRecordingMeanDecay, 'LineWidth',1, 'Color',colour); hold on
legends{4} = [legends{4} p];
ciplot(nHitsCDFPerRecordingMeanDecay+nHitsCDFPerRecordingCI95Decay(1,:),...
  nHitsCDFPerRecordingMeanDecay+nHitsCDFPerRecordingCI95Decay(2,:),centresDecay,colour,0.2);
hold off

% Probability of detecting a mini as a function of the time to the nearest neighbour (with 95% CI): Flat phase
if nargin < 2 || isempty(figures) || numel(figures) < 5
  figures(5) = figure;
else
  figure(figures(5)); hold on
end
smoothingWindowSize = 41;
[centresFlatD2NInterp, nHitsPDFPerRecordingMeanFlatD2NInterpSmooth] = interpSmooth(centresFlatD2N, nHitsPDFPerRecordingMeanFlatD2N, smoothingWindowSize, true);
nHitsPDFPerRecordingCI95FlatD2NInterpSmooth = zeros(1,numel(centresFlatD2NInterp));
[~, nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:)] = interpSmooth(centresFlatD2N, nHitsPDFPerRecordingCI95FlatD2N(1,:), smoothingWindowSize, true);
[~, nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(2,:)] = interpSmooth(centresFlatD2N, nHitsPDFPerRecordingCI95FlatD2N(2,:), smoothingWindowSize, true);
p = semilogx(centresFlatD2NInterp(~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth)), nHitsPDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{5} = [legends{5} p];
ciplot(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:))) +...
  nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(1,~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:))),...
  nHitsPDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(2,:))) +...
  nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(2,~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(2,:))),...
  centresFlatD2NInterp(~isnan(nHitsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of detecting a mini as a function of the time to the nearest neighbour (with 95% CI): Flat phase
if nargin < 2 || isempty(figures) || numel(figures) < 6
  figures(6) = figure;
else
  figure(figures(6)); hold on
end
p = semilogx(centresFlatD2N, nHitsCDFPerRecordingMeanFlatD2N, 'LineWidth',1, 'Color',colour); hold on
legends{6} = [legends{6} p];
ciplot(nHitsCDFPerRecordingMeanFlatD2N+nHitsCDFPerRecordingCI95FlatD2N(1,:),...
  nHitsCDFPerRecordingMeanFlatD2N+nHitsCDFPerRecordingCI95FlatD2N(2,:),centresFlatD2N,colour,0.2);
hold off

% Probability of a false alarm as a function of membrane potential rate of change (with 95% CI): Rising phase
if nargin < 2 || isempty(figures) || numel(figures) < 7
  figures(7) = figure;
else
  figure(figures(7)); hold on
end
smoothingWindowSize = 41;
[centresRiseInterp, nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth] = interpSmooth(centresRise2, nFalseAlarmsPDFPerRecordingMeanRise, smoothingWindowSize, true);
if adjustRates
  centresRiseInterp = centresRiseInterp./dt;
end
nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth = zeros(1,numel(centresRiseInterp));
[~, nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(1,:)] = interpSmooth(centresRise2, nFalseAlarmsPDFPerRecordingCI95Rise(1,:), smoothingWindowSize, true);
[~, nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(2,:)] = interpSmooth(centresRise2, nFalseAlarmsPDFPerRecordingCI95Rise(2,:), smoothingWindowSize, true);
p = semilogx(centresRiseInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth)), nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{7} = [legends{7} p];
ciplot(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(1,:))) +...
  nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(1,~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(1,:))),...
  nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(2,:))) +...
  nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(2,~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(2,:))),...
  centresRiseInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanRiseInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95RiseInterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of a false alarm as a function of membrane potential rate of change (with 95% CI): Rising phase
if nargin < 2 || isempty(figures) || numel(figures) < 8
  figures(8) = figure;
else
  figure(figures(8)); hold on
end
if adjustRates
  centresRise2 = centresRise2./dt;
end
p = semilogx(centresRise2, nFalseAlarmsCDFPerRecordingMeanRise, 'LineWidth',1, 'Color',colour); hold on
legends{8} = [legends{8} p];
ciplot(nFalseAlarmsCDFPerRecordingMeanRise+nFalseAlarmsCDFPerRecordingCI95Rise(1,:),...
  nFalseAlarmsCDFPerRecordingMeanRise+nFalseAlarmsCDFPerRecordingCI95Rise(2,:),centresRise2,colour,0.2);
hold off

% Probability of a false alarm as a function of membrane potential rate of change (with 95% CI): Decay phase
if nargin < 2 || isempty(figures) || numel(figures) < 9
  figures(9) = figure;
else
  figure(figures(9)); hold on
end
smoothingWindowSize = 41;
[centresDecayInterp, nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth] = interpSmooth(centresDecay2, nFalseAlarmsPDFPerRecordingMeanDecay, smoothingWindowSize, true);
if adjustRates
  centresDecayInterp = centresDecayInterp./dt;
end
nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth = zeros(1,numel(centresDecayInterp));
[~, nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(1,:)] = interpSmooth(centresDecay2, nFalseAlarmsPDFPerRecordingCI95Decay(1,:), smoothingWindowSize, true);
[~, nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(2,:)] = interpSmooth(centresDecay2, nFalseAlarmsPDFPerRecordingCI95Decay(2,:), smoothingWindowSize, true);
p = semilogx(centresDecayInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth)), nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{9} = [legends{9} p];
ciplot(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(1,:))) +...
  nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(1,~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(1,:))),...
  nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(2,:))) +...
  nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(2,~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(2,:))),...
  centresDecayInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanDecayInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95DecayInterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of detecting a mini as a function of membrane potential rate of change (with 95% CI): Decay phase
if nargin < 2 || isempty(figures) || numel(figures) < 10
  figures(10) = figure;
else
  figure(figures(10)); hold on
end
if adjustRates
  centresDecay2 = centresDecay2./dt;
end
p = semilogx(centresDecay2, nFalseAlarmsCDFPerRecordingMeanDecay, 'LineWidth',1, 'Color',colour); hold on
legends{10} = [legends{10} p];
ciplot(nFalseAlarmsCDFPerRecordingMeanDecay+nFalseAlarmsCDFPerRecordingCI95Decay(1,:),...
  nFalseAlarmsCDFPerRecordingMeanDecay+nFalseAlarmsCDFPerRecordingCI95Decay(2,:),centresDecay2,colour,0.2);
hold off

% Probability of a false alarm as a function of the time to the nearest neighbour (with 95% CI): Flat phase
if nargin < 2 || isempty(figures) || numel(figures) < 11
  figures(11) = figure;
else
  figure(figures(11)); hold on
end
smoothingWindowSize = 41;
[centresFlatD2NInterp, nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth] = interpSmooth(centresFlatD2N2, nFalseAlarmsPDFPerRecordingMeanFlatD2N, smoothingWindowSize, true, centresFlatD2N2);
nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth = zeros(1,numel(centresFlatD2NInterp));
[~, nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:)] = interpSmooth(centresFlatD2N2, nFalseAlarmsPDFPerRecordingCI95FlatD2N(1,:), smoothingWindowSize, true, centresFlatD2N2);
[~, nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(2,:)] = interpSmooth(centresFlatD2N2, nFalseAlarmsPDFPerRecordingCI95FlatD2N(2,:), smoothingWindowSize, true, centresFlatD2N2);
p = semilogx(centresFlatD2NInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth)), nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{11} = [legends{11} p];
ciplot(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:))) +...
  nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(1,~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:))),...
  nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(2,:))) +...
  nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(2,~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(2,:))),...
  centresFlatD2NInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95FlatD2NInterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of a false alarm as a function of the time to the nearest neighbour (with 95% CI): Flat phase
if nargin < 2 || isempty(figures) || numel(figures) < 12
  figures(12) = figure;
else
  figure(figures(12)); hold on
end
smoothingWindowSize = 41;
[centresFlatD2NInterp, nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth] = interpSmooth(centresFlatD2N2, nFalseAlarmsCDFPerRecordingMeanFlatD2N, smoothingWindowSize, true, centresFlatD2N2);
nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth = zeros(1,numel(centresFlatD2NInterp));
[~, nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(1,:)] = interpSmooth(centresFlatD2N2, nFalseAlarmsCDFPerRecordingCI95FlatD2N(1,:), smoothingWindowSize, true, centresFlatD2N2);
[~, nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(2,:)] = interpSmooth(centresFlatD2N2, nFalseAlarmsCDFPerRecordingCI95FlatD2N(2,:), smoothingWindowSize, true, centresFlatD2N2);
p = semilogx(centresFlatD2NInterp(~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth)), nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth)),...
  'LineWidth',1, 'Color',colour); hold on
legends{12} = [legends{12} p];
ciplot(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(1,:))) +...
  nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(1,~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(1,:))),...
  nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth(~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(2,:))) +...
  nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(2,~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(2,:))),...
  centresFlatD2NInterp(~isnan(nFalseAlarmsCDFPerRecordingMeanFlatD2NInterpSmooth) & ~isnan(nFalseAlarmsCDFPerRecordingCI95FlatD2NInterpSmooth(1,:))), colour, 0.2);
hold off

% Assign output data
outputData.hitsRiseDiffRecording = hitsRiseDiffRecording;
outputData.missesRiseDiffRecording = missesRiseDiffRecording;
outputData.falseAlarmsRiseDiffRecording = falseAlarmsRiseDiffRecording;
outputData.correctRejectionsRiseDiffRecording = correctRejectionsRiseDiffRecording;
outputData.hitsDecayDiffRecording = hitsDecayDiffRecording;
outputData.missesDecayDiffRecording = missesDecayDiffRecording;
outputData.falseAlarmsDecayDiffRecording = falseAlarmsDecayDiffRecording;
outputData.correctRejectionsDecayDiffRecording = correctRejectionsDecayDiffRecording;
outputData.hitsFlatDiffRecording = hitsFlatDiffRecording;
outputData.missesFlatDiffRecording = missesFlatDiffRecording;
outputData.falseAlarmsFlatDiffRecording = falseAlarmsFlatDiffRecording;
outputData.correctRejectionsFlatDiffRecording = correctRejectionsFlatDiffRecording;
outputData.sensitivityRiseRecording = sensitivityRiseRecording;
outputData.specificityRiseRecording = specificityRiseRecording;
outputData.FPRRiseRecording = FPRRiseRecording;
outputData.dPrimeRiseRecording = dPrimeRiseRecording;
outputData.sensitivityDecayRecording = sensitivityDecayRecording;
outputData.specificityDecayRecording = specificityDecayRecording;
outputData.FPRDecayRecording = FPRDecayRecording;
outputData.dPrimeDecayRecording = dPrimeDecayRecording;
outputData.sensitivityFlatRecording = sensitivityFlatRecording;
outputData.specificityFlatRecording = specificityFlatRecording;
outputData.FPRFlatRecording = FPRFlatRecording;
outputData.dPrimeFlatRecording = dPrimeFlatRecording;
outputData.nHitsPDFPerRecordingMeanRise = nHitsPDFPerRecordingMeanRise;
outputData.nHitsPDFPerRecordingRise = nHitsPDFPerRecordingRise;
outputData.nHitsPDFPerRecordingCI95Rise = nHitsPDFPerRecordingCI95Rise;
outputData.nHitsCDFPerRecordingMeanRise = nHitsCDFPerRecordingMeanRise;
outputData.nHitsCDFPerRecordingCI95Rise = nHitsCDFPerRecordingCI95Rise;
outputData.nHitsPDFPerRecordingMeanDecay = nHitsPDFPerRecordingMeanDecay;
outputData.nHitsPDFPerRecordingDecay = nHitsPDFPerRecordingDecay;
outputData.nHitsPDFPerRecordingCI95Decay = nHitsPDFPerRecordingCI95Decay;
outputData.nHitsCDFPerRecordingMeanDecay = nHitsCDFPerRecordingMeanDecay;
outputData.nHitsCDFPerRecordingCI95Decay = nHitsCDFPerRecordingCI95Decay;
outputData.nHitsPDFPerRecordingMeanFlat = nHitsPDFPerRecordingMeanFlat;
outputData.nHitsPDFPerRecordingFlat = nHitsPDFPerRecordingFlat;
outputData.nHitsPDFPerRecordingCI95Flat = nHitsPDFPerRecordingCI95Flat;
outputData.nHitsCDFPerRecordingMeanFlat = nHitsCDFPerRecordingMeanFlat;
outputData.nHitsCDFPerRecordingCI95Flat = nHitsCDFPerRecordingCI95Flat;
outputData.nHitsPDFPerRecordingMeanFlatD2N = nHitsPDFPerRecordingMeanFlatD2N;
outputData.nHitsPDFPerRecordingFlatD2N = nHitsPDFPerRecordingFlatD2N;
outputData.nHitsPDFPerRecordingCI95FlatD2N = nHitsPDFPerRecordingCI95FlatD2N;
outputData.nHitsCDFPerRecordingMeanFlatD2N = nHitsCDFPerRecordingMeanFlatD2N;
outputData.nHitsCDFPerRecordingCI95FlatD2N = nHitsCDFPerRecordingCI95FlatD2N;
outputData.edgesRise = edgesRise;
outputData.centresRise = centresRise;
outputData.edgesDecay = edgesDecay;
outputData.centresDecay = centresDecay;
outputData.edgesFlat = edgesFlat;
outputData.centresFlat = centresFlat;
outputData.edgesFlatD2N = edgesFlatD2N;
outputData.centresFlatD2N = centresFlatD2N;
outputData.nFalseAlarmsPDFPerRecordingMeanRise = nFalseAlarmsPDFPerRecordingMeanRise;
outputData.nFalseAlarmsPDFPerRecordingRise = nFalseAlarmsPDFPerRecordingRise;
outputData.nFalseAlarmsPDFPerRecordingCI95Rise = nFalseAlarmsPDFPerRecordingCI95Rise;
outputData.nFalseAlarmsCDFPerRecordingMeanRise = nFalseAlarmsCDFPerRecordingMeanRise;
outputData.nFalseAlarmsCDFPerRecordingCI95Rise = nFalseAlarmsCDFPerRecordingCI95Rise;
outputData.nFalseAlarmsPDFPerRecordingMeanDecay = nFalseAlarmsPDFPerRecordingMeanDecay;
outputData.nFalseAlarmsPDFPerRecordingDecay = nFalseAlarmsPDFPerRecordingDecay;
outputData.nFalseAlarmsPDFPerRecordingCI95Decay = nFalseAlarmsPDFPerRecordingCI95Decay;
outputData.nFalseAlarmsCDFPerRecordingMeanDecay = nFalseAlarmsCDFPerRecordingMeanDecay;
outputData.nFalseAlarmsCDFPerRecordingCI95Decay = nFalseAlarmsCDFPerRecordingCI95Decay;
outputData.nFalseAlarmsPDFPerRecordingMeanFlat = nFalseAlarmsPDFPerRecordingMeanFlat;
outputData.nFalseAlarmsPDFPerRecordingFlat = nFalseAlarmsPDFPerRecordingFlat;
outputData.nFalseAlarmsPDFPerRecordingCI95Flat = nFalseAlarmsPDFPerRecordingCI95Flat;
outputData.nFalseAlarmsCDFPerRecordingMeanFlat = nFalseAlarmsCDFPerRecordingMeanFlat;
outputData.nFalseAlarmsCDFPerRecordingCI95Flat = nFalseAlarmsCDFPerRecordingCI95Flat;
outputData.nFalseAlarmsPDFPerRecordingMeanFlatD2N = nFalseAlarmsPDFPerRecordingMeanFlatD2N;
outputData.nFalseAlarmsPDFPerRecordingFlatD2N = nFalseAlarmsPDFPerRecordingFlatD2N;
outputData.nFalseAlarmsPDFPerRecordingCI95FlatD2N = nFalseAlarmsPDFPerRecordingCI95FlatD2N;
outputData.nFalseAlarmsCDFPerRecordingMeanFlatD2N = nFalseAlarmsCDFPerRecordingMeanFlatD2N;
outputData.nFalseAlarmsCDFPerRecordingCI95FlatD2N = nFalseAlarmsCDFPerRecordingCI95FlatD2N;
outputData.edgesRise2 = edgesRise2;
outputData.centresRise2 = centresRise2;
outputData.edgesDecay2 = edgesDecay2;
outputData.centresDecay2 = centresDecay2;
outputData.edgesFlat2 = edgesFlat2;
outputData.centresFlat2 = centresFlat2;
outputData.edgesFlatD2N2 = edgesFlatD2N2;
outputData.centresFlatD2N2 = centresFlatD2N2;
end


function [fileProperties, dt, sweepDuration] = loadabfWrap(filename)

fileProperties = loadABF(filename);
dt = fileProperties.dt;
sweepDuration = (length(fileProperties.sweep)*dt - dt)/fileProperties.hd.lActualEpisodes;
end


function [sensitivity, specificity, FPR, dPrime] = performanceMeasures(truePositives, falseNegatives, falsePositives, trueNegatives)

sensitivity = sum(truePositives)/(sum(truePositives) + sum(falseNegatives)); % True positive rate
specificity = sum(trueNegatives)/(sum(trueNegatives) + sum(falsePositives)); % Correct rejection rate
FPR = sum(falsePositives)/(sum(trueNegatives) + sum(falsePositives)); % False positive rate
if sensitivity == 1
  sensitivityApprox = 1-(1e-6);
else
  sensitivityApprox = sensitivity;
end
if FPR == 0
  FPRapprox = 1e-6;
else
  FPRapprox = FPR;
end
dPrime = dprime_simple(sensitivityApprox, FPRapprox);
end


function [hitsRiseDiff, missesRiseDiff, falseAlarmsRiseDiff, correctRejectionsRiseDiff,...
  sensitivityRiseRecordingMean, specificityRiseRecordingMean, FPRRiseRecordingMean, dPrimeRiseRecordingMean,...
  hitsDecayRecording, missesDecayRecording, falseAlarmsDecayRecording, correctRejectionsDecayRecording] = risePerformance(...
  folder, iF, d, noiseProperties, dt, simFilt, noiseRawSweep,...
  hitsRiseDiff, missesRiseDiff, falseAlarmsRiseDiff, correctRejectionsRiseDiff,...
  sensitivityRiseRecordingMean, specificityRiseRecordingMean, FPRRiseRecordingMean, dPrimeRiseRecordingMean)

% Assign input variables
hitsDecayDiff = hitsRiseDiff;
missesDecayDiff = missesRiseDiff;
falseAlarmsDecayDiff = falseAlarmsRiseDiff;
correctRejectionsDecayDiff = correctRejectionsRiseDiff;
hitsDecayRecording = {};
missesDecayRecording = {};
falseAlarmsDecayRecording = {};
correctRejectionsDecayRecording = {};
sensitivityDecayRecordingMean = sensitivityRiseRecordingMean;
specificityDecayRecordingMean = specificityRiseRecordingMean;
FPRDecayRecordingMean = FPRRiseRecordingMean;
dPrimeDecayRecordingMean = dPrimeRiseRecordingMean;

for iFile = 1:numel(d)
  conditionCount = 0;
  if contains(d(iFile).name, '.mat')
    disp([iF iFile])

    % Extract the noise scaling factor
    scaleFactorIndStart = strfind(d(iFile).name,'noiseScaleFactor') + 16;
    scaleFactorIndEnd = strfind(d(iFile).name,'smoothWindow') - 2;
    scaleFactor = d(iFile).name(scaleFactorIndStart:scaleFactorIndEnd);
    scaleFactor = strrep(scaleFactor, 'p', '.');
    scaleFactor = str2double(scaleFactor);
    if scaleFactor == 1
      conditionCount = conditionCount + 1;
      realData = load([folder{iF} filesep d(iFile).name]);
      sensitivityDecay = [];
      specificityDecay = [];
      FPRDecay = [];
      dPrimeDecay = [];
      for iRun = 1:numel(realData.performance)
        if contains(d(iFile).name,'MiniAnalysis')
          targetRawFile = [fileparts(folder{iF}) filesep 'abf_raw' filesep d(iFile).name(1:end-17) '_000' num2str(iRun) '.abf'];
        elseif contains(d(iFile).name,'pClamp')
          targetRawFile = [fileparts(folder{iF}) filesep 'abf_raw' filesep d(iFile).name(1:end-11) '_000' num2str(iRun) '.abf'];
        else
          targetRawFile = [fileparts(folder{iF}) filesep 'abf_raw' filesep d(iFile).name(1:end-4) '_000' num2str(iRun) '.abf'];
        end
        targetProperties = loadabfWrap(targetRawFile);
        if isempty(noiseRawSweep)
          % Get the noise voltage trace
          noiseRawSweep = noiseProperties.sweep;
          filtN.state = realData.filtering.state;
          filtN.nSweeps = noiseProperties.hd.lActualEpisodes;
          filtN.excludedTimes = realData.filtering.noiseExcludedTimes;
          [noiseSweep, ~, f2] = filterMinis(noiseProperties.sweep, dt, filtN, true, [], {'50, 150'});
          close(f2);
          noiseMean = mean(noiseSweep);
          noiseSweep = (noiseSweep-noiseMean).*scaleFactor + noiseMean;
        end
        noiseSweep = fliplr(noiseSweep);

        % Get the simulation voltage trace
        simulationSweep = fliplr(targetProperties.sweep) - noiseSweep;
        simulationSweepFilt = filtfilt(simFilt, double(simulationSweep));
        time = (1:numel(simulationSweep)).*dt;
        %figure; plot(time, simulationSweep); hold on
        %plot(time, simulationSweepFilt, 'r'); hold off
        %filtord(simFilt)

        % Estimate rise and decay threholds
        [n, edges] = histcounts(simulationSweep(1000:end-1000));
        %figure; plot(edges(2:end)-(edges(2)-edges(1)), n);
        edges = edges(2:end)-(edges(2)-edges(1));
        [~, iMax] = max(n);
        baseline = edges(iMax);
        riseThreshold = baseline + mean(realData.optimisationParameters.options.bounds(:,1))/10;
        decayThreshold = baseline + mean(realData.optimisationParameters.options.bounds(:,1))/exp(1);
        %figure; plot(time, simulationSweep); hold on
        %plot(time, simulationSweepFilt, matlabColours(8));
        %plot([time(1) time(end)], [riseThreshold riseThreshold], 'c');
        %plot([time(1) time(end)], [decayThreshold decayThreshold], 'r'); hold off

        % Initial estimate of rise and decay phases
        simSweepDiff = [diff(simulationSweepFilt) 0];
        risePhase = simSweepDiff > 0 & simulationSweep >= riseThreshold; %#ok<*NASGU>
        decayPhase = simSweepDiff < 0 & simulationSweep >= decayThreshold;
        decayPhaseFull = simSweepDiff < 0 & simulationSweep >= riseThreshold;
        %figure; plot(time, simulationSweepFilt); hold on
        %plot(time(risePhase), simulationSweepFilt(risePhase), 'g.', 'MarkerSize',5);
        %plot(time(decayPhaseFull), simulationSweepFilt(decayPhaseFull), 'm.', 'MarkerSize',5);
        %plot(time(decayPhase), simulationSweepFilt(decayPhase), 'r.', 'MarkerSize',5); hold off

        % Find prominent peaks
        [~, peakLocs] = findpeaks(simulationSweepFilt, 'MinPeakHeight',decayThreshold);
        %figure; plot(time, simulationSweepFilt); hold on
        %plot(time(peakLocs), simulationSweepFilt(peakLocs), 'r^'); hold off

        % Final estimate of rise and decay phases:
        refractoryPeriodDuration = 0.5/8; %ms
        refractoryPeriodDuration = round(refractoryPeriodDuration/dt);
        decayPhaseFinal = false(size(decayPhase));
        flatPhase = false(size(simulationSweepFilt));
        peakLocsFinal = [];
        nextPeak = 1;
        for iPeak = 1:numel(peakLocs)
          % Step 1:
          decayStop = find(time > time(peakLocs(iPeak)) & simulationSweepFilt < riseThreshold, 1) - 1;
          if isempty(decayStop)
            decayStop = numel(simulationSweepFilt);
          end
          interveningPeaks = peakLocs(peakLocs > peakLocs(iPeak) & peakLocs <= decayStop);
          if iPeak == nextPeak
            peakLocsFinal = [peakLocsFinal peakLocs(iPeak)];
            if isempty(interveningPeaks) || max(simulationSweepFilt(interveningPeaks)) <= simulationSweepFilt(peakLocs(iPeak))
              decayPhaseFinal(peakLocs(iPeak)+refractoryPeriodDuration+1:decayStop) = true;
              nextPeak = iPeak + numel(interveningPeaks) + 1;
            else
              % Step 2:
              firstLargerPeakRelativeLoc = find(simulationSweepFilt(interveningPeaks) > simulationSweepFilt(peakLocs(iPeak)),1);
              firstLargerPeak = interveningPeaks(firstLargerPeakRelativeLoc);
              decayStop = find(time < time(firstLargerPeak) & decayPhaseFull, 1, 'last');
              decayPhaseFinal(peakLocs(iPeak)+refractoryPeriodDuration+1:decayStop) = true;
              nextPeak = iPeak + firstLargerPeakRelativeLoc;
            end
          end
          flatPhase(max([1 peakLocs(iPeak)-refractoryPeriodDuration]):min([peakLocs(iPeak)+refractoryPeriodDuration numel(flatPhase)])) = true;
        end
        % Step 3: Extend the rise phase backwards
        risePhaseFinal = false(size(risePhase));
        risePhaseFinal(risePhase | flatPhase) = true;
        for shift = 1:round(refractoryPeriodDuration*2)
          risePhaseFinal = risePhaseFinal + [risePhaseFinal(shift+1:end) zeros(1,shift)];
        end
        risePhaseFinal = logical(risePhaseFinal);

        % Estimate membrane potential rate of change
        simSweepDiff(risePhaseFinal) = 1000;
        for iSample = 1:numel(simSweepDiff)
          if iSample == 1 && simSweepDiff(iSample) > 0
            simSweepDiff(iSample) = 0;
          elseif simSweepDiff(iSample) == 1000 && simSweepDiff(iSample-1) > 0
            simSweepDiff(iSample) = 0;
          elseif simSweepDiff(iSample) == 1000
            simSweepDiff(iSample) = simSweepDiff(iSample-1);
          elseif simSweepDiff(iSample) > 0
            simSweepDiff(iSample) = 0;
          end
        end

        % Mark final decay and rise phase estimates, as well as plot membrane rate of change
        %figure; plot(time, simulationSweepFilt); hold on
        %plot(time(peakLocsFinal), simulationSweepFilt(peakLocsFinal), 'r^');
        %plot(time(decayPhaseFinal), simulationSweepFilt(decayPhaseFinal), 'r.', 'MarkerSize',5);
        %plot(time(risePhaseFinal), simulationSweepFilt(risePhaseFinal), 'g.', 'MarkerSize',5);
        %plot(time, 10*simSweepDiff+baseline, 'k'); hold off

        % Extract performance data for a particular simulation instance
        hits = fliplr(realData.performance{iRun}(4,:));
        misses = fliplr(realData.performance{iRun}(5,:));
        falseAlarms = fliplr(realData.performance{iRun}(6,:));
        correctRejections = fliplr(realData.performance{iRun}(7,:));

        % Associate performance measures with membrane potential rate of change parameters
        hitsDecay = false(size(hits));
        missesDecay = false(size(misses));
        falseAlarmsDecay = false(size(falseAlarms));
        correctRejectionsDecay = false(size(correctRejections));
        hitsDecay(decayPhaseFinal) = hits(decayPhaseFinal);
        missesDecay(decayPhaseFinal) = misses(decayPhaseFinal);
        falseAlarmsDecay(decayPhaseFinal) = falseAlarms(decayPhaseFinal);
        correctRejectionsDecay(decayPhaseFinal) = correctRejections(decayPhaseFinal);
        hitsDecayRecording{conditionCount}{iRun} = fliplr(hitsDecay);
        missesDecayRecording{conditionCount}{iRun} = fliplr(missesDecay);
        falseAlarmsDecayRecording{conditionCount}{iRun} = fliplr(falseAlarmsDecay);
        correctRejectionsDecayRecording{conditionCount}{iRun} = fliplr(correctRejectionsDecay);

        hitsDecayDiff = [hitsDecayDiff simSweepDiff(hitsDecay)]; %#ok<*AGROW>
        missesDecayDiff = [missesDecayDiff simSweepDiff(missesDecay)];
        falseAlarmsDecayDiff = [falseAlarmsDecayDiff simSweepDiff(falseAlarmsDecay)];
        correctRejectionsDecayDiff = [correctRejectionsDecayDiff simSweepDiff(correctRejectionsDecay)];

        % Calculate performance measures
        [param1, param2, param3, param4] = performanceMeasures(hitsDecay, missesDecay,...
          falseAlarmsDecay, correctRejectionsDecay);
        sensitivityDecay = [sensitivityDecay param1];
        specificityDecay = [specificityDecay param2];
        FPRDecay = [FPRDecay param3];
        dPrimeDecay = [dPrimeDecay param4];
      end
      sensitivityDecayRecordingMean(iF,conditionCount) = mean(sensitivityDecay);
      specificityDecayRecordingMean(iF,conditionCount) = mean(specificityDecay);
      FPRDecayRecordingMean(iF,conditionCount) = mean(FPRDecay);
      dPrimeDecayRecordingMean(iF,conditionCount) = mean(dPrimeDecay);
    end
  end
end

% Assign output variables
hitsRiseDiff = hitsDecayDiff;
missesRiseDiff = missesDecayDiff;
falseAlarmsRiseDiff = falseAlarmsDecayDiff;
correctRejectionsRiseDiff = correctRejectionsDecayDiff;
sensitivityRiseRecordingMean = sensitivityDecayRecordingMean;
specificityRiseRecordingMean = specificityDecayRecordingMean;
FPRRiseRecordingMean = FPRDecayRecordingMean;
dPrimeRiseRecordingMean = dPrimeDecayRecordingMean;
end


function [hitsDecayDiff, missesDecayDiff, falseAlarmsDecayDiff, correctRejectionsDecayDiff,...
  hitsFlatDiff, missesFlatDiff, falseAlarmsFlatDiff, correctRejectionsFlatDiff,...
  hitsFlatD2N, missesFlatD2N, falseAlarmsFlatD2N, correctRejectionsFlatD2N,...
  sensitivityDecayRecording, specificityDecayRecording, FPRDecayRecording, dPrimeDecayRecording] = decayPerformance(...
  folder, iF, d, noiseProperties, dt, simFilt, noiseRawSweep,...
  hitsDecayDiff, missesDecayDiff, falseAlarmsDecayDiff, correctRejectionsDecayDiff,...
  hitsFlatDiff, missesFlatDiff, falseAlarmsFlatDiff, correctRejectionsFlatDiff,...
  hitsFlatD2N, missesFlatD2N, falseAlarmsFlatD2N, correctRejectionsFlatD2N,...
  sensitivityDecayRecording, specificityDecayRecording, FPRDecayRecording, dPrimeDecayRecording,...
  hitsRiseRecording, missesRiseRecording, falseAlarmsRiseRecording, correctRejectionsRiseRecording)

for iFile = 1:numel(d)
  conditionCount = 0;
  if contains(d(iFile).name, '.mat')
    disp([iF iFile])

    % Extract the noise scaling factor
    scaleFactorIndStart = strfind(d(iFile).name,'noiseScaleFactor') + 16;
    scaleFactorIndEnd = strfind(d(iFile).name,'smoothWindow') - 2;
    scaleFactor = d(iFile).name(scaleFactorIndStart:scaleFactorIndEnd);
    scaleFactor = strrep(scaleFactor, 'p', '.');
    scaleFactor = str2double(scaleFactor);
    if scaleFactor == 1
      conditionCount = conditionCount + 1;
      realData = load([folder{iF} filesep d(iFile).name]);
      sensitivityDecay = [];
      specificityDecay = [];
      FPRDecay = [];
      dPrimeDecay = [];
      sensitivityFlat = [];
      specificityFlat = [];
      FPRFlat = [];
      dPrimeFlat = [];
      for iRun = 1:numel(realData.performance)
        if contains(d(iFile).name,'MiniAnalysis')
          targetRawFile = [fileparts(folder{iF}) filesep 'abf_raw' filesep d(iFile).name(1:end-17) '_000' num2str(iRun) '.abf'];
        elseif contains(d(iFile).name,'pClamp')
          targetRawFile = [fileparts(folder{iF}) filesep 'abf_raw' filesep d(iFile).name(1:end-11) '_000' num2str(iRun) '.abf'];
        else
          targetRawFile = [fileparts(folder{iF}) filesep 'abf_raw' filesep d(iFile).name(1:end-4) '_000' num2str(iRun) '.abf'];
        end
        targetProperties = loadabfWrap(targetRawFile);
        if isempty(noiseRawSweep)
          % Get the noise voltage trace
          noiseRawSweep = noiseProperties.sweep;
          filtN.state = realData.filtering.state;
          filtN.nSweeps = noiseProperties.hd.lActualEpisodes;
          filtN.excludedTimes = realData.filtering.noiseExcludedTimes;
          [noiseSweep, ~, f2] = filterMinis(noiseProperties.sweep, dt, filtN, true, [], {'50, 150'});
          close(f2);
          noiseMean = mean(noiseSweep);
          noiseSweep = (noiseSweep-noiseMean).*scaleFactor + noiseMean;
        end

        % Get the simulation voltage trace
        simulationSweep = targetProperties.sweep - noiseSweep;
        simulationSweepFilt = filtfilt(simFilt, double(simulationSweep));
        time = (1:numel(simulationSweep)).*dt;
        %figure; plot(time, simulationSweep); hold on
        %plot(time, simulationSweepFilt, 'r'); hold off
        %filtord(simFilt)

        % Estimate rise and decay threholds
        [n, edges] = histcounts(simulationSweep(1000:end-1000));
        %figure; plot(edges(2:end)-(edges(2)-edges(1)), n);
        edges = edges(2:end)-(edges(2)-edges(1));
        [~, iMax] = max(n);
        baseline = edges(iMax);
        riseThreshold = baseline + mean(realData.optimisationParameters.options.bounds(:,1))/10;
        decayThreshold = baseline + mean(realData.optimisationParameters.options.bounds(:,1))/exp(1);
        %figure; plot(time, simulationSweep); hold on
        %plot(time, simulationSweepFilt, matlabColours(8));
        %plot([time(1) time(end)], [riseThreshold riseThreshold], 'c');
        %plot([time(1) time(end)], [decayThreshold decayThreshold], 'r'); hold off

        % Initial estimate of rise and decay phases
        simSweepDiff = [diff(simulationSweepFilt) 0];
        risePhase = simSweepDiff > 0 & simulationSweep >= riseThreshold; %#ok<*NASGU>
        decayPhase = simSweepDiff < 0 & simulationSweep >= decayThreshold;
        decayPhaseFull = simSweepDiff < 0 & simulationSweep >= riseThreshold;
        %figure; plot(time, simulationSweepFilt); hold on
        %plot(time(risePhase), simulationSweepFilt(risePhase), 'g.', 'MarkerSize',5);
        %plot(time(decayPhaseFull), simulationSweepFilt(decayPhaseFull), 'm.', 'MarkerSize',5);
        %plot(time(decayPhase), simulationSweepFilt(decayPhase), 'r.', 'MarkerSize',5); hold off

        % Find prominent peaks
        [~, peakLocs] = findpeaks(simulationSweepFilt, 'MinPeakHeight',decayThreshold);
        %figure; plot(time, simulationSweepFilt); hold on
        %plot(time(peakLocs), simulationSweepFilt(peakLocs), 'r^'); hold off

        % Final estimate of rise and decay phases:
        refractoryPeriodDuration = 0.5/8; %ms
        refractoryPeriodDuration = round(refractoryPeriodDuration/dt);
        decayPhaseFinal = false(size(decayPhase));
        flatPhase = false(size(simulationSweepFilt));
        peakLocsFinal = [];
        nextPeak = 1;
        for iPeak = 1:numel(peakLocs)
          % Step 1:
          decayStop = find(time > time(peakLocs(iPeak)) & simulationSweepFilt < riseThreshold, 1) - 1;
          if isempty(decayStop)
            decayStop = numel(simulationSweepFilt);
          end
          interveningPeaks = peakLocs(peakLocs > peakLocs(iPeak) & peakLocs <= decayStop);
          if iPeak == nextPeak
            peakLocsFinal = [peakLocsFinal peakLocs(iPeak)];
            if isempty(interveningPeaks) || max(simulationSweepFilt(interveningPeaks)) <= simulationSweepFilt(peakLocs(iPeak))
              decayPhaseFinal(peakLocs(iPeak)+refractoryPeriodDuration+1:decayStop) = true;
              nextPeak = iPeak + numel(interveningPeaks) + 1;
            else
              % Step 2:
              firstLargerPeakRelativeLoc = find(simulationSweepFilt(interveningPeaks) > simulationSweepFilt(peakLocs(iPeak)),1);
              firstLargerPeak = interveningPeaks(firstLargerPeakRelativeLoc);
              decayStop = find(time < time(firstLargerPeak) & decayPhaseFull, 1, 'last');
              decayPhaseFinal(peakLocs(iPeak)+refractoryPeriodDuration+1:decayStop) = true;
              nextPeak = iPeak + firstLargerPeakRelativeLoc;
            end
          end
          flatPhase(max([1 peakLocs(iPeak)-refractoryPeriodDuration]):min([peakLocs(iPeak)+refractoryPeriodDuration numel(flatPhase)])) = true;
        end
        % Step 3: Extend the rise phase backwards
        risePhaseFinal = false(size(risePhase));
        risePhaseFinal(risePhase | flatPhase) = true;
        for shift = 1:round(refractoryPeriodDuration*4)
          risePhaseFinal = risePhaseFinal + [risePhaseFinal(shift+1:end) zeros(1,shift)];
        end
        risePhaseFinal = logical(risePhaseFinal);

        % Estimate membrane potential rate of change
        simSweepDiff(risePhaseFinal) = 1000;
        for iSample = 1:numel(simSweepDiff)
          if iSample == 1 && simSweepDiff(iSample) > 0
            simSweepDiff(iSample) = 0;
          elseif simSweepDiff(iSample) == 1000 && simSweepDiff(iSample-1) > 0
            simSweepDiff(iSample) = 0;
          elseif simSweepDiff(iSample) == 1000
            simSweepDiff(iSample) = simSweepDiff(iSample-1);
          elseif simSweepDiff(iSample) > 0
            simSweepDiff(iSample) = 0;
          end
        end

        % Mark final decay and rise phase estimates, as well as plot membrane rate of change
        %figure; plot(time, simulationSweepFilt); hold on
        %plot(time(peakLocsFinal), simulationSweepFilt(peakLocsFinal), 'r^');
        %plot(time(decayPhaseFinal), simulationSweepFilt(decayPhaseFinal), 'r.', 'MarkerSize',5);
        %plot(time(risePhaseFinal), simulationSweepFilt(risePhaseFinal), 'g.', 'MarkerSize',5);
        %plot(time, 10*simSweepDiff+baseline, 'k'); hold off

        % Extract performance data for a particular simulation instance
        hits = realData.performance{iRun}(4,:);
        misses = realData.performance{iRun}(5,:);
        falseAlarms = realData.performance{iRun}(6,:);
        correctRejections = realData.performance{iRun}(7,:);
        allTrue = realData.performance{iRun}(1,:);
        trueI = find(allTrue);
        trueT = trueI.*realData.dt;
        missesI = find(misses);
        %[~, hitsI] = setdiff(trueI, missesI);

        % Associate performance measures with membrane potential rate of change parameters
        hitsDecay = false(size(hits));
        missesDecay = false(size(misses));
        falseAlarmsDecay = false(size(falseAlarms));
        correctRejectionsDecay = false(size(correctRejections));
        hitsDecay(decayPhaseFinal) = hits(decayPhaseFinal);
        missesDecay(decayPhaseFinal) = misses(decayPhaseFinal);
        falseAlarmsDecay(decayPhaseFinal) = falseAlarms(decayPhaseFinal);
        correctRejectionsDecay(decayPhaseFinal) = correctRejections(decayPhaseFinal);

        flatPhase = ~(decayPhaseFinal | risePhase);
        hitsFlat = false(size(hits));
        missesFlat = false(size(misses));
        falseAlarmsFlat = false(size(falseAlarms));
        correctRejectionsFlat = false(size(correctRejections));
        hitsFlat(flatPhase & ~hitsRiseRecording{conditionCount}{iRun}) = hits(flatPhase & ~hitsRiseRecording{conditionCount}{iRun} & ~hitsDecay);
        missesFlat(flatPhase & ~missesRiseRecording{conditionCount}{iRun}) = misses(flatPhase & ~missesRiseRecording{conditionCount}{iRun} & ~missesDecay);
        falseAlarmsFlat(flatPhase & ~falseAlarmsRiseRecording{conditionCount}{iRun}) = falseAlarms(flatPhase & ~falseAlarmsRiseRecording{conditionCount}{iRun} & ~falseAlarmsDecay);
        correctRejectionsFlat(flatPhase & ~correctRejectionsRiseRecording{conditionCount}{iRun}) = correctRejections(flatPhase & ~correctRejectionsRiseRecording{conditionCount}{iRun} & ~correctRejectionsDecay);

        hitsDecayDiff = [hitsDecayDiff simSweepDiff(hitsDecay)]; %#ok<*AGROW>
        missesDecayDiff = [missesDecayDiff simSweepDiff(missesDecay)];
        falseAlarmsDecayDiff = [falseAlarmsDecayDiff simSweepDiff(falseAlarmsDecay)];
        correctRejectionsDecayDiff = [correctRejectionsDecayDiff simSweepDiff(correctRejectionsDecay)];

        hitsFlatDiff = [hitsFlatDiff simSweepDiff(hitsFlat)];
        missesFlatDiff = [missesFlatDiff simSweepDiff(missesFlat)];
        falseAlarmsFlatDiff = [falseAlarmsFlatDiff simSweepDiff(falseAlarmsFlat)];
        correctRejectionsFlatDiff = [correctRejectionsFlatDiff simSweepDiff(correctRejectionsFlat)];

        % Associate performance measures with time to the nearest neighbour
        distanceToTheRight = abs([trueT(2:end) inf] - trueT);
        distanceToTheLeft = abs([inf trueT(1:end-1)] - trueT);
        distance2neighbour = min([distanceToTheRight; distanceToTheLeft],[],1);
        [~, trueNonFlatI] = intersect(trueI, find(~flatPhase));
        trueFlatI = trueI;
        trueFlatI(trueNonFlatI) = 0;
        [~, hitsFlatI] = setdiff(trueFlatI, [missesI 0]);
        hitsFlatD2N = [hitsFlatD2N distance2neighbour(hitsFlatI)];
        [~, missesFlatI] = intersect(trueI, intersect(missesI, find(flatPhase)));
        missesFlatD2N = [missesFlatD2N distance2neighbour(missesFlatI)];

        falseAlarmsFlatI = find(falseAlarmsFlat);
        falseAlarmsFlatT = falseAlarmsFlatI.*realData.dt;
        falseAlarmsFlatD2N = zeros(size(falseAlarmsFlatI));
        for iFA = 1:numel(falseAlarmsFlatI)
          falseAlarmsFlatD2N(iFA) = min(abs(trueT - falseAlarmsFlatT(iFA)));
        end
        correctRejectionsFlatI = find(correctRejectionsFlat);
        correctRejectionsFlatT = correctRejectionsFlatI.*realData.dt;
        correctRejectionsFlatD2N = zeros(size(correctRejectionsFlatI));
        for iFA = 1:numel(correctRejectionsFlatI)
          correctRejectionsFlatD2N(iFA) = min(abs(trueT - correctRejectionsFlatT(iFA)));
        end

        % Calculate performance measures
        [param1, param2, param3, param4] = performanceMeasures(hitsDecay, missesDecay,...
          falseAlarmsDecay, correctRejectionsDecay);
        sensitivityDecay = [sensitivityDecay param1];
        specificityDecay = [specificityDecay param2];
        FPRDecay = [FPRDecay param3];
        dPrimeDecay = [dPrimeDecay param4];
        [param1, param2, param3, param4] = performanceMeasures(hitsFlat, missesFlat,...
          falseAlarmsFlat, correctRejectionsFlat);
        sensitivityFlat = [sensitivityFlat param1];
        specificityFlat = [specificityFlat param2];
        FPRFlat = [FPRFlat param3];
        dPrimeFlat = [dPrimeFlat param4];
      end
      sensitivityDecayRecording(iF,conditionCount) = mean(sensitivityDecay);
      specificityDecayRecording(iF,conditionCount) = mean(specificityDecay);
      FPRDecayRecording(iF,conditionCount) = mean(FPRDecay);
      dPrimeDecayRecording(iF,conditionCount) = mean(dPrimeDecay);
      sensitivityFlatRecording(iF,conditionCount) = mean(sensitivityFlat);
      specificityFlatRecording(iF,conditionCount) = mean(specificityFlat);
      FPRFlatRecording(iF,conditionCount) = mean(FPRFlat);
      dPrimeFlatRecording(iF,conditionCount) = mean(dPrimeFlat);
    end
  end
end
end


function [nHitsPDFPerRecordingMean, nHitsPDFPerRecordingCI95, nHitsCDFPerRecordingMean, nHitsCDFPerRecordingCI95, edges, centres, nHitsPDFPerRecording] = calcDistros(hitsDiffRecording, missesDiffRecording, folder, binSize)

hitsDiffMax = zeros(1,numel(hitsDiffRecording));
for iRec = 1:numel(hitsDiffRecording)
  hitsDiffMax(iRec) = max(abs(hitsDiffRecording{iRec}));
end
hitsDiffMax = max(hitsDiffMax);
%binSize = 0.0001;
edges = 0:binSize:hitsDiffMax;
centres = -fliplr(edges(1:end-1) + binSize/2);

nHitsPDFPerRecording = zeros(numel(folder),numel(centres));
nHitsCDFPerRecording = [];
for iRec = 1:numel(hitsDiffRecording)
  nAllTrueRecording = fliplr(histcounts(abs([hitsDiffRecording{iRec} missesDiffRecording{iRec}]), edges));
  nHitsRecording = fliplr(histcounts(abs(hitsDiffRecording{iRec}), edges));
  nHitsPDFPerRecording(iRec,:) = nHitsRecording./nAllTrueRecording;
  nHitsCDFPerRecording(iRec,:) = cumsum(nHitsRecording,'omitnan')./numel([hitsDiffRecording{iRec} missesDiffRecording{iRec}]);
end
[nHitsPDFPerRecordingMean, nHitsPDFPerRecordingCI95] = datamean(nHitsPDFPerRecording);
[nHitsCDFPerRecordingMean, nHitsCDFPerRecordingCI95] = datamean(nHitsCDFPerRecording);
end


function [nHitsPDFPerRecordingMean, nHitsPDFPerRecordingCI95, nHitsCDFPerRecordingMean, nHitsCDFPerRecordingCI95, edges, centres, nHitsPDFPerRecording] = calcDistanceDistros(hitsD2N, missesD2N, folder, binSize)

hitsD2NMax = zeros(1,numel(hitsD2N));
for iRec = 1:numel(hitsD2N)
  hitsD2NMax(iRec) = max(abs(hitsD2N{iRec}));
end
maxDist = floor(max(hitsD2NMax));
%binSize = 0.1;
edges = 0:binSize:maxDist;
centres = edges(1:end-1) + binSize/2;

nHitsPDFPerRecording = zeros(numel(folder),numel(centres));
nHitsCDFPerRecording = [];
for iRec = 1:numel(hitsD2N)
  nAllTrueRecording = histcounts(abs([hitsD2N{iRec} missesD2N{iRec}]), edges);
  nHitsRecording = histcounts(abs(hitsD2N{iRec}), edges);
  nHitsPDFPerRecording(iRec,:) = nHitsRecording./nAllTrueRecording;
  nHitsCDFPerRecording(iRec,:) = cumsum(nHitsRecording,'omitnan')./numel([hitsD2N{iRec} missesD2N{iRec}]);
end
[nHitsPDFPerRecordingMean, nHitsPDFPerRecordingCI95] = datamean(nHitsPDFPerRecording);
[nHitsCDFPerRecordingMean, nHitsCDFPerRecordingCI95] = datamean(nHitsCDFPerRecording);
end


function [dPrimeRiseMean, dPrimeRiseCI95, centresInterp] = dPrimeCalcRise(decayDetectionPerformance)

centresInterp = unique([decayDetectionPerformance.centresRise decayDetectionPerformance.centresRise2]);
nHitsPDFPerRecordingRiseInterp = interp1(decayDetectionPerformance.centresRise,decayDetectionPerformance.nHitsPDFPerRecordingRise',centresInterp, 'linear','extrap')';
nHitsPDFPerRecordingRiseInterp(nHitsPDFPerRecordingRiseInterp < 0) = 0;
nHitsPDFPerRecordingRiseInterp(nHitsPDFPerRecordingRiseInterp > 1) = 1;
% for col = 1:size(nHitsPDFPerRecordingRiseInterp,2)
%   if sum(nHitsPDFPerRecordingRiseInterp(:,col), 'omitnan')
%     break
%   else
%     existsValue = nHitsPDFPerRecordingRiseInterp;
%     existsValue(isnan(existsValue)) = 0;
%     existsValue = logical(sum(existsValue));
%     noValue = 1; %max([1 numel(existsValue) - sum(existsValue)]);
%     nHitsPDFPerRecordingRiseInterp(:,col) = ones(size(nHitsPDFPerRecordingRiseInterp(:,col))).*(min(min(nHitsPDFPerRecordingRiseInterp(nHitsPDFPerRecordingRiseInterp ~= 0)))/noValue);
%   end
% end
nFalseAlarmsPDFPerRecordingRiseInterp = interp1(decayDetectionPerformance.centresRise2,decayDetectionPerformance.nFalseAlarmsPDFPerRecordingRise',centresInterp, 'linear','extrap')';
nFalseAlarmsPDFPerRecordingRiseInterp(nFalseAlarmsPDFPerRecordingRiseInterp < 0) = 0;
nFalseAlarmsPDFPerRecordingRiseInterp(nFalseAlarmsPDFPerRecordingRiseInterp > 1) = 1;
% for col = 1:size(nFalseAlarmsPDFPerRecordingRiseInterp,2)
%   if sum(nFalseAlarmsPDFPerRecordingRiseInterp(:,col), 'omitnan')
%     break
%   else
%     existsValue = nFalseAlarmsPDFPerRecordingRiseInterp;
%     existsValue(isnan(existsValue)) = 0;
%     existsValue = logical(sum(existsValue));
%     noValue = 1; %max([1 numel(existsValue) - sum(existsValue)]);
%     nFalseAlarmsPDFPerRecordingRiseInterp(:,col) = ones(size(nFalseAlarmsPDFPerRecordingRiseInterp(:,col))).*(min(min(nFalseAlarmsPDFPerRecordingRiseInterp(nFalseAlarmsPDFPerRecordingRiseInterp ~= 0)))/noValue);
%   end
% end
dPrimeRise = zeros(size(nHitsPDFPerRecordingRiseInterp));
for iCond = 1:size(dPrimeRise,1)
  for iBin = 1:numel(centresInterp)
    %         if nHitsPDFPerRecordingRiseInterp(iCond,iBin) == 0
    %             nHitsPDFPerRecordingRiseInterp(iCond,iBin) = 1e-9;
    %         end
    %         if nFalseAlarmsPDFPerRecordingRiseInterp(iCond,iBin) == 0
    %             nFalseAlarmsPDFPerRecordingRiseInterp(iCond,iBin) = 1e-9;
    %         end
    if ~isnan(nHitsPDFPerRecordingRiseInterp(iCond,iBin)) && ~isnan(nFalseAlarmsPDFPerRecordingRiseInterp(iCond,iBin))
      dPrime = dprime_simple(nHitsPDFPerRecordingRiseInterp(iCond,iBin), nFalseAlarmsPDFPerRecordingRiseInterp(iCond,iBin));
    else
      dPrime = NaN;
    end
    if isinf(dPrime)
      if dPrime < 0 %#ok<*IFBDUP>
        dPrime = NaN; %-1e9;
      else
        dPrime = NaN; %1e9;
      end
    end
    dPrimeRise(iCond,iBin) = dPrime;
  end
end
[dPrimeRiseMeanInit, dPrimeRiseCI95Init] = datamean(dPrimeRise);
dPrimeRiseMean = dPrimeRiseMeanInit(~isnan(dPrimeRiseMeanInit) & ~isnan(dPrimeRiseCI95Init(1,:)) & ~isnan(dPrimeRiseCI95Init(2,:)));
dPrimeRiseCI95 = dPrimeRiseCI95Init(:,~isnan(dPrimeRiseMeanInit) & ~isnan(dPrimeRiseCI95Init(1,:)) & ~isnan(dPrimeRiseCI95Init(2,:)));
centresInterp = centresInterp(~isnan(dPrimeRiseMeanInit) & ~isnan(dPrimeRiseCI95Init(1,:)) & ~isnan(dPrimeRiseCI95Init(2,:)));
end


function [dPrimeDecayMean, dPrimeDecayCI95, centresInterp] = dPrimeCalcDecay(decayDetectionPerformance)

centresInterp = unique([decayDetectionPerformance.centresDecay decayDetectionPerformance.centresDecay2]);
nHitsPDFPerRecordingDecayInterp = interp1(decayDetectionPerformance.centresDecay,decayDetectionPerformance.nHitsPDFPerRecordingDecay',centresInterp, 'linear','extrap')';
nHitsPDFPerRecordingDecayInterp(nHitsPDFPerRecordingDecayInterp < 0) = 0;
nHitsPDFPerRecordingDecayInterp(nHitsPDFPerRecordingDecayInterp > 1) = 1;
% for col = 1:size(nHitsPDFPerRecordingDecayInterp,2)
%   if sum(nHitsPDFPerRecordingDecayInterp(:,col), 'omitnan')
%     break
%   else
%     existsValue = nHitsPDFPerRecordingDecayInterp;
%     existsValue(isnan(existsValue)) = 0;
%     existsValue = logical(sum(existsValue));
%     noValue = 1; %max([1 numel(existsValue) - sum(existsValue)]);
%     nHitsPDFPerRecordingDecayInterp(:,col) = ones(size(nHitsPDFPerRecordingDecayInterp(:,col))).*(min(min(nHitsPDFPerRecordingDecayInterp(nHitsPDFPerRecordingDecayInterp ~= 0)))/noValue);
%   end
% end
nFalseAlarmsPDFPerRecordingDecayInterp = interp1(decayDetectionPerformance.centresDecay2,decayDetectionPerformance.nFalseAlarmsPDFPerRecordingDecay',centresInterp, 'linear','extrap')';
nFalseAlarmsPDFPerRecordingDecayInterp(nFalseAlarmsPDFPerRecordingDecayInterp < 0) = 0;
nFalseAlarmsPDFPerRecordingDecayInterp(nFalseAlarmsPDFPerRecordingDecayInterp > 1) = 1;
% for col = 1:size(nFalseAlarmsPDFPerRecordingDecayInterp,2)
%   if sum(nFalseAlarmsPDFPerRecordingDecayInterp(:,col), 'omitnan')
%     break
%   else
%     existsValue = nFalseAlarmsPDFPerRecordingDecayInterp;
%     existsValue(isnan(existsValue)) = 0;
%     existsValue = logical(sum(existsValue));
%     noValue = 1; %max([1 numel(existsValue) - sum(existsValue)]);
%     nFalseAlarmsPDFPerRecordingDecayInterp(:,col) = ones(size(nFalseAlarmsPDFPerRecordingDecayInterp(:,col))).*(min(min(nFalseAlarmsPDFPerRecordingDecayInterp(nFalseAlarmsPDFPerRecordingDecayInterp ~= 0)))/noValue);
%   end
% end
dPrimeDecay = zeros(size(nHitsPDFPerRecordingDecayInterp));
for iCond = 1:size(dPrimeDecay,1)
  for iBin = 1:numel(centresInterp)
    %         if nHitsPDFPerRecordingDecayInterp(iCond,iBin) == 0
    %             nHitsPDFPerRecordingDecayInterp(iCond,iBin) = 1e-9;
    %         end
    %         if nFalseAlarmsPDFPerRecordingDecayInterp(iCond,iBin) == 0
    %             nFalseAlarmsPDFPerRecordingDecayInterp(iCond,iBin) = 1e-9;
    %         end
    if ~isnan(nHitsPDFPerRecordingDecayInterp(iCond,iBin)) && ~isnan(nFalseAlarmsPDFPerRecordingDecayInterp(iCond,iBin))
      dPrime = dprime_simple(nHitsPDFPerRecordingDecayInterp(iCond,iBin), nFalseAlarmsPDFPerRecordingDecayInterp(iCond,iBin));
    else
      dPrime = NaN;
    end
    if isinf(dPrime)
      if dPrime < 0
        dPrime = NaN; %-1e9;
      else
        dPrime = NaN; %1e9;
      end
    end
    dPrimeDecay(iCond,iBin) = dPrime;
  end
end
[dPrimeDecayMeanInit, dPrimeDecayCI95Init] = datamean(dPrimeDecay);
dPrimeDecayMean = dPrimeDecayMeanInit(~isnan(dPrimeDecayMeanInit) & ~isnan(dPrimeDecayCI95Init(1,:)) & ~isnan(dPrimeDecayCI95Init(2,:)));
dPrimeDecayCI95 = dPrimeDecayCI95Init(:,~isnan(dPrimeDecayMeanInit) & ~isnan(dPrimeDecayCI95Init(1,:)) & ~isnan(dPrimeDecayCI95Init(2,:)));
centresInterp = centresInterp(~isnan(dPrimeDecayMeanInit) & ~isnan(dPrimeDecayCI95Init(1,:)) & ~isnan(dPrimeDecayCI95Init(2,:)));
end