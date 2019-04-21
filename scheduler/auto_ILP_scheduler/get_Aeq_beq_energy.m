function [new_Aeq, new_beq]  = get_Aeq_beq_energy(Aeq, beq, num_variables, index_matrix, power_information)
    new_beq = [beq; 0]; % add one more row
    new_Aeq = [Aeq; zeros(1, num_variables)];  % initailize
    % execution energy

    for i = 1 : size(index_matrix, 2)
        taskID = index_matrix(1, i);
        resourceID = index_matrix(3, i);
        cycle = index_matrix(2, i);
        
        [row_idx, temp] = find(power_information(:,end-1) == resourceID);
        execution_power = power_information(row_idx(1), taskID);
        if execution_power > 999
            disp('Error on Execution Power');
            execution_power = 0;
        end
        for j = 5 : size(index_matrix, 1)
            index_content = index_matrix(j, i);
            if index_content > 0
                new_Aeq(end, index_content) = execution_power * cycle;
            end
        end
    end
    col_idx = max(index_matrix(:,end)) + 2;
    new_Aeq(end, col_idx) = -1;
end