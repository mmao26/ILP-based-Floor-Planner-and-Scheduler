function block_info = read_block_info(file_name, granularity)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    
    %% It will return the matrix with block_info for its property (hard or soft) and sizes information.
    %% The block_info(1,j) corresponds to block j. 
    %% The block_info(2,j) corresponds to the property for block j: 
       %  hard -- 1, width, height are available; soft -- 0, width, height are NA.  
    %% The block_info(3,j) corresponds to the width for block j. 
    %% The block_info(4,j) corresponds to the height for block j. 
    %% The block_info(5,j) corresponds to the area for block j. 
    %% "99999" means information is NA.
    
    num_info = 5; % col: block, soft/hard, w_i, h_i, A_i
    fd = fopen(file_name);
    S = textscan(fd,'%s','delimiter','\n');
    size_S = size(S{1,1});
    num_row = size_S(1,1);
    i = 1;
    blockID = 1;
    while (i <= num_row)
        if startsWith(S{1,1}(i,1),'num_blocks')
            temp_numblocks = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            num_blocks = str2double([temp_numblocks{:}]);
            % initialize
            block_info = ones(num_info, num_blocks)*99999;
            block_info(1,:) = linspace(1, num_blocks, num_blocks);
            
        elseif startsWith(S{1,1}(i,1),'block')
            % Grab the "soft block or hard block" info
            temp_block = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            temp_soft_hard = str2double([temp_block{:}]);
            block_info(2, blockID) = temp_soft_hard(1, end);
            i = i+1;
            % Grab the width, height, area info
            temp_size = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
            sizes_block = str2double([temp_size{:}]);
            if numel(sizes_block) > 3 % hard
                block_info(3,blockID) = sizes_block(1,end-2)/granularity;   
                block_info(4,blockID) = sizes_block(1,end-1)/granularity; 
            elseif numel(sizes_block) == 3 % soft with max width
                block_info(3,blockID) = sizes_block(1,end-1)/granularity; 
            else % < 3: soft without max width
                block_info(3,blockID) = sizes_block(1,end) /(granularity * granularity);  % area = width max
            end
            block_info(5,blockID) = sizes_block(1,end) /(granularity * granularity);    
            blockID = blockID + 1;
        end
        i = i+1;
    end
end
