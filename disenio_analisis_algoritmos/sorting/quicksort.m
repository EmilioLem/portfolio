function quickSortDemo()
    % Ejemplo de datos de entrada
    A = [10, 7, 8, 9, 1, 5];
    
    % Llamada al algoritmo de QuickSort
    A = quickSort(A, 1, length(A));
    
    disp('Array Ordenado:');
    disp(A);
end

function A = quickSort(A, low, high)
    if low < high
        % Encuentra el índice de partición
        [A, pivotIndex] = partition(A, low, high);
        
        % Ordenar elementos antes y después de la partición
        A = quickSort(A, low, pivotIndex - 1);
        A = quickSort(A, pivotIndex + 1, high);
    end
end

function [A, pivotIndex] = partition(A, low, high)
    % Elegir el último elemento como pivote
    pivot = A(high);
    i = low - 1; % Índice del elemento más pequeño
    
    for j = low:high-1
        % Si el elemento actual es menor o igual al pivote
        if A(j) <= pivot
            i = i + 1; % Incrementar índice
            % Intercambiar A(i) y A(j)
            A([i, j]) = A([j, i]);
        end
    end
    
    % Colocar el pivote en su posición correcta
    A([i + 1, high]) = A([high, i + 1]);
    pivotIndex = i + 1; % Índice del pivote
end

