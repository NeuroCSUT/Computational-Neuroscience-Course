% Perceptron example adapted from Hinton's Coursera course:
% https://class.coursera.org/neuralnets-2012-001/quiz/attempt?quiz_id=69

% clear workspace and switch off paging in Octave
clear;
more off;

% use Gnuplot for plotting in Octave
%graphics_toolkit gnuplot;

% load the dataset
load ../data/dataset1; %TODO replace with dataset2 3 4
% plot the dataset:
% - blue crosses are positive examples (target = 1)
% - green circles are negative examples (target = 0)
plot_perceptron(data, targets);
disp('Press any key to continue');
pause;

% store number of samples and weights for convenience
% we need one additional weight for bias term
num_samples = size(data, 1);
num_weights = size(data, 2) + 1;

% add additional column of ones for bias term
X = [data ones(num_samples, 1)]
% initialize weights randomly from normal distribution
w = randn(num_weights, 1)
% targets stay the same
t = targets

% just long enough loop for most examples to converge
errors = [];
for k=1:20
    % plot data and classification boundary
    % - blue crosses are correctly classified positive samples
    % - red crosses are incorrectly classified positive samples
    % - green circles are correctly classified negative samples
    % - red circles are incorrectly classified negative samples
    % - black line shows decision boundary (not always visible!)
    plot_perceptron(X, t, w);

    % calculate activations - input multiplied by weights
    % NB! we calculate all samples at once using vectorized implementation!
    a = X * w;
    % apply threshold - result is either 0 or 1
    y = (a >= 0);

    % number of errors - where result didn't match target
    num_errors = sum(y ~= t);
    disp(['num_errors = ' num2str(num_errors) ' (press any key to continue)']);
    pause; %you can comment this out to not stop after every learning step

    % collect error history
    errors = [errors num_errors];
    % if there were no errors then stop
    if num_errors == 0 break; end

    % otherwise do the learning
    for i = 1:num_samples
        for j = 1:num_weights
            % TODO: fill in the perceptron learning rule! (adding learning rate is not needed)
            %w(j) = ...;
        end
    end
end

% plot error history
figure;
plot(errors);
title('Perceptron error history');
xlabel('Iteration');
ylabel('Number of errors');
xlim([1 20]);
ylim([1 20]);

% TODO: try datasets 1-4 and report which of them are linearly separable.
% Include final figure with decision boundary in your report. For linearly 
% separable datasets report also approximate number of steps to converge.
