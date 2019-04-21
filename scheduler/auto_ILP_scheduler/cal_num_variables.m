function [num_variables, num_energy_variable] = cal_num_variables(task_info, task_info_dep, resource_info, energy_opti)
    %% Author: Manqing Mao; mmao7@asu.edu
    num_variables = 0;
    % for each task
    for task_idx = 1:size(task_info,2)
        time_period = task_info(3,task_idx) - task_info(2,task_idx) + 1;
        
        % for each task, and each resource:
        for resource_idx = 1:size(resource_info,1)
            % if unique resource
            if ~mod(resource_info(resource_idx,end-1),10) && resource_info(resource_idx,task_idx) < 9999
                num_enc = time_period - resource_info(resource_idx,task_idx) + 1;
                
                % JUST for DEBUG                
                %infomation = ['TASK_',num2str(task_idx),' operates at resourceID ',num2str(resource_info(resource_idx,end-1)),' # of variables ',num2str(num_enc),'. '];
                %disp(infomation);
                if num_enc > 0   % since some cases cannot meet.
                    num_variables = num_variables + num_enc;
                end
            end
        end
    end

    num_variables = num_variables + 1; % one more for tmax
    num_latency_variable = num_variables;
    if energy_opti
        num_variables = num_variables + 1; % one more for E_execution
        num_variables = num_variables + sum(task_info_dep(2,:)<999);
        % for E_communication
%         for task_idx = 1:size(task_info_dep,2)
%             if task_info_dep(2, task_idx) < 9999
%                 num_variables = num_variables + sum(resource_info(:,task_idx)<999);
%             end
%         end
    end
    num_energy_variable = num_variables - num_latency_variable;
end