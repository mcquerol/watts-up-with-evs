function isFeasible = verifyResults(evBatteryPower)
% VERIFYRESULTS Verifies if optimization problem returned non-empty
% solution
    
    isFeasible = 1;
    
    % Solution will be empty if problem is infeasible
    if isempty(evBatteryPower)
       isFeasible = 0; 
       warndlg({'This EV charging scenario is not feasible.', '',...
                'Here are some adjustments you can try:', ...
                '1) Decrease number of EVs', ...
                '2) Decrease desired final state of charge', ...
                '3) Increase grid capacity', '', ...
                'Good luck!'},'Warning');
    end
end