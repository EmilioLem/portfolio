function sortedArray = radixSort(arr)
    % Encontrar el valor máximo en el arreglo para determinar el número de dígitos
    maxVal = max(arr);
    
    % Determinar el número de dígitos en el valor máximo
    exp = 1;  % Exponente para el dígito actual (1, 10, 100, ...)
    
    while maxVal / exp > 1
        % Realizar la ordenación por cada dígito
        arr = countingSortByDigit(arr, exp);
        exp = exp * 10;  % Aumentar el exponente para el siguiente dígito
    end
    
    sortedArray = arr;  % El arreglo ordenado
end

function arr = countingSortByDigit(arr, exp)
    n = length(arr);
    output = zeros(1, n);  % Arreglo de salida
    count = zeros(1, 10);  % Arreglo de contadores (para los dígitos 0-9)
    
    % Contar la ocurrencia de cada dígito
    for i = 1:n
        digit = floor(arr(i) / exp) - floor(arr(i) / (exp * 10)) * 10;
        count(digit + 1) = count(digit + 1) + 1;
    end
    
    % Calcular las posiciones acumuladas
    for i = 2:10
        count(i) = count(i) + count(i - 1);
    end
    
    % Colocar los números en el arreglo de salida
    for i = n:-1:1
        digit = floor(arr(i) / exp) - floor(arr(i) / (exp * 10)) * 10;
        output(count(digit + 1)) = arr(i);
        count(digit + 1) = count(digit + 1) - 1;
    end
    
    % Copiar el arreglo de salida al arreglo original
    arr = output;
end

% Ejemplo de uso:
arr = [170, 45, 75, 90, 802, 24, 2, 66];
sortedArr = radixSort(arr);
disp('Arreglo ordenado usando RadixSort:');
disp(sortedArr);
