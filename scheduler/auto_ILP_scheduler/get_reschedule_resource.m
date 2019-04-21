function new_resourceID = get_reschedule_resource(taskID, resourceID, startTime, endTime)
    % initailize
    new_resourceID = resourceID;
    resource_table = zeros(max(endTime(1,:)), size(taskID,2)+1);
    resource_table(:,1) = linspace(1, max(endTime(1,:)), max(endTime(1,:)));
    
    for task_idx = 1 : size(taskID,2)
        % for each task
        resource_id = resourceID(1,task_idx);
        if mod(resource_id,10)
            min_resourceID = resource_id - mod(resource_id,10);
            max_resourceID = resource_id;
            %task_id = taskID(1,task_idx);
            start_time = startTime(1,task_idx);
            end_time = endTime(1,task_idx);
            flag_found = false;
            
            for candidate_resourceID = min_resourceID:max_resourceID
                if ~ismember(candidate_resourceID, resource_table(start_time:end_time,2:end)) && ~flag_found % not occupied
                    new_resourceID(1, task_idx) = candidate_resourceID;
                    resource_table(start_time:end_time,task_idx+1) = candidate_resourceID;
                    
                    flag_found = true;
                end
            end
        end
    end
    disp(resource_table);
end