function printCorrs(corrMat)
% Prints the correlation matrix labelling the original source and recovered signal correlations.

numSrc=size(corrMat,1);

fprintf('\n ');
for i=1:numSrc,
	fprintf('\t rec-%d',i);
end;

for i=1:numSrc,
	fprintf('\n src-%d',i);
	for j=1:numSrc,
		fprintf(' %f ',corrMat(i,j));
	end;
end;
fprintf('\n');

for i=1:numSrc,
	[val, MI] = max(corrMat(i,:));
	fprintf('Source signal src-%d matches recovered signal rec-%d \n',i,MI);

end
