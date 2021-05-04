
% Matlab code to quantify how well gene data fits with different mixtures
% of Gaussian model
%
% Project: "Boolean factor graph model for Biological systems"
% by S. Kotiang and A. Eslami

clear
clc;

filename = 'cellcycle_data.csv'; % gene-expression data from M3D
data = csvread(filename, 0,0);

options = statset('MaxIter',1000); % max of 1,000 iterations allowed
gmfit_data = {};
k = 1:5;
[data_len, N] = size(data); % N denotes the number of nodes
dct_data = zeros(data_len, N);
BIC_score = zeros(N,length(k));

for i = 1: N
    rng('default')
    
    for j=1:5
        
        % Gaussian Mixture Model
        % centroid initialization using k-means++ algorithm
        % For each dataset we repeat the experiment 10 times
        gmfit = fitgmdist(data(:,i),k(j), 'start','plus', 'Options', options, 'Replicates',10);
        BIC_score(i,j) = gmfit.BIC;
        gmfit_data{i,j} = gmfit;
        
    end
    
end
BIC_score


