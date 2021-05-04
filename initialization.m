
function  msg = initialization(network, states)
% Matlab funtion to initialize all nodes in the facto graph.
% input:
%           network - topology of the system
%           states - possible protein states
% output: msg - message output to factor node 

N = length(states);
msg = cell(N,N);

for j = 1:N
    idx_init = find(network(j,:) == 1);
    for k = 1:length(idx_init)
        msg{j, idx_init(k)} = states(j);
    end
end

end