% Define the number of processes and their weights
n = 50; % Number of processes
weights = randi([1,20],n,1)';  % Weights of each process
%weights = 10+ 3*randn(n,1)';
% Initialize other variables
current_time = 0;
rem_time = 10+ 3*randn(n,1)';
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

AveWaitingTime = sum(waiting_time)./n;



%%
subplot(411);
bar(1:n,weights);title("Burst times chosen from Gaussian Distribution");
xlabel("process number");ylabel("Burst time");
hold on;
plot(1:n,ones(1,n)*(sum(weights)/n),'--y','LineWidth',4);
legend("Burst times per process","Average Burst Time");
%%
subplot(412);
bar(1:n,waiting_time);title("Round Robin Waiting Time");
xlabel("process number"); ylabel("waiting time");
hold on;
plot(1:n,ones(1,n)*AveWaitingTime,'--r','LineWidth',4);
legend("waiting time per process","Average Waiting Time");
%%
subplot(413);
bar(1:n,turnaround_time);title("Round Robin Turnaround Time");
xlabel("process number"); ylabel("TurnAround time");
hold on;
plot(1:n,ones(1,n)*sum(turnaround_time)./n,'--g','LineWidth',4);
legend("TurnAround time per process","Average TurnAround Time");
%%
subplot(414);
Throughput = n/(sum(waiting_time)/3600);                        % throughput in process per minute
plot(1:n,ones(1,n)*Throughput,'-.m','LineWidth',4);
title("Throughput given in processes per hour");
xlabel("process number"); ylabel("Throughput per hour");