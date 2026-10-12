# Review r440, PARTIAL, salvaged from the log

**This reviewer DIED before filing a verdict.** It was launched on [I2](../plan.md)'s tube ingredients (the asymmetry claim, the analyticity radius and the remainder constant), on an identical brief to [r439](REVIEW_r439.md), and its log went thirty-one minutes without a write while no report appeared. **Nothing here is a verdict.** *Its one substantive finding was read from the log and applied before the salvage*: the monotonicity step missing from [Lemma L141](../findings/second-order.md)(b), which [r439](REVIEW_r439.md) also flagged from the other side. **The second audit of those three claims is still owed.**

## The log, verbatim

```
PID 87181 | r440 | phase plan: 1) read plan.md L16a + findings/second-order.md L133/L141 + route-a.md L140.2  2) independent spectrum recompute for product-of-spheres Weyl tensor  3) attack Riesz/Cauchy chain  4) attack C_P, domination, vacuity  5) write reviews/REVIEW_r440.md
[t+3m] READ: plan.md:48-67 (L16a item), findings/second-order.md:821-900 (L133, L141), findings/route-a.md:280-320 (L140.1, L140.2 withdrawal).
FINDING A (claim 2 arithmetic), INDEPENDENT RECOMPUTE, ALL CORRECT.
  S^m x S^m unit factors, n=2m. Curvature operator on Lambda^2: R = 1 on Lambda^2V_1 + Lambda^2V_2 (mult m(m-1)), 0 on V_1^V_2 (mult m^2). Total m(2m-1)=C(n,2) OK.
  Einstein: Ric=(m-1)g, scal=2m(m-1), kappa=scal/(n(n-1))=(m-1)/(2m-1). W = R - kappa*id.
  Unnormalised eigenvalues: +m/(2m-1) mult m(m-1); -(m-1)/(2m-1) mult m^2. Trace 0 OK.
  sum lambda^2 = m^2(m-1)/(2m-1); normaliser N = m sqrt((m-1)/(2m-1)).
  lambda_+ = 1/sqrt((m-1)(2m-1)) MATCHES; lambda_- = -(1/m)sqrt((m-1)/(2m-1)) MATCHES.
  sum lambda^2 = m/(2m-1) + (m-1)/(2m-1) = 1 MATCHES. |lambda_-|/lambda_+ = (m-1)/m MATCHES.
  g_n=|lambda_-| = (2/n)sqrt((n-2)/(2(n-1))) MATCHES; g_12 = (1/6)sqrt(5/11)=0.11237 MATCHES; -> sqrt2/n MATCHES.
  Multiplicities m(m-1)+m^2 = C(n,2): NO KERNEL, CONFIRMED.
  "gap at 0" = dist(0,spec) = min(|lambda_-|,lambda_+) = |lambda_-| since (m-1)/m<1: CORRECT.
[t+8m] FINDING B (claim 2, INDEPENDENT CROSS-CHECK, NEW), the spectrum is tied to theta_0 analytically, without L133.
  bounds.md's row calculus states: at the balanced product theta_0 = -|lambda_min| + (n-2)lambda_max EXACTLY.
  Substituting MY recomputed values with n=2m:
    -(1/m)sqrt((m-1)/(2m-1)) + (2m-2)/sqrt((m-1)(2m-1)) = sqrt((m-1)(2m-1))/m = sqrt(2(n-1)(n-2))/n = theta_0(n). EXACT.
  Also lambda_max/|lambda_min| = m/(m-1) = n/(n-2), matching bounds.md's independent statement.
  => claim (2)'s spectrum and normalisation are confirmed by a route that does not pass through L133. CLAIM (2) CONFIRMED.
FINDING C (claim 2/3, REAL DEFECT), THE RECORD CARRIES TWO DIFFERENT NUMBERS FOR "THE SPECTRAL GAP", DIFFERING BY A FACTOR ~m.
  plan.md:59 g_n = |lambda_-| = (2/n)sqrt((n-2)/(2(n-1))) -> sqrt2/n  [UNIT-NORM, correct for the resolvent]
  plan.md:67, plan.md:111, second-order.md L141 closing, L133 step 1: "the spectral gap (m-1)/(2m-1)"  [UNNORMALISED, = 5/11 = 0.4545 at n=12, Theta(1)]
  g_12 = 0.11237 vs 5/11 = 0.45455 -- ratio exactly m=6 times sqrt((2m-1)/(m-1))... precisely g_n = (1/N)*(m-1)/(2m-1) with N = m sqrt((m-1)/(2m-1)) the unit normaliser.
  The Cauchy/resolvent step runs on the UNIT sphere, so g_n is the one that enters. Using (m-1)/(2m-1) = Theta(1) there gives C_delta = O(1) and r_n = Omega(n^-1) -- THREE ORDERS TOO GOOD.
  The two places the record calls this constant "what is still owed" both quote the WRONG one.
[t+12m] SCREENS (seconds, objects I constructed, reported as screens not evidence):
  S1: closed forms at n=12,14,20,40,100 -- sum(lambda^2)=1.000000000000, -|l-|+(n-2)l+ = theta_0 to 8dp, mult sum = C(n,2) exactly, |l-|/l+ = (m-1)/m. ALL MATCH.
  S2: L141(b) block comparison, Q per unit norm, s=6alpha^2 in [0,1]:
      four-set max Q: -1.0899 (n=12) ... -1.7349 (n=1000); pair block -3th0/(n-2): -0.3708 ... -0.0042. Pair binds at every n. c_n CONFIRMED.
FINDING D (L141(b) written proof, DEFECT, conclusion survives) -- the displayed chain on the (2,2) block is
      Q <= (kappa^Hess - kappa_n) d^2 <= -4.904*sigma*||H||^2, "with sigma <= 2/9".
  sigma <= 2/9 makes that bound WEAKER, not stronger: at sigma -> 0 it gives only Q <= 0. Parametrising sigma = 2s/9,
  the chain beats the pair block's -3th0/(n-2) only for s > 0.3402 (n=12); on the remaining third of the block it proves nothing.
  The true value there is MORE negative (-1.854 at s=0) but only because of the Hessian term the chain replaced by kappa^Hess d^2.
  REPAIR (verified): on the block Q/||H||^2 = 3th0(2 mu s - mu - 1/2) + (2/9)|kappa_n| s, monotone increasing in s, max at s=1 = sigma=2/9.
  So c_n = 3 theta_0/(n-2) stands, and L141(b)'s proof needs this monotonicity sentence, which it does not have.
```
