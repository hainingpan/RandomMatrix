/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * eig.h
 *
 * Code generation for function 'eig'
 *
 */

#ifndef EIG_H
#define EIG_H

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
extern void eig(isimag_CStackData *SD, const emlrtStack *sp, const real_T A
                [1440000], creal_T V[1200]);

#endif

/* End of code generation (eig.h) */
