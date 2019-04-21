function [taskID, resourceID, startTime, endTime]  = get_schedule(index_matrix, x_schedule, print_tag)
    index_x_set = find(x_schedule(:,1)>=0.9);  % default = number of rows
    % initialize
    taskID = zeros(1,numel(index_x_set)-1);
    resourceID = zeros(1,numel(index_x_set)-1);
    startTime = zeros(1,numel(index_x_set)-1);
    endTime = zeros(1,numel(index_x_set)-1);
    for idx = 1:numel(index_x_set)-1
        index_x = index_x_set(idx);
        [index_row, index_col] = find(index_matrix(5:end,:) == index_x); 
        index_row = index_row + 4;    % real index for index_matrix
        % grab info
        taskID(1,idx) = index_matrix(1,index_col);
        resourceID(1,idx) = index_matrix(3,index_col);
        startTime(1,idx) = index_row - 4;
        endTime(1,idx) = startTime(1,idx) + index_matrix(2,index_col) - 1;

        if print_tag
            if mod(resourceID(1,idx),10)   % if remainder is > 0, same resources more than 1
                min_resourceID = resourceID(1,idx) - mod(resourceID(1,idx),10);
                resource_infomation = ['TASK_',num2str(taskID(1,idx)),' operates at resourceID ',num2str(min_resourceID),' -- ',num2str(resourceID(1,idx)),'. '];
                disp(resource_infomation);
            else
                resource_infomation = ['TASK_',num2str(taskID(1,idx)),' operates at resourceID ',num2str(resourceID(1,idx)),'. '];
                disp(resource_infomation);
            end
            time_infomation = ['TASK_',num2str(taskID(1,idx)),' starts at beginning of ',num2str(startTime(1,idx)),' ends at the end of ', num2str(endTime(1,idx)),'. '];
            disp(time_infomation);
            fprintf(1, '\n');
        end
    end
end