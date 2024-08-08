/*
 * Convert a signed number to a string. This will use base 10.
 */
public to_string (number: s64) : String
{
    let base: s64 := 10;

    let max_size: size := 20; // Size is 20 because s64 can be -9223372036854775808 which is 20 characters long.
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

private cmp MIN_S64: s64 := -9223372036854775808:64;
private cmp MAX_S64: s64 := +9223372036854775807:64;

private is_digit (letter: u8) : bool
{
    return match letter with
    {
        8'0' | 8'1' | 8'2' | 8'3' | 8'4' | 8'5' | 8'6' | 8'7' | 8'8' | 8'9' => true,
        default => false
    };
}

private is_lower_alpha (letter: u8) : bool
{
    return match letter with
    {
        8'a' | 8'b' | 8'c' | 8'd' | 8'e' | 8'f' | 8'g' | 8'h' | 8'i' | 8'j' | 8'k' | 8'l' | 8'm' |
        8'n' | 8'o' | 8'p' | 8'q' | 8'r' | 8's' | 8't' | 8'u' | 8'v' | 8'w' | 8'x' | 8'y' | 8'z' => true,
        default => false
    };
}

private is_upper_alpha (letter: u8) : bool
{
    return match letter with
    {
        8'A' | 8'B' | 8'C' | 8'D' | 8'E' | 8'F' | 8'G' | 8'H' | 8'I' | 8'J' | 8'K' | 8'L' | 8'M' |
        8'N' | 8'O' | 8'P' | 8'Q' | 8'R' | 8'S' | 8'T' | 8'U' | 8'V' | 8'W' | 8'X' | 8'Y' | 8'Z' => true,
        default => false
    };
}
 
/*
 * Parse an integer from a given string. If the string is invalid, either MIN_S64 or MAX_S64 is returned.
 */
public parse_s64 (string: String) : s64
{
    let buffer: []u8 := string buffer;
    let length: size := string length;
    
    if length == 0 then return 0;
    let index: size <: 0;
    
    let negative: bool <: false;
    if buffer[index] == 8'-' then { negative <: true; index <: index + 1; }
    else if buffer[index] == 8'+' then index <: index + 1;
    
    assert index < length;
    
    let base: u64 <: 10;
    if buffer[index] == 8'0' and index + 1 < length then 
    {
        let base_letter: u8 := buffer[index + 1];
        base <: match base_letter with 
        {
            8'b' | 8'B' => 2:64,
            8'o' | 8'O' => 8:64,
            8'x' | 8'X' => 16:64,
            default => 10:64
        };
        
        if base /= 10 then index <: index + 2;
    }
    
    let cutoff: u64 := if negative then u64(MIN_S64) else u64(MAX_S64);
    let limit: u64 := cutoff % base;
    let cutoff: u64 := cutoff / base;
    
    let error: bool <: false;
    let value: u64 <: 0;
    while index < length do 
    {
        let current: u8 <: buffer[index];
        
        if is_digit(current) then current <: current - 8'0';
        else if is_lower_alpha(current) then current <: current - 8'a' + 10;
        else if is_upper_alpha(current) then current <: current - 8'A' + 10;
        else 
        {
            error <: true;
            break;
        }
        
        let current_value: u64 := current;
        
        if current_value >= base or value >= cutoff or (value == cutoff and current_value > limit) then 
        {
            error <: true;
            break;
        }
        
        value <: value * base;
        value <: value + current_value;
        index <: index + 1;
    }
    
    if error then return if negative then MIN_S64 else MAX_S64;
    return if negative then -s64(value) else s64(value);
} 

private cmp digits := 8"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";