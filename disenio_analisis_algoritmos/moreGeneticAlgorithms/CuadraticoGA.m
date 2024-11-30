%% Limpieza
clear;
clc;
close all;

%% Hiperparámetros
a = 2.2; b = -3.1; c = -4.2;
x = 0:0.1:10;
y = a *x.^2 + b*x + c;

P = 100; % Tamaño de la población
N = 3; % Número de variables (pendiente y ordenada al origen)
ul = [5, -0.1, -0.1]; % Límite superior de búsqueda
ll = [0.1, -5, -5]; % Límite inferior de búsqueda
num_generaciones = 20; % Número de generaciones
prob_mutacion = 0.1; % Probabilidad de mutación
t_mutacion = 0.05;
n_seleccionados = round(0.7 * P); % 70% de la población seleccionada
t_natalidad = 0.5;

%% Función para crear población
function pob = crear_poblacion(P, N, ul, ll)
    pob = ll + rand(P, N) .* (ul - ll);
end

%% Función para calcular el MSE
function mse = MSE(individuo, x, y)
    a = individuo(1);
    b = individuo(2);
    c = individuo(3);
    y_estimada = a*x.^2 + b*x + c;
    mse = mean((y - y_estimada).^2);
end

%% Inicializar la población y almacenar el MSE promedio de cada generación
% Crear la población inicial
poblacion = crear_poblacion(P, N, ul, ll);
mse_historial_min = zeros(num_generaciones, 1);

for gen = 1:num_generaciones
    % Evaluar el MSE para cada individuo en la población
    mse_vals = zeros(P, 1);
    for i = 1:P
        individuo = poblacion(i, :);
        mse_vals(i) = MSE(individuo, x, y); 
    end
            
    % Calcular el fitness (recíproco del MSE para minimización)
    fitness = 1 ./ (mse_vals + eps); % Agregar eps para evitar división por cero

    % Escalado del fitness para evitar grandes variaciones
    fitness = fitness / max(fitness); % Normalizar los valores de fitness
    % fitness = 1 - (mse_vals / (max(mse_vals) + eps)); % Normalizar en un rango más controlado
           
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
        mask = rand(1, N) > t_natalidad;
        hijo = padre1;
        hijo(mask) = padre2(mask);
    
        % Mutación
        if rand < prob_mutacion
            mutacion = (rand(1, N) - 0.5) * 2 * t_mutacion .* (ul - ll); % Ajuste de magnitud de mutación
            % mutacion = (rand(1, N) - 0.5) * 2 * (ul - ll);
            % mutacion = (rand(1, N) - 0.5) * t_mutacion * (ul - ll); % Ajuste de magnitud de mutación
            hijo = hijo + mutacion;
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
    mse_historial_min(gen) = min(mse_vals);

    % Mostrar progreso
    fprintf('Generación %d, Mejor MSE: %.6f\n', gen, min(mse_vals));
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