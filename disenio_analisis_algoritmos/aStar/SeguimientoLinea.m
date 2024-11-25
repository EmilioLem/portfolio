% Definir el tamaño del cuadrado
x = 15; % El cuadrado será de 15x15 celdas

% Crear la matriz del "laberinto" como un cuadrado relleno de unos
matriz_laberinto = ones(x, x); 
% Rellenar el interior con ceros, dejando un borde de unos
matriz_laberinto(2:end-1, 2:end-1) = 0;

% Visualización inicial del laberinto
imagesc(matriz_laberinto); % Mostrar la matriz como una imagen
colormap(gray); % Usar una escala de grises
axis equal tight; % Ajustar los ejes para que las celdas sean cuadradas y compactas

% Inicializar la posición y dirección para recorrer el contorno
i = 1; j = 1; % Comenzar en la esquina superior izquierda (1,1)
direccion = 'derecha'; % Dirección inicial del recorrido

% Bucle para recorrer el contorno
while i <= x && j <= x
    % Marcar la celda actual con un valor intermedio para visualizar el recorrido
    matriz_laberinto(i, j) = 0.5; 
    
    % Actualizar la imagen para mostrar el progreso
    imagesc(matriz_laberinto); 
    pause(0.1); % Añadir una pausa para que el recorrido sea visible en tiempo real
    
    % Determinar el movimiento basado en la dirección actual
    switch direccion
        case 'derecha'
            % Si podemos movernos a la derecha (hay un 1), avanzamos
            if j < x && matriz_laberinto(i, j+1) == 1
                j = j + 1;
            else
                % Si no, cambiamos la dirección a abajo
                direccion = 'abajo';
            end
        case 'abajo'
            % Si podemos movernos hacia abajo, avanzamos
            if i < x && matriz_laberinto(i+1, j) == 1
                i = i + 1;
            else
                % Si no, cambiamos la dirección a la izquierda
                direccion = 'izquierda';
            end
        case 'izquierda'
            % Si podemos movernos a la izquierda, avanzamos
            if j > 1 && matriz_laberinto(i, j-1) == 1
                j = j - 1;
            else
                % Si no, cambiamos la dirección hacia arriba
                direccion = 'arriba';
            end
        case 'arriba'
            % Si podemos movernos hacia arriba, avanzamos
            if i > 1 && matriz_laberinto(i-1, j) == 1
                i = i - 1;
            else
                % Si no, cambiamos la dirección a la derecha
                direccion = 'derecha';
            end
    end
end
