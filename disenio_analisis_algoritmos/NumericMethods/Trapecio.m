clear all
close all
clc

% Definir la función f(x)
f_str = input('Ingrese la funcion \nf(x) = ', 's');
f = str2func(['@(x) ' f_str]);

% Límites de integración
a = input('Digite el límite inferior a: ');
b = input('Digite el límite superior b: ');

% Número de intervalos
n = input('Digite el número de intervalos n: ');

% Paso de integración
h = (b - a) / n;

% Inicializar la suma con los extremos
integral = 0.5 * (f(a) + f(b));

% Sumar las contribuciones de los puntos intermedios
for i = 1:n-1
    x = a + i * h;
    integral = integral + f(x);
end

% Multiplicar por el paso de integración
integral = integral * h;

% Mostrar el resultado
fprintf('El valor aproximado de la integral es %.6f\n', integral);
