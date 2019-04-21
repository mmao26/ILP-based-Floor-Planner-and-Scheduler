function rightup_coordinate = get_rightup_coordinate(x, block_info)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    idx_x = 0;
    num_block = size(block_info, 2);
    rightup_coordinate = zeros(2, num_block);
    % get rightup corner coordinate for all blocks
    for blockID = 1:size(block_info, 2) 
        if block_info(2, blockID) == 1 % hard block
            w_i = block_info(3, blockID);
            h_i = block_info(4, blockID);
            
            idx_x = idx_x + 1;
            x_i = x(idx_x, 1);

            idx_x = idx_x + 1;
            y_i = x(idx_x, 1);
            
            idx_x = idx_x + 1;
            z_i = x(idx_x, 1);
            
            if z_i == 0  % not rotate
                rightup_coordinate(1, blockID) = x_i + w_i;
                rightup_coordinate(2, blockID) = y_i + h_i;               
            else         % rotate 90 degree
                rightup_coordinate(1, blockID) = x_i + h_i;
                rightup_coordinate(2, blockID) = y_i + w_i;                    
            end
        else
            A_i = block_info(5, blockID);
            
            idx_x = idx_x + 1;
            x_i = x(idx_x, 1);

            idx_x = idx_x + 1;
            y_i = x(idx_x, 1);
            
            idx_x = idx_x + 1;
            w_i = x(idx_x, 1);       
            
            h_i = A_i/w_i;
            
            rightup_coordinate(1, blockID) = x_i + w_i;
            rightup_coordinate(2, blockID) = y_i + h_i;   
        end
    end
    
    
end