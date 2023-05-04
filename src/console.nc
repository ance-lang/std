/**
 * Represents an application console.
 */
public struct Console 
{
    public out: ptr;
}

public console: Console := initialize_console();

private initialize_console () : Console
{
    let console: Console;
    
    let utf8_codepage := 65001:32;
    SetConsoleOutputCP(utf8_codepage);

    let std_output_handle := 4294967285:32;
    console out <: GetStdHandle(std_output_handle);
    
    return console;
}

extern GetStdHandle (nStdHandle: u32) : Handle;
extern SetConsoleOutputCP (wCodePageID: u32) : Bool;