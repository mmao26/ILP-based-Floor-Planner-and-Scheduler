function [Aeq, beq]  = get_Aeq_beq(index_matrix, task_info, num_variables)
    %% Author: Manqing Mao; mmao7@asu.edu
    Aeq = zeros(size(task_info,2), num_variables);
    beq = ones(size(task_info,2), 1);
    % order is taskID from 1 to N
    for idx_m_col = 1:size(index_matrix, 2)
        idx_row = index_matrix(1, idx_m_col);  % taskID --> index_row in Aeq
        for idx_m_row = 5:size(index_matrix, 1) % grab the index for each task
            index_content = index_matrix(idx_m_row, idx_m_col);
            if index_content > 0
                Aeq(idx_row, index_content) = 1;
            end
        end
    end
end