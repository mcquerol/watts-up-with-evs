function visualizeResults(isFeasible, resultType, evBatteryPower, varargin)
% VISUALIZERESULTS Provides visualizations for the smart charging results 
% if a feasible solution was found 

    if ~isFeasible
        disp("EV charging scenario is not feasible. Modify your scenario to find a feasible problem to solve and visualize.")
        return;
    end

    % Visualize results if feasible solution was found
    switch resultType
        case "EV"
            selectedEV = varargin{1};
            ss = varargin{2};
            sc = varargin{3};
            initial_charge = varargin{4};

            % Charging profile for selected EV
            if selectedEV <= 0
               warndlg(['Please select a valid EV number, ranging from 1 to ', num2str(size(evBatteryPower,2)), '.'],'Warning');
               return; 
            end
        
            % Calculate cumulative power stored
            qq = cumsum(evBatteryPower(:,selectedEV)/sc) + initial_charge(selectedEV);
            
            % Plot results
            f = figure; ax = axes(f);
            f.Position= [583 398 780 338];
            stairs((ss(selectedEV,1)-1:ss(selectedEV,2))/sc,qq(ss(selectedEV,1)-1:ss(selectedEV,2)),'g', 'LineWidth',2), grid
            hold on
            plot([0 24],[1 1]*80,'r--',[0 24],[1 1]*18,'r--','LineWidth',2);
            plot([0 ss(selectedEV,1)/sc],[1 1]*qq(1),'k--',[ss(selectedEV,2)/sc 24],[1 1]*qq(end),'k--','LineWidth',2);
            hold off
            xlabel(ax,'Time (hours)'), xticks(1:24)
            ylabel(ax,'State of Charge (kWh)'), axis([1 24 0 87])
            title(ax,['Charging Profile for EV ',num2str(selectedEV)]);
            ax.FontSize = 12;
        
        case "System"
            smartProfile = evBatteryPower;
            
            hourlyStep = varargin{1};
            demandProfile = varargin{2};
            constantProfile = varargin{3};
            numEVs = varargin{4};

            % Compare charging patterns
            f = figure; ax = axes(f);
            f.Position= [583 398 900 338];
            h = plot(ax,hourlyStep,demandProfile,...
                     hourlyStep,sum(constantProfile,2)+demandProfile',...
                     hourlyStep,sum(smartProfile,2)+demandProfile');
            
            h(1).Color = 'k'; h(2).Color = [245, 139, 10]/255; h(3).Color = [114, 181, 5]/255; 
            h(1).LineWidth = 1.5; h(2).LineWidth = 1.5; h(3).LineWidth = 1.5; ax.FontSize = 12;
            xlabel('Time (hours)'),ylabel('Power (kW)'), grid on
            title(['Demand Profile With ' num2str(numEVs),' EVs'])
            legend('Base Demand','Constant Charging','Smart Charging','Location','northeastoutside')
    end
end