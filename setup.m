fileName = 'Exercises';
[fid,errmsg] = fopen(fileName, 'w');
if ~isempty(errmsg)&&strcmp(errmsg,'Permission denied') 
    fprintf('\nError: You do not have write permission in the folder containing (%s).\n',fileName);
    fprintf('\nPlease make a copy of the original workshop folder and navigate to it.\n');
    fprintf('You will run the exercises out of the folder copy you created.\n');
else
    fprintf("Welcome to Watt's Up with EVs, getting things set up for you...")
    fprintf('\nYou have write permission in this folder.\n');
    fprintf('\nInitializing the exercises...\n');
    %% Exercise 1 setup
    % Store the current working directory
    try
        originalDir = pwd;
        
        cd(fullfile("Exercise1_UnderTheEVHood"))
        projectPath = fullfile("EV","EV.prj");
        % Load the Simulink project
        matlab.project.loadProject(projectPath);
        
        filepath = fullfile("System","EvReferenceApplication.slx");
        load_system(filepath)
        
        myModel = "EvReferenceApplication";
        fprintf("Getting your EV ready for you...\n")
        set_param(myModel, 'SimulationCommand', 'update');
    catch
        fprintf('\n An error occured trying to set up exercise 1. Please reach out to a TA.')
        % Restore the original working directory
        cd(originalDir);
        addpath(genpath(pwd));
    end    
    
    %% Adding all exercises to path
    % Restore the original working directory
    cd(originalDir);
    addpath(genpath(pwd));
    
    fprintf("Set up complete, enjoy your workshop!\n")
end
