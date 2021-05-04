
function msg_out = message_pass_calc(input_msg,  previous_state)

% inputs: input_msg: temporary message vector to the node
%         previous_state: previous state of the gene

% output: msg_out: new message passed to the node

p = length(input_msg);
states = [0 1];
q_len = [];

for i = 1:length(states)
    idx = [];
    for j = 1:p
        idx = [idx find(input_msg{j} == states(i))];
    end
    q_len = [q_len length(idx)];
end

if q_len(1) == q_len(2)
    msg_out =  previous_state;
    
elseif q_len(1) > q_len(2)  % 
    msg_out = 0;
else   %
    msg_out = 1;
end




