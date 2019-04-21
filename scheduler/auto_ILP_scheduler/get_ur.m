function ur = get_ur(new_resourceID, startTime, endTime)
    total_latency = max(endTime(1,:));
    resource_list = unique(new_resourceID);
    ur = zeros(3, numel(resource_list));
    ur(1, :) = resource_list;
    for i = 1:size(new_resourceID, 2)
        resourceID = new_resourceID(1, i);
        [a, col_idx] = find(ur(1,:) == resourceID);
        ur(2, col_idx(1)) = ur(2, col_idx(1)) + endTime(1, i) - startTime(1, i) + 1;
    end
    ur(3, :) = ur(2, :) / total_latency;
    disp(ur(1, :));
    disp(ur(3, :)*100);
end