/**
 * A simple string struct, combining a c-like string pointer with the length of the string.
 */
public struct String
{
    public str: *u8;
    public len: u32 <: 15:32;
}

/**
 * Create a new string from pointer and length. This does not allocate.
 */
public new_string (str: *u8, len: u32) : String
{
    let s: String;

    s str <: str;
    s len <: len;

    return s;
}

/**
 * Create a new string from a zero-terminated c-string.
 */
public new_string (str: *u8) : String
{
    let s: String;

    s str <: str;
    s len <: get_c_str_length(str);

    return s;
}

/**
 * Get the length of a zero-terminated string.
 */
public get_c_str_length (c_str: *u8) : u32
{
    let index: size <: 0;

    while c_str[index] /= 8'\0' do
    {
        index <: index + 1;
    }

    return u32(index);
}
