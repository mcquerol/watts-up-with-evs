function displayFeatures(XTrain)

    % Define the original feature names and their corresponding understandable names
    originalFeatureNames = {'DeltaQ_min', 'Qd2', 'AvgChargeTime', 'MinIR'};
    understandableNames = {'Discharge Voltage Difference', 'Initial Discharge Capacity', 'Average Charge Time', ...
         'Minimum Internal Resistance'};

    
    % Extract the selected features using the original order
    XSelected = XTrain(:, originalFeatureNames);

    % Rename the features using the understandable names in the specified order
    XSelected.Properties.VariableNames = understandableNames;

    % Display the first few rows of the renamed features
    disp(head(XSelected));
end