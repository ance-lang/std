/**
 * An output stream that can be used for write operations.
 */
public struct OutStream 
{
    public handle: ptr;
}

/**
 * Write a line to a stream.
 */
public write_line (stream: OutStream, string: *u8, length: size)
{
    assert string /= null;
    
    write(stream, string, length);
    write_line(stream);
}

/**
 * Write a line to a stream.
 */
public write_line (stream: OutStream, c_string: *u8)
{
    assert c_string /= null;
    
    write(stream, c_string);
    write_line(stream);
}

/**
 * Write a new-line to a stream.
 */
public write_line (stream: OutStream)
{
    write(stream, c"\r\n", 2);
}

/**
 * Write a line to a stream.
 */
public write_line (stream: OutStream, string: String)
{
    write(stream, string);
    write_line(stream);
}

/**
 * Write to a stream.
 */
public write (stream: OutStream, string: *u8, length: size)
{
    assert string /= null;
    if length == 0 then return;
    
    let written: *u32 := new automatic u32;
    let ok := WriteFile(stream handle, string, u32(length), written, null);
    
    consume_last_error(ok);
    assert written. == u32(length);
}

/**
 * Write to a stream.
 */
public write (stream: OutStream, c_string: *u8)
{
    assert c_string /= null;
    write(stream, c_string, get_c_str_length(c_string));
}

/**
 * Write to a stream.
 */
public write (stream: OutStream, string: String)
{
    let buffer: []u8 := string buffer;
    write(stream, *u8(buffer), string length);
}
