function new_Aeq = get_Aeq_energy(Aeq)
    % just add one more column with all zero
    col_zero = zeros(size(Aeq,1),1);    
    new_Aeq = [Aeq col_zero];
end