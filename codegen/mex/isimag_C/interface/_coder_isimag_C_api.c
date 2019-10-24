/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_isimag_C_api.c
 *
 * Code generation for function '_coder_isimag_C_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "_coder_isimag_C_api.h"
#include "isimag_C_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[1440000];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1440000];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *Heff_real,
  const char_T *identifier))[1440000];
static const mxArray *emlrt_marshallOut(const real_T u);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[1440000]
{
  real_T (*y)[1440000];
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1440000]
{
  real_T (*ret)[1440000];
  static const int32_T dims[2] = { 1200, 1200 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[1440000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *Heff_real,
  const char_T *identifier))[1440000]
{
  real_T (*y)[1440000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(Heff_real), &thisId);
  emlrtDestroyArray(&Heff_real);
  return y;
}
  static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m6;
  y = NULL;
  m6 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m6);
  return y;
}

void isimag_C_api(isimag_CStackData *SD, const mxArray * const prhs[1], int32_T
                  nlhs, const mxArray *plhs[1])
{
  real_T (*Heff_real)[1440000];
  real_T flag;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  Heff_real = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "Heff_real");

  /* Invoke the target function */
  flag = isimag_C(SD, &st, *Heff_real);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(flag);
}

/* End of code generation (_coder_isimag_C_api.c) */
