function energy_total = get_total_energy(taskID, resourceID, startTime, endTime, power_information, task_info_dep, sameTask_comm, diffTask_comm, sameTask_comm_power, diffTask_comm_power)
    energy_total = 0;
    % for execution energy
    for i = 1:size(taskID, 2)
        task_id = taskID(i);
        resource_id = resourceID(i);
        
        [row_idx, temp] = find(power_information(:, end-1) == resource_id);
        
        exe_power = power_information(row_idx(1), task_id);
        execution_energy = (endTime(i) - startTime(i) + 1) * exe_power;
        energy_total = energy_total + execution_energy;
    end
    % for communication energy
    for j = 1:size(task_info_dep, 2)
        num_dep = sum(task_info_dep(:, j)<9999) - 1;
        if num_dep >= 1
            task_cur = task_info_dep(1, j);
            [temp0, col_idx] = find(taskID(1, :) == task_cur);
            task_cur_resourceID = resourceID(1, col_idx(1));
            
            for idx = 2 : num_dep+1
                task_prev = task_info_dep(idx, j);
                [temp1, col_idx1] = find(taskID(1, :) == task_prev);
                task_prev_resourceID = resourceID(1, col_idx1(1));
                
                
                cycle_same = sameTask_comm(idx,j);
                cycle_diff = diffTask_comm(idx,j);
                power_same = sameTask_comm_power(idx,j);
                power_diff = diffTask_comm_power(idx,j);
                
                if (task_prev_resourceID < 100 && task_cur_resourceID < 100) ...
                   || (task_prev_resourceID >= 100 && task_prev_resourceID < 200 && task_cur_resourceID >= 100 && task_cur_resourceID < 200) ...
                   || (task_prev_resourceID >= 200 && task_cur_resourceID >= 200)
               
                    energy_total = energy_total + cycle_same * power_same;
                    
                else
                    energy_total = energy_total + cycle_diff * power_diff;
                end
            end
        end
    end
end