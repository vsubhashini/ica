function [corrMat] = correlations(original, myrec)
%Compute correlation between original signal and recovered signals
% Output matrix of correlation co-efficient of every pair of original and recovered signals.

numSrc = size(original,1);
corrMat = zeros(numSrc,numSrc);

for i=1:numSrc,
	for j=1:numSrc,
		corrMat(i,j) = corr2(original(i,:),myrec(j,:));
	end;
end;

end
