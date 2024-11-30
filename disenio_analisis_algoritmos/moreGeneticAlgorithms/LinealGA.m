%% Limpieza
clear;
clc;
close all;
addpath("D:\adobe\Trabajos semestre\DyA\Sorting");
tic
%% Valores
a = 2; b = 3;
x = 0:0.1:10;
y = a*x + b;

%% Hiperparámetros
P = 100; % Tamaño de la población
N = 2; % Número de variables (pendiente y ordenada al origen)
ul = 10; % Límite superior de búsqueda
ll = -10; % Límite inferior de búsqueda
num_generaciones = 20; % Número de generaciones
prob_mutacion = 0.1; % Probabilidad de mutación
n_seleccionados = round(0.7 * P); % Proporción de la población seleccionada

%% Función para crear población
function pob = crear_poblacion(P, N, ul, ll)
    pob = ll + rand(P, N) .* (ul - ll);
end

%% Función para calcular el MSE
function mse = calcular_mse(individuo, x, y)
    a = individuo(1);
    b = individuo(2);
    % x_vals = XY(:, 1);
    % y_reales = XY(:, 2);
    % y_estimados = individuo(1) * x_vals + individuo(2);
    y_estimado = a*x + b;
    mse = mean((y - y_estimado).^2);
end

%% Vectores
mse_historial_min = zeros(num_generaciones, 1);

% Tomando como referencia la función 2x + 3
% XY = [0 3; 1 5; 2 7];

% Crear la población inicial
poblacion = crear_poblacion(P, N, ul, ll);

for gen = 1:num_generaciones
    % Evaluar el MSE para cada individuo en la población
    mse_vals = zeros(P, 1);
    for i = 1:P
        individuo = poblacion(i, :);
        mse_vals(i) = calcular_mse(individuo, x, y); 
    end
    
    % Guardar el MSE mínimo de la generación
    mse_historial_min(gen) = min(mse_vals);
    
    % Ordenar individuos por su MSE (de menor a mayor)
    [~, indices_ordenados] = Heapsort(mse_vals);
    
    % Seleccionar los mejores 70% individuos como padres
    seleccionados = poblacion(indices_ordenados(1:n_seleccionados), :);
    
    % Crear una nueva población con los hijos de los mejores padres
    nueva_poblacion = zeros(P, N);
    for i = 1:n_seleccionados
        % Selección de padres (aleatoriamente dentro de los seleccionados)
        idx1 = randi(n_seleccionados);
        idx2 = randi(n_seleccionados);
        padre1 = seleccionados(idx1, :);
        padre2 = seleccionados(idx2, :);
        
        % Cruce (crossover)
        hijo = (padre1 + padre2) / 2;
        
        % Mutación
        if rand < prob_mutacion
            mutacion = (rand(1, N) - 0.5) * 2 .* (ul - ll);
            hijo = hijo + mutacion;
        end
        
        % Asegurarse de que el hijo esté dentro de los límites
        hijo = max(min(hijo, ul), ll);
        
        % Añadir el hijo a la nueva población
        nueva_poblacion(i, :) = hijo;
    end
    
    % Mantener a los mejores individuos (30% mejores)
    nueva_poblacion(n_seleccionados+1:end, :) = poblacion(indices_ordenados(1:P-n_seleccionados), :);
    
    % Reemplazo de la población
    poblacion = nueva_poblacion;

    % Mostrar la nueva población
    fprintf('Población en la generación %d:\n', gen);
    disp(poblacion);
end

disp('Población final después de 20 generaciones:');
disp(poblacion);
disp('Historial del MSE mínimo:');
disp(mse_historial_min);

% Gráfica del MSE mínimo a lo largo de las generaciones
figure;
plot(1:num_generaciones, mse_historial_min, '-o');
xlabel('Generación');
ylabel('MSE mínimo');
title('Evolución del MSE mínimo a lo largo de las generaciones');
grid on;
toc


