# REVIEW r1621: I117Statements L260, L265, L266 against the record

Reviewer r1621, one-reviewer Gate 2 round, analysis only. File [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) at HEAD 6459344d, read against [second-order.md](../findings/second-order.md) Lemmas L260, L265, L266 and the [lean/INDEX.md](../lean/INDEX.md) rows. One screen of a few seconds was run (numpy under Sage, n = 3 and 4, random operators), reported as a screen only.

| claim | verdict |
|---|---|
| C1 L260 (4) | CONFIRMED WITH GAPS |
| C2 L265 positivity | CONFIRMED |
| C3 L266 (1) | CONFIRMED WITH GAPS |
| C4 index rows | CONFIRMED WITH GAPS |

## C1. L260_trace_bound

- **Typed form matches.** The statement is `(n-2) * innerOp2 C idOp ≤ normSq2 idOp` and `= → C = (1/(n-2)) • idOp`, under `IsSelfAdjoint2 C`, `IsPD2 C`, `IsIdem C`, `3 ≤ n`.
- **innerOp2 C idOp is tr C.** `innerOp2 R S = ½ Σ_{i,j} inner2(R φ_ij, S φ_ij)` ([Bivectors2.lean:279](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279)). With `φ_ij = E_ji − E_ij`, `φ_ii = 0` and `φ_ji = −φ_ij`, the ordered sum is twice the sum over `i<j`, and `inner2(φ_ij, φ_ij) = ½ tr(φᵀφ) = 1`, so `{φ_ij}_{i<j}` is orthonormal and `innerOp2 R S = tr(RᵀS)`. At `S = I` this is `tr C`.
- **normSq2 idOp is N**, the same computation at `R = S = I`.
- **K and d at so(n).** so(n) is simple for n ≥ 3, so one ideal, `Π = I`, `d = N`, and `c = n−2` by `sharpMapCL_id` (`I # I = (n−2) I`), matching the record's L265 value `n−2`. So `tr(CK) = (n−2) tr C` and `⊕Π_i/c_i = I/(n−2)`.
- **casimir_row** states `Σ_{β,γ} ⟨b_β, [b_δ, b_γ]⟩² = 2(n−2)`, the record's row sum `2⟨Ku_k,u_k⟩` at `K = (n−2)I`. Hand check at n = 3 on `φ_12, φ_13, φ_23`: `[E_12−E_21, E_13−E_31] = E_32 − E_23`, a unit vector, so each row has two unit entries, sum 2 = 2(3−2).
- **trace_eq_of_pairing** is the record's equality mechanism (every weighted triple has equal λ), stated at the scalar level with the right hypotheses.
- **Gap 1 (minor).** The record's "equality exactly at" is an iff. The theorem types only equality ⇒ `C = I/(n−2)`. The converse (that `I/(n−2)` is a PD idempotent attaining equality) follows at once from `sharpMapCL_id` and the trace computation but is not part of the statement.
- **Gap 2 (minor).** The docstring names so(n) ("at a positive definite idempotent of so(n) itself"). The row names it ("at h = so(n)"). Both are clear.
- **Screen.** `I # I = (n−2)I`, `I/(n−2)` idempotent with `(n−2) tr = N`, and `innerOp2 = tr(RᵀS)` all held at n = 3, 4.

## C2. L265_cp

- **sharpB is the polarised product.** `sharpB A B = ½(S(A+B) − S A − S B)` with `S = sharpMapCL`, which is quadratic in `R` (it is built from `crossPair2 R X Y = −¼ Σ ⟨[X, R[Y, Rφ]], φ⟩`). So `S(A+B) = A#A + 2A#B + B#B`, giving `sharpB A B = A#B`, and `sharpB A A = ½(4S A − 2S A) = S A = A#A`.
- **The typed claim is positivity.** `IsPSD2 C ∧ IsPSD2 X` (both self-adjoint) ⇒ `IsPSD2 (sharpB C X)`. This is positivity of `C#·` on the PSD cone. Complete positivity is not typed, and the docstring says so: "The record's complete positivity is the stronger statement and is not typed here."
- **Screen.** At n = 3, 4 with random PSD `C, X`, the symmetric part of `sharpB C X` had positive least eigenvalue, and `sharpB A A = A#A` held.

## C3. L266_orbit_tangent and phiTri_der

- **orbitTangent is [ad_X, C].** `orbitTangent C X = (adS X).comp C − C.comp (adS X)`, with `adS X Y = [X, Y]`, which is `ad_X C − C ad_X`, the infinitesimal conjugation action on End(h). `derOp X R` is the same expression and `orbitTangent C W = derOp W C` is `rfl`.
- **phiTri_der** states `Φ(DA,B,C) + Φ(A,DB,C) + Φ(A,B,DC) = 0` with `D = derOp X = [ad_X, ·]`, the infinitesimal invariance. Hand test at n = 3, `A = B = C = I`: `D I = ad_X − ad_X = 0`, and Φ is linear in each slot, so each term is 0 and the identity reads 0 = 0. That test is vacuous. **Screen** at random `A, B, C, X`, n = 3 and 4: residuals 2e−16 and 3e−14 against Φ values of order 5 and 39.
- **The self-adjointness hypothesis.** It is the typing of the record's setting and adds no weakening: the record's idempotents live in Sym² h, and the proof uses `IsSelfAdjoint2` only through the symmetries of `F` on Sym².
- **Gap (minor).** The docstring reads "At every #-idempotent". The row reads "at every idempotent of so(n)". Neither names the self-adjoint hypothesis. The record states L260 (1) on End(so(n)), so the two settings coexist in the record and the hypothesis should be named. Suggested docstring: "At every self-adjoint `#`-idempotent (an idempotent of Sym² so(n))".
- **Restriction to so(n)** is named in the docstring ("L266 (1) on so(n)") and in the row.

## C4. lean/INDEX.md rows L260, L265, L266

- **Existence and sorry-freeness.** `L260_trace_bound` (line 3207), `casimir_row` (3167), `trace_eq_of_pairing` (3100), `L265_cp` (3327), `phiTri_der` (3488) and `L266_orbit_tangent` (3592) all exist with tactic proofs. Every `sorry` in the file sits at or before line 2592. The parent's axiom audit (standard three) was taken as given.
- **Stale sentence, L260 row.** "Not stated at the scalar level: the singular value expansion of F, the range argument and the equality case". The equality case is now stated at the scalar level as `trace_eq_of_pairing`, and the range argument is proved at operator level as `L260_range_subalgebra`. Correction: drop "the equality case" from that sentence, or mark it superseded.
- **Stale sentence, L266 row.** "Not stated: that ad acts by derivations of # on Sym² h". `phiTri_der` / `Ftri_der` now type the infinitesimal invariance of `F`, which is that derivation property read through the pairing. Correction: mark it superseded by `phiTri_der`.
- **L266 row** omits the self-adjoint hypothesis (see C3).
- **L265 row** is accurate: `L265_cp` PROVED, complete positivity prose, `L265_I_sharp` `sorry` (line 2023, confirmed).

## Outside the brief, noted for the owning loop

- The record's provenance line for L266 in [second-order.md](../findings/second-order.md) still says "Part (1) is typed in I117LemmaF.lean as `orbit_tangent_F` ...". It does not mention `L266_orbit_tangent`. The L265 provenance line likewise omits `L265_cp`.
- The L260 provenance line says "the whole lemma is machine-checked at h = so(n) and self-adjoint X". The INDEX row is more careful: (3) is typed in the direction H needs, and (4)'s converse is untyped (C1 gap 1). "Every typed clause" is the accurate wording.
