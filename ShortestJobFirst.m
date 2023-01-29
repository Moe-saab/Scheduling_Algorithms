n=50;				%no of processes
%ptime=[3 1 3 2 ];   %process time or burst time
btime = randi([1,20],n,1)';
%process=[1 2 3 4];  %process id
process = [1:n];
wtime=zeros(1,n);   %waiting time
tatime=zeros(1,n);  %turn around time
total=0;			%total waiting time
total2=0;           %total turn around time

for i=1:1:n-1   %sorting the processes in terms of process times
   for j=i+1:1:n
       if(btime(i)>btime(j))
           temp=btime(i);
           btime(i) = btime(j);
           btime(j) = temp;
           temp = process(i);
           process(i) = process(j);
           process(j) = temp;
       end
   end
end
 wtime(1) = 0;
 for i=2:1:n
    wtime(i) = wtime(i-1)+btime(i-1);   %wait time of a process is sum of wait time of process before it and process time of process before it
    total = total + wtime(i);           %finding total waiting time
end
for i=1:1:n
    tatime(i)=btime(i)+wtime(i);    %turn around time=burst time +wait time
    total2=total2+tatime(i);                %total turn around time
end
        avg = total/n;                          %finding average time
        avg1 = total2/n;
        fprintf('P_ID\tP_TIME\tW_TIME\tTA_TIME\n');      %display of final values
        for i=1:1:n
            fprintf('%d\t\t%d\t\t%d\t\t%d\n',process(i),btime(i),wtime(i),tatime(i));
            %fprintf('waiting time is:''%d',wtime(i));
        end
fprintf('Total Waiting Time:%d\n',total);
fprintf('Average Waiting Time:%f\n',avg);
fprintf('Total Turn Around Time:%d\n',total2);
fprintf('Average Turn Around Time:%f\n',avg1);




%%
subplot(411);
bar(1:n,btime);title("Burst times chosen from Gaussian Distribution");
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