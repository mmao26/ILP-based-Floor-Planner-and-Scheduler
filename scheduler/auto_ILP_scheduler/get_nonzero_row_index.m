function [rowID_start, rowID_end]  = get_nonzero_row_index(matrix)
    rowID_start = -1;                % default = -1
    for rowID = 1:size(matrix, 1)    % starts from the last row
        if max(matrix(rowID,:)) > 0  % means all row is 0
            rowID_start = rowID;
            break
        end
    end
    
    rowID_end = -1;                   % default = -1
    for rowID = size(matrix, 1):-1:1  % starts from the last row
        if max(matrix(rowID,:)) > 0   % means all row is 0
            rowID_end = rowID;
            break
        end
    end
end