/*
 * Convert a signed number to a string. This will use base 10.
 */
public to_string (number: i64) : String 
{
    let base: i64 := 10;

    let max_size: size := 20; // Size is 20 because i64 can be -9223372036854775808 which is 20 characters long.
    let buffer := new[max_size] automatic u8;
    
    let first_index := max_size - 1;
    let index <: first_index;
    
    let working_value <: if number < 0 then number else -number;
    
    while working_value /= 0 or index == first_index do 
    {
        index <: index - 1;
        
        let digit <: -(working_value % base);
        buffer[index] <: digits[size(digit)];
        
        working_value <: working_value / base;
    }
    
    if number < 0 then 
    {
        index <: index - 1;
    
        buffer[index] <: 8'-';
    }
    
    let length: size := size(first_index - index);
    let start: diff := index;
    return new_string(buffer + start, length);
}

/*
 * Convert an unsigned number to a string.
 */
public to_string (number: u64, base: u6) : String 
{
    assert base >= 2 and base <= 36;

    let max_size: size := sizeof(number) * BITS_PER_BYTE; // With base 2 we need space for every bit.
    let buffer := new[max_size] automatic u8;
    
    let first_index := max_size - 1;
    let index <: first_index;
    
    let working_value <: number;
    
    while working_value /= 0 or index == first_index do 
    {
        index <: index - 1;
        
        let digit <: working_value % base;
        buffer[index] <: digits[size(digit)];
        
        working_value <: working_value / base;
    }

    let length: size := size(first_index - index);
    let start: diff := index;
    return new_string(buffer + start, length);
}

private const digits := 8"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";