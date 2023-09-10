clear
clc
close all

% Reference inputs
parentFolder = pwd;
childFolder = '2021-04-02-20-45-30_References_Rand1';
caseFolder = 'Bias3Scenario';
root = fullfile(parentFolder,childFolder);
load([root '/refSet_ts.mat']);

% Scenario inputs
simDef = {'Nominal'...
    'ActuatorBias'...
    'SensorBias'};

simInputs = diag([0 0.2 0.2]);

A = 1:1:length(simDef);
B = repmat(A,1,500);

sim{length(B)} = {};
i = length(refSet_ts); j = length(B);
MatPhi{i} = [];
MatLabels{i}  = [];

tic
for numRef = 1:1:length(refSet_ts)
    % Determine reference signal
    simRefCurrent = refSet_ts{numRef};
    refFolder = ['Scenario_' num2str(numRef)];
    
    rootFinal = fullfile(parentFolder,childFolder,caseFolder,refFolder);
    mkdir(rootFinal)
    
    idx = 1;
    % Run Simulation
    for numSim = B
        disp(['Iteration for Ref:' num2str(numRef) '/' num2str(length(refSet_ts)) ' and Sim:' num2str(idx) '/' num2str(length(B))])
        simData.simName = 'model_FOPTD_DMD_3Scenario_v1.slx';
        simData.thresh = 5;
        simData.rtil = 11;
        simData.r = 11;
%         simData.DMDWndw = floor(length(simRefCurrent.Time)*0.97);
        simData.DMDWndw = 1900;
        
        simData.simDef = simDef{numSim};
        simData.simInputs = simInputs(numSim,:);
        [simData.dataDMD.ys,simData.dataDMD.r,simData.dataDMD.raw] = runSimulation_v1(simData,simRefCurrent);
        
        % DMDc
        [simData.resultsDMDc] = runAlgorithmDMDc_v1(simData);
        if idx ==1
            plotSingVal_v1(simData);
            
        end
%         plotDMDModes_v1(simData);
        sim{numRef,idx} = simData;
        idx = idx+1;
    end
    
    [MatPhi{numRef},MatLabels{numRef}] = processDMDModes_v1(sim,numRef,simData.r);
    toc
end

DMDDataDL.Data = MatPhi;
DMDDataDL.Labels = MatLabels;

saveRoot = fullfile(parentFolder,childFolder,caseFolder);
cd(saveRoot)

save DMDDataDL DMDDataDL