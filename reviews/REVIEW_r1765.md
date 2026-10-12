# REVIEW r1765: L264Two.lean and L264Semi.lean, L264 (2) from a split and from Mathlib's IsSemisimple

**Standfirst.** Cold Gate 2 reading of [L264Two.lean](../lean/HamiltonsCubic/Results/L264Two.lean) (commit 0bb66fea) and [L264Semi.lean](../lean/HamiltonsCubic/Results/L264Semi.lean) (commit 8c16c005) for statement fidelity against [findings/second-order.md](../findings/second-order.md) Lemma L264 (2), with the [lean/INDEX.md](../lean/INDEX.md) L264 row as edited in both commits. The kernel checked the proofs. Analysis-only footing: one `#print axioms` file and a seconds-long pure-Python screen of the so(4) example, reported as a screen.

**Summary.** `L264_semisimple_unstable` states the record's (2) at the operator level with the record's own notion of stability, its hypotheses are exactly "semisimple subalgebra of so(n) with two simple ideals" and "self-adjoint #-idempotent supported on h, positive definite there", and the destabilising H built inside the proof lies in Sym²h, so the prose left in the INDEX is nominal.

## Claim table

| Claim | Verdict |
|---|---|
| `L264_semisimple_unstable`'s hypotheses are the record's "compact semisimple h with two or more simple ideals" and "positive-definite idempotent" (Q1) | CONFIRMED (O1) |
| `L264_two`: h = h₁ + h₂, both nonzero, bracket-closed, commuting, h₁ spanned by brackets, gives ¬IsStable C, with orthogonality derived correctly and nothing stronger than needed (Q2) | CONFIRMED (O2) |
| `oproj` with `oproj_mem`, `oproj_self`, `oproj_idem`, `oproj_sa`, `oproj_zero` is the orthogonal projection onto V (Q3) | CONFIRMED |
| The only gap to the record's (2) is reading h's # and stability as so(n)'s on operators supported on h, and ¬IsStable is the record's instability (Q4) | CONFIRMED (O3) |
| `#print axioms` on `L264_two` and `L264_semisimple_unstable` (Q5) | CONFIRMED: propext, Classical.choice, Quot.sound |
| so(4) = so(3) ⊕ so(3) with C = I/2 meets the hypotheses and is unstable (Q6) | CONFIRMED (screen) |
| INDEX row L264 as edited in 0bb66fea and 8c16c005 (Q7) | CONFIRMED WITH OBSERVATIONS (O4) |

## The record

Statement (2), quoted: *"(2) On a compact semisimple $\mathfrak h$ with two or more simple ideals, no positive-definite idempotent is stable."*

Stability, from Statement (1), quoted: *"stable: $\langle C\#H,H\rangle\le\tfrac12\lVert H\rVert^2$ for every $H\perp C$."* In (1) $C$ lives in $\operatorname{Sym}^2\mathfrak{so}(n)$, so $H$ ranges over $\operatorname{Sym}^2\mathfrak{so}(n)$.

Proof (2), quoted: *"(2) Write $C=D_1+D_2+E$ over $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$ with $E$ the cross block. $\mathrm{ad}$ kills $\mathfrak h_1\wedge\mathfrak h_2$, so $(C\#C)_{\mathfrak h_i\mathfrak h_i}=D_i\#D_i$ and $C\#D_i=D_i$: each $D_i$ is an eigenvector of eigenvalue $1$, and $\operatorname{span}(D_1,D_2)$ meets $C^\perp$."*

## Q1: the hypothesis set of L264_semisimple_unstable

- **Semisimple.** `LieAlgebra.IsSemisimple ℝ (lieOf h hbr)` is Mathlib's lattice definition (atoms have supremum ⊤, are sSup-independent, are non-abelian). In characteristic 0 this is semisimplicity in the usual sense, and `lieOf` (reviewed r1763) is h as a Lie subalgebra of the matrix algebra with the commutator, which `psi_br` confirms agrees with `brS`.
- **Compact.** Automatic. Every subalgebra of so(n) carries the positive definite ad-invariant form ½tr(XᵀY) (the layer's `inner2`, invariant by `inner2_brS_skew`), so it is the Lie algebra of a compact group. The record's "compact" adds nothing for h ⊆ so(n).
- **Two or more simple ideals as two distinct atoms.** An atom of the lattice of Lie ideals is a minimal nonzero ideal. In a semisimple algebra the minimal ideals are exactly the simple ideals, so "two distinct atoms" is "at least two simple ideals". Correct.
- **Positive-definite idempotent.** `hC` (self-adjoint, so C ∈ Sym²so(n)), `hidem` (`sharpMapCL C = C`, that is C#C = C), `hran` (range in h, hence by self-adjointness C kills h^⊥, so C is supported on h) and `hpd` (positive definite on h). This is the record's "positive-definite idempotent on h" read in so(n)'s #, which on Sym²h equals h's own # (see Q4).
- **Split used.** One atom I against J' = sSup(atoms \ {I}): `hinf` from `sSupIndep_isAtom`, `hsup` from `sSup_atoms_eq_top` via `sSup_insert`, J' ≠ ⊥ since J ≤ J', I perfect by `lie_eq_self_of_isAtom_of_nonabelian`. `subOf_*` transport each fact to so(n) correctly (`subOf_comm` uses ⁅I,J'⁆ ≤ I ⊓ J' = ⊥).

## Q2: L264_two

- **h = h₁ + h₂.** `hsum : h ≤ h₁ ⊔ h₂` with `hle₁`, `hle₂` gives h₁ ⊔ h₂ ≤ h, so h = h₁ ⊔ h₂, and the submodule supremum is the sum. Directness is left to be derived: an element of h₁ ∩ h₂ is orthogonal to itself by `orth`, hence zero. The docstring's "⊕" is therefore a consequence, which is fine.
- **Ideals.** Bracket-closure of each plus `hcomm` makes each an ideal of h = h₁ + h₂, so "commuting ideals" is exactly what the hypotheses say.
- **Orthogonality derivation.** For A, B ∈ h₁ and b ∈ h₂, `inner2_brS_skew` gives ⟨[A,B], b⟩ = −⟨B, [A,b]⟩ = 0 by `hcomm A b`. Span induction extends this to the span of brackets, and `hperf` puts all of h₁ inside that span. Correct, and it needs only h₁ perfect: h₂ perfect is not assumed and not needed.
- **Nothing stronger than needed.** `hperf` on one side is the minimum that yields orthogonality from commutation (two commuting abelian pieces need not be orthogonal). `hne₁`, `hne₂` are necessary (with h₂ = 0 the conclusion fails at C = I/(n−2) on simple h for n ≥ 7, where I is stable by L259 (2)). The positive-definiteness `hpd` is used only through `hblk` (both blocks nonzero), which is weaker, consistent with r1759's remark that `L264_cross` needs only nonzero blocks.
- **Glue.** `hkill` (C kills h^⊥ from self-adjointness and `hran`), `hQ` (P₁ + P₂ is the identity on h), `hCQ`, `hQC` are the support hypotheses of `L264_cross`, derived correctly.

## Q3: oproj

`oproj V` is `ofSk ∘ (Vsp V).starProjection ∘ toSk`, Mathlib's orthogonal projection transported to `skewSub`. The five properties: range in V (`oproj_mem`), identity on V (`oproj_self`, so range = V), idempotent (`oproj_idem`), self-adjoint for `inner2` (`oproj_sa`, via `inner_def`), and zero on V^⊥ for `inner2` (`oproj_zero`). The kernel is exactly V^⊥: `oproj_zero` gives ⊇, and if P X = 0 then ⟨X, Y⟩ = ⟨X, P Y⟩ = ⟨P X, Y⟩ = 0 for Y ∈ V gives ⊆. These characterise the orthogonal projection onto V. The inner product on `SkewSp` agrees with `inner2` through `inner_def`, so the orthogonality is the layer's.

## Q4: the remaining gap, and which instability

- **`IsStable C`** quantifies over every self-adjoint H ⊥ C in so(n), which is the record's (1) verbatim. So `¬IsStable C` is instability in the record's sense, and it is what (3) consumes (the maximiser's C is stable in this ambient sense by (1)).
- **Intrinsic reading.** If (2) is read with h's own stability (H ranging over Sym²h only), ¬stable_h is the stronger statement. The proof delivers it anyway: `L264_cross` destabilises with H = ‖D₂‖²D₁ − ‖D₁‖²D₂, and D_i = P_iCP_i is supported on h_i ⊆ h, so H ∈ Sym²h. The statement does not export this H (O3).
- **h's own #.** For A, B supported on h, the entries (A#B)_{αβ} involve only structure constants c_α^{γδ} with γ, δ ∈ h, which vanish unless α ∈ h because h is a subalgebra, so so(n)'s # restricted to Sym²h is h's # for the induced metric. This is the record's "Sym²h is closed under #" in (1). It is the whole content of the prose item, and it is a short true fact.
- So yes: that reading is the only gap between `L264_semisimple_unstable` and the record's (2), and under either reading of stability the Lean conclusion (with the proof's H) covers it.

## Q5: axioms

Check file importing `HamiltonsCubic.Results.L264Semi`, run with `lake env lean`:

```
'HamiltonsCubic.L264Two.L264_two' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L264Semi.L264_semisimple_unstable' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx`, no `native_decide` (`Lean.ofReduceBool`).

## Q6: an object meeting the hypotheses

- **Object.** n = 4, h = so(4), hbr trivial, lieOf so(4) semisimple with exactly two atoms Λ²₊ and Λ²₋ (each ≅ so(3)). C = I/2: self-adjoint, range in h, positive definite. With the layer's convention I#I = (n−2)I = 2I, so (I/2)#(I/2) = I/2 and C is an idempotent.
- **Conclusion.** The theorem says I/2 is not stable. Screen (pure Python, the record's formula (A#B)_{αβ} = ½ c_α^{γδ}c_β^{εζ}A_{γε}B_{δζ} on the orthonormal basis e_ij of so(4)): I#I = 2I exactly, C#C = C, and H = P₊ − P₋ has ⟨H, C⟩ = 0, ⟨C#H, H⟩ = 6 = ‖H‖² > 3 = ½‖H‖². This is the proof's H up to scale (D_i = P_±/2), and the hypothesis set is non-vacuous. Discharging `IsSemisimple` for this h in Lean was not attempted (screen only).
- For `L264_two` the same object serves with h₁ = Λ²₊ (perfect, being so(3)), h₂ = Λ²₋.

## Q7: the INDEX row

The row names `L264_two` and `L264_semisimple_unstable` accurately (hypotheses, derived orthogonality, split from atoms), lists both files, keeps status **partial** (right, since (3)'s reduction to simple subalgebras is still prose), and states the untyped remainder in (2) as the reading of h's # and stability. Accurate, with O4.

## Verdict

**CONFIRMED WITH OBSERVATIONS.**

1. **O1.** "Compact" in the record is automatic for subalgebras of so(n) (positive definite invariant form `inner2`). The row or the file header could say so in one clause, so a reader does not look for a compactness hypothesis.
2. **O2.** `L264_two`'s docstring writes h = h₁ ⊕ h₂, and the hypotheses give h = h₁ + h₂ with directness derived from orthogonality (h₁ ∩ h₂ is self-orthogonal). Correct as is. A one-line remark would match the header's "derived rather than assumed" wording.
3. **O3.** The destabilising H = ‖D₂‖²D₁ − ‖D₁‖²D₂ lies in Sym²h, but neither `L264_cross` nor the two new theorems export it. The INDEX prose item is therefore nominal: so(n)'s # on Sym²h is h's own # by closure, and the H found is supported on h. A variant concluding `∃ H` self-adjoint, supported on h, ⊥ C with Ftri C H H > ½‖H‖² would close the prose item outright.
4. **O4.** The row's closing sentence "the untyped remainder is, in (2), only the reading ..." could add that this reading is the record's own (stability in (1) ranges over Sym²so(n)) and that the destabiliser lies in Sym²h (O3), which is what the findings entry's banner already says. Wording only.

**Falsifiers.**

- `L264_semisimple_unstable`: a bracket-closed h ⊆ so(n), semisimple with two distinct atoms, and a self-adjoint C with C#C = C, range in h, positive definite on h, and ⟨C#H,H⟩ ≤ ½‖H‖² for every self-adjoint H ⊥ C.
- `L264_two`: nonzero bracket-closed commuting h₁, h₂ with h = h₁ + h₂ and h₁ spanned by its brackets, and such a stable C.
- `oproj_*`: a subspace V and X with oproj V X ∉ V, or Y ∈ V with oproj V Y ≠ Y, or ⟨oproj V X, Y⟩ ≠ ⟨X, oproj V Y⟩, or X ⊥ V with oproj V X ≠ 0.
- Q6 object: an H ⊥ I in Sym²so(4) with ⟨(I/2)#H,H⟩ ≤ ½‖H‖² for all H would contradict the theorem. The screen exhibits the opposite at H = P₊ − P₋.
