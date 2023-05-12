/*
 * The mathematical constant PI.
 */
public const PI: double := 3.14159265358979323846d;

/*
 * A synonym for PI.
 */
public π: double := PI;

/*
 * The mathematical constant E.
 */
public const E: double := 2.71828182845904523536d;

/*
 * A synonym for E.
 */
public 𝑒: double := E;

/*
 * Not a Number.
 */
public NAN: double := 0.0d / 0.0d; 

public is_nan (x: double) : bool { return x /= x; }

/*
 * The mathematical function sine.
 */
public m_sin (x: double) : double { return sin(x); }
extern sin (x: double) : double;

/*
 * The mathematical function cosine.
 */
public m_cos (x: double) : double { return cos(x); }
extern cos (x: double) : double;

/*
 * The mathematical function for exponentiation of E.
 */
public m_exp (x: double) : double { return exp(x); }
extern exp (x: double) : double;

/*
 * The mathematical function for exponentiation of 2.
 */
public m_exp2 (x: double) : double { return exp2(x); }
extern exp2 (x: double) : double;

/*
 * The mathematical function for exponentiation of 10.
 */
public m_exp10 (x: double) : double { return pow(10.0d, x); }

/*
 * The mathematical function for exponentiation of a number.
 */
public m_pow (base: double, power: double) : double { return pow(base, power); }
extern pow (base: double, power: double) : double;

/*
 * The mathematical function to get the square root of a number.
 */
public m_sqrt (x: double) : double { return sqrt(x); }
extern sqrt (x: double) : double;

/*
 * The mathematical function to get the cube root of a number.
 */
public m_cbrt (x: double) : double { return cbrt(x); }
extern cbrt (x: double) : double;

/*
 * The mathematical function to get the natural logarithm of a number.
 */
public m_ln (x: double) : double { return log(x); }
extern log (x: double) : double;

/*
 * The mathematical function to get the logarithm of a number with base 10.
 */
public m_log10 (x: double) : double { return log10(x); }
extern log10 (x: double) : double;

/*
 * The mathematical function to get the logarithm of a number with base 2.
 */
public m_log2 (x: double) : double { return log2(x); }
extern log2 (x: double) : double;

/*
 * The mathematical function to get the logarithm of a number with a custom base.
 */
public m_log (x: double, base: double) : double { return logb(x, base); }
extern logb (x: double, base: double) : double;

/*
 * The mathematical function to ceil a number.
 */
public m_ceil (x: double) : double { return ceil(x); }
extern ceil (x: double) : double;

/*
 * The mathematical function to floor a number.
 */
public m_floor (x: double) : double { return floor(x); }
extern floor (x: double) : double;

/*
 * Returns the integer part of a number by truncating towards zero.
 */
public m_trunc (x: double) : double { return trunc(x); }
extern trunc (x: double) : double;

/*
 * Returns the fractional part of a number.
 */
public m_frac (x: double) : double { return x - m_trunc(x); }

/*
 * Returns the absolute value of a number.
 */
public m_abs (x: double) : double { return fabs(x); }
extern fabs (x: double) : double;

/*
 * Get a number with the absolute value of the absolute_provider and the sign of the sign_provider.
 */
public m_copysign (absolute_provider: double, sign_provider: double) : double { return copysign(absolute_provider, sign_provider); }
extern copysign (absolute_provider: double, sign_provider: double) : double;

public m_sign (x: double) : double { return if is_nan(x) then NAN else m_copysign(1.0d, x); }

/*
 * On midpoint, round away from zero.
 */
public const MidpointRounding_AwayFromZero: u32 := 0:32;

/*
 * On midpoint, round to the nearest even number. Also known as banker's rounding.
 */
public const MidpointRounding_ToEven: u32 := 1:32;

/*
 * Rounds a number to the nearest integer.
 * If the fractional part is exactly 0.5, the number is rounded according to the midpoint rounding mode.
 */
public m_round (x: double, mode: u32) : double
{
    assert mode == 0 or mode == 1;

    return match mode with
    {
        0:32 => round(x),
        1:32 => rint(x),
        default => 0.0d
    };
}

extern round (x: double) : double;
extern rint (x: double) : double;

/*
 * Rounds a number to the given digits.
 * If the digit is exactly 5, the number is rounded according to the midpoint rounding mode.
 */
public m_round (x: double, digits: u4, mode: u32) : double 
{
    assert mode == 0 or mode == 1;
    
    let power: double := rounding_pow10[digits];
    return m_round(x * power, mode) / power;
}

private rounding_pow10 := [1.0e0d, 1.0e1d, 1.0e2d, 1.0e3d, 1.0e4d, 1.0e5d, 1.0e6d, 1.0e7d, 1.0e8d, 1.0e9d, 1.0e10d, 1.0e11d, 1.0e12d, 1.0e13d, 1.0e14d, 1.0e15d];

/*
 * The mathematical function to round a number to an integer.
 */
public m_round_to_int (x: double, mode: u32) : i64
{
    assert mode == 0 or mode == 1;

    return match mode with 
    {
        0:32 => llround(x),
        1:32 => llrint(x),
        default => 0
    };
}

extern llround (x: double) : i64;
extern llrint (x: double) : i64;
