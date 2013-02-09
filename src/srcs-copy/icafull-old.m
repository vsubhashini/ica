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
srcMat=sounds;  	% Takes too much time to run all 5
%srcMat=sounds(1:3,:);	% Take only 3 signals
%srcMat=sounds(2:4,:);	% Take only 3 signals
%srcMat=sounds(3:5,:);	% Take only 3 signals
%srcMat=[sounds(2,:); sounds(4,:); sounds(5,:)];

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
eta0 = eta;
T=10000;
num_iter=20000;

%Make some random guess of mix-matrix inverse
W = rand(size(A)) ./ 10;

for i=0:num_iter,
	Y = W*X;			% predict source matrix based on guessed mix matrix
	delW = gradient(eta, Y, W);	% gradient descent - shift by delta
	W = W + delW;			% update W
	eta = eta0 / (1 + (i/T));	% annealing - learning rate
	if(mod(i,1000)==0),
		fprintf('runs %d \n',i);
		W
	%	corrMat = correlations(srcMat,Y)
	%	%fflush(stdout);
	end;
end;

Y = W*X;				% predict source matrix based on guessed mix matrix

Y = (Y - min(min(Y))) ./ (max(max(Y)) - min(min(Y)));
%Y2=Y;
Y2 = Y .* 2.0;

% Display the obtained signals
%hold off;

%plot(0,0);
%xlabel('Time');
label='rec';
offSet = addtoPlot(Y2, offSet, label); 
%for i=1:numSrc,
%	plot(Y(i,:), sprintf('%s',plotColors(i)));
%	%print -dpng "recoveredImage1.png";
%	%fprintf('Check Plot. Press Enter to continue');
%	pause;
%end;
print -dpng 'all5recoveredImage.png';
hold off;

% Compute correlation matrix to see which signals match and how well.
corrMat = correlations(srcMat,Y);
checkfile='all5-checkfile.txt';
printCorrs(corrMat, checkfile);

save('all5recovered.mat', 'Y2', 'corrMat');
%Check sounds
%soundsc(Y2(1,:),11025);
fprintf('\n Recovered Source Signals. Press enter to continue.\n');
pause;


%% Run choosing all sources in a loop

%for s1=1:3,
%	for s2=s1+1:4,
%		for s3=s2+1:5,
%			fprintf('Running on sources %d %d %d', s1,s2,s3);
%			srcMat=[sounds(s1,:); sounds(s2,:); sounds(s3,:)];
%			filename = sprintf('t-4kAnnealrecover-srcs-%d%d%d',s1,s2,s3);
%			plot(0,0);
%			hold on;
%			xlabel('Time');
%			offSet=-1;
%			title(sprintf('Graphs (Sources %d %d %d)',s1,s2, s3));
%			label='src';
%			offSet = addtoPlot(srcMat, offSet, label); 
%			numSrc = size(srcMat,1);
%			A=rand(numSrc, numSrc);
%			X = A*srcMat;
%			label='mix';
%			offSet = addtoPlot(X, offSet, label); 
%			eta = 0.01;
%			T=1000;
%num_iter=500;
%			eta0 = eta;
%			num_iter=100000;
%			W = rand(size(A)) ./ 10;
%			for i=0:num_iter,
%				Y = W*X;			
%				delW = gradient(eta, Y, W);	
%				W = W + delW;			
%				eta = eta0 / (1 + (i/T));	% annealing - learning rate
%			end;
%			Y = W*X;				
%			Y = (Y - min(min(Y))) ./ (max(max(Y)) - min(min(Y)));
%			Y2 = Y .* 2.0;
%			label='rec';
%			offSet = addtoPlot(Y2, offSet, label); 
%			imagefile = [filename, '.png'];
%			print('-dpng',imagefile);
%			hold off;
%			corrMat = correlations(srcMat,Y);
%			textfile = [filename, '.txt'];
%			printCorrs(corrMat, textfile);
%			matrixname = [filename, '.mat'];
%			save(matrixname, 'Y2', 'corrMat');
%		end;
%	end;
%end;
			
