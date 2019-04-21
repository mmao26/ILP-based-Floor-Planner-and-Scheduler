function comm_vol  = get_comm_vol(index_matrix, resourceID, num_resource, task_info_dep, taskID, flag_taskgraph)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    % data from row --> col
    % vij, i --> j
    comm_vol = zeros(num_resource, num_resource);
    switch(flag_taskgraph) 
        case(1) % 5C1J
            datavol = zeros(size(task_info_dep,1), size(task_info_dep,2));
            for i = 2:5:22
                datavol(2,i:i+4) = [224, 224, 112, 128, 128];
            end
            num_slc = 4;
            slc_assign = zeros(5, num_slc);
            slc_assign(:,1) = [1000, 2, 5, 6, 7];
            slc_assign(:,2) = [2000, 10, 11, 12, 15];
            slc_assign(:,3) = [3000, 16, 17, 20, 21];
            slc_assign(:,4) = [4000, 22, 25, 26, 0];
        case(2) % 5C2J
            datavol = zeros(size(task_info_dep,1), size(task_info_dep,2));
            for i = 2:5:22
                datavol(2,i:i+4) = [224, 224, 112, 128, 128];
            end
            for i = 28:5:48 
                datavol(2,i:i+4) = [224, 224, 112, 128, 128];
            end
            num_slc = 4;
            slc_assign = zeros(9, num_slc);
%             slc_assign(:,1) = [1000, 2, 5, 6, 7, 28, 31, 32, 33];
%             slc_assign(:,2) = [2000, 10, 11, 12, 15, 36, 37, 38, 41];
%             slc_assign(:,3) = [3000, 16, 17, 20, 21, 42, 43, 46, 47];
%             slc_assign(:,4) = [4000, 22, 25, 26, 0, 48, 51, 52, 0]; 
            
            slc_assign(:,1) = [1000, 2, 5, 6, 7, 10, 11, 12, 15];
            slc_assign(:,2) = [2000, 16, 17, 20, 21, 22, 25, 26, 28];
            slc_assign(:,3) = [3000, 31, 32, 33, 36, 37, 38, 41, 42];
            slc_assign(:,4) = [4000, 43, 46, 47, 0, 48, 51, 52, 0];    
        case(3) % radar
            datavol = zeros(size(task_info_dep,1), size(task_info_dep,2));
            datavol(2:5,5:8) = 1048576;

            num_slc = 4;
            slc_assign = zeros(2, num_slc);
            slc_assign(:,1) = [1000, 5];
            slc_assign(:,2) = [2000, 6];
            slc_assign(:,3) = [3000, 7];
            slc_assign(:,4) = [4000, 8];            
    end
    disp(datavol);
    disp(slc_assign);
    for i = 1:size(task_info_dep, 2)
        if task_info_dep(2,i) < 999
            cur_task = task_info_dep(1,i); 
            [a, col_temp] = find(taskID(1,:) == cur_task);
            curTask_resourceID = resourceID(1,col_temp(1));  % resource ID for current task
            [a, col_temp] = find(index_matrix(1,3:end) == curTask_resourceID);
            idx_ij_curTask = col_temp(1);      % (col index - 2) for current task in index matrix
            for j = 1 : sum(task_info_dep(:,i)<999)-1
                % for each prev task
                prev_task = task_info_dep(j+1,i); 
                [a, col_temp] = find(taskID(1,:) == prev_task);
                prevTask_resourceID = resourceID(1,col_temp(1));  
                [a, col_temp] = find(index_matrix(1,3:end) == prevTask_resourceID);
                idx_ij_prevTask = col_temp(1);      % (col index - 2) index for prev task in index matrix                
                data_vol = datavol(j+1,i); 
                if curTask_resourceID >= 10 && curTask_resourceID < 100 && prevTask_resourceID >= 10 && prevTask_resourceID < 100
                    % they can communicate directly
                    if curTask_resourceID ~= prevTask_resourceID
                        comm_vol(idx_ij_prevTask, idx_ij_curTask) = comm_vol(idx_ij_prevTask, idx_ij_curTask) + data_vol;
                    end
                else
                    % they cannot communicate directly
                    if curTask_resourceID ~= prevTask_resourceID
                        [a, col_temp] = find(slc_assign == cur_task);
                        slc_resourceID = slc_assign(1, col_temp(1));
                        [a, col_temp] = find(index_matrix(1,3:end) == slc_resourceID);
                        idx_ij_slc = col_temp(1);      % (col index - 2) index for prev task in index matrix   
                        
                        comm_vol(idx_ij_prevTask, idx_ij_slc) = comm_vol(idx_ij_prevTask, idx_ij_slc) + data_vol;
                        comm_vol(idx_ij_slc, idx_ij_curTask) = comm_vol(idx_ij_slc, idx_ij_curTask) + data_vol;
                    end                    
                end
            end
        end
    end
    
end
