clc;
clear;
close all;

%% Definimos nuestra matriz con los pesos y valores de los elementos 
items = [2 3 4 5 9 7 1 8 6 3; % Primera fila: pesos
         3 4 8 8 10 7 2 5 6 9]; % Segunda fila: valores

max_weight = 20; % Máximo de kilos que puede llevar la mochila

%% Hiperparámetros 
P = 10;% Tamaño de la población
N = size(items, 2); % Número de objetos
n_generaciones = 1000; % Número de generaciones
probM = 0.2; % Probabilidad de mutación

%% Función para crear población inicial
function pob = crearPob(P, N)
    pob = cell(1, P); % Crear una celda para almacenar las matrices
    for i = 1:P
        pob{i} = randi([0, 1], 1, N); % Generar una matriz 1xN de valores aleatorios (0 o 1)
    end
end

%% Crear población inicial
pob = crearPob(P, N); % Generar 100 matrices de 1xN

for gen = 1:n_generaciones
    %% Evaluar a los individuos
    valores = items(2, :); % Valores de los objetos
    pesos = items(1, :);   % Pesos de los objetos

    scores = zeros(1, P); % Almacena los valores totales de cada individuo
    pesos_totales = zeros(1, P); % Almacena los pesos totales

    for i = 1:P
        individuo = pob{i}; % Obtener el individuo actual
        indices = find(individuo == 1); % Encontrar los índices donde hay un '1'

        % Calcular peso y valor total del individuo
        peso_total = sum(pesos(indices));
        valor_total = sum(valores(indices));

        % Penalizar si excede el peso máximo
        if peso_total > max_weight
            scores(i) = 0;
        else
            scores(i) = valor_total;
        end
        pesos_totales(i) = peso_total;
    end

    %% Ordenar individuos por puntuación
    [~, orden] = sort(scores, 'descend');
    pob_ordenada = pob(orden); % Reordenar la población por puntuación
    scores_ordenados = scores(orden);

    %% Selección de los mejores 10% de  individuos
    seleccionados = zeros(P*(0.1), N);
    for i = 1:P*(0.1)
        seleccionados(i, :) = pob_ordenada{i};
    end

    %% Selección de padres y creación de hijos
    padres = zeros(P*(0.1), N); 
    for i = 1:P*(0.7)
        indice1 = randi(P*(0.1));
        indice2 = randi(P*(0.1));
        % Cruzar seleccionados (promedio)
        padres(i, :) = round((seleccionados(indice1, :) + seleccionados(indice2, :)) / 2);
    end

    hijos = padres; % Inicializar hijos con los padres
    for i = 1:P*(0.1)
        if rand() < probM
            % Mutación: cambia valores aleatorios de los hijos
            punto_mutacion = randi(N); % Seleccionar un índice aleatorio
            hijos(i, punto_mutacion) = 1 - hijos(i, punto_mutacion); % Cambiar 0->1 o 1->0
        end
    end

    %% Reemplazar los peores 70% individuos con los hijos
    for i = 1:P*(0.7)
        pob_ordenada{end - P*(0.7) + i} = hijos(i, :);
    end

    %% Actualizar la población
    pob = pob_ordenada;

    %% Mostrar resultados de la generación actual
    fprintf('Generación %d: Mejor puntaje = %d | Peso = %d\n', gen, scores_ordenados(1), pesos_totales(orden(1)));
end

disp('Evolución finalizada. Individuo óptimo:');
disp(['Selección: ', mat2str(pob{1}), ' | Valor: ', num2str(scores_ordenados(1)), ' | Peso: ', num2str(pesos_totales(orden(1)))]);

