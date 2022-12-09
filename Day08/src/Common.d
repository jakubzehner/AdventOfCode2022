module Common;

import std.stdio;
import std.range;
import std.string;

int castCharToInt(char ch)
{
    return cast(int) ch - cast(int) '0';
}

int[][] readIntoArray(string fileName)
{   
    auto file = File(fileName);
    auto lines = file.byLine();
    auto size = strip(takeOne(lines)[0]).length;

    auto array = new int[][](size, size);
    auto i = 0;
    auto j = 0;
    foreach (line; lines)
    {   
        line = strip(line);
        foreach (ch; line)
        {   
            array[i][j] = castCharToInt(ch);
            j++;
        }
        i++;
        j = 0;
    }

    file.close();
    return array;
}