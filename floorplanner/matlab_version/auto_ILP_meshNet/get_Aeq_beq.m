function [Aeq, beq]  = get_Aeq_beq(index_matrix, num_variables)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    Aeq = zeros(size(index_matrix,2)-2, num_variables);
    beq = ones(size(index_matrix,2)-2, 1);
    % order is taskID from 1 to N
    for idx_m_col = 3:size(index_matrix, 2)
        for idx_m_row = 2:size(index_matrix, 1) % grab the index for each task
            index_content = index_matrix(idx_m_row, idx_m_col);
            if index_content > 0
                Aeq(idx_m_col-2, index_content) = 1;
            end
        end
    end
      
end