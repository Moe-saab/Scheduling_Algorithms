% SJF Non Preemptive
% For shortest job first the process with least burst time out of 
% the process that arrived should be executed.
% To do that I give each process a state of 1 or 0 depending if 
% it has arrived or not.
% Then I do sorting for all the processes not executed that arrived.
n  = 4;
% Create a matrix where:
% column 1 : arrival time
% column 2 : burst time
% column 3 : service time of shortest job =                                                                                                                                                                
% column 4 : waiting time 
% column 5 : 1 if already executed
P = NaN(n,5);
burstTimes = [5,3,8,6]%,4,4,4,4,4,4]';
arrivalTimes = [0,1,2,3]%,4,5,6,7,8,9]';

P(:,1) = arrivalTimes;
P(:,2) = burstTimes;

P(1,3) = 0;
P(1,4) = 0;
P(:,5) = zeros(n,1);
P(1,5) = 1;
last = 1 ;% id of last process executed  
next = 2;
ToBeSorted = [];
for i = 2:n
    %service time of next process to be executed = service time previous +
    %execution time of previous
    % But first lets find the next process id to be considered
    %     next = ??;                                                                                                                                                                                                                    
    for j = 2:n
        if(P(j,1)<=P(last,3)+P(last,2) && P(j,5)==0)    %if arrival time of a one of the processes
            %left is less than service time + execute time of latest executed process then
            % it should be considered for sorting
             ToBeSorted = horzcat(ToBeSorted,j); % vector of id's to be sorted
        end
    end
    % now sorting by least execution time
    next = ToBeSorted(1);
    for k = 1:length(ToBeSorted)
        if( P(ToBeSorted(k),2)<P(next,2)) % if burst time of process id (of the sorted ids) smaller make it next one for execution
            next = ToBeSorted(k);
       end
    end            
    P(next,3) = P(last,3) + P(last,2); % now %service time of next process to be executed = service time previous + execution time of previous
    % now waiting time of latest is service time - arrival time 
    P(next,4) = P(next,3) - P(next,1);
    P(next,5) = 1;
    last = next;
    ToBeSorted = [];
end
clc
P
AverageWaitingTime = sum(P(:,4))./n
    
    
