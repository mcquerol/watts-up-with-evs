function plotLifeCycleComparison(yActual, yPred, cellIndex)
    % Create a bar chart to visualize the actual vs predicted lifecycle
    figure;
    bar([yActual, yPred]);
    set(gca, 'XTickLabel', {'Actual', 'Predicted'});
    ylabel('Cycle Life');
    title(['Actual vs Predicted Cycle Life for Battery ', num2str(cellIndex)]);
    ylim([0, max(yActual, yPred) * 1.2]); % Adjust y-axis limit for better visualization
    grid on;
end