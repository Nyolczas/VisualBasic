﻿Public Class Form1
    Structure TTrade
        Dim OpenTime As Date
        Dim Type As String
        Dim Size As Single
        Dim OpenPrice As Single
        Dim CloseTime As Date
        Dim ClosePrice As Single
        Dim Profit As Single
        Dim Komment As String
        Dim ProfitPerc As String
        Dim Hozam As Single
        Dim HozamPerc As Single
    End Structure

    Dim Tradek(9999) As TTrade
    Dim N As Integer

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        ' beolvasás fileból
        Dim FileBe As New IO.StreamReader("AUDUSD_M5_Zoom.csv")
        Dim Temp() As String
        Dim TempHozam As Single
        Dim TempHozamPerc As Single
        TempHozam = 0
        TempHozamPerc = 0
        N = 0
        Do While FileBe.Peek <> -1
            Temp = FileBe.ReadLine.Split(";")
            N += 1
            TempHozam += CSng(Replace(Temp(6), ".", ","))
            Dim hossz As Integer = Len(Temp(8)) - 1
            Dim subString As String = CSng(Replace(Temp(8).Substring(0, hossz), ".", ","))
            TempHozamPerc += subString
            With Tradek(N)
                Label1.Text += N & vbNewLine
                .OpenTime = Temp(0)
                Label2.Text += Temp(0) & vbNewLine
                .Type = Temp(1)
                Label3.Text += Temp(1) & vbNewLine
                .Size = CSng(Replace(Temp(2), ".", ","))
                Label4.Text += Temp(2) & vbNewLine
                .OpenPrice = CSng(Replace(Temp(3), ".", ","))
                Label5.Text += Temp(3) & vbNewLine
                .CloseTime = Temp(4)
                Label6.Text += Temp(4) & vbNewLine
                .ClosePrice = CSng(Replace(Temp(5), ".", ","))
                Label7.Text += Temp(5) & vbNewLine
                .Profit = CSng(Replace(Temp(6), ".", ","))
                Label8.Text += Temp(6) & vbNewLine
                .Komment = Temp(7)
                Label9.Text += Temp(7) & vbNewLine
                .ProfitPerc = subString
                Label10.Text += Temp(8) & vbNewLine
                .Hozam = TempHozam
                Label12.Text += TempHozam & vbNewLine
                .HozamPerc = TempHozamPerc
                Label13.Text += TempHozamPerc & vbNewLine
            End With
        Loop
        FileBe.Close()

        ' Array Resize
        ReDim Preserve Tradek(N)



    End Sub

End Class
