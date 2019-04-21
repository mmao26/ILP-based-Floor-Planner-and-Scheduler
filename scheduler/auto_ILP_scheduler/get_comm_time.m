function [sameTask_comm, diffTask_comm]  = get_comm_time(task_info_dep, comm_vol, flag_taskgraph)
    sameTask_comm = zeros(size(task_info_dep,1), size(task_info_dep,2));
    diffTask_comm = zeros(size(task_info_dep,1), size(task_info_dep,2));
    sameTask_comm(1,:) = task_info_dep(1,:);
    diffTask_comm(1,:) = task_info_dep(1,:);
    switch(flag_taskgraph) 
        case(1)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 2;
                    end
                end
            end

        case(2)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 1;
                        diffTask_comm(i,j) = 2;
                    end
                end
            end
        case(3)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 1;
                        diffTask_comm(i,j) = 2;
                    end
                end
            end
        case(4)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 1;
                        diffTask_comm(i,j) = 2;
                    end
                end
            end
        case(5)
            diffTask_comm = comm_vol;
            for i = 2:size(comm_vol,1)
                for j = 1:size(comm_vol,2)
                    if comm_vol(i,j) == 0
                        diffTask_comm(i,j) = 99999;
                    end
                end
            end	            
            for i = 2:size(diffTask_comm,1)
                for j = 1:size(diffTask_comm,2)
                    if diffTask_comm(i,j) < 999
                        sameTask_comm(i,j) = 0;
                    else
                        sameTask_comm(i,j) = 99999;
                    end
                end
            end	
        case(6)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 0;
                    end
                end
            end   

            for j = 1:size(task_info_dep,2)
                if mod((j - 2), 5) == 0 
                    diffTask_comm(2,j) = 2;
                elseif mod((j - 1), 5) == 0 
                    diffTask_comm(2,j) = 8;
                end
            end
        case(61)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 0;
                    end
                end
            end   

            for j = 1:size(task_info_dep,2)
                if mod((j - 2), 6) == 0 
                    diffTask_comm(2,j) = 2;
                elseif mod(j, 6) == 0 
                    diffTask_comm(2,j) = 8;
                end
            end  
        case(62)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 0;
                    end
                end
            end   

            for j = 1:size(task_info_dep,2)
                if j < 27
                    if mod((j - 2), 5) == 0 
                        diffTask_comm(2,j) = 2;
                    elseif mod((j - 1), 5) == 0 
                        diffTask_comm(2,j) = 8;
                    end
                else
                    if mod((j - 3), 5) == 0 
                        diffTask_comm(2,j) = 2;
                    elseif mod((j - 2), 5) == 0 
                        diffTask_comm(2,j) = 8;
                    end                    
                end
            end
        case(7)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 0;
                    end
                end
            end   

            for j = 1:size(task_info_dep,2)
                if mod((j-4), 6) == 0 
                    diffTask_comm(2,j) = 8;
                end
            end  
        case(71)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 0;
                    end
                end
            end   

            for j = 1:size(task_info_dep,2)
                if mod((j-4), 7) == 0 
                    diffTask_comm(2,j) = 8;
                end
            end     
        case(72)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm(i,j) = 99999;
                        diffTask_comm(i,j) = 99999;
                    else
                        sameTask_comm(i,j) = 0;
                        diffTask_comm(i,j) = 0;
                    end
                end
            end   

            for j = 1:size(task_info_dep,2)
                if j < 31 && mod((j-4), 6) == 0  
                    diffTask_comm(2,j) = 8;
                elseif j > 31 && mod((j-5), 6) == 0
                    diffTask_comm(2,j) = 8;
                end
            end   
    end
end