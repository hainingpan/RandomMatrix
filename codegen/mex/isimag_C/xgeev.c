/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xgeev.c
 *
 * Code generation for function 'xgeev'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "xgeev.h"
#include "infocheck.h"
#include "lapacke.h"

/* Type Definitions */

/* Variable Definitions */
static emlrtRSInfo nb_emlrtRSI = { 33, /* lineNo */
  "xgeev",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgeev.m"/* pathName */
};

static emlrtRSInfo sb_emlrtRSI = { 101,/* lineNo */
  "ceval_xgeev",                       /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgeev.m"/* pathName */
};

/* Function Definitions */
void xgeev(isimag_CStackData *SD, const emlrtStack *sp, const real_T A[1440000],
           int32_T *info, creal_T W[1200])
{
  int32_T i;
  ptrdiff_t info_t;
  creal_T vl;
  creal_T vr;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &nb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  for (i = 0; i < 1440000; i++) {
    SD->u1.f1.A[i].re = A[i];
    SD->u1.f1.A[i].im = 0.0;
  }

  info_t = LAPACKE_zgeev(102, 'N', 'N', (ptrdiff_t)1200, (lapack_complex_double *)
    &SD->u1.f1.A[0], (ptrdiff_t)1200, (lapack_complex_double *)&W[0],
    (lapack_complex_double *)&vl, (ptrdiff_t)1, (lapack_complex_double *)&vr,
    (ptrdiff_t)1);
  *info = (int32_T)info_t;
  b_st.site = &sb_emlrtRSI;
  if (b_infocheck(&b_st, *info)) {
    for (i = 0; i < 1200; i++) {
      W[i].re = rtNaN;
      W[i].im = 0.0;
    }
  }
}

/* End of code generation (xgeev.c) */
