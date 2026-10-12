# Gate 2 review 194, the assembly: what the four claims' checks can and cannot see

Scope: the four claims of the Gate 2 brief, i.e. the text of [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) and [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) as committed at f5105a3. Priority as briefed: claims 2 and 4. Scripts under [scripts/reviewers/r194/](../scripts/reviewers/r194/). Everything below is exact arithmetic except the PSD eigenvalue checks in [abstract_vs_ambient.py](../scripts/reviewers/r194/abstract_vs_ambient.py), where the witness is an explicit rational matrix whose spectrum is checkable by hand.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | the current abstract-vs-ambient text is right | **CONFIRMED**, and the derivation the file omits is supplied. The ambient alternative is *sound but incomplete*, which is sharper than "the feasible set moves" |
| 2 | kappa = 6 pins metric, cube map and coordinate solve **jointly** | **REFUTED.** kappa = 3! is a formal identity in (H, w) for *every* Hermitian H and *every* vector w. It constrains one of the three, and only up to a scalar. A rational compensating pair is exhibited |
| 3 | the repaired cross-weight check is real and returns 0 | **CONFIRMED**, recomputed independently over **Z**: 0 nonzero of **1168** (the file's "~1180"). It can fail; its scope is the cache's weight labelling alone |
| 4 | stage 3's three checks can fail; "rank at most 14" is right | **REFUTED as stated.** None of the three exists in the code. Check 1 cannot fail beyond a one-bit test on Q. The bound 14 is correct but vacuous below 15 samples. **All three are exactly invariant under the h-Hadamard error the same docstring calls load-bearing** |

---

## Claim 2, kappa = 6 is a tautology, not a joint check

### The identity

Let H be **any** Hermitian form on C^N, no positivity, no invariance, no relation to a Weyl basis. Let w in C^N be **any** vector. With the file's own definitions,

- `cube`: c_t = multinom(t) · prod_{a in t} w_a,
- `sym3_ip` under FISCHER: K(t,s) = sum over sigma in S_3 of prod_i H(t_i, s_sigma(i)),

we have **tot = sum_{t,s} c_t conj(c_s) K(t,s) = 3! · (w^dagger H w)^3, identically**.

*Proof.* Summing a function of the multiset against multinom(t) is summing it over ordered triples: sum_t multinom(t) w^t f(t) = sum over ordered a of w^a f(t(a)). And K(t(a), t(b)) = perm[H(a_i, b_j)]. Hence

    tot = sum over ordered a,b of w^a conj(w^b) sum_sigma prod_i H(a_i, b_sigma(i))
        = sum_sigma prod_{i=1}^{3} ( sum_{p,q} w_p conj(w_q) H(p,q) )
        = 3! (w^dagger H w)^3.

The three factors decouple because sigma is fixed before the a, b sums are taken. **QED**

### What follows

| ingredient the docstring says kappa ties in | does kappa see it |
|---|---|
| the coordinate solve `coords` | **no**, w is arbitrary in the identity |
| the Hermitian Gram H | **no**, H is arbitrary in the identity |
| the cube map's multinomial vs the permanent normalisation | **only their product**, and only up to a scalar |

So "breaking any ONE of the three destroys its constancy" is false for two of the three. Confirmed on the **real** H of [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py), by exec'ing that file's own definitions of `H`, `sym3_ip`, `cube` and `coords` and substituting, [kappa_on_the_real_H.py](../scripts/reviewers/r194/kappa_on_the_real_H.py):

| perturbation of the real pipeline | kappa |
|---|---|
| the honest coordinate vector of a rational Weyl tensor | 6 |
| w replaced by an unrelated random vector (coordinate solve deleted) | 6 |
| H's ten within-weight off-diagonals **deleted** | 6 |
| one within-weight off-diagonal of H perturbed by 7+3i | 6 |

The third row is the sharp one. The file's own comment says those ten entries are "exactly where nothing else in the pipeline looks". kappa does not look either.

### A compensating pair, rational and exact

Reviewer 191's individual tests reject two things: dropping the multinomial from `cube` ("gives 4 values") and the MULT_UP inner-product convention (fails adjointness). **Commit both and kappa returns to 6 exactly**, because multinom(t) = 6/aut(t) makes the two errors reciprocal term by term:

    correct:   (6/aut t)(6/aut s) w^t conj(w^s) K(t,s)
    the pair:  1 · 1 · w^t conj(w^s) · 36 K(t,s)/(aut t · aut s)

Verified on the real H, three trials, exact equality, section (5) of [kappa_on_the_real_H.py](../scripts/reviewers/r194/kappa_on_the_real_H.py). There is also a one-parameter family the check cannot see at all: scaling `cube` by lambda and the ip rule by 1/lambda^2 leaves kappa at 6 for every lambda.

### The printed test is weaker still

Line 250 prints `len(set(kappas)) == 1`, **constancy**, not the value. BOMBIERI (divide by 3!) is constant too, at 1, by the same theorem; so is any fixed rescaling. The number 6 lives in a comment and in a reviewer's memory, never in an assertion. Section (E) of [kappa_is_a_tautology.py](../scripts/reviewers/r194/kappa_is_a_tautology.py) shows BOMBIERI passing the shipped test over five random (H, w).

Two incidental defects in the same block. `kappas.append(...)` sits under `if n2[0]:` while the very next line prints `kappas[-1]` unconditionally, an `IndexError` on the first degenerate sample, or a silently repeated stale value later. And the "all imaginary parts vanish" line at 251 reads `tot` and `n2` after the loop, so it reports the last trial only.

### What a real joint check looks like

The whole polarised family shares the tautology: `<W^3, V^3> = 3! <W,V>^3` for any two vectors, by the same proof. Content requires leaving the pure powers.

- **for H**, skew-adjointness of the so(5) action, `<X·u, v> + <u, X·v> = 0`. This is 191's adjointness test; it is the right one and kappa is not a substitute for it.
- **for the coordinate solve**, the round trip, reconstruct W = sum w_a f_a and compare to the input. The record says this was done and returns exactly 0.
- **for the cube map against the metric**, evaluate on a non-pure element of Sym^3, e.g. W^2·V, against a direct tensor-product computation. `assert kappa == 6` would at least pin the scalar; it still admits the compensating pair above.

---

## Claim 4, stage 3's three checks

### They are not in the code

[run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) is 64 lines, added whole in one commit, `8f6b4cc feat(n=5): stage 3, the assembly, with three checks that can fail`. The file contains no B, no Q, no coefficient matrix, no solve, and none of the three checks. It loads the adapted basis, indexes 7770 adapted vectors by weight and prints the size of the largest per-weight solve. The docstring's "Checks that can fail, run before the solve" describes code that does not exist, and the commit subject asserts it as done.

Run to completion here, it takes 10 min 13 s, 613 s of it building the adapted basis, which does report 24/24 blocks with a shared word list, 41 copies and 7770 vectors, and its entire remaining output is three lines of weight bookkeeping: 7770 adapted vectors over 169 weights, largest weight space 234, sum of squares of sizes 921,780. No B, no rank, no solve.

That answers "can each actually fail" in the operational sense: none of them can, because none of them runs. What follows is the analytic answer to whether they *would* have content once written.

### Check 1, B Hermitian: a one-bit test of Q

    B_ij = sum_pq conj(c^i_p) Q_pq c^j_q
    conj(B_ij) = sum_pq c^i_p conj(Q_pq) conj(c^j_q),   B_ji = sum_pq conj(c^j_q) Q_qp c^i_p

The two agree termwise **iff conj(Q_pq) = Q_qp**. So

> B is Hermitian at every point **if and only if** Q is Hermitian, for arbitrary c, including garbage, degenerate and zero c.

Exhibited in [stage3_checks_blind.py](../scripts/reviewers/r194/stage3_checks_blind.py). The check tests the construction of one matrix and nothing else: not phi_j phi_i^{-1}, not the per-weight solve, not W^3, not invariance, not the sample points. Since Q is built as a Gram, its Hermitian-ness is a property of that one loop.

### Check 2, the trivial block: real, and narrow

The trivial multiplicity at n=5 is **1**, `dim (Sym^3 Weyl_5)^{O(5)} = 1`, confirmed here by running [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) (degrees 2..6 give 1, 1, 4, 5, 14) and, structurally, by the Lovelock collapse `<W#, W> = 2 tr(W^3)` at n <= 5. So B for that block is 1x1, `B_11 = Q_11 |c_1|^2`, and c_1 is a scalar multiple of the unique cubic invariant by Schur. The check can fail and does test the isotypic projection at that block.

Two limits. The constant is fitted rather than predicted, the same file's stage-2 docstring already records the absolute version as ill-posed, at 1/120960 for the cache as it stands, so falsifiability begins at the *second* sample point. And the block is 1 of 24, carrying 1 of the 89 real unknowns.

### Check 3, "rank at most 14"

**The bound is right.** Each B_ij is an O(5)-invariant sextic: y_i(gW) = g·y_i(W) by equivariance of the copies, and Q is invariant, so `<y_i, y_j>` is. `dim (Sym^6 Weyl_5)^{O(5)} = 14`, and at n=5 the O and SO counts coincide because O(5) = SO(5) x {±I} with -I acting trivially on a four-index tensor. Two independent routes give 14, the exact Weyl integration in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), and r179's diagram-rank evaluator reproducing 1,1,4,5,14.

**It can fail, and it has already fired once in this programme, reproduced here.** Re-running [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py) gives coefficient rank **89, full** against augmented rank 90 over 140 sample points, on the predecessor construction whose columns `P_i conj(P_j)` are *not* invariant sextics, for the structural reason that file itself gives: `g^{-1} u_i` leaves the span of the highest-weight vectors. Rank 89 against a ceiling of 14 is the check firing, and its diagnosis ("the equations are not all invariant"), was exactly right there.

**What exceeding it diagnoses, stated precisely.** rank > 14 proves that at least one column function `W -> B_ij(W)` fails to be an O(5)-invariant sextic. The reachable causes are: the copies are not genuine isotypic components (the per-copy-word-list negative control, which the stage-2 docstring records as *passing* the spanning check, this is the error class the rank check actually exists to catch); Q is not an invariant form; **the adapted basis is not held fixed across samples**, so `B_ij` is not one function at all; or arithmetic error. The last of these is the one the docstring's "something upstream is wrong" undersells: a per-sample pivot choice in the per-weight solves would break the check while leaving every other stage self-consistent.

**Falsifiability precondition.** The Hermitian block-diagonal G has `sum m_lambda^2 = 89` real unknowns over the 24 blocks (multiplicities 4, 4, 3, nine 2s, twelve 1s; `sum m = 41`, `sum m(m+1)/2 = 65`), and the real columns `{B_ii} u {Re B_ij, Im B_ij}_{i<j}` also number 89. So `rank <= min(#samples, 89, 14)` and **the check is vacuous below 15 sample points**. Stage 3 states no sample count.

**The bound is also the wrong quantity to check.** What the solve needs is not `rank <= 14` but `rank(A) == rank([A | F_5])`, whether F_5 lies in the column span at all. That is the test with content, [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py) line 210 already implements it, and it is absent from stage 3's list. With 89 unknowns against at most 14 constraints the kernel has dimension at least 75, so the linear system is not what decides the route; consistency and PSD are.

### All three checks are blind to the h-Hadamard error

This is the load-bearing finding. Both docstrings identify `B_ij -> h_ij B_ij` as the error that "moves the SDP's feasible set". Every one of the three checks is **exactly invariant** under it, so the single disputed error passes all three, no compensating pair is needed.

| check | behaviour under B -> h∘B |
|---|---|
| B Hermitian | `(h∘B)_ji = h_ji B_ji = conj(h_ij) conj(B_ij) = conj((h∘B)_ij)`. h is a Gram, hence Hermitian; **preserved** |
| trivial block | multiplicity 1, so `h_11 > 0` is a scalar and `h_11 B_11` is still proportional to `tr(W^3)^2`; **preserved** |
| rank <= 14 | a nonzero-constant rescaling of each column; the rank is **unchanged exactly**, not merely still <= 14 |

Demonstrated on explicit matrices in [stage3_checks_blind.py](../scripts/reviewers/r194/stage3_checks_blind.py). Stage 3's opening paragraph, "everything upstream is now verified by at least two independent reviewers ... and kappa = 6 ties all three together", therefore rests, at its last clause, on the tautology of claim 2, and its own three checks cannot recover the guarantee.

---

## Claim 1, the current text is right, and the alternative is sound but incomplete

Confirmed, with the derivation the file asserts as a "reading". Fix equivariant `phi_1..phi_m : V(lambda) -> Sym^3(Weyl_5)` spanning `Hom_G(V(lambda), .)`; every x in the isotypic component is uniquely `x = sum_i phi_i(y_i)`. By Schur every **invariant** Hermitian form on it is

    Phi(x,x) = sum_{ij} G_ij <y_i, y_j>_{V(lambda)},    G Hermitian,

and `Phi >= 0  <=>  G >= 0`, because taking `y_i = xi_i v` for a fixed unit v lets xi range over C^m freely. An SOS certificate is exactly `F_5(W) = Phi(W^3, W^3)` with `Phi >= 0`. Since the file defines c by `W^3 = sum_{i,t} c^i_t phi_i(b_t)`, we get `y_i = sum_t c^i_t b_t` and `<y_i,y_j> = (c^i)^dagger Q c^j` with Q the **abstract** Gram. **No h factor.** Reading Q off copy 1 replaces Q by `h_11 Q`, one positive scalar per block, absorbed by `G -> G/h_11`; harmless, as the file says. The reverted h_ij insertion was indeed the over-correction.

**Pricing the alternative sharpens 192's warning.** The ambient pairing is `<phi_i(y), phi_j(y')> = h_ij <y,y'>`, so an ambient-Gram implementation solves for G' with the true certificate Gram equal to `G' ∘ h`.

- By the **Schur product theorem**, `G' >= 0` and `h >= 0` give `G' ∘ h >= 0`. Every ambient-feasible G' is a genuine certificate, the ambient route is **SOUND**.
- The converse fails: `G >= 0` does not give `G ⊘ h >= 0`. Explicit rational witness at multiplicity two, `h = [[1, 1/2], [1/2, 1]]`, `G = [[1, 9/10], [9/10, 1]]`, `G ⊘ h = [[1, 9/5], [9/5, 1]]` with eigenvalues -0.8 and 2.8. In general for m = 2, `G ⊘ h` is PSD iff `|g| <= t`. The ambient route is **INCOMPLETE**.

So the feasible set moves, and it moves **inward**: the h version can only produce false negatives, never a false positive. The dispute is live in the 12 blocks of multiplicity at least 2, carrying 77 of the 89 real unknowns; in the twelve multiplicity-1 blocks the readings agree up to a positive scalar.

---

## Claim 3, the repair is real

Recomputed independently over **Z** (the cache clears to a common denominator of 2), in [crossweight_exact.py](../scripts/reviewers/r194/crossweight_exact.py). Of 35 weight-basis tensors over 25 distinct weights (multiplicity profile: sixteen 1s, eight 2s, one 3):

- within-weight nonzero: **45**, matching the shipped count (35 diagonal + 10 off-diagonal);
- cross-weight pairs **actually computed**: **1168** = 1225 - 57, against the file's "~1180";
- cross-weight nonzero: **0**.

The `continue` no longer discards the falsifying pairs, so the repair is genuine.

**Can it fail?** As a test of the cache, yes; as mathematics, no. The Euclidean Hermitian form on `Weyl_5 (x) C` is SO(5,R)-invariant, so every X in the compact Cartan acts skew-Hermitianly with purely imaginary eigenvalues `i mu(X)`; for weight vectors, `0 = <X f_a, f_b> + <f_a, X f_b> = i (mu_a - mu_b)(X) <f_a, f_b>`, forcing orthogonality when `mu_a != mu_b`. So the check is falsifiable exactly against the hypothesis that [n5_hw_cache.json](../scripts/runs/n5_hw_cache.json)'s tensors are the weight vectors it labels them as, and against nothing downstream.

**Negative control.** Relabelling two mutually orthogonal indices changes nothing (the first control tried here did exactly that and stayed silent, which is worth recording). Relabelling index 7, one half of the nonzero pair (6,7), makes the check report 2 nonzero cross-weight entries. It fires.

---

## Runtime note

Stage 2's kappa loop is `|MONO|^2 = 7770^2 = 60.4` million `sym3_ip` calls per trial, three trials, in CPython with `Fraction`. A run launched at the start of this review reached the end of trial 0, reporting `|W|^2 = 2744` and kappa = 6, and 45 within-weight and 0 cross-weight Gram entries, all matching the independent recomputation above, after about ten minutes of CPU, with two trials left. Whatever is decided about the check's content, three trials of a tautology is the wrong place to spend that.

## Scripts

- [kappa_is_a_tautology.py](../scripts/reviewers/r194/kappa_is_a_tautology.py), the identity, the corruptions, the compensating pair, the scalar family, BOMBIERI passing the constancy test
- [kappa_on_the_real_H.py](../scripts/reviewers/r194/kappa_on_the_real_H.py), the same, on run_n5_evaluate.py's own H, sym3_ip, cube and coords
- [stage3_checks_blind.py](../scripts/reviewers/r194/stage3_checks_blind.py), Hermitian <=> Q Hermitian; the h-invariance of all three checks; the 89/14 bookkeeping
- [abstract_vs_ambient.py](../scripts/reviewers/r194/abstract_vs_ambient.py), Schur product theorem one way, the rational witness the other
- [crossweight_exact.py](../scripts/reviewers/r194/crossweight_exact.py), 0 of 1168 over Z, plus a negative control that fires
