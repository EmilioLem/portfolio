%% Limpieza
clear;
clc;
close all;

% addpath("C:\Users\adobe\OneDrive\Escritorio\Trabajos semestre\DyA");

tic
%% Valores
load("motorD.mat");
I = out.intensidad;  % Corriente real del motor
W = out.v_angular;   % Velocidad angular real del motor
t = out.tout;        % Tiempos
    
%% Hiperparámetros del Algoritmo Genético
P = 3000; % Tamaño de la población
N = 5; % Número de variables (R, K, L, J, b)
% ul = [5, 0.1, 0.5, 0.00001, 0.001]; % Límites superiores 
% ll = [0.01, 0.005, 0.00001, 0.0000001, 0.00001]; % Límites inferiores
ul = [5, 0.1, 0.5, 0.009, 0.001]; % Límites superiores 
ll = [0.01, 0.005, 0.00001, 0.0001, 0.00001]; % Límites inferiores
num_generaciones = 100; % Número de generaciones
prob_mutacion = 0.1; % Probabilidad de mutación
t_mutacion = 0.05;
n_seleccionados = round(0.7 * P); % 70% de la población seleccionada
t_natalidad = 0.5;
    
%% Función para crear población
function pob = crear_poblacion(P, N, ul, ll)
    pob = ll + rand(P, N) .* (ul - ll);
end
    
%% Función de estado del motor
function dydt = motorDC(params, y, t)
    R = params(1);
    K = params(2);
    L = params(3);
    J = params(4);
    b = params(5);
    if t <= 0.5
        V = 0; % Sin voltaje hasta los 0.5 segundos
    else
        V = 10.5; % Voltaje aplicado después de 0.5 segundos
    end
    i = y(1);
    w = y(2);
        
    di_dt = (V - R*i - K*w) / L;
    dw_dt = (K*i - b*w) / J;
        
    dydt = [di_dt; dw_dt];
end
    
%% Función para calcular el MSE del modelo del motor
function mse = MSE(params, I_real, W_real, tspan)
    % Condiciones iniciales
    y0 = [0; 0]; % Corriente y velocidad angular iniciales
            
    % Datos en estado estacionario
    vss = 10.5; % Voltaje aplicado en estado estacionario
    Iss = mean(I_real(end-5:end)); % Promedio de la corriente en el estado estacionario
    wss = mean(W_real(end-5:end)); % Promedio de la velocidad en el estado estacionario

    % Usar la constante del motor (K) para calcular R y B en estado estacionario
    K = params(2); % Suponiendo que el segundo parámetro es K
    R = (vss - K * wss) / Iss;
    b = (K * Iss) / wss;

    % Reemplazar R y b en los parámetros
    params(1) = R; % Reemplaza el valor de R
    params(5) = b; % Reemplaza el valor de b

    % Solución del sistema de ecuaciones diferenciales
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8); % Ajustar tolerancias

    % Solución del sistema de ecuaciones diferenciales
    try
        [t, y] = ode45(@(t, y) motorDC(params, y, t), tspan, y0, options);
    catch
        % Si hay un error en la simulación, asignar un MSE alto
        mse = 1e6;
        return;
    end

    % % Verificar si la simulación cubre todo el tiempo necesario
    % if length(t) < length(tspan)
    %     mse = 1e6; % Penalizar si la simulación no es suficiente
    %     return;
    % end

    % Interpolar resultados para comparar con datos reales
    I_calc = interp1(t, y(:, 1), tspan, 'pchip', 'extrap');
    W_calc = interp1(t, y(:, 2), tspan, 'pchip', 'extrap');
        
    % Calcular el MSE entre los datos calculados y los reales
    mse = mean((I_real - I_calc).^2 + (W_real - W_calc).^2);
end
    
%% Simulación
% Usar los datos reales del archivo cargado
tspan = t; % Tiempo de simulación
I_real = I; % Corriente deseada
W_real = W; % Velocidad angular deseada
    
% Crear la población inicial
poblacion = crear_poblacion(P, N, ul, ll);
mse_historial_min = zeros(num_generaciones, 1);

for gen = 1:num_generaciones
    % Evaluar el MSE para cada individuo en la población
    mse_vals = zeros(P, 1);
    for i = 1:P
        individuo = poblacion(i, :);
        mse_vals(i) = MSE(individuo, I_real, W_real, tspan); 
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

    
%% Mostrar resultados
disp('Población final:');
disp(poblacion);
    
% Gráfica del MSE mínimo a lo largo de las generaciones
figure;
plot(1:num_generaciones, mse_historial_min, '-o');
xlabel('Generación');
ylabel('MSE mínimo');
title('Evolución del MSE mínimo a lo largo de las generaciones');
grid on;
    
% Gráfica de comparación de la respuesta simulada vs real
% Mejores parámetros encontrados
[~, mejor_indice] = min(mse_vals);
mejor_individuo = poblacion(mejor_indice, :);
    
% Simulación con los mejores parámetros
[t_sim, y_sim] = ode45(@(t, y) motorDC(mejor_individuo, y, t), tspan, [0; 0]);
I_sim = interp1(t_sim, y_sim(:, 1), tspan);
W_sim = interp1(t_sim, y_sim(:, 2), tspan);
    
figure;
subplot(2,1,1);
plot(tspan, I_real, 'b', tspan, I_sim, 'r--');
xlabel('Tiempo');
ylabel('Corriente');
legend('Real', 'Simulada');
title('Comparación de Corriente');
    
subplot(2,1,2);
plot(tspan, W_real, 'b', tspan, W_sim, 'r--');
xlabel('Tiempo');
ylabel('Velocidad Angular');
legend('Real', 'Simulada');
title('Comparación de Velocidad Angular');
grid on;

% Crear la tabla para mostrar los resultados
resultados = table(tspan, I_real, I_sim, W_real, W_sim, ...
    'VariableNames', {'Tiempo', 'Corriente_Real', 'Corriente_Simulada', 'Velocidad_Real', 'Velocidad_Simulada'});

% Mostrar la tabla
disp(resultados);
toc