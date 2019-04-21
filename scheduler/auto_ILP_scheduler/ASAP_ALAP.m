function reduced_task_timing_info = ASAP_ALAP(task_timing_info, task_dep_info, resource_info, depth)
    %% Author: Manqing Mao; mmao7@asu.edu
    % initialize
    n = 1;
    reduced_task_timing_info = task_timing_info;
    while (n < depth)
        for task_idx = 1 : size(task_dep_info, 2)
            if task_dep_info(2, task_idx) < 99   % means at least 1 task dependency
                % for each task dependency relationship
                for each_dep = 1 : sum(task_dep_info(2:end, task_idx)<99)
                    % grab task A (self)
                    self_taskID = task_dep_info(1,task_idx);
                    % grab task B (prev task)
                    prev_taskID = task_dep_info(each_dep+1,task_idx);

                    % get the information about minimized time
                    minT_self_task = min(resource_info(:,self_taskID));
                    minT_prev_task = min(resource_info(:,prev_taskID));

                    % start time delay for self-task, its start time = max(self_start_time, prevTask_start_time + prevTask_period)
                    reduced_task_timing_info(2,self_taskID) = max(reduced_task_timing_info(2,self_taskID), reduced_task_timing_info(2,prev_taskID)+minT_prev_task);
                    % end time earlier for prev-task, its end time = min(prev_end_time, selfTask_end_time - selfTask_period)
                    reduced_task_timing_info(3,prev_taskID) = min(reduced_task_timing_info(3,prev_taskID), reduced_task_timing_info(3,self_taskID)-minT_self_task);
                end
            end
        end
        n = n + 1;
    end
    %disp(reduced_task_timing_info);
end