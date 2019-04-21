function [task_info_timing, task_info_dep, comm_vol] = read_task_graph(file_name, num_row_dep)
    %% Author: Manqing Mao; mmao7@asu.edu
    %% It will return the matrix with task_info for dependency and timing.
    %% The task_info(1,j) means that which task has to be executed first before task j. 
    %% "99999" means task j does not have to wait for any task.
    %% The task_info(2,j) means the earliest cycle for task j. 
    %% The task_info(3,j) means the deadline for task j. 
    num_info = 3; % col - task: dependency, start time, ddl.
    %file_name = 'Task_graph_2.txt';
    fd = fopen(file_name);
    S = textscan(fd,'%s','delimiter','\n');
    size_S = size(S{1,1});
    num_row = size_S(1,1);
    i = 1;
    taskID = 1;
    while (i <= num_row)
        if startsWith(S{1,1}(i,1),'add_new_tasks')
            temp_numtasks = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            num_tasks = str2double([temp_numtasks{:}]);
            
            task_info_timing = ones(num_info, num_tasks)*99999;
            task_info_timing(1,:) = linspace(1, num_tasks, num_tasks);
            task_info_dep = ones(num_row_dep, num_tasks)*99999;
            task_info_dep(1,:) = linspace(1, num_tasks, num_tasks);
            comm_vol = zeros(num_row_dep+1, num_tasks);
            comm_vol(1,:) = linspace(1, num_tasks, num_tasks);
            comm_vol(end,:) = 2;
            
        elseif startsWith(S{1,1}(i,1),'task')
            % Grab the task dependency info
            temp_dep = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            depend_tasks = str2double([temp_dep{:}]);
            if numel(depend_tasks) > 2         
                temp = numel(depend_tasks) - 2;
                task_info_dep(2:1+temp,taskID) = depend_tasks(1,3:end);
            end
            i = i+1;
            % Grab the timing info
            temp_timing = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            timing_tasks = str2double([temp_timing{:}]);
            task_info_timing(2,taskID) = timing_tasks(1,end-1) + 1;   % + 1 due to start from 1 
            task_info_timing(3,taskID) = timing_tasks(1,end) + 1;     % + 1 due to start from 1 
            taskID = taskID + 1;
        elseif startsWith(S{1,1}(i,1),'comm_vol')
            temp_dep = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            task_ids = str2double([temp_dep{:}]);
            task_post = task_ids(1,2);
            row_ptr = comm_vol(end, task_post);
            comm_vol(row_ptr, task_post) = task_ids(1,3);
            comm_vol(end, task_post) = comm_vol(end,task_post) + 1;
        end
        i = i+1;
    end
    comm_vol = comm_vol(1:end-1,:);
end
