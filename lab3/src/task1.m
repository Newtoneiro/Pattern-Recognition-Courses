% YOUR CODE GOES HERE - testing of the perceptron function

% 1. Preparation of the function to compute separation plane parameters given a training set 
% containing just two classes - perceptron. The easiest way to accomplish it is to use 
% two-dimensional data sets , which can be visualized together with the separating plane

% Call the perceptron function to get the separating plane
[sepplane, mispos, misneg] = perceptron(pclass, nclass);

% Plot the separating line
plot(tenzeros(:,1), tenzeros(:,2), "r*", tenones(:,1), tenones(:,2), "bs")
hold on
x_vals = [-1, 1];
y_vals = (-sepplane(2) * x_vals - sepplane(1)) / sepplane(3);
plot(x_vals, y_vals, 'k-', 'LineWidth', 2)