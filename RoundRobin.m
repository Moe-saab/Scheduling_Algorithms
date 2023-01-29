% Define the time slice or quantum
quantum = 3;

% Create an array of processes with their arrival and burst times
processes = [1 0 5; 2 1 3; 3 2 8; 4 3 6];

% Initialize variables for current time, remaining time, and completion time
current_time = 0;
remaining_time = processes(:,3);
completion_time = zeros(size(processes, 1), 1);
waiting_time = zeros(size(processes, 1), 1);

% Initialize array to keep track of the time instants when a process is serviced
serviced_time = [];

% Loop until all processes have completed execution
while sum(remaining_time) > 0
    for i = 1:size(processes, 1)
        % Check if the process has arrived and has remaining execution time
        if processes(i,2) <= current_time && remaining_time(i) > 0
            % Check if the remaining time is less than the quantum
            if remaining_time(i) <= quantum
                current_time = current_time + remaining_time(i);
                remaining_time(i) = 0;
            else
                current_time = current_time + quantum;
                remaining_time(i) = remaining_time(i) - quantum;
            end
            % Update the completion time of the process
            if remaining_time(i) == 0
                completion_time(i) = current_time;
                waiting_time(i) = completion_time(i) - processes(i,3) - processes(i,2);
            end
            % Save the current time as the service time for the process
            serviced_time = [serviced_time; current_time];
        end
    end
end

% Print the completion time, waiting time, and serviced time of each process
disp('Process Completion Time:')
disp(completion_time)
disp('Process Waiting Time:')
disp(waiting_time)
disp('Process Serviced Time:')
disp(serviced_time)
