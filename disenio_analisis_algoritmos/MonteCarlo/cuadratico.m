clear all
close all
clc

% Número de datos y simulaciones
n = 100; % Número de puntos de datos
simulations = 1000; % Número de simulaciones

% Generar puntos de datos
x = linspace(-10, 10, n); % 100 puntos en el intervalo [-10, 10]
true_a = 3;
true_b = -2;
true_c = 1;
y = true_a*x.^2 + true_b*x + true_c + randn(1, n); % Datos con algo de ruido

% Inicializar arrays para almacenar resultados de las simulaciones
coefficients = zeros(simulations, 3);

for i = 1:simulations
    % Seleccionar un subconjunto aleatorio de datos
    indices = randi(n, [1, n]); % Índices aleatorios con reemplazo
    x_subset = x(indices);
    y_subset = y(indices);
    
    % Ajuste de la parábola y = ax^2 + bx + c
    X = [x_subset.^2; x_subset; ones(1, n)]'; % Matriz de diseño
    coeff = (X' * X) \ (X' * y_subset'); % Resolver los coeficientes
    
    % Guardar los coeficientes de la simulación
    coefficients(i, :) = coeff';
end

% Calcular medias de los coeficientes
mean_coeff = mean(coefficients);

% Mostrar la parábola de ajuste
fprintf('La parábola de ajuste promedio es y = %.6fx^2 + %.6fx + %.6f\n', mean_coeff(1), mean_coeff(2), mean_coeff(3));

% Graficar los puntos, la parábola de ajuste y la función original
figure;
plot(x, y, 'o'); % Puntos de datos
hold on;
x_fit = linspace(min(x), max(x), 1000); % Valores de x para una curva suave
y_fit = mean_coeff(1)*x_fit.^2 + mean_coeff(2)*x_fit + mean_coeff(3); % Parábola de ajuste
plot(x_fit, y_fit, '-r', 'LineWidth', 1.5); % Parábola de ajuste promedio

% Ajuste adicional para verificar visualmente
y_orig = true_a*x_fit.^2 + true_b*x_fit + true_c; % Valores ajustados de y
plot(x_fit, y_orig, '-b', 'LineWidth', 1.5); % Parábola original

xlabel('x');
ylabel('y');
title('Ajuste por Método de Monte Carlo (Cuadrática)');
legend('Datos', 'Parábola de ajuste promedio', 'Parábola original');
hold off;
