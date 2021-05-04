
% main file for the attractor search in Li's budding yeast model
% for network consistency to gene-expression data, uncomment lines 
%            dct_data = discretization(data, k) - 1; 
%            and  states = dct_data; 
% Then comment out line: 
%            states = allcombs(repmat({0:k-1}, 1, N)); 
% 
% Project: "Boolean factor graph model for Biological systems"
% by S. Kotiang and A. Eslami

clear all;
clc;
warning off
rng 'default'

% Example
%
% GRN = [0 1 0 0; 0 0 0 0; 0 1 0 0; 0 1 0 0];
% influence = [0 -1 0 0; 0 0 0 0; 0 1 0 0; 0 -1 0 0]; % activation =1;
% inhibition = -1

% Network structure and Factor Graph
filename = 'cellcycle_data.csv';   % gene-expression data from M3D
data = csvread(filename, 0,0);
[GRN, influence, genes] = gnetwork(); % create the GRN interaction matrix
full_GRN = GRN + eye(size(GRN)); % full network matrix for factor graph structure
id_nodes = [1 4 6 7 11]; % identify self-degrading nodes

k = 2;  % number of states, i.e., Boolean =2;
N = size(full_GRN, 1);
states = allcombs(repmat({0:k-1}, 1, N));   % Protein states

% dct_data = discretization(data, k) - 1;  % discretization of the expression data
% states = dct_data;
numStates = size(states, 1);
iterations = 1;
fixd_points = [];    % global attractor points

for i = 1:numStates
    
    init_state = states(i,: );   % initial proteins state
    tmp_fixd_pts = [];
    
    % Perform # of iterations per network protein state
    for p = 1:iterations
        % initialize message-passing in FGN
        % var_msg: msgs from variable nodes to factor edges: Example, x12 = msg x1 --> f2
        
        original_states = init_state;
        var_msg = initialization(full_GRN, init_state);        
        count = 0;
        test = false;
        while test == false % && count < 50
            tmp_msg = var_msg;
            previous_msg = original_states;
            
            % fact_msg: msgs from factor nodes to variable edges
            %           Example f12 = msg f2 --> x1
            
            fact_msg = f_node_update(full_GRN, influence, tmp_msg, id_nodes);  %  factor node updates
            [var_msg, updt_states] = v_node_update(full_GRN, fact_msg);   %  variable node updates
            
            test = isequal(previous_msg, updt_states); % convergence_test(full_GRN, influence, previous_msg, var_msg);  % convergence test
            original_states = updt_states;
            count = count + 1;
        end % end while loop
        
        tmp_fixd_pts = [tmp_fixd_pts; updt_states];
    end   % end iterations for loop
    
    fixd_points = [fixd_points; unique_counts(tmp_fixd_pts) ];
end

[global_attractors, C, D] = unique(fixd_points, 'rows');
basis_cnts = [];
attractor_membership = {};
for i = 1:length(C)
    tmp = find(D == i);
    basis_cnts = [basis_cnts length(tmp)];
    attractor_memberships{i} = states(tmp,:);
end

global_attractors  % print all global attractors
basis_cnts    % print the basin size of each attractor
 








































