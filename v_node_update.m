
function [var_msg, states] = v_node_update(daG_mat, input_msg)

% function v_node_update updates the variable nodes and the messages to be
% sent back to the control nodes
% inputs:
%         daG_mat: full adjacency matrix of the network
%         input_msg: nxn cell - input messages use in computation
%         nodes: self-degradation nodes

% output: updated factor node messages (var_msg)
%             states - next updated protein states

N = size(daG_mat,1);
states = [];

% Control/factor node message-passing updates
for i = 1:N
    % Edges from factor nodes
    idx = find(daG_mat(i, :) == 1);  % node ids
    msg_snd = [input_msg{i, i}];
    states = [states msg_snd];
    
end % end for loop

% next update msgs to control nodes
var_msg = initialization(daG_mat, states); % messages sent to factor node edges







