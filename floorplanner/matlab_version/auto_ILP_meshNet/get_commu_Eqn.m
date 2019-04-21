function commu_Eqn = get_commu_Eqn(index_matrix, large_idx, small_idx, vol, E_bit, x_or_y, num_variables)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    commu_Eqn = zeros(1,num_variables);
    % x_or_y: 1 for x, 2 for y
    for i = 2:size(index_matrix,1)
        index_content_large = index_matrix(i,large_idx);
        if index_content_large > 0
            commu_Eqn(1, index_content_large) = vol*E_bit*index_matrix(i,x_or_y);
        end
        index_content_small = index_matrix(i,small_idx);
        if index_content_small > 0
            commu_Eqn(1, index_content_small) = -vol*E_bit*index_matrix(i,x_or_y);
        end            
    end
end