
% File for figure 4 in the main paper for reproduction
% Project: "Boolean factor graph model for Biological systems"
% by S. Kotiang and A. Eslami

clear all
clc;

filename = 'attractor_data.csv';
data = csvread(filename, 0,0);

data = sortrows(data, 1); % sort wrt rho values
data = data(find(data(:,2) < 300), : ); % exclude data outliers

% [N,M] = size(data);

idx = unique(floor(data(:,1)));
att_sz = [];

for i = 1: numel(idx) 
    att_idx = find(floor(data(:,1)) == idx(i));
    att_sz = [att_sz numel(att_idx)];
     
end

g = repelem({'1','2','3','4','5','6','7','8'}, [att_sz]);
pos = 0:2:14;

figure(1)

h1 = boxplot(data(:,2), g, 'positions', pos, 'width',0.7);
hlines = findobj(h1,'type','line','Tag','Median');
set(hlines,'Marker','.');
set(h1, 'linewidth',1)
xlabel('Avg. connectivity, \rho_j')
ylabel('Number of attractors')























