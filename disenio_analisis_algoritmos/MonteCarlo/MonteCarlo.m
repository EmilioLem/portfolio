% Función para realizar la simulación de Montecarlo
function pi_estimado = estimar_pi(num_puntos)
    puntos_dentro_circulo = 0;

    for i = 1:num_puntos

        % Generar puntos aleatorios (x, y) en el rango [-1, 1]
        x}= rand*2 - 1; 
        y = rand*2 - 1; 

        % Verificar si el punto está dentro del círculo de radio 1

        if x^2 + y^2 <= 1
            puntos_dentro_circulo = puntos_dentro_circulo + 1;
        end
    end

    % Estimación de pi usando la proporción de puntos dentro del círculo

    pi_estimado = 4 * puntos_dentro_circulo / num_puntos;
end

% Parámetros de la simulación
num_puntos = 100000000;  % Número de puntos a generar

% Ejecución de la simulación
pi_estimado = estimar_pi(num_puntos);

% Mostrar el resultado
fprintf('Estimación de π con %d puntos: %.6f\n', num_puntos, pi_estimado);
%%

% Función que se quiere integrar
f = @(x) x.^2;

% Número de puntos para la simulación de Montecarlo
num_puntos = 1000000;

% Generar puntos aleatorios uniformemente distribuidos en [0, 1]
x_random = rand(1, num_puntos);

% Evaluar la función en los puntos aleatorios
f_random = f(x_random);

% Aproximar la integral como el promedio de los valores de f(x) multiplicado por el tamaño del intervalo
integral_aprox = mean(f_random) * 1; % El tamaño del intervalo es 1 - 0 = 1

% Mostrar el resultado
fprintf('Aproximación de la integral usando Montecarlo con %d puntos: %.6f\n', num_puntos, integral_aprox);

% Comparar con el valor exacto
integral_exacta = 1/3;
fprintf('Valor exacto de la integral: %.6f\n', integral_exacta);

%% 

% Montecarlo para algoritmo genético

%% Limpieza
clear;
clc;
close all;
