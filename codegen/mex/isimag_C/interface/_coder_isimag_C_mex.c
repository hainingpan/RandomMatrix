/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_isimag_C_mex.c
 *
 * Code generation for function '_coder_isimag_C_mex'
 *
 */

/* Include files */
#include "isimag_C.h"
#include "_coder_isimag_C_mex.h"
#include "isimag_C_terminate.h"
#include "_coder_isimag_C_api.h"
#include "isimag_C_initialize.h"
#include "isimag_C_data.h"

/* Function Declarations */
static void isimag_C_mexFunction(isimag_CStackData *SD, int32_T nlhs, mxArray
  *plhs[1], int32_T nrhs, const mxArray *prhs[1]);

/* Function Definitions */
static void isimag_C_mexFunction(isimag_CStackData *SD, int32_T nlhs, mxArray
  *plhs[1], int32_T nrhs, const mxArray *prhs[1])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 1, 4, 8,
                        "isimag_C");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 8,
                        "isimag_C");
  }

  /* Call the function. */
  isimag_C_api(SD, prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  isimag_CStackData *isimag_CStackDataGlobal = NULL;
  isimag_CStackDataGlobal = (isimag_CStackData *)emlrtMxCalloc(1, (size_t)1U *
    sizeof(isimag_CStackData));
  mexAtExit(isimag_C_atexit);

  /* Module initialization. */
  isimag_C_initialize();

  /* Dispatch the entry-point. */
  isimag_C_mexFunction(isimag_CStackDataGlobal, nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  isimag_C_terminate();
  emlrtMxFree(isimag_CStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_isimag_C_mex.c) */
