% -------------------------------------------------------------------------
%   
%   function Grafico_Temporal(snl, Fs, t0, titulo, x_etq, y_etq, color, mod_gr, nombre)
%
%   Parametros de Entrada:
%
%       snl         : Se�al a graficar
%       Fs          : Frecuencia de muestreo
%       t0          : Instante inicial de la se�al
%       titulo      : Titulo del gr�fico hecho
%       x_etq       : Etiqueta del eje x
%       y_etq       : Etiqueta del eje y
%       mod_gr      :   0 -> plot 
%                       1 -> stem
%                       2 -> L�nea y puntos negros
%       color       : Parametro para el plot.
%       nombre      : T�tulo de la figura (propiedad 'Name')
%
%   Fecha de creacion :     11.05.2010
%   �ltima Modificaci�n :   17.02.2014
%
%   Autor : Federico Roux (froux@favaloro.edu.ar)
%   Laboratorio de uP. Universidad Favaloro 
% -------------------------------------------------------------------------

function Grafico_Temporal(snl, Fs, t0, titulo, x_etq, y_etq, color, mod_gr, nombre)

%% Calculo par�metros de la se�al:

N = length(snl);                                                            % Cantidad de muestras de la se�al

Ts = 1 / Fs ;                                                               % Per�odo de muestreo
k = 0:(N - 1);                                                              % Eje de muestras
t = (k * Ts) + t0;                                                          % Convierto de muestras a unidad de tiempo

xmin = t0;                                                                  % Instante inicial de la se�al
xmax = (N - 1)*Ts + t0;                                                     % Instante final de la se�al

%% Tipo de gr�fico:

if (nargin >= 8)                                                            % Pregunto si recib� todos los par�metros de la se�al

    if(mod_gr == 0)                                                         % Modo 0 :        
        plot(t, snl, color, 'LineWidth', 2);                                 % --> Grafico con la funci�n plot
    
    elseif(mod_gr == 1)                                                       % Modo 1 : 
        stem(t, snl, color) ;                                               % --> Grafico con la funci�n stem
    
    elseif(mod_gr == 2)
        plot(t, snl, color, 'LineWidth', 2);                                 % --> Grafico con la funci�n plot
        hold on;
        plot(t, snl, '.k', 'LineWidth', 2);                                 % --> Grafico con la funci�n plot
        hold off;
    end
else
    
    plot(t, snl, color, 'LineWidth', 2) ;                                   % Si no se especifica el modo, por default hace plot.
end

%% Escribo todas las etiquetas del gr�fico:

xlabel(x_etq);                                                              % Asigno las etiqueta del eje X
ylabel(y_etq);                                                              % Asigno las etiqueta del eje Y

titulo = sprintf('%s N = %d Fs = %.2f [Hz]', titulo, N, Fs) ;                    % Genero la leyenda a escribir como t�tulo
title(titulo);                                                              % Escribo t�tulo del gr�fico      

if(nargin == 9)  
    set(gcf, 'Name',  nombre, 'NumberTitle', 'off');
end

%% Determino los l�mites del gr�fico

maximo = max(snl);                                                          % Maximo de la se�al a graficar
minimo = min(snl);                                                          % Minimo de la se�al a graficar

span = maximo - minimo ;                                                    % Rango dinamico de la se�al

if(span == 0)                                                               % Si la se�al tiene todas las muestras iguales el span es cero y da error
    span = 1 ;                                                              % Fuerzo el span para poder ver correctamente la se�al
end

margen_porcentual = 0.1 ;                                                   % Margen del gr�fico a mostrar m�s all� de sus l�mites
margen = margen_porcentual * abs(span) ;                                    % Genero el margen para sumar a los l�mites del gr�fico

maximo = maximo + margen ;                                                  % Calculo el m�ximo del gr�fico
minimo = minimo - margen ;                                                  % Calculo el m�nimo del gr�fico    

ylim([minimo maximo]);                                                      % L�mites del eje vertical
xlim([xmin xmax]);                                                          % Limites del eje horizontal

grid on;                                                                    % Muestro la grilla sobre el fondo del gr�fico

end