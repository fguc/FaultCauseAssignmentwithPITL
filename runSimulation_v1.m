function [DMDys,DMDr,data] = runSimulation_v1(simData,r)

simName = simData.simName;
wnd = simData.DMDWndw;
simInputs = simData.simInputs;

% Simulation parameters
K = 1;      %gain
T = 0.1;    %sec
L = 0.1;    %delay

TsSystem = 0.01;
RefSignal = r;

Ks = 0; 
Ka = 0; 
BL = 0; 

da = simInputs(2);
ds = simInputs(3);

% simOut{1} = sim(simName,'StopTime',num2str(RefSignal.Time(end)),'SrcWorkspace','current');
simOut{1} = sim(simName,'StopTime',num2str(20),'SrcWorkspace','current');

% Data Extraction
data.r{1} = simOut{1, 1}.logsout{1}.Values.signal1;
data.e{1} = simOut{1, 1}.logsout{1}.Values.signal2;
data.u{1} = simOut{1, 1}.logsout{1}.Values.signal3;
data.ua{1} = simOut{1, 1}.logsout{1}.Values.signal4;
data.y{1} = simOut{1, 1}.logsout{1}.Values.signal5;
data.ys{1} = simOut{1, 1}.logsout{1}.Values.signal6;
data.da{1} = simOut{1, 1}.logsout{1}.Values.signal7;
data.ds{1} = simOut{1, 1}.logsout{1}.Values.signal8;

% Data Prep
data.time = data.ys{1, 1}.Time;
dataDMDraw.ys = data.ys{1, 1}.Data;
dataDMDraw.r = data.r{1, 1}.Data;
dataDMD.ys = zeros(wnd,length(dataDMDraw.ys)-wnd);
dataDMD.r = zeros(wnd,length(dataDMDraw.r)-wnd);
for idx = 1:1:length(dataDMDraw.ys)-wnd
    dataDMD.ys(1:wnd,idx) = dataDMDraw.ys(idx:idx+wnd-1,1);
    dataDMD.r(1:wnd,idx) = dataDMDraw.r(idx:idx+wnd-1,1);
end

DMDys = dataDMD.ys;
DMDr = dataDMD.r;
end

