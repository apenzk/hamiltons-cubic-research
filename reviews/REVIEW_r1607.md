# Review r1607: I117Statements.lean (commit c40e14fb) against L254 and L260 to L273

**Log:** [agent_logs/r1607.log](../agent_logs/r1607.log) (this review was dispatched as r1604 and renumbered by the coordinator).

**Standfirst.** The layer's objects are the record's: `Ftri` is F on self-adjoint arguments, `torusOp` reproduces L271 (1) and L268's idempotency in an independent screen, `coordOp` is L261's family and `StatementH` carries κ_n = (n-2)/√N. Twenty-eight of the thirty theorem statements say what the record says or a named weakening of it. **One statement is wrong: `L273_J1_implies_H` types J1 on the sphere ¼(‖P‖² + ‖Q‖²) = 1 where the record has b² = ½(‖P‖² + ‖Q‖²) = 1, and the hypothesis so typed is false at the uniform point, so the theorem is vacuous.** `L264_not_simple_unstable` states more than the record's (2), because its split hypotheses admit decompositions that are not ideal splits. The INDEX rows are honest except where they inherit these two and in three smaller places.

| claim | verdict | reason in one line |
|---|---|---|
| D1. `Ftri`, `torusOp`, `coordOp`, `StatementH` are the record's objects | **CONFIRMED** | Ftri = ⟨A, B#C⟩, which is F(A,B,C) by full symmetry on self-adjoint arguments; torusOp matches L271 (1) and L268 in a screen; coordOp is the identity-weighted L261 family; κ_n matches L259 |
| S1. Each theorem states the record's claim | **REFUTED in one row, with corrections** | `L273_J1_implies_H`'s J1 has the constant ¼ for ½ and is false at μ ≡ const; `L264_not_simple_unstable` is stronger than the record; the rest faithful or honestly weaker |
| S2. The fifteen INDEX rows are honest | **CONFIRMED WITH GAPS** | L273 row inherits the J1 defect; L265 row calls positivity "complete positivity"; L271 row calls an identity "(4)"; L264 row presents a pre-composed hypothesis as (3) |
| P1. Proved declarations say what their docstrings claim | **CONFIRMED** | L270_so, L271_pq_system, sharpMapCL_id, the Ftri and torusMat lemmas match; L270_so's docstring omits the `c ≤ 0` disjunct |

## D1. The layer's objects

- **`Ftri A B C = -½ phiTri A B C`.** `innerOp2_sharpMap_eq_phiTri` gives ⟨S, R#R⟩ = -½ Φ(S; R, R) at every S and R, so `Ftri A B B = ⟨A, B#B⟩` and, polarised, `Ftri A B C` is ⟨A, B#C⟩. On self-adjoint arguments F is fully symmetric (`Ftri_symm12`, `Ftri_symm23`), so this is the record's F(A,B,C) = ⟨A#B, C⟩. Every use of `Ftri` in the file has self-adjoint arguments (the orbit tangents [ad_X, C] are self-adjoint when C is) except `L260_psd_cone`, which uses only the diagonal `Ftri X X X = ⟨X, X#X⟩`, the record's F(X).
- **`idOp`, the norm.** `inner2 = ½ tr(XᵀY)` makes the φ_ij orthonormal, so `normSq2 idOp = N` and `innerOp2 idOp C = tr C`. `sharpMapCL_id` gives I#I = (n-2)I, the record's c on so(n).
- **`torusOp A U V`.** On a diagonal 2×2 block a skew matrix is x_k J, and the output is (Σ_k A_ik x_k) J with J unit, so A acts on the Cartan in an orthonormal basis. On an off-diagonal block, `cPart B = ½(B - JBJ)` is the J-commuting part (J⁻¹ = -J), which transforms as R(θ_i) B R(θ_j)⁻¹ = B R(θ_i - θ_j), the root ε_i - ε_j, so U_ij = μ(ε_i - ε_j) and V_ij = μ(ε_i + ε_j) as the docstring says. With U and V symmetric the pre-skew output is already skew (cPart and aPart commute with transposition), so `skewPartM` changes nothing. `Amu` has diagonal d_i and off-diagonal V² - U² = -P_ij Q_ij, matching L271 (2) and L268's 2Σμ² u uᵀ.
- **Screen** (seconds, [curvature_operator.py](../scripts/lib/curvature_operator.py), independent of the author's): at random symmetric A and pair weights, m = 3, 4, torusOp is self-adjoint and reproduces L271 (1)'s norm and F exactly. At 62 solutions of `TorusSystem` with Q ≠ 0 (m = 3, found by Newton, some with zero or negative weights), torusOp(A_μ) is idempotent, perturbing A by 0.01 I breaks it, and L271_split's three conjuncts hold. A random non-solution is not idempotent. This is a screen, not evidence for the sorry'd statements.
- **`coordOp a`**: with a symmetric, a ⊙ X is skew for skew X, so `coordOp a` multiplies φ_ij by a_ij, the record's Σ a_ik e_ik e_ikᵀ.
- **`StatementH`**: F(X) ≤ κ_n (‖X‖²)^{3/2} for self-adjoint X, κ_n = (n-2)/√(n(n-1)/2). This is L259's statement H on Sym² so(n). **The record says H is false for 4 ≤ n ≤ 8**, so `StatementH` is a false proposition at those n. No theorem asserts it unconditionally there (see L260 (3) below).

## S1. The theorems

| declaration | result and part | faithful? | issue |
|---|---|---|---|
| `L254_conjA_12` | L254 | yes, weaker | Upper bound only; attainment at S⁶×S⁶ and M(12) = Θ₁₂ dropped. Θ₁₂ = √55/6 correct (θ(S⁶×S⁶)² = 2·11·25/(10·36) = 55/36). The identification of the certificate's ⟨Q(R),R⟩ with `Pcubic2` is owed, as L254.lean says. |
| `L260_psd_cone` | L260 (1) | yes, weaker (existence form, named) | The mechanism F(X) ≤ ½(F(\|Xᵀ\|) + F(\|X\|)) is replaced by ∃ PSD Y of equal norm with F(X) ≤ F(Y), which it implies. Screen: under the layer's F the record's inequality held at 120 random non-symmetric X, n = 4, 5. |
| `L260_range_subalgebra` | L260 (2) | yes, weaker | "Semisimple" typed as perfect, equivalent for compact subalgebras. "C is an idempotent of h's own #" is not typed. |
| `L260_H_of_norm_bound` | L260 (3), one direction | yes | hn is 3 ≤ n where the record says n ≥ 9. The implication is true at every n ≥ 3 (maximiser PSD by (1), C = X/F(X) PSD idempotent, ‖C‖² = F(X)⁻²), so at 4 ≤ n ≤ 8, where H is false, the hypothesis is false and the theorem vacuous. Harmless. |
| `L260_trace_bound` | L260 (4) at h = so(n) | yes, instance | Only h = so(n) and only equality ⇒ C = I/(n-2). Correct also at n = 4, where K = 2I. |
| `L261_coord_diag` | L261 | yes | hn : 3 ≤ n added, harmless. |
| `L262_son` | L262 at so(n-1) ⊂ so(n) | yes, instance | The four solutions follow from (C#C)_ik = Σ_j a_ij a_jk: (n-3)a² + b² = a, (n-2)ab = b. Screened at n = 5, 6, 7 (all four idempotent). n ≥ 5 excludes the non-simple so(4). |
| `L263_g2` | L263, last clause | yes, weaker (existence form) | so(7)'s # restricted to operators on h is h's own # (the formula involves only brackets in h), and with the restricted metric g₂ has c = 4, so the reading is right. The existential drops SU(3), the coefficients 9/28, 3/28 and the norms 351/392 and 7/8, and does not pin c. The row names this. |
| `L264_maximiser_stable` | L264 (1) | yes | hpos : 0 < F(X) is a hypothesis the record derives. PSD of X dropped, which is correct since idempotency and stability hold at any maximiser. "PD on its semisimple support" not typed. |
| `L264_not_simple_unstable` | L264 (2) | **no, stronger** | The hypotheses do not make D₁, D₂ the parts of C on two ideals. Counter-construction: take v ≠ 0 in h⊥ commuting with h = range C, w ≠ 0 orthogonal to h and v, E = v⟨w, ·⟩, D₁ = C + E, D₂ = -E. Then D₁D₂ = D₂D₁ = 0, both are nonzero, and [D₁X, D₂Y] = 0, for any C whose range has such a centraliser (a block so(k) in so(n), n ≥ k + 2). The theorem then asserts ambient instability of every such C, which the record does not claim. Truth unknown. **Correction:** add `IsSelfAdjoint2 D₁` and `IsSelfAdjoint2 D₂`. Then range C = range D₁ ⊕ range D₂ orthogonally with commuting parts, and each part is an ideal of range C. |
| `L265_I_sharp` | L265 at so(n) | yes, instance | I#W = -W checks against c - Cas_V/4 with Cas(2ε₁+2ε₂) = 4n-4. The Λ⁴ eigenvalue 2 ≤ (n-2)/2 gives stability from n ≥ 6, so n ≥ 7 is safe. The general-h scalar and the algebra list are not typed. |
| `L265_cp` | L265, first clause | weaker than its name | Types positivity (PSD ↦ PSD), where the record claims complete positivity. |
| `L266_orbit_tangent` | L266 (1) | yes | (2) not typed. u_X = [ad_X, C] is self-adjoint, so `Ftri` is F. |
| `L267_U_fails` | L267 | yes, weaker (existence form) | Drops the explicit a±, a_s, b and the norm formula. The row does not name the existence form. |
| `L268_torus_idem` | L268 with L271 (2) | yes | Positivity dropped, which is L271 (2)'s form. The screen confirms the "if" direction at non-positive solutions and failure off the system. |
| `L268_torus_pd` | L268, PD half | yes | True without the system: root part positive, and A_μ = 2Σμ² u uᵀ is PD once every root has a positive weight. |
| `L268_uniform` | L268, last clause, "if" | yes | Checked by hand: both equations reduce to u(m-2)/(m-1) = 2(m-2)u². |
| `L269_phi_test` | L269 | yes, weaker | Φ, W, R, x, y, q all correct (x, y as ½Σ_{i,j} are sums over positive roots). "Eigenvalue above ½ on C⊥" as ∃ H is equivalent, C⊥ being C#·-invariant at an idempotent. Eigenvector location and Φ = 0 at I/c dropped. |
| `L270_so` | L270 (1), (2) | yes | Proved. The fifth conjunct adds `∨ c ≤ 0` for n ≤ 2. λ_I as a ratio and the eigenvector property are not stated, but both follow from the conjuncts and `Ftri_idem`. |
| `L270_H_of_Us'` | L270 (3) / L264 (3) | yes, weaker | The hypothesis asks every stable PSD idempotent on so(n) for the ambient bound N/(n-2)², so L256 and the reduction to simple h are pre-composed into it. With that hypothesis the conclusion follows from L260 (1) and L264 (1) alone, so the typed theorem does not carry the record's reduction to U_s' on simple subalgebras. |
| `L270_torus_light` | L270 (4) | yes | c = 2m-2, ‖I‖² = m(2m-1), value m/(4(m-1)) correct. |
| `L271_F_slice` | L271 (1) | yes | Screened exactly. |
| `L271_pq_system` | L271 (2), the P, Q form | yes | Proved. |
| `L271_Q_zero` | L271 (3) | yes | The "Q = 0 iff coordinate-diagonal" clause is not typed. |
| `L271_split` | L271 (4), core identity | yes, weaker | F(C, C_P, C_Q) = ½‖C_Q‖² - ¼ tr Q³ is equivalent to the record's second eigenvalue: with p, s the squared norms and f the left side, λ₂ = 1 - fq/(ps), which equals the record's formula exactly when f = s/2 - tr Q³/4. The eigenvalue and the threshold q tr Q³ > 2‖C_Q‖⁴ are not typed. Screened at 5 solutions. |
| `L272_perron` | L272 (2), (3) | yes | A positive eigenvector's eigenvalue is the largest eigenvalue of a symmetric matrix with positive off-diagonal entries, so hρ is the record's ρ. "i ∉ S" as ∀ l, U_il = V_il is right. The equality case of (3) is dropped. (1) is not typed anywhere. |
| `perron_positive_eigvec` | L272, cited step | yes | True (Perron–Frobenius on X + tI). |
| `L272_support` | L272 (4), first half | yes | The eigenvalue counts are dropped. |
| `L273_F_bound` | L273 (1) | yes | F = 3⟨A, A_μ⟩ + T and Cauchy–Schwarz. Equality and g ≥ 1/√m dropped. |
| `L273_J1_implies_H` | L273 (3) | **no** | The J1 hypothesis's sphere is `(1/2) * ((ΣΣ P²)/2 + (ΣΣ Q²)/2) = 1`, which is ¼(‖P‖² + ‖Q‖²) = 1. The record's b² = ½(‖P‖² + ‖Q‖²) = 1, with ‖P‖² the full sum, as L271 (1) and the file's own `L271_F_slice` use. At the uniform point on the record's sphere, T + λ_m g² = λ_m exactly (J1 is tight at I/c). On the file's sphere (b² = 2) the value is 3.632 against λ₅ = 1.186 at m = 5, 3.747 against 1.239 at m = 6, and 3.855 against 1.296 at m = 8. **So the typed J1 is false, the theorem is vacuously true, and it is provable by refuting its own hypothesis.** λ_m, κ, g² and T are otherwise correct. **Correction:** replace the sphere with `(1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) = 1`. |

**Could any sorry be false?** `L273_J1_implies_H` is true, but vacuously. `L264_not_simple_unstable` is of unknown truth as stated. The others are either the record's claims or implied by them.

## S2. The INDEX rows

- **Honest as written:** L254, L260, L261, L262, L263, L266, L268, L269, L270, L272. Each names the so(n) instance or existence form where it matters. L262 and L263 point the general-h statements to I118, and L260 points L260 (1)'s mechanism to I119. Small omissions: L260's row does not say that "idempotent of h's own #" is untyped, L272's row does not say that (1) is untyped in the new file or that (3) loses its equality case, and L269's row does not say that the eigenvector location is dropped.
- **L273 row:** "`L273_J1_implies_H` ((3), J1 a hypothesis)" inherits the defect. The hypothesis as typed is not J1.
- **L265 row:** "`L265_cp` (complete positivity)" should read positivity. Complete positivity is not typed.
- **L271 row:** "`L271_split` (4, screened)" should say it types the identity equivalent to (4)'s eigenvalue, without the eigenvalue or the threshold.
- **L264 row:** "`L264_not_simple_unstable` (2)" inherits the stronger statement. "`L270_H_of_Us'` ((3) with L270 (3))" should say that the hypothesis is the ambient bound with L256 pre-composed, not U_s' on simple subalgebras.
- **L267 row:** does not say the statement is the existence form of a constructive claim.

## P1. Proved declarations against docstrings

- `sharpMapCL_id`: I # I = (n-2) I as operators. Matches.
- `Ftri_symm12`, `Ftri_symm23`, `Ftri_sharp`, `Ftri_idem`, `Ftri_id`, and the additivity and homogeneity lemmas: the statements match their docstrings. The hypotheses (self-adjointness on the right slot) are the ones phiTri's symmetries need.
- `torusMat_add`, `torusMat_smul`, `skewPartM_mem`: linearity and skewness, as stated.
- `L270_so`: the docstring's four quantities and the equivalence match. "That condition forces q(n-2)² > d" omits the typed `∨ c ≤ 0`, which is cosmetic.
- `L271_pq_system`: TorusSystem ⇔ the P, Q system off the diagonal. Matches.

## Verdict

**REFUTED in one row, with corrections.**

1. [I117Statements.lean:352](../lean/HamiltonsCubic/Results/I117Statements.lean#L352): J1's sphere constant. Write ½(‖P‖² + ‖Q‖²) = 1, dropping the inner `/ 2`s. As typed the hypothesis fails at the uniform point, so the theorem is vacuous.
2. [I117Statements.lean:440](../lean/HamiltonsCubic/Results/I117Statements.lean#L440): add self-adjointness of D₁ and D₂ to `L264_not_simple_unstable`, or else state the split as two orthogonal ideals of the range.
3. [lean/INDEX.md](../lean/INDEX.md) rows L265 ("complete positivity"), L271 (scope of `L271_split`), L264 (`L270_H_of_Us'`'s pre-composed hypothesis) and L267 (existence form), plus the L273 and L264 rows once 1 and 2 are repaired.
