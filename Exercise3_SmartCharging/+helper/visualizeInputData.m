function visualizeInputData(hourlyStep,demandProfile,priceBuy,priceSell,startStopTimes,scalingFactor,numEVs)
% VISUALIZEINPUTDATA Plots input data for the smart charging optimization
% problem.
        
    % Visualize demand and electricity prices
    f = figure; f.Position= [583 398 700 338];
    s = stackedplot(hourlyStep',[demandProfile' priceBuy priceSell],...
        DisplayLabels = ["Demand (kW)", "Buy Price (¢/kWh)", "Sell Price (¢/kWh)"],Title = "Input Data");
    s.LineWidth = 1.5; s.FontSize = 12; s.XLabel = "Time (hours)"; s.XLimits = [0 25];
    
    % Visualize EV connect and disconnect times
    f = figure; ax = axes(f); f.Position= [583 398 700 338];
    plot(ax,startStopTimes'/scalingFactor,[(1:numEVs); (1:numEVs)],LineWidth = 4), grid
    xlabel('Time (hours)'), ylabel('Vehicle Number'), axis([0 24 0 numEVs+1]), ax.FontSize=12;
    title('Plug-In Times for Each EV')
    
end