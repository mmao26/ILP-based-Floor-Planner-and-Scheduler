function [num_eqn_tmax, num_eqn_dep] = get_num_eqn_tmaxANDdep(resource_information, task_info_dep, taskID)
    % can only support two different type resources -- cpu, acc
    num_dep = sum(task_info_dep(2:end, taskID)<99);
    if num_dep == 0
        num_eqn_tmax = 1;
        num_eqn_dep = 0;
    else
        num_resource = get_num_resource(taskID, resource_information);
        num_eqn_tmax = num_dep * num_resource;
        num_eqn_dep = num_dep * num_resource;
    end
end