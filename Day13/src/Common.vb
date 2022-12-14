Imports System.IO

Namespace src
    Module Common
        Public Function ReadInput(fileName As String) As List(Of List(Of String))
            Dim lines As List(Of String) = File.ReadLines(fileName).ToList()

            Dim inputs = New List(Of List(Of String))()
            For i = 0 To lines.Count Step 3
                Dim pair = New List(Of String)()
                pair.Add(lines(i))
                pair.Add(lines(i + 1))
                inputs.Add(pair)
            Next

            Return inputs
        End Function
    End Module
End Namespace