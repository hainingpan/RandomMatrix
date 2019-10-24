/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * schur.c
 *
 * Code generation for function 'schur'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "isimag_C.h"
#include "schur.h"
#include "xdlanv2.h"
#include "triu.h"
#include "warning.h"
#include "xhseqr.h"
#include "xgehrd.h"
#include "anyNonFinite.h"

/* Variable Definitions */
static emlrtRSInfo i_emlrtRSI = { 52,  /* lineNo */
  "schur",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\lib\\matlab\\matfun\\schur.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 56,  /* lineNo */
  "schur",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\lib\\matlab\\matfun\\schur.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 83,  /* lineNo */
  "schur",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019a\\toolbox\\eml\\lib\\matlab\\matfun\\schur.m"/* pathName */
};

/* Function Declarations */
static void eml_rsf2csf(const real_T Tr[1440000], creal_T T[1440000]);

/* Function Definitions */
static void eml_rsf2csf(const real_T Tr[1440000], creal_T T[1440000])
{
  int32_T b_tmp;
  int32_T m;
  int32_T mm1;
  int32_T i0;
  real_T r;
  int32_T b_tmp_tmp;
  real_T s;
  real_T t1_re;
  real_T t1_im;
  real_T d;
  real_T rt1r;
  real_T rt1i;
  real_T mu1_re;
  real_T rt2i;
  real_T cs;
  real_T sn;
  int32_T re_tmp;
  int32_T b_re_tmp;
  for (b_tmp = 0; b_tmp < 1440000; b_tmp++) {
    T[b_tmp].re = Tr[b_tmp];
    T[b_tmp].im = 0.0;
  }

  for (m = 1198; m >= 0; m--) {
    mm1 = m + 1;
    b_tmp = m + 1200 * m;
    i0 = b_tmp + 1;
    if (Tr[i0] != 0.0) {
      r = Tr[b_tmp];
      b_tmp_tmp = 1200 * (m + 1);
      b_tmp = m + b_tmp_tmp;
      s = Tr[b_tmp];
      t1_re = Tr[i0];
      t1_im = Tr[b_tmp + 1];
      d = t1_im;
      xdlanv2(&r, &s, &t1_re, &d, &rt1r, &rt1i, &mu1_re, &rt2i, &cs, &sn);
      mu1_re = rt1r - t1_im;
      r = muDoubleScalarHypot(muDoubleScalarHypot(mu1_re, rt1i), Tr[i0]);
      if (rt1i == 0.0) {
        cs = mu1_re / r;
        rt2i = 0.0;
      } else if (mu1_re == 0.0) {
        cs = 0.0;
        rt2i = rt1i / r;
      } else {
        cs = mu1_re / r;
        rt2i = rt1i / r;
      }

      s = Tr[i0] / r;
      for (b_tmp = mm1; b_tmp < 1201; b_tmp++) {
        re_tmp = m + 1200 * (b_tmp - 1);
        t1_im = T[m + 1200 * (b_tmp - 1)].im;
        t1_re = T[re_tmp].re;
        b_re_tmp = re_tmp + 1;
        d = T[b_re_tmp].re;
        rt1r = T[(m + 1200 * (b_tmp - 1)) + 1].im;
        r = T[re_tmp].re;
        T[re_tmp].re = (cs * T[re_tmp].re + rt2i * t1_im) + s * T[b_re_tmp].re;
        T[re_tmp].im = (cs * t1_im - rt2i * r) + s * rt1r;
        mu1_re = cs * d - rt2i * rt1r;
        r = cs * rt1r + rt2i * d;
        T[b_re_tmp].re = mu1_re - s * t1_re;
        T[b_re_tmp].im = r - s * t1_im;
      }

      for (b_tmp = 0; b_tmp <= m + 1; b_tmp++) {
        re_tmp = b_tmp + 1200 * m;
        t1_im = T[b_tmp + 1200 * m].im;
        t1_re = T[re_tmp].re;
        b_re_tmp = b_tmp + b_tmp_tmp;
        d = T[b_re_tmp].re;
        rt1r = T[b_tmp + 1200 * (m + 1)].im;
        mu1_re = cs * T[re_tmp].re - rt2i * t1_im;
        r = cs * t1_im + rt2i * T[re_tmp].re;
        T[re_tmp].re = mu1_re + s * T[b_re_tmp].re;
        T[re_tmp].im = r + s * rt1r;
        T[b_re_tmp].re = (cs * d + rt2i * rt1r) - s * t1_re;
        T[b_re_tmp].im = (cs * rt1r - rt2i * d) - s * t1_im;
      }

      T[i0].re = 0.0;
      T[i0].im = 0.0;
    }
  }
}

void schur(isimag_CStackData *SD, const emlrtStack *sp, real_T A[1440000],
           creal_T V[1440000])
{
  int32_T info;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  if (anyNonFinite(A)) {
    for (info = 0; info < 1440000; info++) {
      V[info].re = rtNaN;
      V[info].im = 0.0;
    }

    triu(V);
  } else {
    st.site = &i_emlrtRSI;
    xgehrd(&st, A);
    memcpy(&SD->u1.f0.Vr[0], &A[0], 1440000U * sizeof(real_T));
    st.site = &j_emlrtRSI;
    info = xhseqr(&st, SD->u1.f0.Vr);
    eml_rsf2csf(SD->u1.f0.Vr, V);
    if (info != 0) {
      st.site = &l_emlrtRSI;
      warning(&st);
    }
  }
}

/* End of code generation (schur.c) */
