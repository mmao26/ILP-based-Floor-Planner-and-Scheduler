function [A, b]  = get_A_b_communication(flag_com, resource_info, index_matrix, task_info_timing, task_info_dep, num_variables, Mdv, BWmax, bigConstant, sameTask_comm, diffTask_comm)
    %% Author: Manqing Mao; mmao7@asu.edu
    % BW constraints -- number of time step
    % tmax constaints -- number of tasks
    % task dependency -- num_dep
    
    %% TESTING
%     clear all;
%     file_TG = 'Task_graph_4.txt';
%     file_RG = 'Resources for TG_4.txt';
%     num_row_dep = 5;
%     cycle = 1;
%     num_resources = 3;
%     BWmax = 10;
%     Mdv = ones(1,10);

%     flag_com = 1;
%     
%     file_TG = 'Task_graph_1.txt';
%     file_RG = 'Resources for TG_1 and TG_2.txt';
%     num_row_dep = 5;
%     num_resources = 3;
%     cycle = 10;
%     BWmax = 10;
% 
%     Mdv = ones(1,5);
%     bigConstant = 1000; 
%     sameCost = 5;
%     diffCost = 10;
%     
%     [task_info_timing, task_info_dep] = read_task_graph(file_TG, num_row_dep);
%     resource_info = read_resources_graph(file_RG, cycle, size(task_info_timing,2), num_resources);
%     num_variables = cal_num_variables(task_info_timing, resource_info);
%     index_matrix = get_index_matrix(task_info_timing, resource_info, size(task_info_timing,2));
    %%
    % calculate the number of Eqn. for BWmax, which is = time step
     [st, ed] = get_nonzero_row_index(index_matrix(5:end,:));    
     num_BW_constraint = ed - st + 1;
     
    if flag_com
        num_tmax_constraint = 0;
        num_dep_constraint = 0;
        for taskID = 1:size(task_info_timing, 2)
            [num_eqn_tmax, num_eqn_dep] = get_num_eqn_tmaxANDdep(resource_info, task_info_dep, taskID);
            num_tmax_constraint = num_tmax_constraint + num_eqn_tmax;
            num_dep_constraint = num_dep_constraint + num_eqn_dep;
        end
    else
        % calculate the number of Eqn. for tmax, which is = number of tasks
        num_tmax_constraint = size(task_info_timing, 2);  
        % calculate the number of Eqn. for task dependencies
        num_dep_constraint = 0;
        for rowID = 2:size(task_info_dep,1)
            num_dep_constraint = num_dep_constraint + sum(task_info_dep(rowID, :)<9999);
        end
    end

    % calculate the number of Eqn. for resource constraints
    % get the column index (bound) for each type of resource
    resourceID_set = unique(index_matrix(3,:));
    number_diff_resource = numel(resourceID_set);
    col_index_resource_temp = zeros(1, number_diff_resource);
    num_eqn_each_resource = zeros(1, number_diff_resource);
    for resouceID = 1:number_diff_resource
        col_index_resource_temp(1, resouceID) = max(find(index_matrix(3,:)==resourceID_set(1, resouceID)));
        col_index_resource = sort(col_index_resource_temp);
    end
%     disp(['col_index_resource: ' num2str(col_index_resource)]);
    i = 1;
    num_resource_constraint = 0;
    for resouceID = 1:numel(col_index_resource)
        tempA = 0;
        % for each type of resource
        for taskID = i:col_index_resource(1, resouceID)   % index bound
            [st, ed] = get_nonzero_row_index(index_matrix(5:end,taskID));
            if ed > 0
                cur_con = ed + (index_matrix(2,taskID) - 1);
                tempA = max(tempA, cur_con);
            end
        end
        num_eqn_each_resource(1, resouceID) = tempA; % number of eqn. for each resource
        
        [st_temp, dm] = get_nonzero_row_index(index_matrix(5:end,i:col_index_resource(1, resouceID)));
        num_resource_constraint = num_resource_constraint + tempA - st_temp + 1;
        
        % Have to substract the number of all rows with zero
        row_all_zeros = find(all(index_matrix(st_temp+4:dm+4,i:col_index_resource(1, resouceID)) == 0,2));
        if size(row_all_zeros,1) > 0
            num_resource_constraint = num_resource_constraint - size(row_all_zeros,1);
        end
        
        % disp(['# of resource constraints for this type: ' num2str(num_resource_constraint)]);
        i = taskID + 1;
    end

    num_row_Ab = num_BW_constraint + num_tmax_constraint + num_dep_constraint + num_resource_constraint;
%     disp(['BW constraints: ' num2str(num_BW_constraint)]);
%     disp(['tmax constraints: ' num2str(num_tmax_constraint)]);
%     disp(['task dependency constraints: ' num2str(num_dep_constraint)]);
%     disp(['resource constraints: ' num2str(num_resource_constraint)]);

    % Set up A, b
    A = zeros(num_row_Ab, num_variables);
    b = zeros(num_row_Ab, 1);
    
    idx_Ab_row = 1;
    i = 1;
    % List Resource Constraints:
    for resouceID = 1:numel(col_index_resource)   
        % for each time step
        for idx_matrix_row = 5:size(index_matrix,1) %j+num_eqn_each_resource(1,taskID)-1 % for each constraints
            % for each type of resource: list resource constraints
            flag_hasValue = false;
            for taskID = i:col_index_resource(1, resouceID)   % column index
                index_content = index_matrix(idx_matrix_row, taskID);
                if index_content > 0
                    % for debug 
%                     if index_content >= 216 && index_content <= 219
%                         disp(['index now is: ' num2str(index_content)]);
%                         disp(['now in A: ' num2str(idx_Ab_row)]);
%                     end
                    
                    for k = 0:index_matrix(2,taskID)-1
                        A(idx_Ab_row+k, index_content) = 1;
                        b(idx_Ab_row+k,1) = index_matrix(4,taskID); % # of resources in this type
                    end
                    % for debug 
%                     if index_content == 210
%                         disp(['A(' num2str(idx_Ab_row) ', ' num2str(index_content) ') is']);
%                         disp(A(idx_Ab_row, index_content));
%                     end
                    
                    flag_hasValue = true;
                end
            end
            if flag_hasValue
                idx_Ab_row = idx_Ab_row + 1;  
            end
        end
        i = taskID + 1;
        % point to next row for a different type of resource
        [dm_temp0, idx_Ab_row] = get_nonzero_row_index(A);
        %disp(['# of resource constraints for this type in A: ' num2str(idx_Ab_row)]);
        idx_Ab_row = idx_Ab_row + 1;
    end
    % debug for resource constraints:
    [dm_temp1, row_idx_check] = get_nonzero_row_index(A);
    % disp(row_idx_check);
    if row_idx_check ~= num_resource_constraint
        disp('ERROR...on Resource Constraints');
    else
        idx_Ab_row = num_resource_constraint + 1;  % point to next row
    end
    A_start = A;
    A_end = A;
    % List Tmax Constraints:
    if flag_com
        % stores the index for start_index and end_index for each task
        index_tmax = zeros(2, size(task_info_timing, 2));
        start_row = idx_Ab_row;
        for taskID = 1 : size(task_info_timing, 2)
            [num_eqn_tmax, num_eqn_dep] = get_num_eqn_tmaxANDdep(resource_info, task_info_dep, taskID);
            index_tmax(1,taskID) = start_row; % start index
            index_tmax(2,taskID) = index_tmax(1,taskID) + num_eqn_tmax - 1; % end index
            start_row = index_tmax(2,taskID) + 1;
        end
        
        for idx_matrix_col = 1:size(index_matrix,2)
            taskID = index_matrix(1,idx_matrix_col);
            cpu_cycle = index_matrix(2,idx_matrix_col);
            start_idx = index_tmax(1, taskID);
            end_idx = index_tmax(2, taskID);
            task_rows_inA = end_idx - start_idx;
            
            for idx_matrix_row = 5:size(index_matrix,1)
                index_content = index_matrix(idx_matrix_row, idx_matrix_col);
                if index_content > 0
                    for i = 0 : task_rows_inA                      
                        
                        A_end(start_idx + i, index_content) = idx_matrix_row - 4 + (cpu_cycle - 1);  % end time
                        A_start(start_idx + i, index_content) = idx_matrix_row - 4;   % start time
                        
                    end
                    
                end
            end

            commu_matrix = get_commu_matrix(taskID, task_info_dep, resource_info, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm);
            A(start_idx:end_idx,:) = A_end(start_idx:end_idx,:) + commu_matrix;
        end
        
    else
    
        for idx_matrix_col = 1:size(index_matrix,2)
            taskID = index_matrix(1,idx_matrix_col);
            cpu_cycle = index_matrix(2,idx_matrix_col);
            for idx_matrix_row = 5:size(index_matrix,1)
                index_content = index_matrix(idx_matrix_row, idx_matrix_col);
                if index_content > 0
                    A(idx_Ab_row + taskID - 1, index_content) = idx_matrix_row - 4 + (cpu_cycle - 1);  % end time
                    A_start(idx_Ab_row + taskID - 1, index_content) = idx_matrix_row - 4;   % start time
                end
            end
        end
    end
        
    start_index = num_resource_constraint + 1;
    end_index = num_resource_constraint + num_tmax_constraint;
    col_tmax = max(index_matrix(:,end)) + 1;
    
%     A(start_index:end_index, end) = -1;
%     A_start(start_index:end_index, end) = -1;
%     A_end(start_index:end_index, end) = -1;
    
    A(start_index:end_index, col_tmax) = -1;
    A_start(start_index:end_index, col_tmax) = -1;
    A_end(start_index:end_index, col_tmax) = -1;
    b(start_index:end_index, 1) = 0;

    % debug for tmax constraints:
    [dm_temp2, row_idx_check] = get_nonzero_row_index(A);
    if row_idx_check ~= num_resource_constraint + num_tmax_constraint
        disp('ERROR...on Tmax Constraints');
    else
        idx_Ab_row = end_index + 1;  % point to next row
    end
    
    
    % List Dependency Constraints:
    if flag_com
        % stores the taskID, index for start_index and end_index for some tasks
        index_dep = zeros(3, sum(task_info_dep(2,:)<999));
        start_row = idx_Ab_row;
        col_idx = 1;
        for taskID = 1 : size(task_info_timing, 2)
            [num_eqn_tmax, num_eqn_dep] = get_num_eqn_tmaxANDdep(resource_info, task_info_dep, taskID);
            if num_eqn_dep > 0
                index_dep(1,col_idx) = taskID;    % taskID
                index_dep(2,col_idx) = start_row; % start index
                index_dep(3,col_idx) = index_dep(2,col_idx) + num_eqn_dep - 1; % end index
                start_row = index_dep(3,col_idx) + 1;
                col_idx = col_idx + 1;
            end
        end
        for idx_col_dep = 1:size(task_info_dep,2)
            if task_info_dep(2,idx_col_dep) < 999 % At least one task dependency
                for idx_row_depTask = 1 : sum(task_info_dep(:,idx_col_dep)<999)-1
                    taskID_prev = task_info_dep(idx_row_depTask+1, idx_col_dep);  % taskID prev
                    taskID_cur = task_info_dep(1, idx_col_dep);     % taskID late

                    start_idx_Aend = index_tmax(1, taskID_prev);
                    start_idx_Astart = index_tmax(1, taskID_cur);
                    
                    num_resource = get_num_resource(taskID_cur, resource_info);  
                    % for each dependency, n Eqn, n = num_resource.                   
                    for each_dep = 1:num_resource
                        A(idx_Ab_row,:) = A_end(start_idx_Aend,:) - A_start(start_idx_Astart,:);  % end time - start time
                        b(idx_Ab_row,1) = -1;
                        idx_Ab_row = idx_Ab_row + 1; 
                    end
                end
                [a, col_idx] = find(index_dep(1,:) == taskID_cur);
                start_idx = index_dep(2,col_idx(1));
                end_idx = index_dep(3,col_idx(1));
                
                commu_matrix = get_commu_matrix(taskID_cur, task_info_dep, resource_info, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm);
                A(start_idx:end_idx,:) = A(start_idx:end_idx,:) + commu_matrix;
            end
        end        
    else
        for idx_col_dep = 1:size(task_info_dep,2)
            if task_info_dep(2,idx_col_dep) < 999
                for idx_row_depTask = 1 : sum(task_info_dep(:,idx_col_dep)<999)-1
                    taskID_prev = task_info_dep(idx_row_depTask+1, idx_col_dep);  % taskID prev
                    taskID_cur = task_info_dep(1, idx_col_dep);     % taskID late
                    A(idx_Ab_row,:) = A(num_resource_constraint + taskID_prev,:) - A_start(num_resource_constraint + taskID_cur,:);  % end time - start time
                    b(idx_Ab_row,1) = -1;
                    idx_Ab_row = idx_Ab_row + 1; 
                end
            end
        end
    end
    
    
    % debug for dependency constraints:
    [dm_temp3, row_idx_check] = get_nonzero_row_index(A);
    if row_idx_check ~= num_resource_constraint + num_tmax_constraint + num_dep_constraint
        disp('ERROR...on Dependency Constraints');
    else
        idx_Ab_row = num_resource_constraint + num_tmax_constraint + num_dep_constraint + 1;  % point to next row
    end    
    % List BWmax Constraints:
    b(idx_Ab_row:end,1) = BWmax;
    for idx_matrix_row = 5:size(index_matrix,1)
        for idx_matrix_col = 1:size(index_matrix,2)
            index_content = index_matrix(idx_matrix_row, idx_matrix_col);
            if index_content > 0
                taskID = index_matrix(1,idx_matrix_col);
                A(idx_Ab_row, index_content) = Mdv(1,taskID);
            end
        end
        idx_Ab_row = idx_Ab_row + 1;
    end
    % debug for dependency constraints:
    [dm_temp4, row_idx_check] = get_nonzero_row_index(A);
    if row_idx_check ~= num_row_Ab
        disp('ERROR...on BWmax Constraints');
    end     
% 
%     %disp(size(A));
%     %disp(b);
end