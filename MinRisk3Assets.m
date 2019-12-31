
%Finding Minimum Risk Possible with the above three assets (Without Short Sell)

clc;
clear all;

%Objective Function's Coefficient
H = [0.001049006,-9.13e-05,0.000637574;
     -9.13e-05,9.04e-05,5.04e-06;
     0.000637574,5.04e-06,0.000979649];
 
%Expected Return of Assets 
m = [0.008322946,0.002542663,0.002317918];
 

%Inequality Constraints
A=[];
b=[];

% Linear Term Coefficients
c=[]';

%Equality Constraints
Aeq=[1,1,1];
beq = [1];

%Variable Bound
ub = [inf; inf; inf;]; 
lb = [0; 0;0]; % without short selling 

%Calling quadprog library to optimize
[x, fval2] = quadprog(H, c, A, b, Aeq, beq, lb, ub);

%Calculating Risk(std)
v=sqrt(x'*H*x);

%Calculating Return
r=m*x;

%Displaying Results
fprintf('Minimum Possible Risk of Portolio:');
disp(v)
fprintf('Return at Minimum Risk:')
disp(r)








    




