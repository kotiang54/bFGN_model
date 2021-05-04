
% main file for the gene deletion analysis in Li's budding yeast model
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
% influence = [0 -1 0 0; 0 0 0 0; 0 1 0 0; 0 -1 0 0];

% Network structure and Factor Graph
[GRN, influence, genes] = gnetwork(); % create the GRN interaction matrix
full_GRN = GRN + eye(size(GRN)); % full network matrix
id_nodes = [1 4 6 7 11]; % identify self-degrading nodes

% Node IDs 1=Cln3, 2=MBF, 3=SBF, 4=Cln1,2, 5=Cdh1, 6=Swi5, 7=Cdc20, 
% 8=Clb5, 9=Sic1, 10=Clb2, 11=Mcm1
prompt = 'Select a node for deletion from 1 to 11:  -> ';
KO_node =  sscanf(input(prompt, 's'), '%d');
fprintf('\n');

k = 2;
N = size(full_GRN, 1);
iterations = 1;
fixd_points = [];    % global attractor points

for i = 1:1 % numStates
  
    init_state = [1 0 0 0 1 0 0 0 1 0 0];
    if any(KO_node) 
        init_state(KO_node) = 0;
    end
    
    tmp_fixd_pts = [];
    recovery = 0;
    % Perform # of iterations per network protein state
    for p = 1:iterations
        % initialize message-passing in FGN
        % var_msg: msgs from variable nodes to factor edges: Example, x12 = msg x1 --> f2
        state_Evolution = init_state;
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
            [var_msg, updt_states] = v_nodeKO_update(full_GRN, fact_msg, KO_node);   %  variable node updates
            
            test = isequal(previous_msg, updt_states); % convergence_test(full_GRN, influence, previous_msg, var_msg);  % convergence test            
            count = count + 1;
            state_Evolution = [state_Evolution; updt_states];  % evolution of protein states           
            original_states = updt_states;    
                
        end % end while loop
        
        tmp_fixd_pts = [tmp_fixd_pts; updt_states];
    end   % end iterations for loop
    
    fixd_points = [fixd_points; unique_counts(tmp_fixd_pts) ];
end

[global_attractors, C, D] = unique(fixd_points, 'rows');
basis_cnts = [];

for i = 1:length(C)
    basis_cnts = [basis_cnts length(find(D == i))];
end

arrest_state = global_attractors
basis_cnts;
state_Evolution(1:end-1, :)




