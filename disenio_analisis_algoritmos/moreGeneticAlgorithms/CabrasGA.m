%% Limpieza
clear;
clc;
close all;
  
%% Valores
data = readmatrix("Datos.xlsx");
BTL = data(:, 7);
GSC = data(:, 9);
AC = data(:, 11);
W = data(:, 2); 
factor_conversion = 0.3937;

%% Hiperparámetros del Algoritmo Genético
P = 2000; % Tamaño de la población
N = 3; % Número de variables (a, b)
ul = [4, 2, 400]; % Límites superiores 
ll = [0.1, 0.1, 0.1]; % Límites inferiores
num_generaciones = 200; % Número de generaciones
prob_mutacion = 0.1; % Probabilidad de mutación
t_mutacion = 0.3;
n_seleccionados = round(0.7 * P); % 70% de la población seleccionada
t_natalidad = 0.5;

%% MSE
function mse = MSE(individuo, w_real, BTL, GSC, factor_conversion)
    a = individuo(1);
    b = individuo(2);
    c = individuo(3);

    % w = (a .* GSC .* BTL) / b;
    % w = ((BTL .* (pi / 3) .* ((AC.^2 + GSC.^2 + AC .* GSC)) ./ (4 * pi^2))) ./ b + a;
    w = ((GSC .* factor_conversion).^a .* (BTL .* factor_conversion).^b) ./ (2.2046 * c);

    mse = mean((w_real - w).^2);

end

%% Poblacion
function pob = crear_poblacion(P, N, ul, ll)
    pob = ll + rand(P, N) .* (ul - ll);
end

%% Simulación
    
% Crear la población inicial
poblacion = crear_poblacion(P, N, ul, ll);
best_mse = zeros(num_generaciones, 1);

for gen = 1:num_generaciones
    % Evaluar el MSE para cada individuo en la población
    mse_vals = zeros(P, 1);
    for i = 1:P
        individuo = poblacion(i, :);
        mse_vals(i) = MSE(individuo, W, BTL, GSC, factor_conversion); 
    end
            
    % Calcular el fitness (recíproco del MSE para minimización)
    fitness = 1 ./ (mse_vals + eps); % Agregar eps para evitar división por cero

    % Selección por ruleta
    total_fitness = sum(fitness);
    prob_acumulada = cumsum(fitness / total_fitness);
        
    % Seleccionar los padres probabilísticamente
    seleccionados = zeros(n_seleccionados, N);
    for i = 1:n_seleccionados
        r = rand;
        idx = find(prob_acumulada >= r, 1, 'first');
        seleccionados(i, :) = poblacion(idx, :);
    end
        
    % Crear la nueva población con los hijos de los padres seleccionados
    nueva_poblacion = zeros(P, N);
    for i = 1:n_seleccionados
        % Selección de padres aleatoria dentro de los seleccionados
        idx1 = randi(n_seleccionados);
        idx2 = randi(n_seleccionados);
        padre1 = seleccionados(idx1, :);
        padre2 = seleccionados(idx2, :);
        
        % Cruce uniforme
        mask = rand(1, N) < t_natalidad;
        hijo = padre1;
        hijo(mask) = padre2(mask);
    
        % Mutación
        if rand < prob_mutacion
            mutacion = (rand(1, N) - 0.5) * 2 .* t_mutacion .* (ul - ll);
            hijo = hijo + mutacion;
            hijo = max(min(hijo, ul), ll); % Asegurarse de que el hijo esté dentro de los límites
        end

    
        % Asegurarse de que el hijo esté dentro de los límites
        hijo = max(min(hijo, ul), ll);
        % hijo = max(hijo, [1e-6, 1e-6, 1e-6, 1e-6, 1e-6]); % Evitar valores extremadamente pequeños
    
        % Añadir el hijo a la nueva población
        nueva_poblacion(i, :) = hijo;
    end
        
    % Reemplazar el 70% inferior con los hijos
    [~, indices_ordenados] = sort(mse_vals);
    nueva_poblacion(n_seleccionados+1:end, :) = poblacion(indices_ordenados(1:P-n_seleccionados), :);
    
    % Reemplazo de la población
    poblacion = nueva_poblacion;
    
    % Guardar el MSE mínimo de la generación
    best_mse(gen) = min(mse_vals);

    % Mostrar progreso
    fprintf('Generación %d, Mejor MSE: %.6f\n', gen, min(mse_vals));
end

%% Mostrar resultados
disp('Población final:');
disp(poblacion);
    
% Gráfica del MSE mínimo a lo largo de las generaciones
figure;
plot(1:num_generaciones, best_mse, '-o');
xlabel('Generación');
ylabel('MSE mínimo');
title('Evolución del MSE mínimo a lo largo de las generaciones');
grid on;

[mejor_mse, mejor_idx] = min(mse_vals);
mejor_individuo = poblacion(mejor_idx, :);
a_mejor = mejor_individuo(1);
b_mejor = mejor_individuo(2);
c_mejor = mejor_individuo(3);

% Calcular los pesos calculados con los mejores valores de a y b
% w_calculado = (a_mejor .* GSC .* BTL) / b_mejor;
% w_calculado = (BTL .* (pi / 3) .* ((AC.^2 + GSC.^2 + AC .* GSC) ./ (4 * pi^2))) ./ b_mejor + a_mejor;
w_calculado = ((GSC .* factor_conversion).^a_mejor .* (BTL .* factor_conversion).^b_mejor) ./ (2.2046 * c_mejor);


% Comparar pesos reales vs calculados
figure;
plot(W, 'o-', 'DisplayName', 'Peso Real');
hold on;
plot(w_calculado, 'x-', 'DisplayName', 'Peso Calculado');
xlabel('Índice de Muestra');
ylabel('Peso');
title('Comparación de Pesos Reales y Calculados');
legend;
grid on;


