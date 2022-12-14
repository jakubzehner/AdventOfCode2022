Namespace src
    Module Part2
        Function FindDecoderKey(inputs As List(Of List(Of String))) As Integer
            Dim flattedInputs = (From pair In inputs From elem In pair Select elem).ToList()
            flattedInputs.Add("[[2]]")
            flattedInputs.Add("[[6]]")
            flattedInputs.Sort(AddressOf Common.ListsComparator)
            Return (flattedInputs.IndexOf("[[2]]") + 1) * (flattedInputs.IndexOf("[[6]]") + 1)
        End Function
    End Module
End Namespace
