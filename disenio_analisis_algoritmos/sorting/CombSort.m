function sortedArray = combSort(arr)
    n = length(arr);
    gap = n; % Establecer el gap inicial como el tamaño del arreglo
    shrink = 1.3; % Factor de reducción del gap
    swapped = true;
    
    while gap > 1 || swapped
        gap = floor(gap / shrink); % Reducir el gap
        if gap < 1
            gap = 1; % Asegurarse de que el gap no sea menor que 1
        end
        
        swapped = false;
        
        % Comparar los elementos con el gap actual
        for i = 1:n - gap
            if arr(i) > arr(i + gap)
                % Intercambiar los elementos
                temp = arr(i);
                arr(i) = arr(i + gap);
                arr(i + gap) = temp;
                swapped = true;
            end
        end
    end
    
    sortedArray = arr; % Resultado final con el arreglo ordenado
end

% Ejemplo de uso:
arr = [10, 2, 9, 1, 14, 6];
sortedArr = combSort(arr);
disp('Arreglo ordenado usando CombSort:');
disp(sortedArr);
