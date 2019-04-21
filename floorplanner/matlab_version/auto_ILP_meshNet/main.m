%% Author Name: Manqing Mao
%% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
clc;
clear all;
tic;

addpath('C:\Program Files\IBM\ILOG\CPLEX_Studio128\cplex\matlab\x64_win64');
num_slc = 4;
E_bit = 1;
TG_case = 66;
switch(TG_case) 
    case(51)
        % load all files from ILP schedule
        load('taskID_5C1J.mat', 'taskID');
        load('resourceID_5C1J.mat', 'new_resourceID');
        load('task_info_dep_5C1J.mat', 'task_info_dep');
        flag = 1;
    case(52)
        % load all files from ILP schedule
        load('taskID_5C2J.mat', 'taskID');
        load('resourceID_5C2J.mat', 'new_resourceID');
        load('task_info_dep_5C2J.mat', 'task_info_dep');
        flag = 2;
        
    case(66)
        % load all files from ILP schedule
        load('taskID_radar.mat', 'taskID');
        load('resourceID_radar.mat', 'new_resourceID');
        load('task_info_dep_radar.mat', 'task_info_dep');
        flag = 3;          
end
num_resource = size(unique(new_resourceID), 2) + num_slc;
index_matrix  = get_index_matrix(new_resourceID, num_slc);

comm_vol  = get_comm_vol(index_matrix, new_resourceID, num_resource, task_info_dep, taskID, flag);
disp(comm_vol);
[num_variables, num_eqn_Ecommu] = get_num_variables(index_matrix, comm_vol);
% set up equations
[Aeq, beq]  = get_Aeq_beq(index_matrix, num_variables);
[A, b] = get_A_b(index_matrix, comm_vol, E_bit, num_variables, num_eqn_Ecommu, num_slc);

% set up objective
f = zeros(num_variables, 1);
f(index_matrix(end,end)+1:end, 1) = 1;

lb = zeros(num_variables, 1);
ub = ones(num_variables, 1);
ub(index_matrix(end,end)+1:end, 1) = Inf;

sostype = [];
sosind = [];
soswt = [];
ctype = [];
for i = 1 : index_matrix(end,end)
    ctype = [ctype;'B'];
end
for i = index_matrix(end,end)+1 : num_variables
    ctype = [ctype;'I'];
end
ctype = ctype'; 
x = cplexmilp(f, A, b, Aeq, beq, sostype, sosind, soswt, lb, ub, ctype);
get_planner_fig(index_matrix, x, new_resourceID, num_slc);
total_commu_energy = sum(x(index_matrix(end,end)+1:end,1));
toc;
