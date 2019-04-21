function [f, Aeq, beq, sostype, sosind, soswt, lb, ub, ctype] = set_up_cplex(A, indexMatrix_xyzw, indexMatrix_xyij, WIDTH, HEIGHT)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    num_variables = size(A, 2); 
    f = zeros(num_variables, 1);
    f(end,1) = 1;                   % objective function: Y
    
    min_idx_xyij = min(indexMatrix_xyij(2:end,1));
    max_idx_xyij = max(indexMatrix_xyij(1:end-1,end));
    
    Aeq = [];
    beq = [];
    sostype = [];
    sosind = [];
    soswt = [];
    ctype = [];
    lb = zeros(num_variables, 1);
    ub = zeros(num_variables, 1);
    
    % x_i, y_i and z_i/w_i
    for blockID = 1:size(indexMatrix_xyzw, 2)
        for idx_row = 3:5
            index = indexMatrix_xyzw(idx_row, blockID);
            if idx_row < 5     % x_i or y_i      
                ub(index, 1) = max(WIDTH, HEIGHT);
                ctype = [ctype;'I'];
            else
                if indexMatrix_xyzw(2, blockID) == 1 % hard
                    ub(index, 1) = 1;
                    ctype = [ctype;'B'];
                else   % soft
                    lb(index, 1) = 1;
                    ub(index, 1) = WIDTH;
                    ctype = [ctype;'I'];
                end
            end
        end
    end
    % x_ij, y_ij
    for index = min_idx_xyij : max_idx_xyij
        ub(index, 1) = 1;
        ctype = [ctype;'B'];
    end
    % Y
    lb(end, 1) = 1;
    ub(end, 1) = HEIGHT;
    ctype = [ctype;'I'];
    ctype = ctype'; 
end