%Finding Maximum Return Possible with the above three assets (Without Short Sell)

clc;
clear all;

%Objective Function's Coefficient
f = [0.008322946,0.002542663,0.002317918].*(-1);

%Covariances
H = [0.001049006,-9.13e-05,0.000637574;
     -9.13e-05,9.04e-05,5.04e-06;
     0.000637574,5.04e-06,0.000979649];
 
%Inequality Constraints
A=[];
b=[];


%Equality Constraints
Aeq=[1,1,1];
beq = [1];

%Variable Bound
ub = [inf; inf; inf;]; 
lb = [0; 0;0]; % without short selling 

%Calling quadprog library to optimize
[x,val]=linprog(f,A,b,Aeq,beq,lb,ub);

%Calculating Risk
risk = sqrt(x'*H*x);

%Displaying Results
fprintf('Maximum Possible Return:');
disp(-val)
fprintf('Risk at Max Return:')
disp(risk)
 





    




