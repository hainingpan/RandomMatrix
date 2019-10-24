/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xgehrd.c
 *
 * Code generation for function 'xgehrd'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "xgehrd.h"
#include "isimag_C_data.h"
#include "lapacke.h"

/* Variable Definitions */
static emlrtRSInfo n_emlrtRSI = { 15,  /* lineNo */
  "xgehrd",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgehrd.m"/* pathName */
};

static emlrtRSInfo s_emlrtRSI = { 84,  /* lineNo */
  "ceval_xgehrd",                      /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgehrd.m"/* pathName */
};

/* Function Definitions */
void xgehrd(const emlrtStack *sp, real_T a[1440000])
{
  ptrdiff_t info_t;
  real_T tau[1199];
  int32_T info;
  boolean_T p;
  boolean_T b_p;
  static const char_T fname[14] = { 'L', 'A', 'P', 'A', 'C', 'K', 'E', '_', 'd',
    'g', 'e', 'h', 'r', 'd' };

  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &n_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  info_t = LAPACKE_dgehrd(102, (ptrdiff_t)1200, (ptrdiff_t)1, (ptrdiff_t)1200,
    &a[0], (ptrdiff_t)1200, &tau[0]);
  info = (int32_T)info_t;
  b_st.site = &s_emlrtRSI;
  if (info != 0) {
    p = true;
    b_p = false;
    if (info == -5) {
      b_p = true;
    }

    if (!b_p) {
      if (info == -1010) {
        emlrtErrorWithMessageIdR2018a(&b_st, &emlrtRTEI, "MATLAB:nomem",
          "MATLAB:nomem", 0);
      } else {
        emlrtErrorWithMessageIdR2018a(&b_st, &b_emlrtRTEI,
          "Coder:toolbox:LAPACKCallErrorInfo",
          "Coder:toolbox:LAPACKCallErrorInfo", 5, 4, 14, fname, 12, info);
      }
    }
  } else {
    p = false;
  }

  if (p) {
    for (info = 0; info < 1440000; info++) {
      a[info] = rtNaN;
    }
  }
}

/* End of code generation (xgehrd.c) */
