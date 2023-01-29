% Define the time slice or quantum
clear; clc;
quantum = 3;
% Create an array of processes with their arrival and burst times
n = 50;
processes = NaN(n,3); 
processes(:,1) = 1:n;   % 1st column for id's only
processes(:,3) = 10+ 3*randn(n,1)'; 
processes(:,2) =  [0:n-1]';

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



TurnAroundTime = completion_time - processes(:,2);
AveWaitingTime = sum(waiting_time)./n;

fprintf('Average waiting time: %f\n',AveWaitingTime);
fprintf('Average turn around time: %f\n',sum(TurnAroundTime)./n);
%%
subplot(411);
bar(1:n,processes(:,3));title("Burst times chosen from Gaussian Distribution");
xlabel("process number");ylabel("Burst time");
hold on;
plot(1:n,ones(1,n)*(sum(processes(:,3))/n),'--y','LineWidth',4);
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
bar(1:n,TurnAroundTime);title("Round Robin Turnaround Time");
xlabel("process number"); ylabel("TurnAround time");
hold on;
plot(1:n,ones(1,n)*sum(TurnAroundTime)./n,'--g','LineWidth',4);
legend("TurnAround time per process","Average TurnAround Time");
%%
subplot(414);
Throughput = n/(sum(waiting_time)/3600);                        % throughput in process per minute
plot(1:n,ones(1,n)*Throughput,'-.m','LineWidth',4);
title("Throughput given in processes per hour");
xlabel("process number"); ylabel("Throughput per hour");

