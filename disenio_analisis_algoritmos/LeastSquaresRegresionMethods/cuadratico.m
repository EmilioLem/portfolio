%% Limpieza
clear;
clc;
close all;

%% Datos
% Tomando como referencia la función cuadrática y = 2x^2 + 3x + 1
XY = [0 1; 1 6; 2 17]; % (x, y) puntos de datos

%% Implementación de Mínimos Cuadrados

% Matriz de diseño (X)
% Añadimos una columna de x^2, una de x y una de unos para los coeficientes a, b y c
X = [XY(:, 1).^2, XY(:, 1), ones(size(XY, 1), 1)];

% Vector de valores reales (Y)
Y = XY(:, 2);

% Cálculo de los coeficientes de la parábola usando la fórmula de mínimos cuadrados:
% coeficientes = inv(X'*X)*X'*Y;
coeficientes = (X' * X) \ (X' * Y);

% Los coeficientes a, b, c resultantes
a = coeficientes(1);
b = coeficientes(2);
c = coeficientes(3);

% Mostrar los resultados
fprintf('Coeficiente a: %.4f\n', a);
fprintf('Coeficiente b: %.4f\n', b);
fprintf('Coeficiente c: %.4f\n', c);

%% Visualización de los resultados

% Generar puntos para la curva estimada
x_vals = linspace(min(XY(:, 1)), max(XY(:, 1)), 100);
y_estimados = a * x_vals.^2 + b * x_vals + c;

% Gráfica de los datos originales y la curva ajustada
figure;
plot(XY(:, 1), XY(:, 2), 'ro', 'MarkerSize', 8, 'DisplayName', 'Datos Reales');
hold on;
plot(x_vals, y_estimados, 'b-', 'LineWidth', 2, 'DisplayName', 'Ajuste por Mínimos Cuadrados');
xlabel('X');
ylabel('Y');
legend;
title('Ajuste Cuadrático usando Mínimos Cuadrados');
grid on;
hold off;
