# Gate 2 review r240 -- claims 3, 4, 5

Reviewer 240. Commits under review: ade3158, b5dedf3, 762593e. Primary file: [run_a1_canonical_lift.py](../scripts/runs/run_a1_canonical_lift.py). Assigned claims 3 (the SO(n) scope limit), 4 (the relocated free-index problem, priority), 5 (the kernel check). Reviewer 239 runs 1, 2, 6 concurrently.

## Verdict table

| # | Claim | Verdict |
|---|-------|---------|
| 3 | SO(n) scope limit, count drops 92 -> 89 from n=12 to 13 | **CONFIRMED, and the range is sharper than the record's.** The chiral bound is n <= 2k = 12, not n <= 4k = 24, so SO- and O-invariants COINCIDE at every n >= 13 and the whole scope problem sits at the base itself. Nothing current or planned fits in the SO space, and by O(n)-averaging nothing ever needs to |
| 4 | The degree-6 Brauer pairing's n-dependence is "a polynomial in n" -- of what degree? | **DERIVED AND CONFIRMED, and the truth is stronger than "a polynomial".** Each entry is the MONOMIAL `n^L` with `L` the number of cycles in the union of the two bare-metric matchings; `L <= min(a_P,a_Q) <= |lam|/2 <= 6`, sharp. Two caveats the record needs |
| 5 | The kernel-nesting check's tolerances (1e-9 rank, 1e-6 projector) are sound | **REFUTED IN BOTH DIRECTIONS.** Witnesses for a missed violation and for a false alarm, both from changes that cannot move a kernel |

**Bottom line.** Claim 3's scope limit is real and the record states it with the wrong range: the chiral bound is `n <= 2k = 12`, not `n <= 4k = 24`, so at degree 6 the SO- and O-invariants coincide at every `n >= 13` and the entire SO problem sits at the base dimension itself -- and nothing current or planned fits there, at zero cost, because averaging over O(n) preserves both PSD-ness and the constraint. Claim 4 comes back favourably and sharper than asked: the n-dependence of a degree-6 Brauer pairing is a *monomial* `n^L` with `L` a cycle count, bounded by `|lam|/2 <= 6` and sharp, so A2's premise holds with a precondition ("reduced diagrams") and a scope note ("the diagram Gram, not the fitted family") written in. Claim 5 is the one that fails: the kernel check added in 762593e is a genuine improvement on the rank asserts and is still unsound in both directions, and the fix -- exact arithmetic in two columns -- removes the question rather than tightening it.

## Claim 3 -- the SO(n) scope limit. Confirmed, with a sharper range, and it forbids one thing that nothing wants to do.

Script: [claim3_so_scope.py](../scripts/reviewers/r240/claim3_so_scope.py), output [out_claim3.txt](../scripts/reviewers/r240/out_claim3.txt). Exact integer arithmetic throughout -- integer Weyl tensors, integer contractions, integer epsilon sums, no tolerance anywhere.

### The count really does drop

Three steps, each checked rather than asserted.

**L1, parity.** Two epsilons contract to a determinant of deltas, so a det-twisted invariant carries exactly one. An epsilon index contracted with a bare metric is either killed by its own antisymmetry or re-routed onto a Weyl slot, so all n epsilon indices sit on Weyl slots; the remaining `24 - n` are matched in pairs, forcing n **even**. Independently, for odd n, `O(n) = SO(n) x {+-I}` and `-I` acts trivially on the four-index `W_n`, so the two invariant rings coincide outright. Either way `SO(13) = O(13) = 89`.

**L2, the sharp range -- and the record's is loose by a factor of two.** The file and [r237](REVIEW_r237.md) both derive "even `n <= 24`" from the slot count `24`. That over-counts. An epsilon meeting one Weyl factor in **three** slots antisymmetrises `W` over three of its indices, and `W_{[abc]d} = 0` for every algebraic curvature tensor -- the first Bianchi identity, verified here exactly at n = 5, 6, 7. So each of the six factors gives epsilon at most **two** slots:

> **a chiral degree-k invariant needs n even and `n <= 2k`.** At k = 6 that is `n in {2,4,6,8,10,12}`, not `n <= 24`.

This is [r182](REVIEW_r182.md)'s "chiral multiplicities first switch on at k = n/2" read in the other direction, and it is the load-bearing half of the claim: **at degree 6 the SO- and O-invariant spaces are equal at every n >= 13**, so the SO sequence on `[12, infinity)` is `92, 89, 89, 89, ...`. It drops once, at exactly the step out of the certificate base, and is constant thereafter.

**L3, the drop is real, from scratch.** At n = 12 the L2 bound is saturated: epsilon takes exactly one antisymmetric pair from each of the six factors and the six remaining pairs match among themselves. Taking that matching to be three "dumbbells" `M_{abcd} = W_{abef} W_{efcd}`,

```
S(W) = eps_{a1..a12} M_{a1a2a3a4} M_{a5a6a7a8} M_{a9a10a11a12}
```

evaluated exactly on a genuinely 12-dimensional integer Weyl tensor (34 650 signed set-partition terms) gives

```
S(W)  = -84473527735709457235968000000        S(RW) = +84473527735709457235968000000
```

for a reflection R, i.e. `S != 0` and `S(RW) = -S(W)`. So a degree-6 invariant exists that SO(12) preserves and O(12) does not: `dim(Sym^6 W_12)^{SO(12)} >= 90 > 89`. The record's multiplicity 3 (from [r180](REVIEW_r180.md), [r182](REVIEW_r182.md)) puts it at 92; **this run reproduces the sign of the gap independently**, which is all the monotonicity refutation needs.

**L4, the same mechanism where it can be checked end to end.** At degree 2 and n = 4 the chiral invariant is the classical Pontryagin density `eps_abcd W^{ab}_{ef} W^{efcd}`. On six exact Weyl tensors it is linearly independent of `|W|^2` (exact 2x2 minors, no tolerance), flips sign under a reflection while `|W|^2` does not, and at n = 5 the contraction needs 5 epsilon slots out of 8 leaving 3 to pair -- impossible. So `SO(4) = 2, O(4) = 1, SO(5) = O(5) = 1`: **the count drops 2 -> 1 from n = 4 to n = 5**, the degree-6 phenomenon in miniature and fully computable.

### What it forbids, concretely

| step | fits the Gram in the SO space? | does A1 apply? |
|---|---|---|
| the n = 5 pipeline ([run_n5_adapted.py](../scripts/runs/run_n5_adapted.py), [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py)) | **the question is empty at n = 5.** n odd, `-I` trivial on `W_5`, so SO(5)- and O(5)-invariants are the same space and the same isotypic decomposition | vacuously |
| A3, the exact SDP at the base ([run_n12_unknowns.py](../scripts/runs/run_n12_unknowns.py)) | **no.** The script fuses the 77 SO(12) constituents across the 6 chirality pairs into **71 O(12) blocks / 477 unknowns**, which is the shape [plan.md](../plan.md) section 2 item 3 names | yes |
| A4, verify `mu_n(B(n)) = G_{mu,n}` in the Brauer ring | **cannot.** The Brauer algebra is the O(n) diagram category; epsilon diagrams are not in it. A4 is an O(n) check by construction | yes |
| A5, Sturm on minor numerators | group-agnostic | n/a |
| the 485-parameter variant ([r167](REVIEW_r167.md), [r168](REVIEW_r168.md)) | **this is the only thing in the record that would**, and it is not on the plan | **no** |

So the scope limit forbids exactly one object -- the SO(12)-adapted 77-block / 485-parameter Gram -- and no current or planned step uses it. Two things worth putting in the record beyond that:

1. **Compliance is free, which the scope note does not say.** [r168](REVIEW_r168.md) already has the argument: `G` is O(n)-invariant, so averaging any feasible Gram over the compact O(n) preserves both PSD-ness (a convex combination of PSD matrices) and the affine constraint (`mu_n` is equivariant and `G` is fixed). **An O-invariant certificate exists whenever any certificate does.** The SO parametrisation is therefore a strictly larger and redundant relaxation, and the right action is to retire it from the record rather than to guard against it -- a guard against something nothing gains from is a standing invitation to try it.
2. **The port in [plan.md](../plan.md) section 2 item 3 needs one structural addition, not only "the data shapes".** The n = 5 pipeline builds its blocks from `so(5) = B_2` highest weights. At n = 12 the same route lands on `D_6` and returns the **77** SO constituents; the fusion of the 6 chirality pairs into 71 O-blocks has *no analogue at n = 5*, because at odd n there is nothing to fuse. "Only the data shapes change" is the one sentence under which the SO fit could enter by accident.

**One correction owed to the file.** "A degree-6 det-twisted invariant needs one epsilon over 24 slots, so it exists only at EVEN n" is right about the parity and wrong about the range: it implies chiral invariants at n = 14, ..., 24, and by L2 there are none. The sentence should read: chiral degree-6 invariants exist only for **even n <= 12**, so the SO and O counts agree at every n >= 13 and differ only at the base.

## Claim 4 -- the relocated free-index problem. The bound is `n^6`, and the entry is a monomial, not a general polynomial.

Script: [claim4_brauer_degree.py](../scripts/reviewers/r240/claim4_brauer_degree.py), output [out_claim4.txt](../scripts/reviewers/r240/out_claim4.txt).

### The derivation

Fix a block, and let a **reduced diagram covariant** of degree 3 with `f` free indices be

```
P_{a_1..a_f}  =  (3 Weyl factors, 12 slots)  x  (a bare metrics on free positions)
```

with the 12 W-slots partitioned into internal contraction pairs and free indices, the `a` bare metrics pairing up `2a` of the free positions, and *reduced* meaning no factor is a closed delta-loop on its own. Contract `P` with `Q` along all `f` free positions and build the **pairing graph**: nodes are the 24 W-slots together with the `f` free positions; edges are, for each covariant, its internal pairs, its free-index-to-W-slot assignments, and its bare metrics.

Every W-slot has degree exactly 1 -- it carries one edge, from its own covariant. Every free position has degree exactly 2 -- one edge from `P`, one from `Q`. **A graph all of whose degrees are 1 or 2 is a disjoint union of paths and cycles.** A path runs between two W-slots and is an ordinary contraction; a cycle can contain no W-slot at all, so it is built purely of bare metrics and closes to `delta^a_a = n`. Therefore

> **`<P, Q> = n^L * q_D(W)`**, with `L` the number of cycle components and `D` the closed degree-6 diagram whose matching is read off the path components.

Each cycle alternates `P`-metrics and `Q`-metrics, so it uses equally many of each and spans at least 2 free positions:

> **`0 <= L <= min(a_P, a_Q) <= floor(f/2)`.**

Three consequences, in order of what the record needs.

1. **It is not merely "a polynomial in n" -- between two basis diagram covariants it is a MONOMIAL**, `n^L` times a fixed complete-contraction invariant that carries no `n` at all. A general polynomial appears only after taking linear combinations of diagrams. This is strictly more information than [plan.md](../plan.md) A2 claims, and it is what makes A4's "identity in the Brauer ring with n formal" a check over `Z[n]` with degree known in advance.
2. **The exponent is computable by the loop count [plan.md](../plan.md) section 2 item 2 asks for, and here is the algorithm.** Take the union of the two covariants' bare-metric matchings as a multigraph on the `f` free positions; `L` is its number of cycle components; the path components give `D`. Nothing else in the pairing can produce a factor of `n`.
3. **The ceiling for this certificate is `n^6`.** A block of `Sym^3(W_12)` is labelled by a partition `lam`, and a diagram covariant there has `f = |lam|` free indices. Reading [r177](REVIEW_r177.md)'s `decomp_D6.json`: the sizes present are `|lam| = 0,2,4,6,8,10,12` with counts `1,1,5,10,17,24,19`, all even and none above 12 (`Sym^3(W_n)` sits inside the 12-fold tensor power). So the per-block ceiling is exactly `n^{|lam|/2}` and the ceiling over the whole pairing matrix is **`deg_n <= 6`, attained only in the 19 blocks with `|lam| = 12`.** r238's `n * I_3^2` is the `f = 2`, `L = 1` row -- already maximal for its own block, which is why it read as the whole phenomenon.

### The check

Twelve pairings, each contracted **twice by different means** -- float64 through numpy's own path optimiser at `n = 4..10`, and exact integers through an independent greedy pairwise path at `n = 4, 5, 6` -- and compared against `n^L * q_D(W)` computed from the graph alone. The Weyl tensor is an exact integer one on `R^4`, zero-padded (antisymmetry, pair symmetry, Bianchi and trace-freeness all verified). `deg` is by exact interpolation through the seven values.

| pairing | a_P, a_Q | L | ceiling f/2 | fitted degree | `= n^L q_D` at every n | exact anchor |
|---|---|---|---|---|---|---|
| `A` vs `A` (pure Weyl, f=2) | 0, 0 | 0 | 1 | 0 | yes | yes |
| `A` vs `g*I3` (f=2) | 0, 1 | 0 | 1 | 0 | yes | yes |
| `g*I3` vs `g*I3` (f=2) | 1, 1 | **1** | 1 | 1 | yes | yes |
| `gg*I3` vs `gg*I3` (f=4) | 2, 2 | **2** | 2 | 2 | yes | yes |
| `gg*I3` vs rotated (f=4) | 2, 2 | 1 | 2 | 1 | yes | yes |
| `A+g` vs `A+g` (f=4) | 1, 1 | 1 | 2 | 1 | yes | yes |
| `A+g` vs `g+A` (f=4) | 1, 1 | 0 | 2 | 0 | yes | yes |
| `A+g` vs `gg*I3` (f=4) | 1, 2 | 1 | 2 | 1 | yes | yes |
| `ggg*I3` vs `ggg*I3` (f=6) | 3, 3 | **3** | 3 | 3 | yes | yes |
| `ggg*I3` vs rotated (f=6) | 3, 3 | 1 | 3 | 1 | yes | yes |
| `g^4*I3` vs `g^4*I3` (f=8) | 4, 4 | **4** | 4 | 4 | yes | yes |
| `g^4*I3` vs rotated (f=8) | 4, 4 | 1 | 4 | 1 | yes | yes |

The fitted degree equals `L` in every row, the identity `<P,Q> = n^L q_D` holds at every dimension in both arithmetics, and the ceiling is attained at every `f` tested. The two "rotated" rows are the point of the cycle count rather than the metric count: the same `a_P = a_Q`, the same `f`, and the metrics matched in a shifted pattern, which fuses the cycles into one long one and drops the degree from `f/2` to 1. **A bound stated in terms of the number of bare metrics alone would be wrong on those rows; the number of *cycles* is the right invariant.** `L = f/2` is reached exactly when the two matchings coincide, checked symbolically up to `f = 12`.

### Two caveats the record needs

**(a) "Reduced" is a hypothesis, not a theorem.** The bound holds for covariants no factor of which is already a closed delta-loop. A spanning-set element `delta^a_a * (something)` carries a factor of `n` for free and there is no bound at all. Normalising the spanning set to reduced diagrams is exactly the loop counting section 2 item 2 budgets for, and it should be stated as a precondition of the `n^6` bound rather than assumed.

**(b) The bound is for the DIAGRAM Gram. The block Gram is rational, not polynomial.** The covariants that carry the SDP live in irreducible blocks and are therefore *traceless*; a bare metric on two free indices does not survive there. Passing from the diagram spanning set to a traceless block basis is trace removal, whose coefficients are rational in `n` (`1/n`, `1/(n-2)`, ...). So `deg_n <= 6` describes the object [plan.md](../plan.md) A2 names -- "every Gram entry of two diagram covariants" -- and the fitted `B(n)` in `Q(n)` is the object after that change of basis. The two statements are consistent, and the record should not let the polynomial one be read as covering the fitted family. This is also where A5's unstated side condition ([r238](REVIEW_r238.md)) becomes concrete and checkable: the denominators trace removal introduces have their roots among the small integers, well below 12.

**And a constructive note on r238's recommendation 4.** They ask that the spanning set be restricted to metric-free diagrams, calling the restriction unjustified. The derivation supplies the necessary condition: a metric-free (`a = 0`) diagram covariant in a block of label `lam` needs `w_free = |lam|` W-slots free and `12 - |lam|` remaining, which must be even -- and **every** `|lam|` occurring in `Sym^3(W_12)` is even and at most 12. So metric-free diagrams exist in every block, and by the theorem their Gram is `n`-independent. What is still owed is that they *span*; the arithmetic obstruction to r238's restriction is not there.

### Verdict

**The record's "valued a polynomial in n" is true and understated, and the bound the brief asks for is `deg_n <= |lam|/2 <= 6`, sharp.** The n-dependence is graded exactly by how the two covariants' bare metrics interlock, it is a monomial per basis pair, and it is computable by a cycle count with no evaluation. A2 rests on something that holds -- with the reduced-diagram precondition written down, and with the polynomial claim scoped to the diagram Gram rather than to the fitted `B(n)`.

## Claim 5 -- the kernel-nesting check. The tolerances misreport in both directions.

Script: [claim5_tolerances.py](../scripts/reviewers/r240/claim5_tolerances.py), output [out_claim5.txt](../scripts/reviewers/r240/out_claim5.txt). The two functions are copied, not imported, since the file under review runs its asserts at import.

**The lever.** Fact (ii) -- `ker eps_n` contained in `ker eps_{n_0}` -- is a statement about *subspaces of V*, the free span of the diagram symbols. Containment of subspaces is invariant under every invertible change of basis of V: rescaling a diagram symbol, or replacing one symbol by a combination of symbols, cannot change whether the kernels nest. The check is not invariant under those changes. That gap is the finding, and it is what makes both witnesses below basis relabellings rather than perturbations of the mathematics.

### (a) The screen contains exactly one non-vacuous comparison

| n | 4 | 5 | 6 | 7 | 8 | 10 | 12 |
|---|---|---|---|---|---|----|----|
| kernel dim reported | 1 | 1 | 0 | 0 | 0 | 0 | 0 |

`nested(K_big, K_small)` returns `True` on an empty `K_big` before it looks at `K_small`. Six comparisons are made and five have an empty `K_big`, so the only containment with content in the entire run is `ker eps_5` inside `ker eps_4` -- one line inside one line, in a 2-dimensional space. The file's closing sentence, "at and above it the kernel is pinned", is carried by nothing: at every n >= 6 the check returns `True` without measuring anything. This is not itself a tolerance fault, but it sets the size of what the tolerances are being asked to decide.

### (b) A real violation of fact (ii) that the check calls nesting

P4(eps) replaces the second diagram by `q2 + eps*n*q1`. Fact (ii) is **false for every eps != 0** -- the kernel line is `-(eps*n + 1/2) : 1`, which moves with n by construction. The committed regression case is eps = 1. Sweeping eps:

| eps | 1e-2 | 1e-4 | 1e-5 | **1e-6** | 1e-7 | 1e-8 |
|---|---|---|---|---|---|---|
| residual | 6.8e-3 | 7.2e-5 | 7.2e-6 | **7.2e-7** | 7.2e-8 | 7.2e-9 |
| verdict | fails | fails | fails | **NESTED** | NESTED | NESTED |

The residual is linear in eps, so the flip is exactly at the hard-coded `tol=1e-6`. **The check certifies nesting only to 1e-6 in angle.** Any violation of fact (ii) whose coefficient is smaller than that is reported as nesting, and the regression case survives only because r238 chose the coefficient to be 1 rather than 1e-7. Since fact (ii) is what makes the padding step exact, a check that cannot see a violation below 1e-6 is not verifying an exact statement -- it is bounding one.

### (c) A false alarm -- the fatal direction, because it is an `assert`

Basis change `T_b`: `q1' = q1`, `q2' = b*(q2 - 0.5*q1)`. Invertible for every b != 0, and `q2 - 0.5*q1` *is* the relation, so at n = 4 and n = 5 the second column is pure roundoff of relative size ~1e-15. Multiplying by b lifts that roundoff through the 1e-9 rank tolerance -- and at a rate that differs between n = 4 and n = 5, because the two roundoff floors are independent samples of the same noise. **Over 120 seeds the n=4 floor exceeds the n=5 floor in 44 of them (36%)**, and for any such seed there is a window of b where rank 2 is read at n = 4 (kernel empty) and rank 1 at n = 5 (kernel a line):

| seed | floor n=4 | floor n=5 | b | reported ker dims (4,5) | verdict |
|---|---|---|---|---|---|
| 0 | 2.37e-15 | 7.80e-16 | 4.4e5 | (0, 1) | **assertion fires** |
| 2 | 2.66e-15 | 1.98e-15 | 4.0e5 | (0, 1) | **assertion fires** |
| 5 | 3.07e-15 | 9.76e-16 | 3.4e5 | (0, 1) | **assertion fires** |

Five of the first six such seeds abort with *"ker eps_5 is NOT contained in ker eps_4. Fact (ii) is the padding step the whole reduction rests on"* -- on a relabelling of the diagram basis that moves no kernel anywhere. And `b ~ 4e5` is not an exotic number: it is smaller than the dynamic range a degree-6 Brauer Gram carries at n = 12 from the n-powers alone (claim 4 below bounds those at n^6, and 12^6 = 3.0e6), before any diagram coefficient is counted.

The screen also draws from an **unseeded module-level `rng`**, so at a b in that window the verdict is a coin toss between runs. A fatal assert whose outcome is not reproducible is worse than no assert.

### (d) The `max(sv[0], 1.0)` clamp puts an absolute floor inside a relative test

Scaling *both* diagram symbols by c -- the most innocuous basis change there is, a choice of normalisation -- makes `sv[0] < 1`, at which point `tol` becomes the absolute 1e-9 and the matrix reads as rank 0:

| c | 1 | 1e-9 | **1e-12** | 1e-16 |
|---|---|---|---|---|
| rank at n=6 | 2 | 2 | **0** | 0 |
| kernel dim | 0 | 0 | **2** | 2 |
| nesting reported | True | True | **True (vacuously, kernel = all of R^2)** | True |

At c <= 1e-12 every kernel is the whole space, every containment holds, and the check reports fact (ii) verified while measuring nothing. The clamp exists to stop division-by-zero on an all-zero matrix; `sv[0] > 0` with a `sv[0] == 0` early return does that without breaking scale invariance.

### (e) What is sound

The projector is exact. `K_small`'s rows come from an SVD, so they are orthonormal, `pinv(K^T) = K`, and `P = K^T K` satisfies `||P^2 - P|| = 0` and `||P - P^T|| = 8e-17`. The `pinv` default `rcond` never bites. So the 1e-6 is a pure angle tolerance and the failures are (b), (c), (d), not conditioning inside `pinv`.

### Verdict and the fix

**The check is a strict improvement on the rank asserts -- it catches r238's P4, which they could not -- and it is not sound as written.** It can miss a real violation of fact (ii) (any coefficient below 1e-6) and it can abort on a basis change that changes nothing (a b window that exists for 36% of seeds). Both faults have the same root: a statement about subspaces is being decided by absolute tolerances on unnormalised coordinates.

Two changes, both cheap, and one of them removes the tolerance question entirely:

1. **Column-normalise before the SVD**, and compare kernels of the normalised matrix. `M[:, d] /= ||M[:, d]||` makes the rank test invariant under the diagram rescalings of (d) and under the `T_b` family of (c), and replaces the `max(sv[0], 1.0)` clamp with a genuine relative test.
2. **Do the miniature in exact arithmetic.** r238 already computed this kernel over `Fraction` on integer Weyl tensors -- rank 1 at n = 4, 5 and rank 2 at n = 6, 7, with the line `-1/2 : 1` exact. In two columns and eight samples there is no reason to be in floating point at all: over Q the rank is exact, the kernel is exact, and containment is a rational linear-algebra fact with no tolerance anywhere. Then (b), (c) and (d) all cease to exist, and P4 still fails because its kernel line genuinely moves.

*Also worth fixing:* seed the `rng`, so that a fatal assert is reproducible.


## Recommendations to the record

1. **[run_a1_canonical_lift.py](../scripts/runs/run_a1_canonical_lift.py), the scope paragraph.** "one epsilon over 24 slots, so it exists only at EVEN n" should read "only at even `n <= 2 * degree = 12`": three or more epsilon slots on one Weyl factor antisymmetrise `W` over three indices and vanish by Bianchi. The corrected range is what turns a vague warning into a usable fact -- **the SO and O theories agree at every n >= 13**, so the SO exposure is one dimension wide.
2. **Retire the SO variant rather than guarding it.** [r168](REVIEW_r168.md)'s averaging argument makes the O-invariant space sufficient, not merely permitted. A guard against a variant nothing gains from invites someone to try it.
3. **[plan.md](../plan.md) section 2 item 3, the port.** "Only the data shapes change" is the sentence under which the SO fit could enter by accident: the n = 5 pipeline builds blocks from `so(5)` highest weights and has nothing to fuse, while at `D_6` the same route returns 77 constituents and the fusion into 71 O-blocks is a structural addition with no n = 5 analogue. [run_n12_unknowns.py](../scripts/runs/run_n12_unknowns.py) already does it; the plan should say so.
4. **[plan.md](../plan.md) A2, upgrade the claim.** "valued a polynomial in n" understates what holds: each entry between two reduced basis diagram covariants is the monomial `n^L`, `L` the number of cycle components in the union of the two bare-metric matchings, and `deg_n <= |lam|/2 <= 6`. Add the reduced-diagram precondition, and scope the polynomial claim to the diagram Gram -- the block Gram is rational, because trace removal is.
5. **The kernel check, two lines.** Column-normalise before the SVD (which restores invariance under the diagram rescalings that currently decide the verdict), drop the `max(sv[0], 1.0)` clamp in favour of an `sv[0] == 0` early return, and seed the `rng` so a fatal assert is reproducible. Better still, do the whole miniature over `Fraction`: two columns and eight samples need no floating point, and then the 1e-9 and 1e-6 both disappear along with the failure modes they create.
