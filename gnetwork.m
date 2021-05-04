
function [GRN, influence, genes] = gnetwork()

% matlab function to create the gene network matrix.
% N is the size of the network
% Output: GRN - interaction matrix
%         genes - list of genes        
% GRN matrix can be created with any other method known
% Example network: Li's budding yeast model

genes = {'Cln3','MBF','SBF','Cln1,2','Cdh1','Swi5','Cdc20,14', ...
         'Clb5,6','Sic1','Clb1,2','Mcm1'};  % List of genes

% Yeast cell-cycle network - original
s = [1  1  2  3  4  4   5  6  7  7  7  7  7  8 8  8   8  9  9  10 10 10 10 10 10 10 11 11 11];
t = [2  3  8  4  5  9  10 9  5  6  8  9 10 5 9 10 11 8 10  2   3    5   6   7   9  11  6   7  10];

% influence type: + activation. - inhibition
weights = [1 1 1 1 -1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 1 -1 1 1 1 1]; 

G = digraph(s,t,weights);
GRN = full(adjacency(G));
% influence = full(adjacency(G, 'weighted'));

N = size(GRN,1);
influence = zeros(N,N);

for i = 1:length(G.Edges.Weight)
    influence(G.Edges.EndNodes(i,1), G.Edges.EndNodes(i,2)) = G.Edges.Weight(i);    
end

% Network structure and Factor Graph
% view(biograph(GRN, genes, 'LayoutType','hierarchical')); % radial, equilibrium, hierarchical
% or
% G = digraph(GRN,genes);
% plot(G,'NodeLabel',genes);

