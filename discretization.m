
function dct_data  = discretization(data, k)

% function takes in continuous expression data and output discrete data
% Output: dct_data - discretized data
%         class_proportions - distribution of the discretized data per gene
%         node
%         gmfit - learned GMM function


options = statset('MaxIter',1000); % max of 1,000 iterations allowed
% gmfit = {};

[data_len, N] = size(data);
dct_data = zeros(data_len, N); % N denotes the number of nodes

for i = 1: N
    rng('default')
    
    % Gaussian Mixture Model
    % centroid initialization using k-means++ algorithm
    % For each dataset we repeat the experiment 10 times
    gmfit = fitgmdist(data(:,i),k, 'start', 'plus', 'Options', options, 'Replicates',10);
    
    if gmfit.mu(1) > gmfit.mu(2)
        mu = gmfit.mu([2 1]);
        componentProportion = gmfit.ComponentProportion([2 1]);
        sigma = gmfit.Sigma([2 1]);
        gm = gmdistribution(mu, sigma, componentProportion);
        dct_data(:, i) = cluster(gm, data(:, i));
        
    else
        dct_data(:, i) = cluster(gmfit, data(:, i));
    end
    
end
