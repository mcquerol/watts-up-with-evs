function plotPerformanceEvaluation(yTest, yPredTest)
    % plotPredictedVsActual - Plots a scatter plot of predicted vs actual cycle life.
    %
    % Syntax: plotPredictedVsActual(yTest, yPredTest)
    %
    % Inputs:
    %   yTest - Vector of actual cycle life values
    %   yPredTest - Vector of predicted cycle life values
    %
    % Example: 
    %   plotPredictedVsActual(yTest, yPredTest)

    % Create a new figure
    figure;
    
    % Create a scatter plot of actual vs predicted values
    scatter(yTest, yPredTest,'filled');
    hold on;
    
    % Add a reference line with a slope of 1 and intercept of 0
    refline(1, 0);
    
    % Add title and labels
    title('Predicted vs Actual Cycle Life');
    xlabel('Actual cycle life');
    ylabel('Predicted cycle life');
    
end