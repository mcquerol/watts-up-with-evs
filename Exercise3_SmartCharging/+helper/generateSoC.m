function [initial_charge, final_charge] = generateSoC(nEVs,final_SoC)
% GENERATESOC Generates vectors containing the (random) initial state of
% and (desired) final state of charge for each EV.
    
    rng default % Set random seed for reproducibility
    
    % Assumptions on state of charge
    lower_SoC_constraint = 20; % minimum allowable SoC (kWh)
    max_initial_SoC = 40; % maximum SoC at plug-in time (kWh)
    full_SoC = 80; % full capacity (kWh)
    
    % Generate vectors for initial and final charge of each EV
    initial_charge = randi([lower_SoC_constraint,max_initial_SoC],nEVs,1); % randomize the initial charge from lower constraint to max_initial SoC
    final_charge = (final_SoC/100)*full_SoC*ones(nEVs,1); % all units must end on final_SoC
end