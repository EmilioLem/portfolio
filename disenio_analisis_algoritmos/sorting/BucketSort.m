function sortedArray = bucketSort(arr)
    % Verificar si el arreglo está vacío
    if isempty(arr)
        sortedArray = [];
        return;
    end
    
    % 1. Encontrar el valor máximo y el mínimo del arreglo
    minValue = min(arr);
    maxValue = max(arr);
    
    % 2. Definir el número de cubos (buckets)
    numBuckets = ceil(sqrt(length(arr)));  % Usamos la raíz cuadrada de la longitud del arreglo
    
    % 3. Inicializar los cubos
    buckets = cell(numBuckets, 1);
    
    % 4. Distribuir los elementos en los cubos
    for i = 1:length(arr)
        % Calcular el índice del cubo para el valor arr(i)
        index = floor((arr(i) - minValue) / (maxValue - minValue + 1) * (numBuckets));
        if index == numBuckets
            index = numBuckets - 1; % En caso de que el valor esté en el extremo superior
        end
        buckets{index + 1} = [buckets{index + 1}, arr(i)];
    end
    
    % 5. Ordenar cada cubo individualmente
    for i = 1:numBuckets
        buckets{i} = sort(buckets{i});
    end
    
    % 6. Concatenar todos los cubos ordenados
    sortedArray = [];
    for i = 1:numBuckets
        sortedArray = [sortedArray, buckets{i}];
    end
end

% Ejemplo de uso:
arr = [4, 2, 8, 5, 1, 3, 7, 6, 9];
sortedArr = bucketSort(arr);
disp('Arreglo ordenado usando BucketSort:');
disp(sortedArr);
