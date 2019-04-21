function commu_matrix = get_commu_matrix(taskID, task_info_dep, resource_information, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm)
    
%     %% TESTING
%     clear all;
%     file_TG = 'Task_graph_4.txt';
%     file_RG = 'Resources for TG_4.txt';
%     num_row_dep = 5;
%     cycle = 1;
%     num_resources = 3;
%     BWmax = 10;
%     Mdv = ones(1,10);
%     flag_com = 1;
    
%     file_TG = 'Task_graph_1.txt';
%     file_RG = 'Resources for TG_1 and TG_2.txt';
%     num_row_dep = 5;
%     num_resources = 3;
%     cycle = 10;
%     BWmax = 10;
%     Mdv = ones(1,5);

%     file_TG = 'Task_graph_3.txt';
%     file_RG = 'Resources for TG_3.txt';
%     num_row_dep = 5;
%     num_resources = 2;
%     cycle = 10;
%     BWmax = 10;
%     Mdv = ones(1,11);

%     [task_info_timing, task_info_dep] = read_task_graph(file_TG, num_row_dep);
%     resource_information = read_resources_graph(file_RG, cycle, size(task_info_timing,2), num_resources);
%     num_variables = cal_num_variables(task_info_timing, resource_information);
%     index_matrix = get_index_matrix(task_info_timing, resource_information, size(task_info_timing,2));
%     
%     bigConstant = 1000; 
%     sameCost = 5;
%     diffCost = 10;
%     taskID = 6;
    %%
    % the number of resources can perform the task
    num_resource_task = get_num_resource(taskID, resource_information);  
    num_dep = sum(task_info_dep(2:end, taskID)<9999);
    num_eqn = num_resource_task * num_dep;
    
    if num_dep == 0
        % For tmax Eqn, return zeros(1, num_variables);
        commu_matrix = zeros(1, num_variables);
    else
        commu_matrix = zeros(num_eqn, num_variables); % initialize
        index_row = 1;
        for prevTask_idx = 1 : num_dep
            prevTaskID = task_info_dep(1+prevTask_idx, taskID);
            [a, col_idx] = find(index_matrix(1,:) == taskID);
            
            flag_absent_acc_other = false;
            flag_absent_cpu_other = false;
            flag_absent_acc_cpu = false;
            for loc_col_idx = 1: numel(col_idx)
                idx_m_col = col_idx(1, loc_col_idx);
                resourceID = index_matrix(3, idx_m_col);
                % taskID is cpu, option = cpu:
                if resourceID >= 10 && resourceID < 100
                    absent_resourceIDList = [100, 200];
                    if flag_absent_acc_other == false
                        commu_vector = get_commu_vector(prevTaskID, taskID, task_info_dep, absent_resourceIDList, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm);
                        commu_matrix(index_row,:) = commu_vector;
                        index_row = index_row + 1;
                    end
                    flag_absent_acc_other = true; 
                    
                elseif resourceID >= 100 && resourceID < 200
                    absent_resourceIDList = [10, 200];
                    if flag_absent_cpu_other == false
                        commu_vector = get_commu_vector(prevTaskID, taskID, task_info_dep, absent_resourceIDList, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm);
                        commu_matrix(index_row,:) = commu_vector;
                        index_row = index_row + 1;
                    end
                    flag_absent_cpu_other = true; 
                elseif resourceID >= 200
                    absent_resourceIDList = [10, 100];
                    if flag_absent_acc_cpu == false
                        commu_vector = get_commu_vector(prevTaskID, taskID, task_info_dep, absent_resourceIDList, num_variables, index_matrix, bigConstant, sameTask_comm, diffTask_comm);
                        commu_matrix(index_row,:) = commu_vector;
                        index_row = index_row + 1;
                    end
                    flag_absent_acc_cpu = true; 
                end
            end        
        end
    end
    %disp(commu_matrix);
end