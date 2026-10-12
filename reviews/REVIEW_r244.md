# Gate 2 review r244 -- A2', the certificate point as a Cramer formula

Commit under review: `5df6750`, [run_a2prime_point_formula.py](../scripts/runs/run_a2prime_point_formula.py). Claims 3, 5 and 6; claims 1, 2 and 4 go to r243.

Scripts: [scripts/reviewers/r244/](../scripts/reviewers/r244/). Every verdict rests on exact arithmetic -- sympy over Q(n), Fraction/LDL^H over Q(i). One magnitude *measurement* uses 60-digit mpmath and is labelled as such; nothing numerical carries a positive claim.

| # | Claim | Verdict |
|---|---|---|
| 3 | Cramer gives Q(n) entries; one sign-constancy obligation on xi(n) suffices | **TRUE IN SUBSTANCE, FALSE AS STATED.** One minor *is* enough, by an argument the file omits. But the hypothesis names the wrong predicate (witness below), and it guards a different point from the one the theorem defines. |
| 5 | Open case: if no constant t, take t polynomial in n and fit its coefficients | **THE FALLBACK IS REFUTED AS WRITTEN (witness).** A family of A2's exact shape has a nonempty feasible set at every n and admits *no* polynomial t of any degree. Repair: t rational in n, which costs (b) and A5 nothing. Separately, the constant-t question is a finite convex-feasibility question, not an open-ended one. |
| 6 | The screen's exhibited four-point-fit failure | **REFUTED. It is a straw man, and it hides the direction that matters.** Under an honest solver model the fit either succeeds exactly or misses by `2.7e-8` -- quiet enough to pass acceptance -- against the screen's manufactured median miss of `0.24`. |

---

## Claim 3 -- does Cramer actually give Q(n) entries here?

Script: [c3_pivot_minor.py](../scripts/reviewers/r244/c3_pivot_minor.py).

**The brief's worry is a real phenomenon and it does not sink the claim.** In a 2x4 miniature with entries polynomial in n, 4 of the 6 candidate pivot sets have a minor vanishing inside `[12, infinity)` -- cols (0,1) at n=12, (0,2) at 13 and 20, (1,2) at 20 and `7+sqrt(37)`, (2,3) at 20 and 27 -- and only (0,3) and (1,3) survive. That is reviewer 242's `869n - 2767` in miniature. It is survivable because a pivot set is a *choice*: one surviving choice is all Cramer needs.

**One minor genuinely suffices, and the reason is missing from the file.** `xi(n0) != 0` forces `rank A(n0) >= |S|`, and rank can only drop under specialisation, so `rank A(n0)` equals the generic rank exactly. The nullity is then constant across the range, and the `K_i` -- each carrying a unit vector on its own non-pivot coordinate -- stay independent, hence stay a *basis*, so the specialised family is the whole solution set at each n. Verified: `A x_p - b == 0` and `A K_i == 0` identically in Q(n), rank and nullity anomaly-free at every even n in [12, 60]. **The pivot set does not have to be certified as a whole.** A2' asserts the conclusion; the rank-semicontinuity step is what carries it.

Three defects stand.

**(i) The stated hypothesis is the wrong predicate -- witness.** A2' asks that `xi(n)` be *sign-constant* on `[12, infinity)`. Cramer needs it *nonzero*. Take `xi(n) = (n-20)^2`: sign-constant (>= 0) throughout, zero at n = 20. The live instance `diag(1, (n-20)^2) x = (1,1)` gives `x(n) = (1, 1/(n-20)^2)`, so the family has no member at n = 20 while the hypothesis holds. Determinants acquire even-multiplicity roots readily, so this is not contrived. The file imported the obligation type from A5, where sign-constancy is right because those minors are *PSD conditions*; a Cramer *denominator* wants root-freeness. Note the file's own screen checks root-freeness (`bad = [r for r in roots if r.is_real and r >= 12]`) -- so **the script tests a stronger property than the theorem states**, and the theorem is what would be cited.

**(ii) The obligation guards a different object from the one the theorem names.** A2'(a) calls `B_p` "the minimum-Frobenius-norm solution". Cramer on a pivoted system returns the *basic* solution, with non-pivot coordinates set to zero. They are different points with different denominators: in the miniature the basic solution's denominator is `xi(n) = n+1`, degree 1, and the minimum-norm solution's is `det(A A^T)`, degree 6. A single pivot-minor obligation does not guard a `det(A A^T)` denominator. The repair costs nothing -- soundness needs *some* particular solution, not the shortest -- but as written the guarantee does not cover the stated point.

*Aside on 242's factor.* By Cauchy-Binet `det(A A^T)` is a sum of squared maximal minors, hence `>= 0` over the reals with a real root only where every maximal minor vanishes. A bare linear factor `869n - 2767` in a Gram determinant is therefore itself anomalous -- a real root of odd multiplicity cannot survive in a sum of real squares, so either that step is not over R or the factor is paired. Worth a line in A2.

**(iii) The screen exercises none of this.** The augmented miniature is 3x3 with `det = 5 - 2n` and empty nullspace, which the file asserts. So: exactly one square submatrix using all columns, hence *no pivot choice*; no free parameters t, hence *no kernel basis to certify*; a unique solution, making "minimum-Frobenius-norm" *vacuous*; and no way for one minor to vanish while another does not. The screen demonstrates that sympy solves a 3x3 system symbolically. Claim 3's structure begins at 2x4.

**Owed:** state the hypothesis as root-freeness of the *chosen* `xi(n)` on `[12, infinity)`; name `B_p` as the basic solution at that pivot set; add the rank-semicontinuity sentence. One practical note the file understates: `xi(n)` is a determinant of an r x r matrix with r of order 89 and entries of degree <= 6, so its degree is of order several hundred. "ONE more Sturm item" is one item, not a cheap one.

---

## Claim 5 -- is there a structural reason a constant t would or would not exist?

Script: [c5_constant_t_structure.py](../scripts/reviewers/r244/c5_constant_t_structure.py). Screen: [c5_n5_interior_or_boundary.py](../scripts/reviewers/r244/c5_n5_interior_or_boundary.py).

### R1. The constant-t question is finite convex feasibility, not a search

For each even n >= 12 put `S_n = { t in R^k : B_p(n) + sum t_i K_i(n) >= 0 }`.

- `t -> B(t;n)` is affine and the PSD cone is closed convex, so **every `S_n` is a spectrahedron in one fixed `R^k`** -- k is constant across the range by claim 3's rank theorem above.
- A constant t works **iff** `intersection over n of S_n` is nonempty. This is convex feasibility in a fixed finite-dimensional space. It needs no ansatz and is not a fitting problem.
- **Helly.** If at least one `S_{n0}` is *bounded*, intersecting the family with it makes every member compact convex, and Helly in `R^k` gives: the full intersection is nonempty **iff every k+1 of the `S_n` have a common point**. So a *finite refutation exists*: constant t is dead as soon as k+1 dimensions have no common feasible point, and that one joint infeasibility carries an exact Farkas certificate. A legitimate screen -- it refutes, it does not establish.
- **Boundedness is itself structural and checkable at one n:** `S_n` is bounded iff its recession cone `{ t : sum t_i K_i(n) >= 0 }` is `{0}`, i.e. iff the span of the kernel basis contains no nonzero PSD matrix.

**What sharpness does and does not cost.** At even n the forced kernel makes every feasible B singular, so `S_n` has empty interior in the *unrestricted* family. A2' already imposes `B v(n) = 0` inside the family, so `B(t;n)` lives in the PSD cone of `v(n)^perp` and `S_n` can have nonempty *relative* interior there. The kernel direction `v(n)` moves with n, but that is absorbed by `B_p` and `K_i` being n-dependent. **Sharpness is therefore not a reason the intersection must be empty.** The file concedes the open case without this analysis, and the analysis says the concession is premature.

### R2. The polynomial fallback is refuted by a witness of A2's own shape

Take entries in Q(n), affine in t, exactly `B_p(n) + t K(n)`:

```
B_p(n) = [[1, -1/n], [-1/n, 1/n^4]]      K = [[0, 1], [1, 0]]
det B(t;n) = -(n^2 t - n - 1)(n^2 t - n + 1)/n^4
```

`B_11 = 1 > 0`, so `B >= 0` iff `det >= 0`, giving `S_n = [1/n - 1/n^2, 1/n + 1/n^2]` -- **nonempty for every n >= 12**, of width `2/n^2 > 0`, and containing `t = 1/n`. Checked exactly at n = 12, 14, 100, 10^6.

**No polynomial `t(n)` is feasible, at any degree.** Feasibility forces `|t(n) - 1/n| <= 1/n^2` for all even n >= 12, so `t(n) -> 0`; a polynomial tending to 0 along an infinite set of integers is the zero polynomial; and `t = 0` gives `|0 - 1/n| = 1/n > 1/n^2`. Contradiction. No degree bound could rescue it, because every degree fails.

Yet `t(n) = 1/n` in Q(n) is feasible at every n, and `B(t(n);n)` still has entries in Q(n), so claim (b) and A5 are untouched. **So A2's fallback as written -- "t must be taken polynomial in n of bounded degree" -- is not merely missing a bound; it can be unavailable while a rational t exists.** The fallback should read `t in Q(n)`. A2' currently poses a false dichotomy, constant-else-polynomial; the true trichotomy is **constant, else rational, else no member of the family certifies at all**.

### R3. What 242's owed degree bound is a bound on

`S_n` is cut out by minors of `B(t;n)`, so its boundary is an algebraic function of n with a Puiseux expansion in powers of `n^(1/q)`. A polynomial `t(n)` of degree d can track an algebraic centre curve only to the resolution its degree allows. Hence:

> **a degree bound exists iff the width of `S_n` is bounded below by some `n^(-M)`** -- and then d is bounded in terms of M and q.

That is the shape of 242's owed bound, and it is owed on a quantity the record does not have: **an effective lower bound on the margin of the certificate, uniform in n.** Without it, "fit the coefficients of t" has no stopping rule -- no failure at degree d refutes degree d+1. The witness in R2 is exactly the dangerous case: positive width at every n, shrinking, so the search neither terminates nor refutes. **A width lower bound is the first thing to derive, before any t is chosen.**

### Screen (refuting only)

The record's one completed certificate, n=5, is **strictly positive definite**: all 16 blocks, exact `LDL^H` over Q(i), every pivot > 0, smallest `2.258e-02`. n=5 is odd, has no balanced product and no forced kernel, so it is the *interior* regime -- and [sym3-blocks.md](../findings/sym3-blocks.md) records the mechanism, a product of two cubics of K already vanishing at `W_0`, so sharpness there is absorbed by the covariants rather than by a kernel in B. **This screens out one reading of the record:** n=5 cannot be cited as evidence that an arbitrary or constant selection survives at even n, because it is an instance of the other regime. It establishes nothing positive, and I do not offer it as one.

*Cross-claim note for r243 (claim 1).* n=5 is a live counterexample to the naive form of "sharp implies forced kernel": the bound is sharp and the Gram is strictly PD, because the evaluation covector itself vanishes at the extremiser. Claim 1 needs `v(n) != 0` at even n as an explicit hypothesis.

---

## Claim 6 -- the screen's exhibited four-point-fit failure

Script: [c6_solver_model.py](../scripts/reviewers/r244/c6_solver_model.py).

**It is a straw man, on four counts, and the fourth is the serious one.**

**1. It is a tautology.** `solver_output(20)` draws a *fresh* random t after the fit is made. Extrapolating four samples of a random variable and comparing to a fifth independent sample fails with probability 1 for *any* fitting method, sound or not. Across 40 seeds: 0 exact hits, median relative miss `0.24`, max `503`. The test measures the planted noise.

**2. The noise model is wrong.** A converged primal-dual interior-point solver does not return "whatever its path-following happens to hit" -- it returns the **analytic centre of the optimal face**, a canonical point, hence a deterministic function of n. And the screen's stated premise, *"four arbitrary points of four DIFFERENT feasible bodies"*, is the false part: the four bodies are four members of **one rational family**, so their analytic centres lie on one algebraic curve rather than scattered.

**3. The ansatz is under-parameterised before any noise is added.** With a rational selection `t(n) = 6 - n/12`, the miniature's coordinate 0 is exactly `(14n^3 - 169n^2 + 872n - 1320)/(24n^2 - 108n + 120)` -- type (deg 3 / deg 2). The screen fits (deg 2 / deg 1) at four points, which cannot represent it. Part of the "failure" is a wrong ansatz, not a wrong method.

**4. The straw man hides the direction that matters.** Modelling the solver honestly, with an adequate (deg 3 / deg 2) ansatz at six dimensions and a held-out n = 26:

| solver model | relative miss at the held-out dimension | consequence |
|---|---|---|
| screen's random kernel component | median `2.45e-01` | LOUD -- any check catches it |
| **rational** analytic centre (2 active constraints) | **exactly 0** | the fit is CORRECT; the screen's `assert not fit_ok` would FIRE and crash it |
| **algebraic** analytic centre (3 active constraints, `t(n) = 5n/18 - sqrt(61n^2+114n+1116)/18 + 16/3`) | **`2.72e-08`** | QUIET -- passes a `1e-6` acceptance test |

The honest model's miss is roughly `9e6` times *smaller* than the manufactured one. **A4's real hazard is a quiet wrong answer; the screen produces only loud ones**, so it makes the flaw look easier to detect than it is. And the rational-centre row is worse than that: dropped into the screen, an honest model makes the screen crash announcing that the flaw is not exhibited.

**The repair is available and the file does not use it.** A2' is still right, for a reason the screen never states: the analytic centre is an *algebraic function of n of uncontrolled degree*, so no rational ansatz of bounded degree is **justified**, however well it fits -- and by row 3 above it *will* fit well. That argument survives an honest solver model. The screen should make it instead of planting randomness.

---

## Summary of what is owed

1. **Claim 3, hypothesis.** Restate as root-freeness of the chosen `xi(n)` on `[12, infinity)`; sign-constancy is A5's predicate, not a denominator's. Witness: `(n-20)^2`.
2. **Claim 3, object.** `B_p` is the *basic* solution at the pivot set, not the minimum-Frobenius-norm solution; the two have different denominators.
3. **Claim 3, argument.** Add the rank-semicontinuity step -- it is what makes one minor sufficient, and it is currently absent.
4. **Claim 5, fallback.** Change "polynomial in n of bounded degree" to "rational in n". The polynomial form is refuted by a witness of A2's own shape.
5. **Claim 5, before conceding.** Test constant t as a joint convex-feasibility problem over k+1 dimensions; Helly makes that a complete refutation criterion when one `S_n` is bounded, and boundedness is decidable at one n.
6. **Claim 5, the real owed bound.** An effective lower bound on the width of `S_n`, uniform in n. Without it the fitted-t route has no stopping rule.
7. **Claim 6, the screen.** Replace the random kernel component with an analytic-centre model, and rest the argument on the *algebraicity* of the centre rather than on planted noise.
