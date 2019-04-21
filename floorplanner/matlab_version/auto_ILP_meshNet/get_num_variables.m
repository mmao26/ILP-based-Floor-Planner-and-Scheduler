function [num_variables, num_eqn_Ecommu] = get_num_variables(index_matrix, comm_vol)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    num_eqn_Ecommu = 4 * sum(sum(comm_vol>0));
    num_variables = index_matrix(end,end) + 2*sum(sum(comm_vol>0));
end