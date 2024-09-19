function [wModelFinal, betaFinal] = selectBestModel(XVal, yVal, wModel, beta)
    % Initialize RMSE storage for validation data
    numVal = length(wModel);
    rmseValModel = zeros(numVal, 1);
    
    % Compute RMSE for each model on validation data
    for valList = 1:numVal
        yPredVal = (XVal.Variables * wModel{valList} + beta{valList});
        rmseValModel(valList) = sqrt(mean((yPredVal - yVal).^2));
    end
    
    % Select model with the lowest RMSE on validation data
    [rmseMinVal, bestIdx] = min(rmseValModel);
    wModelFinal = wModel{bestIdx};
    betaFinal = beta{bestIdx};
end