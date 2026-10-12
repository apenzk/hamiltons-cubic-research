# Gate 2 review r230 -- the convention conflict, settled; and the B_n lemma

Commits under review: 50954d8, 2d56917, c8d89b1. Reviewer 230, brief21. Scripts: [scripts/reviewers/r230/](../scripts/reviewers/r230/).

| # | Claim | Verdict |
|---|-------|---------|
| 1 | Sign convention of the second-kind operator; p_3(omega) at S^6 x S^6 | **SETTLED -- and the conflict was misdiagnosed by both sides.** `ring(.,'iklj')` correctly implements Li (2.2). But `sphere_product(p,q)` builds MINUS the Weyl tensor of S^p x S^q, so it is the anti-maximiser. At the real maximiser p_3(omega) = **-0.300581**. Reviewers 228/229's numbers are right; the reason they gave is wrong |
| 2 | Bi-spectral identity as independent arbiter | **CONFIRMS -0.300581, and it is decisive.** theta and p_3(nu) never touch the second-kind convention; at theta = +theta_0(12) they force p_3(omega) = -2.404646 (|M|_F=1) = -0.300581 (|W|_4=1). The flipped sign gives -1.168613, not theta_0 |
| 2b | Consequence: run_second_kind_moment.py's support cap | **DEFECT.** Its two tables use m in two different normalisations, neither of them the right one. m at the file's own p_2 = 3/4 scale is 0.674200; the first table uses 1.348400, the second 0.067420 |
| 3 | B_n lemma (c8d89b1) | **CORRECT.** Every step holds, n_0 >= 2 is the right threshold, and the screen fires when n_0 = 1 is planted. One step is redundant: O(n_0) already supplies determinant -1 |
| 4 | Is the lemma useful | **OVERSTATED, though not vacuous.** It is a generator reduction, hence *equivalent* to O(n)-invariance rather than weaker. "Halves the transfer question" is not a measurable claim, and "a statement at one dimension" is false -- the block O(n_0) acts on all n coordinates |
| 5 | Reproducibility fix (50954d8) | **PARTLY UPHELD.** The table is computed, the guard runs, both asserts fire when planted. But the guard is structurally blind to the error that occurred, and the p_2 = 3/4 claim is false as stated -- witness: the round S^6 |

---

## Claim 1. The index order is Li's; the tensor is not.

### What Li's definition says, and it is not ambiguous

[Li arXiv:2112.08465](https://arxiv.org/abs/2112.08465) eq. (2.2) is `Rring(e_i (.) e_j) = sum_{k,l} R_{iklj} e_k (.) e_l`, and Example 2.4 writes the quadratic form out: `Rring(phi,phi) = sum_{ijkl} R_{ijkl} phi_{il} phi_{jk}`. Relabelling `(i,j,k,l) -> (a,c,d,b)` turns that into `sum R_{acdb} phi_{ab} phi_{cd}`, which is exactly `phi -> einsum('iklj,kl->ij')` contracted against `phi`. Example 2.4 also fixes the curvature sign convention: on the unit sphere `R_{ijkl} = g_ik g_jl - g_il g_jk`, so `R_{ijij} = +1 =` sectional curvature.

I implemented that from the two formulas alone in [c1_li_external.py](../scripts/reviewers/r230/c1_li_external.py), importing nothing from this repository, and checked it against four *published* spectra, all of them sign-asymmetric, so a global flip is detectable:

| source | manifold | predicted | fresh implementation |
|---|---|---|---|
| Li Ex. 2.4 | S^n, n=4,5,6 | +1, multiplicity (n-1)(n+2)/2 | MATCH |
| Li Ex. 2.6 | S^{n-1} x R, n=4,5,6 | -(n-2)/n (x1), 0 (x n-1), +1 (x (n-2)(n+1)/2) | MATCH |
| Li Ex. 2.7 / CGT21 | S^2 x S^2 | -1 (x1), 0 (x4), +1 (x4) | MATCH |
| Li Ex. 2.5 / BK 1978 | CP^m, m=2,3,4 | -2 (x m^2-1), +4 (x m(m+1)) | MATCH |

Li's own normalisation footnote (`tr Rring = S/2`, `Rring(g,g) = -S`) also holds exactly on the fresh operator at n=4,5,6.

**Direct comparison against the repo's construction**: on S^6, S^2 x S^2 and CP^3, `einsum('iklj',...)` is *identical* to the fresh Li operator and `einsum('ikjl',...)` is its exact *negative*. So the record is right that `iklj` is Li's order, `run_bk_crosscheck.py`'s MATCH is genuine, and the factor-2 story is a normalisation, not an error: `|W|_4^2 = 4|M|_F^2`, so `p_2(omega) = 3/4` at `|W|_4 = 1` and `= 3` at `|M|_F = 1`.

### And none of that is where the conflict lives

[run_bispectral_catalogue.py:40](../scripts/runs/run_bispectral_catalogue.py#L40) builds `Lam` with intra-block `-q/(p-1)` and cross-block `+1`. The Weyl tensor of the genuine Riemannian product S^p(1) x S^q(1) has intra-block Weyl sectional curvature **positive** and cross-block **negative**: at p=q=3 the true sectional curvatures are 1 (intra), 0 (cross), scalar curvature 12, background 12/30 = 0.4, so the Weyl sectional curvatures are +0.6 and -0.4, proportional to `-(-1.5, +1)`.

[c1b_true_product.py](../scripts/reviewers/r230/c1b_true_product.py) builds the Weyl tensor from the real metric by Kulkarni-Nomizu subtraction and confirms `|W_true + W_cat| = 3e-17` at S^3xS^3, S^6xS^6 and S^4xS^8: **the catalogue's tensor is exactly the negative of the product's Weyl tensor.**

Everything cubic therefore flips. On `W_cat`, `theta = -1.236033`; the repo's own catalogue prints that number. `theta_0(12) = +1.236033`, so **`sphere_product(6,6)` is the anti-maximiser and `-sphere_product(6,6)` is the point the whole programme is about.**

### The numbers at the point that matters

All in Li's `iklj` order, at S^6 x S^6:

| quantity | W_true (real metric, theta = +theta_0) | W_cat (catalogue, theta = -theta_0) |
|---|---|---|
| omega spectrum, `\|M\|_F = 1` | -1.348400 (x1), -0.112367 (x36), +0.134840 (x40) | +1.348400 (x1), +0.112367 (x36), -0.134840 (x40) |
| p_3(omega), `\|M\|_F = 1` | **-2.404646** | +2.404646 |
| p_3(omega), `\|W\|_4 = 1` | **-0.300581** | +0.300581 |
| min omega, `\|W\|_4 = 1` | **-0.674200** | -0.067420 |
| theta | +1.236033 | -1.236033 |

The `W_true` spectrum reproduces [findings/bispectral.md](../findings/bispectral.md)'s closed form `{mA x (m-1)(m+2), -(m-1)A x m^2, -2m(m-1)A x 1}` with `A = 1/(m sqrt((m-1)(2m-1)))` **exactly, multiplicities included**. The record's own closed form is therefore correct and is stated at the true maximiser.

### Verdict on the three parties

- **`ring(.,'iklj')` and `run_bk_crosscheck.py` are correct** about the index order. The record's defence of them is sound as far as it goes.
- **Reviewers 228 and 229 reported the right numbers**, `p_3(omega) = -0.300581`, `min omega = -1.348400`, because those are the values at the actual maximiser. Their diagnosis, that the operator must be built from `W_ikjl`, is **wrong**: `ring(W_cat,'ikjl')` is numerically identical to `ring(W_true,'iklj')`, which is exactly why substituting the index order reproduced all eight of their figures to six digits. Two errors that cancel.
- Their `min = -1.348400` alongside `p_3 = -0.300581` mixes the two normalisations (`|M|_F = 1` for the first, `|W|_4 = 1` for the second). That mismatch is what made the record suspect a stray factor of 2 in *their* reading; the factor is real but it is inside their own pair of numbers, not between the conventions.
- **[run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py)'s refusal to assert a sign was the right call, and the paragraph it labels "the corrected figures" is the correct one.** The convention guard it now runs is sound but tests the wrong thing: it varies the index order while holding a tensor of the wrong sign fixed, and no index-order test can detect a sign that lives in the input.

**A guard that would have caught it in one line:** assert `theta(W) = +theta_0(n)` at the balanced sphere product before reading anything off it.

## Claim 2. The bi-spectral identity is a genuine arbiter, and it decides.

`theta = (3/2) p_3(nu) - (1/2) p_3(omega)` is an identity, so it closes on any tensor with that tensor's own p_3(omega); what it pins is the **relative** sign, and `theta` and `p_3(nu)` are computed entirely on the Lambda^2 side, never touching the second-kind convention. That makes it independent of everything claim 1 argues.

At the maximiser, `theta = +theta_0(12) = +1.236033` and `p_3(nu) = tr(M^3) = +0.022473`, so

- `(3/2)(0.022473) - (1/2)(-2.404646) = +1.236033 = theta_0(12)`
- `(3/2)(0.022473) - (1/2)(+2.404646) = -1.168613`, which is neither `+theta_0` nor `-theta_0`

so the identity admits **only** `p_3(omega) = -2.404646`. Checked in [c2_bispectral_arbiter.py](../scripts/reviewers/r230/c2_bispectral_arbiter.py) and [c1b_true_product.py](../scripts/reviewers/r230/c1b_true_product.py); the identity closes to 1e-15 at n = 6, 8, 10, 12, 14, 16, 24 with `|theta| = theta_0(n)` at each.

**It does not close with both signs**, so the brief's fallback case does not arise.

## Claim 2b. A defect this exposes in run_second_kind_moment.py

The closed form `p_3^min = 9/(16 m N) - 3m/4` is derived under `p_2 = 3/4`, i.e. the `|W|_4 = 1` normalisation, where `-min omega = 0.674200` at n=12. The file's two tables use neither value:

| table | m at n=12 | what that number is |
|---|---|---|
| first (`m_max`) | 1.348400 | `-min omega` at `\|M\|_F = 1`, the wrong normalisation for `p_2 = 3/4`, too large by exactly 2 |
| second (`m`) | 0.067420 | `-min omega` on the **anti-maximiser**, too small by exactly 10 |
| correct | 0.674200 | `-min omega` at the maximiser, `\|W\|_4 = 1` |

With `m = 0.674200`, `N = 77`: `p_3^min = -0.494813` and `p_3/p_3^min = 0.6075`, which is the ratio the file's own prose quotes for n=12. So the prose is right and both computed tables are wrong, the second by a factor of ten in `m` and a sign in `p_3`. The reported ratio of 5.2067 at n=12 is meaningless (it compares a positive `p_3` to a positive `p_3^min`).

The `assert lo < 0` guard still fires correctly for the right reason, but the framing sentence attached to it (that a positive `p_3^min` would mean omega "helps rather than constrains"), is about the maximiser's sign convention, where `p_3(omega) < 0` and `-(1/2) p_3(omega) > 0` is indeed the term that must be bounded below.

---

## Claim 3. The B_n lemma is correct.

*Lemma.* For `n_0 >= 2` and `n >= n_0`, `B_n` together with the block `O(n_0)` on the first `n_0` coordinates generates `O(n)`.

Step by step ([run_bn_generates_on.py](../scripts/runs/run_bn_generates_on.py)):

| step | status |
|---|---|
| `B_n` contains every coordinate permutation | holds; `S_n` sits in the signed permutation group |
| conjugating the block by a permutation moves it onto any `n_0`-subset | holds; `P O(S) P^{-1} = O(P(S))`, and conjugating by a diagonal sign matrix preserves each block |
| `n_0 >= 2` gives every coordinate 2-plane inside the block | holds; `SO(2)` on two coordinates of the subset, identity elsewhere, lies in the block |
| every coordinate pair lies in some `n_0`-subset (needs `n >= n_0`) | holds |
| Givens: coordinate-plane rotations generate `SO(n)` | correctly invoked -- Givens' theorem is exactly a statement about coordinate 2-planes, and the proof supplies all `n(n-1)/2` of them |
| a determinant -1 element extends `SO(n)` to `O(n)` | holds, `SO(n)` having index 2 |

**`n_0 >= 2` is the right threshold, not `n_0 >= 3`.** Verified directly rather than by the plane count: [c345_lemma_and_repro.py](../scripts/reviewers/r230/c345_lemma_and_repro.py) spans the conjugates `P so(n_0) P^T` and measures the rank. At `(n,n_0) = (6,2), (8,3), (12,2), (12,4)` the span is the full `so(n)` (15, 28, 66, 66) so the generated group is `SO(n)` already at the Lie-algebra level. At `n_0 = 1` the span is 0.

**Planting `n_0 = 1` fires the screen**, at `n = 6` and `n = 12`: 0 of 15 and 0 of 66 coordinate 2-planes reached.

**One redundancy.** "B_n supplies a single sign flip, of determinant -1" is unnecessary: the block `O(n_0)` with `n_0 >= 2` already contains reflections, and `diag(A, I_{n-n_0})` has determinant `det A = -1`. The lemma holds with `SB_n` (even signed permutations) or with `S_n` alone in place of `B_n`. Harmless, but the proof claims to need something it does not.

## Claim 4. The lemma is a generator reduction, and the commit oversells it.

**It is an equivalence, not a weakening.** Given `B_n`-invariance, the lemma says the group generated is `O(n)`, so "invariant under the block `O(n_0)`" and "invariant under `O(n)`" are the *same condition*. That is unavoidable for any generation statement and does not by itself make the lemma empty, reducing an invariance requirement to a generating set is a real, if elementary, reduction in what must be checked, and infinitesimally it replaces annihilation by `so(n)` with annihilation by one `so(n_0)` block.

**But two of the commit's phrases do not survive.**

- *"the route reduces ... to a statement at one dimension"* is **false**. The block `O(n_0)` acts on all `n` coordinates, fixing `n - n_0` of them pointwise; invariance of the extension under it is still one statement per `n`, about `u_n`, and `O(n_0)` is still a continuous group. What shrinks is the *dimension of the group* (`n_0(n_0-1)/2`, fixed), not the dimension at which the statement lives.
- *"halves the transfer question"* and *"half answered"* measure nothing. The half proved is the direction that generation statements always give; the residual is the entire mathematical content.

**The file's own caveat is the accurate statement** and it contradicts the headline: "the extension restricts at level `n_0` to `u_{n_0}`, which IS `O(n_0)`-invariant, but that is invariance of the RESTRICTION ... nothing here bridges them." That paragraph is right, and it says the lemma moves no difficulty. The commit message should read as that paragraph does.

## Claim 5. The table is computed and the asserts fire, but the guard cannot see the error it was built for.

**What holds.**

- The table is produced by code, not quoted. `run_second_kind_moment.py` computes both tables at run time.
- The convention guard runs: it loads `run_secondkind_sign.py` and `run_bispectral_catalogue.py` and measures both index orders at `n = 12, 16`.
- **Both asserts fire when planted.** Scaling the guard's eigenvalues by 1.05 gives `p_2 = 0.826875` and the assert fires with its message; forcing `lo = abs(lo)` fires the `p_3^min < 0` assert.

**What fails.**

1. **The guard is structurally incapable of catching the error that actually occurred.** `p_2` is quadratic in the operator, so it is invariant under *both* the index-order flip and the tensor sign flip, the guard's own output shows `p_2 = 0.7500` in both orders at both `n`. And varying the index order while holding a wrong-signed tensor fixed cannot detect a sign that lives in the input. A guard that would work: assert `theta(W) = +theta_0(n)` at the balanced sphere product.
2. **The `p_2 = 3/4` claim is false as stated.** The file (from 2d56917) says `tr(Wring^2) = (3/4)|R|^2` for *every* algebraic curvature tensor, with "Ricci-flatness only removing the g-direction eigenvalue". The identity holds on the **full** `S^2(V)`; on `S^2_0`, which is where Li's eq. (1.2)/(2.3) operator lives and where the code computes, it holds only in the Ricci-flat case. Witnesses:

   | tensor | `tr(Rring^2)` on `S^2_0` | `(3/4)\|R\|^2` | `tr` on full `S^2` |
   |---|---|---|---|
   | round S^6 | 20.000000 | 45.000000 | 45.000000 |
   | round S^7 | 27.000000 | 63.000000 | 63.000000 |
   | S^3 x S^3, full R | 14.000000 | 18.000000 | 18.000000 |
   | random algebraic curvature tensor, n=6 | 3481.655306 | 3753.601938 | 3753.601938 |
   | random Weyl, n=6 | 4903.822950 | 4903.822950 | 4903.822950 |
   | random Weyl, n=7 | 9001.593740 | 9001.593740 | 9001.593740 |

   The correct statement: `tr_{S^2(V)}(Rring^2) = (3/4)|R|^2` for every algebraic curvature tensor, and the restriction to `S^2_0` agrees with it exactly when `R` is Ricci-flat. Nothing downstream breaks (the file only ever applies it to Weyl tensors) but the sentence claims a generality it does not have, and it is the sentence the guard's assert message repeats.

3. **The file only runs from the repository root.** The guard loads by the relative path `scripts/runs/...`; from any other working directory it raises `FileNotFoundError` before reaching a single assert.
