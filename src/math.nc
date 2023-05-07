/**
 * The mathematical constant PI.
 */
public const PI: double := 3.14159265358979323846d;

/**
 * A synonym for PI.
 */
public π: double := PI;

/**
 * The mathematical constant E.
 */
public const E: double := 2.71828182845904523536d;

/**
 * A synonym for E.
 */
public 𝑒: double := E;

/**
 * The mathematical function sine.
 */
public m_sin (x: double) : double
{
    return sin(x);
}

extern sin (x: double) : double;

/**
 * The mathematical function cosine.
 */
public m_cos (x: double) : double
{
    return cos(x);
}

extern cos (x: double) : double;

/**
 * The mathematical function for exponentiation of E.
 */
public m_exp (x: double) : double
{
    return exp(x);
}

extern exp (x: double) : double;

/**
 * The mathematical function for exponentiation of 2.
 */
public m_exp2 (x: double) : double
{
    return exp2(x);
}

extern exp2 (x: double) : double;

/**
 * The mathematical function for exponentiation of 10.
 */
public m_exp10 (x: double) : double
{
    return pow(10.0d, x);
}

/**
 * The mathematical function for exponentiation of a number.
 */
public m_pow (base: double, power: double) : double
{
    return pow(base, power);
}

extern pow (base: double, power: double) : double;

/**
 * The mathematical function to get the square root of a number.
 */
public m_sqrt (x: double) : double
{
    return sqrt(x);
}

extern sqrt (x: double) : double;

/**
 * The mathematical function to get the cube root of a number.
 */
public m_cbrt (x: double) : double
{
    return cbrt(x);
}

extern cbrt (x: double) : double;

/**
 * The mathematical function to get the natural logarithm of a number.
 */
public m_ln (x: double) : double
{
    return log(x);
}

extern log (x: double) : double;

/**
 * The mathematical function to get the logarithm of a number with base 10.
 */
public m_log10 (x: double) : double
{
    return log10(x);
}

extern log10 (x: double) : double;

/**
 * The mathematical function to get the logarithm of a number with base 2.
 */
public m_log2 (x: double) : double
{
    return log2(x);
}

extern log2 (x: double) : double;

/**
 * The mathematical function to get the logarithm of a number with a custom base.
 */
public m_log (x: double, base: double) : double
{
    return logb(x, base);
}

extern logb (x: double, base: double) : double;

/**
 * The mathematical function to ceil a number.
 */
public m_ceil (x: double) : double
{
    return ceil(x);
}

extern ceil (x: double) : double;

/**
 * The mathematical function to floor a number.
 */
public m_floor (x: double) : double
{
    return floor(x);
}

extern floor (x: double) : double;

public const MidpointRounding_AwayFromZero: u32 := 0:32;
public const MidpointRounding_ToEven: u32 := 1:32;
public const MidpointRounding_ToZero: u32 := 2:32;

/**
 * The mathematical function to round the nearest integer.
 * If the fractional part is exactly 0.5, the number is rounded according to the midpoint rounding mode.
 */
public m_round (x: double, mode: u32) : double
{
    return match mode with
    {
        0:32 => round(x),
        1:32 => round(x * 0.5d) * 2.0d,
        2:32 => trunc(x),
        default => x
    };
}

extern round (x: double) : double;
extern trunc (x: double) : double;

/**
 * The mathematical function to round a number to an integer.
 */
public m_round_to_int (x: double, mode: u32) : i64
{
    let rounded := m_round(x, mode);
    return i64(rounded);
}
