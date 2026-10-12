# REVIEW r1638: L267 and the four-block family closure, fidelity audit of I117Four.lean

Log: agent_logs/r1638.log

Standing rule: analysis only. The one computation run is the `#print axioms` check the brief asks for. The n = 9 figure in item 3 is hand arithmetic.

| claim | Lean declaration | verdict |
|---|---|---|
| the four-block family is closed under the sharp, with the record's block equations | sharp_fourOp | CONFIRMED |
| L267, a positive-definite idempotent other than I/(n-2), unstable and heavier | L267_U_fails | CONFIRMED WITH GAPS (G1, G2, G3) |

Axioms: in a scratch file importing HamiltonsCubic.Results.I117Four (both oleans postdate their sources, 12:45 source, 12:51 and 12:52 oleans), `#print axioms` gives [propext, Classical.choice, Quot.sound] for L267_U_fails and for sharp_fourOp.

## Item 1: fourOp is the record's C

- `fourOp e a₊ a₋ aₛ b = coordOp (wSV e aₛ b) + a₊ • projOm e true + a₋ • projOm e false`. `wSV` is 0 on pairs inside the block, `b` on mixed pairs and `aₛ` on pairs outside it, so `coordOp (wSV)` is `aₛPₛ + bP_V` on the coordinate basis `φ_pq` and kills the block's own `φ`'s (`fourOp_phiS`, `fourOp_omS`).
- `projOm e s` is the sum of the rank-one maps `X ↦ ⟨X, ω⟩ω` over three vectors that `omS_inner` proves orthonormal. It is therefore the orthogonal projection onto their span.
- The six vectors `omS e s k` span Λ²(ℝ⁴) of the block, together with the off-block `φ_pq` they span 𝔰𝔬(ι) (`four_sum_change`, `four_expand`, `op_zero_four`), and `fourOp_omS` and `fourOp_phiS` show that C is diagonal on this basis with the record's eigenvalues.
- Orientation. With orientation e₀∧e₁∧e₂∧e₃: \*e₀₁ = e₂₃, \*e₀₂ = −e₁₃, \*e₀₃ = e₁₂. So `s = true` gives the self-dual vectors e₀₁+e₂₃, e₀₂−e₁₃, e₀₃+e₁₂, and `s = false` the anti-self-dual ones. The two halves are the two eigenspaces of \*, as the claim needs. `brS_omS_pm` (they commute) and `brS_omS_01/12/20` (each closes as 𝔰𝔲(2)) confirm this independently of the Hodge convention.
- Verdict for item 1: exact.

## Item 2: the coefficient map of sharp_fourOp

- sharp_fourOp: `(C)# = fourOp (2a₊² + (n−4)b²) (2a₋² + (n−4)b²) ((n−6)aₛ² + 4b²) (3·(a₊+a₋)/2·b + (n−5)·b·aₛ)`, with n = card ι.
- `IsIdem C` is `sharpMapCL C = C`. Matching coefficients gives exactly the record's `2a±² + (n−4)b² = a±` and `(n−6)aₛ² + 4b² = aₛ`. It also gives `b = (3/2)(a₊+a₋)b + (n−5)aₛb`, which is the record's third equation multiplied by b. The record's form presupposes b ≠ 0, and the stated member has b > 0.
- The normalisation matches the record: `sharpMapCL_id` gives I#I = (n−2)I, and sharp_fourOp at (1,1,1,1) returns (n−2)·(1,1,1,1).
- The statement holds for every real coefficient vector and every injective `e : Fin 4 → ι`, with no hypothesis on n. At card ι = 4 or 5 the coefficients of the empty blocks do not matter. It is a statement about operators, not a vacuous one.
- The record's proof has more content than its statement: the invariant family is the whole commutant, and the individual products P±#P_V = ¾P_V and so on are listed. These are proof steps, not part of the statement. They are unformalised, and nothing in the statement depends on them.
- Verdict for item 2: exact.

## Item 3: existential statement vs explicit member

L267_U_fails and L267_core say only that ∃ C, self-adjoint ∧ PD ∧ idempotent ∧ C ≠ I/(n−2) ∧ ¬IsStable ∧ ‖I‖²/(n−2)² < ‖C‖². The proof builds the record's member exactly:

- a₊ = (½ + D)/2 with D = √((n−6)(5n−24)/32)/(n−5), which is the larger root of 2a² − a + (n−4)b² = 0, and a₋ = ½ − a₊, so a₊a₋ = (n−4)b²/2.
- aₛ = 1/(4(n−5)) and b = √(3n−14)/(8(n−5)) > 0.
- `hCn` proves ‖C‖² = (53n²−524n+1296)/(64(n−5)²), and `gap` proves the record's excess 3(n−6)²(7n²−44n+48)/(64(n−5)²(n−2)²). `hI` gives ‖I‖² = n(n−1)/2 = N.
- The destabilising direction is `H = q·H₀ − g·C`, where H₀ = a₋P₊ + a₊P₋ + (1/(n−5))Pₛ + 4bP_V is the record's H exactly, q = ‖C‖² and g = ⟨H₀, C⟩. So H is q times the projection of H₀ off C. `key` proves F(C,H,H) − ½‖H‖² = 9(53n²−524n+1296)(249n⁴−…+123840)/(524288(n−5)⁶). Dividing by q² gives 9(249n⁴−…)/(128(n−5)²(53n²−524n+1296)), which is the record's projected excess. Checked by hand at n = 9: 61389/198656.

Gaps:

- **G1: the export is weaker than the record's statement and weaker than the record's provenance line.** The record states explicit values, the norm and the excess. The staged provenance sentence in findings/second-order.md (L267) says that "the stated member is idempotent, positive definite, other than I/(n−2), heavier, and unstable along the stated direction projected off C, with the projected excess and the norm gap exactly as written." All of this is established inside the proof of L267_core as the local facts `h1`, `hCn`, `gap`, `hHC` and `key`. None of it is in any exported statement. A citer of L267_U_fails gets the existence of some such C, not the record's values, norm, gap or direction. **Recommendation:** make the explicit member the statement. For example, define `L267_C n` and `L267_H n` as the two `fourOp` terms (e = Fin.castLE) and export `IsIdem (L267_C n) ∧ IsPD2 … ∧ normSq2 (L267_C n) = (53n²−524n+1296)/(64(n−5)²) ∧ normSq2 (L267_C n) − N/(n−2)² = 3(n−6)²(7n²−44n+48)/(64(n−5)²(n−2)²) ∧ innerOp2 (L267_H n) (L267_C n) = 0 ∧ Ftri C H H − ½‖H‖² = …`, then derive L267_U_fails from it. The alternative is to narrow the provenance sentence to "proved inside the proof". The first option is better, since every ingredient is already a proved line.
- **G2: the docstring of L267_core names the member** ("the four-block member with a₊ + a₋ = ½, …"), but its type is existential. The docstring describes the proof, not the statement. G1's fix resolves this as well.
- **G3: the idempotent equations are joined to L267 only through the proof.** The record's statement contains the equations. They sit in sharp_fourOp (row 1), and L267_U_fails does not mention the family. This is a minor gap that G1's restatement would close.
- None of these gaps affects the truth of what is exported. The exported claims are the record's qualitative claims, stated faithfully.

## Item 4: ¬IsStable

- `IsStable C := ∀ H, IsSelfAdjoint2 H → innerOp2 H C = 0 → Ftri C H H ≤ ½ normSq2 H`. This is L264 (1)'s wording, and L264 takes its ambient space as Sym²𝔰𝔬(n), the self-adjoint operators, as IsSelfAdjoint2 does.
- `Ftri` is a symmetric trilinear form on self-adjoint operators (`Ftri_symm12/23`, `Ftri_line`), and `Ftri_sharp` ties it to the same `sharpMapCL` through F(C,C,Y) = ⟨C#C, Y⟩. So F(C,H,H) is the polarised ⟨C#H, H⟩, the bilinear form B of L270's proof.
- ¬IsStable ⇔ ∃ H ∈ C⊥ with B(H,H) > ½‖H‖². B is symmetric, and B(C,H) = ⟨C,H⟩ at an idempotent, so C#· preserves C⊥. The condition is therefore the same as the compression of C#· to C⊥ having an eigenvalue above ½, which is the record's wording. L267_core proves the existence direction with an explicit H.
- Verdict for item 4: exact.

## Item 5: docstrings of the new lemmas

- G_form: accurate. Vterm and Eterm depend only on (aₛ, b, X), so a₊ and a₋ enter only through the Λ²± terms and the factor (a₊+a₋)/2 on Vterm.
- vsym: has no docstring. vsym_mixed's docstring says that the Λ²₊ and Λ²₋ triples "move φ_{e a,q} by the same amount". The statement is equality of Σ_k⟨X, [ω^±_k, φ]⟩² for every X, which is equality of the two Gram forms. The wording is loose but claims nothing false. Suggest "have the same Gram form".
- starW_wAll: accurate given the `p ≠ q` hypothesis in the signature, which is essential because starW is nonzero on the diagonal. "r = |ι| − 4" names a symbol absent from the statement (so does sharp_fourOp's docstring). This is cosmetic.
- sharp_fourOp_cc: accurate. It proves more than the docstring says, since the docstring gives no formula.
- fourOp_pd: accurate. It needs all four coefficients positive, and the hypotheses say so.
- idOp_eq_fourOp: has no docstring. The statement I = fourOp 1 1 1 1 is correct because P₊ + P₋ is the identity on the block.
- Ftri_pol': accurate. It needs both operators self-adjoint, and the hypotheses carry that.
- L267_core: overclaims relative to its type (G2).

## Item 6: n = 8

- L267_U_fails and every lemma it uses have only `7 ≤ n`, together with `Function.Injective e` for the lemmas over a general ι. There is no case split at n = 8.
- The record's O(n−4) correction repairs its invariance argument. At n = 8, 𝔰𝔬(4) of the complement is reducible under SO(4). The Lean proof does not use invariance at all: closure is computed directly on the adapted basis (sharp_fourOp), so n = 8 is covered with no extra hypothesis.
- The discriminant (n−6)(5n−24) and 3n−14 are positive from n = 7 onward, and the proof checks this (`hD0`, `hb0`).
- Verdict for item 6: covered.
