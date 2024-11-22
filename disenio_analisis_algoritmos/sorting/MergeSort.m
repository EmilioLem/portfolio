function sortedArray = mergeSort(arr)
    % Si el arreglo tiene un solo elemento, ya está ordenado
    if length(arr) <= 1
        sortedArray = arr;
        return;
    end
    
    % Dividir el arreglo en dos mitades
    mid = floor(length(arr) / 2);
    left = arr(1:mid);
    right = arr(mid+1:end);
    
    % Llamadas recursivas para ordenar cada mitad
    leftSorted = mergeSort(left);
    rightSorted = mergeSort(right);
    
    % Fusionar las dos mitades ordenadas
    sortedArray = merge(leftSorted, rightSorted);
end

% Función para fusionar dos arreglos ordenados
function mergedArray = merge(left, right)
    mergedArray = [];  % Inicializar arreglo vacío para almacenar la fusión
    i = 1;  % Índice para el arreglo izquierdo
    j = 1;  % Índice para el arreglo derecho
    
    % Fusionar los dos arreglos ordenados
    while i <= length(left) && j <= length(right)
        if left(i) <= right(j)
            mergedArray = [mergedArray, left(i)];
            i = i + 1;
        else
            mergedArray = [mergedArray, right(j)];
            j = j + 1;
        end
    end
    
    % Si quedan elementos en el arreglo izquierdo, agregarlos
    while i <= length(left)
        mergedArray = [mergedArray, left(i)];
        i = i + 1;
    end
    
    % Si quedan elementos en el arreglo derecho, agregarlos
    while j <= length(right)
        mergedArray = [mergedArray, right(j)];
        j = j + 1;
    end
end

% Ejemplo de uso:
arr = [14,16,12,11,1,2,9,10,3];
sortedArr = mergeSort(arr);
disp('Arreglo ordenado usando MergeSort:');
disp(sortedArr);
