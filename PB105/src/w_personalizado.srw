$PBExportHeader$w_personalizado.srw
forward
global type w_personalizado from window
end type
type em_1 from editmask within w_personalizado
end type
type cb_cancelar from commandbutton within w_personalizado
end type
type cb_aceptar from commandbutton within w_personalizado
end type
type st_1 from statictext within w_personalizado
end type
end forward

global type w_personalizado from window
integer width = 1326
integer height = 660
boolean titlebar = true
string title = "Choices"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_1 em_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
st_1 st_1
end type
global w_personalizado w_personalizado

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();If Integer(em_1.Text) > 80 Then
	MessageBox ("", "The generated values cannot be greater than 80")
	Return -1
Else
	If Integer(em_1.Text) < 25 Then
		MessageBox ("", "The generated values cannot be greater than 25")
		Return -1
	End If
End If
Return 0

end function

on w_personalizado.create
this.em_1=create em_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.st_1=create st_1
this.Control[]={this.em_1,&
this.cb_cancelar,&
this.cb_aceptar,&
this.st_1}
end on

on w_personalizado.destroy
destroy(this.em_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.st_1)
end on

type em_1 from editmask within w_personalizado
integer x = 73
integer y = 224
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type cb_cancelar from commandbutton within w_personalizado
integer x = 841
integer y = 288
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "cancel"
end type

event clicked;Close(Parent)

end event

type cb_aceptar from commandbutton within w_personalizado
integer x = 841
integer y = 96
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "accept"
end type

event clicked;If wf_validar() = 0 Then
	gi_pos =  Integer(em_1.Text)
	Close(Parent)
End If

end event

type st_1 from statictext within w_personalizado
integer x = 73
integer y = 64
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
string text = "Total Number"
boolean focusrectangle = false
end type

