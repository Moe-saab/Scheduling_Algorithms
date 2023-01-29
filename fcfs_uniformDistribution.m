clear;clc;close all;

t1=0;
t2=0;
n=50;                    %no of processes
btime= [randi([1,20],n,1)]';    %burst time
btime2 = randi(n,1)';
wtime=zeros(1,n);       %waiting time
tatime=zeros(1,n);      %turn around time:  interval from the time of submission of a process to the time of the completion of the process
for i=2:1:n
   wtime(i)=btime(i-1)+wtime(i-1);  
   t1=t1+wtime(i);               
end
for i=1:1:n
    tatime(i)=btime(i)+wtime(i);   
    t2=t2+tatime(i);               
end
disp('Process                               Burst time                                  Waiting time                                  Turn Around time'); 
for i=1:1:n
    fprintf('P%d\t\t%d\t\t%d\t\t%d\n',(i),btime(i),wtime(i),tatime(i));
end
fprintf('Average waiting time: %f\n',(t1/n));
fprintf('Average turn around time: %f\n',(t2/n));
%%
subplot(411);
bar(1:n,btime);title("Burst times chosen from Uniform Distribution");
xlabel("process number");ylabel("Burst time");
hold on;
plot(1:n,ones(1,n)*(sum(btime)/n),'--y','LineWidth',4);
legend("Burst times per process in msec","Average Burst Time");
%%
subplot(412);
bar(1:n,wtime);title("First Come First Served Waiting Time");
xlabel("process number"); ylabel("waiting time");
hold on;
plot(1:n,ones(1,n)*t1/n,'--r','LineWidth',4);
legend("waiting time per process in msec","Average Waiting Time");
%%
subplot(413);
bar(1:n,tatime);title("First Come First Served Turnaround Time");
xlabel("process number"); ylabel("TurnAround time");
hold on;
plot(1:n,ones(1,n)*t2/n,'--g','LineWidth',4);
legend("TurnAround time per process in msec","Average TurnAround Time");
%%
subplot(414);
Throughput = n/(t1/3600);                        % throughput in process per minute
plot(1:n,ones(1,n)*Throughput,'-.m','LineWidth',4);
title("Throughput given in processes per hour");
xlabel("process number"); ylabel("Throughput per hour");
legend("Throughput *10^3");