%Use the mean-variance optimization model to generate an efficient frontier of the three assets
%SPDR S&P 500 ETF (SPY), iShares Core US Treasury Bond (GOVT), iShares MSCI Emerging Markets Mini Vol (EEMV),
%CME Group (CME), Broadridge Financial Solutions (BR), Cboe Global Markets (CBOE), Intercontinental Exchange (ICE)
%and Accenture (ACN)  

clc;
clear all;

%Objective Function's Coefficient
H = [0.001049006,-9.13e-05,0.000637574,0.000167142,0.000829194,0.000155484,0.000465748,0.001055922;
-9.13e-05,9.04e-05,5.04e-06,-5.65e-05,8.59e-05,4.90e-05,-9.54e-05,-2.48e-05;
0.000637574,5.04e-06,0.000979649,-0.000209242,0.000551047,-0.000120595,1.29e-05,0.0004995;
0.000167142,-5.65e-05,-0.000209242,0.001941622,0.00082004,0.001080395,0.000968508,0.000254312;
0.000829194,8.59e-05,0.000551047,0.00082004,0.002787938,0.000429,0.000565742,0.00117817;
0.000155484,4.90e-05,-0.000120595,0.001080395,0.000429,0.003380142,0.000744647,0.000272206;
0.000465748,-9.54e-05,1.29e-05,0.000968508,0.000565742,0.000744647,0.002011436,0.000801188;
0.001055922,-2.48e-05,0.0004995,0.000254312,0.00117817,0.000272206,0.000801188,0.002065123];

%Inequality Constraints
A=[];
b=[];

% Linear Term Coefficients
c=[]';

%Equality Constraints
Aeq=[0.008322946,0.002542663,0.002317918,0.014734132,0.017090435,0.011271019,0.013601989,0.014154253;
    1,1,1,1,1,1,1,1];

%Variable Bound
ub = [inf; inf; inf;inf;inf;inf;inf;inf;]; 
lb = zeros(8,1); % without short selling 

std=[];%To store STD
weights=[]; %To store weights

% Running Loop for different Expected Return of Portfolio
for r=[0.0039:0.000528:0.0171]
    beq = [r;1];
    
    %Calling quadprog library to optimize
    [x, fval] = quadprog(H, c, A, b, Aeq, beq, lb, ub);
    
    v= (x'*H*x ); 
    weights=[weights;x'];
    std=[std,sqrt(v)];

end

% Plotting Effiecient Frontier
plot(std,[0.0039:0.000528:0.0171])
ylim([0 0.018]);
xlabel('Risk(STD of portfolio)')
ylabel('Expected return of portfolio')
title('Efficient Frontier')

% Displaying Results
result=array2table([[0.0039:0.000528:0.0171]',weights,std'],...
    'VariableNames',{'Expected_Return_of_Portfolio','X1',...
    'X2','X3','X4','X5','X6','X7','X8','STD_of_Portfolio'})




