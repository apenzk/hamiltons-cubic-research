# Reviewer r461, audit wave 0, **PARTIAL, SALVAGED FROM THE LOG**

*The reviewer reached verdicts and did not write a report; the process ended first. **This file is its log, edited only to remove heartbeats**, it is evidence at the weight of one reviewer's working notes, not a filed report, and Gate 2 on these claims is not complete.* *Stopped before completing the brief.*

**Claims with a verdict here: L10 L11 L41 L42, four of eleven.**

---

```
PID 7503 | r461-wave0 | phase plan: (1) read conventions.md + README.md, (2) locate 11 claim blocks, (3) per-claim rebuild+attack, log verdict immediately, (4) write reviews/REVIEW_r461.md
23:39:47 HEARTBEAT: conventions+README read; 11 blocks located. NOTE: L14 is NOT in findings/bounds.md as briefed, it lives in findings/curvature-invariants.md:37.
=== L10 (findings/graded-half.md:418) VERDICT: CONFIRMED (numbers), with 2 hypothesis caveats ===
Rebuilt from scratch via symmetric-pair machinery inside so(n): R = mu*mu on Lambda^2 p,
eigenvalue on each k-block = const*(1 - c_j), c_j = Casimir of block wrt g-Killing;
W = R - scal/(n(n-1)) Id; <W,W#> = (1/2) sum_{a,g,d} T_{agd} lam_a lam_g lam_d with
T = c^2, marginals sum_{g,d} T = 2(n-2) per index and c_S = Killing const of each block
subalgebra as embedded in so(n) (must use its action on p, NOT on the ambient g-module).
Normalisation anchored independently: n=4 SD/ASD gives <W,W#> = 6(a1a2a3+b1b2b3), which
reproduces theta_0(4)=sqrt3/2 at S^2xS^2 exactly. So W#_aa = (1/2) sum c^2 lam lam.
INDEPENDENTLY REPRODUCED, exactly:
  CP^m closed form theta^2 = (m+1)(2m-1)/(3m(m-1))  -- proved symbolically for ALL m,
      via ||W||^2 = 12m(m-1)(m+1)/(2m-1) and P = 2(m+1)||W||^2.  Monotone decreasing
      (derivative numerator -3(3m^2-2m+1) < 0), limit 2/3. 3/2 at m=2. CONFIRMED.
  Wolf: HP^2 = 1.1155467 (exact 0.5/sqrt(45/224)), HP^3 = 0.852944.  CONFIRMED.
  Gr_C(2,2) = 0.720082, Gr_C(2,3) = 0.596068.  CONFIRMED (both exact).
CAVEAT 1: the block TITLE says "all below the threshold"; the m=2 member EQUALS the
  threshold sqrt(3/2) (the body says so). Title overstates.
CAVEAT 2: "the families" are verified at TWO members each for Wolf and Gr_C. Quantifier
  gap. I close the Wolf half: theta^2_{HP^m} = (m+2)^2(4m-1)/(9m(2m+1)(m-1)), decreasing,
  <= 56/45 for all m>=2 (checked m=2,3,4 against the machinery, exact).  Gr_C family open.
=== L11 (findings/nondegeneracy.md:434) VERDICT: PLAUSIBLE (conclusion) / REFUTED (stated mechanism) ===
Conclusion (nondegenerate except S^3xS^3) agrees with L27's symbolic argument for p,q>=3.
DEFECT 1 (mechanism, live contradiction with L27 in the same file):
  L11 says the (3,3) exception is because Lambda^2(R^3) (x) Lambda^2(R^3) = R^3 (x) R^3,
  "the orbit's own representation", and "the content lies in the representation
  isomorphism above". As an O(3)xO(3) statement that is FALSE:
  Lambda^2(R^3) = R^3 (x) det, so Lambda^2 |X| Lambda^2 = (R^3 |X| R^3) (x) (det_1 |X| det_2),
  a NON-trivial character twist, hence NOT isomorphic to R^3 |X| R^3.
  L11's own next paragraph concedes multiplicity-freeness under O(3)^2, which already
  says the two pieces are non-isomorphic -- so the block contradicts itself.
  L27 (same file, l.457ff) records exactly this: "an eigenvalue coincidence, not
  representation mixing", and says both its reviewers "refuted the mechanism first
  proposed for the (3,3) exception". L11 still carries the refuted mechanism.
  Verified the coincidence myself: 1/2 - mu = ((p-2)(q-2)-1)/(2(p-1)(q-1)) = 0 at (3,3),
  so mu = 1/2 exactly; kernel 18 = 9 (orbit R^3(x)R^3) + 9 (Lambda^2(x)Lambda^2). Arithmetic OK.
DEFECT 2 (quantifier): L11 quantifies over k,l>=2. L27's proof needs p,q>=3, because
  Nienhaus' 10-summand decomposition FAILS at k=2: I checked the dimension sum --
  (3,3)/n=6 gives 84 = dim Weyl_6 exactly, but (2,2)/n=4 gives 14 vs 10, and
  (2,3)/n=5 gives 37 vs 35. So every k=2 split rests on the n<=14 numerics alone.
  The claim also names "36 splits with k,l>=2 up to n=14" -- I recounted: exactly 36. OK.
DEFECT 3: S^7xS^7 (n=14) admitted to rest on floating point.
Screen of the p=2 branch (analysis, not compute): mu = 1/2 requires (p-2)(q-2)=1, so no
  coincidence at p=2 -- consistent with L11, but that argument uses the very decomposition
  that fails at p=2, so it is not a proof.
=== L41 (findings/target.md:657) VERDICT: CONFIRMED ===
Rebuilt independently. g_gamma = sum_{a,b} T_{gamma a b}(lam_a - lam_b)^2 in an eigenbasis.
(a) sum_gamma g_gamma = 4(n-2)||W||^2 - 4 tr(W#).  I then PROVED tr(W#) = -||W||^2 for
    EVERY Weyl tensor, with no criticality: tr W# = -(1/2) W_abcd W_bcda, and first
    Bianchi gives W_abcd W_bcda = (1/2) S1 with S1 = W_abcd W_abcd = 4||W||^2_{Lambda^2}
    (which is exactly conventions.md's |W|^2 = 4||W||_F^2). Hence sum g = 4(n-1) at unit
    norm, for all Weyl W. The block's "sum_gamma g_gamma = 4(n-1)" needs NO criticality --
    good, and worth stating, since results.md L41 sits under "direct".
(b) sum_gamma lam_gamma g_gamma = -4 theta: verified exactly at THREE witnesses --
    S^2xS^2 (n=4): -sqrt12 = -4*(sqrt3/2). CP^2 padded (n=4, kernel present): -12/sqrt6.
    CP^3 (n=6, three distinct eigenvalues, not self-dual): sum = -9216/5 = -1843.2
    against -4P = -4*460.80 = -1843.2. Exact. Also sum g = 1152 = 4(n-1)||W||^2. Exact.
(c) The bound theta <= |lam_min|(4(n-1) - Delta - G_0)/4 follows by dropping the
    non-negative {lam>0} mass (= Delta) and the kernel mass G_0 from
    sum lam g >= lam_min * sum_{lam<0} g. Correct. Equality checked at both n=4 witnesses.
CAVEAT (minor, precision of the equality clause): the block says equality holds "exactly
  when g is supported on the lambda_min eigenspace". The bound as displayed already
  accounts for the {lam>0} and kernel mass, so equality actually needs only that g
  RESTRICTED TO {lam<0} sits on the lambda_min eigenspace; g may carry mass on ker and
  on {lam>0}. The stated condition is sufficient, not necessary.
CROSS-CHECK: L49's theta = sum lam^3 + 3 sum_{a<b<c} T lam lam lam agrees with my
  normalisation <W,W#> = (1/2) sum_{ordered} T lam lam lam exactly (T vanishes on
  repeated indices, so ordered/6 = a<b<c). Normalisations consistent across files.
=== L42 (findings/stratum-two-negative.md:473) VERDICT: CONFIRMED ===
Rebuilt the LP. 3M = sum_{a<b} lam_a lam_b (sum_gamma t_{ab gamma} lam_gamma), so the
trivial bound is lam_max(s^2-u); the claim replaces lam_max by the HARMONIC MEAN h of
the three largest, which is strictly stronger, so the harmonic mean is load-bearing.
Checks:
 - EXACTLY 3 positives: M = 2 lam1 lam2 lam3, h = 3 lam1lam2lam3/e2, s^2-u = 2e2,
   so RHS = 6 lam1lam2lam3 = 3M.  IDENTITY. Sharpness clause CONFIRMED here.
 - k equal positives: LP optimum t = 2/(k-2) on every triple, 3M = k(k-1)lam^3
   = h(s^2-u) exactly.  Second equality family.  "Constant cannot be improved" CONFIRMED.
 - (R,1,1,1): RHS - 3M = 3(R-1)/(2R+1) >= 0, equality at R=1.  Holds.
 - (1,1,1,R), R<1: both branches of the LP checked, holds for all R in (0,1].
 - (2,1,1,1,1) k=5: 3M = 32 vs RHS 33.6.  (1,1,0.5,0.5): 4.5 vs 4.875.
 - Long-tail stress (1,1,eps x m) with m*eps = c fixed, eps->0: RHS - 3M ~ eps(2c^2+6c)
   >= 0. Holds, and the two sides agree to leading order.
NOTE (scope, not a defect): the LP restricts gamma to the positive block while the true
  pair cap sums over all gamma, so M is an upper bound on the physical quantity -- the
  direction is safe.
NOTE (record hygiene): the L42 block carries NO argument; it points at a prose section
  ("The dim m<=2 stratum, assembled -- closed modulo three nam") in the same file.
  Whether that prose contains a general proof, rather than the two equality families,
  is unverified by me -- my checks are a family of witnesses, not a proof.
```
