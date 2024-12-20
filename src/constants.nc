/*
 * Process exit code indicating success.
 */
public cmp SuccessCode: u32 := 0:32;

/*
 * Process exit code indicating failure.
 */
public cmp FailureCode: u32 := 1:32;

/*
 * Numbers of bits in a byte. Use this with sizeof to get the total bits of a type.
 */
public cmp BITS_PER_BYTE: size := 8;