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
%plot(U(1,:), 'r');
%plot(U(2,:)+1, 'g');
%plot(U(3,:)+2, 'b');
%text(pi, 1.7, "src-1");
%text(pi, 0.7, "src-2");
%text(pi, 2.7, "src-3");
%legend('src-1','src-2', 'src-3');
%hold off;

fprintf('\n Showing Original Source. Press enter to continue.\n');
pause;

%Mix and get X - mixed signals

X = A*U;
label="mix";
offSet = addtoPlot(X, offSet, label); 
%plot(X(1,:) + 4, 'm');
%plot(X(2,:) + 5, 'c');
%plot(X(3,:) + 6, 'k');
%text(pi, 4.7, "mix-1");
%text(pi, 5.7, "mix-2");
%text(pi, 6.7, "mix-3");
%legend('src-1','src-2', 'src-3', 'mix-1','mix-2', 'mix-3');

fprintf('\n Showing Mixed Signals. Press enter to continue.\n');
pause;

eta = 0.01;
num_iter=1000000;

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
%plot(Y(1,:) + 8, 'r');
%plot(Y(2,:) + 9, 'g');
%plot(Y(3,:) + 10, 'b');
%text(pi, 8.7, "rec-1");
%text(pi, 9.7, "rec-2");
%text(pi, 10.7, "rec-3");
%legend('Osrc-1','Osrc-2', 'Osrc-3', 'mix-1','mix-2', 'mix-3', 'rec-1','rec-2', 'rec-3');
hold off;

fprintf('\n Recovered Source Signals. Press enter to continue.\n');
pause;

