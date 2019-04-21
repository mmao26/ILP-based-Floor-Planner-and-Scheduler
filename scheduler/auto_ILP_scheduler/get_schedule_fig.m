function get_schedule_fig(taskID, resourceID, startTime, endTime)
    
    reg_height = 1;
    
    order_uniq_resourceID = unique(resourceID);
    num_resource = size(order_uniq_resourceID, 2);
    
    resource_index = zeros(2, num_resource);
    resource_index(1,:) = linspace(1, num_resource, num_resource);
    resource_index(2,:) = order_uniq_resourceID;

    for task_idx = 1 : size(taskID,2)
        % for each task
        task_id = taskID(1,task_idx);
        resource_id = resourceID(1,task_idx);
        start_time = startTime(1,task_idx);
        end_time = endTime(1,task_idx);
        
        [a, col_idx_comm] = find(resource_index(2,:) == resource_id);
        resource_ycoor = resource_index(1, col_idx_comm(1));

        leftcorder_x = start_time;
        leftcorder_y = resource_ycoor - 0.5*reg_height;
        reg_width = end_time - start_time + 1;
        
        rectangle('Position', [leftcorder_x leftcorder_y reg_width reg_height],'LineWidth',1);
        text_x = leftcorder_x + 0.35*reg_width;
        text_y = leftcorder_y + 0.5*reg_height;
        text(text_x, text_y, num2str(task_id),'Color','red', 'FontSize',14, 'FontWeight','bold');
        hold on;
    end
    
    axis([0 max(endTime(1,:))+3 0 6.5]);
    ax = gca;
    ax.XRuler.Axle.LineWidth = 1.5;
    
    ax.YRuler.Axle.LineWidth = 1.5;
    set(gca,'fontsize',12, 'FontWeight','Bold');
    yticks(linspace(0, num_resource+1, num_resource+2));
    xlabel('Time (Cycles)','FontName','Arial','FontWeight','Bold','FontSize',14);
    ylabel('Resource ID','FontName','Arial','FontWeight','Bold','FontSize',14);
    hold on;
    accID = 1;
    cpuID = 1;
    otherID = 1;
    text_y0 = 6.5;
    delta_coor = 0.15;
    for recsource_idx = 1 : size(resource_index,2)
        line([0,max(endTime(1,:))+1],[recsource_idx,recsource_idx],'Color','k','LineWidth',0.75, 'LineStyle','--')
        hold on;
        if resource_index(2,recsource_idx) >= 100 && resource_index(2,recsource_idx) < 200
            str = strcat('Resource #',num2str(recsource_idx),' represents ACC-', num2str(accID),'. (ID=', num2str(resource_index(2,recsource_idx)),') ');
            accID = accID + 1;
        elseif resource_index(2,recsource_idx) >= 10 && resource_index(2,recsource_idx) < 100
            str = strcat('Resource #',num2str(recsource_idx),' represents CPU-',num2str(cpuID),'. (ID=', num2str(resource_index(2,recsource_idx)),') ');
            cpuID = cpuID + 1;
        elseif resource_index(2,recsource_idx) >= 200
            str = strcat('Resource #',num2str(recsource_idx),' represents OTHER-',num2str(otherID),'. (ID=', num2str(resource_index(2,recsource_idx)),') ');
            otherID = otherID + 1;
        end
        text_x0 = max(endTime(1,:))*0.7;
        text_y0 = text_y0 - delta_coor;
        text(text_x0, text_y0, str,'Color','b', 'FontSize',10, 'FontWeight','bold');
        hold on;
    end
    
%     a=findobj(gcf);
%     allaxes=findall(a,'Type','axes');
%     alllines=findall(a,'Type','line');
%     alltext=findall(a,'Type','text');
% 
%     set(allaxes,'FontName','Arial','FontWeight','Bold','LineWidth',6,'FontSize',20);
%     set(alllines,'Linewidth',4);
%     set(alltext,'FontName','Arial','FontWeight','Bold','FontSize',20);
    
end