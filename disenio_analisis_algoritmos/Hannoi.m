clear; close all; clc;

n = input('Numero de discos: ');

movimientos = 0;

fprintf('Los movimientos a realizar son:\n');
movimientos = hanoi(n, 1, 2, 3, movimientos);
fprintf('\nNúmero total de movimientos: %d\n', movimientos);

function movimientos = hanoi(discos, com, aux, fin, movimientos)
    if discos == 1
        fprintf('%d -> %d\n', com, fin);
        movimientos = movimientos + 1;
    else
        movimientos = hanoi(discos-1, com, fin, aux, movimientos);
        
        fprintf('%d -> %d\n', com, fin);
        movimientos = movimientos + 1;
       
        movimientos = hanoi(discos-1, aux, com, fin, movimientos);
    end
end
