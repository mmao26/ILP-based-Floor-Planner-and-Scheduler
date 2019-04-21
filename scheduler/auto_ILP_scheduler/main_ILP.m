%% Author: Manqing Mao; mmao7@asu.edu
%% Preprocessing -- Read File
%% TODO: reduces the number of variables based on task dependency, ASAP ALAP
%% TODO: communication time
%% Requirement: 
%  (1) same type resource: (CPUa1, CPUa2); THE TOTALLY SAME -- same number
%  of tasks and same cycles
%  (2) different type resource: (CPUa1, CPUb1); (CPUa1, ACCa1);
%% TODO: Debug tag_ASAP_ALAP = 1; && TG_case = 5;
clc;
clear all;
tic;

addpath('C:\Program Files\IBM\ILOG\CPLEX_Studio128\cplex\matlab\x64_win64');

flag_cplex = 1;
performance_buget = 300;
energy_opti = 0;    % optimization for energy?
mix_energy_latency_obj = 1;

debug = 1;
BWmax = 100000;
tag_ASAP_ALAP = 1;
flag_com = 1;
bigConstant = 100000;
BigContant_power = 100000;
output_tag = 0;
TG_case = 6111;%option 75222 6522
switch(TG_case) 
    case(1)
        file_TG = 'Task_graph_1.txt';
        file_RG = 'Resources for TG_1.txt';
        flag_taskgraph = 1;
        Mdv = ones(1,5);
        num_row_dep = 3;
        num_resources = 3;
        cycle = 10;
        dep_depth = num_row_dep - 1;
    case(2)
        file_TG = 'Task_graph_2.txt';
        file_RG = 'Resources for TG_2.txt';
        flag_taskgraph = 2;
        Mdv = ones(1,5);
        num_row_dep = 3;
        num_resources = 3;
        cycle = 1;
        dep_depth = num_row_dep - 1;
    case(31)
        file_TG = 'Task_graph_3.txt';
        file_RG = 'Resources for TG_3.txt';
        flag_taskgraph = 3;
        Mdv = ones(1,11);
        num_row_dep = 5;
        num_resources = 2;
        cycle = 10;
        dep_depth = num_row_dep - 1;
    case(32)
        file_TG = 'Task_graph_3.txt';
        file_RG = 'Resources for TG_3_1.txt';
        flag_taskgraph = 3;
        Mdv = ones(1,11);
        num_row_dep = 5;
        num_resources = 1;
        cycle = 10;
        dep_depth = num_row_dep - 1;
    case(4)
        file_TG = 'Task_graph_4.txt';
        file_RG = 'Resources for TG_4.txt';
        flag_taskgraph = 4;
        Mdv = ones(1,10);
        num_row_dep = 5;
        num_resources = 3;
        cycle = 1;
        dep_depth = num_row_dep - 1;
    case(5)
        file_TG = 'Task_graph_5.txt';
        file_RG = 'Resources for TG_5.txt';
        flag_taskgraph = 5;
        Mdv = ones(1,10);
        num_row_dep = 5;
        num_resources = 3;
        cycle = 1;   
        dep_depth = num_row_dep - 1;
    case(53)
        file_TG = 'Task_graph_5_3.txt';
        file_RG = 'Resources for TG_5_3.txt';
        flag_taskgraph = 5;
        Mdv = ones(1,20);
        num_row_dep = 4;
        num_resources = 3;
        cycle = 2;   
        dep_depth = num_row_dep - 1;  
        performance_buget = 200; 
    case(6111) % TX chain
        file_TG = 'Task_graph_TX_1C1J.txt';
        file_RG = 'Resources for TG_TX_1C1J_1acc.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,6);   %%%
        num_row_dep = 5;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 200;   
        filename_task_info_dep = 'task_info_dep_1C1J.mat';
        filename_taskID = 'taskID_1C1J.mat';
        filename_resourceID = 'resourceID_1C1J.mat';
        
    case(6121) % TX chain
        file_TG = 'Task_graph_TX_1C2J.txt';
        file_RG = 'Resources for TG_TX_1C2J_1acc.txt';
        flag_taskgraph = 61;
        Mdv = ones(1,12);   %%%
        num_row_dep = 5;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300;  
    case(6122) % TX chain
        file_TG = 'Task_graph_TX_1C2J.txt';
        file_RG = 'Resources for TG_TX_1C2J_2a53.txt';
        flag_taskgraph = 61;
        Mdv = ones(1,12);   %%%
        num_row_dep = 5;
        num_resources = 4; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300;  

    case(6510) % TX chain
        file_TG = 'Task_graph_TX_5C1J.txt';
        file_RG = 'Resources for TG_TX_5C1J_1a53.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,26);   %%%
        num_row_dep = 5;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 250;
    case(6511) % TX chain
        file_TG = 'Task_graph_TX_5C1J.txt';
        file_RG = 'Resources for TG_TX_5C1J_1acc.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,26);   %%%
        num_row_dep = 5;
        num_resources = 4; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 200;
     case(6512) % TX chain
        file_TG = 'Task_graph_TX_5C1J.txt';
        file_RG = 'Resources for TG_TX_5C1J_2acc.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,26);   %%%
        num_row_dep = 5;
        num_resources = 5; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 200;
        filename_task_info_dep = 'task_info_dep_5C1J.mat';
        filename_taskID = 'taskID_5C1J.mat';
        filename_resourceID = 'resourceID_5C1J.mat';
        
     case(6522) % TX chain
        file_TG = 'Task_graph_TX_5C2J.txt';
        file_RG = 'Resources for TG_TX_5C2J_2acc.txt';
        flag_taskgraph = 62;
        Mdv = ones(1,52);   %%%
        num_row_dep = 5;
        num_resources = 5; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300;
        filename_task_info_dep = 'task_info_dep_5C2J.mat';
        filename_taskID = 'taskID_5C2J.mat';
        filename_resourceID = 'resourceID_5C2J.mat';
        
     case(651264) % TX chain
        file_TG = 'Task_graph_TX_5C1J_radar.txt';
        file_RG = 'Resources for TG_TX_5C1J_radar_2acc.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,26);   %%%
        num_row_dep = 5;
        num_resources = 5; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 200;
        filename_task_info_dep = 'task_info_dep_5C1J.mat';
        filename_taskID = 'taskID_5C1J.mat';
        filename_resourceID = 'resourceID_5C1J.mat';  

    case(666) % radar
        file_TG = 'Task_graph_radar.txt';
        file_RG = 'Resources for radar.txt';
        flag_taskgraph = 1;
        Mdv = ones(1,8);   %%%
        num_row_dep = 2;
        num_resources = 6; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 10;
        filename_task_info_dep = 'task_info_dep_radar.mat';
        filename_taskID = 'taskID_radar.mat';
        filename_resourceID = 'resourceID_radar.mat';  
        
    case(7111) % RX chain
        file_TG = 'Task_graph_RX_1C1J.txt';
        file_RG = 'Resources for TG_RX_1C1J.txt';
        flag_taskgraph = 7;
        Mdv = ones(1,7);   %%%
        num_row_dep = 6;
        num_resources = 2; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300;  

    case(7121) % RX chain
        file_TG = 'Task_graph_RX_1C2J.txt';
        file_RG = 'Resources for TG_RX_1C2J.txt';
        flag_taskgraph = 71;
        Mdv = ones(1,14);   %%%
        num_row_dep = 6;
        num_resources = 2; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300;         

    case(7122) % RX chain
        file_TG = 'Task_graph_RX_1C2J.txt';
        file_RG = 'Resources for TG_RX_1C2J_2a53.txt';
        flag_taskgraph = 71;
        Mdv = ones(1,14);   %%%
        num_row_dep = 6;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300; 
     case(7122) % RX chain
        file_TG = 'Task_graph_RX_1C2J.txt';
        file_RG = 'Resources for TG_RX_1C2J_2a53.txt';
        flag_taskgraph = 71;
        Mdv = ones(1,14);   %%%
        num_row_dep = 6;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 300; 
        
    case(7512) % RX chain
        file_TG = 'Task_graph_RX_5C1J.txt';
        file_RG = 'Resources for TG_RX_5C1J_2a53.txt';
        flag_taskgraph = 7;
        Mdv = ones(1,31);   %%%
        num_row_dep = 6;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 350;   
        
    case(75122) % RX chain
        file_TG = 'Task_graph_RX_5C1J.txt';
        file_RG = 'Resources for TG_RX_5C1J_2acc.txt';
        flag_taskgraph = 7;
        Mdv = ones(1,31);   %%%
        num_row_dep = 6;
        num_resources = 4; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 350;    
    case(75222) % RX chain
        file_TG = 'Task_graph_RX_5C2J.txt';
        file_RG = 'Resources for TG_RX_5C2J_2acc.txt';
        flag_taskgraph = 72;
        Mdv = ones(1,62);   %%%
        num_row_dep = 6;
        num_resources = 4; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 700; 
        
    case(71) % RX chain
        file_TG = 'Task_graph_RX_new_5pw.txt';
        file_RG = 'Resources for TG_RX1_5pw.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,31);   %%%
        num_row_dep = 6;
        num_resources = 3; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 350;
    case(72) % RX chain
        file_TG = 'Task_graph_RX_new_5pw.txt';
        file_RG = 'Resources for TG_RX2_5pw.txt';
        flag_taskgraph = 6;
        Mdv = ones(1,31);   %%%
        num_row_dep = 6;
        num_resources = 4; %%%
        cycle = 1;   
        dep_depth = num_row_dep - 1;      
        performance_buget = 350;         
end
[task_info_timing, task_info_dep, comm_vol] = read_task_graph(file_TG, num_row_dep);
save(filename_task_info_dep,'task_info_dep');
if performance_buget
    task_info_timing(end,:) = performance_buget;
end
[resource_information, power_information] = read_resources_graph(file_RG, cycle, size(task_info_timing,2), num_resources);

%% use ASAP ALAP to reduce the number of variables:
if tag_ASAP_ALAP
    reduced_task_timing_info = ASAP_ALAP(task_info_timing, task_info_dep, resource_information, dep_depth);
    task_info_timing = reduced_task_timing_info;
end

%% 

[sameTask_comm, diffTask_comm]  = get_comm_time(task_info_dep, comm_vol, flag_taskgraph);
[sameTask_comm_power, diffTask_comm_power]  = get_comm_power(task_info_dep, flag_taskgraph);

[num_variables, num_energy_variables] = cal_num_variables(task_info_timing, task_info_dep, resource_information, energy_opti);

index_matrix = get_index_matrix(task_info_timing, resource_information, size(task_info_timing,2));

if debug
    if max(index_matrix(:,end)) == num_variables - 1 - num_energy_variables
        disp(['num_variables consistent: ' num2str(num_variables)]);
    else
        disp('ERROR..num_variables');
    end
end

% Set up Aeq, beq  
[Aeq, beq]  = get_Aeq_beq(index_matrix, task_info_timing, num_variables);
% if energy_opti
%     [Aeq, beq]  = get_Aeq_beq_energy(Aeq, beq, num_variables, index_matrix, power_information);
% end

[A, b] = get_A_b_communication(flag_com, resource_information, index_matrix, task_info_timing, task_info_dep, num_variables, Mdv, BWmax, bigConstant, sameTask_comm, diffTask_comm);
%%%%%
if energy_opti  % optimization for energy?
    % Set up f (objective function) = tmax + E_exe + E + E
    f = zeros(num_variables, 1);
    if mix_energy_latency_obj                    % objective function: tmax + energy_total
        f(end-num_energy_variables:end, 1) = 1; 
    else
        f(end-num_energy_variables,1) = 1;       % objective function: tmax
    end
    [Aeq, beq]  = get_Aeq_beq_energy(Aeq, beq, num_variables, index_matrix, power_information);
    [A, b] = get_A_b_energy(A, b, num_energy_variables, index_matrix, task_info_dep, resource_information, sameTask_comm, diffTask_comm, sameTask_comm_power, diffTask_comm_power, BigContant_power);
    % Set up lower bound and upper bound
    lb = zeros(num_variables, 1);
    ub = ones(num_variables, 1);
    ub(end-num_energy_variables:end, 1) = Inf;
else
    % Set up f
    f = zeros(num_variables, 1);
    f(end,1) = 1;                   % objective function: tmax
    lb = zeros(num_variables, 1);
    ub = ones(num_variables, 1);
    ub(end,1) = Inf;
end
disp(size(A));


if flag_cplex   % use CPLEX package from IBM
    sostype = [];
    sosind = [];
    soswt = [];
    ctype = [];

    if energy_opti
        for i = 1:num_variables-num_energy_variables-1
            ctype = [ctype;'B'];
        end
        for i = 1 : num_energy_variables+1
            ctype = [ctype;'I'];
        end
    else
        for i = 1 : num_variables-1
            ctype = [ctype;'B'];
        end
        ctype = [ctype;'I'];
    end
    ctype = ctype'; 
    x = cplexmilp(f, A, b, Aeq, beq, sostype, sosind, soswt, lb, ub, ctype);
else
    % Set up integer for variables
    intcon = linspace(1, num_variables, num_variables);
    x = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub);
end

% get the scheduling
if energy_opti
    [taskID, resourceID, startTime, endTime]  = get_schedule(index_matrix, x(1:end-num_energy_variables,:), true);
else
    [taskID, resourceID, startTime, endTime]  = get_schedule(index_matrix, x, true);
end
total_latency = max(endTime(1,:));
new_resourceID = get_reschedule_resource(taskID, resourceID, startTime, endTime);
save(filename_taskID,'taskID');
save(filename_resourceID,'new_resourceID');
get_schedule_fig(taskID, new_resourceID, startTime, endTime);
disp(['Total Latency is: ' num2str(total_latency)]);
if energy_opti
    energy_total = get_total_energy(taskID, new_resourceID, startTime, endTime, power_information, task_info_dep, sameTask_comm, diffTask_comm, sameTask_comm_power, diffTask_comm_power);
    disp(['Total Energy is: ' num2str(energy_total)]);
end
disp(['num_variables: ' num2str(num_variables)]);
if output_tag
    output_matrix = get_output_file(taskID, new_resourceID, startTime, 1);
end
% utilization rate: have to debug
ur = get_ur(new_resourceID, startTime, endTime);

toc;