cleanUp
params

testType = {'test1'; 'testSelect'; 'test2'};


%% Analyses

for iTest = 1:numel(testType)
  % minis
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
  [fH1, fH2, dPrimeMeanAllMinis, ~, ~, aucAllMinis, ~, ~, pHAUC(1), pHdPrime(1), simEventCount] = summaryPerformance(folder, [], [], matlabColours(8), testType{iTest});
  distType = 'nearest';
  [figures, legends, nHitsPDFPerRecordingMinis, nFalseAlarmsPDFPerRecordingMinis, centresMinis, centresMinisFA] = summaryDistance(folder, [], [], matlabColours(8), distType);

  % Mini Analysis
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
    targetDir = performanceTestDir1;
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
    targetDir = performanceTestDirSelect;
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
    targetDir = performanceTestDir2;
  end
  [fH1, fH2, dPrimeMeanAllMiniAnalysis, ~, ~, aucAllMiniAnalysis, ~, ~, pHAUC(2), pHdPrime(2)] = summaryPerformance(folder, fH1, fH2, 'r', testType{iTest});
  [figures, legends, nHitsPDFPerRecordingMiniAnalysis, nFalseAlarmsPDFPerRecordingMiniAnalysis, centresMiniAnalysis, centresMiniAnalysisFA] = summaryDistance(folder, figures, legends, 'r', distType);

  % pClamp_raw
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
    targetDir = performanceTestDir1;
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
    targetDir = performanceTestDirSelect;
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
    targetDir = performanceTestDir2;
  end
  [fH1, fH2, dPrimeMeanAllpClampRaw2, ~, ~, aucAllpClampRaw2, ~, ~, pHAUC(3), pHdPrime(3)] = summaryPerformance(folder, fH1, fH2, 'm', testType{iTest});
  [figures, legends, nHitsPDFPerRecordingpClampRaw2, nFalseAlarmsPDFPerRecordingpClampRaw2, centrespClampRaw2, centrespClampRaw2FA] = summaryDistance(folder, figures, legends, 'm', distType);


  %% Calculate simulated event frequencies for different conditions
  durations = [200 200 100 100 100 100 100 100 100 100 100 100 100 100]';
  frequency = simEventCount./durations;
  meanFrequency = datamean(frequency);


  %% Figures
  % Common parameters
  figFolder = targetDir;
  yTickLabels = {'minis', 'MiniAnalysis', 'Clampfit'};
  legendString = {'minis', 'Mini Analysis', 'Clampfit'};
  colourCodes = {matlabColours(8),'r','m'};
  figSize = 17;

  %% 1. ROC figure
  figure(fH1);
  hold on
  plot([0 1], [0 1], 'k:')
  hold off
  legend(pHAUC, legendString, 'Location','SouthEast');
  legend boxoff

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'FPR', xlim, 0:0.2:1,...
    'on', 'k', 'TPR', ylim, 0:0.2:1);
  set(fH1, 'color','w');
  figName = 'ROC';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(fH1, gca, width, height, label, margin, 0);
  if ~exist(figFolder,'dir')
    mkdir(figFolder);
  end
  hgsave(fH1, [figFolder filesep figName '.fig']);
  exportFig(fH1, [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH1, [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(fH1);

  %% 2. d' figure
  figure(fH2);
  %legend(pHdPrime, legendString, 'Location','NorthEast');
  %legend boxoff

  if strcmpi(testType{iTest}, 'test1')
    yLim = [0 3.75];
    xLim = [0.5 14.5];
    xTicks = xticks;
  elseif strcmpi(testType{iTest}, 'testSelect')
    yLim = [0.5 3];
    xLim = [0.5 3.5];
    xTicks = [1 2 3];
  else
    yLim = [0.5 1.7];
    xLim = [0.5 3.5];
    xTicks = [1 2 3];
  end
  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'ROC condition from left to right', xLim, xTicks,...
    'on', 'k', 'd''', yLim, yticks);
  set(fH2, 'color','w');
  figName = 'dPrime';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(fH2, gca, width, height, label, margin, 0);
  hgsave(fH2, [figFolder filesep figName '.fig']);
  exportFig(fH2, [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH2, [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(fH2);

  if strcmpi(distType,'nearest')
    figure(figures(1));
    legend(legendString);
    xlabel('Time to neighbour (ms)');
    ylabel('TPR');
    title('PDF (nearest): Probability of mini detection as a function of time to the nearest neighbour');

    figure(figures(2));
    legend(legendString);
    xlabel('Time to neighbour (ms)');
    ylabel('Cumulative TPR');
    title('CDF (nearest): Cumulative probability of mini detection as a function of time to the nearest neighbour');

    % 5
    figure(figures(3));
    legend(legends{3},legendString, 'Location','NorthWest');
    legend boxoff
    axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
      'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
      'on', 'k', 'TPR', [0 1], 0:0.2:1);
    xticklabels({'0.1','1','10','100'});
    %yticklabels({'0.1','0.5','1'});
    set(figures(3), 'color','w');
    figName = 'distancePDF';

    label = [3.25 3];
    margin = [0.75 0.5];
    width = figSize-label(1)-margin(1);
    height = figSize-label(2)-margin(2);
    paperSize = resizeFig(figures(3), gca, width, height, label, margin, 0);
    hgsave(figures(3), [figFolder filesep figName '.fig']);
    exportFig(figures(3), [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
    exportFig(figures(3), [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
    %close(figures(3));

    % 6
    figure(figures(4));
    %legend(legends{4},legendString, 'Location','NorthWest');
    %legend boxoff
    if strcmpi(testType{iTest},'test1')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'Cumulative TPR', [0 0.275], 0:0.05:0.3);
    else
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'Cumulative TPR', [0 0.715], 0:0.1:0.7);
    end
    xticklabels({'0.1','1','10','100'});
    %yticklabels({'0.006','0.01','0.1','0.3'});
    set(figures(4), 'color','w');
    figName = 'distanceCDF';

    label = [3.25 3];
    margin = [0.75 0.5];
    width = figSize-label(1)-margin(1);
    height = figSize-label(2)-margin(2);
    paperSize = resizeFig(figures(4), gca, width, height, label, margin, 0);
    hgsave(figures(4), [figFolder filesep figName '.fig']);
    exportFig(figures(4), [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
    exportFig(figures(4), [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
    %close(figures(4));

    % 7
    figure(figures(5));
    %legend(legends{5},legendString, 'Location','NorthWest');
    %legend boxoff
    if strcmpi(testType{iTest},'test1')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'FPR', [0 0.375], 0:0.1:1);
    elseif strcmpi(testType{iTest},'testSelect')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'FPR', [0 0.375], 0:0.1:1);
    elseif strcmpi(testType{iTest},'test2')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'FPR', [0 0.52], 0:0.1:1);
    end
    xticklabels({'0.1','1','10','100'});
    %yticklabels({'0.1','0.5','1'});
    set(figures(5), 'color','w');
    figName = 'distancePDF_fa';

    label = [3.25 3];
    margin = [0.75 0.5];
    width = figSize-label(1)-margin(1);
    height = figSize-label(2)-margin(2);
    paperSize = resizeFig(figures(5), gca, width, height, label, margin, 0);
    hgsave(figures(5), [figFolder filesep figName '.fig']);
    exportFig(figures(5), [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
    exportFig(figures(5), [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
    %close(figures(5));

    % 8
    figure(figures(6));
    %legend(legends{6},legendString, 'Location','NorthWest');
    %legend boxoff
    if strcmpi(testType{iTest},'test1')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'Cumulative FPR', [0 0.301], 0:0.1:0.4);
    elseif strcmpi(testType{iTest},'testSelect')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'Cumulative FPR', [0 0.301], 0:0.1:0.4);
    elseif strcmpi(testType{iTest},'test2')
      axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
        'on', 'k', 'Time to neighbour (ms)', [0.05 100], [0.1 1 10 100],...
        'on', 'k', 'Cumulative FPR', [0 0.375], 0:0.1:0.4);
    end
    xticklabels({'0.1','1','10','100'});
    %yticklabels({'0.006','0.01','0.1','0.3'});
    set(figures(6), 'color','w');
    figName = 'distanceCDF_fa';

    label = [3.25 3];
    margin = [0.75 0.5];
    width = figSize-label(1)-margin(1);
    height = figSize-label(2)-margin(2);
    paperSize = resizeFig(figures(6), gca, width, height, label, margin, 0);
    hgsave(figures(6), [figFolder filesep figName '.fig']);
    exportFig(figures(6), [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
    exportFig(figures(6), [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
    %close(figures(6));
  else
    figure(figures(1));
    legend(legendString);
    xlabel('Average time to a neighbour (ms)');
    ylabel('TPR');
    title('PDF (average nearest): Probability of mini detection as a function of average time to a neighbour');

    figure(figures(2));
    legend(legendString);
    xlabel('Average time to a neighbour (ms)');
    ylabel('Cumulative TPR');
    title('CDF (average nearest): Cumulative probability of mini detection as a function of average time to a neighbour');

    figure(figures(3));
    legend(legends{1},legendString);
    xlabel('Average time to a neighbour (ms)');
    ylabel('TPR');
    title('PDF log (average nearest): Probability of mini detection as a function of average time to a neighbour');

    figure(figures(4));
    legend(legends{2},legendString);
    xlabel('Average time to a neighbour (ms)');
    ylabel('Cumulative TPR');
    title('CDF log (average nearest): Cumulative probability of mini detection as a function of average time to a neighbour');
  end

  %% 9. dPrime
  dPrimeMean = {dPrimeMeanAllMinis; dPrimeMeanAllMiniAnalysis; dPrimeMeanAllpClampRaw2};
  [dPrimeMeanMean, dPrimeCI95Mean] = datamean([dPrimeMeanAllMinis dPrimeMeanAllMiniAnalysis dPrimeMeanAllpClampRaw2]);
  [statsdPrime.ttest.pval, statsdPrime.ttest.area1, statsdPrime.ttest.area2, statsdPrime.ttest.tstat] = ttestGroup(yTickLabels, dPrimeMean);
  [statsdPrime.signrank.pval, statsdPrime.signrank.area1, statsdPrime.signrank.area2] = signrankGroup(yTickLabels, dPrimeMean);
  [statsdPrime.signtest.pval, statsdPrime.signtest.area1, statsdPrime.signtest.area2] = signtestGroup(yTickLabels, dPrimeMean);
  statsdPrime.area1sem = std(dPrimeMean{1})/sqrt(numel(dPrimeMean{1}));
  statsdPrime.area2sem = std(dPrimeMean{2})/sqrt(numel(dPrimeMean{2}));
  statsdPrime.area3sem = std(dPrimeMean{3})/sqrt(numel(dPrimeMean{3}));
  if strcmpi(testType{iTest}, 'test1')
    options.yLim = [0.5 3.1];
  elseif strcmpi(testType{iTest}, 'testSelect')
    options.yLim = [0.5 4];
  elseif strcmpi(testType{iTest}, 'test2')
    options.yLim = [0.375 2];
  end
  options.yLabel = 'd''';
  options.showNotches = false;
  options.medianPlot = false;
  options.colours = colourCodes;
  options.showNotches = false;
  options.medianPlot = false;
  options.violinVisibility = false;
  fH3 = multiViolinPlots(dPrimeMean, yTickLabels, dPrimeMeanMean, dPrimeCI95Mean, [], options);
  xticklabels(yTickLabels);
  set(fH3, 'Name','Mean dPrime across conditions');

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', {}, xlim, xticks,...
    'on', 'k', options.yLabel, options.yLim, yticks);
  set(fH3, 'color','w');
  figName = 'dPrimeMean';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(fH3, gca, width, height, label, margin, 0);
  hgsave(fH3, [figFolder filesep figName '.fig']);
  exportFig(fH3, [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH3, [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(fH3);

  %% 10. AUC
  auc = {aucAllMinis; aucAllMiniAnalysis; aucAllpClampRaw2};
  [aucMean, aucCI95] = datamean([aucAllMinis' aucAllMiniAnalysis' aucAllpClampRaw2']);
  [statsAUC.ttest.pval, statsAUC.ttest.area1, statsAUC.ttest.area2, statsAUC.ttest.tstat] = ttestGroup(yTickLabels, auc);
  [statsAUC.signrank.pval, statsAUC.signrank.area1, statsAUC.signrank.area2] = signrankGroup(yTickLabels, auc);
  [statsAUC.signtest.pval, statsAUC.signtest.area1, statsAUC.signtest.area2] = signtestGroup(yTickLabels, auc);
  statsAUC.area1sem = std(auc{1})/sqrt(numel(auc{1}));
  statsAUC.area2sem = std(auc{2})/sqrt(numel(auc{2}));
  statsAUC.area3sem = std(auc{3})/sqrt(numel(auc{3}));
  options.yLim = [];
  options.yLabel = 'Area under the curve';
  options.showNotches = false;
  options.medianPlot = false;
  options.colours = colourCodes;
  options.showNotches = false;
  options.medianPlot = false;
  options.violinVisibility = false;
  fH4 = multiViolinPlots(auc, yTickLabels, aucMean, aucCI95, [], options);
  xticklabels(yTickLabels);
  set(fH4, 'Name','Mean AUC across conditions');

  yTicks = yticks;
  yTicks = yTicks(1:2:end);
  if strcmpi(testType{iTest}, 'test2')
    axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
      'on', 'k', {}, xlim, xticks,...
      'on', 'k', options.yLabel, [0.6 0.8501], 0:0.05:1);
  else
    axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
      'on', 'k', {}, xlim, xticks,...
      'on', 'k', options.yLabel, ylim, yTicks);
  end
  set(fH4, 'color','w');
  figName = 'AUC';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(fH4, gca, width, height, label, margin, 0);
  hgsave(fH4, [figFolder filesep figName '.fig']);
  exportFig(fH4, [figFolder filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH4, [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(fH4);

  %% 11. Distance d'
  smoothingWindowSize = 41;
  perfmormanceStruct.centresFlatD2N = centresMinis;
  perfmormanceStruct.centresFlatD2N2 = centresMinisFA;
  % for col = 1:size(nHitsPDFPerRecordingMinis,2)
  %   if sum(nHitsPDFPerRecordingMinis(:,col), 'omitnan')
  %     break
  %   else
  %     nHitsPDFPerRecordingMinis(:,col) = ones(size(nHitsPDFPerRecordingMinis(:,col))).*min(min(nHitsPDFPerRecordingMinis(nHitsPDFPerRecordingMinis ~= 0)));
  %   end
  % end
  perfmormanceStruct.nHitsPDFPerRecordingFlatD2N = nHitsPDFPerRecordingMinis;
  % for col = 1:size(nFalseAlarmsPDFPerRecordingMinis,2)
  %   if sum(nFalseAlarmsPDFPerRecordingMinis(:,col), 'omitnan')
  %     break
  %   else
  %     nFalseAlarmsPDFPerRecordingMinis(:,col) = ones(size(nFalseAlarmsPDFPerRecordingMinis(:,col))).*min(min(nFalseAlarmsPDFPerRecordingMinis(nFalseAlarmsPDFPerRecordingMinis ~= 0)));
  %   end
  % end
  perfmormanceStruct.nFalseAlarmsPDFPerRecordingFlatD2N = nFalseAlarmsPDFPerRecordingMinis;
  [dPrimeFlatMeanMinis, dPrimeFlatCI95Minis, centresMinis] = dPrimeCalcFlat(perfmormanceStruct);
  [centresMinisInterp, dPrimeFlatMeanMinisInterpSmooth] = interpSmooth(centresMinis, dPrimeFlatMeanMinis, smoothingWindowSize, true);
  dPrimeFlatCI95MinisInterpSmooth = zeros(1,numel(dPrimeFlatMeanMinisInterpSmooth));
  [~, dPrimeFlatCI95MinisInterpSmooth(1,:)] = interpSmooth(centresMinis, dPrimeFlatCI95Minis(1,:), smoothingWindowSize, true);
  [~, dPrimeFlatCI95MinisInterpSmooth(2,:)] = interpSmooth(centresMinis, dPrimeFlatCI95Minis(2,:), smoothingWindowSize, true);

  perfmormanceStruct.centresFlatD2N = centresMiniAnalysis;
  perfmormanceStruct.centresFlatD2N2 = centresMiniAnalysisFA;
  % for col = 1:size(nHitsPDFPerRecordingMiniAnalysis,2)
  %   if sum(nHitsPDFPerRecordingMiniAnalysis(:,col), 'omitnan')
  %     break
  %   else
  %     nHitsPDFPerRecordingMiniAnalysis(:,col) = ones(size(nHitsPDFPerRecordingMiniAnalysis(:,col))).*min(min(nHitsPDFPerRecordingMiniAnalysis(nHitsPDFPerRecordingMiniAnalysis ~= 0)));
  %   end
  % end
  perfmormanceStruct.nHitsPDFPerRecordingFlatD2N = nHitsPDFPerRecordingMiniAnalysis;
  % for col = 1:size(nFalseAlarmsPDFPerRecordingMiniAnalysis,2)
  %   if sum(nFalseAlarmsPDFPerRecordingMiniAnalysis(:,col), 'omitnan')
  %     break
  %   else
  %     nFalseAlarmsPDFPerRecordingMiniAnalysis(:,col) = ones(size(nFalseAlarmsPDFPerRecordingMiniAnalysis(:,col))).*min(min(nFalseAlarmsPDFPerRecordingMiniAnalysis(nFalseAlarmsPDFPerRecordingMiniAnalysis ~= 0)));
  %   end
  % end
  perfmormanceStruct.nFalseAlarmsPDFPerRecordingFlatD2N = nFalseAlarmsPDFPerRecordingMiniAnalysis;
  [dPrimeFlatMeanMiniAnalysis, dPrimeFlatCI95MiniAnalysis, centresMiniAnalysis] = dPrimeCalcFlat(perfmormanceStruct);
  [centresMiniAnalysisInterp, dPrimeFlatMeanMiniAnalysisInterpSmooth] = interpSmooth(centresMiniAnalysis, dPrimeFlatMeanMiniAnalysis, smoothingWindowSize, true);
  dPrimeFlatCI95MiniAnalysisInterpSmooth = zeros(1,numel(dPrimeFlatMeanMiniAnalysisInterpSmooth));
  [~, dPrimeFlatCI95MiniAnalysisInterpSmooth(1,:)] = interpSmooth(centresMiniAnalysis, dPrimeFlatCI95MiniAnalysis(1,:), smoothingWindowSize, true);
  [~, dPrimeFlatCI95MiniAnalysisInterpSmooth(2,:)] = interpSmooth(centresMiniAnalysis, dPrimeFlatCI95MiniAnalysis(2,:), smoothingWindowSize, true);

  perfmormanceStruct.centresFlatD2N = centrespClampRaw2;
  perfmormanceStruct.centresFlatD2N2 = centrespClampRaw2FA;
  % for col = 1:size(nHitsPDFPerRecordingpClampRaw2,2)
  %   if sum(nHitsPDFPerRecordingpClampRaw2(:,col), 'omitnan')
  %     break
  %   else
  %     nHitsPDFPerRecordingpClampRaw2(:,col) = ones(size(nHitsPDFPerRecordingpClampRaw2(:,col))).*min(min(nHitsPDFPerRecordingpClampRaw2(nHitsPDFPerRecordingpClampRaw2 ~= 0)));
  %   end
  % end
  perfmormanceStruct.nHitsPDFPerRecordingFlatD2N = nHitsPDFPerRecordingpClampRaw2;
  % for col = 1:size(nFalseAlarmsPDFPerRecordingpClampRaw2,2)
  %   if sum(nFalseAlarmsPDFPerRecordingpClampRaw2(:,col), 'omitnan')
  %     break
  %   else
  %     nFalseAlarmsPDFPerRecordingpClampRaw2(:,col) = ones(size(nFalseAlarmsPDFPerRecordingpClampRaw2(:,col))).*min(min(nFalseAlarmsPDFPerRecordingpClampRaw2(nFalseAlarmsPDFPerRecordingpClampRaw2 ~= 0)));
  %   end
  % end
  perfmormanceStruct.nFalseAlarmsPDFPerRecordingFlatD2N = nFalseAlarmsPDFPerRecordingpClampRaw2;
  [dPrimeFlatMeanpClampRaw2, dPrimeFlatCI95pClampRaw2, centrespClampRaw2] = dPrimeCalcFlat(perfmormanceStruct);
  [centrespClampRaw2Interp, dPrimeFlatMeanpClampRaw2InterpSmooth] = interpSmooth(centrespClampRaw2, dPrimeFlatMeanpClampRaw2, smoothingWindowSize, true);
  dPrimeFlatCI95pClampRaw2InterpSmooth = zeros(1,numel(dPrimeFlatMeanpClampRaw2InterpSmooth));
  [~, dPrimeFlatCI95pClampRaw2InterpSmooth(1,:)] = interpSmooth(centrespClampRaw2, dPrimeFlatCI95pClampRaw2(1,:), smoothingWindowSize, true);
  [~, dPrimeFlatCI95pClampRaw2InterpSmooth(2,:)] = interpSmooth(centrespClampRaw2, dPrimeFlatCI95pClampRaw2(2,:), smoothingWindowSize, true);

  colours = {matlabColours(8),'r','m'};
  legends_fH5 = [];
  fH5 = figure;
  p = semilogx(centresMinisInterp, dPrimeFlatMeanMinisInterpSmooth, 'LineWidth',1, 'Color',colours{1}); hold on
  legends_fH5 = [legends_fH5 p];
  ciplot(dPrimeFlatMeanMinisInterpSmooth+dPrimeFlatCI95MinisInterpSmooth(1,:),...
    dPrimeFlatMeanMinisInterpSmooth+dPrimeFlatCI95MinisInterpSmooth(2,:),...
    centresMinisInterp,colours{1},0.2);
  p = semilogx(centresMiniAnalysisInterp, dPrimeFlatMeanMiniAnalysisInterpSmooth, 'LineWidth',1, 'Color',colours{2});
  legends_fH5 = [legends_fH5 p];
  ciplot(dPrimeFlatMeanMiniAnalysisInterpSmooth+dPrimeFlatCI95MiniAnalysisInterpSmooth(1,:),...
    dPrimeFlatMeanMiniAnalysisInterpSmooth+dPrimeFlatCI95MiniAnalysisInterpSmooth(2,:),...
    centresMiniAnalysisInterp,colours{2},0.2);
  p = semilogx(centrespClampRaw2Interp, dPrimeFlatMeanpClampRaw2InterpSmooth, 'LineWidth',1, 'Color',colours{3});
  legends_fH5 = [legends_fH5 p];
  ciplot(dPrimeFlatMeanpClampRaw2InterpSmooth+dPrimeFlatCI95pClampRaw2InterpSmooth(1,:),...
    dPrimeFlatMeanpClampRaw2InterpSmooth+dPrimeFlatCI95pClampRaw2InterpSmooth(2,:),...
    centrespClampRaw2Interp,colours{3},0.2);
  hold off

  if strcmpi(testType{iTest}, 'test1')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [-1 5];
    yTicks = -1:7;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'testSelect')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [-0.05 5.5];
    yTicks = -1:7;
    legendLocation = 'NorthWest';
  elseif strcmpi(testType{iTest}, 'test2')
    xLim = [0.05 100];
    xTicks = [0.1 1 10 100];
    xTickLabels = {'0.1','1','10','100'};
    yLim = [-0.5 5.5];
    yTicks = -1:7;
    legendLocation = 'NorthWest';
  end
  %legend(legends_fH5,legendString, 'Location',legendLocation);
  %legend boxoff

  axesProperties({}, 1, 'normal', 'off', 'w', 'Arial', 25, 4/3, 2, [0.003 0.003], 'out',...
    'on', 'k', 'Time to neighbour (ms)', xLim, xTicks,...
    'on', 'k', 'd''', yLim, yTicks);
  xticklabels(xTickLabels);
  set(fH5, 'color','w');
  figName = 'distancedPrime';

  label = [3.25 3];
  margin = [0.75 0.5];
  width = figSize-label(1)-margin(1);
  height = figSize-label(2)-margin(2);
  paperSize = resizeFig(fH5, gca, width, height, label, margin, 0);
  hgsave(fH5, [targetDir filesep figName '.fig']);
  exportFig(fH5, [targetDir filesep figName '.png'],'-dpng','-r300', paperSize);
  exportFig(fH5, [figFolder filesep figName '.eps'],'-depsc','-r1200', paperSize);
  %close(fH5);


  %% Save statistical data
  save([figFolder filesep 'stats.mat'], 'statsdPrime','dPrimeMeanMean','dPrimeCI95Mean',...
    'statsAUC','aucMean','aucCI95', '-v7.3');
end
close all



%% Local functions
function [fH1, fH2, dPrimeMeanAll, dPrimeMeanMean, dPrimeMeanCI95, aucAll, aucMean, aucCI95, pH1, pH2, simEventCountAll] = summaryPerformance(folder, fH1, fH2, colour, testType)

if nargin < 4
    colour = matlabColours(8);
end

roc1All = [];
roc2All = [];
dPrimeAll = [];
dPrimeMeanAll = [];
aucAll = [];
simEventCountAll = [];
for iF = 1:numel(folder)
    [fh1,fh2,roc,dPrime,dPrimeMean,auc,fileOrder,simEventCount] = rocCurve(folder{iF});
    close(fh1); close(fh2);
    roc1All = [roc1All; roc(1,fileOrder-2)]; %#ok<*AGROW>
    roc2All = [roc2All; roc(2,fileOrder-2)];
    dPrimeAll = [dPrimeAll; dPrime(fileOrder-2)];
    dPrimeMeanAll = [dPrimeMeanAll; dPrimeMean];
    aucAll = [aucAll; auc];
    simEventCountAll = [simEventCountAll; simEventCount(fileOrder-2)];
end

[roc1Mean, roc1CI95] = datamean(roc1All);
[roc2Mean, roc2CI95] = datamean(roc2All);
[dPrimeMean, dPrimeCI95] = datamean(dPrimeAll);
[dPrimeMeanMean, dPrimeMeanCI95] = datamean(dPrimeMeanAll);
[aucMean, aucCI95] = datamean(aucAll);
aucAll = aucAll';

% Interpolate ROCs
[~, iPks] = findpeaks(roc1Mean);
[~, iTroughs] = findpeaks(-roc1Mean);
iPks = sort([iPks iTroughs]);
stepSizeNormalised = 1/1000;
roc1MeanInterp = zeros(round(1/stepSizeNormalised)+1,numel(iPks)+1);
roc2MeanInterp = zeros(round(1/stepSizeNormalised)+1,numel(iPks)+1);
if isempty(iPks)
    inds = 1:numel(roc1Mean);
    chunkLims = sort([roc1Mean(inds(1)) roc1Mean(inds(end))]);
    chunkSize = abs(diff(chunkLims));
    stepSize = stepSizeNormalised*chunkSize;
    roc1MeanInterp = chunkLims(1):stepSize:chunkLims(2);
    roc2MeanInterp = interp1(roc1Mean(inds),roc2Mean(inds),roc1MeanInterp,'pchip');
else
    for peak = 1:numel(iPks)
        if peak == 1
            inds = 1:iPks(peak);
        else
            inds = iPks(peak-1):iPks(peak);
        end
        chunkLims = sort([roc1Mean(inds(1)) roc1Mean(inds(end))]);
        chunkSize = abs(diff(chunkLims));
        stepSize = stepSizeNormalised*chunkSize;
        roc1MeanInterp(:,peak) = chunkLims(1):stepSize:chunkLims(2);
        roc2MeanInterp(:,peak) = interp1(roc1Mean(inds),roc2Mean(inds),roc1MeanInterp(:,peak),'pchip');
        if peak == numel(iPks)
            inds = iPks(peak):numel(roc1Mean);
            chunkLims = sort([roc1Mean(inds(1)) roc1Mean(inds(end))]);
            chunkSize = abs(diff(chunkLims));
            stepSize = stepSizeNormalised*chunkSize;
            roc1MeanInterp(:,peak+1) = chunkLims(1):stepSize:chunkLims(2);
            roc2MeanInterp(:,peak+1) = interp1(roc1Mean(inds),roc2Mean(inds),roc1MeanInterp(:,peak+1),'pchip');
        end
    end
end

% Plot ROCs
if nargin < 2 || isempty(fH1)
    fH1 = figure;
else
    figure(fH1);
end
hold on
pH1 = plot(roc1MeanInterp, roc2MeanInterp, '-', 'Color',colour, 'Linewidth',1);
uistack(pH1, 'bottom');
if strcmpi(testType, 'test1')
  p = plot(roc1Mean(4:6), roc2Mean(4:6), 'o', 'MarkerEdgeColor',colour, 'MarkerSize',20);
  uistack(p, 'bottom');
end
pH1 = pH1(1);
eH = errorbar(roc1Mean, roc2Mean, abs(roc1CI95(1,:)), abs(roc1CI95(2,:)),...
    abs(roc2CI95(1,:)), abs(roc2CI95(2,:)), '.', 'MarkerSize',15, 'Color',colour,...
    'LineWidth',2, 'Capsize',0);
uistack(eH, 'bottom');
xlim([-0.05 1.05]);
ylim([-0.05 1.05]);
hold off

% dataOrder = [8 1 4 7 3 6 9 10 11 12 13 14 2 5];
% for iCond = 1:numel(roc1Mean)
%     text(roc1Mean(iCond),roc2Mean(iCond), num2str(dataOrder(iCond)), 'Interpreter','None');
% end

% Interpolate d primes
xInterp = 1:0.001:numel(dPrimeMean);
dPrimeInterp = interp1(1:numel(dPrimeMean),dPrimeMean,xInterp,'pchip');

% Combined dPrimes
if nargin < 3 || isempty(fH2)
    fH2 = figure;
else
    figure(fH2);
end
hold on
pH2 = plot(xInterp,dPrimeInterp, '-', 'Color',colour);
uistack(pH2, 'bottom');
if strcmpi(testType, 'test1')
  p = plot(4:6, dPrimeMean(4:6), 'o', 'MarkerEdgeColor',colour, 'MarkerSize',20);
  uistack(p, 'bottom');
end
eH = errorbar(1:numel(dPrimeMean),dPrimeMean, abs(dPrimeCI95(1,:)), abs(dPrimeCI95(2,:)),...
    '.', 'MarkerSize',15, 'Color',colour, 'LineWidth',2, 'Capsize',0);
uistack(eH, 'bottom');
hold off
end

function [figures, legends, nHitsPDFPerRecording, nFalseAlarmsPDFPerRecording, centresHits, centresFA] = summaryDistance(folder, figures, legends, colour, type)

if nargin < 5
    type = 'nearest';
end
if nargin < 4
    colour = matlabColours(8);
end
if nargin < 3 || isempty(legends)
    legends{1} = [];
    legends{2} = [];
    legends{3} = [];
    legends{4} = [];
    legends{5} = [];
    legends{6} = [];
end

distance2neighbourCombined = [];
distance2neighbourCombinedHits = [];
distance2neighbourPerRecording = {};
distance2neighbourPerRecordingHits = {};
distance2neighbourPerRecordingFA = {};
distance2neighbourPerRecordingCR = {};
for iF = 1:numel(folder)
    distance2neighbourRecording = [];
    distance2neighbourRecordingHits = [];
    d = dir(folder{iF});
    for iFile = 1:numel(d)
        if contains(d(iFile).name, '.mat')
            disp([iF iFile])
            
            % Extract the noise scaling factor
            scaleFactorIndStart = strfind(d(iFile).name,'noiseScaleFactor') + 16;
            scaleFactorIndEnd = strfind(d(iFile).name,'smoothWindow') - 2;
            scaleFactor = d(iFile).name(scaleFactorIndStart:scaleFactorIndEnd);
            scaleFactor = strrep(scaleFactor, 'p', '.');
            scaleFactor = str2double(scaleFactor);
            if scaleFactor == 1
                realData = load([folder{iF} filesep d(iFile).name]);
                for iRun = 1:numel(realData.performance)
                    
                    % Get real data for a particular simulation instance
                    allTrue = realData.performance{iRun}(1,:);
                    trueI = find(allTrue);
                    trueT = trueI.*realData.dt;
                    misses = find(realData.performance{iRun}(5,:));
                    [~, hitsI] = setdiff(trueI, misses);
                    
                    % Calculate the time to the nearest neighbour
                    if strcmpi(type, 'nearest') %&& ~isfield(realData, 'distance2neighbour')
                        distanceToTheRight = abs([trueT(2:end) inf] - trueT);
                        distanceToTheLeft = abs([inf trueT(1:end-1)] - trueT);
                        distance2neighbour{iRun} = min([distanceToTheRight; distanceToTheLeft],[],1);
                    elseif strcmpi(type, 'average')
                        distanceToTheRight = abs([trueT(2:end) inf] - trueT);
                        distanceToTheLeft = abs([inf trueT(1:end-1)] - trueT);
                        distanceToTheRight(end) = distanceToTheLeft(end);
                        distanceToTheLeft(1) = distanceToTheRight(1);
                        distance2neighbour{iRun} = mean([distanceToTheRight; distanceToTheLeft],1);
                    end
                    
                    % Combine data
                    distance2neighbourCombined = [distance2neighbourCombined distance2neighbour{iRun}];
                    distance2neighbourCombinedHits = [distance2neighbourCombinedHits distance2neighbour{iRun}(hitsI)];
                    distance2neighbourRecording = [distance2neighbourRecording distance2neighbour{iRun}];
                    distance2neighbourRecordingHits = [distance2neighbourRecordingHits distance2neighbour{iRun}(hitsI)];
                    
                    falseAlarms = realData.performance{iRun}(6,:);
                    falseAlarmsFlatI = find(falseAlarms);
                    falseAlarmsFlatT = falseAlarmsFlatI.*realData.dt;
                    falseAlarmsFlatD2N = zeros(size(falseAlarmsFlatI));
                    for iFA = 1:numel(falseAlarmsFlatI)
                        falseAlarmsFlatD2N(iFA) = min(abs(trueT - falseAlarmsFlatT(iFA)));
                    end
                    
                    correctRejections = realData.performance{iRun}(7,:);
                    correctRejectionsFlatI = find(correctRejections);
                    correctRejectionsFlatT = correctRejectionsFlatI.*realData.dt;
                    correctRejectionsFlatD2N = zeros(size(correctRejectionsFlatI));
                    for iFA = 1:numel(correctRejectionsFlatI)
                        correctRejectionsFlatD2N(iFA) = min(abs(trueT - correctRejectionsFlatT(iFA)));
                    end
                end
            end
        end
    end
    distance2neighbourPerRecording = [distance2neighbourPerRecording; distance2neighbourRecording];
    distance2neighbourPerRecordingHits = [distance2neighbourPerRecordingHits; distance2neighbourRecordingHits];
    distance2neighbourPerRecordingFA = [distance2neighbourPerRecordingFA; falseAlarmsFlatD2N];
    distance2neighbourPerRecordingCR = [distance2neighbourPerRecordingCR; correctRejectionsFlatD2N];
    
end

% Calculate distributions
maxDist = floor(max(distance2neighbourCombined));
binSize = 0.1;
edgesHits = 0:binSize:maxDist;
centresHits = edgesHits(1:end-1) + binSize/2;

nAllTrue = histcounts(distance2neighbourCombined, edgesHits);
nHits = histcounts(distance2neighbourCombinedHits, edgesHits);
nHitsPDF = nHits./nAllTrue;
nHitsCDF = cumsum(nHits,'omitnan')./numel(distance2neighbourCombined);

% figure; semilogx(centres, nAllTrue); hold on
% semilogx(centres, nHits); hold off

% Hit rate
nHitsPDFPerRecording = [];
nHitsCDFPerRecording = [];
for iRec = 1:numel(distance2neighbourPerRecording)
    nAllTrueRecording = histcounts(distance2neighbourPerRecording{iRec}, edgesHits);
    nHitsRecording = histcounts(distance2neighbourPerRecordingHits{iRec}, edgesHits);
    nHitsPDFPerRecording = [nHitsPDFPerRecording; nHitsRecording./nAllTrueRecording];
    nHitsCDFPerRecording = [nHitsCDFPerRecording; cumsum(nHitsRecording,'omitnan')./numel(distance2neighbourPerRecording{iRec})];
end
[nHitsPDFPerRecordingMean, nHitsPDFPerRecordingCI95] = datamean(nHitsPDFPerRecording);
[nHitsCDFPerRecordingMean, nHitsCDFPerRecordingCI95] = datamean(nHitsCDFPerRecording);

% Probability of detecting a mini as a function of time to the nearest neighbour
if nargin < 2 || isempty(figures) || numel(figures) < 1
    figures(1) = figure;
else
    figure(figures(1)); hold on
end
semilogx(centresHits, nHitsPDF, 'LineWidth',2, 'Color',colour);
%loglog(centres, nHitsPDF, 'LineWidth',2, 'Color',colour);
hold off

% Cumulative probability of detecting a mini as a function of time to the nearest neighbour
if nargin < 2 || isempty(figures) || numel(figures) < 2
    figures(2) = figure;
else
    figure(figures(2)); hold on
end
semilogx(centresHits, nHitsCDF, 'LineWidth',2, 'Color',colour);
%loglog(centres, nHitsCDF, 'LineWidth',2, 'Color',colour);
hold off

% Probability of detecting a mini as a function of time to the nearest neighbour (with 95% CI)
smoothingWindowSize = 41;
[centresInterp, nHitsPDFPerRecordingMeanInterpSmooth] = interpSmooth(centresHits, nHitsPDFPerRecordingMean, smoothingWindowSize, true);
nHitsPDFPerRecordingCI95InterpSmooth = zeros(1,numel(centresInterp));
[~, nHitsPDFPerRecordingCI95InterpSmooth(1,:)] = interpSmooth(centresHits, nHitsPDFPerRecordingCI95(1,:), smoothingWindowSize, true);
[~, nHitsPDFPerRecordingCI95InterpSmooth(2,:)] = interpSmooth(centresHits, nHitsPDFPerRecordingCI95(2,:), smoothingWindowSize, true);

if nargin < 2 || isempty(figures) || numel(figures) < 3
    figures(3) = figure;
else
    figure(figures(3)); hold on
end
p = semilogx(centresInterp(~isnan(nHitsPDFPerRecordingMeanInterpSmooth)), nHitsPDFPerRecordingMeanInterpSmooth(~isnan(nHitsPDFPerRecordingMeanInterpSmooth)),...
   'LineWidth',1, 'Color',colour); hold on
% p = loglog(centresInterp(~isnan(nHitsPDFPerRecordingMeanInterpSmooth)), nHitsPDFPerRecordingMeanInterpSmooth(~isnan(nHitsPDFPerRecordingMeanInterpSmooth)),...
%     'LineWidth',1, 'Color',colour); hold on
legends{3} = [legends{3} p];
lowerLim = nHitsPDFPerRecordingMeanInterpSmooth(~isnan(nHitsPDFPerRecordingMeanInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95InterpSmooth(1,:))) +...
    nHitsPDFPerRecordingCI95InterpSmooth(1,~isnan(nHitsPDFPerRecordingMeanInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95InterpSmooth(1,:)));
lowerLim(lowerLim <= 0) = 1e-9;
upperLim = nHitsPDFPerRecordingMeanInterpSmooth(~isnan(nHitsPDFPerRecordingMeanInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95InterpSmooth(2,:))) +...
    nHitsPDFPerRecordingCI95InterpSmooth(2,~isnan(nHitsPDFPerRecordingMeanInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95InterpSmooth(2,:)));
upperLim(upperLim <= 0 | upperLim > 1.5) = 1e-9;
ciplot(lowerLim,upperLim, centresInterp(~isnan(nHitsPDFPerRecordingMeanInterpSmooth) & ~isnan(nHitsPDFPerRecordingCI95InterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of detecting a mini as a function of time to the nearest neighbour  (with 95% CI)
if nargin < 2 || isempty(figures) || numel(figures) < 4
    figures(4) = figure;
else
    figure(figures(4)); hold on
end
p = semilogx(centresHits, nHitsCDFPerRecordingMean, 'LineWidth',1, 'Color',colour); hold on
% p = loglog(centres, nHitsCDFPerRecordingMean, 'LineWidth',1, 'Color',colour); hold on
legends{4} = [legends{4} p];
lowerLim = nHitsCDFPerRecordingMean+nHitsCDFPerRecordingCI95(1,:);
lowerLim(lowerLim <= 0) = 1e-9;
upperLim = nHitsCDFPerRecordingMean+nHitsCDFPerRecordingCI95(2,:);
upperLim(upperLim <= 0 | upperLim > 1.5) = 1e-9;
ciplot(lowerLim,upperLim, centresHits,colour,0.2);
hold off

% False alarm rate
binSize = 0.5;
edgesFA = 0:binSize:maxDist;
centresFA = edgesFA(1:end-1) + binSize/2;
nFalseAlarmsPDFPerRecording = [];
nFalseAlarmsCDFPerRecording = [];
for iRec = 1:numel(distance2neighbourPerRecordingFA)
    nAllFalseRecording = histcounts([distance2neighbourPerRecordingFA{iRec} distance2neighbourPerRecordingCR{iRec}], edgesFA);
    nFalseAlarmsRecording = histcounts(distance2neighbourPerRecordingFA{iRec}, edgesFA);
    nFalseAlarmsPDFPerRecording = [nFalseAlarmsPDFPerRecording; nFalseAlarmsRecording./nAllFalseRecording];
    nFalseAlarmsCDFPerRecording = [nFalseAlarmsCDFPerRecording;...
        cumsum(nFalseAlarmsRecording,'omitnan')./numel([distance2neighbourPerRecordingFA{iRec} distance2neighbourPerRecordingCR{iRec}])];
end
[nFalseAlarmsPDFPerRecordingMean, nFalseAlarmsPDFPerRecordingCI95] = datamean(nFalseAlarmsPDFPerRecording);
[nFalseAlarmsCDFPerRecordingMean, nFalseAlarmsCDFPerRecordingCI95] = datamean(nFalseAlarmsCDFPerRecording);

% Probability of a false alarm as a function of time to the nearest neighbour (with 95% CI)
smoothingWindowSize = 41;
[centresInterp, nFalseAlarmsPDFPerRecordingMeanInterpSmooth] = interpSmooth(centresFA, nFalseAlarmsPDFPerRecordingMean, smoothingWindowSize, true);
nFalseAlarmsPDFPerRecordingCI95InterpSmooth = zeros(1,numel(centresInterp));
[~, nFalseAlarmsPDFPerRecordingCI95InterpSmooth(1,:)] = interpSmooth(centresFA, nFalseAlarmsPDFPerRecordingCI95(1,:), smoothingWindowSize, true);
[~, nFalseAlarmsPDFPerRecordingCI95InterpSmooth(2,:)] = interpSmooth(centresFA, nFalseAlarmsPDFPerRecordingCI95(2,:), smoothingWindowSize, true);

if nargin < 2 || isempty(figures) || numel(figures) < 5
    figures(5) = figure;
else
    figure(figures(5)); hold on
end
p = semilogx(centresInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth)), nFalseAlarmsPDFPerRecordingMeanInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth)),...
   'LineWidth',1, 'Color',colour); hold on
% p = loglog(centresInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth)), nFalseAlarmsPDFPerRecordingMeanInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth)),...
%     'LineWidth',1, 'Color',colour); hold on
legends{5} = [legends{5} p];
lowerLim = nFalseAlarmsPDFPerRecordingMeanInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95InterpSmooth(1,:))) +...
    nFalseAlarmsPDFPerRecordingCI95InterpSmooth(1,~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95InterpSmooth(1,:)));
lowerLim(lowerLim <= 0) = 1e-9;
upperLim = nFalseAlarmsPDFPerRecordingMeanInterpSmooth(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95InterpSmooth(2,:))) +...
    nFalseAlarmsPDFPerRecordingCI95InterpSmooth(2,~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95InterpSmooth(2,:)));
upperLim(upperLim <= 0 | upperLim > 1.5) = 1e-9;
ciplot(lowerLim,upperLim, centresInterp(~isnan(nFalseAlarmsPDFPerRecordingMeanInterpSmooth) & ~isnan(nFalseAlarmsPDFPerRecordingCI95InterpSmooth(1,:))), colour, 0.2);
hold off
ylim([0 1]);

% Cumulative probability of detecting a mini as a function of time to the nearest neighbour  (with 95% CI)
if nargin < 2 || isempty(figures) || numel(figures) < 6
    figures(6) = figure;
else
    figure(figures(6)); hold on
end
p = semilogx(centresFA, nFalseAlarmsCDFPerRecordingMean, 'LineWidth',1, 'Color',colour); hold on
% p = loglog(centres, nFalseAlarmsCDFPerRecordingMean, 'LineWidth',1, 'Color',colour); hold on
legends{6} = [legends{6} p];
lowerLim = nFalseAlarmsCDFPerRecordingMean+nFalseAlarmsCDFPerRecordingCI95(1,:);
lowerLim(lowerLim <= 0) = 1e-9;
upperLim = nFalseAlarmsCDFPerRecordingMean+nFalseAlarmsCDFPerRecordingCI95(2,:);
upperLim(upperLim <= 0 | upperLim > 1.5) = 1e-9;
ciplot(lowerLim,upperLim, centresFA,colour,0.2);
hold off
end

function [p, area1, area2, tstat] = ttestGroup(areaNames, data)

areaCombos = nchoosek(1:numel(areaNames), 2);
nCombos = size(areaCombos,1);
area1 = areaNames(areaCombos(:,1));
area2 = areaNames(areaCombos(:,2));
p = zeros(1,nCombos);
for iCombo = 1:nCombos
    areaCode1 = areaCombos(iCombo,1);
    areaCode2 = areaCombos(iCombo,2);
    [~,p(iCombo),~,stats] = ttest(data{areaCode1}(~isinf(data{areaCode1}+data{areaCode2}) & ~isnan(data{areaCode1}+data{areaCode2})),...
        data{areaCode2}(~isinf(data{areaCode1}+data{areaCode2}) & ~isnan(data{areaCode1}+data{areaCode2})));
    tstat(iCombo) = stats.tstat;
end
end

function [p, area1, area2] = signrankGroup(areaNames, data)

areaCombos = nchoosek(1:numel(areaNames), 2);
nCombos = size(areaCombos,1);
area1 = areaNames(areaCombos(:,1));
area2 = areaNames(areaCombos(:,2));
p = zeros(1,nCombos);
for iCombo = 1:nCombos
    areaCode1 = areaCombos(iCombo,1);
    areaCode2 = areaCombos(iCombo,2);
    p(iCombo) = signrank(data{areaCode1}, data{areaCode2});
end
end

function [p, area1, area2] = signtestGroup(areaNames, data)

areaCombos = nchoosek(1:numel(areaNames), 2);
nCombos = size(areaCombos,1);
area1 = areaNames(areaCombos(:,1));
area2 = areaNames(areaCombos(:,2));
p = zeros(1,nCombos);
for iCombo = 1:nCombos
    areaCode1 = areaCombos(iCombo,1);
    areaCode2 = areaCombos(iCombo,2);
    p(iCombo) = signtest(data{areaCode1}, data{areaCode2});
end
end