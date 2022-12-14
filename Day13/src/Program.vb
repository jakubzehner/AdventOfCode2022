Namespace src
    Module Program
        ReadOnly FileName = "./inputs/input.txt"

        Sub Main(args As String())
            Dim inputs = Common.ReadInput(FileName)
            Console.WriteLine(Part1.SumOfRightOrders(inputs))
        End Sub
    End Module
End Namespace