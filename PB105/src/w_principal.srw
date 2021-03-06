$PBExportHeader$w_principal.srw
forward
global type w_principal from window
end type
type st_tiempo from statictext within w_principal
end type
type st_nivel from statictext within w_principal
end type
type dw_1 from datawindow within w_principal
end type
end forward

global type w_principal from window
integer width = 2382
integer height = 2640
boolean titlebar = true
string title = "PowerBuilder Sudoku"
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_tiempo st_tiempo
st_nivel st_nivel
dw_1 dw_1
end type
global w_principal w_principal

type variables
time it_inicio,it_ahora

end variables

forward prototypes
public function boolean wf_esta_completo (integer ai_arreglo[], integer ai_fil, integer ai_col, integer ai_valor)
public subroutine wf_iniciar ()
public function integer wf_pinta_sudoku (integer ai_arreglo[])
public function string wf_validar (integer fila, integer col, integer valor)
end prototypes

public function boolean wf_esta_completo (integer ai_arreglo[], integer ai_fil, integer ai_col, integer ai_valor);Int li_filas,li_col,li_cont
Int aux1,aux2
li_cont = 1
String ls_cadena
For li_filas = 1 To 9
	For li_col = 1 To 9
		aux1 = ai_arreglo[li_cont]
		If ai_fil = li_filas And li_col = ai_col Then
			aux2 =  ai_valor
		Else
			aux2 =  dw_1.GetItemNumber( li_filas,li_col)
		End If
		If IsNull(aux2) Then
			aux2 = 0
		End If
		If  aux1 <> aux2 Then
			Return False
		End If
		li_cont ++
	Next
Next
Return True


end function

public subroutine wf_iniciar ();
dw_1.Reset( )
dw_1.DataObject = "d_tablero"
guo_sudoku.uf_reiniciar_juego(gi_pos)
wf_pinta_sudoku(guo_sudoku.ii_sudoku_inicial )
dw_1.SetFocus( )

it_inicio = Now()
Timer(1)

//iuo_sudoku.uf_validar_celda(49)

end subroutine

public function integer wf_pinta_sudoku (integer ai_arreglo[]);Int li_filas,li_col,li_cont
li_cont = 1
String ls_cadena
For li_filas = 1 To 9
	For li_col = 1 To 9
		If ai_arreglo[li_cont] > 0 Then
			dw_1.SetItem( li_filas,li_col,ai_arreglo[li_cont])
		End If
		li_cont ++
	Next
Next
Return 1


end function

public function string wf_validar (integer fila, integer col, integer valor);//calculate region
Integer li_region,li_col_region,li_fila_region
Int li_filas,li_col,li_cont,li_valor

Choose Case fila
	Case 1 To 3
		Choose Case col
			Case 1 To 3
				li_region = 1
			Case 4 To 6
				li_region = 2
			Case 7 To 9
				li_region = 3
		End Choose
	Case 4 To 6
		Choose Case col
			Case 1 To 3
				li_region = 4
			Case 4 To 6
				li_region = 5
			Case 7 To 9
				li_region = 6
		End Choose
	Case 7 To 9
		Choose Case col
			Case 1 To 3
				li_region = 7
			Case 4 To 6
				li_region = 8
			Case 7 To 9
				li_region = 9
		End Choose
End Choose

Choose Case li_region
	Case 1
		li_col_region = 1
		li_fila_region = 1
	Case 2
		li_col_region = 4
		li_fila_region = 1
	Case 3
		li_col_region = 7
		li_fila_region = 1
	Case 4
		li_col_region = 1
		li_fila_region = 4
	Case 5
		li_col_region = 4
		li_fila_region = 4
	Case 6
		li_col_region = 7
		li_fila_region = 4
	Case 7
		li_col_region = 1
		li_fila_region = 7
	Case 8
		li_col_region = 4
		li_fila_region = 7
	Case 9
		li_col_region = 7
		li_fila_region = 7
		
End Choose

li_cont = 0
//validar la fila

li_valor = valor
For li_filas = 1 To 9
	If dw_1.GetItemNumber( li_filas, col) = li_valor  Then
		li_cont ++
	End If
Next

If li_cont > 0 Then Return "Column"


//validate the column

For li_col = 1 To 9
	If dw_1.GetItemNumber( fila, li_col) = li_valor  Then
		li_cont ++
	End If
Next

If li_cont > 0 Then Return "Row"

//validate the region
//		li_col_region = 1
//		li_fila_region = 1
li_cont = 0
For li_filas = li_fila_region To li_fila_region + 2
	For li_col = li_col_region To li_col_region + 2
		If dw_1.GetItemNumber( li_filas, li_col) = li_valor  Then
			li_cont ++
		End If
	Next
Next

If li_cont > 0 Then Return "Region"


Return ""


end function

on w_principal.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.st_tiempo=create st_tiempo
this.st_nivel=create st_nivel
this.dw_1=create dw_1
this.Control[]={this.st_tiempo,&
this.st_nivel,&
this.dw_1}
end on

on w_principal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_tiempo)
destroy(this.st_nivel)
destroy(this.dw_1)
end on

event timer;it_ahora = now()
time lt_tiempo
st_tiempo.text = string(RelativeTime ( lt_tiempo, secondsafter(it_inicio,it_ahora)))
end event

event open;w_principal.wf_iniciar()
Timer ( 1, w_principal)
st_nivel.text = "Level: Beginner "
end event

type st_tiempo from statictext within w_principal
integer x = 1719
integer y = 2304
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "00:00:00"
boolean focusrectangle = false
end type

type st_nivel from statictext within w_principal
integer x = 110
integer y = 2336
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_principal
event ue_key pbm_dwnkey
integer x = 133
integer y = 68
integer width = 2094
integer height = 2116
integer taborder = 10
string title = "none"
string dataobject = "d_tablero"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;Int li_num

li_num = dw_1.GetItemNumber( dw_1.GetRow(),dw_1.GetColumn())
If Key = KeyLeftArrow! Then
	This.SetColumn(This.GetColumn()-1)
End If

If Key = KeyRightArrow! Then
	This.SetColumn(This.GetColumn()+1)
Else
	If( f_celda_original(dw_1.GetRow(),dw_1.GetColumn(),li_num )   )Then
	dw_1.SetItem( dw_1.GetRow(),dw_1.GetColumn(),li_num)
End If
End If

end event

event itemchanged;String ls_retorno

ls_retorno = ""
ls_retorno = wf_validar(row,dw_1.GetColumn( ),Integer(Data))
If ls_retorno = "" Then
	If wf_esta_completo(guo_sudoku.ii_sudoku_solucion ,row,dw_1.GetColumn( ),Integer(Data)) Then
		Timer(0)
		messagebox ("congratulations", "the soduku is over. consider yourself a master")
		
	End If
	Return 0
Else
	If MessageBox ("Repeated Number", "This value already exists in the same" + ls_retorno + ". ~ Do you want to remove this invalid value?", Question!, Yesno!) = 1 Then
		Return 2
	Else
		Return 3
	End If
End If




end event

