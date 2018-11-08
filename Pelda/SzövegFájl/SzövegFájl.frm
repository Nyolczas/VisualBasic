VERSION 5.00
Begin VB.Form FormSz�vegF�jl 
   AutoRedraw      =   -1  'True
   Caption         =   "Sz�vegF�jl"
   ClientHeight    =   2880
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   5016
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   12
      Charset         =   238
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   2880
   ScaleWidth      =   5016
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton GombBeolvas 
      Caption         =   "&Beolvas"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   7.8
         Charset         =   238
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   2520
      TabIndex        =   0
      Top             =   1080
      Width           =   1212
   End
End
Attribute VB_Name = "FormSz�vegF�jl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
' t�bb p�lda
'   sz�vegf�jl beolvas�sa
'   Split f�ggv�ny haszn�lat�ra
'   FormatNumber haszn�lat�ra
' FIGYELEM! A Timer haszn�lata nem szabatos (ha a k�t v�grehajt�sa k�z� esik
'   �jf�l, akkor hib�s eredm�nyt ad)
Dim F�jlRendszer As FileSystemObject, Sz�vegF�jl As TextStream
' dinamikus karakterl�nct�mb�k
Dim ST�mb() As String, ST�mb2() As String
' az ST�mb indexe long legyen, mert bizony 32 ezer sorn�l t�bb is el�fordulhat
Dim i As Long, MaxSorhossz As Long, F�jlN�v As String, Id� As Single
' a For Each ciklus csak variant t�pus� ciklusv�ltoz�t fogad el
Dim V

Private Sub GombBeolvas_Click()
' he-he, j� kis sz�vegf�jl, mi?
F�jlN�v = App.EXEName & ".frm"
If F�jlRendszer.FileExists(F�jlN�v) Then
  Print "Kis t�relmet..."
  MousePointer = vbHourglass: GombBeolvas.Enabled = False
  Id� = Timer: DoEvents
  Set Sz�vegF�jl = F�jlRendszer.OpenTextFile(F�jlN�v)
  ' a Split az els� param�ter�ben megadott karakterl�ncot szeleteli fel
  ' a m�sodik param�terben megadott karakterl�nc "ment�n"
  ST�mb = Split(Sz�vegF�jl.ReadAll, vbNewLine): Sz�vegF�jl.Close
  ' k�sz vagyunk, az ST�mb nev� karakterl�nct�mbben van a sz�vegf�jl,
  ' a t�mb minden eleme a sz�veg egy-egy sora
  
  ' egyik p�lda a FormatNumber haszn�lat�ra,
  ' a FormatNumber a Vez�rl�pult "Ter�leti be�ll�t�sok" be�ll�t�sait haszn�lja
  Me.Cls: Print "Beolvas�s ideje: " & FormatNumber(Timer - Id�)
  MousePointer = vbDefault: GombBeolvas.Enabled = True: DoEvents
  
  ' m�sik p�lda a FormatNumber haszn�lat�ra,
  ' itt fel�lb�r�ljuk a Vez�rl�pult "Ter�leti be�ll�t�sok"-ban megadott
  ' tizedesjegyek sz�m�t
  Print "Sorok sz�ma: " & FormatNumber(UBound(ST�mb) - LBound(ST�mb) + 1, 0)
  
  ' leghosszabb sor hossz�nak meg�llap�t�sa
  MaxSorhossz = 0
  For Each V In ST�mb
    If Len(V) > MaxSorhossz Then MaxSorhossz = Len(V)
  Next
  Print "Leghosszabb sor hossza: " & FormatNumber(MaxSorhossz, 0)
  
  ' p�lda v�logat�sra:
  '   ST�mb2-ben azok a sorok lesznek, amelyek tartalmazz�k a m�sodik
  '   param�terk�nt megadott karakterl�ncot
  ST�mb2 = Filter(ST�mb, "valami")
Else
  MsgBox " Nem l�tez� f�jl: " & F�jlN�v: Beep
End If
End Sub

Private Sub Form_Load()
' a k�telez� penzum
Set F�jlRendszer = CreateObject("Scripting.FileSystemObject")
End Sub

Private Sub Form_Unload(Cancel As Integer)
' kitakar�tunk
Set F�jlRendszer = Nothing: Set Sz�vegF�jl = Nothing
End Sub


