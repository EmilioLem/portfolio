clear; close all; clc;

% --- Parámetros para generar el laberinto ---
rows = 20; cols = 20; obstacle_density = 0.3; seed = 12;

% --- Llamar a la función del primer archivo para generar el laberinto ---
maze = mazeGenerator(rows, cols, obstacle_density, seed);

% --- Ajustar la matriz del laberinto para la visualización ---
maze_visual = 1 - maze; % Fondo blanco (1) y paredes negras (0)

% --- Crear un mapa de colores personalizado ---
cmap = [0 0 0; % Negro para paredes
        1 1 1; % Blanco para celdas libres
        0 1 0; % Verde para el recorrido
        1 0 0]; % Rojo para la meta
colormap(cmap);

% --- Configurar inicio y meta ---
start = [1, 1]; % Inicio (esquina superior izquierda)
goal = [rows, cols]; % Meta (esquina inferior derecha)
maze_visual(goal(1), goal(2)) = 3; % Marcar la meta en la matriz visual

% --- Visualizar el laberinto inicial ---
figure;
imagesc(maze_visual); % Visualizar el laberinto inicial
axis equal tight;
title('Laberinto Generado');
pause(1);

% --- Algoritmo de "girar siempre a la derecha" ---
i = start(1); j = start(2);

% Direcciones: [fila_incremento, columna_incremento]
directions = [0, 1; 1, 0; 0, -1; -1, 0]; % Derecha, Abajo, Izquierda, Arriba
dir_idx = 1; % Iniciar moviéndose hacia la derecha

maxIterations = rows*cols;
iteraciones = 0;
conocidos = zeros(1,maxIterations);
while true
    iteraciones = iteraciones + 1;
    % Visualizar el progreso
    if maze_visual(i, j) ~= 3 % No sobrescribir la meta
        maze_visual(i, j) = 2; % Marcar el camino recorrido con un valor 2
    end
    imagesc(maze_visual); % Actualizar la visualización
    colormap(cmap); % Aplicar el mapa de colores
    axis equal tight;
    title('Resolviendo el Laberinto');
    pause(0.1);

    % Terminar si llegamos a la meta
    if i == goal(1) && j == goal(2)
        disp('¡Meta alcanzada!');
        break;
    end
    
    % Calcular nueva dirección intentando girar a la derecha
    right_idx = mod(dir_idx, 4) + 1; % Índice de giro a la derecha
    next_i = i + directions(right_idx, 1);
    next_j = j + directions(right_idx, 2);

    if next_i > 0 && next_i <= rows && next_j > 0 && next_j <= cols && maze(next_i, next_j) == 0
        % Girar a la derecha y avanzar
        dir_idx = right_idx;
        i = next_i;
        j = next_j;
    else
        % Si no puedes girar a la derecha, intenta avanzar
        next_i = i + directions(dir_idx, 1);
        next_j = j + directions(dir_idx, 2);

        if next_i > 0 && next_i <= rows && next_j > 0 && next_j <= cols && maze(next_i, next_j) == 0
            % Avanzar sin girar
            i = next_i;
            j = next_j;
        else
            % Si no puedes avanzar, gira a la izquierda
            dir_idx = mod(dir_idx - 2, 4) + 1; % Índice de giro a la izquierda
        end
    end

    %if i == start(1) && j == start(2)
    %    disp('No hay solucion');
    %    break;
    %end
    if iteraciones >= maxIterations
        disp('Ya no encontró la solución')
        break;
    end


    
    for k=1 : maxIterations;
        conoC = conocidos(k);
        if conoC(1) == i && conoC(2) == j
            disp("Ya conocíamos este camino")
            % Borramos los nodos extra
            for l=k : size(conocidos)
                conocidos(l) = 0;
            end
        end
    end
    % conoC = ;
    conocidos(k) = [i, j];%conoC;

end

disp(conocidos);