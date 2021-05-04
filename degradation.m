
function state = degradation(previous_state, msg_input)

% a function to self-degradate nodes
% inputs:
%         msg_input: input messages to the node
%         previous_state: protein previous state at time t

% output: state - next state on degradation

x = sort(msg_input);
y = unique(x);
len = [];

for i = 1:length(y)
    len = [len length(find(x == y(i)))];  % number of 0's and 1's
end
a = max(len);    % find index of the maximum occurance in y

% test multiple max values
idx_max = find(len == a);

if length(idx_max) > 1 % more than one maximum unique values
    % number of 0's equals number of 1's
    if previous_state == 1
        state = 0;
    else
        state = previous_state;
    end
else
    state = y(idx_max);
end

end


    


