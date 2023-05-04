/**
 * Represents an application console.
 */
public struct Console 
{
    public out: OutStream;
}

public console: Console := initialize_console();

private initialize_console () : Console
{
    let console: Console;
    
    let utf8_codepage := 65001:32;
    SetConsoleOutputCP(utf8_codepage);

    let std_output_handle := 4294967285:32;
    console out handle <: GetStdHandle(std_output_handle);
    
    return console;
}

/**
 * Print to a console.
 */
public print (console: Console, string: String) 
{
    write(console out, string);
}

/**
 * Print to a console.
 */
public print (console: Console, c_string: *u8) 
{
    write(console out, c_string);
}

/**
 * Print a new-line to a console.
 */
public print_line (console: Console, string: String) 
{
    write_line(console out, string);
}

/**
 * Print a new-line to a console.
 */
public print_line (console: Console, c_string: *u8) 
{
    write_line(console out, c_string);
}

/**
 * Print a new-line to a console.
 */
public print_line (console: Console) 
{
    write_line(console out);
}
