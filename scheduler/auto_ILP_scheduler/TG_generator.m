times = 5;
piece_task = 5;
other_task = 1;
num_task = 2*(other_task + piece_task*times);
task_id = 1;
start_time = 0;
budget_time = 500;

TG_file = 'Task_graph_TX_new_5pw.txt';

fid = fopen(TG_file,'wt');
str = strcat('add_new_tasks\t',num2str(num_task));
fprintf(fid, str);
fprintf(fid,'\n');
while task_id <= num_task
    if (mod(task_id-other_task-1, piece_task) && task_id > 1) || (task_id == other_task+1)
        str = strcat('task_',num2str(task_id),'\t',num2str(task_id),'\t',num2str(task_id-1));
    else
        str = strcat('task_',num2str(task_id),'\t',num2str(task_id));
    end
    fprintf(fid, str);
    fprintf(fid,'\n');    

    str = strcat('task_',num2str(task_id),'\t', 'earliest_start\t', num2str(start_time), '\t','deadline\t', num2str(budget_time));
    fprintf(fid, str);
    fprintf(fid,'\n');
    task_id = task_id + 1;

end
fclose(fid);