# r1890: L226GenB and L226GenC, item 1 of Lemma L226 at every |J| = k

*Gate 2 review of [L226GenB.lean](../lean/HamiltonsCubic/Results/L226GenB.lean) (commit a4346dd1) and [L226GenC.lean](../lean/HamiltonsCubic/Results/L226GenC.lean) (commit 27ab01d7), which with [L226GenA.lean](../lean/HamiltonsCubic/Results/L226GenA.lean) ([r1886](REVIEW_r1886.md)) move Lemma L226's row in [lean/INDEX.md](../lean/INDEX.md) to proved. Analysis-only footing: the one computation is an exact rational screen of seconds, reported as a screen. The Lean statements are faithful to item 1 on the block form, every block sum was rederived by hand from the bracket table and agrees, the kernel reports the standard three axioms, and one stale sentence in the record's Lean note contradicts the new state.*

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `sharpPair_opOf`: ⟨C, C#⟩ = ⅛ Σ_{ijkl} ⟨C[Cφ_ij, Cφ_kl], [φ_ij, φ_kl]⟩ | CONFIRMED |
| 2 | `split_even`, `sharp_split`: multiplicities 1,2,1,2,4,2,1,2,1 | CONFIRMED |
| 3 | The nine block sums | CONFIRMED |
| 4 | `Pcubic_blockOpG` states item 1 as the record does, hypotheses faithful, agrees with k = 3 | CONFIRMED WITH OBSERVATIONS |
| 5 | `trRL2_eq`: trRL2 is tr(R_J Λ²M) | CONFIRMED |
| 6 | The untyped step from W ∈ S_J to the block form, and marking L226 proved | CONFIRMED WITH OBSERVATIONS |
| 7 | Axioms and a concrete screen | CONFIRMED |
| 8 | The INDEX row and the record's Lean note | CONFIRMED WITH OBSERVATIONS |

**Summary.** Item 1 is kernel-checked at every k on the block form with the record's coefficients, and the only defect found is the sentence "Owed in Lean: items 1 and 2 at $k\ne3$" left standing in the record's Lean note (O1).

## Conventions

- Base layer ([Base/WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)): `inner2 X Y = ½ tr(XᵀY)`, `br X Y = XY − YX`, `phi i j = E_ji − E_ij`, so ⟨φ_ij, φ_ij⟩ = 1 for i ≠ j. `innerOp R S = ½ Σ_{ij} ⟨Rφ_ij, Sφ_ij⟩` (ordered pairs, halved), `trCube R = innerOp (R∘R) R`, `sharpPair R = innerOp R (sharpOp R)`, `Pcubic = trCube + sharpPair`.
- `opOf C X = ¼ Σ_{ijkl} ⟨X, φ_ij⟩ C_ijkl φ_kl`, with `pairing` giving ⟨(opOf C)φ_ab, φ_cd⟩ = ¼(C_abcd − C_bacd − C_abdc + C_badc).
- `phiTri A B C = −¼ Σ_{ijkl} ⟨B[Aφ_ij, Cφ_kl], [φ_ij, φ_kl]⟩` ([PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean)) and `sharpPair2_eq_phiTri`: sharpPair2 R = −½ phiTri R R R.
- The record's objects: J of size k, A of size m, V_a identified with ℝ^J by x ↦ Σ x_p φ_pa, x∧y = Σ x_p y_q φ_pq, (M_a)_pq = W_{pa,qa}, Wφ_ab = K_ab φ_ab, Λ²M: x∧y ↦ Mx∧My.

## Hypothesis inventory

`Pcubic_blockOpG` (checked with `#check`):

- `IsCurvArray R`: R_qprs = −R_pqrs, R_pqsr = −R_pqrs, R_rspq = R_pqrs. No Bianchi. This is exactly "R_J a symmetric operator on Λ²ℝ^J" written in the array ⟨R_J φ_pq, φ_rs⟩ = R_pqrs, and item 1 is a statement on all of S_J, so the absence of Bianchi is correct.
- `∀ a, (M a).IsSymm`: the record's M_a symmetric.
- `K a b = K b a` and `K a a = 0`: the record's K_ab is defined for a ≠ b, and K_ba = K_ab is forced by φ_ba = −φ_ab. `blockCoeffG` reads K only under `a ≠ b`, and the right side reads it only at a < b, so the zero diagonal is a normalisation that excludes no block operator (O2).
- No hypothesis on k or m. The record has k ≥ 2, and the Lean theorem also covers k = 0, 1, where it is trivially consistent.

## 1. sharpPair_opOf

The proof is `extend_opL`, `sharpPair_extend`, `sharpPair2_eq_phiTri`, then −½ · (−¼ x) = ⅛ x and `rfl` against `phiTri`'s body. So the normalisation is inherited from the layer's own `sharpPair`, and the theorem is about the layer's definition rather than a restatement of it. Hand check of the factor: in an orthonormal eigenbasis v_α (α indexing pairs i < j), Σ_{α,β} ⟨W[λ_α v_α, λ_β v_β], [v_α, v_β]⟩ = Σ λ_αλ_βλ_γ c²_{αβγ} = 2⟨W, W#⟩ by the record's step 1. The ordered sum over (i, j) visits each basis element twice with sign squared away in each slot, so Σ_{ijkl} = 4 Σ_{αβ} = 8⟨W, W#⟩, which is ⅛. **CONFIRMED.**

## 2. split_even and sharp_split

`split_even` splits Σ over i, j ∈ J ⊔ A by `Fintype.sum_sum_type` into four blocks and maps the (a, p) block onto the (p, a) block through `phi_swap` and evenness F(−X) = F(X). So J-pairs count once, mixed pairs twice, A-pairs once. `QG_neg_left` and `QG_neg_right` hold because Q is bilinear in the first operand pair and bilinear in the bracket pair, two sign flips per slot. Applying the split to the inner sum and then to the outer gives the product of (1, 2, 1) with itself: JJ·JJ 1, JJ·JA 2, JJ·AA 1, JA·JJ 2, JA·JA 4, JA·AA 2, AA·JJ 1, AA·JA 2, AA·AA 1. `sharp_split` carries exactly these coefficients. **CONFIRMED.**

## 3. The block sums

Brackets from `br_phi_phi`: [φ_ab, φ_cd] = δ_ac φ_bd + δ_bd φ_ac − δ_ad φ_bc − δ_bc φ_ad. Block actions from `pairing`: Wφ_pq = ½ Σ R_pquv φ_uv, Wφ_pa = Σ_w (M_a)_pw φ_wa, Wφ_ab = K_ab φ_ab (the last two at symmetric M and K, `blockOpG_M`, `blockOpG_K`).

**S_JAJA, by hand.** At a = b: [φ_pa, φ_qa] = φ_pq and [Wφ_pa, Wφ_qa] = Σ (M_a)_pu (M_a)_qv φ_uv, so Q = Σ (M_a)_pu (M_a)_qv R_uvpq, and Σ_{pq} of it is Σ R_pquv (M_a)_pu (M_a)_qv = Z(R, M_a) by pair symmetry. At a ≠ b: [φ_pa, φ_qb] = δ_pq φ_ab and [Wφ_pa, Wφ_qb] = (M_aM_b)_pq φ_ab, so Q = δ_pq K_ab (M_aM_b)_pq, summing to K_ab tr(M_aM_b). Total Σ_a Z + Σ_{a≠b} K_ab tr(M_aM_b). Agrees with `QG_JA_same`, `QG_JA_diff`, `S_JAJA`.

**S_JJJA, by hand.** Self-adjointness moves W: Q(φ_pq, φ_ra) = ⟨[Wφ_pq, Wφ_ra], W[φ_pq, φ_ra]⟩. Here [φ_pq, φ_ra] = δ_pr φ_qa − δ_qr φ_pa, so W[φ_pq, φ_ra] = δ_pr Σ_w (M_a)_qw φ_wa − δ_qr Σ_w (M_a)_pw φ_wa. Also Wφ_ra = Σ_s (M_a)_rs φ_sa, and ⟨[Wφ_pq, φ_sa], φ_wa⟩ = ½ Σ R_pquv (δ_us δ_vw − δ_vs δ_uw) = R_pqsw (this is `LJ_br_inner`). Summing r collapses the deltas to Σ_s (M_a)_ps Σ_w (M_a)_qw R_pqsw − Σ_s (M_a)_qs Σ_w (M_a)_pw R_pqsw. Over p, q the first is Z(R, M_a), and the second, after renaming p ↔ q and using R_qpsw = −R_pqsw, is −Z. Total 2 Σ_a Z. Agrees with `QG_JJ_JA`, `Zs_direct`, `Zs_swap`, `S_JJJA`.

**S_AAAA, by hand.** Q(φ_ab, φ_cd) = K_ab K_cd ⟨W X, X⟩ with X = [φ_ab, φ_cd]. When {a, b} and {c, d} share one index exactly one delta survives and ⟨WX, X⟩ is the K of the remaining pair. When they share two, X = 0, and the four-term formula of `KK_pairG` gives 0 there too since every surviving term reads a diagonal K. Each of the four delta terms sums to Σ_{abd} K_ab K_ad K_bd, total 4T.

**S_JAAA, by hand.** At c = b: [φ_pb, φ_ab] = φ_pa, and [Wφ_pb, Wφ_ab] = K_ab Σ_u (M_b)_pu φ_ua, whose image under W paired with φ_pa is K_ab (M_bM_a)_pp. The case c = a is symmetric. Per ordered a ≠ b the sum over p is 2K_ab tr(M_aM_b). **S_JJAA** vanishes because Λ²ℝ^J and Λ²ℝ^A commute (no shared index), `br_JJ_AA`. **S_JJJJ** reduces to the layer's sum on `Fin k` through `emb` (r1886's `blockOpG_emb`, `br_emb`, `inner2_emb`) and then to 8⟨R_J, R_J#⟩ by claim 1 at κ = Fin k.

**Assembly.** With multiplicities: 8⟨R,R#⟩ + 2·2ΣZ + 0 + 2·2ΣZ + 4(ΣZ + Σ_{a≠b}K tr) + 2·2Σ_{a≠b}K tr + 0 + 2·2Σ_{a≠b}K tr + 4T = 8⟨R,R#⟩ + 12ΣZ + 12Σ_{a≠b}K tr + 4T, which is `sharp_formula`. Divided by 8: (3/2)ΣZ = 3Σ trRL2, (3/2)Σ_{a≠b} = 3Σ_{a<b}, and ½T = 3Σ_{a<b<c} since T counts each triangle 6 times at zero diagonal (`tri6`). These are item 1's three coefficients 3. **CONFIRMED.**

## 4. Pcubic_blockOpG against item 1

The printed statement is P(blockOpG R M K) = Pcubic(opOf R) + Σ_a (tr M_a³ + 3 trRL2 R M_a) + Σ_{a<b} (K_ab³ + 3K_ab tr(M_aM_b)) + 3 Σ_{a<b<c} K_ab K_ac K_bc, term for term the record's display. Pcubic(opOf R) is the layer's P on 𝔰𝔬(k), the record's P(R_J) = tr R_J³ + ⟨R_J, R_J#⟩ (r1886 O1 covers the trCube half at a pair-symmetric array). `blockCoeffG` is faithful to the block form: `pairing` gives ⟨Wφ_pq, φ_rs⟩ = R_pqrs, ⟨Wφ_pa, φ_qa⟩ = ¼(4M_a,pq) = (M_a)_pq, ⟨Wφ_ab, φ_ab⟩ = K_ab, and zero across blocks and across distinct a. So every block-form W is some `blockOpG R M K` with the stated hypotheses, and conversely.

**Agreement at k = 3.** With R_pqrs = Σ ε_pqx ε_rsy S_xy (the `blockCoeff` of [L226Statement.lean](../lean/HamiltonsCubic/Results/L226Statement.lean)), ½Z(R, M) = ½ Σ S_xy Σ ε_pqx ε_rsy M_pr M_qs = Σ S_xy adj(M)_xy = tr(S adj M) at symmetric M, and Pcubic(opOf R) = tr S³ + 3 det S. So `Pcubic_blockOpG` at k = 3 is `blockP`, and the two theorems agree. Both identities were checked exactly in the screen of section 7. There is no Lean lemma identifying `blockOp S M K` with `blockOpG (Rε S) M K`, so the agreement is by computation here and not a kernel fact (O3). **CONFIRMED WITH OBSERVATIONS.**

## 5. trRL2_eq

`lam2_phi`: Mφ_pqMᵀ = Σ_{sw} M_sp M_wq φ_sw. Since φ_pq = e_p∧e_q in the record's x∧y = Σ x_p y_q φ_pq, and Me_p = Σ_s M_sp e_s, the right side is Me_p∧Me_q, so X ↦ MXMᵀ is the record's Λ²M on the basis and hence everywhere by linearity. The trace over Λ²ℝ^J in the orthonormal basis {φ_pq : p < q} is Σ_{p<q} ⟨Tφ_pq, φ_pq⟩, and the ordered sum doubles it (the diagonal terms vanish since φ_pp = 0, and (q, p) repeats (p, q) with both signs flipped), so ½ Σ over ordered pairs is the trace. `trRL2_eq` computes ½ Σ M_sp M_wq R_swpq, which after renaming is ½Z. So trRL2 = tr(R_J ∘ Λ²M), matching the record's step 3 value 3 tr(R_J Λ²M_a). **CONFIRMED.**

## 6. The untyped step to the block form

The Lean theorems quantify over `blockOpG R M K`, and the passage from "W ∈ S_J, the H_J-fixed symmetric operators" to that shape is the block note's character argument, untyped. The INDEX row states this in its closing hypotheses sentence ("the step from $W\in\mathcal S_J$ to the block form is the block note's argument, untyped (r1864 O1)"), and GenC's docstring says the same. The record's Setting presents the block form as a cited input ("By the block note, W ∈ S_J is block-diagonal ... "), and item 1's proof starts from it. So what L226 itself derives is exactly what Lean checks, and marking the row proved is acceptable with the caveat stated in the row. The findings note's header says "kernel-checked at every k on the block form", which also carries the scope, but less explicitly than the row (O4). **CONFIRMED WITH OBSERVATIONS.**

## 7. Axioms and a screen

`lake env lean` on a scratch file importing `L226GenC`, run with no other lake process alive: `Pcubic_blockOpG`, `trRL2_eq`, `sharp_formula`, `sharpPair_opOf`, `sharp_split`, `S_AAAA` each depend on [propext, Classical.choice, Quot.sound]. Neither file contains `sorry`. The working tree matches commits a4346dd1 and 27ab01d7 for both files, and both are imported by [lean/HamiltonsCubic.lean](../lean/HamiltonsCubic.lean).

**Screen** (seconds, exact `Fraction` arithmetic, objects constructed here, a screen and no evidence by itself). The script builds the full operator on Λ²ℝ^n in the orthonormal basis φ_ij (i < j) from random rational R (from a random symmetric matrix on Λ²ℝ^k, so `IsCurvArray` holds), symmetric M_a and symmetric K with zero diagonal. It takes structure constants from matrix commutators and computes P by the record's index formula ⟨W, W#⟩ = ½ Σ c c W W W, independently of Lean. Item 1's right side, with P(R_J) computed the same way on Λ²ℝ^k, matched exactly at (k, m) = (2, 2), (2, 3), (3, 2), (3, 3), (4, 2), for example P = −76937/1728 on both sides at (3, 3). The direct trace of R_J ∘ Λ²M_a (Λ²M_a as the matrix ⟨Mφ_bMᵀ, φ_a⟩) equalled ½Z in every case. Replacing the coefficient 3 by 2 on the trRL2 term moved the value by −341/32, 6691/432, 1361/16, 99/2 at the last four sizes (by 0 at (2, 2), where the draw made Σ_a Z vanish, so that size does not discriminate the coefficient). At k = 3 with the ε array, ½Z = tr(S adj M) = −65/2 and P(R_J) = tr S³ + 3 det S = −19577/216. **CONFIRMED.**

## 8. The INDEX row and the Lean note

The [lean/INDEX.md](../lean/INDEX.md) L226 row describes parts A, B and C accurately: the nine sums, their values, `sharp_formula`'s constants 12, 12, 4, `Pcubic_blockOpG`, `trRL2_eq` and `lam2_phi`, the hypotheses, and the untyped step. In the row's body, part C's link text is the full path HamiltonsCubic/Results/L226GenC.lean where parts A and B use the bare file name, a cosmetic inconsistency (O5). The [findings/second-order.md](../findings/second-order.md) L226 note's italic header was updated to name `Pcubic_blockOpG` and `trRL2_eq`, but its **Lean.** paragraph still ends with "Owed in Lean: items 1 and 2 at $k\ne3$.", which is now false for both items (O1). **CONFIRMED WITH OBSERVATIONS.**

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `Pcubic_blockOpG` states item 1 of L226 on the block form at every k with the record's objects and coefficients, the proof rests on the layer's own `sharpPair` and the standard three axioms, and every block sum agrees with a hand derivation from the bracket table. The row may stand as proved with its stated caveat. The record's Lean note needs the stale sentence removed.

## Observations

- **O1.** [findings/second-order.md](../findings/second-order.md), L226 **Lean.** paragraph: "Owed in Lean: items 1 and 2 at $k\ne3$." contradicts the note's own header and the INDEX row. Replace with a sentence naming `isWeyl_blockOpG_iff` and `Pcubic_blockOpG` as items 2 and 1 at every k on the block form.
- **O2.** The hypothesis `K a a = 0` excludes no operator: `blockCoeffG` and the right side of `Pcubic_blockOpG` never read the diagonal of K. Harmless, and worth one clause in the docstring so a consumer does not think it a restriction.
- **O3.** No kernel lemma identifies `blockOp S M K` with `blockOpG` at the ε array. The k = 3 and general theorems agree by the computation of section 4 and the screen. A lemma `blockOp_eq_blockOpG` would let consumers of L227 and L228 (built on `blockOp`) cite the general file directly. Optional.
- **O4.** The note's header could state the untyped block-form step as the row does, for a reader who meets the note without the row.
- **O5.** The INDEX row's body links part C as [HamiltonsCubic/Results/L226GenC.lean] while parts A and B link the bare file name. Cosmetic.

## What would falsify the claims

A symmetric R_J on Λ²ℝ^k (Bianchi or not), symmetric blocks M_a and a symmetric K for which the directly computed P of the assembled operator differs from item 1's right side, or a block-form operator not expressible as `blockOpG` under the stated hypotheses. I looked for the first by deriving four of the nine block sums and the assembly by hand and by the exact screen at five (k, m) sizes including k = 2 and k = 4, and for the second by checking `blockCoeffG`'s pairings entry by entry against the Setting's (M_a)_pq = W_{pa,qa} and Wφ_ab = K_ab φ_ab. Neither turned up.
