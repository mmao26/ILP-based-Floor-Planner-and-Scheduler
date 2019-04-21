%% Author Name: Manqing Mao
%% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu

clear all;
clc;
addpath('C:\Program Files\IBM\ILOG\CPLEX_Studio128\cplex\matlab\x64_win64');

BLK_case = 2;
switch(BLK_case) 
    %% only two hard blocks
    case(1)            
        granularity = 1;
        % decreases from 7, 6, 5, 4, 3, 2
        WIDTH = 2;                
        HEIGHT = 10;
        file_BLK = 'Block_info_1.txt';
    %% three hard blocks
    case(2)           
        granularity = 1;
        % decreases from 8, 7, 6, 5, 4, 3, 2
        WIDTH = 4;                
        HEIGHT = 10;
        file_BLK = 'Block_info_2.txt';
        
    %% one hard + one soft blocks
    case(3) 
        granularity = 1;
        % decreases from 10, 9, 8, 7, 6, 5, 4, 3, 2
        WIDTH = 2;                
        HEIGHT = 6;
        file_BLK = 'Block_info_3.txt';
    %% one soft + one hard blocks    
    case(4) 
        granularity = 1;
        % decreases from 10, 9, 8, 7, 6, 5, 4, 3, 2
        WIDTH = 4;                
        HEIGHT = 6;
        file_BLK = 'Block_info_4.txt';
    %% only two soft blocks
    case(5) 
        granularity = 1;
        % decreases from 10, 9, 8, 7, 6, 5, 4, 3, 2
        WIDTH = 3;                
        HEIGHT = 7;
        file_BLK = 'Block_info_5.txt';
    %% only two hard blocks + two soft blocks
    case(6) 
        granularity = 1;
        % decreases from 10, 9, 8, 7, 6, 5, 4, 3, 2
        WIDTH = 2;                
        HEIGHT = 10;
        file_BLK = 'Block_info_6.txt';
    case(7) 
        granularity = 1;
        % decreases from 10, 9, 8, 7, 6, 5, 4, 3, 2
        WIDTH = 80;                
        HEIGHT = 80;
        file_BLK = 'Config0_1.txt';
end

%% load block information
block_info = read_block_info(file_BLK, granularity);
% get two index matrices
[indexMatrix_xyzw,indexMatrix_xyij] = get_index_matrices(block_info);
% get A, b
[A, b] = get_A_b_fp(block_info, indexMatrix_xyzw, indexMatrix_xyij, WIDTH, HEIGHT);
% set up cplex
[f, Aeq, beq, sostype, sosind, soswt, lb, ub, ctype] = set_up_cplex(A, indexMatrix_xyzw, indexMatrix_xyij, WIDTH, HEIGHT);
% solve by cplex
x = cplexmilp(f, A, b, Aeq, beq, sostype, sosind, soswt, lb, ub, ctype);
% draw the solution
get_footprint_fig(x, block_info, WIDTH, HEIGHT);
% get the rightup coordinate, which will input to ILP scheduler
rightup_coordinate = get_rightup_coordinate(x, block_info);
