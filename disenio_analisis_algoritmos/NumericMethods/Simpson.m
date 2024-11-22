clear all;
clc;

% Definir la función f(x) como una cadena de texto y convertirla a función anónima
f_str = input('Ingrese la función \nf(x) = ', 's');
f = str2func(['@(x) ' f_str]);

% Límites de integración
a = input('Digite el límite inferior a: ');
b = input('Digite el límite superior b: ');

% Número de subintervalos (debe ser múltiplo de 3)
n = input('Digite el número de subintervalos (múltiplo de 3): ');

% Validación de n
if mod(n, 3) ~= 0
    error('El número de intervalos debe ser múltiplo de 3.');
end

% Paso de integración
h = (b - a) / n;

% Inicializar la suma
integral = f(a) + f(b);

% Sumar las contribuciones de los puntos intermedios
for i = 1:n-1
    x = a + i * h;
    if mod(i, 3) == 0
        integral = integral + 2 * f(x);
    else
        integral = integral + 3 * f(x);
    end
end

% Multiplicar por el factor de Simpson 3/8
integral = (3 * h / 8) * integral;

% Mostrar el resultado
fprintf('El valor aproximado de la integral es %.6f\n', integral);
