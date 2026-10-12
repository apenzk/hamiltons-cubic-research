# REVIEW r255 -- Gate 2, the component test (claims 1 and 2)

Commits under review: f8e22e1 (primary), adb2a3d, 7c21cd4. Primary file: [scripts/runs/run_component_independence.py](../scripts/runs/run_component_independence.py). Reviewer 255 holds claims 1 and 2; reviewer 256 holds 3, 4, 5. Scripts: [scripts/reviewers/r255/](../scripts/reviewers/r255/).

## Verdict table

| Claim | Subject | Verdict |
|---|---|---|
| 1 | The dissolving move: F_c(W) already lies in the target, so U is unconstrained and one basis element serves | **REFUTED, with a witness inside the file's own validation.** The file's own covariant `cov_ric_like` has trace `|W|^2 != 0`, so it does not lie in V_(2); `cov_trace_g` projects to the ZERO covariant there. The pair the file asserts is independent has rank **1 in every block** of the target and rank 2 only in the ambient 2-tensor space -- the r247/r251 error, committed by the same file whose other assert message warns against it. |
| 2 | Reading components can only lose information, so rank = N proves independence and rank < N proves nothing | **IMPLICATION CORRECT AND ORIENTED CORRECTLY, BUT VOID IN APPLICATION** -- it is a statement about the maps whose components are read, and the file reads raw diagram values. Raw independence is *necessary* for covariant independence, never sufficient. One wording error: "a deficient matrix means the components were unlucky, **not that a relation exists**" denies a live possibility; the correct statement is that the outcome is uninformative. |

## What this review asks for, in four lines

1. **Pair with `c_lambda e_I`, not `e_I`.** For a multi-index `I` with distinct entries (available whenever `n >= |lambda|`, so at `n = 12` for every block in the table), the Young symmetrizer `c_lambda e_I` is traceless and hence lies **in** `V_lambda`, so `<D_c(W), c_lambda e_I> = <P D_c(W), c_lambda e_I>` reads a genuine coordinate of the covariant: a signed sum of raw components over the row and column groups, **~5.2e5 terms for the widest label**, not one. This is r254's highest-weight repair written in coordinates.
2. **Replace the validation pair.** `((W.W)_ij, |W|^2 delta_ij)` is independent only in the ambient space; per block it is rank 1 and rank 1. A validation of a *covariant* test must use two covariants into the **same** V_lambda.
3. **Drop "nothing of size n^{|lambda|} is ever built" or drop the premise.** A cheap component read means the value is unprojected; a projected value means the symmetrizer sum above. Both cannot hold at once.
4. **Restore r253's hypothesis on the identity.** The chain `<F,U> = <PF,U> = <F,PU>` needs `P` self-adjoint for the second step and `F = PF` for the first; commit 7c21cd4 applied that correction and f8e22e1's docstring states the chain bare again.

## Claim 1 -- REFUTED

Script: [scripts/reviewers/r255/r255_target_witness.py](../scripts/reviewers/r255/r255_target_witness.py). Exact over `Fraction`, no thresholds, using the file's own `weyl_exact`, `cov_ric_like`, `cov_trace_g`, `component_rank` and `COMPS`.

### 1a. The identity is true and does no work

`<F, U> = <PF, U> = <F, PU>` holds when `F = PF` and `P` is self-adjoint. But if `F` is already in the target, the identity is not needed at all: `<F, e_I>` is simply the `I`-th coordinate of `F`, and the whole content of the "one line" is the tautology *a value already in the target needs no test tensor in the target*. The load-bearing step is the premise, not the algebra.

Two hypotheses go unstated. `F = PF` is the premise under attack. `P` self-adjoint is r253's finding -- an equivariant idempotent with the right image but a relative 3.0 failure of self-adjointness exists, because the (2,2) block has multiplicity 2 -- and the record accepted it in 7c21cd4. The new docstring writes the chain with neither hypothesis attached.

### 1b. The premise is FALSE for the covariants the file actually evaluates

The record's target is one `O(n)`-block `V_lambda` per block of `Sym^3(W_12)`, inequivalent irreps pairing to zero ([REVIEW_r254.md](REVIEW_r254.md), 3a). Both carriers here are symmetric in their two free legs, so the only blocks available are the trivial one and `lambda = (2)`. Measured at the three dimensions the file runs:

| n | `tr (W.W)` | `|W|^2` | `(W.W)` traceless? | `P(|W|^2 delta)` |
|---|---|---|---|---|
| 5 | 502/3 | 502/3 | **no** | **0** |
| 6 | 187843/480 | 187843/480 | **no** | **0** |
| 7 | 3648/5 | 3648/5 | **no** | **0** |

`tr (W.W)_ij = W_{iabc}W_{iabc} = |W|^2`, which is nonzero on a nonzero Weyl tensor. So `cov_ric_like(W)` is **not** an element of `V_(2)`: it is a raw contraction carrying a trivial-block part and a `(2)` part. And `cov_trace_g(W) = |W|^2 delta_ij` is annihilated by the projector onto `V_(2)`: as a covariant into that target it is the **zero map**.

The file's central premise therefore fails on the two carriers the file itself validates on.

### 1c. The consequence is a false certificate -- the failure direction that sank r254

| test | n=5 | n=6 | n=7 |
|---|---|---|---|
| file's rank on `((W.W), |W|^2 g)` -- **asserted 2** | 2 | 2 | 2 |
| rank inside the target `V_(2)` (project, then read) | **1** | **1** | **1** |
| rank in the trivial block (the trace) | **1** | **1** | **1** |

The pair is dependent in *every* block of the target and independent only in the ambient 2-tensor space, where the two live in different isotypic pieces. The file's `assert r_ind == 2` therefore certifies "genuinely independent covariants" for a pair that has covariant-rank 1 wherever the programme's question is asked.

This is the ambient/target confusion that sank r247 and r251, and the file names it in its **other** assert message: *"a test reporting 2 is reading the AMBIENT space -- the error that sank three earlier attempts."* The file catches the error with one assert and commits it with the other.

### 1d. "U unconstrained" does not survive the covariants being defined up to the projector

If the objects at issue are the covariants into `V_lambda`, two raw diagrams differing by an element of `ker P` are the **same covariant**. Witness, with `F(W) = (W.W)_ij` and `F'(W) = (W.W)_ij + 17|W|^2 delta_ij`:

| n | `P F = P F'` (exact, all entries) | file's component rank on `(F, F')` |
|---|---|---|
| 5 | **True** | **2** |
| 6 | **True** | **2** |
| 7 | **True** | **2** |

One covariant, presented twice, is certified as two independent ones. `<F_c(W), e_I>` is a function of the *representative*, not of the covariant, so the freedom the file gains by making `U` unconstrained is exactly the freedom it loses in the object being measured.

### 1e. The 461 GiB obstacle does not dissolve; it is conserved

r254 priced a dense `U in V_lambda` at 461 GiB for `|lambda| = 10`. The file's escape is `U = e_I`, one basis element. But the pairing the covariant question needs is `<P D_c(W), e_I> = <D_c(W), P e_I>`, and `P e_I` is the operative test tensor whichever way the projector is moved. The projector must be applied to one side or the other; the file's move is to apply it to neither, which changes the object rather than the cost.

**The good news, which the file does not claim.** `P e_I` is not 461 GiB. Choose `I` with distinct entries -- possible for every block in the record's table, since `|lambda| <= 12 = n`. Every permuted basis tensor in `c_lambda e_I` then has distinct indices, so all its traces vanish and `c_lambda e_I` is already traceless; hence `c_lambda e_I` lies in `V_lambda` and is an admissible test vector, a signed sum over the row and column groups of `lambda`. For the widest label `(2,2,2,2,2,2)` that is `prod(row!)*prod(col!) = 2!^6 * 6!^2 = 3.3e7` terms, and r254's `6!^2 = 518,400` is the column-group half of the same count. So the test is:

    <F_c(W), c_lambda e_I>  =  sum over sigma of  coeff(sigma) * D_c(W)_{sigma(I)},

a signed sum of raw components -- **feasible, exact, and sound**, but not "a single contraction". The obstacle is removed by r254's own repair, not by the file's dissolution, and the file's version of it measures the ambient family instead.

## Claim 2 -- implication correct and correctly oriented; void where it is applied

Script: [scripts/reviewers/r255/r255_onesided.py](../scripts/reviewers/r255/r255_onesided.py).

### 2a. The implication, re-derived

Let `F_1..F_N : X -> T` be the maps whose components are read, `W_1..W_s` the samples, `S` the component set, and `M` the matrix with rows `(s, I)` and entries `<F_c(W_s), e_I>`. If `sum_c a_c F_c = 0` identically then for every row `sum_c a_c M[(s,I),c] = 0`, so `a in ker M` and `rank M <= N-1`. Contrapositive: **`rank M = N` implies no constant-coefficient relation**, from a single draw, for any component set. Correct as stated, and the notion of independence matches what the programme needs ([REVIEW_r245.md](REVIEW_r245.md): "linearly independent as functions", constant coefficients).

Checked against a planted relation `F_3 = 2F_1 - 5F_2` over 24 random combinations of component set, sample count and seed: **rank 3 never occurs**; the maximum over the full 3x3 component set and three seeds is 2. The implication has no leak.

### 2b. The converse fails, and the file says so correctly

An ambient-independent pair read on a single component:

| n | `COMPS = [(0,0),(0,1),(1,2)]` | `[(0,1)]` | `[(0,0)]` |
|---|---|---|---|
| 5 | 2 | **1** | 2 |
| 6 | 2 | **1** | 2 |
| 7 | 2 | **1** | 2 |

`cov_trace_g` is identically zero off the diagonal, so the `(0,1)` column dies and an independent pair reads rank 1. A deficient matrix establishes exactly this and nothing more: **there exists `a != 0` such that `sum a_c F_c` vanishes at the sampled points on the sampled components.** It does not establish a relation among the maps, nor even a relation at those sample points across all components.

**One wording error, in the file's favoured direction.** The docstring says a deficient matrix "means the chosen components were unlucky, **not that a relation exists**". A relation is exactly one of the things a deficient matrix is consistent with -- it is the case in which the matrix is deficient for *every* component set. The correct statement is that the outcome is uninformative, not that the deficiency has a benign cause.

### 2c. Why the correct implication does not deliver what the file spends it on

"Reading components can only lose information" is true. So is "projecting onto `V_lambda` can only lose information", and the two losses run the wrong way for the file. Since `P` is linear:

    {P F_c} independent  ==>  {F_c} independent,

and never the converse. The file's certificate establishes independence of the **raw** family, which is a *necessary* condition for what the programme needs and not a sufficient one. Claim 1's witness is claim 2's counterexample: `((W.W), (W.W) + 17|W|^2 g)` gives `rank = N = 2` at every n tested while the projected family has rank 1. So the certifiable direction, correctly derived, certifies the wrong family -- which is the fifth appearance in this item of a test that passes for a reason the question does not care about.

The implication becomes the two-sided test the programme wants as soon as the component read is a coordinate **inside** `V_lambda`: for a covariant `F` into `V_lambda`, vanishing of the highest-weight coordinate on all `W` forces `F = 0` by equivariance and polarisation, so rank of the highest-weight-component matrix `= N` **iff** independent. That is the repair of 1a-1e stated on claim 2's side.

## Reproduction

    python3 scripts/reviewers/r255/r255_target_witness.py     # claim 1, ~10 s
    python3 scripts/reviewers/r255/r255_onesided.py           # claim 2, ~20 s

Both import the file under review unchanged and are exact over `Fraction` end to end.
