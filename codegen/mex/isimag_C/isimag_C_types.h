/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * isimag_C_types.h
 *
 * Code generation for function 'isimag_C'
 *
 */

#ifndef ISIMAG_C_TYPES_H
#define ISIMAG_C_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_isimag_CStackData
#define typedef_isimag_CStackData

typedef struct {
  union
  {
    struct {
      real_T Vr[1440000];
    } f0;

    struct {
      creal_T A[1440000];
    } f1;
  } u1;

  struct {
    creal_T T[1440000];
    real_T A[1440000];
  } f2;
} isimag_CStackData;

#endif                                 /*typedef_isimag_CStackData*/
#endif

/* End of code generation (isimag_C_types.h) */
