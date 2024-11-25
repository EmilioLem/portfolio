x = 15; % Tamaño del cuadrado
matriz_laberinto = ones(x, x);
matriz_laberinto(2:end-1, 2:end-1) = 0; % Relleno del interior

% Visualización inicial
imagesc(matriz_laberinto); % Mostrar el cuadrado
colormap(gray); % Escala de grises
axis equal tight;

% Seguir el contorno
i = 1; j = 1;
direccion = 'derecha'; % Dirección inicial
while i <= x && j <= x
    matriz_laberinto(i, j) = 0.5; % Marcar el camino
    imagesc(matriz_laberinto); % Actualizar la imagen
    pause(0.1); % Pausa para visualizar el recorrido
    
    % Movimiento en función de la dirección
    switch direccion
        case 'derecha'
            if j < x && matriz_laberinto(i, j+1) == 1
                j = j + 1;
            else
                direccion = 'abajo';
            end
        case 'abajo'
            if i < x && matriz_laberinto(i+1, j) == 1
                i = i + 1;
            else
                direccion = 'izquierda';
            end
        case 'izquierda'
            if j > 1 && matriz_laberinto(i, j-1) == 1
                j = j - 1;
            else
                direccion = 'arriba';
            end
        case 'arriba'
            if i > 1 && matriz_laberinto(i-1, j) == 1
                i = i - 1;
            else
                direccion = 'derecha';
            end
    end
end
