function [wModel, beta] = trainClassifier(XTrain, yTrain)
    % Set random number generator for reproducibility
    rng("default");
    
    % Define hyperparameters
    alphaVec = 0.01:0.1:1;
    lambdaVec = 0:0.01:1;
    MCReps = 1;
    cvFold = 4;
    
    % Initialize storage
    rmseList = zeros(length(alphaVec), 1);
    minLambdaMSE = zeros(length(alphaVec), 1);
    wModelList = cell(1, length(alphaVec));
    betaVec = cell(1, length(alphaVec));
    
    % Train models for each alpha
    for i = 1:length(alphaVec)
        [coefficients, fitInfo] = ...
            lasso(XTrain.Variables, yTrain, 'Alpha', alphaVec(i), ...
            'CV', cvFold, 'MCReps', MCReps, 'Lambda', lambdaVec);
        
        % Store model with minimum RMSE for current alpha
        wModelList{i} = coefficients(:, fitInfo.IndexMinMSE);
        betaVec{i} = fitInfo.Intercept(fitInfo.IndexMinMSE);
        rmseList(i) = sqrt(fitInfo.MSE(fitInfo.IndexMinMSE));
        minLambdaMSE(i) = fitInfo.LambdaMinMSE;
    end
    
    % Select models with the lowest RMSE values
    numVal = 4;
    [~, idx] = sort(rmseList);
    selectedIdx = idx(1:numVal);
    
    % Extract selected models and parameters
    alpha = alphaVec(selectedIdx);
    lambda = minLambdaMSE(selectedIdx);
    wModel = wModelList(selectedIdx);
    beta = betaVec(selectedIdx);
end