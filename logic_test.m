function msg = logic_test(sum_input, previous_msg)

% inputs: influence: activate (+1) or inhibit (-1) property
%         logic_value: logical value 0 or 1

% output: msg 

if sum_input > 0 
    msg = 1;
elseif sum_input < 0
    msg = 0;
else
    msg = previous_msg;
end


