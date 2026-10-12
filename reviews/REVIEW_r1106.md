# r1106: the orthogonal projection onto W_n and L234's split in Lean

Log: [agent_logs/r1106-weylproj-split.log](../agent_logs/r1106-weylproj-split.log). Sole reviewer of a comparison round: each Lean statement read against the record's mathematics (hypotheses, conventions, quantifiers, vacuity). One Lean run, a scratch file importing [L234Split.lean](../lean/HamiltonsCubic/Results/L234Split.lean), kept outside the repository. Its content is quoted below where it matters.

**Verdict: every statement is the claimed mathematics. `knOp` is the record's h⊙g, `knCorr` reproduces the record's projector at [nondegeneracy.md](../findings/nondegeneracy.md) line 374 coefficient for coefficient, `weylProj` is the orthogonal projection onto 𝒲ₙ on Λ², and `L234_split` is step (1) with the record's Y₀ = u⊙v an admissible input, checked by instantiating it in Lean. The defects are all in the prose around the files: the L234 row in [lean/INDEX.md](../lean/INDEX.md) still says the projection is "absent by grep", and two Lean headers still list it as untyped.**

| # | claim | verdict |
|---|---|---|
| 1 | WeylRicciRemoval: knOp normalisation, ric_knOp, weylOfBianchi_isWeylOp | CONFIRMED. The file header's "Not typed" list is stale (F3) |
| 2 | WeylProjection: opOf, comp_opOf, bianchi_sub_alt, weylProj_isWeylOp | CONFIRMED |
| 3 | WeylOrthogonal: weylProj_orth, weylProj is the record's π_{𝒲ₙ} | CONFIRMED on Λ², with one scope note (F1). u⊙v meets every hypothesis, proved in Lean |
| 4 | L234Split: L234_split is L234 step (1) | CONFIRMED. restrictLin = restrict by rfl |
| 5 | axioms | CONFIRMED, standard three for both |
| 6 | index rows and record search | REFUTED in part: the L234 row carries a stale "absent by grep", a broken sentence and an understated hypothesis list (F2). Two stale Lean headers (F3). The L209 row and the second-order.md Lean paragraph are accurate |

## Claim 1, WeylRicciRemoval.lean

- **knOp is h⊙g in the record's component convention.** `R4_knOp` gives R4(knOp h)_{ijkl} = h_ik δ_jl + h_jl δ_ik − h_il δ_jk − h_jk δ_il, which is the record's (A⊙B)_{ijkl} = A_ik B_jl + A_jl B_ik − A_il B_jk − A_jk B_il at B = g (the form used in [VERIFY_v19.md](../verification/VERIFY_v19.md) and [VERIFY_v87.md](../verification/VERIFY_v87.md)). At diagonal h = diag(η) the operator acts on φ_ij by η_i + η_j, the eigenvalue [second-order.md](../findings/second-order.md) line 1621 quotes for h⊙id. The identity anchor agrees: R4(id) = δ_ik δ_jl − δ_il δ_jk is ½ g⊙g, and the record says ½ g⊙g = id.
- **ric_knOp is the classical Ric(h⊙g) = (n−2)h + tr(h) g**, with the layer's Ric_ab = Σ_c ⟨R φ_ac, φ_bc⟩, the same contraction as the record's Ric(R)_{jl} = Σ_i R_{ijil} by pair symmetry. It is what L234 step (2) uses: h = Ric(Y₀) is traceless at orthonormal u, v (tr(UV) = −2⟨u,v⟩ = 0), so N's Ricci part h⊙g/(n−2) is recovered.
- **knCorr is the record's projector.** Expanding the record's P(X) = Y − (2/(n−2)) KN(ρ₀) − (s/(n(n−1))) KN(g) with KN(h) = ½ h⊙g and ρ₀ = Ric − (s/n) g gives Y − (1/(n−2)) Ric⊙g + s/(2(n−1)(n−2)) g⊙g, since 1/(n(n−2)) − 1/(2n(n−1)) = 1/(2(n−1)(n−2)). The Lean correction knOp(knCorr R) = (1/(n−2)) Ric⊙g − s/(2(n−1)(n−2)) g⊙g. Equal, by hand.
- **Hypotheses of weylOfBianchi_isWeylOp** (n ≥ 3, IsLinOp, bivector-preserving, self-adjoint on bivectors, first Bianchi) are exactly what is used: n ≥ 3 for the divisions by n−2 and n−1, self-adjointness for Ric symmetric (so knCorr symmetric, so knOp h preserves bivectors and is self-adjoint), first Bianchi because R is Bianchi and every h⊙g is (bianchi_knOp), so the difference is. The conclusion is `IsWeylOp`, which is the record's 𝒲ₙ as [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) defines it (IsLinOp plus WeylReal's four clauses). No clause is weakened.

## Claim 2, WeylProjection.lean

- **opOf and comp_opOf.** opOf C maps X to ¼ Σ ⟨X, φ_ij⟩ C_ijkl φ_kl. With ⟨φ_ab, φ_ij⟩ = δ_ai δ_bj − δ_aj δ_bi (unit norm under inner2's ½), a pair-antisymmetric C collapses twice by a factor 2 each, so ⟨opOf C φ_ab, φ_cd⟩ = C_abcd. The ¼ is the ordered-pair double count and matches innerOp's ½ per pair. Hypotheses hA1, hA2 are the two antisymmetries, needed and sufficient.
- **bianchi_sub_alt is Alt(R) = ⅓ b(R) in the record's normalisation.** `altCoeff = alt4 ∘ comp` with alt4 T = ⅓(T_ijkl + T_iklj + T_iljk), the record's line quoted in [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean) from [conventions.md](../findings/conventions.md), and `altCoeff_eq_third_bianchi` is rfl against the undivided `bianchi`. The theorem then says b(R − Alt R) = b(R) − 3 Alt(R) = 0, using that Alt(R) is cyclic in its last three indices. Linearity enters only as R(−Z) = −R(Z), for the antisymmetry of comp in the first pair.
- **weylProj = weylOfBianchi(R − Alt R)**, remove Λ⁴ then Ricci. The record says the two removals commute ([second-order.md](../findings/second-order.md) line 442), and in any case Ric of a totally antisymmetric array vanishes, so the order is immaterial. weylProj_isWeylOp requires linear, bivector-preserving, self-adjoint R at n ≥ 3, and no Bianchi, which is right for a projection defined on all of S²(Λ²).

## Claim 3, WeylOrthogonal.lean and whether weylProj is π_{𝒲ₙ}

- **weylProj_orth** states innerOp(R − weylProj R, S) = 0 for every linear, self-adjoint R and every S with IsWeylOp S, under WeylReal's `innerOp` (½ Σ_ij ⟨R φ_ij, S φ_ij⟩, the record's Hilbert-Schmidt pairing on Λ² with ordered-pair doubling). The proof splits R − weylProj R = opOf(Alt R) + knOp(knCorr(R − Alt R)) exactly (`sub_sub_cancel`), then kills each piece: the Λ⁴ piece against Bianchi, the Kulkarni-Nomizu piece against Ric S = 0. Both are the textbook orthogonality statements.
- **Together with weylProj_isWeylOp this is the orthogonal projection.** P(R) ∈ 𝒲ₙ and R − P(R) ⟂ 𝒲ₙ characterise the projection: two candidates differ by D ∈ 𝒲ₙ with innerOp(D, D) = ½ Σ ‖D φ_ij‖² = 0, so D vanishes on every φ_ij and, being linear, on all of Λ².
- **F1 (scope, no defect).** The layer's operators are functions on all n×n matrices, and IsWeylOp constrains them only on skew inputs. So "the" projection is unique as a map on Λ², and weylProj R off Λ² is an artefact of the encoding. Every quantity the record uses (innerOp, foxTri through `foxTri_congr_on_skew`) reads operators on Λ² only, so nothing downstream depends on it. The record's π_{𝒲ₙ} acts on self-adjoint endomorphisms of Λ², which is the Lean hypothesis set.
- **Hidden restrictions.** weylProj_orth needs no bivector preservation of R, weylProj_isWeylOp needs it, and L234_split assumes it. None excludes the record's Y₀. **The record's Y₀ = u⊙v = ½(uvᵀ + vuᵀ)** ([INDEX-results.md](../findings/INDEX-results.md), row 233) is, as a layer operator, X ↦ ½(⟨v,X⟩U + ⟨u,X⟩V). The scratch file defines it as `odotOp U V`, proves `odot_lin` (IsLinOp), `odot_skew` (skew U, V give bivector-valued), `odot_sym` (self-adjoint), and then instantiates `L234_split hn e _ he (odot_lin U V) (odot_skew U V hU hV) (odot_sym U V)` at arbitrary skew U, V and arbitrary IsWeylOp e. It compiled, EXIT 0. So the theorem is non-vacuous at exactly the record's inputs, and orthonormality of u, v is not needed for step (1). Its Ricci tensor, by hand from the layer's Ric: Σ_c ½(V_ac U_bc + U_ac V_bc) = −½(UV + VU)_ab, the record's h.

## Claim 4, L234Split.lean

- **The statement.** foxTri e Y₀ Y₀ = foxTri e X X + foxTri e N N with X = weylProj Y₀ and N = Y₀ − X, at IsWeylOp e, linear, bivector-preserving, self-adjoint Y₀, n ≥ 3. The record's step (1) reads ⟨X, e∘X⟩ = ⟨Y₀, e∘Y₀⟩ − ⟨N, e∘N⟩, the same identity rearranged.
- **Argument order.** foxTri A B C = innerOp(foxProd A B, C) ([FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) line 293), so foxTri e X X = ⟨e∘X, X⟩ = ⟨X, e∘X⟩ by `innerOp_comm`. e∘X versus X∘e is immaterial, `foxProd_comm` holding with no hypothesis. No sign enters: foxProd is ½(Q(X+Y) − Q(X) − Q(Y)), the record's ∘ verbatim, and T is the record's T.
- **The inputs are the block's.** The cross term is killed by `weylProj_orth` applied to S = e∘X, which is in 𝒲ₙ by `foxProd_isWeylOp` (L209's polarised closure), and it is counted twice through `foxTri2_symm_right` on the restrictions. This is the record's "T fully symmetric, e∘𝒲ₙ ⊆ 𝒲ₙ, N ⟂ 𝒲ₙ". n ≥ 3 is weaker than the record's n ≥ 5, a strengthening.
- **restrictLin agrees with restrict.** Both are `LinearMap.toContinuousLinearMap` of the same toFun X ↦ ⟨R X, _⟩, differing only in proof terms. The scratch file checks `restrictLin hW.1 hW.2.1 = restrict hW.2 := rfl` at every IsWeylOp R, and it compiled.

## Claim 5, axioms

From the scratch run (Lean toolchain v4.33.1, `lake env lean`, one process, none running before):

```
'HamiltonsCubic.Results.weylProj_orth' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.TensorBridge.L234_split' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Claim 6, index rows and the record search

- **F2 (lean/INDEX.md, L234 row, line 172).** Three repairs.
  - Stale: "What it leaves out is the split itself and the Λ⁴ constant, which need an orthogonal projection onto 𝒲ₙ, absent by grep". The same row later says the projection and the split are proved. Repair: "What it leaves out is the Λ⁴ constant and steps (2)-(4)", and delete "absent by grep".
  - Broken sentence: "standard three axioms. and the polarised closure `foxProd_isWeylOp`". Repair: "standard three axioms, and the polarised closure ...".
  - Understated hypotheses: the Ricci-half sentence says "every linear, self-adjoint, first-Bianchi R", and the split sentence says "every linear self-adjoint Y₀". Both theorems also assume R (resp. Y₀) bivector-preserving. Repair: insert "bivector-preserving" in both.
  - The Files column names only I73ProjectedPair.lean. It should also list WeylRicciRemoval.lean, WeylProjection.lean, WeylOrthogonal.lean and L234Split.lean, which the Notes cite.
- **L209 row (line 167)** states Qop_isWeylOp and foxProd_isWeylOp and makes no claim about the projection. Accurate.
- **[second-order.md](../findings/second-order.md) line 198, the L234 Lean paragraph**: accurate. It names the four new files, says step (1) is proved, and "Steps (2)-(4) remain untyped", which matches the files.
- **F3 (stale Lean headers).**
  - [WeylRicciRemoval.lean](../lean/HamiltonsCubic/Results/WeylRicciRemoval.lean) lines 19-20: "Not typed: the Λ⁴ (Alt) removal for operators off first Bianchi, and orthogonality of the removed parts to 𝒲ₙ, which together make the full orthogonal projection." Both now exist. Repair: "Typed elsewhere: the Λ⁴ removal and orthogonality are `weylProj_isWeylOp` in WeylProjection.lean and `weylProj_orth` in WeylOrthogonal.lean."
  - [I73cElimination.lean](../lean/HamiltonsCubic/Results/I73cElimination.lean) line 23: "what it lacks is the corrections Φ, Ω and the projection onto the Weyl module". The projection now exists. Repair: drop "and the projection onto the Weyl module" and point to weylProj, as [I73cGapWeighted.lean](../lean/HamiltonsCubic/Results/I73cGapWeighted.lean) line 22 already does.
- **Scope searched.** `grep -rnI -i` over every `.md` and `.lean` file in the repository, excluding reviews/, agent_logs/, lean/.lake and ATTEMPTS.md, for "projection onto", "orthogonal projection", "weylProj", "absent by grep", "projector", "projection onto the Weyl module", "orthogonality of the removed", "full orthogonal projection" and π_{𝒲ₙ}, filtered by hand for absence or ownership language. Hits outside the three above are about other projections (L223's Z(v), I36's plane projections, L132's spectral projectors) or are record uses of π_{𝒲ₙ} that claim nothing about Lean. The verification/ files quote the record's numerical projector and claim nothing about Lean either.
