/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * anyNonFinite.c
 *
 * Code generation for function 'anyNonFinite'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "anyNonFinite.h"

/* Function Definitions */
boolean_T anyNonFinite(const real_T x[1440000])
{
  boolean_T p;
  int32_T k;
  p = true;
  for (k = 0; k < 1440000; k++) {
    if (p && ((!muDoubleScalarIsInf(x[k])) && (!muDoubleScalarIsNaN(x[k])))) {
      p = true;
    } else {
      p = false;
    }
  }

  return !p;
}

/* End of code generation (anyNonFinite.c) */
