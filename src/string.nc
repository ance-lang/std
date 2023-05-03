/**
 * A simple string struct that contains a text buffer pointer and the length of that buffer.
 * The string owns the buffer and thus must be cleaned up after use.
 */
public struct String
{
    public buffer: []u8;
    public length: size;
}

/**
 * Create a new string from pointer and length.
 */
public new_string (string: *u8, length: size) : String
{
    let buffer <: []u8(string);
    return new_string(buffer, length);
}

/**
 * Create a new string from a zero-terminated c-string.
 */
public new_string (c_string: *u8) : String
{
    return new_string(c_string, get_c_str_length(c_string));
}

/**
 * Create a new string from buffer and length.
 */
public new_string (buffer: []u8, length: size) : String
{
    let string: String;

    string buffer <: new[length] dynamic u8;
    string length <: length;
    
    copy_string_buffer(buffer, string buffer, length);

    return string;
}

/**
 * Copy a string.
 */
public copy_string (string: String) : String 
{
    return new_string(string buffer, string length); 
}

/**
 * Delete a string. The string must not be used afterwards.
 */
public delete_string (string: String) 
{
    let buffer: []u8 := string buffer;
    delete[] buffer;
}

private copy_string_buffer (source: []u8, destination: []u8, length: size) 
{
    copy_memory([]Byte(source), []Byte(destination), length);
}

/**
 * Get the length of a zero-terminated string.
 */
public get_c_str_length (c_string: *u8) : size
{
    let index: size <: 0;

    while c_string[index] /= 8'\0' do
    {
        index <: index + 1;
    }

    return index;
}
