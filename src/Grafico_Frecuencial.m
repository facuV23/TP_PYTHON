% -------------------------------------------------------------------------
%
%    function [espectro img] = Grafico_Frecuencial(sgn, fs, mode, mod_gr);
%
%   Par�metros de Entrada :
%
%       snl     : array con las muestras de la se�al
%       Fs      : Frecuencia a la que fue sampleada la se�al
%       color   : par�metro del plot
%       mod_gr  : 0 -> grafica parte real e imaginaria de la se�al
%                 1 -> grafica modulo y fase en dB
%                 2 -> Grafica solo m�dulo sin crear nueva figura
%       NF      : Opcional:N�mero de fila. Para asociar el gr�fico a uno ya
%                 existente.
%       NC      : Opcional:N�mero de columna. Para asociar el gr�fico a uno 
%                 ya existente.
%       G0      : Opcional:N�mero de gr�fico del plot a partir del cual se
%                 dibuja.
%
%   Par�metros de salida :
% 
%       espectro    : Array de N muestras con la se�al
%       img         : Array de N muestras con el eje temporal
%
%   Fecha de creacion   :   08.04.2010
%   �ltima Modificaci�n :   10.02.2014
%
%   Autor : Federico Roux (froux@favaloro.edu.ar)
%   Laboratorio de uP. Universidad Favaloro 
% -------------------------------------------------------------------------

function [espectro img ] = Grafico_Frecuencial(snl, Fs, color, mod_gr, NF, NC, G0)

%% Definici�n de par�metros :

margenY = 0.1 ;                                                             % Margen porcentual en el eje y

%% Implementaci�n de la funci�n :

N = length(snl);                                                            % Calculo la longitud de la se�al

espectro = fft(snl);                                                        % Hago la fft de la se�al

if(mod_gr == 1 || mod_gr == 2)                                              % Grafico mod_gr : M�dulo y Fase
    
    modulo  = abs(espectro);                                                % Calculo el m�dulo de las muestras
    fase    = angle(espectro);                                              % Calculo la fase del espectro de la se�al
    
    max_mod = max(modulo);                                                  % Calculo el m�ximo del m�dulo para normalizar
    modulo_norm = modulo/max_mod;                                           % Normalizo en funci�n del m�ximo que me queda igual a uno
    modulo_db = 20*log(modulo_norm);                                        % Convierto todo a dB (el m�ximo pasa a ser cero)
    
    g1 = modulo_db;                                                         % Guardo el m�dulo de la se�al a graficar
    g2 = fase ;                                                             % Guardo la fase de la se�al a graficar
        
    titulo = 'M�dulo y Fase del Espectro de la Se�al' ;                     % T�tulo general
    tit1 = 'M�dulo del espectro de la se�al' ;                              % Titulo gr�fico modulo
    tit2 = 'Fase del espectro de la se�al' ;                                % T�tulo gr�fico fase
    ylab1 = '|X(\omega)| [dB]' ;                                            % Etiqueta del eje vertical del primer gr�fico
    ylab2 = '\phi[X(\omega)] [rad]' ;                                       % Etiqueta del eje vertical del segundo gr�fico
       
elseif (mod_gr == 0 )                                                       % Grafico cartesiano : parte real e imaginaria
    
    preal   = real (espectro) ;                                             % Calculo la parte real del espectro
    pimag   = imag (espectro) ;                                             % Calculo la parte imaginaria del espectro
    
    g1 = preal ;                                                            % Guardo la parte real de la se�al a graficar
    g2 = pimag ;                                                            % Guardo la parte imaginaria de la se�al a graficar
    
    titulo = 'Parte Real e Imaginaria del Espectro de la Se�al' ;           % Titulo general
    tit1 = 'Parte Real del espectro de la se�al' ;                          % T�tulo del gr�fico de la parte real
    tit2 = 'Parte Imaginaria del espectro de la se�al' ;                    % T�tulo del gr�fico de la parte imaginaria
    
    ylab1 = 'Real [X(\omega) ]' ;                                           % Etiqueta del eje vertical del primer gr�fico
    ylab2 = 'Imag [X(\omega) ]' ;                                           % Etiqueta del eje vertical del segundo gr�fico 

end

n = 0 : N - 1 ;                                                             % Eje con n�mero de muestras
n = n * (Fs / N);                                                           % Escalo el eje de frecuencias en Hz
% n = n - N/2 ;                                                             % Muevo el eje al centro

%% Correci�n de m�rgenes

[max1 min1 ] = Margenes(g1, margenY ) ;
[max2 min2 ] = Margenes(g2, margenY ) ;


%% Gr�fico de las se�ales :

if(mod_gr == 0 || mod_gr == 1)
    if(nargin < 5)
        img = figure () ;                                                       % Obtengo el handler de la imagen       
        G0 = 1;
        set(gcf, 'Name', titulo) ;
        NF = 2;
        NC = 1;
    end
    % Primer Gr�fico :

    subplot (NF, NC, G0) ;
    plot (n, g1, color, 'LineWidth', 2 ) ;               
    grid on ;    
    ylim ([min1 max1 ] ) ;

    xlabel ('f[Hz]' ) ;
    ylabel (ylab1) ;
    title(tit1 ) ;

    % Segundo Gr�fico :

    subplot (NF, NC, G0 + 1) ;
    plot (n, g2, color, 'LineWidth', 2 ) ;               
    grid on ;
    ylim ([min2 max2 ] ) ;

    xlabel ('f[Hz]' ) ;
    ylabel (ylab2) ;
    title(tit2 ) ;

    
elseif(mod_gr == 2)

    if(nargin < 5)
        img = figure () ;                                                       % Obtengo el handler de la imagen       
        G0 = 1;
        set(gcf, 'Name', titulo) ;
    end
    img = gcf();
    
    plot (n, g1, color, 'LineWidth', 2 ) ;               
    grid on ;
    % xlim ([fmin fmax ] ) ;
    ylim ([min1 max1 ] ) ;

    xlabel ('f[Hz]' ) ;
    ylabel (ylab1) ;
    title(tit1 ) ;    
    
end

end

%-------------------------------------------------------------------------
%   function [maximo minimo] = Margenes(signal )
%
%   Par�metros de Entrada :
%           sgn                 : se�al a calcular los m�rgenes
%           margen_porcentual   : porcentaje respecto a los m�ximos
%
%   Par�metros de salida :
%       maximo  : valor m�ximo del m�rgen del gr�fico
%       minimo  : valor m�nimo del m�rgen del gr�fico
%
%   Fecha de creaci�n   : 13-10-2010
%   �ltima Modificaci�n : 13-10-2010
%
%   Fecha de creacion   :   13.10.2010
%   �ltima Modificaci�n :   10.02.2014
%
%   Autor : Federico Roux (froux@favaloro.edu.ar)
%   Laboratorio de uP
%   Universidad Favaloro 
%-------------------------------------------------------------------------

function [maximo minimo] = Margenes(sgn, margen_porcentual )

maximo = max(sgn );                                                         % M�ximo de la se�al a graficar
minimo = min(sgn );                                                         % M�nimo de la se�al a graficar

span = maximo - minimo ;                                                    % Rango din�mico de la se�al

if(span == 0)
    span = 1 ;                                                              % Fuerzo el span si las se�ales tienen sus muestras iguales
end

margen = margen_porcentual * abs(span ) ;

maximo = maximo + margen ;
minimo = minimo - margen ;

end