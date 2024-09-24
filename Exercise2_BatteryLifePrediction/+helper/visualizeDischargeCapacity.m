function visualizeDischargeCapacity(numBattery,trainDataset)
    % Create a new figure and hold on to allow multiple plots
    figure;
    hold on;

    % Determine the number of datasets to plot
    numDatasets = min(numBattery, size(trainDataset, 2));

    % Loop over each dataset and plot if conditions are met
    for i = 1:numDatasets
        if numel(trainDataset(i).summary.cycle) == numel(unique(trainDataset(i).summary.cycle))
            plot(trainDataset(i).summary.cycle, trainDataset(i).summary.QDischarge,'LineWidth', 2);
        end
    end

    % Set the limits of the y-axis and x-axis
    ylim([0.85, 1.1]);
    xlim([0, 1000]);

     % Label the axes
    ylabel('Discharge capacity (Ah) of Battery');
    xlabel('Cycle');
    

    % Add a title for clarity
    title('Battery Discharge Capacity Over Cycles');
end