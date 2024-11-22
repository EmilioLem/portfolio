function sortedArray = insertionSort(arr)
    % Obtenemos la longitud del arreglo
    n = length(arr);
    
    % Recorremos el arreglo desde el segundo elemento
    for i = 2:n
        % Guardamos el valor del elemento actual
        key = arr(i);
        
        % Comenzamos a comparar con el elemento anterior
        j = i - 1;
        
        % Desplazamos los elementos mayores a la derecha
        while j >= 1 && arr(j) > key
            arr(j + 1) = arr(j); % Desplazamos el elemento
            j = j - 1; % Comparamos con el siguiente elemento hacia la izquierda
        end
        
        % Insertamos el valor en la posición correcta
        arr(j + 1) = key;
    end
    
    % El arreglo ahora está ordenado
    sortedArray = arr;
end

% Ejemplo de uso:
arr = [5, 4, 9, 1, 11, 6, 7, 3, 10];
sortedArr = insertionSort(arr);
disp('Arreglo ordenado usando InsertionSort:');
disp(sortedArr);
