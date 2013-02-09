function [nextOffset] = addtoPlot(data, offsetBegin, label)
%Function to plot the sound signal data and add it to previous plot
% plot each signal, give it color and a label

numSources = size(data,1);
plotColors = 'rgbcmyk';
offsetBegin=offsetBegin+1;

for i=1:numSources,
	plot(data(i,:) + offsetBegin+(i*1.5), sprintf('%s',plotColors(i)));
	text(pi, offsetBegin+(i*1.5)+0.6, sprintf('%s-%d',label,i));
end;
 
nextOffset = offsetBegin+(numSources*1.5);
plot([0, size(data,2)],[nextOffset+1.5,nextOffset+1.5], 'k');

end
