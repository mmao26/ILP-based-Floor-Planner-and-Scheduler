function [indexMatrix_xyzw, indexMatrix_xyij] = get_index_matrices(block_info)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    
    %% The indexMatrix_xyzw(1,j) corresponds to blocks #.
    %% The indexMatrix_xyzw(2,j) corresponds to property for the block (hard:1, soft:1).
    %% The indexMatrix_xyzw(3,j) corresponds to indices for x_i. 
    %% The indexMatrix_xyzw(4,j) corresponds to indices for y_i.
    %% The indexMatrix_xyzw(5,j) corresponds to indices for z_i or w_i. 
    num_blocks = size(block_info, 2);
    idx = 1;
    num_info = 5;
    indexMatrix_xyzw = zeros(num_info, num_blocks);
    indexMatrix_xyzw(1:2,:) = block_info(1:2,:);
    indexMatrix_xyij = ones(num_blocks, num_blocks)*99999;
    % assign indices for x_i, y_i, z_i or w_i
    for j = 1:num_blocks
        for i = 3:num_info
            indexMatrix_xyzw(i, j) = idx;
            idx = idx + 1;
        end
    end
    % assign indices for x_ij
    for j = 1:num_blocks
        for i = j+1:num_blocks
            indexMatrix_xyij(i, j) = idx;
            idx = idx + 1;
        end
    end
    % assign indices for y_ij
    for i = 1:num_blocks
        for j = i+1:num_blocks
            indexMatrix_xyij(i, j) = idx;
            idx = idx + 1;
        end
    end
end