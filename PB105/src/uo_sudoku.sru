$PBExportHeader$uo_sudoku.sru
forward
global type uo_sudoku from nonvisualobject
end type
end forward

global type uo_sudoku from nonvisualobject
end type
global uo_sudoku uo_sudoku

type variables
int ii_celdas[],ii_celdas_posibles[], ii_sudoku_solucion[]
int ii_sudoku_inicial[] 
int ii_numeros_solucionados = 0

 //Variable que contiene la opcion del menu que esta activada:
 int ii_opcion_activada = 0;
 //Variable que guarada los numeros iniciales que se muestran al comenzar el sudoku (minimo deberian ser 17, aunque hay quien asegura que algunos basta con 16):
 int ii_numeros_iniciales = 28;

 //Variable que alternara mostrar/ocultar solucion:
 boolean ib_ver_solucion = false;
end variables

forward prototypes
public subroutine uf_vaciar_sudoku ()
public function boolean uf_solucionar_sudoku (integer ai_celda)
public subroutine uf_barajar (ref integer ai_arreglo[])
public function boolean uf_validar_celda (integer celda)
public subroutine uf_crear_sudoku ()
public subroutine uf_calcular_casillas_libres (ref integer casillas_libres[])
public function boolean uf_validar_sudoku (boolean salir_al_fallar)
public subroutine uf_iniciar_juego (integer ai_numeros)
public function boolean uf_reiniciar_juego (integer ai_numeros_iniciales)
end prototypes

public subroutine uf_vaciar_sudoku ();//====================================================================
// Function: uo_sudoku.uf_vaciar_sudoku()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_vaciar_sudoku ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int X

ii_numeros_solucionados = 0

For X = 1 To 81
	// The arrays are deleted:
	ii_celdas[X] = 0;
	ii_sudoku_solucion[X] = 0;
	ii_sudoku_inicial[X] = 0;
	// The default font color is set:
// The cell is emptied:
	
Next


end subroutine

public function boolean uf_solucionar_sudoku (integer ai_celda);//====================================================================
// Function: uo_sudoku.uf_solucionar_sudoku()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ai_celda	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_solucionar_sudoku ( integer ai_celda )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Boolean lb_sudoku_solucionado = False

// If the sudoku has already been solved, the function is exited, returning true:
If (ii_numeros_solucionados >= 81) Then
	Return True
End If

// If the box is already full, the function is called again with the subsequent one (as long as it is not in the last cell, 81):
If ( ii_celdas[ai_celda] <> 0 And ai_celda <= 81) Then
	lb_sudoku_solucionado = uf_solucionar_sudoku(ai_celda+1)
	// If the sudoku has been solved, it returns true:
	If (lb_sudoku_solucionado) Then
		Return True
	Else //... but if not, false is returned:
		Return False
	End If
End If
// An array is created with the number from 1 to 8, and then shuffled:
Int li_numeros_barajados[]
uf_barajar(li_numeros_barajados) // It is shuffled.

Boolean es_valido = False
Int e
// A loop is performed to test numbers in the box:

For e = 1 To 9
	// The shuffled number is inserted into the cell:
	ii_celdas[ai_celda] = li_numeros_barajados[e]
	// It is checked if it is valid:
	
	es_valido = uf_validar_celda(ai_celda)
	// If the sudoku is valid, it is called to solve the subsequent cell:
	If (es_valido) Then
		
		// The value of the solved numbers is increased:
		ii_numeros_solucionados++
		// It is called to solve the subsequent cell:
		lb_sudoku_solucionado = uf_solucionar_sudoku(ai_celda+1)
		// If it has been solved, it returns true:
		If (lb_sudoku_solucionado) Then
			Return True
			// ... and if not, the entered cell is deleted:
		Else
			ii_celdas[ai_celda] = 0
			ii_numeros_solucionados --
		End If
		
		// ... and if not, the entered cell is deleted:
	Else
		ii_celdas[ai_celda] = 0
	End If
Next

// If it has come this far, it is that no solution has been found, so the entered cell is deleted and returns false:
ii_celdas[ai_celda] = 0
// solved_numbers--
Return False



end function

public subroutine uf_barajar (ref integer ai_arreglo[]);//====================================================================
// Function: uo_sudoku.uf_barajar()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	integer	ai_arreglo[]	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_barajar ( ref integer ai_arreglo[] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int numeros_barajados[9],f,numero_aleatorio,g
Boolean se_encuentra
For f = 1 To 9
	// We create a random number:
	numero_aleatorio = Rand(9)
	// We check if the number is already in the array:
	se_encuentra = False
	For g = 1 To 9
		// If it is already in the array, it exits the loop:
		If (numeros_barajados[g] = numero_aleatorio) Then
			se_encuentra = True
			//  break;
			g = 10
		End If
	Next
	// If found, the loop is repeated without counting the loop:
	If (se_encuentra) Then
		f --
		Continue;
		//... but if not, it is entered in the new shuffled array:
	Else
		numeros_barajados[f] = numero_aleatorio;
	End If
Next
// The shuffled matrix is returned:
ai_arreglo = numeros_barajados


end subroutine

public function boolean uf_validar_celda (integer celda);//====================================================================
// Function: uo_sudoku.uf_validar_celda()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	celda	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_validar_celda ( integer celda )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//Funcion que valida si una celda es valida o no:

Int numero_fila = 0
Int numero_columna = 0
Int numero_region = 0
Int num_inicial_fila = 0
Int num_inicial_columna = 0;
Int num_inicial_region
Double ldbl_1 = 0,ldbl_2 = 0 ,ldbl_3 = 0

numero_fila  = Ceiling(Double(celda/9));
numero_columna = celda - ((numero_fila - 1) * 9);
numero_region = (3 * Ceiling(Double(numero_fila/3))) - (3 - Ceiling(Double(numero_columna/3)))
num_inicial_columna = numero_columna;

num_inicial_fila =  numero_fila - 1
num_inicial_fila = (9 * num_inicial_fila) + 1;
ldbl_1 = Double(numero_fila/3)
ldbl_2 = Ceiling(Double(ldbl_1))
ldbl_3 = ldbl_2 -1
ldbl_3 *= 3
ldbl_3 *= 9
num_inicial_region	  = ldbl_3
ldbl_1 = Double(numero_columna/3)
ldbl_2 = Ceiling(ldbl_1)
ldbl_3 = ldbl_2 -1
ldbl_3 *= 3
ldbl_3 += 1
//num_inicial_region	  = ((Ceiling(double(numero_fila/3)) - 1) * 3 * 9) + 					((Ceiling(double(numero_columna/3)) - 1) * 3) + 1;
num_inicial_region = num_inicial_region + ldbl_3


// ((Math.ceil(numero_fila/3) - 1) * 3 * 9) + ((Math.ceil(numero_columna/3) - 1) * 3) + 1;

// We calculate that nothing is repeated in the cell region:
Boolean numeros_usados[]
Int n = 1;
For n = 1 To 9
	numeros_usados[n] = False
Next
Int contador = 1;
For n = num_inicial_region To num_inicial_region+20
	If ii_celdas[n] <> 0 Then
		If (numeros_usados[ii_celdas[n]] = True   ) Then
			Return False // If it is repeated, the function is exited, returning false.
		Else
			numeros_usados[ii_celdas[n]] = True // If it is being used, it is set as such.
		End If
	End If
	If (contador = 3) Then
		n += 6
		contador = 0
	End If
	contador++
Next

// We calculate that nothing is repeated in the cell row:
For n = 1 To 9
	numeros_usados[n] = False
Next

For n = num_inicial_fila To num_inicial_fila+8
	If ii_celdas[n] <> 0 Then
		If (numeros_usados[ii_celdas[n]] = True   ) Then
			Return False // If it is repeated, the function is exited, returning false.
		Else
			numeros_usados[ii_celdas[n]] = True // If it is being used, it is set as such.
		End If
	End If
Next

// We calculate that nothing is repeated in the cell column:
For n = 1 To 9
	numeros_usados[n] = False
Next

For n = num_inicial_columna To num_inicial_columna+72 Step 9
	If ii_celdas[n] <> 0 Then
		If (numeros_usados[ii_celdas[n]] = True  ) Then
			Return False // If it is repeated, the function is exited, returning false.
		Else
			numeros_usados[ii_celdas[n]] = True // If it is being used, it is set as such.
		End If
	End If
Next

// If it has come this far, everything works fine, so it returns true:
Return True




end function

public subroutine uf_crear_sudoku ();//====================================================================
// Function: uo_sudoku.uf_crear_sudoku()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_crear_sudoku ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Boolean sudoku_valido
// The number sudoku is emptied:
uf_vaciar_sudoku()

// An attempt is made to solve a random sudoku puzzle:
Boolean sudoku_solucionado
sudoku_solucionado	  = uf_solucionar_sudoku(1);
// If it could not be solved, the function is called again:
If (Not sudoku_solucionado) Then
	uf_crear_sudoku();
	Return;
	// ... but if it has been solved, save the solved sudoku in sudoku_solucion, put the initial numbers in the cell matrix and then continue:
Else
	Int j
	For j = 1 To 81
		ii_sudoku_solucion[j] = ii_celdas[j]
		ii_celdas[j] = 0;
	Next
End If

// Variables that will contain the region number, box and random number:
Int casillas_libres[],X
Int casilla_aleatoria_posicion
Int casilla_aleatoria = 0;
// The numbers are put in the sudoku:
For X = 1 To ii_numeros_iniciales
	
	// A random box is calculated that is valid (from 0 to sizeof (free_squares) -1):
	uf_calcular_casillas_libres(casillas_libres);
	
	casilla_aleatoria_posicion = Rand( 	 UpperBound(casillas_libres))
	casilla_aleatoria = casillas_libres[casilla_aleatoria_posicion]
	
	// If the box is empty, it is calculated if the sudoku is valid and if so, enter:
	If (ii_celdas[casilla_aleatoria] = 0 And ii_sudoku_solucion[casilla_aleatoria] <> 0) Then
		
		// Enter the number in the box:
		ii_celdas[casilla_aleatoria] = ii_sudoku_solucion[casilla_aleatoria];
		
		// Check if the sudoku is valid:
		sudoku_valido = uf_validar_sudoku(True);
		
		// If the sudoku is not valid, the entered box is deleted and the loop is done again without counting this loop:
		If (Not sudoku_valido)  Then
			ii_celdas[casilla_aleatoria] = 0;
			X --;
			Continue;
		End If
		
		// ... and if not, the loop is done again without counting this loop:
	Else
		X --
		Continue
	End If
Next

// The sudoku is validated:

sudoku_valido = False
sudoku_valido = uf_validar_sudoku(True);
// If the sudoku is not valid, call the function again:
If (Not sudoku_valido) Then
	uf_crear_sudoku();
	//... but if it is valid, the map is created (the sudoku is represented):
Else
	
	For X = 1 To 81
		
		// If the cell is not empty, it is represented:
		If (ii_celdas[X] <> 0 ) Then
			// document.getElementById (x) .innerHTML = cells [x];
			// document.getElementById (x) .style.color = "# aa0000"; }
			// It is stored in the matrix that contains the initial sudoku:
			ii_sudoku_inicial[X] = ii_celdas[X];
		End If
	Next
	// The loading message stops showing:
	// eye show_message ("", false);
End If




end subroutine

public subroutine uf_calcular_casillas_libres (ref integer casillas_libres[]);//====================================================================
// Function: uo_sudoku.uf_calcular_casillas_libres()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	integer	casillas_libres[]	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_calcular_casillas_libres ( ref integer casillas_libres[] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int a
Int b = 1;
For a = 1 To 81
	If (ii_celdas[a] = 0) Then
		casillas_libres[b] = a
		b++
	End If
Next





end subroutine

public function boolean uf_validar_sudoku (boolean salir_al_fallar);//====================================================================
// Function: uo_sudoku.uf_validar_sudoku()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	boolean	salir_al_fallar	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_validar_sudoku ( boolean salir_al_fallar )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


// Check that no number is repeated by regions:
// int num_region = 1
// int a, b
// boolean region [9,9]
// for a = 1 to 9
// for b = 1 to 9
// region [a, b] = false
// next
// next
//
//
// for a = 1 to 61 step 3
// // a ++
// for b = a to a + 20
// if (b = a + 3) then
// b = b - 3 + 9
// else
// if (b = a + 12) then
// b = b - 12 + 18
// end if
// end if
// if (ii_cells [b] <> 0 and not isnull (ii_cells [b])) then
//
// if (region [num_region, ii_cells [b]] = true) and (exit_on_fail) then
// return false
// else
// region [num_region, ii_cells [b]] = true
// end if
// end if
// next
// if (a = 7 or a = 34) then
// a + = 18
// end if
// num_region ++
// next
//
// // Check that no number is repeated by rows:
// integer row_num = 1;
// boolean row [9,9]
// for a = 1 to 9
// for b = 1 to 9
// row [a, b] = false
// next
// next
//
// b = 1;
// for a = 1 to 81
//
// if (b> 9) then b = 1
// row_num ++
// if (ii_cells [a] <> 0 and not isnull (ii_cells [a])) then
//
// if (row [row_num, ii_cells [a]] = true and exit_on_fail) then
// return false
// else
// row [row_num, ii_cells [a]] = true
// end if
// end if
// b ++;
// next
//
//
//
//
//
// // Check that no number is repeated by columns:
// boolean column [9,9]
//
// for a = 1 to 9
// for b = 1 to 9
// column [a, b] = false
// next
// next
//
// for a = 1 to 9
//
// for b = a to 81 step 9
//
// if (ii_cells [b] <> 0) and (not isnull (ii_cells [b])) then
//
// if column [a, ii_cells [b]] = true and exit_on_fail then
// return false
// else
// column [a, ii_cells [b]] = true
// end if
// end if
// next
// next
// // If it gets this far, everything has gone well:
Return True




end function

public subroutine uf_iniciar_juego (integer ai_numeros);//====================================================================
// Function: uo_sudoku.uf_iniciar_juego()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ai_numeros	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_iniciar_juego ( integer ai_numeros )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

ii_numeros_iniciales = ai_numeros
uf_crear_sudoku()


end subroutine

public function boolean uf_reiniciar_juego (integer ai_numeros_iniciales);//====================================================================
// Function: uo_sudoku.uf_reiniciar_juego()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ai_numeros_iniciales	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/06/16
//--------------------------------------------------------------------
// Usage: uo_sudoku.uf_reiniciar_juego ( integer ai_numeros_iniciales )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int numeros_iniciales_provisional
numeros_iniciales_provisional = ai_numeros_iniciales
// If the initial numbers is not a number or is invalid, it is notified, returns to the previous number and exits the function:
If (numeros_iniciales_provisional < 0 Or numeros_iniciales_provisional > 81 Or IsNull(numeros_iniciales_provisional)) Then
	MessageBox ("The initial numbers are not valid", "You must type Numbers between 20 and 81");
	Return False;
	// If you press accept, the game is restarted:
Else
	
	// Show the default option in the div to see solution again:
	// document.getElementById ("div_solucion"). innerHTML = "see solution";
	// document.getElementById ('div_solucion'). title = 'Shows sudoku solved';
	// see_solution = false;
	
	// Start the game again:
	uf_iniciar_juego(ai_numeros_iniciales);
	
	// ... and if not, the previous number is put back:
	
End If


end function

on uo_sudoku.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sudoku.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

