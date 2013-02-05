% Machine Learning HomeWork 2 - Independent Component Analysis
% This puts together the ica algorithm

%%Init
clear; close all; clc

%%=========Load and Sample Visualization

% Load Matrices U/srcMat and A; U is the original sound source, A is the mixing matrix
 
fprintf('Loading and Visualizing Sources ... \n')
load('icaTest.mat'); % Original signals stored in matrices U (3x40) and A(3x3)
load('sounds.mat'); % Original signals stored in sounds

srcMat=U;
%srcMat=sounds;  	% Takes too much time to run all 5
%srcMat=sounds(1:2,:);	% Take only 2 signals

plot(0,0);
hold on;
xlabel('Time');
%ylabel('Frequency');
offSet=-1;
label='src';
offSet = addtoPlot(srcMat, offSet, label); 

fprintf('\n Showing Original Source. Press enter to continue.\n');
%pause;

%Mix and get X - mixed signals

numSrc = size(srcMat,1);
A=rand(numSrc, numSrc);
%fprintf('\n Actual A.\n');
%A
X = A*srcMat;
label='mix';
offSet = addtoPlot(X, offSet, label); 

fprintf('\n Showing Mixed Signals. Press enter to continue.\n');
%pause;

eta = 0.01;
num_iter=100000;

%Make some random guess of mix-matrix inverse
W = rand(size(A));

for i=0:num_iter,
	Y = W*X;			% predict source matrix based on guessed mix matrix
	delW = gradient(eta, Y, W);	% gradient descent - shift by delta
	W = W + delW;			% update W
	%if(mod(i,1000)==0),
	%	fprintf('runs %d \n',i);
	%	corrMat = correlations(srcMat,Y);
	%	W
	%	fflush(stdout);
	%end;
end;

Y = W*X;				% predict source matrix based on guessed mix matrix

% Display the obtained signals

label='rec';
offSet = addtoPlot(Y, offSet, label); 
print -dpng "recoveredImage.png";
hold off;

% Compute correlation matrix to see which signals match and how well.
%corrMat = correlations(srcMat,Y);
%printCorrs(corrMat);

fprintf('\n Recovered Source Signals. Press enter to continue.\n');
pause;

