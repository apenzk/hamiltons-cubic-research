# Review r231 -- Gate 2

Reviewer 231. Brief: brief21.md. Commits under review: 50954d8, 2d56917, c8d89b1.
Assigned claims: 3, 4 (priority), then 5. Reviewer 230 runs claims 1 and 2 concurrently.

| Claim | Subject | Verdict |
|---|---|---|
| 3 | B_n + block O(n_0) generates O(n); Givens invocation; n_0 >= 2 vs >= 3; plant n_0 = 1 | **UPHELD** -- lemma true, Givens correctly invoked, n_0 >= 2 is sharp; three weaknesses in the *screen*, none in the proof |
| 4 | Does the lemma halve the transfer question, or rename it | **REFUTED** -- the residual is logically *equivalent* to O(n)-invariance, so "half answered" overstates; what it buys is a smaller generating set, and even that is not the block |
| 5 | Table computed not quoted; convention guard runs; p_2 = 3/4 assert can fire | **PARTLY REFUTED** -- the guard runs and its asserts fire on planted violations, but the newly-added table is computed **wrong** (it drops the wrong eigenvalue), three docstring figures are still emitted by no code, and the file's own printed table violates its own coherence assert |

**Base moved during this review.** Reviewer 230 landed 5ba3fbd (sphere_product built the anti-maximiser; sign flipped) and 054e1e2 (the transfer question proved outright, superseding the c8d89b1 lemma). Claims 3 and 4 below were settled against c8d89b1 as briefed and are unaffected by either. Claim 5 was re-run from scratch on the post-5ba3fbd tree; the pre-flip figures are noted where they differ.

---

## Claim 3 -- the lemma is correct, and the hypothesis is sharp

Script: [c3_generation.py](scripts/reviewers/r231/c3_generation.py).

**The proof holds, step by step.**

| Step in [run_bn_generates_on.py](scripts/runs/run_bn_generates_on.py) | Verdict |
|---|---|
| B_n contains every coordinate permutation | correct -- B_n = S_n ltimes {+-1}^n |
| conjugating the block by a permutation moves it onto any n_0-subset | correct; conjugating by a *signed* permutation lands the same plane with angle +-theta, and theta ranges over all reals, so the sign is immaterial |
| n_0 >= 2 => the block contains every coordinate 2-plane rotation inside it | correct |
| those planes range over ALL coordinate 2-planes | correct, and needs only n >= n_0 >= 2 -- every pair {i,j} sits in some n_0-subset |
| Givens' theorem: coordinate-plane rotations generate SO(n) | correctly invoked -- the standard QR sweep reduces any Q in O(n) to diag(+-1) by n(n-1)/2 Givens rotations, so the generation is by *finite words*, needing no topological closure |
| a sign flip has det -1, so the group is O(n) | correct -- a subgroup containing SO(n) plus one det -1 element is O(n), index 2 |

**Not cited but exhibited.** Rather than take Givens on trust I factored random elements of O(n) into Givens rotations and rewrote every factor as `P B P^T` with `B` inside the first-n_0 block, then multiplied the word back: `|word - Q|_max ~ 5e-16` at (n,n_0) = (6,2), (8,3), (12,4), (5,5), for det +1 and det -1 alike. The lemma's conclusion is verified constructively, not just its combinatorial sub-step.

**n_0 >= 2 or n_0 >= 3?** n_0 >= 2 is right, and it is *sharp in both directions*. Sufficiency is (b) above at n_0 = 2. Necessity: O(1) = {+-1} already sits inside B_n, so `<B_n, O(1)> = B_n`, a finite group of order 2^n n!, never O(n) for n >= 2. The planted n_0 = 1 run reaches 0 of 1, 0 of 6, 0 of 15, 0 of 66 coordinate 2-planes at n = 2, 4, 6, 12 -- **the screen fires**, as it must.

**Three weaknesses, all in the screen, none in the proof.**

- The screen is **probabilistic where it could be exhaustive**. It samples 4000 random signed permutations; the reachable set is determined by the n_0-subsets of {1..n}, of which there are 495 at (12,4). Enumerating `itertools.combinations` settles it with no seed dependence. My (a) does that and confirms 15/15, 28/28, 66/66, 66/66.
- The **determinant assert is a tautology**. `np.linalg.det(np.diag([-1.0] + [1.0]*11))` is hardcoded to 12 coordinates whatever `n` is in the loop above it, and it tests a numpy determinant, not membership of that matrix in B_n. It cannot fail and screens nothing.
- The screen **does not touch the Givens step at all**, which is the step the brief flagged. Counting reachable planes verifies the hypothesis of Givens' theorem; it does not verify that the theorem is being applied to the right object. The constructive word in (b) is what closes that gap.

## Claim 4 -- the lemma does not halve the question; it renames it

Script: [c4_equivalence.py](scripts/reviewers/r231/c4_equivalence.py).

**The residual statement is equivalent to the original, not weaker.** Let E be the extension. By construction it is B_n-invariant, so `Inv(E)` is a subgroup of O(n) *containing B_n*. Then

- (=>) if E is block-O(n_0)-invariant, `Inv(E)` contains B_n and the block, hence contains the group they generate, which the lemma says is all of O(n);
- (<=) the block is a subgroup of O(n), so O(n)-invariance gives block-invariance for free.

So **"E is block-O(n_0)-invariant" <=> "E is O(n)-invariant"**, given exactly the hypothesis the route already has. An equivalence answers no part of a question. The lemma answers a *different*, group-theoretic question -- which generators suffice -- and the commit's "that question is now half answered" counts proving a reduction as answering half of what was reduced.

**Witness, computed rather than argued.** On homogeneous degree-d polynomials on R^n -- B_n acting by signed permutation, O(n) by rotation -- I computed all three dimensions exactly (sympy, rationals):

| n | d | dim B_n-inv | dim (B_n + block O(n_0)) | dim O(n)-inv |
|---|---|---|---|---|
| 5 | 4 | 2 | 1 | 1 |
| 6 | 6 | 3 | 1 | 1 |
| 6 | 8 | 5 | 1 | 1 |
| 7 | 6 | 3 | 1 | 1 |

for every n_0 in {2,3,4}, imposing all n_0(n_0-1)/2 block generators. The middle column **equals** the right column in all 18 cases: adding the block to B_n leaves no intermediate invariance class between B_n and O(n). The left column is strictly larger, so the transfer question is not vacuous -- `sum x_i^4` is B_n-invariant and not O(n)-invariant, and it is not block-invariant either, exactly as the equivalence requires.

**The block is not even the minimal residual.** An internal assert in the script checks that the single generator L_01 cuts the B_n-invariants exactly as far as all n_0(n_0-1)/2 block generators do. That is the lemma's own argument at n_0 = 2, and it strictly dominates the n_0-block version for n_0 >= 3: what is actually needed is invariance under **one** rotation of **one** coordinate 2-plane, a 1-parameter subgroup, whatever n_0 is. Choosing "the block O(n_0)" as the stopping point is arbitrary -- it is one rung of a chain of mutually equivalent restatements, and not the smallest rung.

**The commit message overstates relative to the file it commits.** The commit says the route reduces "to a statement at one dimension". It is not at one dimension: the block acts on all n coordinates, the statement is indexed by n exactly as O(n)-invariance is, and the block O(n_0) is itself a positive-dimensional continuous group -- it has to be, or generation fails. The file's own "WHAT IS STILL OWED" paragraph says precisely this ("the block acting on all n coordinates ... nothing here bridges them"), so the file is more honest than its commit message.

**What the lemma does buy, stated positively.** Per n, the invariance that must be established shrinks from a group of dimension n(n-1)/2 to one of dimension n_0(n_0-1)/2 -- or, by the sharper corollary, to a single one-parameter subgroup, independent of n. That is a real reduction in the size of the generating set to be checked. It is a reduction in *bookkeeping*, not in logical content, and the hard part -- bridging invariance of the restriction at level n_0 to invariance of the extension -- is untouched, being 100% of the original question.


## Claim 5 -- the guard fires, the table is computed, and the table is wrong

Scripts: [c5_plants.py](scripts/reviewers/r231/c5_plants.py), [c5_quoted.py](scripts/reviewers/r231/c5_quoted.py).

### 5a. The asserts can fire -- planted and confirmed

The two live guards in [run_second_kind_moment.py](scripts/runs/run_second_kind_moment.py) were re-executed verbatim on mutated input, outside the file under review.

| Plant | Result |
|---|---|
| baseline, unmutated | silent, as it must be |
| **A1**, W scaled by 1.05 (normalisation dropped) | p_2 = 0.826875, **fires** in both orders |
| **A1**, Bianchi broken at defect 4.1e-03 / 4.0e-05 / 5.3e-06 | **fires** in both orders |
| **A1**, Bianchi broken at defect 3.9e-07 and below | silent -- p_2 deviates *quadratically* in the defect, so the 1e-9 tolerance gives a sensitivity floor around 3e-6 |
| **A2**, p_3^min < 0 at m = (n/(n-1))theta_0(n) | silent at n = 12, 24, 100 |

So the p_2 = 3/4 assert is live, not decoration. Two qualifications.

- **It cannot detect the claim it is written to defend.** The docstring says p_2 = (3/4)|W|^2 is "BIANCHI'S IDENTITY ... for EVERY algebraic curvature tensor", but the assert only ever evaluates balanced sphere products, which are Ricci-flat. On a random algebraic curvature tensor satisfying Bianchi with Ricci norm 18.1, I get tr(ring^2) = **0.708745** in both index orders, not 0.75. The docstring statement is false and the guard is blind to it, independently corroborating reviewer 230.
- **A2 is mis-scoped, and the file's own table violates it.** A2 computes p_3^min from m = the projection cap, and passes. The file's *last* table computes p_3^min from the measured m and prints **+0.087887, +0.075064, +0.065568, +0.043676** at n = 12, 14, 16, 24 -- positive at every n, which is exactly the condition A2 declares makes "the route as framed make no sense". The assert is placed where it cannot see the numbers the file prints.

### 5b. The table is computed -- and the computation is wrong

Line 205 restricts to S^2_0 with

```
_om = np.sort(_om)[1:]                    # drop the g-direction zero: S^2_0
```

`np.sort(...)[1:]` drops the **most negative** eigenvalue. The g-direction eigenvalue is the **zero** one. These are different entries, and the comment names the one the code does not remove.

| n | dropped by `[1:]` | the actual zero | p_2 as filed | p_3 as filed | m as filed | p_2 true | p_3 true | m true |
|---|---|---|---|---|---|---|---|---|
| 12 | -0.674200 | -0.000000 | 0.295455 | +0.005874 | 0.056183 | 0.750000 | **-0.300581** | **0.674200** |
| 14 | -0.679366 | -0.000000 | 0.288462 | +0.004199 | 0.048526 | 0.750000 | -0.309354 | 0.679366 |
| 16 | -0.683130 | +0.000000 | 0.283333 | +0.003151 | 0.042696 | 0.750000 | -0.315643 | 0.683130 |
| 24 | -0.691564 | -0.000000 | 0.271739 | +0.001338 | 0.028815 | 0.750000 | -0.329410 | 0.691564 |

Three consequences.

- **p_2 of the spectrum the file's table is built on is not 3/4** -- 0.295455 at n = 12. That is the single invariant the file says no convention choice may move, and the p_2 assert never looks at the restricted spectrum, only at the unrestricted one.
- **p_3 comes out with the wrong sign and two orders of magnitude too small**: +0.005874 where the S^2_0 value is -0.300581.
- The error is *worse* after 5ba3fbd, not better. Before the sign flip the wrongly-dropped eigenvalue was one of 40 degenerate copies of -0.067420, so p_3 was off by only its cube, 3.1e-4. After the flip the wrongly-dropped eigenvalue is the **unique** extreme one, -0.674200, and the table collapses.

**A closed form, so this is checkable at any n.** For W = diag_weyl(Lam), `(Wring h)_ij = Lam_ij h_ij - delta_ij sum_k Lam_ik h_kk`, so the Sym^2 spectrum is {Lam_ij : i<j} together with spec(-Lam), and S^2_0 drops the zero that -Lam carries on the all-ones vector. For the balanced product with p = n/2 and alpha = p/(p-1), the unit-norm S^2_0 spectrum is alpha with multiplicity p(p-1)+2p-2, -1 with multiplicity p^2, and -2p once; N = 2p^2+p-1. This matches the dense operator to 1.4e-16 at n = 12, 16, 20 and reaches n = 400 in milliseconds.

### 5c. Three docstring figures are still emitted by no code

The defect 700c34c was faulted for is not fully cleared. Using the closed form:

| Docstring figure | Reproduces? | Emitted by any code in the repo? |
|---|---|---|
| p_3(omega) = -0.300581 at S^6 x S^6 | yes | yes, by the convention guard |
| "-min omega equals the projection cap with EXACT equality at every balanced sphere product" | **yes** -- 2m = cap to 0 or 2.2e-16 at n = 12, 16, 24, 60, 100, 400 | **no** -- the file never computes the cap alongside m, and its table's m = 0.056183 misses the cap by a factor of 24 |
| "p_3/p_3^min rises 0.6075 -> 0.6600 from n=12 to n=100" | **yes, to four decimals** -- 0.6075, 0.6168, 0.6235, 0.6384, 0.6600 at n = 12, 14, 16, 24, 100 | **no** -- the file's own ratio column prints 0.0668, 0.0559, 0.0481, 0.0306 and stops at n = 24 |
| "relaxed -3.9585 ... truth -2.4046" | yes, in the doubled normalisation where p_2 = 3 | **no** |
| "integrality restored -3.6108" | **not reproduced** -- the integer two-atom search over all k = 1..N-1 with mu <= cap gives k = 2, p_3 = -3.5295 | **no** |

The irony is sharp: **the docstring's figures are right and the code added to substantiate them is wrong.** A reader who trusts the newly-computed table gets numbers that contradict the prose above it by a factor of nine in the ratio column and by a sign in p_3, with nothing in the file flagging the disagreement.

### 5d. Smaller items

- `p3_min()` (line 118) is the only exact-arithmetic path in the file, using `Fraction`, and is **never called**; both tables recompute the same formula inline in floats.
- Lines 176-177 build and normalise `_W = _cat.sphere_product(3, 3)` and then overwrite it unused on the first loop iteration.
- The convention guard itself does run, executes both dependency modules, and calls `ring()` in both index orders. That part of 50954d8's claim holds.
