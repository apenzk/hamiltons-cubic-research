# Review r249, the Weyl projector (claims 1, 2, 5)

Gate 2, reviewer 249. Brief `brief30.md`. Commits under review: 6338def (primary), 6536b2f, 2cdff7b. Primary file: [scripts/runs/run_weyl_projector.py](../scripts/runs/run_weyl_projector.py). Claims 3 and 4 belong to reviewer 250.

## Verdicts

| Claim | Verdict | One line |
| --- | --- | --- |
| 1(a) wm.BASIS is a basis of Weyl_5 | **UPHELD** | independent 625-unknown system gives solution dim 35 and every basis tensor satisfies it exactly |
| 1(b) float Gram-Schmidt can drift off Weyl_n | **UPHELD, with a caveat** | roundoff drift and loss of orthogonality scale together, so idempotence bounds the drift to ~1e-10; the docstring's "exact over Q" is false of the code |
| 1(c) the construction generalises to n = 12 | **REFUTED as written, repaired here** | wm is hardcoded to N = 5; a closed-form P exists at every n and I build an orthonormal basis of Weyl_12 with it |
| 2 the trace catches a wrong projector | **REFUTED** | three wrong 35-dimensional projectors pass all four checks; trace(P) is identically the number of unit basis vectors |
| 5 the 8-index P at n = 12 is the next step | **REFUTED as a plan** | 3.2 GB array, ~12 min just to build, ~6 min per idempotence check, six copies per closed graph; the matrix-free form runs one application in 0.4 ms |

## Claim 2, REFUTED. The four checks are identities of the construction

Script: [scripts/reviewers/r249/c2_wrong_projector.py](../scripts/reviewers/r249/c2_wrong_projector.py). Three wrong subspaces, each 35-dimensional, each passing every assertion the file makes:

| Witness | idempotent | symmetric | trace | fixes "a Weyl tensor" | file's checks |
| --- | --- | --- | --- | --- | --- |
| true Weyl_5 | 1.7e-16 | 0 | 35.000000 | 3.3e-16 | PASS |
| A: 35 coordinate tensors e_abcd | 0 | 0 | 35.000000 | 0 | PASS |
| B: a random 35-dim subspace | 1.5e-16 | 0 | 35.000000 | 4.4e-16 | PASS |
| C: 30 Weyl + 5 Ricci directions | 5.6e-17 | 0 | 35.000000 | 2.2e-16 | PASS |

Witness C is the sharp one. It lives inside the 50-dimensional space of algebraic curvature tensors, so every tensor in its range has both antisymmetries, pair symmetry and first Bianchi, it fails only Ricci-tracelessness, which the file never tests. `|P_C - P_Weyl|_max = 0.125`.

Two structural reasons, and they are the actual finding:

- **trace(P) counts basis vectors, not dimensions of a range.** For `P = sum_k b_k (x) b_k` with unit `b_k`, `trace(P) = sum_k <b_k,b_k> = k`. So the trace assert is arithmetically the same statement as `assert len(ON) == 35` two lines above it, and holds for any 35 unit tensors whatsoever. Confirmed exactly over Q in [c1d_exact_over_Q.py](../scripts/reviewers/r249/c1d_exact_over_Q.py) and visible in the scan of [c1b_gs_drift.py](../scripts/reviewers/r249/c1b_gs_drift.py), where trace stays at exactly 35.000000 in rows whose idempotence error is 1.3e-7.
- **The fourth check is circular.** The file builds its test tensor as `w = sum rng.standard_normal() * b for b in ON`, from the very list that defines `P`. Every orthogonal projector fixes every vector of its own range, so `|Pw - w| = 0` is an identity. [c2b_independent_weyl.py](../scripts/reviewers/r249/c2b_independent_weyl.py) builds a Weyl tensor without the module (Kulkarni–Nomizu `h ⧄ h` with its Ricci and scalar parts removed, certified by symmetries plus `Ric = 0`): the true P fixes it to 5.6e-16, witness C misses it by 0.39. That is the check that separates them, and the file does not make it.

So the file's sentence "Only the trace distinguishes the intended range" is wrong in both halves: the trace does not see the range at all, and idempotence, symmetry and trace together are consistent with any 35-dimensional subspace of the 625. What actually certifies the range is that `wm.BASIS` spans Weyl_5, inherited from the module, never checked in this file. The stub `P = 0` is caught by the trace only because it is not built by the construction at all; the regression case proves less than it appears to.

**Repair.** Replace the trace assert with two checks on the range: (i) a Weyl tensor built independently of `wm` is fixed; (ii) `P X` satisfies antisymmetry, pair symmetry, Bianchi and `Ric = 0` for random `X`. Both are `O(n^4)` and both separate all three witnesses (diagnostics table in `c2_wrong_projector.py`).

## Claim 1, the projector at n = 5 is right; the reasoning for it is not

**(a) UPHELD.** [c1a_basis_is_weyl.py](../scripts/reviewers/r249/c1a_basis_is_weyl.py) rebuilds the Weyl conditions directly on the 625 coordinates of `(R^5)^4` (both antisymmetries, pair symmetry, first Bianchi, `Ric = 0`), gets rank 590, solution dimension 35, and finds `wm.BASIS` satisfies every row with residual exactly 0 and numerical rank 35. So `wm.BASIS` spans exactly Weyl_5.

**(b) UPHELD, and the docstring is wrong.** [c1b_gs_drift.py](../scripts/reviewers/r249/c1b_gs_drift.py) scans inputs of growing ill-conditioning inside Weyl_5. Off-subspace drift and idempotence error track each other within one order of magnitude across seventeen decades of condition number, so no regime drifts off Weyl_5 by more than ~2e-11 while passing `|P.P - P| < 1e-9`. The shipped input has Gram condition number 13.7 and drift 1.2e-15, the n = 5 run is numerically sound. My first attempt to break it, a rank-deficient badly scaled input, is caught by idempotence at 4.7e-2, so that attack fails and I record it as such.

The docstring nonetheless says "Orthonormalising it is exact over Q by Gram-Schmidt on the Frobenius product" while `orthonormalise` is float and its own comment says "float here, exactness is the next step". Orthonormalising cannot be exact over Q, the norms are square roots of rationals. **P itself can be:** run Gram-Schmidt without normalising and set `P = sum_k b_k (x) b_k / <b_k, b_k>`. [c1d_exact_over_Q.py](../scripts/reviewers/r249/c1d_exact_over_Q.py) does that at n = 5 and gets exact zero off-diagonal Gram entries and an exact `Fraction` trace of 35.

**(c) REFUTED as written, repaired.** `run_n5_weyl_module.py` fixes `N = 5` throughout, so "the module already builds one" has no content at n = 12, and pushing the module to n = 12 means an exact nullspace over Q of a ~570 x 2211 rational system.

None of that is needed, because P has a closed form and the file's premise that "no formula is needed" is a choice rather than a fact. As an operator on 4-tensors, `P = D o C o S`:

- `S` symmetrises into `Sym^2(Lambda^2)`: antisymmetrise in `ab` and in `cd`, then average with the pair swap;
- `C` removes the `Lambda^4` part: `R -> R - (R_abcd + R_acdb + R_adbc)/3`;
- `D` removes the traces: `R -> R - (Ric0 ⧄ g)/(n-2) - s (g ⧄ g)/(2n(n-1))`, with `Ric0 = Ric - (s/n) g`.

The coefficients in `D` are forced by `Ric(h ⧄ g) = (n-2) h + tr(h) g`, which gives `Ric(PT) = 0` identically; the three factors are self-adjoint and their ranges are the orthogonal O(n)-isotypic pieces, so this is the orthogonal projector. [c15_matrix_free.py](../scripts/reviewers/r249/c15_matrix_free.py) checks it agrees with the file's basis-built P at n = 5 to 5.6e-16 and has exact trace 35, then runs it at n = 12: one application 0.4 ms, idempotence 2.7e-16, self-adjointness 1.7e-13, all Weyl symmetries at 1e-16, and an **exact trace of 1638.000000 = dim Weyl_12**, computed in 6.7 s at `O(n^4)` memory.

[c1c_weyl12_basis.py](../scripts/reviewers/r249/c1c_weyl12_basis.py) then supplies what the module cannot: project 1698 random 4-tensors, take the SVD range, and get 1638 orthonormal Weyl_12 basis tensors in 6 s, `|Q^T Q - I| = 3.3e-14`, all Weyl conditions at 1e-14, reproducing the closed-form projector to 6e-14. Stored as a matrix that is 259 MB, against 3.2 GB for the 8-index P.

## Claim 5, the dense 8-index route at n = 12 is not tractable

Measured, not guessed: [c5_timing.py](../scripts/reviewers/r249/c5_timing.py) times the file's accumulation loop at n = 6, 7, 8 and gets a steady 14.5–15.9 GB/s.

| Quantity at n = 12 | Cost |
| --- | --- |
| the array `P`, `n^8` doubles | 429,981,696 entries = 3.20 GB |
| building it the file's way, 1638 outer products | ~12 min, 6.4 GB peak |
| the idempotence check `P.P` | a 20736 x 20736 matmul, 17.8 Tflop, ~9.6 GB resident, ~6 min |
| exact over Q as the docstring wants | 4.3e8 `Fraction` objects, >22 GB of pointers alone |
| the degree-6 gluing | six such vertices per closed graph, over 720 bijections, for 2 x 14 diagram pairings |

The first four rows are merely expensive. The last is the one that kills it: a single pairwise contraction of two dense P nodes is already the 17.8 Tflop matmul, and the gluing needs six per graph across 20160 graph evaluations. That is not a constant-factor problem.

**The formulation that works.** Never materialise P.

1. Use the closed-form action above wherever P is applied to a 4-tensor slot: `O(n^4)`, no storage, exact over Q if wanted, defined for every `n >= 4`.
2. Where the network genuinely needs a two-sided node, use the low-rank factorisation `P = B^T B` with `B` the 1638 x 20736 basis matrix from `c1c_weyl12_basis.py`. This replaces one 8-index node of bond dimension `n^4 = 20736` by two nodes of bond dimension 1638, a 12.7x reduction in the bond that dominates every contraction, at 259 MB instead of 3.2 GB, and it is the exact same operator.
3. Choose the contraction order over the 6-vertex diagram with an optimiser (`opt_einsum`) rather than the written index order; the cost is then set by the network's treewidth in the reduced bond, not by `n^8`.

The stub in [run_n5_diagram_gram.py:27](../scripts/runs/run_n5_diagram_gram.py#L27) is typed as an 8-index `int64` array of shape `(n,)*8`. At n = 12 that signature is itself the obstacle; it should be replaced by a callable that applies P to a slot.

## Summary for the record

The projector shipped at n = 5 is the right one, 1(a) confirms the basis, 1(b) confirms the arithmetic. What the file gets wrong is why it believes that. Its three properties are identities of the construction `P = sum b (x) b` rather than tests of it, the fourth is circular, and the claim that the trace is what catches a wrong range is refuted by a projector onto a subspace of algebraic curvature tensors that passes everything. And its stated next step (the same construction with an 8-index array at n = 12), is out of reach by roughly four orders of magnitude in the gluing, while a closed-form matrix-free P reaches n = 12 in under a second and certifies its own range with an exact trace of 1638.
