function sortedArray = countingSort(arr)
    % Encontrar el valor máximo y mínimo en el arreglo
    maxVal = max(arr);
    minVal = min(arr);
    
    % Crear un arreglo de conteo con el rango de valores
    range = maxVal - minVal + 1;
    count = zeros(1, range); 
    
    % Contar las ocurrencias de cada valor en el arreglo original
    for i = 1:length(arr)
        count(arr(i) - minVal + 1) = count(arr(i) - minVal + 1) + 1;
    end
    
    % Crear el arreglo ordenado utilizando el conteo
    sortedArray = [];
    for i = 1:range
        sortedArray = [sortedArray repmat(minVal + i - 1, 1, count(i))];
    end
end

% Ejemplo de uso:
arr = [12,25,1,9,10,54,2];
sortedArr = countingSort(arr);
disp('Arreglo ordenado usando CountingSort:');
disp(sortedArr);
