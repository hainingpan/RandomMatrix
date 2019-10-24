/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * eig.c
 *
 * Code generation for function 'eig'
 *
 */

/* Include files */
#include <string.h>
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "eig.h"
#include "ishermitian.h"
#include "xgeev.h"
#include "schur.h"
#include "warning.h"
#include "anyNonFinite.h"

/* Variable Definitions */
static emlrtRSInfo d_emlrtRSI = { 125, /* lineNo */
  "eig",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\lib\\matlab\\matfun\\eig.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 144, /* lineNo */
  "eig",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\lib\\matlab\\matfun\\eig.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 181, /* lineNo */
  "eig",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\lib\\matlab\\matfun\\eig.m"/* pathName */
};

/* Function Declarations */
static void mainDiagZeroImag(const creal_T D[1440000], creal_T d[1200]);

/* Function Definitions */
static void mainDiagZeroImag(const creal_T D[1440000], creal_T d[1200])
{
  int32_T k;
  for (k = 0; k < 1200; k++) {
    d[k] = D[k + 1200 * k];
  }
}

void eig(isimag_CStackData *SD, const emlrtStack *sp, const real_T A[1440000],
         creal_T V[1200])
{
  int32_T info;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  info = 0;
  if (anyNonFinite(A)) {
    for (info = 0; info < 1200; info++) {
      V[info].re = rtNaN;
      V[info].im = 0.0;
    }
  } else {
    if (ishermitian(A)) {
      memcpy(&SD->f2.A[0], &A[0], 1440000U * sizeof(real_T));
      st.site = &d_emlrtRSI;
      schur(SD, &st, SD->f2.A, SD->f2.T);
      mainDiagZeroImag(SD->f2.T, V);
    } else {
      st.site = &e_emlrtRSI;
      xgeev(SD, &st, A, &info, V);
    }

    if (info != 0) {
      st.site = &f_emlrtRSI;
      b_warning(&st);
    }
  }
}

/* End of code generation (eig.c) */
