openProject("EV.prj")

%%
myModel = "EvReferenceApplication";
load_system("System/EvReferenceApplication.slx")

set_param(myModel, 'SimulationCommand', 'update');