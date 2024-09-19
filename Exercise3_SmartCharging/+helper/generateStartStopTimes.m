function [ss, isPluggedIn] = generateStartStopTimes(sc, nSteps, nEVs)
% GENERATESTARTSTOPTIMES Generates random times for EV connection and
% disconnection based on number of EVs and minimum wait time selected.

    rng default % Set random seed for reproducibility
    
    % Create a large number of random start-stop times to choose from
    no_sunits = 2000; 
    ss = sort([randi(23,no_sunits,1) randi(23,no_sunits,1)],2)*sc;
    
    % Identify and remove charging times less than 2 hours
    idx = (ss(:,2)-ss(:,1))/sc < 2; 
    ss = ss(~idx,:);
    
    % Select the appropriate number os scenarios
    ss = ss(1:nEVs,:); 

    % Create a logical index matrix to indicate when EVs are plugged in
    isPluggedIn = false(nSteps,nEVs);
    for k = 1:nEVs
        isPluggedIn(ss(k, 1):ss(k, 2),k) = true;
    end
end