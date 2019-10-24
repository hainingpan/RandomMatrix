/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * infocheck.c
 *
 * Code generation for function 'infocheck'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "infocheck.h"
#include "isimag_C_data.h"
#include "lapacke.h"

/* Function Definitions */
boolean_T b_infocheck(const emlrtStack *sp, int32_T info)
{
  boolean_T p;
  static const char_T fname[13] = { 'L', 'A', 'P', 'A', 'C', 'K', 'E', '_', 'z',
    'g', 'e', 'e', 'v' };

  if (info < 0) {
    if (info == -1010) {
      emlrtErrorWithMessageIdR2018a(sp, &emlrtRTEI, "MATLAB:nomem",
        "MATLAB:nomem", 0);
    } else {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:toolbox:LAPACKCallErrorInfo", "Coder:toolbox:LAPACKCallErrorInfo",
        5, 4, 13, fname, 12, info);
    }
  } else {
    p = false;
  }

  return p;
}

boolean_T infocheck(const emlrtStack *sp, int32_T info)
{
  boolean_T p;
  boolean_T b_p;
  static const char_T fname[14] = { 'L', 'A', 'P', 'A', 'C', 'K', 'E', '_', 'd',
    'h', 's', 'e', 'q', 'r' };

  if (info < 0) {
    p = true;
    b_p = false;
    if (info == -7) {
      b_p = true;
    } else {
      if (info == -11) {
        b_p = true;
      }
    }

    if (!b_p) {
      if (info == -1010) {
        emlrtErrorWithMessageIdR2018a(sp, &emlrtRTEI, "MATLAB:nomem",
          "MATLAB:nomem", 0);
      } else {
        emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
          "Coder:toolbox:LAPACKCallErrorInfo",
          "Coder:toolbox:LAPACKCallErrorInfo", 5, 4, 14, fname, 12, info);
      }
    }
  } else {
    p = false;
  }

  return p;
}

/* End of code generation (infocheck.c) */
