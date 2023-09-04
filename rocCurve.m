function [fH1, fH2, roc, dPrime, dPrimeMean, auc, fileOrder, simEventCount] = rocCurve(path2data)


%% Load data
d = dir(path2data);
if numel(d) > 5
    fileOrder = [fliplr([3 6 8 16 5 7 15 4]) 9:14];
    %fileOrder = [10 3 6 9 5 8 11 12 13 14 15 16 4 7];
else
    if contains(d(3).name, '1000')
        fileOrder = [3 5 4];
    elseif contains(d(3).name, '1250')
        fileOrder = [4 3 5];
    else
        fileOrder = [3 5 4];
    end
end
sensitivityAll = zeros(1,numel(d)-2);
specificityAll = zeros(1,numel(d)-2);
FPRall = zeros(1,numel(d)-2);
dPrimeAll = zeros(1,numel(d)-2);
ampsAll = zeros(1,numel(d)-2);
nAll = zeros(1,numel(d)-2);
simEventCount = zeros(1,numel(d)-2);
for iFile = 1:numel(d)
    if ~strcmpi(d(iFile).name, '.') && ~strcmpi(d(iFile).name, '..')
        load([path2data filesep d(iFile).name], 'sensitivity','specificity','FPR','dPrime','optimisationParameters','performance');
        sensitivityAll(iFile-2) = mean(cell2mat(sensitivity));
        specificityAll(iFile-2) = mean(cell2mat(specificity));
        FPRall(iFile-2) = mean(cell2mat(FPR));
        dPrimeAll(iFile-2) = mean(cell2mat(dPrime));
        ampsAll(iFile-2) = optimisationParameters.options.bounds(1);
        nAll(iFile-2) = optimisationParameters.options.bounds(1,3);
        simEventCountFile = 0;
        for iSimFile = 1:numel(performance)
            simEventCountFile = simEventCountFile + sum(performance{iSimFile}(1,:));
        end
        simEventCount(iFile-2) = simEventCountFile/iSimFile;
    end
end
if numel(fileOrder) > 1
    xAUC = 1-specificityAll(fileOrder-2);
    yAUC = sensitivityAll(fileOrder-2);
    [maxX, imaxX] = max(xAUC);
    [maxY, imaxY] = max(yAUC);
    for i = 1:numel(xAUC)
        if i > max([imaxX imaxY]) && xAUC(i) < maxX && yAUC(i) < maxY
            xAUC(i) = maxX;
            yAUC(i) = maxY;
        end
    end
    areaAboveChanceUnadjusted = trapz(xAUC, yAUC) - trapz([xAUC(1) xAUC(end)], [xAUC(1) xAUC(end)]);
    areaAboveChanceIdeal = (xAUC(end) - xAUC(1)) - trapz([xAUC(1) xAUC(end)], [xAUC(1) xAUC(end)]);
    auc = areaAboveChanceUnadjusted*(0.5/areaAboveChanceIdeal) + 0.5;
    if isnan(auc) || auc <= 0 || auc > 1
        error('A suspicious AUC value detected');
    end
else
    auc = [];
end


%% Plot the ROC curve
fH1 = figure; plot(1-specificityAll, sensitivityAll, 'g.', 'MarkerSize',20); hold on;
xlim([-0.05 1.05]);
ylim([-0.05 1.05]);

for iFile = fileOrder
    if ~strcmpi(d(iFile).name, '.') && ~strcmpi(d(iFile).name, '..')
        %text(1-specificityAll(iFile-2),sensitivityAll(iFile-2),num2str(iFile-2));
        %text(1-specificityAll(iFile-2),sensitivityAll(iFile-2),num2str(ampsAll(iFile-2)));
        i1 = strfind(d(iFile).name, 'noiseScaleFactor') + 16;
        i2 = strfind(d(iFile).name, 'smoothWindow');
        smoothWindow = strrep(d(iFile).name(i1:i2-2), 'p', '.');
        text(1-specificityAll(iFile-2),sensitivityAll(iFile-2), [num2str(nAll(iFile-2)) '_' smoothWindow],...
            'Interpreter','None');
    end
end

plot([0 1], [0 1], 'k:')
xlabel('FPR');
ylabel('TPR');
title('ROC');


%% Plot d'
fH2 = figure; plot(1:numel(fileOrder),dPrimeAll(fileOrder-2), 'g.', 'MarkerSize',20);

for iFile = 1:numel(fileOrder)
    if ~strcmpi(d(fileOrder(iFile)).name, '.') && ~strcmpi(d(fileOrder(iFile)).name, '..')
        i1 = strfind(d(fileOrder(iFile)).name, 'noiseScaleFactor') + 16;
        i2 = strfind(d(fileOrder(iFile)).name, 'smoothWindow');
        smoothWindow = strrep(d(fileOrder(iFile)).name(i1:i2-2), 'p', '.');
        text(iFile,dPrimeAll(fileOrder(iFile)-2), [num2str(nAll(fileOrder(iFile)-2)) '_' smoothWindow],...
            'Interpreter','None');
    end
end

xlabel('Condition (ROC curve left to right)');
ylabel('dPrime');
title('dPrime');


%% Assign output
roc = [1-specificityAll; sensitivityAll];
dPrime = dPrimeAll;
dPrimeMean = mean(dPrime, 'omitnan');
simEventCount = simEventCount;