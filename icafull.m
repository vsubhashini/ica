% Machine Learning HomeWork 2 - Independent Component Analysis
% This puts together the ica algorithm

%%Init
clear; close all; clc

%%=========Load and Sample Visualization

% Load Matrices U and A; U is the original sound source, A is the mixing matrix
 
fprintf('Loading and Visualizing Sources ... \n')
load('icaTest.mat'); % Original signals stored in matrices U (3x40) and A(3x3)

plot(0,0);
hold on;
xlabel('Time');
ylabel('Frequency');
offSet=-1;
label="src";
offSet = addtoPlot(U, offSet, label); 

fprintf('\n Showing Original Source. Press enter to continue.\n');
pause;

%Mix and get X - mixed signals

X = A*U;
label="mix";
offSet = addtoPlot(X, offSet, label); 

fprintf('\n Showing Mixed Signals. Press enter to continue.\n');
pause;

eta = 0.01;
num_iter=100001;

%Make some random guess of mix-matrix inverse
W = rand(size(A));

for i=0:num_iter,
	Y = W*X;			% predict source matrix based on guessed mix matrix
	delW = gradient(eta, Y, W);	% gradient descent - shift by delta
	W = W + delW;			% update W
end;

Y = W*X;				% predict source matrix based on guessed mix matrix

% Display the obtained signals

label="rec";
offSet = addtoPlot(Y, offSet, label); 
hold off;

fprintf('\n Recovered Source Signals. Press enter to continue.\n');
pause;

