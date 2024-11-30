% Clear workspace, close all figures, and clear command window
clc; clear; close all;

% Problem parameters
target_values = [2.2, -3.1, -4.2]; % Expected values for coefficients a, b, c
x = 0:0.1:5; % Input values for x
y_real = target_values(1) * x.^2 + target_values(2) * x + target_values(3); % Calculate the expected y values
rng(42); % Set random seed for reproducibility

% Algorithm parameters
lower_bound = -5; % Minimum value for randomly generated coefficients
upper_bound = 5;  % Maximum value for randomly generated coefficients
max_iterations = 1e7; % Maximum number of attempts
error_threshold = 1e-2; % Acceptable error threshold (mean squared error)

% Initialization
best_fitness = inf; % Track the lowest error (fitness) found
best_individual = []; % Store the coefficients corresponding to the best fitness
iteration = 0; % Initialize iteration counter

% Main search loop
while best_fitness > error_threshold && iteration < max_iterations
    % Generate random candidate solution
    candidate = lower_bound + (upper_bound - lower_bound) * rand(1, 3);
    a = candidate(1); % Coefficient a
    b = candidate(2); % Coefficient b
    c = candidate(3); % Coefficient c

    % Calculate predicted y values using the candidate solution
    y_pred = a * x.^2 + b * x + c;

    % Calculate fitness (mean squared error)
    fitness = mean((y_pred - y_real).^2);

    % Update best solution if this one is better
    if fitness < best_fitness
        best_fitness = fitness;
        best_individual = candidate;
    end

    % Increment iteration counter
    iteration = iteration + 1;
end

% Display results
if best_fitness <= error_threshold
    fprintf('Solution found in %d iterations:\n', iteration);
    fprintf('a = %.4f, b = %.4f, c = %.4f\n', best_individual(1), best_individual(2), best_individual(3));
    fprintf('Fitness = %.10f\n', best_fitness);
else
    fprintf('No acceptable solution found in %d iterations.\n', iteration);
    fprintf('Best fitness found: %.10f\n', best_fitness);
end

