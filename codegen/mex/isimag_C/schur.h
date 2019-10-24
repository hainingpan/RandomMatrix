/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * schur.h
 *
 * Code generation for function 'schur'
 *
 */

#ifndef SCHUR_H
#define SCHUR_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "isimag_C_types.h"

/* Function Declarations */
extern void schur(isimag_CStackData *SD, const emlrtStack *sp, real_T A[1440000],
                  creal_T V[1440000]);

#endif

/* End of code generation (schur.h) */
