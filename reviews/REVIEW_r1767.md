# REVIEW r1767: L270Simple.lean's statement H from simple ranges, and L264Three.lean's L264 (3) sentence

**Standfirst.** Cold Gate 2 reading for statement fidelity of `L270_H_of_Us_simple` in [L270Simple.lean](../lean/HamiltonsCubic/Results/L270Simple.lean) (commit 8e349691) and `L264_three_full` in [L264Three.lean](../lean/HamiltonsCubic/Results/L264Three.lean) (commit 82163fc6), against Lemma L264 (3), Lemma L270 (3) and Lemma L256 of [findings/second-order.md](../findings/second-order.md), and the [lean/INDEX.md](../lean/INDEX.md) rows L264 and L270 as edited in both commits. The kernel checked the proofs. Analysis only, one small `#print axioms` file run.

**Summary.** Both theorems state what the record says. `L270_H_of_Us_simple` is L264 (3) and L270 (3)'s reduction with the prose step "(1) and (2) put C on a simple h" now typed, its hypothesis is the one of `L270_H_of_Us'` with one further antecedent (range simple), and the bound in it is exactly U$_{\mathrm s}'$ composed with L256's comparison, whose arithmetic is correct. `L264_three_full` is L264 (3)'s first sentence. The hypothesis is non-vacuous (I/7 on so(9) lies in its scope and meets it with equality), and it is in fact equivalent to statement H, which is the substance of the theorem rather than a defect.

## Claim table

| Claim | Verdict |
|---|---|
| Q1a. `L270_H_of_Us_simple` is the record's reduction "(1) and (2) put the maximiser's C on a simple h, so U$_{\mathrm s}'$ on simple subalgebras suffices" | CONFIRMED |
| Q1b. Its hypothesis is logically weaker than `L270_H_of_Us'`'s (one extra antecedent), so the theorem is stronger | CONFIRMED (O1) |
| Q1c. The hypothesis's bound is U$_{\mathrm s}'$ composed with L256's comparison, and the composition is correct | CONFIRMED (O2) |
| Q2. "range simple" with C self-adjoint PSD idempotent on so(n) matches "C a positive-definite idempotent on a compact simple h" | CONFIRMED (O2) |
| Q3. `L264_three_full` is L264 (3)'s "the maximiser's C is a stable positive-definite idempotent on a simple h ⊆ so(n)" | CONFIRMED (O3) |
| Q4. `#print axioms` on both theorems | CONFIRMED: propext, Classical.choice, Quot.sound |
| Q5. The hypothesis of `L270_H_of_Us_simple` is satisfiable, non-vacuous in scope | CONFIRMED (O1) |
| Q6. INDEX rows L264 and L270 as edited in 8e349691 and 82163fc6 | CONFIRMED WITH OBSERVATIONS (O4) |

## The record, quoted

**L264 (3), statement:** "Hence statement H at $n\ge9$ follows from **U$_{\mathrm s}$**: on a compact simple $\mathfrak h$, every stable positive-definite idempotent equals $I/c$."

**L264 (3), proof:** "By (1) and (2) the maximiser's $C$ is a stable positive-definite idempotent on a simple $\mathfrak h\subseteq\mathfrak{so}(n)$, so U$_{\mathrm s}$ gives $C=I/c_{\mathfrak h}$, and [L256] with $\mathcal M(\mathfrak h)=2c_{\mathfrak h}d$ gives $d/c_{\mathfrak h}^2\ge N/(n-2)^2$."

**L270 (3), statement:** "Statement H at $n\ge9$ follows from **U$_{\mathrm s}'$**: every stable positive-definite idempotent on a compact simple $\mathfrak h$ has $\lVert C\rVert^2\ge d/c^2$. U$_{\mathrm s}$ implies it, and it asks nothing of idempotents heavier than $I/c$."

**L270 (3), proof:** "By L260 (1)–(3) and L264 (1)–(2) the maximiser of $F$ on the unit sphere gives a stable positive-definite idempotent $C$ on a simple $\mathfrak h\subseteq\mathfrak{so}(n)$ with $\lVert C\rVert^2=1/\kappa_n^2$; U$_{\mathrm s}'$ gives $\lVert C\rVert^2\ge d/c_{\mathfrak h}^2$ and L256 gives $d/c_{\mathfrak h}^2\ge N/(n-2)^2$, so $\kappa_n\le(n-2)/\sqrt N$; the reverse inequality is the value at $I$ (L259 (2)), so equality, which is H."

**L256, statement:** "For $n\ge9$ and every Lie subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ of dimension $d$, $\mathcal M(\mathfrak h)/d^{3/2}\le2(n-2)/\sqrt N$, the value of $\mathfrak{so}(n)$."

**StatementH** ([I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean), `def StatementH`): `∀ X, IsSelfAdjoint2 X → Ftri X X X ≤ kappaN ι * normSq2 X ^ (3/2)`, with `kappaN ι = (n − 2)/√(n(n − 1)/2)`. This is H in homogeneous form, F(X) ≤ κ_n ‖X‖³ on Sym² so(n).

## Q1. L270_H_of_Us_simple against the reduction

**Statement as checked** (`#check` output): for `9 ≤ card ι`, if every `C` that is `IsSelfAdjoint2`, `IsPSD2`, `IsIdem`, `≠ 0`, `IsStable`, and has a bracket-closed range `hbr` with `LieAlgebra.IsSimple ℝ (lieOf (range C) hbr)`, satisfies `n(n−1)/2/(n−2)² ≤ normSq2 C`, then `StatementH ι`.

- **Q1a.** The proof body is `L270_H_of_Us'`'s line for line (maximiser from `exists_sa_maximiser`, PSD replacement from `L260_psd_cone`, idempotent and stability from `L264_maximiser_stable`, `maximiser_le_kappa`) with one inserted step, `L264_three_simple` on the PSD maximiser Y, which supplies the simple-range antecedent. That inserted step is exactly the record's "by (1) and (2) the maximiser's C is ... on a simple h". The conclusion is H at n ≥ 9 in the form of `StatementH`. The reverse inequality κ_n ≥ value at I is not needed for H as an upper bound, which is what `StatementH` asserts.
- **Q1b.** The hypothesis of `L270_H_of_Us'` is `∀ C, SA → PSD → Idem → C ≠ 0 → Stable → bound`. The new one adds the antecedent `(∃ hbr, IsSimple ...)` before the bound. So `L270_H_of_Us'`'s hypothesis implies the new one by discarding that antecedent, and `L270_H_of_Us_simple` implies `L270_H_of_Us'`. The theorem is stronger in form. Whether the two hypotheses differ in truth is a separate matter (O1): both are equivalent to H.
- **Q1c.** U$_{\mathrm s}'$ gives ‖C‖² ≥ d/c_h². L256 with M(h) = 2c_h d gives 2c_h d/d^{3/2} = 2c_h/√d ≤ 2(n−2)/√N. All quantities are positive, so c_h²/d ≤ (n−2)²/N, that is d/c_h² ≥ N/(n−2)². Chained, ‖C‖² ≥ N/(n−2)², the hypothesis's bound with N = n(n−1)/2 written as `n(n−1)/2`. The header's sentence "The bound in the hypothesis is U$_{\mathrm s}'$ composed with L256's comparison" is correct, and the comparison is not typed, as the header, the INDEX and the record header all say.

## Q2. "Range simple" against "PD idempotent on a compact simple h"

- **PD on the range.** A self-adjoint PSD operator has kernel equal to the orthogonal complement of its range, so it is positive definite on its range h = range C. `L264_three_full`'s third conjunct and `L260_range_subalgebra` (cited in r1766) state this explicitly. The Lean hypothesis's "PSD with range h" is therefore "PD on h, zero on h⊥", the record's "positive-definite idempotent on h" extended by zero.
- **Idempotent for h's own #.** For C supported on h, the ambient C#C involves only brackets of elements of h (`sharp_closed` in [L264Sym.lean](../lean/HamiltonsCubic/Results/L264Sym.lean) for closure), so ambient `IsIdem` is h's own idempotency under the restricted inner product. The identification of the two #'s is prose, as the INDEX says.
- **Compact simple.** `LieAlgebra.IsSimple ℝ` is non-abelian with no proper nonzero ideals. A subalgebra of so(n) carries the definite invariant form ½tr(xᵀy), so it is compact. A compact real Lie algebra that is simple over ℝ is compact simple in the record's sense (a complex simple algebra viewed as real is never compact). So "range simple" is the record's "compact simple h".
- **Stability.** `IsStable` asks ⟨C#H,H⟩ ≤ ½‖H‖² for every self-adjoint H ⊥ C in Sym² so(n), which contains every such H in Sym²h. So an ambient-stable C is stable in h's sense, and U$_{\mathrm s}'$ in either reading of "stable" implies the Lean hypothesis on the C it covers. This is the direction the reduction needs.
- **d and c_h.** d = dim range C and c_h is fixed by I_h#I_h = c_h I_h in so(n)'s normalisation, which is L256's M(h) = 2c_h d normalisation. Both stay outside the Lean statement because the bound is stated after composition.

## Q3. L264_three_full against L264 (3)'s sentence

**Statement:** for `3 ≤ card ι`, X self-adjoint, PSD, `normSq2 X = 1`, maximising `Ftri Y Y Y` over self-adjoint unit Y, the operator C = (1/F(X))•X satisfies `IsIdem C`, `IsStable C`, `∀ A ∈ range C, A ≠ 0 → 0 < ⟨CA, A⟩`, and `∃ hbr, LieAlgebra.IsSimple ℝ (lieOf (range C) hbr)`.

- "idempotent": `IsIdem`, C#C = C. Matches.
- "stable": `IsStable`, ambient stability, which is L264 (1)'s sense ("for every H ⊥ C"). Matches, and is more than U$_{\mathrm s}$ uses, as L264's *What it gives* says.
- "positive-definite ... on h": the third conjunct, PD on range C. Matches.
- "on a simple h ⊆ so(n)": range C is bracket-closed (the `hbr` witness) and Mathlib-simple, and it is a subspace of skewSub ι = so(n). Matches.
- "the maximiser's C = X/F(X)": X is a unit maximiser over the self-adjoint sphere, taken PSD as a hypothesis, which is the record's "taken positive semidefinite by L260 (1)". The existence of a PSD maximiser is `L260_psd_cone`, used in `L270_H_of_Us_simple` and outside this theorem (O3).

## Q4. Axioms

A check file importing `HamiltonsCubic.Results.L270Simple`, run with `lake env lean` in the background, printed for both `L270_H_of_Us_simple` and `L264_three_full`: `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `Lean.ofReduceBool`. Exit 0.

## Q5. Vacuity

- **In scope and satisfying the bound.** At n = 9, C = I/7 on so(9): `IsIdem` from I#I = (n−2)I (`L265_I_sharp`), `IsStable` from L265's strict stability of I/(n−2) at n ≥ 7 (typed in [I117Stable.lean](../lean/HamiltonsCubic/Results/I117Stable.lean)), self-adjoint PSD and nonzero, range so(9), which is simple. ‖C‖² = 36/49 = N/(n−2)², equality. So the class the hypothesis quantifies over is nonempty and the bound is attained. The simplicity of so(9) as a Mathlib `IsSimple` instance is quoted here, not checked in Lean.
- **Equivalence with H (O1).** For any self-adjoint idempotent C ≠ 0, F(C,C,C) = ⟨C#C, C⟩ = ‖C‖², so F at C/‖C‖ is 1/‖C‖. If H holds, 1/‖C‖ ≤ κ_n, so ‖C‖² ≥ N/(n−2)² for every nonzero idempotent. Hence H implies `L270_H_of_Us'`'s hypothesis, which implies the new one, which implies H. The hypothesis is consistent exactly when H holds at that n.
- **Object that would make it false.** A self-adjoint PSD #-idempotent C of so(n), n ≥ 9, stable on all of Sym² so(n), with simple range and ‖C‖² < N/(n−2)². By the computation above it would also refute H directly. No such object is on record: L267's and L263's idempotents are unstable and heavier than I/c.

## Q6. INDEX rows

- **L270 row.** Names [L270Simple.lean](../lean/HamiltonsCubic/Results/L270Simple.lean) in the files column and states: "(3)'s reduction to simple subalgebras is PROVED ... `L270_H_of_Us_simple`, statement H at $n\ge9$ from the bound ... at the stable positive semidefinite idempotents whose range is a simple subalgebra, the maximiser's being one by `L264_three_simple`; L256's comparison $d/c^2\ge N/(n-2)^2$, folded into the bound, stays prose." Accurate.
- **L264 row.** The (3) clause now reads that `L270_H_of_Us'` has "L256's comparison composed into the hypothesis; the reduction to simple subalgebras is `L270_H_of_Us_simple`", and the remainder sentence names "naming # on operators supported on h as h's own" and "in (3) L256's comparison ... folded into `L270_H_of_Us_simple`'s bound". Accurate, and it discharges r1766 O4. `L264_three_full` is named as stating (3)'s sentence whole, which Q3 confirms.
- The L264 row's parenthesis on `L270_H_of_Us'` ends "**PROVED**, the maximiser's idempotent being stable by `L264_maximiser_stable`", which now sits after the L270Simple clause and reads as if it described `L270_H_of_Us_simple` too. That is true for both, so it is a reading nuisance only (O4).

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1.** The hypotheses of `L270_H_of_Us'` and `L270_H_of_Us_simple` are each equivalent to statement H (H gives ‖C‖² ≥ 1/κ_n² at every nonzero idempotent through F(C/‖C‖) = 1/‖C‖). The new theorem's content is therefore that H is decided on the stable PSD idempotents with simple range, a genuine narrowing of where a counterexample must live. A one-line converse, `StatementH ι → hypothesis`, would make this equivalence a typed statement and is cheap from `IsIdem` and `normSq2`.
2. **O2.** The step from U$_{\mathrm s}'$ to the Lean hypothesis carries three prose identifications, all correct: ambient # on operators supported on h is h's own #, ambient stability implies stability in h's sense, and L256 with M(h) = 2c_h d gives d/c_h² ≥ N/(n−2)². The INDEX and the record header name the last. The first is named in the L264 row's remainder. The second is the harmless direction and is nowhere stated, and a clause in the file header would close it.
3. **O3.** `L264_three_full` requires n ≥ 3 against the record's n ≥ 9 in (3), which is broader and correct since (1) and (2) need no bound on n. It takes the PSD maximiser as a hypothesis, the record's "taken positive semidefinite by L260 (1)", with existence supplied by `L260_psd_cone` in the consumer.
4. **O4.** The record's L270 header (commit 127ff30c) says "what stays prose is the comparison $d/c^2\ge N/(n-2)^2$ of L256, L260 and L264", which attributes the comparison to three lemmas. The comparison is L256's together with M(h) = 2c_h d from L264 (3)'s proof. In the L264 INDEX row, the trailing "PROVED ... `L264_maximiser_stable`" now follows the L270Simple clause, and a reader cannot tell which theorem it qualifies.

**Falsifiers.** For `L270_H_of_Us_simple`'s fidelity: a compact simple h ⊆ so(n), n ≥ 9, with d/c_h² < N/(n−2)² (would refute L256 and break the composition), or an ambient PSD idempotent with simple range whose restriction is not an idempotent of h's own # (excluded by `sharp_closed`). For the hypothesis itself: the object of Q5. For `L264_three_full`: a PSD unit maximiser of F whose C = X/F(X) has a range that is not a simple subalgebra, which the kernel-checked proof excludes, or a reading of Mathlib's `IsSimple` differing from compact simple on a subalgebra of so(n), excluded by the definite invariant trace form.
