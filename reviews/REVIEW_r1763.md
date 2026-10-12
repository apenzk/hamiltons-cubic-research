# REVIEW r1763: CompactSemisimple.lean, the semisimple steps of L263 and L264 (1)

**Standfirst.** Cold Gate 2 reading of [CompactSemisimple.lean](../lean/HamiltonsCubic/Results/CompactSemisimple.lean) at commit 6f0e6082 against [findings/second-order.md](../findings/second-order.md) Lemmas L263, L264 (1) and L260 (2), Mathlib's `LieAlgebra.IsSemisimple` and `LinearMap.BilinForm.lieInvariant`, and the [lean/INDEX.md](../lean/INDEX.md) rows L260, L263, L264 as edited in that commit. Statement fidelity only, the kernel having checked the proofs. Analysis-only footing: every identification below is derived by hand from the definitions. One small check file ran (`#print axioms` and one `#check`), reported as a kernel check.

**Summary.** Every statement says what the record needs: Mathlib's `IsSemisimple` is the standard notion, `lieOf h` is h with the layer's bracket, the trace form is invariant in Mathlib's sign convention and positive definite, and the axioms are the standard three. The one gap is that L260 (2), whose proof is where the record's sentence "a perfect subalgebra of a compact algebra is semisimple" lives, is not credited with the step, although `isSemisimple_perfect` composed with `L260_range_subalgebra` now closes it at every positive-semidefinite idempotent.

## Claim table

| Claim | Verdict |
|---|---|
| `isSemisimple_of_center`: finite-dimensional real L, symmetric positive-definite invariant form, trivial centre, gives `IsSemisimple ℝ L` (Q3) | CONFIRMED |
| `center_trivial_of_perfect`: a perfect such L has trivial centre | CONFIRMED |
| `lieOf`: a bracket-closed subspace of so(n) as a Lie subalgebra of the matrices, the same Lie algebra as (h, brS) (Q1) | CONFIRMED |
| `traceForm`, `traceForm_symm`: ½ tr(xᵀy), symmetric | CONFIRMED |
| `traceForm_inv`: invariant in Mathlib's sign convention, via `inner2_brS_skew` (Q2) | CONFIRMED |
| `traceForm_pos`: positive definite on the subalgebra (Q2) | CONFIRMED |
| `isSemisimple_sub`, `isSemisimple_perfect`: trivial centre, or spanned by brackets, gives semisimple | CONFIRMED |
| `gv_span_closed`: span(gv) is closed under brS | CONFIRMED |
| `L263_semisimple`: L263's h = span(gv) is semisimple, so the witness is in U's scope (Q4) | CONFIRMED (O2, O3) |
| `L264_one_semisimple`: the range of C = X/F(X) is semisimple (Q5) | CONFIRMED |
| `#print axioms` on `L263_semisimple`, `L264_one_semisimple`, `isSemisimple_of_center` (Q6) | CONFIRMED: propext, Classical.choice, Quot.sound |
| INDEX rows L260, L263, L264 as edited in 6f0e6082 (Q7) | CONFIRMED WITH OBSERVATIONS (O1, O4) |

## The record

L260, the scope of U (What it gives), quoted: *"Statement H, and with it I117's sharp $\#$ half of P and I114, is a lower bound on the norm of positive-definite idempotents on semisimple subalgebras. The uniqueness that would have given it, U (the positive-definite idempotents on $\mathfrak h$ are exactly $\bigoplus_i\Pi_i/c_i$), is false: L263's $SU(3)\subset G_2$ gives a second one on $\mathfrak g_2$, of larger norm than $I/4$."* L260 (3) sets the domain: *"the least squared norm of a positive-definite idempotent on a compact semisimple subalgebra of $\mathfrak{so}(n)$"*.

L260 (2), quoted: *"(2) The range of a PSD idempotent is a semisimple subalgebra $\mathfrak h$, on which it is a positive-definite idempotent of $\mathfrak h$'s own $\#$."* Its proof, quoted: *"(2) $C\#C=\tfrac12\sum\sigma_i\sigma_j|[v_i,v_j]\rangle\langle[v_i,v_j]|$ has range $[V,V]$, which must equal $V$, and a perfect subalgebra of a compact algebra is semisimple."*

L264 (1), quoted: *"(1) Let $X$ maximise $F$ on the unit sphere of $\operatorname{Sym}^2\mathfrak{so}(n)$, taken positive semidefinite by L260 (1). Then $C=X/F(X)$ is an idempotent, positive definite on the semisimple subalgebra $\mathfrak h$ it is supported on, and* stable: $\langle C\#H,H\rangle\le\tfrac12\lVert H\rVert^2$ *for every $H\perp C$."*

L263's statement, the witness clause, quoted: *"$$C=\tfrac9{28}P_{\mathfrak{su}(3)}+\tfrac3{28}P_{\mathfrak p}$$ is a positive-definite idempotent on $\mathfrak g_2$ other than $I/4$, so U is false."*

## Q1. Mathlib's IsSemisimple and lieOf

- `LieAlgebra.IsSemisimple` (Mathlib/Algebra/Lie/Semisimple/Defs.lean) has three fields: the atoms (minimal nonzero ideals) have supremum ⊤, are `sSupIndep`, and are non-abelian. That is L the direct sum of its minimal ideals, each non-abelian, hence simple. It is the record's "semisimple" (a direct sum of simple ideals, equivalently trivial radical in characteristic zero).
- `lieOf h hbr` has carrier the image of h under the coercion `skewSub ι → Matrix ι ι ℝ`, with the Lie structure `LieRing.ofAssociativeRing`, bracket AB − BA (`Ring.lie_def`). The layer's `brS X Y` is `br X Y = XY − YX` on the underlying matrices (Base/Bivectors2.lean). The coercion is injective and linear, and carries brS to the commutator, so `lieOf h` is isomorphic to (h, brS). The local instance attribute changes nothing, since these are the instances Mathlib already uses on a ring.
- Finite dimension (`Module.Finite`) is inferred for a subalgebra of the matrices, so `isSemisimple_of_center` applies.

## Q2. Sign convention and definiteness

- Mathlib: `Φ.lieInvariant L` is `∀ x y z, Φ ⁅x, y⁆ z = −Φ y ⁅x, z⁆`.
- `inner2_brS_skew X Y Z`: `inner2 (brS X Y) Z = −inner2 Y (brS X Z)`. With x = X, y = Y, z = Z this is the same identity term for term. By hand: for skew X, ½tr((XY − YX)ᵀZ) = ½tr(−YᵀXZ + XYᵀZ) = ½tr(−YᵀXZ + YᵀZX) = −½tr(Yᵀ(XZ − ZX)), using Xᵀ = −X and cyclicity, so ad_X is skew-adjoint for the trace form. `traceForm_inv` unfolds the subalgebra bracket to `Ring.lie_def` and applies it.
- `inner2 A A = ½ Σ A_ij² ≥ 0`, zero only at A = 0, on every real matrix, so on skew ones. `traceForm_pos` is the Frobenius form's definiteness restricted to the subalgebra. CONFIRMED.

## Q3. The centre hypothesis and the atom argument

- `hcen : ∀ z, (∀ x, ⁅x, z⁆ = 0) → z = 0` says every z commuting with all of L is zero: exactly trivial centre.
- The route is `InvariantForm.isSemisimple_of_nondegenerate`, which needs Φ nondegenerate (from definiteness), reflexive (from symmetry), invariant, and every atom non-abelian. For an abelian atom I and a ∈ I, `⁅a, x⁆ ∈ I` (ideal, with `lie_skew`), `hinv a x ⁅a,x⁆` gives Φ⁅a,x⁆⁅a,x⁆ = −Φ x ⁅a,⁅a,x⁆⁆, and ⁅a,⁅a,x⁆⁆ = 0 since a and ⁅a,x⁆ both lie in the abelian I. Definiteness gives ⁅a,x⁆ = 0, hence ⁅x,a⁆ = 0 for all x, so a is central and a = 0 by `hcen`. Then I = ⊥, contradicting that an atom is nonzero. CONFIRMED.
- `center_trivial_of_perfect`: a central z has Φ⁅x,y⁆z = −Φ y ⁅x,z⁆ = 0, so z is orthogonal to the span of brackets, which is all of L, so Φ z z = 0 and z = 0. CONFIRMED. (`isSemisimple_perfect` repeats this argument at the matrix level rather than calling it, which is a style point only.)

## Q4. L263_semisimple

- `L263_g2` is existential in h, but its proof fixes `h := Submodule.span ℝ (Set.range gv)` (I117G2.lean line 416), and `L263_witness` states the instance with the same `gv` (C acts by 9/28 or 3/28 on each `gv k`, and `gop lamP` fixes each `gv k`). `center_zero` and `L263_not_ideal_sum` in L263Ideal.lean are stated over the same `gv`. So `span(range gv)` is the fourteen-dimensional h carrying the witness. CONFIRMED.
- The proof takes a central Z = Σ c_m gv_m and feeds `hcen (gv k)` through `brS_neg` into `center_zero`, which needs brS Z (gv k) = 0 for all k. That matches.
- U's scope (L260 (3)) is positive-definite idempotents on a compact semisimple subalgebra of so(n). `L263_semisimple` gives semisimple, and compactness is the definite invariant trace form of `traceForm_inv` and `traceForm_pos`, which holds for every subalgebra of so(n). So the witness is in U's scope completely, as the INDEX row now says.
- What remains is correctly listed in the row: that h's own # is so(7)'s restricted (named by r1760), that h is g2 with the 9/28 directions su(3), and the Casimir values. Simplicity is not proved and is not needed for U's scope (O3).

## Q5. L264_one_semisimple

- `L264_one` gives, for C = (1/F(X))·X at a PSD maximiser, bracket closure of range C and `range C = span{brS A B | A, B ∈ range C}`. `isSemisimple_perfect` takes the `≤` half. C is self-adjoint, so the subspace it is supported on is its range. Positive definiteness on the range is `L264_one`'s last clause. Together they are the record's clause "positive definite on the semisimple subalgebra h it is supported on". CONFIRMED.
- The `∃ hbr` form: hbr is a proof of a Prop, so by proof irrelevance `lieOf _ hbr` does not depend on which proof is chosen, and the existential asserts exactly bracket closure together with semisimplicity. Harmless. The `#check` output confirms the statement reads as described.

## Q6. Axioms

Check file importing `HamiltonsCubic.Results.CompactSemisimple`, run with `lake env lean` after waiting for another session's build to finish:

```
'HamiltonsCubic.CompactSemisimple.L263_semisimple' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.CompactSemisimple.L264_one_semisimple' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.CompactSemisimple.isSemisimple_of_center' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Q7. INDEX rows

- L263: now cites CompactSemisimple.lean and `L263_semisimple`, and drops "that a subalgebra of the compact so(7) with trivial centre is semisimple" from what is left. Accurate.
- L264: "(1) nothing: the step from a perfect subalgebra of the compact so(n) to a semisimple one is PROVED as `L264_one_semisimple`". Accurate for (1).
- L260: r1762's O1 is taken (the opening now reads "(1) at every X and (4) at so(n)", and "Routed to the research session" is replaced). The row still reads (2) as "the range is a perfect subalgebra with C positive definite on it" and does not record that semisimplicity of the range at every PSD idempotent now follows from `isSemisimple_perfect` (O1). The row's closing note that `L260_psd_cone`'s docstring is owed an edit is being overtaken by an uncommitted working-tree edit of that docstring in another session (O4).
- The record's L263 and L264 provenance lines were brought into line by the later commit 223ebe2d, which was outside this brief and was checked only for the two sentences in question.

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1, L260 (2) is not credited.** The sentence "a perfect subalgebra of a compact algebra is semisimple" is in L260's proof of (2), and L264 (1) inherits it. `isSemisimple_perfect` composed with `L260_range_subalgebra` (any self-adjoint PSD idempotent) proves L260 (2)'s semisimple clause in full generality, not only at the maximiser. No theorem states that composite, and neither the L260 INDEX row nor the record's L260 provenance mentions it. Suggested: a one-line `L260_two_semisimple` and a row edit.
2. **O2, L263's h is joined to the witness through gv, not through L263_g2's statement.** `L263_g2` quantifies h existentially, so `L263_semisimple` attaches to `L263_witness` and `center_zero` (both over `gv`), not to `L263_g2`'s conclusion. A corollary stating `L263_g2` with h := span(range gv) and semisimplicity would make the join a statement.
3. **O3, semisimple rather than simple.** L263's criterion is stated inside a compact simple g, and the record calls h g2. Simplicity of span(gv) stays with the record, as the row lists under "that it is g2". U's scope needs only semisimple, so the row's "inside U's scope" is exact.
4. **O4, the L260 row's docstring note.** "`L260_psd_cone`'s docstring ... is owed an edit" will be stale once the working-tree edit to I117Statements.lean lands.

## Falsifiers

- `isSemisimple_of_center`: a finite-dimensional real Lie algebra with a positive-definite invariant symmetric form, trivial centre and an abelian minimal ideal.
- `center_trivial_of_perfect`: a nonzero central element of a perfect Lie algebra with a positive-definite invariant form.
- `lieOf` as (h, brS): a pair X, Y in h whose brS differs from XY − YX.
- `traceForm_inv`: skew X, Y, Z with ½tr([X,Y]ᵀZ) ≠ −½tr(Yᵀ[X,Z]).
- `traceForm_pos`: a nonzero real matrix with zero Frobenius norm.
- `L263_semisimple`: a nonzero Z in span(gv) commuting with every gv k.
- `L264_one_semisimple`: a PSD unit maximiser whose C has a range with a nonzero central element, or not closed under the bracket.
