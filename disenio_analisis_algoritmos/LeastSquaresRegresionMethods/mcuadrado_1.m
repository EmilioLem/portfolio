clear all
close all
clc

% Número de datos

n = 1000; 

% Generar puntos de datos
x = linspace(-10, 10, n); % 50 puntos en el intervalo [-10, 10]
y = (3) * x + randn(1, n); % Generar datos de acuerdo a y = 3x con algo de ruido

% Ajuste de la recta y = ax + b
sx = sum(x);
sy = sum(y);
sx2 = sum(x.^2);
sxy = sum(x .* y);

% Resolver el sistema de ecuaciones
a = (n * sxy - sx * sy) / (n * sx2 - sx^2);
b = (sy - a * sx) / n;

% Mostrar la recta de ajuste
fprintf('La recta de ajuste es y = %.6fx + %.6f\n', a, b);

% Graficar los puntos y la recta de ajuste
plot(x, y, 'o'); % Puntos de datos
hold on;
plot(x, a*x + b, '-'); % Recta de ajuste
hold off;
xlabel('x');
ylabel('y');
title('Ajuste por Mínimos Cuadrados (Lineal)');
legend('Datos', 'Recta de ajuste');
