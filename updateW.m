function [newW] = update(eta, Y, W)
%UPDATE gradient value W = W + delW

newW = zeros(size(W));
newW = W + gradient(eta, Y, W);

end
