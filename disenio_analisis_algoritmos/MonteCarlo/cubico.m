clear all
close all
clc

% Número de datos y simulaciones
n = 100; % Número de puntos de datos
simulations = 1000; % Número de simulaciones

% Generar puntos de datos
x = linspace(-10, 10, n); % 5 puntos en el intervalo [-10, 10]
true_a = 2;
true_b = -3;
true_c = 4;
true_d = -5;
y = true_a*x.^3 + true_b*x.^2 + true_c*x + true_d + randn(1, n); % Datos con algo de ruido

% Inicializar arrays para almacenar resultados de las simulaciones
coefficients = zeros(simulations, 4);

for i = 1:simulations
    % Seleccionar un subconjunto aleatorio de datos
    indices = randperm(n); % Permutación aleatoria de índices
    x_subset = x(indices);
    y_subset = y(indices);
    
    % Ajuste de la cúbica y = ax^3 + bx^2 + cx + d
    X = [x_subset.^3; x_subset.^2; x_subset; ones(1, n)]'; % Matriz de diseño
    coeff = (X' * X) \ (X' * y_subset'); % Resolver los coeficientes
    
    % Guardar los coeficientes de la simulación
    coefficients(i, :) = coeff';
end

% Calcular medias y desviaciones estándar de los coeficientes
mean_coeff = mean(coefficients);

% Mostrar la cúbica de ajuste
fprintf('La cúbica de ajuste promedio es y = %.6fx^3 + %.6fx^2 + %.6fx + %.6f\n', mean_coeff(1), mean_coeff(2), mean_coeff(3), mean_coeff(4));

% Graficar los puntos, la cúbica de ajuste y la función original
figure;
plot(x, y, 'o'); % Puntos de datos
hold on;

% Evaluar la cúbica de ajuste sobre x_fit
x_fit = linspace(min(x), max(x), 2000); % Valores de x para una línea suave
y_fit = mean_coeff(1)*x_fit.^3 + mean_coeff(2)*x_fit.^2 + mean_coeff(3)*x_fit + mean_coeff(4); % Cúbica de ajuste

plot(x_fit, y_fit, '-r', 'LineWidth', 1.5); % Cúbica de ajuste promedio

% Ajuste adicional para verificar visualmente
y_orig = true_a*x_fit.^3 + true_b*x_fit.^2 + true_c*x_fit + true_d; % Valores ajustados de y
plot(x_fit, y_orig, '-b', 'LineWidth', 1.5); % Cúbica original

xlabel('x');
ylabel('y');
title('Ajuste por Método de Monte Carlo (Cúbica)');
legend('Datos', 'Cúbica de ajuste promedio', 'Cúbica original');
hold off;
