clear all
close all
clc

% Definir la EDO f(x, y)
f_str = input('Ingrese la función \nf(x) = ', 's');
f = str2func(['@(x) ' f_str]);

% Condiciones iniciales
x0 = input('Digite el valor inicial de x: ');
y0 = input('Digite el valor inicial de y: ');

% Punto donde se evalúa la solución
x_final = input('Digite el valor final de x: ');

% Número de pasos
n = input('Digite el número de pasos n: ');

% Paso de integración
h = (x_final - x0) / n;

% Inicializar la solución
x = x0;
y = y0;

% Implementar el método de Runge-Kutta de 4to orden
for i = 1:n
    k1 = h * f(x, y);
    k2 = h * f(x + 0.5*h, y + 0.5*k1);
    k3 = h * f(x + 0.5*h, y + 0.5*k2);
    k4 = h * f(x + h, y + k3);
    
    y = y + (k1 + 2*k2 + 2*k3 + k4) / 6;
    x = x + h;
end

% Mostrar el resultado
fprintf('El valor aproximado de y en x = %.6f es y = %.6f\n', x, y);
