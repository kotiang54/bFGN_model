
function [var_msg, states] = v_nodeKO_update(daG_mat, input_msg, del_node)

% function v_nodeKO_update updates the variable nodes and the messages to be
% sent back to the facto nodes
% inputs:
%         daG_mat: full adjacency matrix of the network
%         input_msg: nxn cell - input messages use in computation
%         del_nodes: deleted nodes

% output: updated factor node messages (var_msg)
%             states - next updated protein states

N = size(daG_mat,1);
states = [];

% Factor node message-passing updates
for i = 1:N    % PICK ELEMENTS OF DIAGONAL
    % Edges from factor nodes
    idx = find(daG_mat(i, :) == 1);  % node ids
    msg_snd = [input_msg{i, i}];
    states = [states msg_snd];

end % end for loop

if any(del_node)
    states(del_node) = 0;
end

% next update msgs to factor nodes
var_msg = initialization(daG_mat, states); % messages sent to factor node edges

end


    


