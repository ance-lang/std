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
    write(c"\r\n", 2);
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
    WriteFile(console out, string, u32(length), written, null);
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
