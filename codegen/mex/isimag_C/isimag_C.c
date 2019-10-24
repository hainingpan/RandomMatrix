/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * isimag_C.c
 *
 * Code generation for function 'isimag_C'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "eig.h"
#include "abs.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 5,     /* lineNo */
  "isimag_C",                          /* fcnName */
  "D:\\CMTC\\RandomMatrix\\isimag_C.m" /* pathName */
};

/* Function Definitions */
real_T isimag_C(isimag_CStackData *SD, const emlrtStack *sp, const real_T
                Heff_real[1440000])
{
  creal_T eiglist[1200];
  int32_T idx;
  real_T b_eiglist[1200];
  real_T varargin_1[1200];
  int32_T k;
  boolean_T exitg1;
  real_T ex;
  real_T d0;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;

  /* Here the trick is make Heff real(assuming Heff is purely imaginary) and */
  /* then multiplied by a i to rotate the spectrum back. */
  st.site = &emlrtRSI;
  eig(SD, &st, Heff_real, eiglist);

  /*  eiglist=1i*eiglist; */
  for (idx = 0; idx < 1200; idx++) {
    b_eiglist[idx] = eiglist[idx].im;
  }

  b_abs(b_eiglist, varargin_1);
  if (!muDoubleScalarIsNaN(varargin_1[0])) {
    idx = 1;
  } else {
    idx = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k < 1201)) {
      if (!muDoubleScalarIsNaN(varargin_1[k - 1])) {
        idx = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (idx == 0) {
    ex = varargin_1[0];
  } else {
    ex = varargin_1[idx - 1];
    idx++;
    for (k = idx; k < 1201; k++) {
      d0 = varargin_1[k - 1];
      if (ex > d0) {
        ex = d0;
      }
    }
  }

  return ex < 1.0E-10;
}

/* End of code generation (isimag_C.c) */
