function commu_vector = get_commu_vector(prevTaskID, taskID, task_info_dep, absent_resourceIDList, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm)
    % Initialize
    commu_vector = zeros(1, num_variables);
    flag_absent_cpu = 0;
    flag_absent_acc = 0;
    flag_absent_other = 0;
    for i = 1:numel(absent_resourceIDList)
        absent_resourceID = absent_resourceIDList(1,i);
        if absent_resourceID >= 10 && absent_resourceID < 100
            flag_absent_cpu = 1;
        elseif absent_resourceID >= 100 && absent_resourceID < 200
            flag_absent_acc = 1;
        elseif absent_resourceID >= 200
            flag_absent_other = 1;
        else
            disp('ERROR..resource not support...');
        end
    end
    
    [a, col_idx] = find(index_matrix(1,:) == taskID);
    for loc_col_idx = 1: numel(col_idx)
        idx_m_col = col_idx(1, loc_col_idx);
        resourceID = index_matrix(3, idx_m_col);
        % -C(..taskID..)
        if (flag_absent_cpu && resourceID >= 10 && resourceID < 100) || (flag_absent_acc && resourceID >= 100 && resourceID < 200) || (flag_absent_other && resourceID >= 200)
            
            for idx_m_row = 5:size(index_matrix, 1) 
                index_content = index_matrix(idx_m_row, idx_m_col);
                if index_content > 0
                    commu_vector(1, index_content) = -bigConstant;
                end
            end
            
        end
    end
    

    [row_idx_comm, b0] = find(task_info_dep(2:end,taskID) == prevTaskID);
    sameCost = sameTask_comm(row_idx_comm(1)+1, taskID);
    diffCost = diffTask_comm(row_idx_comm(1)+1, taskID);
    
    [a, col_idx] = find(index_matrix(1,:) == prevTaskID);
    for loc_col_idx = 1: numel(col_idx)
        idx_m_col = col_idx(1, loc_col_idx);
        resourceID = index_matrix(3, idx_m_col);
        % diffCost(..prevTaskID..)
        if (flag_absent_cpu && resourceID >= 10 && resourceID < 100) || (flag_absent_acc && resourceID >= 100 && resourceID < 200) || (flag_absent_other && resourceID >= 200)
            
            for idx_m_row = 5:size(index_matrix, 1)
                index_content = index_matrix(idx_m_row, idx_m_col);
                if index_content > 0
                    commu_vector(1, index_content) = diffCost;
                end
            end    

        % sameCost(..prevTaskID..)
        elseif (~flag_absent_cpu && resourceID >= 10 && resourceID < 100) || (~flag_absent_acc && resourceID >= 100 && resourceID < 200) || (~flag_absent_other && resourceID >= 200)
            
            for idx_m_row = 5:size(index_matrix, 1)
                index_content = index_matrix(idx_m_row, idx_m_col);
                if index_content > 0
                    commu_vector(1, index_content) = sameCost;
                end
            end    
        end      
    end
end