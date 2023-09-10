clear
clc
close all

N_Rand_Sign = 1;

% Generate folder
parentFolder = pwd;
childFolder = [datestr(now, 'yyyy-mm-dd-HH-MM-SS') '_References_Rand' num2str(N_Rand_Sign)];
root = fullfile(parentFolder,childFolder);
mkdir(root)
cd(root)

% Generate random signals
nSplit = randi([6],N_Rand_Sign,1);

for i = 1:1:N_Rand_Sign
    nSplitLength{i} = [1;randi([4 6],nSplit(i),1);1]*30;
    nSplitAmp{i} = [0;randi([1 5],nSplit(i),1);0];
    
    refTime{i} = (0:0.01:sum(nSplitLength{i}-0.01)/100)';
    refSet{i} = [];
    for j = 1:1:length(nSplitLength{i})
        ref = nSplitAmp{i}(j)*ones(nSplitLength{i}(j),1);
        refSet{i} = [refSet{i};ref];
    end
    refSet_ts{i} = timeseries(refSet{i},refTime{i});
    figure
    plot(refSet_ts{1, i},'LineWidth',2)
    xlabel('time [s]')
    ylabel('reference')
    title('Reference Signal')
%     ylim([0 4.2])
    grid on
    saveas(gcf,['RandRef' num2str(i) '.png'])
end

save refSet_ts