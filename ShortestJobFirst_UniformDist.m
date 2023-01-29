clear all; close all; clc;
n = 50;     %number of processes
burstTimes = [randi([1,20],n,1)]'; 
burstTimes = 10+ 3*randn(n,1)'; 
arrivalTimes = [0:n-1]';
P = NaN(n,6);       
P(:,1) = arrivalTimes;
P(:,2) = burstTimes;
P(1,3) = 0;
P(1,4) = 0;
P(:,5) = 0;
P(1,5) = 1;
P(1,6) = P(1,2) + P(1,4);
last = 1 ;
next = 2;
ToBeSorted = [];
for i = 2:n
    for j = 2:n
        if(P(j,1)<=P(last,3)+P(last,2) && P(j,5)==0)
            ToBeSorted = horzcat(ToBeSorted,j);
        end
    end
    next = ToBeSorted(1);
    for k = 1:length(ToBeSorted)
        if( P(ToBeSorted(k),2)<P(next,2))
            next = ToBeSorted(k);
        end
    end
    P(next,3) = P(last,3) + P(last,2);
    P(next,4) = P(next,3) - P(next,1);
    P(next,5) = 1;
    P(next,6) = P(next,2) + P(next,4);
    last = next;
    ToBeSorted = [];
end
%P = P(:,1:4)
figure(1);
subplot(411);
bar(1:n,P(:,2));title("Burst times chosen from Gaussian Distribution");
xlabel("process number"); ylabel("Burst time");
hold on;
plot(1:n,ones(1,n).*sum(P(:,2))/n,'--y',"LineWidth",4);
legend("Burst time per process in msec","Average Waiting Time");

subplot(412);
bar(1:n,P(:,4));title("Shortest Job First Waiting Time");
xlabel("process number"); ylabel("waiting time");
hold on;
plot(1:n,ones(1,n).*sum(P(:,4))/n,'--r','LineWidth',4);
legend("waiting time per process in msec","Average Waiting Time");

subplot(413);
bar(1:n,P(:,6));title("Shortest Job First TurnAround Time");
xlabel("process number"); ylabel("TurnAround time");
hold on;
plot(1:n,ones(1,n).*sum(P(:,6))/n,'--g',"LineWidth",4);
legend("TurnAround time per process in msec","Average TurnAround Time");

subplot(414);
Throughput = n/(sum(P(:,4))/3600);                        % throughput in process per minute
plot(1:n,ones(1,n)*Throughput,'-.m','LineWidth',4);
title("Throughput given in processes per hour");
xlabel("process number"); ylabel("Throughput per hour");
legend("Throughput *10^3");