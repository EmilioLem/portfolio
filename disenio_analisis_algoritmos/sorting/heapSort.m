function heapSort()
    % Ejemplo de datos de entrada
    A = [4, 10, 3, 5, 1];
    
    % Llamada al algoritmo de Heap Sort
    A = heapSortAlgorithm(A);
    
    disp('Array Ordenado:');
    disp(A);
end

function A = heapSortAlgorithm(A)
    n = length(A);
    
    % Construir el Max Heap
    A = buildMaxHeap(A, n);
    
    % Extraer elementos del heap uno por uno
    for i = n:-1:2
        % Mover la raíz (el mayor elemento) al final del array
        A([1, i]) = A([i, 1]);
        
        % Llamar a MaxHeapify en el heap reducido
        A = maxHeapify(A, 1, i-1);
    end
end

function A = buildMaxHeap(A, n)
    % Construir un Max Heap
    for i = floor(n / 2):-1:1
        A = maxHeapify(A, i, n);
    end
end

function A = maxHeapify(A, i, heapSize)
    l = 2 * i;
    r = 2 * i + 1;
    largest = i;
    
    % Verificar si el hijo izquierdo es mayor que el nodo actual
    if l <= heapSize && A(l) > A(largest)
        largest = l;
    end
    
    % Verificar si el hijo derecho es mayor que el nodo actual
    if r <= heapSize && A(r) > A(largest)
        largest = r;
    end
    
    % Si el nodo actual no es el mayor
    if largest ~= i
        % Intercambiar el nodo actual con el mayor
        A([i, largest]) = A([largest, i]);
        
        % Llamar a maxHeapify recursivamente en el subárbol afectado
        A = maxHeapify(A, largest, heapSize);
    end
end
