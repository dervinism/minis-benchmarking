function [dataMean, dataCI95] = datamean(data, meanType)
% [dataMean, dataCI95] = datamean(data, meanType)
% Function calculates the mean of a data vector. Infinite values are
% treated as NaNs. NaNs are ommited from calculations.
% Input: data - a data vector or a data column matrix.
%        meanType - 'regular' for a regular mean, 'circular' for a
%                   circular mean and 'circularNP' for a circular mean with
%                   non-parametric confidence intervals. The default is
%                   'regular'.
% Output: dataMean
%         dataCI95 - a 95% confidence around the data mean.

if nargin < 2
    meanType = 'regular';
end

dataMean = []; dataCI95 = [];
if isempty(data)
    return
end
data(isinf(data)) = NaN;
n = sum(~isnan(data),1); % number of significant cells
F = size(data, 2); % number of frequencies or time
if n == 1
    dataMean = data;
    return
end

% Mean calculations
if strcmp(meanType, 'regular')
    dataMean = mean(data, 1, 'omitnan');
    dataStd = std(data, 1, 'omitnan');
    dataSEM = dataStd ./ n;
    CI95 = zeros(2,F);
    dataCI95 = zeros(2,F);
    for f = 1:F
        CI95(:,f) = (tinv([0.025 0.975], n(f)-1))';
        dataCI95(:,f) = bsxfun(@times, dataSEM(f), CI95(:,f));
    end
elseif strcmp(meanType, 'circular') || strcmp(meanType, 'circularNP')
    dataMean = NaN(1,size(data,2));
    dataCI95 = NaN(2,size(data,2));
    for j = 1:size(data,2)
      if sum(~isnan(data(:,j)))
        dataMean(j) = circmean(data(:,j));
        if strcmp(meanType, 'circular')
            dataCI95(2,j) = circ_confmean(data(~isnan(data(:,j)),j), 0.05);
        else
            dataCI95(2,j) = circ_confmeanFisher(data(~isnan(data(:,j)),j), 0.05);
        end
      else
        dataMean(j) = NaN;
        dataCI95(2,j) = NaN;
      end
    end
    dataCI95(1,:) = -dataCI95(2,:);
end