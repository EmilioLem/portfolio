function path = a_star(maze, origin, destiny)
    % Configurar la visualización del laberinto
    setup_visualization(maze, origin, destiny);
    
    rows = size(maze, 1);
    cols = size(maze, 2);

    open_list = [origin];
    closed_list = zeros(rows, cols);

    % Inicializar puntajes
    g_score = inf(rows, cols);
    g_score(origin(1), origin(2)) = 0;
    
    f_score = inf(rows, cols);
    f_score(origin(1), origin(2)) = heuristic(origin, destiny);
    
    parent_node = zeros(rows, cols, 2); % Guardar padres

    while ~isempty(open_list)
        % Encontrar el nodo con el menor f_score
        [~, idx] = min(arrayfun(@(i) f_score(open_list(i, 1), open_list(i, 2)), 1:size(open_list, 1)));
        current = open_list(idx, :);
        open_list(idx, :) = []; % Remover de la lista abierta
        
        % Animación: pintar nodo actual
        rectangle('Position', [current(2)-0.5, current(1)-0.5, 1, 1], 'FaceColor', [0 1 1]);
        pause(0.05);
        
        if isequal(current, destiny)
            path = reconstruct_path(parent_node, origin, destiny);
            % Dibujar el camino final
            for i = 1:size(path, 1)
                rectangle('Position', [path(i, 2)-0.5, path(i, 1)-0.5, 1, 1], 'FaceColor', [0 1 0]);
                pause(0.05);
            end
            return;
        end
        
        % Marcar nodo como visitado
        closed_list(current(1), current(2)) = 1;
        
        % Obtener vecinos
        neighbors = get_neighbors(current, maze);
        for i = 1:size(neighbors, 1)
            neighbor = neighbors(i, :);
            
            if closed_list(neighbor(1), neighbor(2)) == 1
                continue; % Ignorar si ya está visitado
            end
            
            tentative_g_score = g_score(current(1), current(2)) + 1; % Costo entre nodos
            
            if ~ismember(neighbor, open_list, 'rows')
                open_list = [open_list; neighbor]; % Agregar a la lista abierta
            elseif tentative_g_score >= g_score(neighbor(1), neighbor(2))
                continue;
            end

            % Dibujar nodos vecinos como abiertos (verde claro)
            rectangle('Position', [neighbor(2)-0.5, neighbor(1)-0.5, 1, 1], 'FaceColor', [1 0.5 1]);
            % plot(neighbor(2), neighbor(1), 'cs', 'MarkerSize', 8, 'MarkerFaceColor', 'c');
            pause(0.05);
            
            % Actualizar puntajes y camino
            parent_node(neighbor(1), neighbor(2), :) = current;
            g_score(neighbor(1), neighbor(2)) = tentative_g_score;
            f_score(neighbor(1), neighbor(2)) = g_score(neighbor(1), neighbor(2)) + heuristic(neighbor, destiny);
        end
    end

    % Si no se encuentra un camino
    path = [];
end

function setup_visualization(maze, origin, destiny)
    % Función para configurar la visualización inicial del laberinto
    figure;
    colormap([1 1 1; 0 0 0]); % Blanco para caminos, negro para obstáculos
    imagesc(maze);
    axis equal tight;
    hold on;
    plot(origin(2), origin(1), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g'); % Nodo inicial
    plot(destiny(2), destiny(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Nodo final
    pause(0.1);
end

function h = heuristic(node, destiny)
    h = abs(node(1) - destiny(1)) + abs(destiny(2) - node(2));
end

function neighbors = get_neighbors(node, maze)
    % Obtener vecinos válidos
    directions = [0 1; 1 0; 0 -1; -1 0]; % Derecha, abajo, izquierda, arriba
    neighbors = [];
    
    for i = 1:size(directions, 1)
        neighbor = node + directions(i, :);
        if neighbor(1) > 0 && neighbor(2) > 0 && ...
           neighbor(1) <= size(maze, 1) && neighbor(2) <= size(maze, 2) && ...
           maze(neighbor(1), neighbor(2)) == 0
           neighbors = [neighbors; neighbor];
        end
    end
end

function path = reconstruct_path(parent_node, start, goal)
    % Reconstruir el camino desde el objetivo al inicio
    path = goal;
    current = goal;
    while ~isequal(current, start)
        current = squeeze(parent_node(current(1), current(2), :))';
        path = [current; path];
    end
end
