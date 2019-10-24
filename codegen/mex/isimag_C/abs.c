/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * abs.c
 *
 * Code generation for function 'abs'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "abs.h"

/* Function Definitions */
void b_abs(const real_T x[1200], real_T y[1200])
{
  int32_T k;
  for (k = 0; k < 1200; k++) {
    y[k] = muDoubleScalarAbs(x[k]);
  }
}

/* End of code generation (abs.c) */
