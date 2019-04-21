function index_matrix  = get_index_matrix(resourceID, num_slc)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    uniq_resourceID = unique(resourceID);
    %% index first row: x + y + resource ID + SLC ID (999)
    index_matrix = zeros(10, size(uniq_resourceID,2)+2+num_slc);
    index_matrix(1,3:end-num_slc) = uniq_resourceID;
    for i = 0:num_slc-1
        index_matrix(1,end-i) = (4-i)*1000;
    end
    index_matrix(1,1) = -1;
    index_matrix(1,2) = -2;
    % assign variable index
    for col = 3 : size(index_matrix,2)
        index_matrix(2:end,col) = linspace(1+(col-3)*9, (col-2)*9, 9);
    end
    % (0,0) (1,0) (0,1) (2,0) (1,1) (0,2) (2,1) (1,2) (2,2)
    index_matrix(2:end,1) = [0, 1, 0, 2, 1, 0, 2, 1, 2];   % x
    index_matrix(2:end,2) = [0, 0, 1, 0, 1, 2, 1, 2, 2];   % y
end