function num_resource = get_num_resource(taskID, resource_information)        
    num_resource_cpu = 0;
    num_resource_acc = 0;
    num_resource_other = 0;
    for resourceID_row = 1 : size(resource_information, 1)
        if resource_information(resourceID_row, taskID) < 9999
            if resource_information(resourceID_row, end-1) >= 10 && resource_information(resourceID_row, end-1) < 100
                num_resource_cpu = 1;
            elseif resource_information(resourceID_row, end-1) >= 100 && resource_information(resourceID_row, end-1) < 200
                num_resource_acc = 1;
            elseif resource_information(resourceID_row, end-1) >= 200
                num_resource_other = 1;
            end
        end      
    end
    num_resource = num_resource_cpu + num_resource_acc + num_resource_other;
end