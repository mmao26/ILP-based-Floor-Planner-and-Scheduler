function [A, b]  = get_A_b(index_matrix, comm_vol, E_bit, num_variables, num_eqn_Ecommu, num_slc)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    A = zeros(2*size(index_matrix,1)-2+num_eqn_Ecommu, num_variables);
    b = zeros(2*size(index_matrix,1)-2+num_eqn_Ecommu, 1); 
    b(1:size(index_matrix,1)-1, 1) = 2; % two hardware per loc
    for idx_m_row = 2:size(index_matrix,1)
        for idx_m_col = 3:size(index_matrix, 2)
            index_content = index_matrix(idx_m_row, idx_m_col);
            if index_content > 0
                A(idx_m_row-1, index_content) = 1;
            end
        end
    end

    b(size(index_matrix,1):2*size(index_matrix,1)-2, 1) = 1; % one SLC per loc
    for idx_m_row = 2:size(index_matrix,1)
        for idx_m_col = size(index_matrix, 2)-num_slc+1:size(index_matrix, 2)
            index_content = index_matrix(idx_m_row, idx_m_col);
            if index_content > 0
                A(idx_m_row+size(index_matrix, 1)-2, index_content) = 1;
            end
        end
    end    
    
    
    idx_col_Ecommu = index_matrix(end,end);
    idx_row_A = 2*size(index_matrix,1)-2;
    % for communication part
    for i = 1:size(comm_vol,1)
        for j = 1:size(comm_vol,2)
            if comm_vol(i,j) > 0
                % compute Eij_x
                idx_row_A = idx_row_A + 1;
                A(idx_row_A,:) = get_commu_Eqn(index_matrix, i+2, j+2, comm_vol(i,j), E_bit, 1, num_variables);
                idx_col_Ecommu = idx_col_Ecommu + 1;
                A(idx_row_A, idx_col_Ecommu) = -1;
                idx_row_A = idx_row_A + 1;
                A(idx_row_A,:) = get_commu_Eqn(index_matrix, j+2, i+2, comm_vol(i,j), E_bit, 1, num_variables);
                A(idx_row_A, idx_col_Ecommu) = -1;   
                % compute Eij_y
                idx_row_A = idx_row_A + 1;
                A(idx_row_A,:) = get_commu_Eqn(index_matrix, i+2, j+2, comm_vol(i,j), E_bit, 2, num_variables);
                idx_col_Ecommu = idx_col_Ecommu + 1;
                A(idx_row_A, idx_col_Ecommu) = -1;
                idx_row_A = idx_row_A + 1;
                A(idx_row_A,:) = get_commu_Eqn(index_matrix, j+2, i+2, comm_vol(i,j), E_bit, 2, num_variables);
                A(idx_row_A, idx_col_Ecommu) = -1;                  
            end
        end
    end

    
    
end