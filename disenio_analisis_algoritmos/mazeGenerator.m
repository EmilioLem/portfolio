function maze = mazeGenerator(rows, cols, obstacle_density, seed)
    rng(seed); % Configurar la semilla
    maze = rand(rows, cols) < obstacle_density; % Generar obstáculos
    maze(1, 1) = 0; % Inicio libre
    maze(rows, cols) = 0; % Meta libre
end
