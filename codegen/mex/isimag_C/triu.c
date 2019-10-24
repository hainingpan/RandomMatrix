/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * triu.c
 *
 * Code generation for function 'triu'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "triu.h"

/* Function Definitions */
void triu(creal_T x[1440000])
{
  int32_T istart;
  int32_T j;
  int32_T i;
  int32_T i1;
  istart = 3;
  for (j = 0; j < 1198; j++) {
    for (i = istart; i < 1201; i++) {
      i1 = (i + 1200 * j) - 1;
      x[i1].re = 0.0;
      x[i1].im = 0.0;
    }

    istart++;
  }
}

/* End of code generation (triu.c) */
