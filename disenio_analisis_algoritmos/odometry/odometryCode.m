% Parámetros
radiod = 0.024; % Radio de la rueda derecha
radioi = 0.028; % Radio de la rueda izquierda
d = 0.13; % Distancia entre las ruedas (en metros)
dt = 0.1; % Intervalo de tiempo (en segundos)
x0 = 0; % Posición inicial en x
y0 = 0; % Posición inicial en y
theta0 = 0; % Orientación inicial

% Leer el archivo
datos = importdata('muestras.log');
t = datos(:, 1);          % Tiempo
encoderR = datos(:, 2);    % Encoder derecho
encoderL = datos(:, 3);    % Encoder izquierdo

% Inicialización de matrices para almacenar resultados
x = zeros(length(t), 1);
y = zeros(length(t), 1);
theta = zeros(length(t), 1);

% Valores iniciales
x(1) = x0;
y(1) = y0;
theta(1) = theta0;

% Cálculo de parámetros
for i = 2:length(t)
    % Calcular las distancias recorridas por cada rueda
    d_l = (encoderL(i) - encoderL(i-1)) * (2 * pi * radioi) / 360; % Distancia de la rueda izquierda
    d_r = (encoderR(i) - encoderR(i-1)) * (2 * pi * radiod) / 360; % Distancia de la rueda derecha

    % Calcular el cambio en la orientación
    delta_theta = (d_r - d_l) / d;

    % Actualizar la orientación
    theta(i) = theta(i-1) + delta_theta;

    % Calcular el desplazamiento en x e y
    x(i) = x(i-1) + (d_l + d_r) / 2 * cos(theta(i));
    y(i) = y(i-1) + (d_l + d_r) / 2 * sin(theta(i));
end

% % Mostrar resultados finales
% fprintf('Posición final: (%.2f, %.2f)\n', x(end), y(end));
% fprintf('Orientación final: %.2f rad\n', theta(end));

% Gráfica del recorrido
figure;
plot(x, y, 'g-'); % Trazo de la trayectoria en verde
hold on;
xlabel('Posición en x (m)');
ylabel('Posición en y (m)');
title('Recorrido del Carrito');
axis equal; % Para que las proporciones sean correctas
grid on; % Añadir una cuadrícula para facilitar la visualización
hold off;

