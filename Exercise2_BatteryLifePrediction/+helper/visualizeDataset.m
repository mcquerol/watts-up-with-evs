function visualizeDataset(trainDataset)
    % Extract the summary field from the current struct
    summary = trainDataset(1).summary;

    % Create a temporary table from the desired fields with custom column names
    dataToDisplay = table(summary.cycle, summary.QDischarge, summary.IR, summary.chargetime, ...
                      'VariableNames', {'Cycle Number', 'Discharge Capacity', 'Internal Resistance', 'Charge Time'});

     % Limit the table to display only the first 5 rows
    dataToDisplay = dataToDisplay(1:min(5, height(dataToDisplay)), :);

    % Display the heading
    heading = '*** Example Data of Battery 1 ***';
    fprintf('\n\n%s\n\n', heading);


    % Display the limited data for the first battery
    disp(dataToDisplay);
end