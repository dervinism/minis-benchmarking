function [dPrimeFlatMean, dPrimeFlatCI95, centresInterp] = dPrimeCalcFlat(decayDetectionPerformance)

centresInterp = unique([decayDetectionPerformance.centresFlatD2N decayDetectionPerformance.centresFlatD2N2]);
nHitsPDFPerRecordingFlatInterp = interp1(decayDetectionPerformance.centresFlatD2N,decayDetectionPerformance.nHitsPDFPerRecordingFlatD2N',centresInterp, 'linear','extrap')';
nHitsPDFPerRecordingFlatInterp(nHitsPDFPerRecordingFlatInterp < 0) = 0;
nHitsPDFPerRecordingFlatInterp(nHitsPDFPerRecordingFlatInterp > 1) = 1;
% for col = 1:size(nHitsPDFPerRecordingFlatInterp,2)
%   if sum(nHitsPDFPerRecordingFlatInterp(:,col), 'omitnan')
%     break
%   else
%     existsValue = nHitsPDFPerRecordingFlatInterp;
%     existsValue(isnan(existsValue)) = 0;
%     existsValue = logical(sum(existsValue));
%     noValue = 1; %max([1 numel(existsValue) - sum(existsValue)]);
%     nHitsPDFPerRecordingFlatInterp(:,col) = ones(size(nHitsPDFPerRecordingFlatInterp(:,col))).*(min(min(nHitsPDFPerRecordingFlatInterp(nHitsPDFPerRecordingFlatInterp ~= 0)))/noValue);
%   end
% end
nFalseAlarmsPDFPerRecordingFlatInterp = interp1(decayDetectionPerformance.centresFlatD2N2,decayDetectionPerformance.nFalseAlarmsPDFPerRecordingFlatD2N',centresInterp, 'linear','extrap')';
nFalseAlarmsPDFPerRecordingFlatInterp(nFalseAlarmsPDFPerRecordingFlatInterp < 0) = 0;
nFalseAlarmsPDFPerRecordingFlatInterp(nFalseAlarmsPDFPerRecordingFlatInterp > 1) = 1;
% for col = 1:size(nFalseAlarmsPDFPerRecordingFlatInterp,2)
%   if sum(nFalseAlarmsPDFPerRecordingFlatInterp(:,col), 'omitnan')
%     break
%   else
%     existsValue = nFalseAlarmsPDFPerRecordingFlatInterp;
%     existsValue(isnan(existsValue)) = 0;
%     existsValue = logical(sum(existsValue));
%     noValue = 1; %max([1 numel(existsValue) - sum(existsValue)]);
%     nFalseAlarmsPDFPerRecordingFlatInterp(:,col) = ones(size(nFalseAlarmsPDFPerRecordingFlatInterp(:,col))).*(min(min(nFalseAlarmsPDFPerRecordingFlatInterp(nFalseAlarmsPDFPerRecordingFlatInterp ~= 0)))/noValue);
%   end
% end
dPrimeFlat = zeros(size(nHitsPDFPerRecordingFlatInterp));
for iCond = 1:size(dPrimeFlat,1)
    for iBin = 1:numel(centresInterp)
%         if nHitsPDFPerRecordingFlatInterp(iCond,iBin) == 0
%             nHitsPDFPerRecordingFlatInterp(iCond,iBin) = 1e-9;
%         end
%         if nFalseAlarmsPDFPerRecordingFlatInterp(iCond,iBin) == 0
%             nFalseAlarmsPDFPerRecordingFlatInterp(iCond,iBin) = 1e-9;
%         end
        if ~isnan(nHitsPDFPerRecordingFlatInterp(iCond,iBin)) && ~isnan(nFalseAlarmsPDFPerRecordingFlatInterp(iCond,iBin))
            dPrime = dprime_simple(nHitsPDFPerRecordingFlatInterp(iCond,iBin), nFalseAlarmsPDFPerRecordingFlatInterp(iCond,iBin));
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
        dPrimeFlat(iCond,iBin) = dPrime;
    end
end
[dPrimeFlatMeanInit, dPrimeFlatCI95Init] = datamean(dPrimeFlat);
dPrimeFlatCI95Reduced = dPrimeFlatCI95Init(:,~isnan(dPrimeFlatMeanInit));
reducedVecLength = round(size(dPrimeFlatCI95Reduced,2)/4);
if isnan(dPrimeFlatCI95Init(1,1))
  %dPrimeFlatCI95Init(:,1) = [0; 0];
  dPrimeFlatCI95Init(:,1) = [-max(max(datamean(abs(dPrimeFlatCI95Reduced(:,1:reducedVecLength))'))); max(max(datamean(abs(dPrimeFlatCI95Reduced(:,1:reducedVecLength))')))];
end
if isnan(dPrimeFlatCI95Init(1,end))
  %dPrimeFlatCI95Init(:,end) = [0; 0];
  dPrimeFlatCI95Init(:,end) = [-max(max(datamean(abs(dPrimeFlatCI95Reduced(:,end-reducedVecLength+1:end))'))); max(max(datamean(abs(dPrimeFlatCI95Reduced(:,end-reducedVecLength+1:end))')))];
end
dPrimeFlatMean = dPrimeFlatMeanInit(~isnan(dPrimeFlatMeanInit) & ~isnan(dPrimeFlatCI95Init(1,:)) & ~isnan(dPrimeFlatCI95Init(2,:)));
dPrimeFlatCI95 = dPrimeFlatCI95Init(:,~isnan(dPrimeFlatMeanInit) & ~isnan(dPrimeFlatCI95Init(1,:)) & ~isnan(dPrimeFlatCI95Init(2,:)));
centresInterp = centresInterp(~isnan(dPrimeFlatMeanInit) & ~isnan(dPrimeFlatCI95Init(1,:)) & ~isnan(dPrimeFlatCI95Init(2,:)));
end