private define Handle alias ptr;
private define Bool alias i32;

private std_out: Handle; 

/**
 * Initialize the IO system.
 */
public init_io ()
{
    SetConsoleOutputCP(65001);
    std_out <: GetStdHandle(4294967285:32);
}

/**
 * Write a line to std out.
 */
public write_line (string: *u8, length: size)
{
    write(string, length);
    write_line();
}

/**
 * Write a line to std out.
 */
public write_line (c_string: *u8)
{
    write(c_string);
    write_line();
}

/**
 * Write a new-line to std-out.
 */
public write_line ()
{
    write(c"\n", 1);
}

/**
 * Write a line to std out.
 */
public write_line (string: String)
{
    write(string);
    write_line();
}

/**
 * Write to std out.
 */
public write (string: *u8, length: size)
{
    let written: *u32 <: new automatic u32;
    WriteFile(std_out, string, u32(length), written, null);
}

/**
 * Write to std out.
 */
public write (c_string: *u8)
{
    write(c_string, get_c_str_length(c_string));
}

/**
 * Write to std out.
 */
public write (string: String)
{
    let buffer: []u8 := string buffer;
    write(*u8(buffer), string length);
}

extern WriteFile (hFile: Handle, lpBuffer: *u8, nNumberOfBytesToWrite: u32, lpNumberOfBytesWritten: *u32, lpOverlapped: ptr) : Bool;
extern GetStdHandle (nStdHandle: u32) : Handle;
extern SetConsoleOutputCP (wCodePageID: u32) : Bool;
