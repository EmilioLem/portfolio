clear all
close all
clc
% Definimos la función
syms x;
f = input('Digite la función deseada (con variable x): ');

% Derivada de la función
df = diff(f);

% Punto inicial
x0 = input('Digite el valor inicial: ');

% Número máximo de iteraciones
max_iter = input('Digite el número de iteraciones: ');

% Tolerancia para la convergencia
tol = input('Digite el error máximo permitido: ');

% Iteración de Newton
for i = 1:max_iter
    x1 = x0 - subs(f, x0)/subs(df, x0);  % Aplicación del método de Newton
    
    % Verificación de la convergencia
    if abs(x1 - x0) < tol
        fprintf('Convergencia alcanzada en %d iteraciones.\n', i);
        break;
    end
    
    % Actualizar x0
    x0 = x1;
end

% Resultado
fprintf('La solución es x = %.6f\n', x1);
