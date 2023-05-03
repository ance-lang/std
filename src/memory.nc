/**
 * A single byte of memory. Prefer this over directly using u8 when the numerical value of the byte is not relevant.
 */
public define Byte alias u8;

/**
 * Copy data from one buffer to another.
 */ 
public copy_memory (source: []Byte, destination: []Byte, length: size) 
{
    let index: size <: 0;
    
    while index < length do 
    {
        destination[index] <: source[index];
        index <: index + 1;
    }
} 