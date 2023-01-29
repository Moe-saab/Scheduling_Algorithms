% Define the number of processes and their weights
n = 50; % Number of processes
weights = randi([1,20],n,1)';  % Weights of each process

% Initialize other variables
current_time = 0;
rem_time = weights;
completion_time = zeros(1, n);
turnaround_time = zeros(1, n);
waiting_time = zeros(1, n);

% calculate total weight
total_weight = sum(weights);

% Loop until all processes are completed
while (1)
    done = true;
    for i = 1:n
        if (rem_time(i) > 0)
            done = false; % There is a process that is not completed
            % calculate time quantum for each process
            time_quantum = weights(i) * 3 / total_weight;
            if (rem_time(i) > time_quantum)
                current_time = current_time + time_quantum;
                rem_time(i) = rem_time(i) - time_quantum;
            else
                current_time = current_time + rem_time(i);
                waiting_time(i) = current_time - weights(i);
                rem_time(i) = 0;
                completion_time(i) = current_time;
                turnaround_time(i) = completion_time(i) - weights(i);
            end
        end
    end
    if (done == true)
        break;
    end
end

% Display results
% disp(completion_time);
% disp(turnaround_time);
disp(waiting_time);
