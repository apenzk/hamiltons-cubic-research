# Gate 2 review r214 -- n=5 certificate, claims 4, 5, 6

Reviewer 214. Assigned claims 4, 5, 6 (r213 concurrently on 1-3).

## Verdict table

| Claim | Statement | Verdict |
|---|---|---|
| 4 | 40 equations give an identity (ker/rank argument) | **CONCLUSION HOLDS** (and corroborated at 12 fresh points); the stated justification is defective in two places |
| 5 | PSD in these coordinates = SOS of cubics in K | **DERIVATION CORRECT**; one convention defect, on the safe side |
| 6 | n=12 weight system: dim 1638, mults 1,1,2,4,9,30, hw (2,2,0,0,0,0) for O(12) | **CONFIRMED** (three routes) |

Work in progress.

## Claim 4 -- the 40 equations do give an identity, but not for the reason the file gives

### What I recomputed, with my own code

| Fact | Route | Value |
|---|---|---|
| `rank(A)` mod each of the four primes | my own Gaussian elimination over F_p, self-tested on planted ranks 0,1,5,13,14,20 | 13, 13, 13, 13 |
| `rank([A \| F_5])` mod the four primes | same | 13, 13, 13, 13 |
| `rank_Q(A)` | my own CRT + rational reconstruction, then exact rref over Q | 13 |
| `rank_Q([A \| F_5])` | same | 13, no pivot in the rhs column |
| `dim ker_Q(A)` | 47 - 13 | 34 |
| `dim (Sym^6 Weyl_5)^{O(5)}` | Sage, route A: Sym^6 character of the B2 irrep (2,2) by Newton's recursion, then Kostant's alternating sum over W(B2) | 14 |
| `dim (Sym^6 Weyl_5)^{O(5)}` | Sage, route B: `WeylCharacterRing("B2").symmetric_power(6)` plethysm | 14 |
| certificate point against all 40 equations | exact over Q | 0 failures of 40 |
| shape and blocks metadata, certificate vs row dumps | direct compare | identical |

A is 40 x 47; the certificate carries 47 coordinates; `shape` and `blocks` agree between the two files. So the domain of the sampled matrix and the domain of the Gram parametrisation are the same 47-dimensional space, and the brief's worst case -- `rank(ev.mu)` measured on one map while `rank(mu) = 13` describes another -- **does not occur**. Script: [claim4_exact.py](scripts/reviewers/r214/claim4_exact.py), [rank_modp.py](scripts/reviewers/r214/rank_modp.py), [claim4_inv14.sage](scripts/reviewers/r214/claim4_inv14.sage).

### Defect 1: `rank(mu) = 13` is NOT measured, and the argument collapses if it were

[run_n5_verify.py](scripts/runs/run_n5_verify.py) prints

```
    ker(ev . mu) contains ker(mu)   always,
    rank(ev . mu) = 13 = rank(mu)   measured, at four primes,
```

What is measured at four primes is `rank(A) = rank(ev . mu) = 13`. Nothing measures `rank(mu)`. Taken literally the second line is circular: `rank(ev . mu) = 13` cannot on its own establish `rank(mu) = 13`, because `rank(mu) >= rank(ev . mu)` is the only inequality sampling supplies, and it runs the wrong way. If `rank(mu)` were 14, `dim ker(mu)` would be 33 < 34 and the kernels would differ -- which is exactly the failure mode the brief names, the Gram's sextic agreeing with F_5 at 40 points and nowhere else.

What actually carries the load is a **theorem**, stated in [run_n5_order2.py](scripts/runs/run_n5_order2.py) and in [run_n5_assemble.py](scripts/runs/run_n5_assemble.py) but never joined to the kernel argument in the file that draws the conclusion:

1. every cubic in K vanishes at W_0, so every sextic in `im(mu)` vanishes at W_0;
2. `im(mu)` lies in the O(5)-invariant sextics, of dimension 14 -- which I confirmed above by two independent Sage computations. (O(5)-invariants equal SO(5)-invariants here: 5 is odd so O(5) = SO(5) x {+-I}, and `-I` acts as `+1` on a 4-tensor.)
3. evaluation at W_0 is a nonzero functional on those 14 (the invariant `|W|^6` is 1 there), so `im(mu)` lies in a 13-dimensional subspace W13;
4. hence `rank(mu) <= 13` unconditionally.

Combine with the measurement: `13 = rank(A) <= rank(mu) <= 13`, so `rank(mu) = 13`, `dim ker(mu) = 34 = dim ker(A)`, and with `ker(mu) contained in ker(A)` the two coincide. **The chain closes.** But it closes on an upper bound proved elsewhere, not on a measurement, and the file that states the argument cites the measurement instead. That is a presentation defect with real teeth: a reader checking only run_n5_verify.py is checking a non-argument.

### Defect 2: "F_5 lies in the image (rank 13 with and without it appended)" is an invalid inference

The file's justification for `F_5` being in `im(mu)` is the consistency of the sampled system. That does not follow. `rank([A|F_5]) = rank(A)` says `ev(F_5)` lies in the column space, i.e. there is `s` in `im(mu)` with `ev(s) = ev(F_5)`. Concluding `s = F_5` needs `ev` injective on `im(mu) + span(F_5)`; what was established is `ev` injective on `im(mu)` alone. If `F_5` were outside the image, `s - F_5` would be a nonzero sextic killed by `ev`, and nothing in the rank data excludes it.

The repair is a dimension count and is one line: `im(mu)` is contained in W13, `dim im(mu) = rank(mu) = 13 = dim W13`, therefore `im(mu) = W13`. `F_5` is an O(5)-invariant sextic vanishing at W_0, so `F_5` is in W13 = `im(mu)`. **The conclusion is true**, by an argument the record does not give.

A corollary worth recording: once `rank(A) = 13` is known, `rank([A|F_5]) = 13` is *forced* and carries no independent mathematical content -- `ev(W13)` is 13-dimensional and equals the column space, and `ev(F_5)` is in it automatically. The consistency test is a useful detector of a coding error in the rhs (a wrong normalisation of F_5 would show up), and [run_n5_assemble.py](scripts/runs/run_n5_assemble.py) is right to run it; it is not, as the prose has it, the step that puts F_5 in the image.

### What claim 4 still rests on, and which I did not verify

The kernel argument is sound given that A really is `ev . mu` in these coordinates. Two inputs sit outside what I checked:

- **the equivariant identification of copies** -- reviewer 209's counterexample (S_3 on R^3, sampled rank 10 against a cap of 7) shows the cap `rank(A) <= rank(mu)` fails if the multiplicity copies are not identified equivariantly. The guard is the multi-probe Schur test in stage 3 of run_n5_assemble.py. If that guard is wrong, `rank(A) = 13` no longer forces `rank(mu) = 13` and defect 1's repair fails with it.
- **that the lifted rows are the sextic's coordinates at all** -- claim 3, assigned to r213.

The first is the sharper risk, because attainment on the cap is invisible: a defect landing the rank exactly on 13 would pass every check in this pipeline.


## Claim 6 -- the n=12 weight system: CONFIRMED

Three independent routes, none sharing code with the repo.

**dim = 1638, three ways.**

| Route | Value |
|---|---|
| Sage `WeylCharacterRing("D6")`, hw `2*omega_2`, Weyl dimension formula | 1638 |
| Closed form `n(n+1)(n+2)(n-3)/12` at n=12 | 1638 |
| Sum of Freudenthal weight multiplicities over the whole weight system | 1638 |
| Littlewood: `s_{(2,2)} - h_2` expanded in `x_1..x_6, x_1^-1..x_6^-1`, coefficients summed | 1638 |

**Dominant multiplicities.** Both routes give the same six dominant weights with the same multiplicities:

| epsilon weight | mult (Freudenthal, Sage D6) | mult (Littlewood/symmetric functions) |
|---|---|---|
| (2,2,0,0,0,0) | 1 | 1 |
| (2,1,1,0,0,0) | 1 | 1 |
| (1,1,1,1,0,0) | 2 | 2 |
| (2,0,0,0,0,0) | 4 | 4 |
| (1,1,0,0,0,0) | 9 | 9 |
| (0,0,0,0,0,0) | 30 | 30 |

Multiset {1,1,2,4,9,30} as claimed. Scripts: [claim6_d6.sage](scripts/reviewers/r214/claim6_d6.sage), [claim6_littlewood.sage](scripts/reviewers/r214/claim6_littlewood.sage).

**Is (2,2,0,0,0,0) the right highest weight for O(12), not merely SO(12)?** Yes, and the second route proves it rather than assuming it, because it constructs the character from the *tensor* definition:

- Littlewood restriction of the GL(12) Schur functor gives `s_{(2,2)}|_{O(12)} = [2,2] + [2] + [0]`, dimensions 1638 + 77 + 1 = 1716 = `n^2(n^2-1)/12` at n=12. So the traceless (2,2)-Schur functor -- which is exactly the Weyl-tensor space -- is the O(12) irrep labelled by the partition (2,2).
- The O(12) label is (2,2) and not its associate `(2,2,1^8)`: the two differ by a `det` twist, and the module here sits inside `V^{tensor 4}`, on which `-I` acts as `+1` and `det` is not present. A tensor-constructed module carries the label whose partition it is built from.
- The restriction to SO(12) stays irreducible. The O(12) irrep `[lambda]` splits on SO(2m) only when `lambda` has exactly m = 6 rows; (2,2) has two. Empirically: the full 1638-dimensional space equals a single D6 irrep of dimension 1638, so there is nothing to split.
- Consequently `lambda_6 = 0` and the epsilon highest weight (2,2,0,0,0,0) = `2*omega_2` describes the O(12) module unambiguously.

**One caveat that the weight system does not settle.** O(12)-invariants are a *subspace* of SO(12)-invariants, strictly so whenever a self-associate constituent appears. Any count of invariants done with the D6 (SO(12)) weight system is therefore an upper bound for the O(12) count, which is safe for a cap argument (the shape of the n=5 rank argument) and unsafe as a lower bound. Nothing in claim 6 as stated is affected; the note matters when the n>=12 plan starts counting invariants.

## Claim 5 -- the congruence-by-h derivation, re-derived from scratch

### The derivation, done independently

Notation: per weight block `lambda`, the orbit-constrained cubics K have an adapted basis `R_{i,t}` with i the copy (multiplicity) index and t the position index inside `V_lambda`; `h_ij` is the multiplicity Gram, `Q_ts` the position Gram, and `<R_{i,t}, R_{j,s}> = h_ij Q_ts`.

**Step 1 -- what an SOS is, as a Gram condition.** `F_5 = sum_r |f_r|^2` with `f_r = sum c^{(r)}_{i,t} R_{i,t}` in K is equivalent to the existence of a Hermitian psd `M` with `F_5(W) = sum M_{(it),(js)} R_{it}(W) conj(R_{js}(W))`. Forward by expanding; backward by a spectral decomposition of M. Correct as stated in the file.

**Step 2 -- Schur forces M = B (x) Q^{-1}, and the inverse is right.** Under g the coefficient vectors transform as `c -> rho(g) c`, so `M -> rho(g) M rho(g)^*`. An invariant M therefore lives in `V (x) conj(V)`, not in its dual, and the invariant element of `V (x) conj(V)` is the INVERSE of the invariant form. Check: `rho^* Q rho = Q` gives `rho Q^{-1} rho^* = Q^{-1}`, while `rho Q rho^* = Q` is false in general. **The file is right and the three earlier attempts that used Q were wrong.** M may be taken invariant without loss because `F_5` is invariant and the group average of a psd Gram of `F_5` is again a psd Gram of `F_5`.

**Step 3 -- push y back to x.** With `y_{i,t}(W) = <R_{i,t}, W^3>` and `W^3 = sum x_{j,s} R_{j,s}`, sesquilinearity gives `y_i = sum_j h_ij Q conj(x_j)`. Substituting into `F_5 = sum M_{(it),(js)} y_{it} conj(y_{js})` with `M = B (x) Q^{-1}`, the position sums collapse:

- `sum_t (Q^{-1})_{ts} Q_{tu} = delta_{su}` (Q real symmetric), then `sum_s delta_{su} Q_{sv} = Q_{uv}`,

leaving `F_5 = sum_{k,l} C_{kl} A_{kl}` with `A_{kl} = conj(x_k)^T Q x_l` and

    C = h^T B conj(h) = P B P^*,   P = h^T.

That is a congruence, exactly as the file says. My index bookkeeping puts the congruence on `B` where the file writes `h^* B^T h`; the two differ by a transpose/conjugate, which is immaterial -- for Hermitian B, `B` psd iff `B^T` psd, and `h^* = h`, `h^T = conj(h)`.

**Step 4 -- the congruence is nonsingular, and this is where positive definiteness of h is genuinely needed.** For the UNRESTRICTED congruence, `det h != 0` would be enough -- congruence by any nonsingular matrix preserves psd in both directions, positivity is irrelevant -- and the pipeline checks `det h != 0` on all twelve blocks with m > 1 on every run. But the certificate lives on the RESTRICTED cubics, where the relevant matrix is the compression `T h T^*` to the surviving copies. A nonsingular indefinite matrix can have a singular compression; a positive definite one cannot. So reviewer 201's measurement that h is positive definite is load-bearing here and `det h != 0` alone would not carry the argument. The file's own justification ("h is a Gram ... hence nonsingular") names the weaker property and uses the stronger one. With h positive definite, `T h T^*` is positive definite for full-row-rank T, P is nonsingular, and

    the matrix tested in these coordinates is psd  <=>  B is psd  <=>  M is psd  <=>  F_5 is a sum of squares in K.

The last equivalence uses `Q^{-1}` positive definite, so `B (x) Q^{-1}` is psd iff B is.

**Step 5 -- and the squares are REAL cubics in K.** `|f|^2 = (Re f)^2 + (Im f)^2`. K is cut out of a real O(5)-submodule by the real condition `sigma_lambda(W_0) = 0` applied to the COPY index alone, so K is the complexification of a real space and `Re f`, `Im f` lie in it. The exhibited decomposition is therefore a sum of squares of real cubics vanishing on the orbit of W_0, which is what the claim asserts.

**Verdict: the derivation is correct.** The coordinates question, got wrong twice before, is got right here.

### The convention defect: the matrix verified is not the Hermitian form

[herm_row](scripts/runs/run_n5_assemble.py) packs a block's real coordinates as

    (H_00, ..., H_kk, Re H_ij, Im H_ij for i < j)

with **no factor of two on the off-diagonals**, and the certificate's 47 numbers are the coefficients `c` of the linear functional `sextic = sum_k c_k row_k`. For Hermitian C and H,

    tr(C H) = sum_i C_ii H_ii + 2 sum_{i<j} (Re C_ij Re H_ij + Im C_ij Im H_ij),

so the Hermitian form the certificate actually represents is

    C_ii = c_ii ,     C_ij = (c^re_ij + i c^im_ij) / 2 ,

while [blocks()](scripts/runs/run_n5_verify.py) builds `M_ij = c^re_ij + i c^im_ij` -- the same matrix with its off-diagonals **doubled**. M and C are different matrices, and doubling off-diagonals does not preserve psd in general (`[[1, 0.6],[0.6, 1]]` is psd, `[[1, 1.2],[1.2, 1]]` is not).

**It falls on the safe side, and provably so.** `C = (M + D)/2` where `D = diag(M)`. If M is psd then D is psd, so C is psd as a sum of two psd matrices. Hence **M positive definite implies C positive definite**, and run_n5_verify.py's test is *stronger* than the one the claim needs. Nothing is broken.

Two consequences worth recording anyway:

- The test is conservative. A future rounding that produced an M failing the test could still carry a perfectly good certificate, so "run_n5_verify.py rejected it" must not be read as "no SOS of this shape".
- Nothing in the record states which of M and C the 47 coordinates are, so this was luck rather than care -- the same class of bookkeeping slip as the block-order defect r211/r212 caught, which was not on the safe side.

I checked both matrices exactly over Q, by an LDL of my own written from the definition and self-tested on one indefinite and one positive-definite example ([claim5_gram.py](scripts/reviewers/r214/claim5_gram.py)):

| matrix | all blocks positive definite | least LDL pivot |
|---|---|---|
| M, as run_n5_verify.py reads the file | yes | 2.258040e-02 |
| C, the actual Hermitian form | yes | 2.337000e-02 |

Both are positive definite over Q, so the point certifies either way. That is also a third independent confirmation of claim 1 (r213's), by a route sharing no code with the characteristic-polynomial test.

### What claim 5 inherits and does not prove

`h` positive definite is quoted from reviewer 201, not re-verified here; if h were singular the congruence argument fails outright. And the identification `M = B (x) Q^{-1}` presumes the copies are identified equivariantly -- the same hypothesis claim 4's rank cap needs, guarded by the same multi-probe Schur test.

## The refutation attempt the brief asks for first: a W with F_5(W) < 0

**Not found, and the search says why not.** `F_5 = (3/2)|W|^6 - 9 tr(W^3)^2` is negative exactly when `|tr(W^3)| / |W|^3 > 1/sqrt(6) = 0.408248290464...`, so the whole question is the supremum of that ratio over Weyl tensors in dimension 5. I ran 4000 random starts of projected gradient ascent on the ratio over the 35-dimensional module ([hunt_negative.py](scripts/reviewers/r214/hunt_negative.py)):

| quantity | value |
|---|---|
| best `\|tr(W^3)\|/\|W\|^3` reached | 0.408248290464 |
| threshold `1/sqrt(6)` | 0.408248290464 |
| relative gap | 1.9e-15 |
| `F_5/\|W\|^6` at the best point | -6.2e-15 (machine epsilon against a scale of 1.5) |

The supremum is *attained* at exactly the claimed value, to twelve digits. That is the strongest corroboration available short of the proof itself: the inequality is tight, so no crude search will refute it and no slack is being hidden.

**And it exposes that the shipped falsification test is toothless.** [run_n5_falsify.py](scripts/runs/run_n5_falsify.py) draws 30000 Weyl tensors with small integer coordinates and reports a minimum `F_5/|W|^6` of 0.857 -- it never comes within 57% of the boundary. A test that cannot approach the surface it is meant to probe would pass a version of `F_5` with a substantially wrong constant. The 30000-point screen should be replaced by, or at least accompanied by, an optimisation; the file's own claim that it is "the falsification test the claim owes" overstates it.

## The decisive end-to-end test claim 4 never ran: fresh points

The failure mode the brief names is "the Gram's sextic agrees with F_5 at 40 points and nowhere else". That is directly testable and the pipeline never tested it, because the only points it ever evaluates are the 40 that built the system. I re-ran the whole pipeline from a copy ([assemble_r214_freshpoint.py](scripts/reviewers/r214/assemble_r214_freshpoint.py)) at prime 1099511627873, with an appendix that pairs the certificate's 47 rationals against restricted rows at points drawn from a seed the pipeline has never used.

| check | result |
|---|---|
| my run's 40 rows against the shipped [n5_rows_1099511627873.json](scripts/runs/n5_rows_1099511627873.json) | identical, entry for entry |
| my run's rhs against the shipped rhs | identical |
| certificate `shape` and BLOCK ORDER against this run's `herm_row` order | match |
| unrestricted sampled rank at the 40 points | 14 -- the theorem's cap, attained, so the points are unisolvent |
| restricted sampled rank | 13 -- the derived cap, attained |
| the 40 training points: certificate sextic vs F_5 | 0 disagreements |
| **12 FRESH points: certificate sextic vs F_5** | **12 of 12 agree** |

Twelve points that played no part in constructing the certificate, at a 40-bit prime. If the two sextics merely agreed on the 40 training points, the chance of surviving this is about `p^-12`, roughly `2^-480`. **No separation exists.** This does not replace the kernel argument -- it is a check, not a derivation -- but it removes the specific worry the brief raises, and it is the falsification this pipeline owed and did not have.

## The equivariance guard, observed live

Re-running the pipeline at prime 1099511627873 from a copy ([assemble_r214_freshpoint.py](scripts/reviewers/r214/assemble_r214_freshpoint.py)) reproduces the stage-3 guard that both claim 4's rank cap and claim 5's Schur step depend on:

- `h agrees across ALL probes: 0 disagreements, 0 skipped`
- `adapted vectors carrying more than one weight: 0`
- `blocks with m>1: 12; det h nonzero on those 12`
- `widest Q block across all lambda: 14 (attained, not a bound)`

So the guard runs and passes. It remains the single unproved hypothesis under both claims: reviewer 209's `S_3` on `R^3` counterexample shows that a non-equivariant identification of copies lifts the sampled rank above the cap, and a defect that landed the restricted rank exactly on 13 would be invisible to every test in this pipeline.

## Summary and what should change

**Nothing I found refutes the n=5 certificate.** Every claim I was assigned comes out true. Three of the arguments *given* for them do not survive contact:

| # | Defect | Consequence |
|---|---|---|
| 1 | [run_n5_verify.py](scripts/runs/run_n5_verify.py) says `rank(mu) = 13` is "measured, at four primes". Nothing measures it; what is measured is `rank(ev . mu)`, and the inequality from sampling runs the wrong way. | The argument as printed is circular. It is repaired by the `rank(mu) <= 13` cap from [run_n5_order2.py](scripts/runs/run_n5_order2.py), which the file does not cite. A reader checking only the file that states the conclusion is checking a non-argument. |
| 2 | The same file infers "F_5 lies in the image" from `rank(A) = rank([A \| F_5])`. That inference is invalid -- `ev` injective on `im(mu)` does not make it injective on `im(mu) + span(F_5)`. | Repaired by a dimension count: `im(mu)` is contained in the 13-dimensional W13 and has dimension 13, so it IS W13, which contains F_5. As a corollary the consistency test is mathematically forced and carries no independent content -- it is a code-level bug detector, which is worth keeping but should not be described as the step that puts F_5 in the image. |
| 3 | The 47 coordinates are the coefficients of a linear functional against `herm_row`'s packing, so the Hermitian form they represent has off-diagonals **half** of what [blocks()](scripts/runs/run_n5_verify.py) builds. | Falls on the safe side: `C = (M + diag M)/2`, so M positive definite implies C positive definite. Both are exactly positive definite here. But the record nowhere states which matrix the coordinates are, and this is the same class of bookkeeping slip as the block-order defect r211/r212 caught, which did NOT fall on the safe side. |

Two more, smaller:

- [run_n5_falsify.py](scripts/runs/run_n5_falsify.py) calls itself "the falsification test the claim owes" but its 30000-point random screen never comes within 57% of the boundary. A gradient search reaches the boundary to 15 digits. Replace or supplement it.
- The congruence argument in [run_n5_assemble.py](scripts/runs/run_n5_assemble.py) justifies nonsingularity of h by "h is a Gram", then uses positive definiteness, which is what the *restricted* compression actually needs. State the property being used.

**What still rests on an unproved hypothesis:** the equivariant identification of copies, guarded by the multi-probe Schur test. Both claim 4's rank cap and claim 5's `M = B (x) Q^{-1}` need it, and a defect landing the restricted rank exactly on 13 would pass every check in the pipeline. That, and claim 3 (r213's), are where I would look next.

## Scripts

| file | what it does |
|---|---|
| [rank_modp.py](scripts/reviewers/r214/rank_modp.py) | my own F_p elimination, self-tested on planted ranks; ranks of A and [A\|F_5] at all four primes |
| [claim4_exact.py](scripts/reviewers/r214/claim4_exact.py) | my own CRT + rational reconstruction, exact rank/kernel over Q, certificate against all 40 equations |
| [claim4_inv14.sage](scripts/reviewers/r214/claim4_inv14.sage) | dim (Sym^6 Weyl_5)^{O(5)} by Newton + Kostant |
| [claim4_inv14b.sage](scripts/reviewers/r214/claim4_inv14b.sage) | the same by Sage's plethysm |
| [claim5_gram.py](scripts/reviewers/r214/claim5_gram.py) | exact LDL over Q on both candidate Grams |
| [claim6_d6.sage](scripts/reviewers/r214/claim6_d6.sage) | D6 weight system by Weyl dimension formula and Freudenthal |
| [claim6_littlewood.sage](scripts/reviewers/r214/claim6_littlewood.sage) | the same by Littlewood restriction from GL(12) |
| [hunt_negative.py](scripts/reviewers/r214/hunt_negative.py) | 4000-start gradient ascent hunting for F_5 < 0 |
| [assemble_r214_freshpoint.py](scripts/reviewers/r214/assemble_r214_freshpoint.py) | a copy of the pipeline with the fresh-point identity test appended |
