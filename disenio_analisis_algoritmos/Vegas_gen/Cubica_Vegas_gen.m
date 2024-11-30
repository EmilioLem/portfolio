% Main function for solving a cubic regression problem using a genetic algorithm
function [best_individual, best_fitness] = las_vegas_genetic()

    % Problem parameters
    num_variables = 4; % Number of coefficients: a, b, c, d
    target_values = [-4.3, 3.2, -6.34, 0.85]; % Target coefficients for the cubic equation
    x = 0:0.1:10; % Input values for x
    y_real = target_values(1) * x.^3 + target_values(2) * x.^2 + target_values(3) * x + target_values(4); % Expected y values

    % Algorithm parameters
    lower_bound = -10; % Minimum value for coefficients
    upper_bound = 10;  % Maximum value for coefficients
    max_iterations = 17000; % Maximum number of iterations
    population_size = 100; % Number of solutions in each generation
    mutation_probability = 0.3; % Chance of mutation for offspring
    mutation_range = [-1.0, 1.0]; % Range of possible mutations

    % Initialize population with random solutions
    population = lower_bound + (upper_bound - lower_bound) * rand(population_size, num_variables);
    best_fitness = inf; % Track the best fitness (error) found
    best_individual = []; % Store the coefficients with the best fitness

    % Evolutionary loop
    for iteration = 1:max_iterations
        % Evaluate the fitness of the current population
        fitness_values = evaluate_population(population, x, y_real);

        % Find the best individual in the current population
        [min_fitness, min_index] = min(fitness_values);
        if min_fitness < best_fitness
            best_fitness = min_fitness;
            best_individual = population(min_index, :);
        end

        % Exit criteria: fitness threshold met
        if best_fitness < 1e-6
            break;
        end

        % Select the top 50% of individuals based on fitness
        [sorted_fitness, indices] = sort(fitness_values);
        selected_population = population(indices(1:round(0.5 * population_size)), :);

        % Generate new population through crossover and mutation
        new_population = selected_population;
        for i = 1:2:population_size
            parent1 = selected_population(randi(size(selected_population, 1)), :);
            parent2 = selected_population(randi(size(selected_population, 1)), :);
            child = (parent1 + parent2) / 2; % Average crossover
            if rand < mutation_probability
                child = child + mutation_range(1) + (mutation_range(2) - mutation_range(1)) * rand(1, num_variables);
            end
            new_population(i, :) = child;
        end

        % Update population for the next generation
        population = new_population;
    end

    % Output results
    if best_fitness >= 1e-6
        disp('Reached iteration limit without finding an optimal solution.');
    end
end

% Helper function to evaluate the fitness (mean squared error) of a population
function fitness_values = evaluate_population(population, x, y_real)
    population_size = size(population, 1);
    fitness_values = zeros(population_size, 1);
    for i = 1:population_size
        a = population(i, 1);
        b = population(i, 2);
        c = population(i, 3);
        d = population(i, 4);
        y_pred = a * x.^3 + b * x.^2 + c * x + d;
        fitness_values(i) = mean((y_pred - y_real).^2);
    end
end

