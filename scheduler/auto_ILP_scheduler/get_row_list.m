function [row_list, granu_cur] = get_row_list(num_dep, num_resource, resource_pos, granu_prev)
    data = linspace(1, num_dep, num_dep);
    if num_resource == 1
        row_list = data;
        granu_cur = granu_prev;
    else
        row_list = zeros(1 , num_dep/num_resource);
        granu_cur = granu_prev / num_resource;
        i = 1;
        counter = 1;
        idx = 1;
        while (i <= num_dep) 
            if (mod(counter, num_resource) == resource_pos) || (mod(counter, num_resource) == 0 && resource_pos == num_resource)
                row_list(:, idx:idx+granu_cur-1) = linspace(i, i+granu_cur-1, granu_cur);
                idx = idx + granu_cur;
            end
            counter = counter + 1;
            i = i + granu_cur;
        end
    end
end