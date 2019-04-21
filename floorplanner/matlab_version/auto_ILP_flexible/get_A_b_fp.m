function [A, b] = get_A_b_fp(block_info, indexMatrix_xyzw, indexMatrix_xyij, WIDTH, HEIGHT)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    num_variables = max(indexMatrix_xyij(1:end-1,end)) + 1;   
    num_blocks = size(block_info, 2);
    num_softblocks = sum(block_info(2,:)==0);
    num_row_Ab = 2 * num_blocks * num_blocks + num_softblocks;
    A = zeros(num_row_Ab, num_variables);
    b = zeros(num_row_Ab, 1);
    row_ptr = 0;
    M = max(WIDTH, HEIGHT);
    for blockID_i = 1:num_blocks
        property_Blocki = block_info(2, blockID_i);
        num_pair = num_blocks - blockID_i;
        
        if property_Blocki == 1 % hard block
            % coefficients 
            w_i = block_info(3, blockID_i);
            h_i = block_info(4, blockID_i);
            % indecies 
            idx_x_i = indexMatrix_xyzw(3, blockID_i);
            idx_y_i = indexMatrix_xyzw(4, blockID_i);
            idx_z_i = indexMatrix_xyzw(5, blockID_i);

            row_ptr = row_ptr + 1;
            % x_i + (h_i - w_i)*z_i <= WIDTH - w_i
            A(row_ptr, idx_x_i) = 1;
            A(row_ptr, idx_z_i) = h_i - w_i;
            b(row_ptr, 1) = WIDTH - w_i;

            row_ptr = row_ptr + 1;
            % y_i + (- h_i + w_i)*z_i - Y <= - h_i
            A(row_ptr, idx_y_i) = 1;
            A(row_ptr, idx_z_i) = - h_i + w_i;
            A(row_ptr, end) = -1;
            b(row_ptr, 1) = - h_i;  
            
        else % soft block   
            % coefficients 
            w_imax = block_info(3, blockID_i);
            A_i = block_info(5, blockID_i);
            c_i = A_i + 1;
            disp(c_i);            
            
            % indecies 
            idx_x_i = indexMatrix_xyzw(3, blockID_i);
            idx_y_i = indexMatrix_xyzw(4, blockID_i);
            idx_w_i = indexMatrix_xyzw(5, blockID_i);

            row_ptr = row_ptr + 1;
            % x_i + w_i <= WIDTH
            A(row_ptr, idx_x_i) = 1;
            A(row_ptr, idx_w_i) = 1;
            b(row_ptr, 1) = WIDTH;

            row_ptr = row_ptr + 1;
            % y_i - w_i - Y <= - c_i
            A(row_ptr, idx_y_i) = 1;
            A(row_ptr, idx_w_i) = -1;
            A(row_ptr, end) = -1;
            b(row_ptr, 1) = - c_i;  
            
            row_ptr = row_ptr + 1;
            % w_i <= w_imax            
            A(row_ptr, idx_w_i) = 1;
            b(row_ptr, 1) = w_imax;
        end        
        
       
        if num_pair > 0
            for pairID = 1:num_pair
                blockID_j = pairID + blockID_i;
                property_Blockj = block_info(2, blockID_j);
                
                if property_Blocki == 1 && property_Blockj == 1 % both blocks are hard
                    % coefficients 
                    w_i = block_info(3, blockID_i);
                    h_i = block_info(4, blockID_i);
                    w_j = block_info(3, blockID_j);
                    h_j = block_info(4, blockID_j);
                    % indecies 
                    idx_x_i = indexMatrix_xyzw(3, blockID_i);
                    idx_y_i = indexMatrix_xyzw(4, blockID_i);
                    idx_z_i = indexMatrix_xyzw(5, blockID_i);
                    idx_x_j = indexMatrix_xyzw(3, blockID_j);
                    idx_y_j = indexMatrix_xyzw(4, blockID_j);
                    idx_z_j = indexMatrix_xyzw(5, blockID_j);      
                    
                    idx_x_ij = indexMatrix_xyij(blockID_j, blockID_i);
                    idx_y_ij = indexMatrix_xyij(blockID_i, blockID_j);
                    
                    % list four non-overlapping constraints
                    row_ptr = row_ptr + 1;
                    % x_i - x_j + (h_i - w_i)*z_i - M*x_ij - M*y_ij <= - w_i
                    A(row_ptr, idx_x_i) = 1;
                    A(row_ptr, idx_x_j) = -1;
                    A(row_ptr, idx_z_i) = h_i - w_i;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = - w_i;                    
                    
                    row_ptr = row_ptr + 1;
                    % - x_i + x_j + (h_j - w_j)*z_j - M*x_ij + M*y_ij <= - w_j + M
                    A(row_ptr, idx_x_i) = -1;
                    A(row_ptr, idx_x_j) = 1;
                    A(row_ptr, idx_z_j) = h_j - w_j;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = - w_j + M;   
                    
                    row_ptr = row_ptr + 1;
                    % y_i - y_j + (-h_i + w_i)*z_i + M*x_ij - M*y_ij <= - h_i + M
                    A(row_ptr, idx_y_i) = 1;
                    A(row_ptr, idx_y_j) = -1;
                    A(row_ptr, idx_z_i) = -h_i + w_i;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = - h_i + M;  
                    
                    row_ptr = row_ptr + 1;
                    % -y_i + y_j + (-h_j + w_j)*z_j + M*x_ij + M*y_ij <= - h_j + 2*M
                    A(row_ptr, idx_y_i) = -1;
                    A(row_ptr, idx_y_j) = 1;
                    A(row_ptr, idx_z_j) = -h_j + w_j;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = - h_j + 2*M;            
                    
                elseif property_Blocki == 1 && property_Blockj == 0 % block i is hard; block j is soft; 
                    % coefficients 
                    w_i = block_info(3, blockID_i);
                    h_i = block_info(4, blockID_i);
                    A_j = block_info(5, blockID_j);
                    c_j = A_j + 1;

                    % indecies 
                    idx_x_i = indexMatrix_xyzw(3, blockID_i);
                    idx_y_i = indexMatrix_xyzw(4, blockID_i);
                    idx_z_i = indexMatrix_xyzw(5, blockID_i);
                    idx_x_j = indexMatrix_xyzw(3, blockID_j);
                    idx_y_j = indexMatrix_xyzw(4, blockID_j);
                    idx_w_j = indexMatrix_xyzw(5, blockID_j);      
                    
                    idx_x_ij = indexMatrix_xyij(blockID_j, blockID_i);
                    idx_y_ij = indexMatrix_xyij(blockID_i, blockID_j);
                    
                    % list four non-overlapping constraints                   
                    row_ptr = row_ptr + 1;
                    % x_i - x_j + (h_i - w_i)*z_i - M*x_ij - M*y_ij <= - w_i
                    A(row_ptr, idx_x_i) = 1;
                    A(row_ptr, idx_x_j) = -1;
                    A(row_ptr, idx_z_i) = h_i - w_i;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = - w_i; 
                    
                    row_ptr = row_ptr + 1;
                    % -x_i + x_j + w_j - M*x_ij + M*y_ij <= M
                    A(row_ptr, idx_x_i) = -1;
                    A(row_ptr, idx_x_j) = 1;
                    A(row_ptr, idx_w_j) = 1;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = M;    

                    row_ptr = row_ptr + 1;
                    % y_i - y_j + (-h_i + w_i)*z_i + M*x_ij - M*y_ij <= - h_i + M
                    A(row_ptr, idx_y_i) = 1;
                    A(row_ptr, idx_y_j) = -1;
                    A(row_ptr, idx_z_i) = -h_i + w_i;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = - h_i + M; 
                    
                    row_ptr = row_ptr + 1;
                    % -y_i + y_j - w_j + M*x_ij + M*y_ij <= - c_i + 2*M
                    A(row_ptr, idx_y_i) = -1;
                    A(row_ptr, idx_y_j) = 1;
                    A(row_ptr, idx_w_j) = -1;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = - c_j + 2*M; 

                    
                elseif property_Blocki == 0 && property_Blockj == 1 % block i is soft; block j is hard; 
                    % coefficients 
                    A_i = block_info(5, blockID_i);
                    c_i = A_i + 1;
                    w_j = block_info(3, blockID_j);
                    h_j = block_info(4, blockID_j);
    
                    % indecies 
                    idx_x_i = indexMatrix_xyzw(3, blockID_i);
                    idx_y_i = indexMatrix_xyzw(4, blockID_i);
                    idx_w_i = indexMatrix_xyzw(5, blockID_i);
                    idx_x_j = indexMatrix_xyzw(3, blockID_j);
                    idx_y_j = indexMatrix_xyzw(4, blockID_j);
                    idx_z_j = indexMatrix_xyzw(5, blockID_j); 
                    
                    idx_x_ij = indexMatrix_xyij(blockID_j, blockID_i);
                    idx_y_ij = indexMatrix_xyij(blockID_i, blockID_j);
                    
                    % list four non-overlapping constraints  
                    row_ptr = row_ptr + 1;
                    % x_i - x_j + w_i - M*x_ij - M*y_ij <= 0
                    A(row_ptr, idx_x_i) = 1;
                    A(row_ptr, idx_x_j) = -1;
                    A(row_ptr, idx_w_i) = 1;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = 0;                       
                    
                    row_ptr = row_ptr + 1;
                    % - x_i + x_j + (h_j - w_j)*z_j - M*x_ij + M*y_ij <= - w_j + M
                    A(row_ptr, idx_x_i) = -1;
                    A(row_ptr, idx_x_j) = 1;
                    A(row_ptr, idx_z_j) = h_j - w_j;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = - w_j + M;   

                    row_ptr = row_ptr + 1;
                    % y_i - y_j - w_i + M*x_ij - M*y_ij <= - c_i + M
                    A(row_ptr, idx_y_i) = 1;
                    A(row_ptr, idx_y_j) = -1;
                    A(row_ptr, idx_w_i) = -1;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = - c_i + M; 
                    
                    row_ptr = row_ptr + 1;
                    % -y_i + y_j + (-h_j + w_j)*z_j + M*x_ij + M*y_ij <= - h_j + 2*M
                    A(row_ptr, idx_y_i) = -1;
                    A(row_ptr, idx_y_j) = 1;
                    A(row_ptr, idx_z_j) = -h_j + w_j;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = - h_j + 2*M;     
                    
                else % both blocks are soft
                    % coefficients 
                    A_i = block_info(5, blockID_i);
                    c_i = A_i + 1;
                    A_j = block_info(5, blockID_j);
                    c_j = A_j + 1;
           
                    % indecies 
                    idx_x_i = indexMatrix_xyzw(3, blockID_i);
                    idx_y_i = indexMatrix_xyzw(4, blockID_i);
                    idx_w_i = indexMatrix_xyzw(5, blockID_i);
                    idx_x_j = indexMatrix_xyzw(3, blockID_j);
                    idx_y_j = indexMatrix_xyzw(4, blockID_j);
                    idx_w_j = indexMatrix_xyzw(5, blockID_j);
                    
                    idx_x_ij = indexMatrix_xyij(blockID_j, blockID_i);
                    idx_y_ij = indexMatrix_xyij(blockID_i, blockID_j);  
                    
                    row_ptr = row_ptr + 1;
                    % x_i - x_j + w_i - M*x_ij - M*y_ij <= 0
                    A(row_ptr, idx_x_i) = 1;
                    A(row_ptr, idx_x_j) = -1;
                    A(row_ptr, idx_w_i) = 1;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = 0;  

                    row_ptr = row_ptr + 1;
                    % -x_i + x_j + w_j - M*x_ij + M*y_ij <= M
                    A(row_ptr, idx_x_i) = -1;
                    A(row_ptr, idx_x_j) = 1;
                    A(row_ptr, idx_w_j) = 1;
                    A(row_ptr, idx_x_ij) = -M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = M;       

                    row_ptr = row_ptr + 1;
                    % y_i - y_j - w_i + M*x_ij - M*y_ij <= - c_i + M
                    A(row_ptr, idx_y_i) = 1;
                    A(row_ptr, idx_y_j) = -1;
                    A(row_ptr, idx_w_i) = -1;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = -M;
                    b(row_ptr, 1) = - c_i + M; 
                    
                    row_ptr = row_ptr + 1;
                    % -y_i + y_j - w_j + M*x_ij + M*y_ij <= - c_j + 2*M
                    A(row_ptr, idx_y_i) = -1;
                    A(row_ptr, idx_y_j) = 1;
                    A(row_ptr, idx_w_j) = -1;
                    A(row_ptr, idx_x_ij) = M;
                    A(row_ptr, idx_y_ij) = M;
                    b(row_ptr, 1) = - c_j + 2*M;                  
                end
                
            end
        end
        
        
    end
end