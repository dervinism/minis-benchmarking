function [interpGridInterp, dataVecInterpSmooth] = interpSmooth(centresRise, dataVec, smoothingWindowSize, replacenan, interpGrid)

if nargin < 5
    interpGrid = centresRise;
end

if replacenan
    dataVec(isnan(dataVec)) = 0;
end
dataSign = mean(interpGrid, 'omitnan');
interpGridInterp = log10(abs(interpGrid));
interpStep = abs(interpGridInterp(1)-interpGridInterp(end))/1000;
if dataSign < 0
    interpGridInterp = interpGridInterp(1):-interpStep:interpGridInterp(end);
    interpGridInterp = -(10.^interpGridInterp);
else
    interpGridInterp = interpGridInterp(1):interpStep:interpGridInterp(end);
    interpGridInterp = 10.^interpGridInterp;
end
dataVecInterp = interp1(centresRise(~isnan(dataVec)),...
    dataVec(~isnan(dataVec)), interpGridInterp, 'linear');
if replacenan && isnan(dataVecInterp(end))
    dataVecInterp(end) = dataVecInterp(end-1);
end
if replacenan && isnan(dataVecInterp(1))
    dataVecInterp(isnan(dataVecInterp)) = dataVecInterp(find(~isnan(dataVecInterp),1)); %#ok<*FNDSB>
end
if ~isempty(smoothingWindowSize)
    dataVecInterpSmooth = smoothdata(dataVecInterp(~isnan(dataVecInterp) &...
        ~isnan(dataVecInterp(1,:))), 'gaussian',smoothingWindowSize);
else
    dataVecInterpSmooth = dataVecInterp;
end
end