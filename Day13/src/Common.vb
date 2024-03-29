﻿Imports System.IO

Namespace src
    Module Common
        Function ReadInput(fileName As String) As List(Of List(Of String))
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

        Function IsOrderRight(left As String, right As String) As Boolean
            Dim leftArr = left.ToCharArray().ToList()
            Dim rightArr = right.ToCharArray().ToList()
            Dim length = Math.Max(leftArr.Count, rightArr.Count)

            ' if it's silly but works it's not silly XD
            For i = 0 To length - 1
                ' Same chars
                If leftArr(i) = rightArr(i) Then
                    Continue For
                End If

                ' Short number encounter long number
                If leftArr(i) = "0"c And (rightArr(i) = ","c Or rightArr(i) = "]"c) Then
                    Return False
                End If
                If rightArr(i) = "0"c And (leftArr(i) = ","c Or leftArr(i) = "]"c) Then
                    Return True
                End If

                If Char.IsNumber(leftArr(i)) And Char.IsNumber(rightArr(i)) Then
                    If Char.IsNumber(leftArr(i + 1)) Then
                        Return False
                    End If
                    If Char.IsNumber(rightArr(i + 1)) Then
                        Return True
                    End If
                    Return Convert.ToInt32(leftArr(i)) < Convert.ToInt32(rightArr(i))
                End If

                ' End of one array
                If leftArr(i) = "]"c Then
                    Return True
                End If
                If rightArr(i) = "]"c Then
                    Return False
                End If

                ' Number encounter array
                If leftArr(i) = "["c Then
                    If rightArr(i + 1) = "0"c Then
                        rightArr.Insert(i + 2, "]"c)
                    Else
                        rightArr.Insert(i + 1, "]"c)
                    End If
                    rightArr.Insert(i, "["c)
                    i -= 1
                    Continue For
                End If
                If rightArr(i) = "["c Then
                    If leftArr(i + 1) = "0"c Then
                        leftArr.Insert(i + 2, "]"c)
                    Else
                        leftArr.Insert(i + 1, "]"c)
                    End If
                    leftArr.Insert(i, "["c)
                    i -= 1
                    Continue For
                End If
            Next
            Return False
        End Function

        Function ListsComparator(left As String, right As String) As Integer
            Return If(IsOrderRight(left, right), -1, 1)
        End Function
    End Module
End Namespace