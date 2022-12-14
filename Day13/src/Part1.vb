Namespace src
    Module Part1
        Function SumOfRightOrders(inputs As List(Of List(Of String))) As Integer
            Dim sum = 0
            For i = 0 To inputs.Count - 1
                If Common.IsOrderRight(inputs(i)(0), inputs(i)(1)) Then
                    sum += i + 1
                End If
            Next
            Return sum
        End Function
    End Module
End Namespace
