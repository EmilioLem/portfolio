clear; close all; clc;

disp("LaberintoA_star.m");

function maze = generateMaze(rows, cols, obstacle_density, seed)
    rng(seed); % Configurar la semilla
    maze = rand(rows, cols) < obstacle_density; % Generar obstáculos
    maze(1, 1) = 0; % Inicio libre
    maze(rows, cols) = 0; % Meta libre
end

function visualizeMaze(maze, start, goal, path)
    imagesc(1 - maze); % Visualizar el laberinto
    colormap(gray);
    axis equal tight;
    hold on;

    % Resaltar el inicio (verde) y la meta (rojo)
    plot(start(2), start(1), 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
    plot(goal(2), goal(1), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % Dibujar el camino encontrado (si existe)
    if ~isempty(path)
        for i = 1:size(path, 1)-1
            plot([path(i, 2), path(i+1, 2)], [path(i, 1), path(i+1, 1)], ...
                 'b-', 'LineWidth', 2);
        end
    end

    title('Laberinto con solución');
    xlabel('Columnas');
    ylabel('Filas');
    hold off;
end

% Generar un laberinto
rows = 20; cols = 20; obstacle_density = 0.3; seed = 11431;
maze = generateMaze(rows, cols, obstacle_density, seed);

start1 = 1;
start2 = 1;
end1 = rows;
end2 = cols;

% Definir inicio y meta
start = [start1, start2];
goal = [end1, end2];

% Resolver el laberinto con A*
path = a_star(maze, start, goal);

% Visualizar el laberinto y la solución
visualizeMaze(maze, start, goal, path);
