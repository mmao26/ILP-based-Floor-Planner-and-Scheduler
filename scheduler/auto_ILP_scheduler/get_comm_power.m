function [sameTask_comm_power, diffTask_comm_power]  = get_comm_power(task_info_dep, flag_taskgraph)
    sameTask_comm_power = zeros(size(task_info_dep,1), size(task_info_dep,2));
    diffTask_comm_power = zeros(size(task_info_dep,1), size(task_info_dep,2));
    sameTask_comm_power(1,:) = task_info_dep(1,:);
    diffTask_comm_power(1,:) = task_info_dep(1,:);
    switch(flag_taskgraph) 
        case(1)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm_power(i,j) = 99999;
                        diffTask_comm_power(i,j) = 99999;
                    else
                        sameTask_comm_power(i,j) = 0;
                        diffTask_comm_power(i,j) = 2;
                    end
                end
            end

        case(2)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm_power(i,j) = 99999;
                        diffTask_comm_power(i,j) = 99999;
                    else
                        sameTask_comm_power(i,j) = 1;
                        diffTask_comm_power(i,j) = 2;
                    end
                end
            end
        case(3)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm_power(i,j) = 99999;
                        diffTask_comm_power(i,j) = 99999;
                    else
                        sameTask_comm_power(i,j) = 1;
                        diffTask_comm_power(i,j) = 2;
                    end
                end
            end
        case(4)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm_power(i,j) = 99999;
                        diffTask_comm_power(i,j) = 99999;
                    else
                        sameTask_comm_power(i,j) = 1;
                        diffTask_comm_power(i,j) = 2;
                    end
                end
            end
        case(5)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm_power(i,j) = 99999;
                        diffTask_comm_power(i,j) = 99999;
                    else
                        sameTask_comm_power(i,j) = 0;
                        diffTask_comm_power(i,j) = 5;
                    end
                end
            end
        case(6)
            for i = 2:size(task_info_dep,1)
                for j = 1:size(task_info_dep,2)
                    if task_info_dep(i,j) > 999
                        sameTask_comm_power(i,j) = 99999;
                        diffTask_comm_power(i,j) = 99999;
                    else
                        sameTask_comm_power(i,j) = 0;
                        diffTask_comm_power(i,j) = 3;
                    end
                end
            end            
    end
end