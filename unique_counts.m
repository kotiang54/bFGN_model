
function out_states = unique_counts(msg)
% inputs: - msg: the input messages to be counted
% output: - out_logic

    [a, b, c] = unique(msg, 'rows');
    idx = [];
    for i = 1:length(b)
        idx = [idx length(find(c == i))];
    end

    val = max(idx);  % find the maximum value in idx

    % test multiple max values
    idx_max = find(idx == val); % find index of the maximum occurance in y
    if length(idx_max) > 1 % more than one maximum unique values
        a_sample = randsample(idx_max,1);
        out_states = a(a_sample, :);  % majority voting
    else
        out_states = a(idx_max, :);
    
    end  % end if-else statement




