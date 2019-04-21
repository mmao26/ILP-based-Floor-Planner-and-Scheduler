function new_output_matrix = get_output_file(taskID, new_resourceID, startTime, write_file_tag)
    num_tasks = size(taskID, 2);
    output_matrix = zeros(num_tasks, 2);
    new_output_matrix = zeros(num_tasks, 2);
    for id = 1:size(taskID, 2)
        task_id = taskID(1, id);
        resource_id = new_resourceID(1, id);
        start_time = startTime(1, id);
        output_matrix(task_id, 1) = resource_id;
        output_matrix(task_id, 2) = start_time;
        new_output_matrix(task_id, 1) = resource_id;
    end
    new_output_matrix(:, 2) = 1;
    rescource_types = unique(output_matrix(:,1));
    for resource_idx = 1:numel(rescource_types)
        resource_id = rescource_types(resource_idx);
        [row_idx, temp] = find(output_matrix(:,1)==resource_id);
        num_tasks_resource = numel(row_idx);
        for i = 1:num_tasks_resource-1
            for j = i+1:num_tasks_resource
                if output_matrix(row_idx(i), 2) > output_matrix(row_idx(j), 2)
                    new_output_matrix(row_idx(i), 2) = new_output_matrix(row_idx(i), 2) + 1;
                else
                    new_output_matrix(row_idx(j), 2) = new_output_matrix(row_idx(j), 2) + 1;
                end
            end
        end
    end
    for new_id = 1:numel(rescource_types)
        old_id = rescource_types(new_id);
        [row_idx, temp] = find(new_output_matrix(:,1)==old_id);
        new_output_matrix(row_idx,1) = new_id;
    end
    if write_file_tag
        fid = fopen('OUTPUT_ILP.txt','wt');
        for ii = 1:size(new_output_matrix,1)
            fprintf(fid,'%g\t',new_output_matrix(ii,:));
            fprintf(fid,'\n');
        end
        fclose(fid)
    end
end