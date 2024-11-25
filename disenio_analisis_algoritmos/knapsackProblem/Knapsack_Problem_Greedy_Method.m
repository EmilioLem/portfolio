clc;
clear;
close all;

%% Definimos nuestra matriz con los pesos y valores de los elementos 
items = [2 3 4 5 9 7 1 8 6 3; % Primera fila: pesos
         3 4 8 8 10 7 2 5 6 9]; % Segunda fila: valores

max_weight = 20; % Máximo de kilos que puede llevar la mochila

%% Definimos nuestro algoritmo voraz
function knapsack = greedymethod(items, max_weight)
    % Número de objetos
    N = size(items, 2); % Obtener el número de columnas (objetos)
    
    % Calculamos el valor por kilo para cada objeto
    valuePerKilo = items(2, :) ./ items(1, :); % Valores divididos por pesos
    
    % Ordenamos los objetos por valor por kilo en orden descendente
    [~, sortedIndices] = sort(valuePerKilo, 'descend'); 
    
    % Inicializamos variables
    total_weight = 0;
    knapsack = []; % Mochila inicial vacía
    
    % Recorremos los objetos en orden de mayor valor por kilo
    for i = 1:N
        idx = sortedIndices(i); % Índice del objeto actual
        
        % Verificamos si podemos añadir el objeto sin exceder el peso máximo
        if total_weight + items(1, idx) <= max_weight
            knapsack = [knapsack, idx]; % Añadimos el índice del objeto a la mochila
            total_weight = total_weight + items(1, idx); % Actualizamos el peso total
        end
    end
end

%% Llamamos la función y mostramos resultados
knapsack = greedymethod(items, max_weight);

% Mostrar los resultados
disp('Objetos seleccionados (índices):');
disp(knapsack);

disp('Peso total de la mochila:');
disp(sum(items(1, knapsack))); % Peso total de los objetos seleccionados

disp('Valor total de la mochila:');
disp(sum(items(2, knapsack))); % Valor total de los objetos seleccionados
