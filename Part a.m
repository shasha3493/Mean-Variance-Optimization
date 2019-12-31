%Use the mean-variance optimization model to generate an efficient 
%frontier of the three assets SPDR S&P 500 ETF (SPY), iShares Core US Treasury Bond (GOVT)
%and iShares MSCI Emerging Markets Mini Vol (EEMV). 

clc;
clear all;

%Objective Function's Coefficient
H = [0.001049006,-9.13e-05,0.000637574;
     -9.13e-05,9.04e-05,5.04e-06;
     0.000637574,5.04e-06,0.000979649];

%Inequality Constraints
A=[];
b=[];

% Linear Term Coefficients
c=[]';

%Equality Constraints
Aeq=[0.008322946, 0.002542663, 0.002317918;
    1,1,1];

%Variable Bound
ub = [inf; inf; inf;]; 
lb = [0; 0;0]; % without short selling 


std=[]; %To store std deviations
weights=[] %To store weights

% Running Loop for different Expected Return of Portfolio
for r=[0.0033:0.0002:0.0083]
    
    beq = [r;1]; 
    
    %Calling quadprog library to optimize
    [x, fval2] = quadprog(H, c, A, b, Aeq, beq, lb, ub);
    v= (x'*H*x ); 
    weights=[weights;x'];
    std=[std,sqrt(v)];
end

% Plotting Effiecient Frontier
plot(std,[0.0033:0.0002:0.0083]);
ylim([0 0.009]);
xlabel('Risk(STD of portfolio)')
ylabel('Expected return of portfolio')
title('Efficient Frontier')

% Displaying Results
result=array2table([[0.0033:0.0002:0.0083]',weights,std'],...
    'VariableNames',{'Expected_Return_of_Portfolio','X1','X2','X3','STD_of_Portfolio'})






    




