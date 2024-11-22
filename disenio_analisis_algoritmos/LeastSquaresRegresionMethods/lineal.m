%% Limpieza
clear;
clc;
close all;

%% Datos
% Tomando como referencia la función 2x + 3
XY = [0 3; 1 5; 2 7];  % Datos proporcionados

%% Implementación de Mínimos Cuadrados

% Matriz de diseño (X)
% Añadimos una columna de unos para la ordenada al origen
X = [XY(:, 1), ones(size(XY, 1), 1)];

% Vector de valores reales (Y)
Y = XY(:, 2);

% Cálculo de los coeficientes de la recta usando la fórmula de mínimos cuadrados:
% beta = inv(X'*X)*X'*Y;
coeficientes = (X' * X) \ (X' * Y);

% La pendiente (m) y la ordenada al origen (b) resultantes
pendiente = coeficientes(1);
ordenada_origen = coeficientes(2);

% Mostrar los resultados
fprintf('Pendiente (m): %.4f\n', pendiente);
fprintf('Ordenada al origen (b): %.4f\n', ordenada_origen);

%% Visualización de los resultados

% Generar puntos para la línea estimada
x_vals = linspace(min(XY(:, 1)), max(XY(:, 1)), 100);
y_estimados = pendiente * x_vals + ordenada_origen;

% Gráfica de los datos originales y la línea ajustada
figure;
plot(XY(:, 1), XY(:, 2), 'ro', 'MarkerSize', 8, 'DisplayName', 'Datos Reales');
hold on;
plot(x_vals, y_estimados, 'b-', 'LineWidth', 2, 'DisplayName', 'Ajuste por Mínimos Cuadrados');
xlabel('X');
ylabel('Y');
legend;
title('Ajuste Lineal usando Mínimos Cuadrados');
grid on;
hold off;
