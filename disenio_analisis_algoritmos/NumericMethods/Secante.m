clear all
close all
clc

fprintf ('\nCalculo de la raiz de una ecuación por el método de la Secante\n\n');
% Definir la función f(x)
f=input ('Dame la funcion f(x): ','s');

% Puntos iniciales
x0=input ('Dame el valor del intervalo inferior de x: ');
x1=input ('Dame el valor del intervalo superior de x: ');

% Porcentaje de error
e=input ('Dame el porciento del error: ');
ea = 1000;
c = 1;

while ea > e
    x = x0;
    g = eval(f);
    x = x1;
    gg = eval(f);
    xi = x1 - ((gg * (x0 - x1)) / (g - gg));
    ea = abs((xi - x1) / xi) * 100;
    x0 = x1;
    x1 = xi;
    c = c + 1;
end

fprintf('\n\nLa raíz exacta es: %d', xi)
fprintf('\nNumero de iteraciones: %d\n', c)




