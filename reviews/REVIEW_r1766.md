# REVIEW r1766: L260Sub.lean's K and eigenbasis corollaries, L264Three.lean's simple subalgebra, L264Destab.lean's destabilising direction, L264Sym.lean's closure of Sym² h

**Standfirst.** Cold Gate 2 reading of three Lean commits for statement fidelity: da87f648 ([L260Sub.lean](../lean/HamiltonsCubic/Results/L260Sub.lean), `Kh_eq_sharp` and `L260_four`), 1532f167 ([L264Three.lean](../lean/HamiltonsCubic/Results/L264Three.lean), `L264_three_one_atom`, with `L264_three_simple` of 68f47a59 added at the coordinator's request), 0aee2b09 ([L264Destab.lean](../lean/HamiltonsCubic/Results/L264Destab.lean), `L264_cross_H`, `L264_two_H`, `L264_semisimple_H`) and d996fbd3 ([L264Sym.lean](../lean/HamiltonsCubic/Results/L264Sym.lean), `rk1_expand`, `sharp_closed`, also added at the coordinator's request), against [findings/second-order.md](../findings/second-order.md) Lemmas L260 (4) and L264 (1), (2), (3), and the [lean/INDEX.md](../lean/INDEX.md) rows L260 and L264 as edited. The kernel checked the proofs. Analysis-only footing: two check files compiled with `lake env lean`, no sweep.

**Summary.** All five commits state what they claim: `Kh_eq_sharp` makes the Casimir reading of r1764 O1 a statement, `L260_four` is L260 (4)'s inequality for every self-adjoint PSD idempotent, `L264_three_simple` is (3)'s "simple h", and the three `_H` theorems keep their predecessors' hypotheses verbatim while strengthening ¬IsStable to an exported H in Sym²h. `sharp_closed` is L264 (1)'s "Sym²h is closed under #" in its quadratic form, from which the polarised form follows in one line.

## Claim table

| Claim | Verdict |
|---|---|
| `diagOp b 1[λ>0]` is the orthogonal projection P_h onto h = span{b_k : λ_k > 0} = range C (A1) | CONFIRMED (O1) |
| `Kh_eq_sharp`: K_k = sharpBil2 P_h b_k b_k = ⟨(P_h#P_h) b_k, b_k⟩ in the layer's convention, at λ_k > 0 (A2) | CONFIRMED |
| `L260_four`'s hypotheses (self-adjoint, PSD, #-idempotent) are the record's L260 (4) "every positive-definite idempotent" read on h = range C, conclusion tr(CK) ≤ d (A3) | CONFIRMED (O1) |
| `L264_three_one_atom`: semisimple with any two atoms equal says "simple or zero" (B1) | CONFIRMED |
| range C is nonzero at the maximiser, and `L264_three_simple` states Mathlib's `LieAlgebra.IsSimple`, the record's "simple h" in (3) (B2) | CONFIRMED (O2) |
| `L264_cross_H`, `L264_two_H`, `L264_semisimple_H` carry exactly the hypotheses of `L264_cross`, `L264_two`, `L264_semisimple_unstable` and imply their conclusions (C1) | CONFIRMED |
| The exported H (self-adjoint, ⊥ C, into h, killing h⊥, ½‖H‖² < F(C,H,H)) makes C unstable in h's own sense (C2) | CONFIRMED (O3) |
| `sharp_closed`: for h bracket-closed and A self-adjoint with range in h, A#A has range in h, which is L264 (1)'s "Sym²h is closed under #" (E1) | CONFIRMED (O5) |
| The polarised form A#B is not needed for reading h's own # on the values F(C,H,H) (E2) | CONFIRMED (O5) |
| `#print axioms` on all nine theorems | CONFIRMED: propext, Classical.choice, Quot.sound |
| INDEX rows L260 and L264 as edited, including d996fbd3's remainder sentence (D) | CONFIRMED WITH OBSERVATIONS (O4) |

## A. L260Sub.lean, da87f648

**Record, L260 (4):** "Every positive-definite idempotent satisfies $\operatorname{tr}(CK)\le d$, $K=\bigoplus_ic_i\Pi_i$, with equality exactly at $\bigoplus_i\Pi_i/c_i$." Read with (2): C is a positive-definite idempotent of h's own # on h = range C.

- **A1.** `diagOp b μ Y = Σ_β μ_β ⟨b_β, Y⟩ b_β` with b orthonormal. At μ = 1[λ>0] this is Σ over the positive eigenvectors of ⟨b_β, ·⟩ b_β, the orthogonal projection onto their span. Since C b_β = λ_β b_β, range C is that span. So `diagOp b 1[λ>0]` is P_h with h = range C. The identification range C = span{b_k : λ_k > 0} is standard and stays in prose (O1).
- **A2.** `sharpBil2 R X Y` is ⟨(R#R)X, Y⟩ by `inner2_sharpMap` (PhiTri.lean), `sharpMap R` being the operator R#R that `IsIdem` compares with R. `sharpBil2_eigen` at the eigenbasis b with eigenvalues μ = 1[λ>0] (supplied by `diagOp_basis`) gives ½ Σ_{β,γ} μ_β μ_γ ⟨b_β,[b_k,b_γ]⟩², which for λ_k > 0 is `Kh b lam k` = ½ Σ_{i,j: λ>0} ⟨b_i,[b_k,b_j]⟩². P_h is self-adjoint, so the row/column convention question of L260 (1) does not arise. For x, y ∈ h the ambient ⟨(P_h#P_h)x,y⟩ = ½ Σ_{a,b∈h} ⟨[e_a,e_b],x⟩⟨[e_a,e_b],y⟩ is h's own Casimir in the restricted Frobenius normalisation, and tr(CK) needs only the diagonal of K in C's eigenbasis, since C is diagonal there. The restriction to λ_k > 0 is harmless because λ_k weights the term.
- **A3.** `L260_four` takes C self-adjoint, PSD and `IsIdem`, builds the eigenbasis from `opSk_symm` and Mathlib's `eigenvectorBasis`, derives λ ≥ 0 from PSD, and applies `L260_four_sub`. A self-adjoint PSD ambient idempotent is positive definite on its range (`L260_range_subalgebra`), and conversely a positive-definite idempotent of h's own # extended by zero on h⊥ is an ambient self-adjoint PSD idempotent under the restriction reading. So the hypothesis set is the record's. #{λ_k > 0} is rank C = d. The conclusion is existential in (b, λ), and `L260_four_sub` already gives the universal form. The equality clause stays prose, as the row says.
- **Object.** I/(n−2) at n = 4 (`idem_Ic`, `pd_Ic`) meets `L260_four`'s hypotheses. The check file applies the theorem to it, PSD derived from `pd_Ic`, and it compiles.

## B. L264Three.lean, 1532f167 and the working-tree addition

**Record, L264 (3), statement:** "Hence statement H at $n\ge9$ follows from **U$_{\mathrm s}$**: on a compact simple $\mathfrak h$, every stable positive-definite idempotent equals $I/c$." **Proof (3):** "By (1) and (2) the maximiser's $C$ is a stable positive-definite idempotent on a simple $\mathfrak h\subseteq\mathfrak{so}(n)$, so U$_{\mathrm s}$ gives $C=I/c_{\mathfrak h}$, and [L256] with $\mathcal M(\mathfrak h)=2c_{\mathfrak h}d$ gives $d/c_{\mathfrak h}^2\ge N/(n-2)^2$."

- **B1.** Mathlib's `IsSemisimple` asks sSup of the atoms = ⊤, the atoms independent and non-abelian. The zero Lie algebra satisfies it vacuously (no atoms, sSup ∅ = ⊥ = ⊤). With at most one atom, a nonzero semisimple algebra has exactly one atom I, sSup {I} = I = ⊤, so ⊤ is an atom and the algebra is simple. So `L264_three_one_atom` says "simple or zero" and alone it does not exclude range C = 0.
- **B2.** range C is nonzero: normSq2 X = 1 gives X ≠ 0, `maximiser_pos` gives F(X) > 0, so C = X/F(X) ≠ 0 has a nonzero image. `L264_three_simple` proves exactly this and concludes `LieAlgebra.IsSimple ℝ (lieOf _ hbr)` through `isSimpleOrder_iff_isAtom_top` and non-abelianness of the atom ⊤. Mathlib's `IsSimple` is "every ideal is ⊥ or ⊤, and non-abelian", which over ℝ is the record's simple h, compactness being automatic in so(n) (r1765 O1). The other three attributes of (3)'s sentence (stable, positive definite on h, idempotent) are `L264_one` on the same C, a separate theorem, so the full sentence is two theorems read together (O2).
- **Object.** At n = 4 `L264_one_exists` supplies a PSD unit maximiser, and the check file applies `L264_three_simple` to it. This agrees with the record: at n = 4 statement H fails and the maximiser sits on a simple ideal of so(4) = so(3) ⊕ so(3), with I/2 unstable by L264 (2).

## C. L264Destab.lean, 0aee2b09

**Record, L264 (2):** "On a compact semisimple $\mathfrak h$ with two or more simple ideals, no positive-definite idempotent is stable." r1765 O3 asked for the destabiliser in Sym²h to be exported.

- **C1.** The hypothesis lists of `L264_cross_H`, `L264_two_H` and `L264_semisimple_H` are character-for-character those of `L264_cross`, `L264_two` and `L264_semisimple_unstable` (same section variables h, hbr for the last). Each conclusion ∃ H, IsSelfAdjoint2 H ∧ innerOp2 H C = 0 ∧ … ∧ ½‖H‖² < Ftri C H H implies ¬IsStable C by `IsStable`'s definition. The check file proves that implication generically. Nothing is weakened.
- **C2.** "Maps into h" and "kills h⊥" with self-adjointness put H in Sym²h (`L264_cross_H` states the same as H = QHQ, Q = P₁ + P₂). For operators supported on h, innerOp2 and normSq2 are traces over an adapted basis and so equal h's own, and ⟨(A#B)x,y⟩ = ½ Σ ⟨[Aω_a,Bω_b],x⟩⟨[ω_a,ω_b],y⟩ reduces to a sum over an orthonormal basis of h, the brackets staying in h by closure. So Ftri C H H is h's own F(C,H,H) in the restricted Frobenius normalisation and C is unstable in h's own sense. H ≠ 0 follows from the strict inequality.
- **Object.** so(4) = Λ²₊ ⊕ Λ²₋ with C = I/2: two atoms, C a positive-definite idempotent on all of h, and `L264_semisimple_H` returns a destabiliser. Named, not built (the atoms of so(4) are not in the layer as a Lean object).

## E. L264Sym.lean, d996fbd3

**Record, L264 proof (1):** "... which is Theorem A of [Tkachev] for the metrized algebra $(\operatorname{Sym}^2\mathfrak{so}(n),\#)$; $\operatorname{Sym}^2\mathfrak h$ is closed under $\#$."

- **E1.** `rk1_expand` is the spectral expansion A = Σ λ_k b_k b_kᵀ in an orthonormal eigenbasis, from `onb_expand`. `sharp_closed` takes h bracket-closed, A self-adjoint with A X ∈ h for all X, and concludes (A#A) X ∈ h for all X. The proof puts every b_k with λ_k ≠ 0 in h and reads `sharp_rk1_sum`, A#A = ½ Σ λ_iλ_j [b_i,b_j][b_i,b_j]ᵀ, whose images lie in span{[b_i,b_j]} ⊆ h. The other half of membership in Sym²h, that A#A kills h⊥, follows from self-adjointness of A#A (`isSelfAdjoint2_sharp`): for x ⊥ h, ⟨(A#A)x, y⟩ = ⟨x, (A#A)y⟩ = 0. So A#A ∈ Sym²h, and the theorem is the record's sentence at A#A.
- **E2.** The layer has no two-operator A#B, only the trilinear `Ftri`. Closure of the bilinear product follows by polarisation, 2A#B = (A+B)#(A+B) − A#A − B#B, with A + B again self-adjoint with range in h, so it is one line from `sharp_closed` once such an operator is named. The reading of h's own # at the values the lemma uses, F(C,H,H) = ⟨C#H,H⟩ with C, H ∈ Sym²h, needs only that C and H are supported on h (C2), and closure plays no part in it. The polarised closure is what "Sym²h is a subalgebra of the metrized algebra", the frame in which the record applies Tkachev's Theorem A, means, and it holds by E1 and polarisation.
- **Object.** h = so(3) = Λ²₊ ⊂ so(4) and A = P_h: `sharp_closed` gives P_h#P_h with range in Λ²₊, which matches P_h#P_h = 2P_h, L259's idempotent being P₊/2.

## D. INDEX rows

- L260: the added clause ("`Kh_eq_sharp` identifying K_k as ⟨(P_h#P_h)b_k,b_k⟩ and `L260_four` supplying the eigenbasis") is accurate, and the equality case at a proper h is correctly left as prose.
- L264: "(3)'s reduction to a simple subalgebra is PROVED … semisimple with at most one simple ideal" was, at 1532f167, a heading stronger than its theorem, the zero case being open in the statement. `L264_three_simple` (68f47a59) closes it, and the row at HEAD names it.
- L264: the closing sentence, as edited in d996fbd3, says the untyped remainder "in (2) and (3)" is only naming # on operators supported on h as h's own, the layer carrying no intrinsic # for a subalgebra. For (2) that is accurate. For (3) the U_s ⇒ C = I/c_h ⇒ L256 ⇒ H chain is also untyped: `L270_H_of_Us'` takes U_s' at so(n) as a hypothesis with L256's comparison composed in, and it is not joined to the simple-h clause (O4).

## Verdict

**CONFIRMED WITH OBSERVATIONS.**

1. **O1.** range C = span{b_k : λ_k > 0} and #{λ_k > 0} = dim range C are standard and stay in prose, so "P_h is the projection onto range C" and "the right side is d" are readings of `Kh_eq_sharp` and `L260_four`. A one-line corollary (range of `diagOp b 1[λ>0]` = range C) would make both statements.
2. **O2.** At commit 1532f167 alone, (3)'s "simple h" was typed as "simple or zero". `L264_three_simple` (68f47a59) closes it and the L264 row names it. Consider a combined statement carrying `L264_one`'s idempotent, stable and positive-definite clauses with `IsSimple` on the same C, which is the whole of the record's sentence.
3. **O3.** "h's own sense" is exact in the restricted Frobenius normalisation, which is the record's (L263 banner). On a semisimple h the invariant metric can be rescaled per ideal, and a different choice changes #. The record fixes the restricted one throughout, so this remark records scope.
4. **O4.** The L264 row's "only" in "the untyped remainder is, in (2) and (3), only naming # …" (d996fbd3) understates (3): the composition from U_s on a simple h through L256 to statement H is still prose over `L270_H_of_Us'`, whose hypothesis is U_s' at so(n) with L256's comparison composed in. Wording: "in (2) only …, and in (3) that together with the step from U_s through L256".
5. **O5.** `sharp_closed` states the closure at A#A, and its kill-h⊥ half is left to `isSelfAdjoint2_sharp`. The polarised closure, which is what makes (Sym²h, #) a subalgebra for Tkachev's Theorem A, follows by polarisation and is not typed, the layer having no bilinear operator product. Neither affects the values F(C,H,H) that (2) and (3) use.

**Falsifiers.** `Kh_eq_sharp`: an orthonormal eigenbasis and k with λ_k > 0 where ½ Σ_{i,j: λ>0} ⟨b_i,[b_k,b_j]⟩² differs from ⟨(P#P)b_k,b_k⟩. `L260_four`: a self-adjoint PSD #-idempotent with Σ λ_k K_k > rank C. `L264_three_one_atom` / `L264_three_simple`: a PSD unit maximiser whose C has range with two distinct simple ideals, or range zero. `L264_*_H`: a self-adjoint idempotent meeting the split hypotheses with ⟨C#H,H⟩ ≤ ½‖H‖² for every self-adjoint H ∈ Sym²h orthogonal to C. `sharp_closed`: a bracket-closed h and a self-adjoint A with range in h such that A#A maps some X outside h.
