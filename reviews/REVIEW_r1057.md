# Review r1057: the i24a pinned-class LP obstruction at n=12

Reviewer r1057, cold brief. Every check below is built from the definitions in the brief. The script under review, [i24a_pinned_lp.py](../scripts/misc/i24a_pinned_lp.py), was neither read, imported nor run; the two LP formulations here were written from the relations and the two reported numbers were reproduced independently, then reproduced a third time in exact rational arithmetic with a dual certificate.

Log: [r1057-i24a.log](../agent_logs/r1057-i24a.log)

## Verdicts

| claim | verdict |
|---|---|
| Claim 1, body: max theta = 0.9242643 at (30,20,16), hence the spectrum is not realisable at or above theta_0(12) | **CONFIRMED**, and strengthened to an exact algebraic identity with a rational dual certificate |
| Claim 1, trailing sentence: "the record's only recorded obstruction to a theta_0(n) threshold at n >= 12 is removed" | **REFUTED as written.** A screen finds three-value spectra at the same multiplicities where the same LP admits theta up to about 1.32 > theta_0(12) |
| Claim 2: post F43 stands, realisability being invisible to a per-row argument | **CONFIRMED** |
| Claim 2's measurement: "the gap 1.2917 vs 0.9242643 measures what the cross-row system adds over the per-row family, a factor of about 1.4" | **REFUTED.** 1.2917 already contains a cross-row relation. The per-row maximum is 1.4078288 and the factor over the per-row family is 1.5232 |

Composite: **Claim 1 CONFIRMED** on the mathematics, with the last sentence struck. **Claim 2 PLAUSIBLE**, conclusion confirmed and measurement corrected.

## 2. The ordered-vs-unordered coefficients, derived here

Fix an unordered triple of distinct indices {a,b,c} and let t denote the common value T_abc = T_acb = T_bac = ... . Row a of each relation sums over ORDERED pairs, so the triple contributes through exactly the two ordered pairs (b,c) and (c,b).

| relation | contribution of (b,c) | contribution of (c,b) | coefficient of t in row a |
|---|---|---|---|
| (A) sum T_abc | t | t | **2** |
| (B) sum lambda_b T_abc | lambda_b t | lambda_c t | **lambda_b + lambda_c** |
| (C) sum lambda_b lambda_c T_abc | lambda_b lambda_c t | lambda_c lambda_b t | **2 lambda_b lambda_c** |

All three agree with the script's stated coefficients. Two independent confirmations that the convention is the right one:

- **The so(3) calibration.** With c_abc = epsilon_abc, row a of (A) over ordered pairs gives 2, and 2(n-2) = 2 at n = 3. The basis is therefore E_ij - E_ji unnormalised, and in that basis T is the **triangle indicator**: T_abc = 1 exactly when the three index pairs are {i,j}, {j,k}, {i,k}. That array satisfies (A) at n = 12 exactly, checked over all 66 indices.
- **The factor-of-two sensitivity test.** Each of the six single-coefficient factor-of-two perturbations was run against a spectrum known to be realisable. Halving or doubling (A) moves the answer to 2.3596995 or 0.4269932 instead of theta_0(12); halving or doubling either (B) or (C) makes the LP **infeasible**. The script's triple is the only one of the seven that reproduces the truth, so a factor-of-two error would not have survived contact with a realisable point.

## 1 and 3. The relaxation, and what it does and does not impose

**The direction is right and only the right direction is used.** If a theta-critical unit W in W_12 has this spectrum, pick any orthonormal eigenbasis and set T_abc = c_abc^2. That T is nonnegative, totally symmetric, vanishes on repeated indices by antisymmetry of c, and satisfies (A), (B) and (C) at that theta. So it is a feasible point, and every realisable theta is at most the LP maximum. The claim uses this and nothing more. It never asserts that a feasible T comes from a W, and it does not claim realisability below 0.9242643.

**No constraint is added.** Indexing the variables by unordered triples of distinct indices *encodes* total symmetry and vanishing on repeated indices rather than imposing them: the map from nonnegative symmetric arrays vanishing on repeated indices to nonnegative functions on triples is a bijection. The LP therefore allows every array a genuine W could produce. The relations are each necessary, (A) and (B) on all of W_n and (C) at critical points, which is where this W lives.

**What is omitted all weakens the LP, which is the safe direction.** The Jacobi identity, the signs of c_abc (T sees only squares), the requirement that the basis be an actual Lie-algebra basis of so(12), and the pair cap are all absent. An honest T satisfies more than the LP asks, so the LP maximum is an upper bound on the true maximum. That is why the conclusion is one-sided and sound.

## 4. theta free, and the maximum attained

theta enters only through the (C) rows, as -2 lambda_a theta moved to the left-hand side, and it carries no bound. It is free and may be negative. The feasible set is a **compact** polytope: (A) with T >= 0 forces every variable into [0, 2(n-2)], and with T bounded and every lambda_a nonzero the (C) rows bound theta. A linear objective on a nonempty compact polyhedron attains its maximum, so "max" is correct and no supremum argument is needed. The solver reports an optimal basis rather than unboundedness, consistent with this.

## 5. The inference

The logical form is:

> W theta-critical, unit, spectrum (30,20,16) ⟹ ∃ T >= 0 with (A),(B),(C) at theta ⟹ (T, theta) feasible ⟹ theta <= max = 0.9242643.

The contrapositive is what is claimed: theta > 0.9242643 ⟹ no such W. The quantifiers check out because the maximum is taken over the whole feasible set, so the projection of that set onto the theta axis is contained in (-inf, 0.9242643]. Since theta_0(12) = 1.2360331 > 0.9242643, no such W exists at or above theta_0(12). **Valid.**

**This contradicts a caveat already on the record, and the caveat is the thing that is wrong.** [DERIVE-t11](DERIVE-t11.md) pre-registered this run and closed the paragraph with "Neither outcome bears on realisability, which the LP cannot see." That is false for the outcome that occurred. The LP is a relaxation, so it cannot certify realisability but it *can* refute it, and this is exactly the case where it does. The sentence should be corrected to say that the LP sees non-realisability above its optimum and nothing below it.

**The value is exact, not floating-point.** Write lambda_a = mu nu_a with nu = (-1, 6/5, 3/8) rational and mu = 1/sqrt(1221/20), and theta = mu tau. Relation (A) is mu-free, (B) is homogeneous of degree one in lambda and (C) of degree two, so mu cancels throughout and the LP is rational in (nu, tau). Solving on the reported optimal support in exact arithmetic gives

- tau_max = **74239/10280**, so theta_max = **6749 sqrt(6105) / 570540** = 0.9242642699937805,
- theta_0(12)^2 - theta_max^2 = **1185077267 / 1759545360 > 0**, an exact rational inequality.

The reported 0.9242643 is right in every digit shown.

## 7. The vacuity test, the decisive item

**The LP is not vacuous. It is exact on every realisable spectrum tested.**

A realisable n = 12 spectrum was constructed from scratch rather than taken from the record. For the splitting R^12 = R^p + R^q the standard basis of so(12) is an eigenbasis, with alpha on so(p), beta on so(q) and gamma on the mixed block. Imposing (B) forces (p-1)alpha + q gamma = 0 and (q-1)beta + p gamma = 0, imposing (C) forces theta = -(n-1)gamma, and unit norm then fixes everything. At p = q = 6 this gives theta = sqrt(2(n-1)(n-2))/n = **theta_0(n) identically**, so the balanced product is the theta_0 extremiser and its spectrum is realisable at exactly the threshold. The triangle-indicator T was checked to satisfy (A), (B) and (C) at all 66 indices to machine zero.

| spectrum | true theta | LP max theta |
|---|---|---|
| balanced 6+6 product, (30 at 1.2m, 36 at -m), realisable | 1.2360331 = theta_0(12) | **1.2360331** |
| 5+7 product, (10, 21, 35), realisable | 1.2282392 | **1.2282392** |
| candidate (30, 20, 16) | none | 0.9242643 |

The LP returns the truth to seven digits at both realisable points, and the symmetrised triangle indicator sits in the feasible set at theta_0 with residual 3.6e-15. A screen deforming the balanced spectrum by splitting its 36-fold class into 30 + 6 shows the LP value moving **continuously** down from 1.2360331 (1.2343 at e = 0.001, 1.2188 at 0.01, 1.1501 at 0.05, 0.9037 at 0.2), so the low value at the candidate is a property of that spectrum and not a systematic collapse on three-value spectra.

**But the same screen refutes Claim 1's last sentence.** Holding the multiplicities at (30, 20, 16) and moving the third value, the LP maximum runs 0.6652 at 0.575, 0.9243 at 0.375, 1.2354 at 0.200, **1.3193 at 0.150, 1.3102 at 0.100, 1.2904 at 0.050**, all above theta_0(12) = 1.2360331. *Reported as a screen and not as evidence for a positive claim.* What it shows is that the full pinned class at n = 12 and three distinct eigenvalues still admits theta > theta_0(12), so the obstruction removed by this cycle is the removal of **one exhibited witness**, not of the class of obstructions. The sentence "the record's only recorded obstruction to a theta_0(n) threshold at n >= 12 is removed" should be struck and replaced by "the (30,20,16) witness is removed, and the pinned class at d = 3 has not been shown to force theta <= theta_0(12)". The run that would settle the replacement, a sweep over three-value n = 12 spectra maximising the pinned LP value, is **long and open-ended and is not started here**; it is named and left for the user's decision.

## 6. Post F43

**The conclusion stands, and the reasoning given for why it stands is correct.** A per-row condition is an implication over the ambient set of pairs (spectrum, theta), not over realisable ones. If the complete per-row condition (Theorem B of [DERIVE-t11](DERIVE-t11.md)) is satisfied by (lambda, 1.2917), then no consequence of the per-row family can be "theta <= theta_0(12)", because the family has a model where the conclusion fails. Realisability never enters, exactly as claimed. Unrealisability of the witness therefore does **no** damage to post F43. The LP result is in fact the positive content behind that: the rows are individually satisfiable at 1.2917 and jointly unsatisfiable there, which is precisely the cross-row content the post said was all that remains.

**The measurement attached to it is wrong.** The per-row relaxation was solved here directly. For each class, maximise theta subject to a nonnegative symmetric row marginal with total 2(n-2), first moment -2 lambda_a and second moment 2 lambda_a(theta - lambda_a). This is exactly the post's own description, the pair-points P_jj = (nu_j, nu_j^2) on the parabola and P_jk the tangent intersection. The result:

| row class | max theta |
|---|---|
| -m, multiplicity 30 | 1.4078288 |
| 1.2m, multiplicity 20 | 1.4078288 |
| 0.375m, multiplicity 16 | 4.1178993 |
| **per-row maximum** | **1.4078288** |

So 1.2917 is **not** the per-row value. [DERIVE-t11](DERIVE-t11.md) says so itself: "recovers part of that pinning (1.2917 against the per-row 1.4078) and not all of it". 1.2917 is the value after the Sigma-budget, which is a **joint** relation, so the gap 1.2917 to 0.9242643 measures what the full pinned system adds over *Theorem D*, per-row plus one cross-row ingredient. The gap the sentence names, cross-row over per-row, is **1.4078288 to 0.9242643, a factor of 1.5232**. The correction to make is one clause: replace "over the per-row family" with "over Theorem D, whose 1.2917 already carries the Sigma-budget", and record 1.5232 as the per-row figure. The same calculation at the balanced 6+6 spectrum returns the per-row maximum 1.2360331 = theta_0(12) exactly, consistent with the post's d = 2 exactness statement and a check on the formulation.

## Lean

| claim | declaration |
|---|---|
| max theta = 0.9242643 at (30,20,16) | **NONE EXISTS, and one is now within reach.** A dual certificate was extracted here in exact rationals and is given below. What it would have to contain, and now does: a vector y in Q^(3d) with (i) the theta column normalised, (ii) every triple-type column nonpositive, (iii) the dual objective equal to the primal. With that in hand the Lean statement is a finite rational inequality with no solver in the trusted path, provable by `norm_num` on the certificate plus a short symmetrisation lemma. |
| (30,20,16) is not realisable at theta >= theta_0(12) | **NONE EXISTS.** It is the contrapositive of the row above plus the observation that every critical W supplies a feasible T. The second half is the part that needs real Lean work, since it needs c_abc^2 and relations (A), (B), (C) formalised; the LP half becomes arithmetic once the certificate is in. The final comparison is the exact rational 55/36 - 501039011/586515120 = 1185077267/1759545360 > 0. |
| post F43 stands | **NONE CAN EXIST**, and this is right. It quantifies over a family of arguments. What *is* typable is the witness fact underneath it, that a specific (lambda, theta) with theta > theta_0(12) satisfies the per-row conditions, and that is a finite check. |

**The exact dual certificate**, on the symmetrised nine-row system with rows ordered (A, B, C) per class and classes ordered (-1 at 30, 6/5 at 20, 3/8 at 16):

```
y = ( -144/257,  240/257, -100/257,   0, 0, 0,   72/1285, -516/1285, 76/257 )
```

Dual feasibility holds on all ten triple types, six at equality and the rest strictly negative (-393008/257, -104544/257, -19602/257, -22869/2056). The theta column evaluates to exactly -1 and the dual objective to -74239/10280, matching the primal optimum, so strong duality is exhibited rather than asserted. The reduced system bounds the full one by averaging over S_30 x S_20 x S_16, which preserves feasibility and theta because the constraint coefficients depend on an index only through its eigenvalue; the full 45,760-variable LP was solved separately and returns the same value, so that lemma is corroborated as well as argued.

## Corrections owed

1. Strike Claim 1's final sentence. The pinned class at n = 12, d = 3 has not been shown to force theta <= theta_0(12), and a screen finds nearby spectra where it does not.
2. Correct Claim 2's measurement: 1.2917 is Theorem D's value, not the per-row value. The per-row maximum is 1.4078288 and the cross-row-over-per-row factor is 1.5232.
3. Correct [DERIVE-t11](DERIVE-t11.md)'s pre-registered caveat "Neither outcome bears on realisability, which the LP cannot see." A relaxation refutes realisability above its optimum, which is what happened.
4. Record the exact value 6749 sqrt(6105) / 570540 and the dual certificate alongside the decimal, so the number stops being a solver output.
