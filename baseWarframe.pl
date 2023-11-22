%BASE CONOCIMIENTOS WARFRAME

% Diego Ampuero
% Carlos Urzua 
% Joaquín Sánchez 
% Cristofer Quintana
% Diego Vargas


%warframe(nombre,Salud,escudos,energia,velocidad)

warframe(ash, 200, 150, 100, 1.3).
warframe(atlas, 270, 270, 175, 0.9).
warframe(banshee,270, 270, 175, 1.1).
warframe(baruuk, 180, 270, 200, 1.2).
warframe(caliban, 170, 450, 140, 1.1).
warframe(chroma, 270, 270, 175, 1).
warframe(citrine, 400, 270, 130, 1).
warframe(dagath, 566, 150, 175, 1.1).
warframe(ember, 270, 270, 175, 1.1).
warframe(equinox, 270, 270, 175, 1.15).
warframe(excalibur, 270, 270, 100, 1).
warframe(frost, 270, 270, 100, 0.95).
warframe(gara, 270, 270, 175, 1.15).
warframe(garuda, 150, 100, 100, 1.15).
warframe(gauss, 270, 455, 175, 1.4).
warframe(grendel, 1095, 95, 175, 0.95).
warframe(gyre, 270, 555, 190, 1).
warframe(harrow, 270, 455, 100, 1).
warframe(hildryn, 180, 1280, 0, 1).
warframe(hydroid, 270, 365, 140, 1.05).
warframe(inaros, 2110, 0, 100, 1).
warframe(ivara, 180, 270, 215, 1.5).
warframe(khora, 365, 270, 140, 1.05).
warframe(kullervo, 1005, 0, 175, 1.1).
warframe(lavos, 540, 270, 0, 1.15).
warframe(limbo, 270, 280, 175, 1.15).
warframe(loki, 180, 180, 175, 1.25).
warframe(mag, 180, 455, 140, 1).
warframe(mesa, 365, 180, 100, 1.1).
warframe(mireya, 200, 200, 175, 1.2).
warframe(nekros, 270, 235, 100, 1.1).
warframe(nezha, 365, 135, 175, 1.15).
warframe(nidus, 455, 0, 100, 1).
warframe(nova, 270, 180, 175, 1.2).
warframe(nyx, 270, 270, 175, 1.1).
warframe(oberon, 365, 270, 175, 1).

%pertenece(faccion,salud,escudos,energia,velocidad).
pertenece(tenno,1.05,1.05,1.05,1.05).
pertenece(grineer, 1, 1, 1.1, 1).
pertenece(corpus, 1, 1.1, 1, 1).
pertenece(infestacion, 0.95, 1, 1.15, 1).
pertenece(orokin, 1, 1, 1, 1.1).
pertenece(consciente, 1.15, 0.95, 1, 1).
pertenece(stalker, 1, 1, 0.95, 1.15).
pertenece(sindicato, 1, 1.15, 1, 0.95).
pertenece(sin_afiliacion, 1, 1, 1, 1).

% Regla para calcular la mejora por faccion
aumentoPorFaccion(Nombre,Salud,Escudo,Energia,Velocidad,Faccion):-
warframe(Nombre,SaludBase,EscudoBase,EnergiaBase,VelocidadBase),pertenece(Faccion,S1,E1,EN1,V1),
Salud is SaludBase * S1,
Escudo is EscudoBase * E1,
Energia is EnergiaBase * EN1, 
Velocidad is VelocidadBase * V1.

% Regla para calcular la mejora por rango
aumentoPorRango(Nombre,Salud,Escudo,Energia,Velocidad,Rango,Faccion):-
aumentoPorFaccion(Nombre,SaludMejorada,EscudoMejorado,EnergiaMejorada,VelocidadMejorada,Faccion),
(Rango > 30 ->  RangoAjustado is 30; RangoAjustado is Rango),
Salud is RangoAjustado * (SaludMejorada * 0.05) ,
Escudo is RangoAjustado * (EscudoMejorado * 0.05),
Energia is RangoAjustado * (EnergiaMejorada * 0.05),
Velocidad is RangoAjustado * (VelocidadMejorada * 0.05).

%Regla para calcular el aumento total
aumentoTotal(Nombre, SaludFinal, EscudoFinal, EnergiaFinal, VelocidadFinal, Faccion, Rango) :-
    aumentoPorFaccion(Nombre, SaludFaccion, EscudoFaccion, EnergiaFaccion, VelocidadFaccion, Faccion),
    aumentoPorRango(Nombre, SaludRango, EscudoRango, EnergiaRango, VelocidadRango, Rango,Faccion),
    SaludFinal is SaludFaccion + SaludRango,
    EscudoFinal is EscudoFaccion + EscudoRango,
    EnergiaFinal is EnergiaFaccion + EnergiaRango,
    VelocidadFinal is VelocidadFaccion + VelocidadRango.

% Regla para realizar un ataque
ataque(EnergiaAtacante, SaludDefensor, EscudoDefensor,NuevaSaludDefensor, NuevoEscudoDefensor) :-
    
    % ... (lógica de tu ataque, actualiza las estadísticas del Defensor en base al Atacante)
    % 
    %Energia mayor que los escudos, la diferencia se resta a la salud del defensor      
    (EnergiaAtacante > EscudoDefensor -> NuevaSaludDefensor is SaludDefensor - (EnergiaAtacante - EscudoDefensor), NuevoEscudoDefensor is EscudoDefensor;
    %Energia menor que los escudos, el 150% de la diferencia se resta a los escudos del defensor
	EnergiaAtacante < EscudoDefensor ->  NuevoEscudoDefensor is EscudoDefensor -((EscudoDefensor - EnergiaAtacante) * 1.5), NuevaSaludDefensor is SaludDefensor;    %si la energia no es mayor ni menor a los escudos,entonces son iguales
    %Energia igual a los escudos, los escudos pierden un 15% de su valor
    EnergiaAtacante == EscudoDefensor ->  NuevoEscudoDefensor is EscudoDefensor - (EscudoDefensor * 0.15), NuevaSaludDefensor is SaludDefensor).
  
% Regla para realizar la batalla
batalla(Atacante, Defensor, Salud1, Escudo1, Energia1, Salud2, Escudo2, Energia2, Ganador) :-
    
    % Realizar el ataque del Atacante al Defensor
    ataque(Energia1, Salud2, Escudo2,NuevaSaludDefensor, NuevoEscudoDefensor),

    % Verificar si el Defensor ha perdido
    (NuevaSaludDefensor =< 0 ->  Ganador = Atacante;
     % Si el Defensor sigue con vida, realizar la contraofensiva
     batalla(Defensor, Atacante, NuevaSaludDefensor, NuevoEscudoDefensor, Energia2, Salud1, Escudo1, Energia1, Ganador)).    

  
% Regla para determinar qué warframe ataca primero
warframeConMayorVelocidad(Warframe1, Warframe2, Velocidad1, Velocidad2, Atacante, Defensor) :-
    (Velocidad1 > Velocidad2 ->   Atacante = Warframe1, Defensor = Warframe2;
     Velocidad2 > Velocidad1 ->   Atacante = Warframe2, Defensor = Warframe1;
    Velocidad1 == Velocidad2 ->  Atacante = Warframe1, Defensor = Warframe2).

% Regla para iniciar el combate 1vs1
%combate(ash,infestacion,15,garuda,tenno,12).
combate(Warframe1, Faccion1, Rango1, Warframe2, Faccion2, Rango2) :-
    
    % Obtener las estadísticas finales de los warframes
    aumentoTotal(Warframe1, Salud1, Escudo1, Energia1, Velocidad1, Faccion1, Rango1),
    aumentoTotal(Warframe2, Salud2, Escudo2, Energia2, Velocidad2, Faccion2, Rango2),
    
	%encontramos el warframe de mayor velocidad para que sea el primero en atacar
	warframeConMayorVelocidad(Warframe1,Warframe2,Velocidad1,Velocidad2,Atacante,Defensor),
    
    
     % Comenzar la batalla hasta que uno de los warframes alcance 0 de salud
    (Atacante == Warframe1 ->  batalla(Warframe1, Warframe2, Salud1, Escudo1, Energia1, Salud2, Escudo2, Energia2, Ganador);batalla(Defensor, Atacante, Salud2, Escudo2, Energia2, Salud1, Escudo1, Energia1,Ganador)),
	write('El ganador del combate '), write(Warframe1), write(' Vs '), write(Warframe2), write(' es: '), write(Ganador).