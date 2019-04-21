function [resource_info, power_info] = read_resources_graph(file_name, cycle, num_tasks, num_resources)
    %% Author: Manqing Mao; mmao7@asu.edu
    %% It will return the matrix with resource_info for execution time except last two columns
    %% resource_info(:,end-1) represents the resource ID; 
    %% resource_info(:,end) represents total number of tasks executing on this resource. 
    %% The resource_info(i,j) means that how many cycles does task j works on resource i. 
    %% The power_info(i,j) means that how much power does task j consume on resource i. 
    %% "99999" means task j cannot be executed on resource i.
    
%     clear all;
%     
%     file_name = 'Resources for TG_4.txt';
%     cycle = 1;
%     num_tasks = 10;
%     num_resources = 3;
    
    fd = fopen(file_name);
    S = textscan(fd,'%s','delimiter','\n');
    size_S = size(S{1,1});
    num_row = size_S(1,1);
    i = 1;
    resourceID = 1;
    resource_info = ones(num_resources, num_tasks+2)*99999;
    power_info = ones(num_resources, num_tasks+2)*99999;
    % support eight different CPUs
    CPUaID = 10; % starts from 10
    CPUbID = 20; % starts from 20
    CPUcID = 30; % starts from 30
    CPUdID = 40; % starts from 40
    CPUeID = 50; % starts from 50
    CPUfID = 60; % starts from 60
    CPUgID = 70; % starts from 70
    CPUhID = 80; % starts from 80
    % support eight different ACCs
    ACCaID = 100; % starts from 100
    ACCbID = 110; % starts from 110
    ACCcID = 120; % starts from 120
    ACCdID = 130; % starts from 130
    ACCeID = 140; % starts from 140
    ACCfID = 150; % starts from 150
    ACCgID = 160; % starts from 160
    ACChID = 170; % starts from 170    
    % support eight different OTHERs
    OTHERaID = 200; % starts from 200
    OTHERbID = 210; % starts from 210
    OTHERcID = 220; % starts from 220
    OTHERdID = 230; % starts from 230
    OTHEReID = 240; % starts from 240
    OTHERfID = 250; % starts from 250
    OTHERgID = 260; % starts from 260
    OTHERhID = 270; % starts from 270    
    while (i <= num_row)
        if startsWith(S{1,1}(i,1),'add_new_resource')
            
            if startsWith(S{1,1}(i,1),'add_new_resource CPUa') || startsWith(S{1,1}(i,1),'add_new_resource MULTIPLIER')
                resource_info(resourceID, end-1) = CPUaID;    % add hardware ID
                CPUaID = CPUaID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUb')
                resource_info(resourceID, end-1) = CPUbID;    % add hardware ID
                CPUbID = CPUbID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUc')
                resource_info(resourceID, end-1) = CPUcID;    % add hardware ID
                CPUcID = CPUcID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUd')
                resource_info(resourceID, end-1) = CPUdID;    % add hardware ID
                CPUdID = CPUdID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUe')
                resource_info(resourceID, end-1) = CPUeID;    % add hardware ID
                CPUeID = CPUeID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUf')
                resource_info(resourceID, end-1) = CPUfID;    % add hardware ID
                CPUfID = CPUfID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUg')
                resource_info(resourceID, end-1) = CPUgID;    % add hardware ID
                CPUgID = CPUgID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource CPUh')
                resource_info(resourceID, end-1) = CPUhID;    % add hardware ID
                CPUhID = CPUhID + 1;                
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCa') || startsWith(S{1,1}(i,1),'add_new_resource ALU')
                resource_info(resourceID, end-1) = ACCaID;    % add hardware ID
                ACCaID = ACCaID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCb')
                resource_info(resourceID, end-1) = ACCbID;    % add hardware ID
                ACCbID = ACCbID + 1; 
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCc')
                resource_info(resourceID, end-1) = ACCcID;    % add hardware ID
                ACCcID = ACCcID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCd')
                resource_info(resourceID, end-1) = ACCdID;    % add hardware ID
                ACCdID = ACCdID + 1;     
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCe')
                resource_info(resourceID, end-1) = ACCeID;    % add hardware ID
                ACCeID = ACCeID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCf')
                resource_info(resourceID, end-1) = ACCfID;    % add hardware ID
                ACCfID = ACCfID + 1; 
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCg')
                resource_info(resourceID, end-1) = ACCgID;    % add hardware ID
                ACCgID = ACCgID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource ACCh')
                resource_info(resourceID, end-1) = ACChID;    % add hardware ID
                ACChID = ACChID + 1; 
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERa')
                resource_info(resourceID, end-1) = OTHERaID;    % add hardware ID
                OTHERaID = OTHERaID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERb')
                resource_info(resourceID, end-1) = OTHERbID;    % add hardware ID
                OTHERbID = OTHERbID + 1; 
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERc')
                resource_info(resourceID, end-1) = OTHERcID;    % add hardware ID
                OTHERcID = OTHERcID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERd')
                resource_info(resourceID, end-1) = OTHERdID;    % add hardware ID
                OTHERdID = OTHERdID + 1;     
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERe')
                resource_info(resourceID, end-1) = OTHEReID;    % add hardware ID
                OTHEReID = OTHEReID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERf')
                resource_info(resourceID, end-1) = OTHERfID;    % add hardware ID
                OTHERfID = OTHERfID + 1; 
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERg')
                resource_info(resourceID, end-1) = OTHERgID;    % add hardware ID
                OTHERgID = OTHERgID + 1;
            elseif startsWith(S{1,1}(i,1),'add_new_resource OTHERh')
                resource_info(resourceID, end-1) = OTHERhID;    % add hardware ID
                OTHERhID = OTHERhID + 1;   
            end
            temp_numtasks = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match'); 
            tasks = str2double([temp_numtasks{:}]);
            idx_tasks = tasks(1,end);                        % get the number of tasks, which excutes on this hardware
            resource_info(resourceID, end) = idx_tasks;      % add the number of tasks

            i = i + 1;                                    
            for idx = 1:idx_tasks                            % process next n rows to grab timing information (n=idx_tasks)
                temp_time = regexp(S{1,1}(i,1),'\d+(\.)?(\d+)?','match');
                time_info = str2double([temp_time{:}]); 
                
                resource_info(resourceID, time_info(1,1)) = ceil(time_info(1,2)/cycle);   % task MUST starts from 1.
                if size(time_info,2) < 3
                    disp('Power information is missing in the file !!!!!');
                else
                    power_info(resourceID, time_info(1,1)) = time_info(1,3);   % grab power info
                end
                i = i + 1;
            end
            resourceID = resourceID + 1;
         end
        i = i+1;
    end
    % keep consistent for last two columns 
    power_info(:, end-1:end) = resource_info(:, end-1:end);
end
