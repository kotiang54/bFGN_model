
function fact_msg = f_node_update(daG_mat, influence, input_msg, nodes)

% Matlab function to implement message passing and computation at the
% control node.
% inputs:
%         daG_mat: full adjacency matrix of the network
%         influence: activation (+1) or inhibition (-1) property
%         input_msg: nxn cell - input messages use in computation

% output: updated factor node messages (fact_msg)

N = size(daG_mat,1);
fact_msg = cell(N,N);

% Factor/Control node message passing updates
for i = 1:N
    % Edges from factor nodes
    idx = find(daG_mat(:,i) == 1);  % node ids
    %     msg_snd = [];
    
    if length(idx) == 1
        % leaf factor node messages
        if any(nodes == idx) == true && input_msg{idx,i} == 1
            msg_snd = 0;
        else
            msg_snd = input_msg{idx,i};
        end
        fact_msg{idx,i} = msg_snd; % it sends back the message it received
    else
        for j = 1:length(idx)
            if idx(j) == i
                % msg to gene i from factor node i
                tmp_msg = {};  % collect all messages to this node from its parents
                new_idx = idx(idx ~= i);
                
                for p = 1:length(new_idx)
                    %   msg = influence(new_idx(p), i)*input_msg{new_idx(p), i};
                    %     tmp_msg = tmp_msg + msg;
                    upd_msg = logic_function(influence(new_idx(p),i), input_msg{new_idx(p),i}, input_msg{i,i});
                    tmp_msg = [tmp_msg upd_msg];
                end
                if any(nodes == i) == true
                    % self-degradation (TODO: previous states)
                    if (isempty(tmp_msg) && input_msg{i,i} == 1) || (isempty(tmp_msg) && input_msg{i,i} == 0)
                        msg_snd = 0;
                    else
                        msg_snd = degradation(input_msg{i,i}, cell2mat(tmp_msg));
                    end
                else
                    if isempty(tmp_msg)
                        msg_snd = input_msg{i,i};
                    else
                        msg_snd = message_pass_calc(tmp_msg, input_msg{i,i});  % compute message to gene i from factor node i
                    end
                end
                fact_msg{i,i} = msg_snd; % send message to gene i
                
            end % end if statement
        end % end for loop
    end  % end if length(idx) == 1
    
end % end for loop i = 1:N

