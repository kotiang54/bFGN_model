
% main file for attractor search in random networks

% Project: "Boolean factor graph model for Biological systems"
% by S. Kotiang and A. Eslami

clear
clc;

sample_nets = 10;  % number of sample random networks to test
data_K = [];
data_Edge = [];

for i = 1:sample_nets
    %
    idx = randsample([2:6], 10,'true') - 1; % randomly create the connectivity k for each node
       % see more help on Matlab documentatio help(randsample)
    [GRN, influence, genes] = randm_network(idx);   % create the GRN interaction matrix
    full_GRN = GRN;
    edge_cnt = nnz(GRN);   % count the number of edges in the network
    full_GRN(eye(size(GRN))==1) = 1; % full network matrix   
    id_nodes = 0; % identify self degrading nodes
    
    new_idx = sum(full_GRN,1);  % count the edges per control node
     
    k = 2;
    N = size(full_GRN, 1);
    states = fullfact(ones(1, N) + 1) - 1;    % Protein states
    numStates = size(states, 1);
    
    fixd_points = [];    % global attractor points
    tic;   % computation time for attractor search
    
    for i = 1:numStates
        
        init_state = states(i,: );   % initial proteins state
        tmp_fixd_pts = [];
        
        % initialize message-passing in FGN
        % var_msg: msgs from variable nodes to factor edges: Example, x12 = msg x1 --> f2
        
        original_states = init_state;
        var_msg = initialization(full_GRN, init_state);
        
        count = 0;
        test = false;
        while test == false % 
            tmp_msg = var_msg;
            previous_msg = original_states;
            
            % fact_msg: msgs from factor nodes to variable edges
            %           Example f12 = msg f2 --> x1
            
            fact_msg = f_node_update(full_GRN, influence, tmp_msg, id_nodes);  % , id_nodes; factor node updates
            [var_msg, updt_states] = v_node_update(full_GRN, fact_msg);   % , id_nodes; variable node updates
            
            test = isequal(previous_msg, updt_states); % convergence_test(full_GRN, influence, previous_msg, var_msg);  % convergence test
            original_states = updt_states;
            count = count + 1;
        end % end while loop
        
        tmp_fixd_pts = [tmp_fixd_pts; updt_states];
        
        fixd_points = [fixd_points; unique_counts(tmp_fixd_pts) ];
    end
    xt = toc;  % save elapsed computation time
    
    [global_attractors, C, D] = unique(fixd_points, 'rows');
    attractor_size = size(global_attractors,1);
    
    data_K = [data_K; [mean(new_idx) attractor_size xt]];  % compute connectivity and compute complexity
    data_Edge = [data_Edge; [edge_cnt attractor_size xt]];  % compute edge and compute complexity
    
  
end
% csvwrite('comp_complx_data.csv', data_K)   % initial data save
% csvwrite('nEdges_complx_data.csv', data_Edge)   % initial data save
% dlmwrite('comp_complx_data.csv', data_K, '-append')    % append subsequent data.
dlmwrite('nEdges_complx_data.csv', data_Edge, '-append')    % append subsequent data.

