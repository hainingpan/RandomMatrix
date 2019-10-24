/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xhseqr.c
 *
 * Code generation for function 'xhseqr'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "xhseqr.h"
#include "infocheck.h"
#include "lapacke.h"

/* Variable Definitions */
static emlrtRSInfo w_emlrtRSI = { 28,  /* lineNo */
  "xhseqr",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xhseqr.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 127,/* lineNo */
  "ceval_xhseqr",                      /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xhseqr.m"/* pathName */
};

/* Function Definitions */
int32_T xhseqr(const emlrtStack *sp, real_T h[1440000])
{
  int32_T info;
  real_T z;
  ptrdiff_t n_t;
  ptrdiff_t info_t;
  real_T wr[1200];
  real_T wi[1200];
  int32_T i2;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &w_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  z = 0.0;
  n_t = (ptrdiff_t)1200;
  info_t = LAPACKE_dhseqr(102, 'S', 'N', n_t, (ptrdiff_t)1, (ptrdiff_t)1200, &h
    [0], n_t, &wr[0], &wi[0], &z, (ptrdiff_t)1200);
  info = (int32_T)info_t;
  b_st.site = &cb_emlrtRSI;
  if (infocheck(&b_st, info)) {
    for (i2 = 0; i2 < 1440000; i2++) {
      h[i2] = rtNaN;
    }
  }

  return info;
}

/* End of code generation (xhseqr.c) */
