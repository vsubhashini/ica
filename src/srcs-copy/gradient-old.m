function [grad] = gradient(eta, Y, W)
%Gradient function, it gives the value by which W must be updated to get new W
% \del W = eta (I + (1-2Z)Y')W where
%	eta - learning rate
%	Z = sigmoid(Y)
%	W is the predicted matrix

delW = zeros(size(W));

Z = sigmoid(Y);
Id = eye(size(Y,1));
grad = eta * (Id + (1-2*Z)*Y') * W;

end
