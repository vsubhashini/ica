function g= sigmoid(y)
% The sigmoid/logistic function
% g(y) = 1/(1 + e^{-y})
% Returns the sigmoid of y, where y can be a single value, vector or a matrix

g = zeros(size(y));
g = 1 ./ (1 + exp(-y));

end
