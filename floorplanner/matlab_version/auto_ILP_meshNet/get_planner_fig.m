function get_planner_fig(index_matrix, x_planner, resourceID, num_slc)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    Mapping = {'10','11','100','110','111','1000','2000','3000','4000','A53_1','A53_2','Enc_acc','FFT_acc1','FFT_acc2','SLC1','SLC2','SLC3','SLC4'};
    uniq_resources = unique(resourceID);
    num_resource = numel(uniq_resources) + num_slc;
    x_coor = ones(1,num_resource)*99;
    y_coor = ones(1,num_resource)*99;
    row_box = zeros(1,num_resource);
    leg = {};
    [index_x_set, a] = find(x_planner(:,1)>=0.9);  % default = number of rows
    % initialize
    idx_col = 0;
    for i = 1:numel(index_x_set)
        % planner
        if index_x_set(i) <= index_matrix(end,end)
            [row, col] = find(index_matrix(2:end,3:end) == index_x_set(i));
            idx_col = idx_col + 1;
            row_box(1, idx_col) = row+1;
            resource_id = index_matrix(1, col+2);
            x_coor(1, idx_col) = index_matrix(row+1, 1);
            y_coor(1, idx_col) = index_matrix(row+1, 2);
            if resource_id == 10
                str = strcat('A53_1:',' ID(',num2str(resource_id),')');
            elseif resource_id == 11
                str = strcat('A53_2:',' ID(',num2str(resource_id),')');
            elseif resource_id == 100
                str = strcat('Enc-Acc:',' ID(',num2str(resource_id),')');             
            elseif resource_id == 110
                str = strcat('FFT-Acc_1:',' ID(',num2str(resource_id),')');   
            elseif resource_id == 111
                str = strcat('FFT-Acc_2:',' ID(',num2str(resource_id),')');     
            elseif resource_id == 1000
                str = strcat('SLC_1:',' ID(',num2str(resource_id),')');     
            elseif resource_id == 2000
                str = strcat('SLC_2:',' ID(',num2str(resource_id),')');    
            elseif resource_id == 3000
                str = strcat('SLC_3:',' ID(',num2str(resource_id),')');     
            elseif resource_id == 4000
                str = strcat('SLC_4:',' ID(',num2str(resource_id),')');        
            end
            leg{end+1} = str;
%             leg{end+1} = num2str(resource_id);
        end

    end
    figure(1)
    CM = colorcube(num_resource);
    CM(end,:) = CM(end,:)*0.75;
    hold on
    for k1 = 1:num_resource
        if k1 > 1 && ismember(row_box(1,k1),row_box(1,1:k1-1))
            s = scatter(x_coor(1,k1)+0.1,y_coor(1,k1)+0.1, 100, 'filled', 'MarkerFaceColor', CM(k1,:));
        else
            s = scatter(x_coor(1,k1)-0.1,y_coor(1,k1)-0.1, 100, 'filled', 'MarkerFaceColor', CM(k1,:));
        end
    end
    xl = [-0.25, 3];
    yl = [-0.25, 3];
    plot(xl,ones(1,2)*yl(1), '-k',  ones(1,2)*xl(1), yl,'-k', 'LineWidth',1.5)  % Left & Lower Axes
    plot(xl,ones(1,2)*yl(2), '-k',  ones(1,2)*xl(2), yl,'-k', 'LineWidth',1.5)  % Right & Upper Axes

    legend(leg,'Location','NorthEastOutside');

    axis([-0.25 3.1 -0.25 3.1]);
    xticks([0 1 2 3]);
    yticks([0 1 2 3]);
    grid on;
    ax = gca;
    ax.XRuler.Axle.LineWidth = 1.5;
    ax.YRuler.Axle.LineWidth = 1.5;
   
    a = findobj(gcf);        
    allaxes = findall(a,'Type','axes');
    alllines = findall(a,'Type','line');
    set(allaxes,'FontName','Arial','FontWeight','Bold','LineWidth',2,'FontSize',18);
    set(alllines,'Linewidth',2);
    alltext = findall(a,'Type','text');
    set(allaxes,'FontName','Arial','FontWeight','Bold','LineWidth',2,'FontSize',15);
    ax.GridAlpha = 0.3;
    ax.GridLineStyle = '--';
    ax.GridColor = 'k';    
end