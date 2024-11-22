clear all
close all
clc

% Número de datos

n = 50; 

% Generar puntos de datos
x = linspace(-10, 10, n); % 50 puntos en el intervalo [-10, 10]
y = x.^2 + 2*x + 1 + randn(1, n); % Generar datos de acuerdo a y = x^2 + 2x + 1 con algo de ruido

% Ajuste de la parábola y = ax^2 + bx + c
X = [x.^2; x; ones(1, n)]'; % Matriz de diseño, cada fila es un punto, cada columna es un término
% Aquí 'X' es n x 3 y 'y' es 1 x n, por lo que la transposición asegura que las dimensiones sean correctas

% Resolver el sistema de ecuaciones
coefficients = (X' * X) \ (X' * y'); % Resolver los coeficientes, 'y' debe ser una columna

% Coeficientes de la parábola
a = coefficients(1);
b = coefficients(2);
c = coefficients(3);

% Mostrar la parábola de ajuste
fprintf('La parábola de ajuste es y = %.6fx^2 + %.6fx + %.6f\n', a, b, c);

% Graficar los puntos y la parábola de ajuste
plot(x, y, 'o'); % Puntos de datos
hold on;
plot(x, a*x.^2 + b*x + c, '-'); % Parábola de ajuste
hold off;
xlabel('x');
ylabel('y');
title('Ajuste por Mínimos Cuadrados (Cuadrática)');
legend('Datos', 'Parábola de ajuste');
