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
public write_line (str: *u8, len: u32)
{
    write(str, len);
    write_line();
}

/**
 * Write a line to std out.
 */
public write_line (c_str: *u8)
{
    write(c_str);
    write_line();
}

/**
 * Write a new-line to std-out.
 */
public write_line ()
{
    write(c"\n", 1:32);
}

/**
 * Write a line to std out.
 */
public write_line (str: String)
{
    write(str);
    write_line();
}

/**
 * Write to std out.
 */
public write (str: *u8, len: u32)
{
    let written: *u32 <: new automatic u32;
    WriteFile(std_out, str, len, written, null);
}

/**
 * Write to std out.
 */
public write (c_str: *u8)
{
    let length: u32 <: get_c_str_length(c_str);
    write(c_str, length);
}

/**
 * Write to std out.
 */
public write (str: String)
{
    write(str str, str len);
}

extern WriteFile (hFile: Handle, lpBuffer: *u8, nNumberOfBytesToWrite: u32, lpNumberOfBytesWritten: *u32, lpOverlapped: ptr) : Bool;
extern GetStdHandle (nStdHandle: u32) : Handle;
extern SetConsoleOutputCP (wCodePageID: u32) : Bool;
