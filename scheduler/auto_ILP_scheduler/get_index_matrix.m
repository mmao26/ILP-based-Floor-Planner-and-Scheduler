function index_matrix  = get_index_matrix(task_info, resource_info, total_task)
%% Author: Manqing Mao; mmao7@asu.edu
%% 1st row in index_matrix is taskID
%% 2nd row in index_matrix is period in terms of cycles
%% 3rd row in index_matrix is resource ID. --> different type of resource
%% 4th row in index_matrix is the number of same type of resource
%% 5th row to the last row is indecies
%% For Testing
%     clear all;
%     file_TG = 'Task_graph_3.txt';
%     file_RG = 'Resources for TG_3.txt';
%     num_row_dep = 5;
%     cycle = 10;
%     num_resources = 3;
%     
% %     file_TG = 'Task_graph_2.txt';
% %     file_RG = 'Resources for TG_1 and TG_2.txt';
% %     num_row_dep = 5;
% %     num_resources = 3;
% %     cycle = 10;
%  
%     [task_info, task_info_dep] = read_task_graph(file_TG, num_row_dep);
%     resource_info = read_resources_graph(file_RG, cycle, size(task_info,2), num_resources);
%     total_task = size(task_info,2);
%%
    num_col = 0;
    indexID = 1;
    num_task_cpuA = 0;
    num_task_cpuB = 0;
    num_task_cpuC = 0;
    num_task_cpuD = 0;
    num_task_cpuE = 0;
    num_task_cpuF = 0;
    num_task_cpuG = 0;
    num_task_cpuH = 0;
    
    num_task_accA = 0;
    num_task_accB = 0;
    num_task_accC = 0;
    num_task_accD = 0;
    num_task_accE = 0;
    num_task_accF = 0;
    num_task_accG = 0;
    num_task_accH = 0;
    
    num_task_otherA = 0;
    num_task_otherB = 0;
    num_task_otherC = 0;
    num_task_otherD = 0;
    num_task_otherE = 0;
    num_task_otherF = 0;
    num_task_otherG = 0;
    num_task_otherH = 0;
    
    idx_col = 1;
    % grab the latest deadline
    time_step = max(task_info(3,:));  
    % grab the information: (1) MAX number of tasks (num_task_cpuX or
    % num_task_accX) in cpuX or accX
    % (2) row index (idx_num_task_cpuX or idx_num_task_accX) for
    % cpuX or accX
    
    for i = 1:size(resource_info,1)
        % get number of col for index matrix
        % which = sum(tasks for HW1) + ... + sum(tasks for HWn)
        if ~mod(resource_info(i,end-1),10)
            num_col = resource_info(i,end) + num_col;
        end
        if resource_info(i,end-1) >= 10 && resource_info(i,end-1) < 20
            num_task_cpuA = resource_info(i,end);
            idx_num_task_cpuA = i;
        elseif resource_info(i,end-1) >= 20 && resource_info(i,end-1) < 30
            num_task_cpuB = resource_info(i,end);
            idx_num_task_cpuB = i;
        elseif resource_info(i,end-1) >= 30 && resource_info(i,end-1) < 40
            num_task_cpuC = resource_info(i,end);
            idx_num_task_cpuC = i;
        elseif resource_info(i,end-1) >= 40 && resource_info(i,end-1) < 50
            num_task_cpuD = resource_info(i,end);
            idx_num_task_cpuD = i;
        elseif resource_info(i,end-1) >= 50 && resource_info(i,end-1) < 60
            num_task_cpuE = resource_info(i,end);
            idx_num_task_cpuE = i;
        elseif resource_info(i,end-1) >= 60 && resource_info(i,end-1) < 70
            num_task_cpuF = resource_info(i,end);
            idx_num_task_cpuF = i;
        elseif resource_info(i,end-1) >= 70 && resource_info(i,end-1) < 80
            num_task_cpuG = resource_info(i,end);
            idx_num_task_cpuG = i;
        elseif resource_info(i,end-1) >= 80 && resource_info(i,end-1) < 90
            num_task_cpuH = resource_info(i,end);
            idx_num_task_cpuH = i;
        elseif resource_info(i,end-1) >= 100 && resource_info(i,end-1) < 110
            num_task_accA = resource_info(i,end);
            idx_num_task_accA = i;
        elseif resource_info(i,end-1) >= 110 && resource_info(i,end-1) < 120
            num_task_accB = resource_info(i,end);
            idx_num_task_accB = i;
        elseif resource_info(i,end-1) >= 120 && resource_info(i,end-1) < 130
            num_task_accC = resource_info(i,end);
            idx_num_task_accC = i;
        elseif resource_info(i,end-1) >= 130 && resource_info(i,end-1) < 140
            num_task_accD = resource_info(i,end);
            idx_num_task_accD = i;
        elseif resource_info(i,end-1) >= 140 && resource_info(i,end-1) < 150
            num_task_accE = resource_info(i,end);
            idx_num_task_accE = i;
        elseif resource_info(i,end-1) >= 150 && resource_info(i,end-1) < 160
            num_task_accF = resource_info(i,end);
            idx_num_task_accF = i;
        elseif resource_info(i,end-1) >= 160 && resource_info(i,end-1) < 170
            num_task_accG = resource_info(i,end);
            idx_num_task_accG = i;
        elseif resource_info(i,end-1) >= 170 && resource_info(i,end-1) < 180
            num_task_accH = resource_info(i,end);
            idx_num_task_accH = i;   
        elseif resource_info(i,end-1) >= 200 && resource_info(i,end-1) < 210
            num_task_otherA = resource_info(i,end);
            idx_num_task_otherA = i;
        elseif resource_info(i,end-1) >= 210 && resource_info(i,end-1) < 220
            num_task_otherB = resource_info(i,end);
            idx_num_task_otherB = i;
        elseif resource_info(i,end-1) >= 220 && resource_info(i,end-1) < 230
            num_task_otherC = resource_info(i,end);
            idx_num_task_otherC = i;
        elseif resource_info(i,end-1) >= 230 && resource_info(i,end-1) < 240
            num_task_otherD = resource_info(i,end);
            idx_num_task_otherD = i;
        elseif resource_info(i,end-1) >= 240 && resource_info(i,end-1) < 250
            num_task_otherE = resource_info(i,end);
            idx_num_task_otherE = i;
        elseif resource_info(i,end-1) >= 250 && resource_info(i,end-1) < 260
            num_task_otherF = resource_info(i,end);
            idx_num_task_otherF = i;
        elseif resource_info(i,end-1) >= 260 && resource_info(i,end-1) < 270
            num_task_otherG = resource_info(i,end);
            idx_num_task_otherG = i;
        elseif resource_info(i,end-1) >= 270 && resource_info(i,end-1) < 280
            num_task_otherH = resource_info(i,end);
            idx_num_task_otherH = i;
        end
    end
    index_matrix = zeros(time_step+4, num_col);
%     disp(num_task_cpuA);
%     disp(num_task_accA);
%     disp(num_task_cpuB);
%     disp(num_task_accB);
%     disp(idx_num_task_cpuA);
%     disp(idx_num_task_accA);
%     disp(idx_num_task_cpuB);
%     disp(idx_num_task_accB);
    
    % ACC Section (support 8 different ACCs at most)
    if num_task_accA  % accA exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accA, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accA, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_accA, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accA, end-1),10) + 1;
                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;   % time period
                % the number of variables for each task
                num_vari_task = 1 - resource_info(idx_num_task_accA, idx_task) + n;
                % assign variable index for each task
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;   % i+2 since first two rows are taskID and period
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end 
        end
    end
    if num_task_accB  % accB exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accB, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accB, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_accB, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accB, end-1),10) + 1;
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accB, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_accC  % accC exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accC, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accC, idx_task); % assign period
                index_matrix(3,idx_col) = resource_info(idx_num_task_accC, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accC, end-1),10) + 1;
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accC, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_accD  % accD exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accD, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accD, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_accD, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accD, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accD, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_accE  % accE exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accE, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accE, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_accE, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accE, end-1),10) + 1;                  
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accE, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_accF  % accF exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accF, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accF, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_accF, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accF, end-1),10) + 1;                  
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accF, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_accG  % accG exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accG, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accG, idx_task); % assign period
                index_matrix(3,idx_col) = resource_info(idx_num_task_accG, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accG, end-1),10) + 1;                  
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accG, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_accH  % accH exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_accH, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_accH, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_accH, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_accH, end-1),10) + 1;                  
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_accH, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end           
        end
    end
    % CPU Section (support 8 different CPUs at most)
    if num_task_cpuA  % cpuA exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuA, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuA, idx_task); % assign period
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuA, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuA, end-1),10) + 1;
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuA, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end 
        end
    end
    if num_task_cpuB  % cpuB exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuB, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuB, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuB, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuB, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuB, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_cpuC  % cpuC exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuC, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuC, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuC, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuC, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuC, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_cpuD  % cpuD exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuD, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuD, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuD, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuD, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuD, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_cpuE  % cpuE exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuE, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuE, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuE, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuE, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuE, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_cpuF  % cpuF exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuF, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuF, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuF, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuF, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuF, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_cpuG  % cpuG exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuG, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuG, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuG, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuG, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuG, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_cpuH  % cpuH exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_cpuH, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_cpuH, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_cpuH, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_cpuH, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_cpuH, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end           
        end
    end
    % OTHER Section (support 8 different OTHERs at most)
    if num_task_otherA  % otherA exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherA, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherA, idx_task); % assign period
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherA, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherA, end-1),10) + 1;
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherA, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end 
        end
    end
    if num_task_otherB  % otherB exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherB, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherB, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherB, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherB, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherB, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_otherC  % otherC exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherC, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherC, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherC, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherC, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherC, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_otherD  % otherD exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherD, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherD, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherD, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherD, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherD, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_otherE  % otherE exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherE, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherE, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherE, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherE, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherE, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_otherF  % otherF exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherF, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherF, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherF, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherF, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherF, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_otherG  % otherG exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherG, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherG, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherG, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherG, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherG, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end
        end
    end
    if num_task_otherH  % otherH exists
        for idx_task = 1:total_task
            if resource_info(idx_num_task_otherH, idx_task) < 99
                index_matrix(1,idx_col) = idx_task;         % assign taskID 
                index_matrix(2,idx_col) = resource_info(idx_num_task_otherH, idx_task); % assign period 
                index_matrix(3,idx_col) = resource_info(idx_num_task_otherH, end-1);
                index_matrix(4,idx_col) = mod(resource_info(idx_num_task_otherH, end-1),10) + 1;                
                n = task_info(3,idx_task) - task_info(2,idx_task) + 1;
                num_vari_task = 1 - resource_info(idx_num_task_otherH, idx_task) + n;
                for i = task_info(2,idx_task):(task_info(2,idx_task) + num_vari_task - 1)
                    index_matrix(i+4, idx_col) = indexID;
                    indexID = indexID + 1;
                end
                idx_col = idx_col + 1;   % point to nxt col will be written
            end           
        end
    end
    
end