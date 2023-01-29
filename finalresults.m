Throughput_FCFS_Gaussian = 15.1306;
AvWaitingTime_FCFS_Gaussian = 237.928946;
AvTurnAroundTime_FCFS_Gaussian = 247.150886;

Throughput_FCFS_Uniform = 14.5231;
AvWaitingTime_FCFS_Uniform = 247.880000;
AvTurnAroundTime_FCFS_Uniform = 257.880000;
%%
Throughput_SJF_Gaussian = 19.9541;
AvWaitingTime_SJF_Gaussian = 180.4137;
AvTurnAroundTime_SJF_Gaussian =  190.2774;

Throughput_SJF_Uniform = 25.1924;
AvWaitingTime_SJF_Uniform =   142.9000;
AvTurnAroundTime_SJF_Uniform =   152.9600;
%%
Throughput_RR_Gaussian = 9.5345;
AvWaitingTime_RR_Gaussian = 377.575319;
AvTurnAroundTime_RR_Gaussian = 387.583083;

Throughput_RR_Uniform = 8.9897;
AvWaitingTime_RR_Uniform = 400.460000;
AvTurnAroundTime_RR_Uniform = 412.800000;
%%
Throughput_WRR_Gaussian = 12.5025;
AvWaitingTime_WRR_Gaussian = 287.9423;
AvTurnAroundTime_WRR_Gaussian = 287.9423;

Throughput_WRR_Uniform = 9.12;
AvWaitingTime_WRR_Uniform =   394.6557;
AvTurnAroundTime_WRR_Uniform =   394.6557;



figure(1);
X = categorical({'Throughput','Average Waiting Time','Average TurnAround Time'});
X = reordercats(X,{'Throughput','Average Waiting Time','Average TurnAround Time'});

data = [5*Throughput_FCFS_Gaussian 5*Throughput_SJF_Gaussian 5*Throughput_RR_Gaussian 5*Throughput_WRR_Gaussian ; 
    AvWaitingTime_FCFS_Gaussian AvWaitingTime_SJF_Gaussian AvWaitingTime_RR_Gaussian AvWaitingTime_WRR_Gaussian;
    AvTurnAroundTime_FCFS_Gaussian AvTurnAroundTime_SJF_Gaussian AvTurnAroundTime_RR_Gaussian AvTurnAroundTime_WRR_Gaussian];
bar(X,data);
title("Gaussian Distribution Results");
legend("FCFS","Shortest Job First","Round Robin","Weighted Round Robin");


figure(2);
X = categorical({'Throughput','Average Waiting Time','Average TurnAround Time'});
X = reordercats(X,{'Throughput','Average Waiting Time','Average TurnAround Time'});

data = [5*Throughput_FCFS_Uniform 5*Throughput_SJF_Uniform 5*Throughput_RR_Uniform 5*Throughput_WRR_Uniform; 
    AvWaitingTime_FCFS_Uniform AvWaitingTime_SJF_Uniform AvWaitingTime_RR_Uniform AvWaitingTime_WRR_Uniform;
    AvTurnAroundTime_FCFS_Uniform AvTurnAroundTime_SJF_Uniform AvTurnAroundTime_RR_Uniform AvTurnAroundTime_WRR_Uniform];
bar(X,data);
title("Uniform Distribution Results");
legend("FCFS","Shortest Job First","Round Robin","Weighted Round Robin");








