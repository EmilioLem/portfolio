% Bubble Sort Script

A = [64, 34, 25, 12, 22, 11, 90];

% Llamada a la función bubbleSort
sortedArray = bubbleSort(A);

% Mostrar el resultado
disp('Arreglo ordenado:');
disp(sortedArray);

% Definición de la función bubbleSort
function sortedArray = bubbleSort(arr)
    n = length(arr); 

    for i = 1:n-1
        for j = 1:n-i
            if arr(j) > arr(j+1)
                % Intercambiar los elementos
                temp = arr(j);
                arr(j) = arr(j+1);
                arr(j+1) = temp;
            end
        end
    end
    sortedArray = arr; 
end
