
function upd_msg_ch = logic_function(influence, msg_pr, msg_ch)

% Function to compute message for factor/control node i to variable node i
% inputs: influence: activate (+1) or inhibit (-1) property
%         msg_pr: parent input message
%         msg_ch: child (target gene) input message

% msg_out: output logic message
% upd_msg_ch: updated child gene state
% y = [0 1];

switch influence
    
    % TODO: What logic test definition (Eliminate  0 0 elements)
    
    case 1 % activation (a or b)
        upd_msg_ch = double(msg_pr | msg_ch);
        
    case -1 % inhibition (xor(a,b)&b)
        
        upd_msg_ch = double(xor(msg_pr, msg_ch) & msg_ch);        
end

if msg_pr == 0    % inactive parent genes contribute no information
    upd_msg_ch = [];
end
end










