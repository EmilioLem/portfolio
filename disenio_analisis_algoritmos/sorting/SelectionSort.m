function sortedArray = selectionSort(arr)
    n = length(arr);
    
    % Recorrer el arreglo
    for i = 1:n-1
        % Encontrar el índice del elemento mínimo
        minIndex = i;
        
        for j = i+1:n
            if arr(j) < arr(minIndex)
                minIndex = j;
            end
        end
        
        % Intercambiar el elemento actual con el elemento mínimo
        if minIndex ~= i
            temp = arr(i);
            arr(i) = arr(minIndex);
            arr(minIndex) = temp;
        end
    end
    
    sortedArray = arr; % El arreglo ordenado
end

% Ejemplo de uso:
arr = [64, 25, 12, 22, 11,201,101];
sortedArr = selectionSort(arr);
disp('Arreglo ordenado usando SelectionSort:');
disp(sortedArr);
