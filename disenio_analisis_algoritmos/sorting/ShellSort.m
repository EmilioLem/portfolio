function sortedArray = shellSort(arr)
    n = length(arr);
    
    % Inicializar el gap. Utilizamos la fórmula de Hibbard (gap = 2^k - 1)
    
    gap = floor(n / 2);  % Comenzamos con un gap que sea la mitad del arreglo

    % Continuamos hasta que el gap sea 0
    while gap > 0
        % Realizamos un InsertionSort con el gap actual
        for i = gap + 1:n
            temp = arr(i);
            j = i;
            
            % Comparar e insertar el elemento en la posición correcta
            while j > gap && arr(j - gap) > temp
                arr(j) = arr(j - gap);
                j = j - gap;
            end
            arr(j) = temp;
        end
        
        % Reducir el gap (generalmente lo reducimos a la mitad)
        gap = floor(gap / 2);
    end
    
    sortedArray = arr; % El arreglo ordenado
end

% Ejemplo de uso:
arr = [64, 34, 25, 12, 22, 11, 90];
sortedArr = shellSort(arr);
disp('Arreglo ordenado usando ShellSort:');
disp(sortedArr);
