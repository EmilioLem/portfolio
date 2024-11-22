clear all
close all
clc

% Número de datos
n = 100; 

% Generar puntos de datos

x = linspace(-10, 10, n); % 100 puntos en el intervalo [-10, 10]
y = 2*x.^3 - 3*x.^2 + 4*x - 5 + randn(1, n); % Generar datos de acuerdo a y = 2x^3 - 3x^2 + 4x - 5 con algo de ruido

% Ajuste de la cúbica y = ax^3 + bx^2 + cx + d

X = [x.^3; x.^2; x; ones(1, n)]'; % Matriz de diseño

% Aquí 'X' es n x 4 y 'y' es 1 x n, por lo que la transposición asegura que las dimensiones sean correctas

% Resolver el sistema de ecuaciones
coefficients = (X' * X) \ (X' * y'); % Resolver los coeficientes, 'y' debe ser una columna

% Coeficientes de la cúbica
a = coefficients(1);
b = coefficients(2);
c = coefficients(3);
d = coefficients(4);

% Mostrar la cúbica de ajuste
fprintf('La cúbica de ajuste es y = %.6fx^3 + %.6fx^2 + %.6fx + %.6f\n', a, b, c, d);

% Evaluar la función original
y_original = 2*x.^3 - 3*x.^2 + 4*x - 5;

% Graficar los puntos, la cúbica de ajuste y la función original
figure;
plot(x, y, 'o'); % Puntos de datos
hold on;
plot(x, a*x.^3 + b*x.^2 + c*x + d, '-'); % Cúbica de ajuste
hold off;
xlabel('x');
ylabel('y');
title('Ajuste por Mínimos Cuadrados (Cúbica)');


% Ajuste adicional para verificar visualmente
x_fit = linspace(min(x), max(x), 1000); % Valores de x para una línea suave
y_fit = a*x_fit.^3 + b*x_fit.^2 + c*x_fit + d; % Valores ajustados de y


hold on;
plot(x_fit, y_fit, '-r', 'LineWidth', 1.5); 
legend('Datos', 'Cúbica de ajuste', 'Cubica Original');
hold off;
