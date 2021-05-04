
clear all
clc;
% warning off

filename = 'nEdges_complx_data.csv'; % data obtained from the matlab file computation_cost.m
data = csvread(filename, 0,0);

data = sortrows(data, 1); % sort wrt rho values
data = data(find(data(:,2) < 300), : );
data = data(find(data(:,1) < 80), : );

% [N,M] = size(data);

idx = unique(floor(data(:,1)));
comptime = [];
med = [];

for i = 1: numel(idx) 
    att_idx = find(floor(data(:,1)) == idx(i));
    comptime = [comptime numel(att_idx)];
    med = [med mean(data(att_idx,3))];     
end

plot(idx, med, 'bo');
xlabel('No. of Edges')
ylabel('time (seconds)')

























