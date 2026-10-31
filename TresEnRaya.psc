//TRES EN RAYA
//
// ** ** **
// ** ** **
// ** ** **
//
// ** O **
// ** O **
// ** O **
//
// U ** **
// ** U **
// ** ** U

//Función que muestra el tablero que se le pasa como parámetro
Funcion MostrarTablero(tableroJuego, jugada)
	//1. Definir e inicializar variables
	Definir fila, columna Como Entero
	fila = 0
	columna = 0
	//2. Letrero
	Escribir ""
	Escribir " --------------------"
	Escribir "| TABLERO - JUGADA ", jugada " |"
	Escribir " --------------------"
	Escribir ""
	
	//3. Mostrar el tablero de juego
	Para fila = 0 Hasta 2 Con Paso 1 Hacer
		Para columna = 0 Hasta 2 Con Paso 1 Hacer
			Escribir tableroJuego[fila,columna] " " Sin Saltar
		FinPara
		Escribir ""
	FinPara
	
	Escribir ""
FinFuncion

//Función que revisa el tablero que se le pasa como parámetro, comprobando si hay algún ganador
Funcion hayGanador = ComprobarGanador(tableroJuego)
	//1. Definir e inicializar variables
	Definir i Como Entero
	Definir hayGanador Como Logico
	hayGanador = Falso
	i = 0
	//2. Comprobamos si hay alguna fila completa con U's o O´s, que no sean "**"
	Para i = 0 Hasta 2 Con Paso 1 Hacer
		Si (tableroJuego[i,0] <> "**") Y (tableroJuego[i,0] = tableroJuego[i,1]) Y (tableroJuego[i,1] = tableroJuego[i,2]) Entonces
			hayGanador = Verdadero
		FinSi
	FinPara
	//3. Comprobamos si hay alguna columna completa con U's o O's, que no sean "**"
	Para i = 0 Hasta 2 Con Paso 1 Hacer
		Si (tableroJuego[0,i] <> "**") Y (tableroJuego[0,i] = tableroJuego[1,i]) Y (tableroJuego[1,i] = tableroJuego[2,i]) Entonces
			hayGanador = Verdadero
		FinSi
	FinPara
	//4. Comprobamos si alguna de las dos diagonales está completa con XU's o O's, que no sean "**"
	Si (tableroJuego[0,0] <> "**") Y (tableroJuego[0,0] = tableroJuego[1,1]) Y (tableroJuego[1,1] = tableroJuego[2,2]) Entonces
		hayGanador = Verdadero
	FinSi
	Si (tableroJuego[0,2] <> "**") Y (tableroJuego[0,2] = tableroJuego[1,1]) Y (tableroJuego[1,1] = tableroJuego[2,0]) Entonces
		hayGanador = Verdadero
	FinSi
FinFuncion

//Juego de las Tres en Raya
Algoritmo TresEnRaya
	//1. Definir e inicializar variables
	Definir fila, columna, numeroJugada, jugador, filajugada, columnajugada Como Entero
	Definir tablero Como Texto
	Definir hayGanador, posicioncorrecta Como Logico
	fila = 0
	columna = 0
	jugador = 0
	numeroJugada = 0
	filajugada = 0
	columnajugada = 0
	hayGanador = Falso
	posicioncorrecta = Falso
	Dimension tablero[3,3]
	//1.1. Inicializar las posiciones del tablero con texto "**"
	Para fila = 0 Hasta 2 Con Paso 1 Hacer
		Para columna = 0 Hasta 2 Con Paso 1 Hacer
			tablero[fila,columna] = "**"
		FinPara
	FinPara
	
	//2. Empieza el juego
	//2.1. Comenzamos mostrando el tablero vacío
	MostrarTablero(tablero, numeroJugada)
		//Elegimos quien empieza primero
	jugador = azar(2) //1 --> Ordenador; 0 --> Usuario
	Mientras (numeroJugada < 9) Y (hayGanador = Falso) Hacer
		numeroJugada = numeroJugada + 1
		posicioncorrecta = Falso
		//2.2. En el caso de que sea el turno del jugador... (el usuario pone "U")
		Si (jugador = 0) Entonces
			Escribir "¡Es tu turno!"
			Esperar 3 segundos
		//2.2.1. Pedir al usuario que elija una fila y una columna, hasta que introduzca una posición vacía (tablero[fila,columna] = "**")
		//y poner la ficha del jugador (tablero[fila,columna] = "U")
			Mientras (posicioncorrecta = Falso) Hacer
				Escribir "Introduce un número de fila [0,2]"
				Leer filajugada
				Escribir "Introduce un número de columna [0,2]"
				Leer columnajugada
				Si tablero[filajugada,columnajugada] = "**" Entonces
					posicioncorrecta = Verdadero
					tablero[filajugada,columnajugada] = "U"
				SiNo
					Escribir "Esa posición ya está ocupada"
				FinSi
			FinMientras
		//2.3. En el caso de que sea el turno del ordenador... (el ordenador pone "O")
		SiNo
			Escribir  "Mi turno >:)"
			Esperar 3 segundos
		//2.3.1. Hacer que el ordenador elija una fila y una columna al azar, hasta que introduzca una posición vacía (tablero[fila,columna] = "**")
		//y poner la ficha del ordenador (tablero[fila,columna] = "O")
			Mientras (posicioncorrecta = Falso) Hacer
				filajugada = azar(3)
				columnajugada = azar (3)
				Si tablero[filajugada,columnajugada] = "**" Entonces
					posicioncorrecta = Verdadero
					tablero[filajugada, columnajugada] = "O"
					Escribir "He colocado una ficha en la posición [" filajugada, "," columnajugada "]"
					Escribir "¡Te toca!"
				FinSi
			FinMientras
		FinSi
		//2.4. Mostramos el tablero después de poner la ficha
		MostrarTablero(tablero,numeroJugada)
		//2.5. Comprobamos si ha ganado el jugador que acaba de poner ficha, y si es así, lo decimos y terminamos el juego (función ComprobarGanador(tablero))
		hayGanador = ComprobarGanador(tablero)
		Si (hayGanador = Verdadero) Y (jugador = 0) Entonces
			Escribir "HAS GANADO"
			Escribir "¡¡Has ganado en " numeroJugada " turnos!!"
			numeroJugada = 9
		Sino
			Si (hayGanador = Verdadero) Y (jugador = 1) Entonces
				Escribir "HAS PERDIDO"
				Escribir "¡¡He ganado en " numeroJugada " turnos!!"
				numeroJugada = 9
			FinSi
		FinSi
		//2.6. Cambiamos de jugador (Si acaba de jugar el ordenador, ahora le toca al jugador; y viceversa)
		Si jugador = 0 Entonces
			jugador = 1 //Pasamos el turno al ordenador
		SiNo
			jugador = 0 //Pasamos el turno al jugador
		FinSi
	FinMientras
	
	//3. En el caso de que no haya habido un ganador, mostrar que hemos empatado
	Si hayGanador = Falso Entonces
		Escribir "EMPATE"
	FinSi
FinAlgoritmo
