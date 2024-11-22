%% Limpieza
clear;
clc;
close all;

%% Puntos de datos (x, y)
XY = [0 0.85; 0.14234 0; 0.2 -0.3244]; % (x, y) puntos de datos
x_vals = XY(:, 1);
y_reales = XY(:, 2);

%% Ajuste por mínimos cuadrados
% Construir la matriz de diseño para el polinomio cúbico
X = [x_vals.^3, x_vals.^2, x_vals, ones(size(x_vals))];

% Resolver para los coeficientes (a, b, c, d)
coeficientes = (X \ y_reales)';

% Descomponer los coeficientes
a = coeficientes(1);
b = coeficientes(2);
c = coeficientes(3);
d = coeficientes(4);

% Mostrar los coeficientes obtenidos
disp('Coeficientes obtenidos por mínimos cuadrados:');
disp(['a = ', num2str(a)]);
disp(['b = ', num2str(b)]);
disp(['c = ', num2str(c)]);
disp(['d = ', num2str(d)]);

%% Graficar los datos reales y la curva ajustada

% Valores de x para la curva ajustada
x_fit = linspace(min(x_vals), max(x_vals), 100);

% Calcular los valores ajustados de y
y_fit = a * x_fit.^3 + b * x_fit.^2 + c * x_fit + d;

% Graficar los datos reales con marcadores
figure;
plot(x_vals, y_reales, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Datos Reales');
hold on;

% Graficar la curva ajustada
plot(x_fit, y_fit, 'b-', 'LineWidth', 2, 'DisplayName', 'Curva Ajustada');

% Configurar la gráfica
xlabel('x');
ylabel('y');
title('Datos Reales y Curva Ajustada');
legend;
grid on;

