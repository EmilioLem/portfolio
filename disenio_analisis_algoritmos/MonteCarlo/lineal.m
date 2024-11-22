clear all
close all
clc

% Número de datos y simulaciones
n = 3; % Número de puntos de datos
simulations = 1000; % Número de simulaciones

% Generar puntos de datos
x = linspace(-10, 10, n); % 100 puntos en el intervalo [-10, 10]
true_slope = 2;
true_intercept = 3;
y = true_slope * x + true_intercept + randn(1, n); % Datos con algo de ruido

% Inicializar arrays para almacenar resultados de las simulaciones
slopes = zeros(simulations, 1);
intercepts = zeros(simulations, 1);

for i = 1:simulations
    % Seleccionar un subconjunto aleatorio de datos
    indices = randperm(n, n); % Permutación aleatoria de índices
    x_subset = x(indices);
    y_subset = y(indices);
    
    % Ajuste de la recta y = ax + b
    X = [x_subset; ones(1, n)]'; % Matriz de diseño
    coefficients = (X' * X) \ (X' * y_subset'); % Resolver los coeficientes
    
    % Guardar los coeficientes de la simulación
    slopes(i) = coefficients(1);
    intercepts(i) = coefficients(2);
end

% Calcular medias y desviaciones estándar de los coeficientes
mean_slope = mean(slopes);
mean_intercept = mean(intercepts);

% Mostrar la recta de ajuste
fprintf('La recta de ajuste promedio es y = %.6fx + %.6f\n', mean_slope, mean_intercept);

% Graficar los puntos, la recta de ajuste y la función original
figure;
plot(x, y, 'o'); % Puntos de datos
hold on;
plot(x, mean_slope*x + mean_intercept, '-r', 'LineWidth', 1.5); % Recta de ajuste promedio

% Ajuste adicional para verificar visualmente
y_fit = true_slope * x + true_intercept; % Valores ajustados de y
plot(x, y_fit, '-b', 'LineWidth', 1.5); % Recta original

xlabel('x');
ylabel('y');
title('Ajuste por Método de Monte Carlo (Lineal)');
legend('Datos', 'Recta de ajuste promedio', 'Recta original');
hold off;
