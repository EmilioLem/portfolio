%% Limpieza
clear;
clc;
close all;

%% Valores
load("motorD.mat");
I = out.intensidad;  % Corriente real del motor
W = out.v_angular;   % Velocidad angular real del motor
t = out.tout;        % Tiempos

%% Configuración del Algoritmo de Monte Carlo
num_samples = 10000; % Número de muestras aleatorias
ul = [5, 0.1, 0.5, 0.00001, 0.001]; % Límites superiores para cada parámetro
ll = [0.01, 0.005, 0.0000001, 0.0000001, 0.00001]; % Límites inferiores para cada parámetro

% Crear muestras aleatorias dentro de los límites
samples = ll + rand(num_samples, 5) .* (ul - ll);

% Inicializar variables para guardar el mejor MSE y parámetros
best_mse = Inf;
best_params = [];

% Iterar sobre cada muestra y calcular el MSE
for i = 1:num_samples
    params = samples(i, :);
    mse = MSE(params, I, W, t);
    
    % Si se encuentra un mejor MSE, actualizar
    if mse < best_mse
        best_mse = mse;
        best_params = params;
    end
end

% Mostrar los mejores parámetros y el MSE mínimo encontrado
fprintf('Mejor MSE: %.6f\n', best_mse);
fprintf('Mejores Parámetros: R = %.6f, K = %.6f, L = %.6f, J = %.6f, B = %.6f\n', ...
    best_params(1), best_params(2), best_params(3), best_params(4), best_params(5));

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

    % Ajustar tolerancias y resolver el sistema de ecuaciones diferenciales
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);

    % Extender el rango temporal para asegurar la cobertura completa
    try
        [t, y] = ode45(@(t, y) motorDC(params, y, t), [min(tspan)-1, max(tspan)+1], y0, options);
    catch
        % Si hay un error en la simulación, asignar un MSE alto
        mse = 1e6;
        return;
    end

    % Verificar si la simulación cubre todo el tiempo necesario
    if length(t) < length(tspan) || any(isnan(y(:, 1))) || any(isnan(y(:, 2)))
        mse = 1e6; % Penalizar si la simulación no es suficiente o hay NaNs
        return;
    end

    % Interpolar resultados para comparar con datos reales
    I_calc = interp1(t, y(:, 1), tspan, 'pchip', 'extrap');
    W_calc = interp1(t, y(:, 2), tspan, 'pchip', 'extrap');

    % Asegurar que no haya NaNs en los datos interpolados
    if any(isnan(I_calc)) || any(isnan(W_calc))
        mse = 1e6; % Penalizar si la interpolación genera NaNs
    else
        % Calcular el MSE entre los datos calculados y los reales
        mse = mean((I_real - I_calc).^2 + (W_real - W_calc).^2);
    end
end

%% Visualización de los Resultados
% Simulación con los mejores parámetros encontrados
[t_sim, y_sim] = ode45(@(t, y) motorDC(best_params, y, t), t, [0; 0]);
I_sim = interp1(t_sim, y_sim(:, 1), t, 'pchip', 'extrap');
W_sim = interp1(t_sim, y_sim(:, 2), t, 'pchip', 'extrap');

% Gráfica de la Corriente Real vs Simulada
figure;
subplot(2,1,1);
plot(t, I, 'b', 'LineWidth', 1.5); % Corriente real
hold on;
plot(t, I_sim, 'r--', 'LineWidth', 1.5); % Corriente simulada
xlabel('Tiempo (s)');
ylabel('Corriente (A)');
legend('Real', 'Simulada');
title('Comparación de Corriente Real vs Simulada');
grid on;

% Gráfica de la Velocidad Angular Real vs Simulada
subplot(2,1,2);
plot(t, W, 'b', 'LineWidth', 1.5); % Velocidad angular real
hold on;
plot(t, W_sim, 'r--', 'LineWidth', 1.5); % Velocidad angular simulada
xlabel('Tiempo (s)');
ylabel('Velocidad Angular (rad/s)');
legend('Real', 'Simulada');
title('Comparación de Velocidad Angular Real vs Simulada');
grid on;
