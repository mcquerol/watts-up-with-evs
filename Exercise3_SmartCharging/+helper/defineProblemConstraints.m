function prob = defineProblemConstraints(prob,no_steps,nEVs,ss,sc,initial_charge,final_charge,demandProfile,gridUpperLimit,sellingBack)
% DEFINEPROBLEMCONSTRAINS Defines constraints for the EV charging
% optimization problem. This includes:
%   - Battery charging/discharging limits
%   - Battery state of charge constraints
%   - Power grid electricity distribution limit
%   - Power grid balance constraint

    % EV battery power optimization variable
    evBatteryPower = optimvar("evBatteryPower",no_steps,nEVs,"LowerBound",0,"UpperBound",0);
    for u = 1:nEVs
        idx = ss(u,1):ss(u,2);
        evBatteryPower(idx,u).LowerBound = -35*sellingBack;
        evBatteryPower(idx,u).UpperBound = 35;
    end
    
    % Grid power optimization variables
    gridPowerBuy = optimvar("gridPowerBuy",no_steps,1,"LowerBound",0);
    gridPowerSell = optimvar("gridPowerSell",no_steps,1,"LowerBound",0);
    
    % Binary indicator variables, to be used for logical buying or selling constraint
    zBuy = optimvar("zBuy",no_steps,1,"Type","integer","LowerBound",0,"UpperBound",1);
    zSell = optimvar("zSell",no_steps,1,"Type","integer","LowerBound",0,"UpperBound",1);
    
    % Constraint expressions connecting indicator variables to grid power    
    buyCon = gridPowerBuy <= gridUpperLimit*zBuy;
    sellCon = gridPowerSell <= nEVs*zSell;
    
    % Constraint expression to either buy from or sell to grid    
    buyOrSell = zBuy + zSell <= 1;
    
    % Expressions for charge of EV units
    chargeInit = repmat(initial_charge,1,no_steps)';
    chargeFull = repmat(final_charge,1,no_steps)';
    
    charge = chargeInit + cumsum(evBatteryPower/sc,1);
    
    % Constraint expressions bounding charge of EV battery
    chargeLowerLimit = charge(:,:) >= chargeInit;
    chargeUpperLimit = charge(:,:) <= chargeFull;
    
    % Constraint expressions bounding rate of charge of EV battery power
    evBatteryPowerDiff = diff(evBatteryPower);
    diffPositive = evBatteryPowerDiff(:,:) >= -15*ones(no_steps-1,nEVs);
    diffNegative = evBatteryPowerDiff(:,:) <= 15*ones(no_steps-1,nEVs);
    
    % Constraint expression specifying final charge   
    chargeFinal = charge(end,:) == chargeFull(end,:);
    
    % Constraint expression to limit power consumption according to grid capacity   
    gridPowerLimit = gridPowerBuy - gridPowerSell <= gridUpperLimit;

    % Constraint expression for balancing total system power   
    powerBalance = sum(evBatteryPower,2) + demandProfile' == gridPowerBuy - gridPowerSell;

    % Add constraints to optimization problem
    prob.Constraints.chargeLowerLimit = chargeLowerLimit;
    prob.Constraints.chargeUpperLimit = chargeUpperLimit;
    prob.Constraints.chargeFinal = chargeFinal;
    prob.Constraints.gridPowerLimit = gridPowerLimit;
    prob.Constraints.powerBalance = powerBalance;
    prob.Constraints.buyOrSell = buyOrSell;
    prob.Constraints.buyCon = buyCon;
    prob.Constraints.sellCon = sellCon;
    prob.Constraints.diffPositive = diffPositive;
    prob.Constraints.diffNegative = diffNegative;

end