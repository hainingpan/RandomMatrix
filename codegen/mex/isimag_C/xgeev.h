/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xgeev.h
 *
 * Code generation for function 'xgeev'
 *
 */

#ifndef XGEEV_H
#define XGEEV_H

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

/* Type Definitions */
#include "lapacke.h"

/* Function Declarations */
extern void xgeev(isimag_CStackData *SD, const emlrtStack *sp, const real_T A
                  [1440000], int32_T *info, creal_T W[1200]);

#endif

/* End of code generation (xgeev.h) */
