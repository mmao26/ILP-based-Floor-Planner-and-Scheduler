function [new_A, new_b]  = get_A_b_energy(A, b, num_energy_variables, index_matrix, task_info_dep, resource_information, sameTask_comm, diffTask_comm, sameTask_comm_power, diffTask_comm_power, BigContant_power)
% clear all;
% clc;
% file_TG = 'Task_graph_3.txt';
% file_RG = 'Resources for TG_3.txt';
% flag_taskgraph = 1;
% Mdv = ones(1,11);
% num_row_dep = 5;
% num_resources = 2;
% cycle = 10;
% dep_depth = num_row_dep - 1;
% energy_opti = 1;
% flag_com = 1;
% BWmax = 10;
% bigConstant = 1000;
% BigContant_power = 10000;
% debug = 1;
% [task_info_timing, task_info_dep] = read_task_graph(file_TG, num_row_dep);
% 
% [resource_information, power_information] = read_resources_graph(file_RG, cycle, size(task_info_timing,2), num_resources);
% 
% %% use ASAP ALAP to reduce the number of variables:
% 
% reduced_task_timing_info = ASAP_ALAP(task_info_timing, task_info_dep, resource_information, dep_depth);
% task_info_timing = reduced_task_timing_info;
% 
% [sameTask_comm, diffTask_comm]  = get_comm_time(task_info_dep, flag_taskgraph);
% disp(sameTask_comm);
% disp(diffTask_comm);
% [sameTask_comm_power, diffTask_comm_power]  = get_comm_power(task_info_dep, flag_taskgraph);
% disp(sameTask_comm_power);
% disp(diffTask_comm_power);
% 
% [num_variables, num_energy_variables] = cal_num_variables(task_info_timing, task_info_dep, resource_information, energy_opti);
% 
% index_matrix = get_index_matrix(task_info_timing, resource_information, size(task_info_timing,2));
% 
% [A, b] = get_A_b_communication(flag_com, resource_information, index_matrix, task_info_timing, task_info_dep, num_variables, Mdv, BWmax, bigConstant, sameTask_comm, diffTask_comm);

%%  
    debug = 1;
    num_eqn_Ecommu = 0;
    for task_idx = 1:size(task_info_dep,2)
        if task_info_dep(2, task_idx) < 9999
            num_eqn_Ecommu = num_eqn_Ecommu + sum(resource_information(:,task_idx)<999);
        end
    end
    new_b = [b; zeros(num_eqn_Ecommu,1)];
    new_A = [A; zeros(num_eqn_Ecommu, size(A,2))];
    if debug
        if isequal(A,new_A(1:end-num_eqn_Ecommu,:))
            disp('Succeed for new_A initailization');
        else
            disp('ERROR...on new_A initailization');
        end
    end
    
    idx_row_newA = size(A, 1) + 1;    % the first row of energy constraint inequality
    idx_col_newA = size(new_A, 2) - num_energy_variables + 2; 
    
    for taskID = 1:size(task_info_dep,2)    % taskID for current task
        
        if task_info_dep(2, taskID) < 9999

            
            for resource_idx = 1 : sum(resource_information(:,taskID)<9999)
                resourceID_cur = resource_information(resource_idx, end-1);    % resourceID for current task
                
                % Penalty for task executes on other resources
                if sum(resource_information(:,taskID)<9999) > 1
                    [temp0, col_idx0] = find(index_matrix(1,:) == taskID);
                    % for each resource not belong to the same type
                    for n0 = 1:size(col_idx0,2)
                        col0 = col_idx0(n0);
                        resourceID_cur0 = index_matrix(3, col0);
                        if (resourceID_cur < 100 && resourceID_cur0 >= 100) ...
                                    || (resourceID_cur >= 100 && resourceID_cur < 200 && resourceID_cur0 < 100) ...
                                    || (resourceID_cur >= 100 && resourceID_cur < 200 && resourceID_cur0 > 200) ...
                                    || (resourceID_cur >= 200 && resourceID_cur0 < 200)
                            for ii = 5 : size(index_matrix, 1)
                                index_content = index_matrix(ii, col0);
                                if index_content > 0
                                    new_A(idx_row_newA, index_content) = new_A(idx_row_newA, index_content) - BigContant_power; 
                                end
                            end
                        end
                    end
                end
                % for each dependent task:
                for task_prev_idx = 2 : sum(task_info_dep(:,taskID)<9999)
                    taskID_prev = task_info_dep(task_prev_idx, taskID);
                    [temp, col_idx] = find(index_matrix(1,:) == taskID_prev);
                    
                    % get the coefficiencts 
                    cycle_same = sameTask_comm(task_prev_idx, taskID);
                    cycle_diff = diffTask_comm(task_prev_idx, taskID);
                    power_same = sameTask_comm_power(task_prev_idx, taskID);
                    power_diff = diffTask_comm_power(task_prev_idx, taskID);
                    
                    % for each resource for this taskID_prev:
                    for idx = 1: size(col_idx, 2)
                        resourceID_prev = index_matrix(3, col_idx(idx));

                        % check if they are the same resource
                        if (resourceID_prev < 100 && resourceID_cur < 100) ...
                           || (resourceID_prev >= 100 && resourceID_prev < 200 && resourceID_cur >= 100 && resourceID_cur < 200) ...
                           || (resourceID_prev >= 200 && resourceID_cur >= 200)
                       
                            % for each x in this previous task
                            for jj = 5 : size(index_matrix, 1)
                                index_content = index_matrix(jj, col_idx(idx));
                                if index_content > 0
                                    new_A(idx_row_newA, index_content) = new_A(idx_row_newA, index_content) + cycle_same * power_same;                               
                                end
                            end  
                        % not the same type    
                        else
                            % for each x in this previous task
                            for jj = 5 : size(index_matrix, 1)
                                index_content = index_matrix(jj, col_idx(idx));
                                if index_content > 0
                                    new_A(idx_row_newA, index_content) = new_A(idx_row_newA, index_content) + cycle_diff * power_diff;
                                end
                            end                             
                        end                        
                       
                    end
                    
                end
                new_A(idx_row_newA, idx_col_newA) = -1;
                idx_row_newA = idx_row_newA + 1; 
            end
            idx_col_newA = idx_col_newA + 1;    
        end
    end

    
    
end