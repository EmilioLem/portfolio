function sortedArray = cocktailSort(arr)
    n = length(arr);
    swapped = true;
    
    while swapped
        swapped = false;
        
        % Recorrido de izquierda a derecha
        for i = 1:n-1
            if arr(i) > arr(i+1)
                % Intercambiar los elementos
                temp = arr(i);
                arr(i) = arr(i+1);
                arr(i+1) = temp;
                swapped = true;
            end
        end
        
        % Si no se hicieron intercambios, la lista está ordenada
        if ~swapped
            break;
        end
        
        swapped = false;
        
        % Recorrido de derecha a izquierda
        for i = n-1:-1:2
            if arr(i) < arr(i-1)
                % Intercambiar los elementos
                temp = arr(i);
                arr(i) = arr(i-1);
                arr(i-1) = temp;
                swapped = true;
            end
        end
    end
    
    sortedArray = arr; % Resultado final con el arreglo ordenado
end

% Ejemplo de uso:
arr = [5, 2, 9, 1, 10, 6];
sortedArr = cocktailSort(arr);
disp('Arreglo ordenado usando CocktailSort:');
disp(sortedArr);
