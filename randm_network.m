
function [GRN, influence, genes] = randm_network(idx)

% matlab function to create random gene network matrix.
% N is the size of the network
% Output: GRN - interaction matrix
%         genes - list of genes
%         exp_data - expression data used
% GRN matrix can be created with any other method known

% mean(idx)

genes = {'g1','g2','g3','g4','g5','g6','g7','g8','g9','g10'};  % List of genes

% Yeast cell-cycle network - original
len = size(idx,2);

GRN = zeros(len, len);

for i = 1:len   
    nodes = randsample(len, idx(i));   % sample without replacement    
    id = find(nodes == i);    
    if ~isempty(id)
        nodes([id]) = randi(len,1,numel(id));
    end
    
    GRN(nodes,i) = 1;
        
end

influence = zeros(size(GRN,1), size(GRN,2));

for i = 1:size(GRN,1)
   id_x = find(GRN(i,:) == 1);
   inf_num = randsample([-1,1],length(id_x),true);
   influence(i, [id_x]) = inf_num;
end
% 

% Network structure and Factor Graph
%  view(biograph(GRN, genes, 'LayoutType','hierarchical')); % radial, equilibrium, hierarchical

