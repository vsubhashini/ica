function [nextOffset] = addtoPlot(data, offsetBegin, label)
%Function to plot the sound signal data and add it to previous plot
% plot each signal, give it color and a label

numSources = size(data,1);
plotColors = 'rgbcmyk';
offsetBegin++;

for i=1:numSources,
	plot(data(i,:) + offsetBegin+i, sprintf('%s',plotColors(i)));
	text(pi, offsetBegin+i+0.6, sprintf('%s-%d',label,i));
end;
 
nextOffset = offsetBegin+numSources;
end
