function get_footprint_fig(x, block_info, WIDTH, HEIGHT)
    %% Author Name: Manqing Mao
    %% Email: maomanqing@gmail.com or Manqing.Mao@asu.edu
    idx_x = 0;
    for blockID = 1:size(block_info, 2) 
        if block_info(2, blockID) == 1 % hard block
            w_i = block_info(3, blockID);
            h_i = block_info(4, blockID);
            
            idx_x = idx_x + 1;
            x_i = x(idx_x, 1);

            idx_x = idx_x + 1;
            y_i = x(idx_x, 1);
            
            idx_x = idx_x + 1;
            z_i = x(idx_x, 1);
            
            if z_i == 0  % not rotate
                rectangle('Position', [x_i y_i w_i h_i],'LineWidth',1);
                text_x = x_i + 0.5*w_i;
                text_y = y_i + 0.5*h_i;               
            else         % rotate 90 degree
                rectangle('Position', [x_i y_i h_i w_i],'LineWidth',1);
                text_x = x_i + 0.5*h_i;
                text_y = y_i + 0.5*w_i;                   
            end

            text(text_x, text_y, num2str(blockID),'Color','red', 'FontSize',14, 'FontWeight','bold');
            hold on;
        else % soft block
            A_i = block_info(5, blockID);
            
            idx_x = idx_x + 1;
            x_i = x(idx_x, 1);

            idx_x = idx_x + 1;
            y_i = x(idx_x, 1);
            
            idx_x = idx_x + 1;
            w_i = x(idx_x, 1);       
            
            h_i = ceil(A_i/w_i);
            
            rectangle('Position', [x_i y_i w_i h_i],'LineWidth',1);
            text_x = x_i + 0.5*w_i;
            text_y = y_i + 0.5*h_i;  
            text(text_x, text_y, num2str(blockID),'Color','red', 'FontSize',14, 'FontWeight','bold');
            hold on;            
        end
    end
    axis([0 WIDTH 0 HEIGHT]);
    ax = gca;
    ax.XRuler.Axle.LineWidth = 1.5;
    ax.YRuler.Axle.LineWidth = 1.5;
    set(gca,'fontsize',12, 'FontWeight','Bold');
    %xticks(linspace(0, WIDTH, WIDTH+20));
    %yticks(linspace(0, HEIGHT, HEIGHT+20));
    xlabel('Width (units)','FontName','Arial','FontWeight','Bold','FontSize',14);
    ylabel('Height (units)','FontName','Arial','FontWeight','Bold','FontSize',14);
    hold on;
end