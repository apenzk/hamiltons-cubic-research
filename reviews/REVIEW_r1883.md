# REVIEW r1883: L244Kappa, κ_r(x) by Ky Fan and Lemma L244 (i), (ii) at every unit vector

*Gate 2 on [L244Kappa.lean](../lean/HamiltonsCubic/Results/L244Kappa.lean) at commit 84cf52c9, with [L244Unit.lean](../lean/HamiltonsCubic/Results/L244Unit.lean) and [L244Norm.lean](../lean/HamiltonsCubic/Results/L244Norm.lean), against Lemma L244 in [second-order.md](../findings/second-order.md). Every claim is CONFIRMED, two with observations. `kappa r x` is the record's κ_r(x) at every r, including r = 0 and r above dim Λ², through `slot_le_kappa`, `kappa_le` and `slotμ_nonneg` plus one hand step (the conjugated slot vectors are a complete eigenbasis). `L244_ii` is the record's (ii) as stated, with the multiplicities and a = 1/√(2p) derived. `L244_i_unit` is the record's (i) at every unit x once the labelling is injective, the b_ab being computed at the reflected frame ψx, whose class projections are W's eigenprojections. The frame independence of b_ab that makes this the record's quantity is a two-line hand fact outside the kernel. The INDEX row already carries that qualification and the findings note does not. Six declarations print the standard three axioms.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `kappa r x` is the record's κ_r(x), the top-r eigenvalue sum of −ad_x², at every r (with `kSet_nonempty`, `kSet_bdd`, `le_kappa`, `slot_le_kappa`, `kappa_le`) | CONFIRMED WITH OBSERVATIONS (O1) |
| 2 | `negAd_conj`, `slotμ_nonneg` | CONFIRMED |
| 3 | `cap_self_kappa`, the self cap at every class size, m_c = 1 included | CONFIRMED |
| 4 | `L244_i_unit` is the record's (i) at every unit x ∈ E_c | CONFIRMED WITH OBSERVATIONS (O2, O3) |
| 5 | `L244_ceiling_kappa`, `L244_ii`: (ii) as stated | CONFIRMED |
| 6 | lean/INDEX.md L244 row (new text, **proved**) and the findings/second-order.md Lean note | CONFIRMED WITH OBSERVATIONS (O2, O4) |
| 7 | `#print axioms` on L244_ii, L244_i_unit, kappa_le, slot_le_kappa (and cap_self_kappa, L244_ceiling_kappa) | CONFIRMED |

**Summary.** The file proves what the row says, the κ it uses is the record's κ, and (ii) is closed as stated. (i) is closed at the frame the proof builds, and its b_ab equal the record's frame-free ⟨(P_a#P_b)x,x⟩ by a hand argument the row names and the findings note should name.

## Conventions

- `inner2 X Y = ½ tr(XᵀY)` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), the half-trace pairing, so e_i∧e_j is a unit bivector and tr(−ad_x²) = 2(n−2) at unit x, which is row (A)'s n − 2 after the factor 2 in 2Σ_b b_ab.
- `normSq W = innerOp W W = ½ Σ_{i,j} inner2 (Wφ_ij) (Wφ_ij) = Σ_k λ_k²` (`normSq_eq`, L244Norm).
- `IsCritical W θ` is `Qop W (φ_ij) = θ W(φ_ij)` for all i, j, i.e. W² + W# = θW on bivectors. `IsWeylOp` is linear plus the four `IsWeyl` clauses (skew-valued, symmetric on bivectors, first Bianchi, Ric = 0).
- `br x y = [x, y]`. `bAB ψ cls a b x = ½ Σ_{γ∈a, δ∈b} inner2([ψ_γ, ψ_δ], x)²`, the record's b_ab written at the frame ψ.
- `evf W hW`, `ψf W hW`: the spectral frame of W from EigenFrameExist, orthonormal and complete on skew matrices, reindexed by `Fin (card (Pairs n))`, N = n(n−1)/2 members.

The record, quoted verbatim from the heading "Lemma L244, the per-vector ceiling on a symmetric three-value critical point":

> **Setting.** $W$ a unit critical point, $W^2+W^\#=\theta W$, with three eigenvalues; $P_a$ the eigenprojections, $B_{ab}=P_a\#P_b\succeq0$, and for unit $x$, $b_{ab}(x)=\langle B_{ab}x,x\rangle=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$. $\kappa_r(x)$ is the sum of the top $r$ eigenvalues of $-\mathrm{ad}_x^2$.

> **Statement.** (i) **The per-vector rows.** Since $Q(\mathcal W_n)\subseteq\mathcal W_n$ ([L234](#lemma-l234-the-projected-pair-quotient-in-closed-form-at-every-weyl-e), step (1)), $W^\#=\theta W-W^2$ is an operator identity, so for every unit $x\in E_c$:
> $$\sum_{a,b}b_{ab}(x)=n-2,\qquad\sum_{a,b}\lambda_b\,b_{ab}(x)=-\lambda_c,\qquad\sum_{a,b}\lambda_a\lambda_b\,b_{ab}(x)=\lambda_c(\theta-\lambda_c),$$
> with source caps $2\sum_bb_{ab}(x)\le\kappa_{m_a}(x)$, and $\kappa_{m_c-1}(x)$ for $a=c$ since $x\in\ker\mathrm{ad}_x$. (ii) **The symmetric family.** If the eigenvalues are $(-a,0,a)$, $a=1/\sqrt{2p}$, with multiplicities $(p,N-2p,p)$, **the indices $0,1,2$ label the eigenvalues $-a,0,a$ in that order, so $E_0$ is the NEGATIVE eigenspace and $E_1$ the kernel of $W$**; then every unit $x\in E_0$ gives
> $$\theta\ \le\ \frac{\min\big(\kappa_{p-1}(x),\ \kappa_p(x)-2,\ n-4\big)-1}{\sqrt{2p}},\qquad\text{in particular}\qquad\theta\le\frac{n-5}{\sqrt{2p}} .$$

## Hypothesis inventory

| Declaration | Hypotheses | Record counterpart |
|---|---|---|
| `kSet_bdd`, `le_kappa` | `IsSkew x` | x a bivector |
| `kappa_le` | `IsSkew x`, a bound B on every ≤r-set of slot eigenvalues of every normal form (N, O) of x | Ky Fan's upper half |
| `slot_le_kappa` | `IsSkew x`, one normal form x = O N.X Oᵀ, O orthogonal, `S.card ≤ r` | Ky Fan's attainment |
| `negAd_conj` | O orthogonal, x = O N.X Oᵀ | slot vectors are eigenvectors |
| `slotμ_nonneg` | as `negAd_conj`, plus `IsSkew x` | −ad_x² ⪰ 0 |
| `cap_self_kappa` | ψ skew, orthonormal, complete, `cls k₀ = c`, `ψ k₀ = x`, `IsSkew x` | the a = c cap |
| `L244_i_unit` | `IsWeylOp W`, `IsCritical W θ`, `cls`, `lam` with `evf k = lam (cls k)`, `cls k₀ = c`, x skew, unit, `W x = lam c • x` | (i), W critical with its spectrum labelled, x unit in E_c |
| `L244_ceiling_kappa` | `IsWeylOp W`, `0 < a`, `IsCritical W θ`, `cls` into (−a, 0, a), classes 0 and 2 nonempty, x skew, unit, `W x = −a x` | (ii) without the unit norm |
| `L244_ii` | `IsWeylOp W`, `0 < a`, `IsCritical W θ`, `normSq W = 1`, `cls` into (−a, 0, a), x skew, unit, `W x = −a x` | (ii) |

`L244_ii` assumes neither the multiplicities (p, N−2p, p) nor a = 1/√(2p). It derives card(class 2) = card(class 0) and normSq W = 2pa² from `L244_mult` (tracelessness), a = 1/√(2p) from `L244_a`, and p > 0 from the unit norm. The zero class may be empty, which widens the record's "three eigenvalues" to allow N = 2p. Nothing in the record's hypotheses goes missing.

## 1. `kappa r x` is κ_r(x)

**Definition.** `kSet r x` is the set of Σ_{γ<m} ‖[x, ψ_γ]‖² over m ≤ r and orthonormal skew ψ : Fin m → Mat. `kappa r x = sSup (kSet r x)`.

**Nonempty and bounded.** `kSet_nonempty` puts 0 in the set by the empty family (m = 0), at every r including r = 0. `kSet_bdd` takes the normal form from `bracket_cap` and applies its conclusion at c = 0, giving every element ≤ Σ_{slots} max(μ_s, 0). So sSup is the true supremum and `le_csSup`, `csSup_le` apply as used.

**By hand, the identification.** Let (N, O) be any normal form of x. The N slot vectors φ_s are orthonormal in Λ² (`slot_orthonormal`), and conjugation by O is an isometry of Λ² (`inner2_conj`), so {Oφ_sOᵀ} is an orthonormal set of N = dim Λ² vectors, hence an orthonormal basis. `negAd_conj` makes each an eigenvector of −ad_x² with eigenvalue μ_s. So the multiset {μ_s} is the spectrum of −ad_x² on Λ², the same for every normal form. Write T_r for the top-r sum (the sum of all N eigenvalues when r ≥ N).

- `slot_le_kappa` gives Σ_S μ ≤ κ for every S with |S| ≤ r. Taking S the indices of the top min(r, N) eigenvalues gives T_r ≤ `kappa r x`.
- `kappa_le` with B = T_r: its hypothesis asks every ≤r-set of slot eigenvalues of every normal form to sum to at most T_r. Every normal form carries the same multiset, and by `slotμ_nonneg` every entry is ≥ 0, so a set of at most r entries sums to at most the top min(r, N) of them. Hence `kappa r x` ≤ T_r.

So `kappa r x` = T_r at every r. At r = 0 both sides are 0: I screened this in Lean, `kappa 0 x ≤ 0` follows from `kappa_le hx 0` with S = ∅ forced by `S.card ≤ 0`, and it compiles. At r ≥ N it is the full trace 2(n−2)·inner2 x x, which is the only sensible reading of "top r" past the dimension, and the record's uses (r ∈ {m_a, m_c − 1, p − 1, p}) never exceed N. Nonnegativity matters exactly here: without it "largest sum of at most r" and "sum of the top r" differ, and `slotμ_nonneg` closes the gap.

**How `kappa_le` itself is proved.** For m = 0 the sum is 0 and hB at S = ∅ gives 0 ≤ B. For m > 0, `exists_c_topSum` picks c with rc + Σ max(μ − c, 0) ≤ B from the ≤r bounds, and `bracket_cap`'s dual Ky Fan bound (Gate 2 r1151) gives the family's sum ≤ that. This is the standard dual form of Ky Fan's maximum principle, and it is sound. Verdict CONFIRMED WITH OBSERVATIONS: the equality `kappa r x = T_r` is not one Lean theorem. It is the pair of inequalities plus the hand step that every normal form carries the full spectrum (O1).

## 2. `negAd_conj`, `slotμ_nonneg`

**`negAd_conj`.** With U = Oᵀ orthogonal, `br_conj` gives [OAOᵀ, OBOᵀ] = O[A, B]Oᵀ. So −[x, [x, Oφ_sOᵀ]] = O(−[N.X, [N.X, φ_s]])Oᵀ = O(μ_s φ_s)Oᵀ = μ_s Oφ_sOᵀ by `slot_eigen`. Correct.

**`slotμ_nonneg`.** Put ψ = Oφ_sOᵀ, a unit vector by `inner2_conj` and `slot_orthonormal`. `inner2_negAdSq` is ad-invariance: ⟨ψ, −[x, [x, ψ]]⟩ = ⟨[x, ψ], [x, ψ]⟩, since ad_x is skew-adjoint for ½tr(XᵀY) at skew x. The left side is μ_s⟨ψ, ψ⟩ = μ_s by `negAd_conj`. So μ_s = ‖[x, ψ]‖² ≥ 0. Correct.

## 3. `cap_self_kappa`

For m_c ≥ 2 it is `cap_self_gen` (Gate 2 r1881) with κ₀ = `kappa (m_c − 1) x`, the needed bound on every ≤(m_c − 1)-set of slot eigenvalues supplied by `slot_le_kappa`. For m_c = 1, `class_equiv` gives e : Fin 1 ≃ class c with e 0 = k₀. The class row mass is Σ_b b_cb(x) (`rowMass_class`), `rowMass_drop_self` removes x's own row (⟨[x, ψ_δ], x⟩ = ⟨ψ_δ, [x, x]⟩ = 0 up to sign), and the remaining family is indexed by Fin 0, so the mass is 0. The right side `kappa 0 x` is ≥ 0 by the empty family. By hand the same: b_cb(x) = ½Σ_δ⟨[x, ψ_δ], x⟩² = 0. m_c = 0 is excluded by k₀ ∈ class c. CONFIRMED.

## 4. `L244_i_unit` against the record's (i)

**What is proved.** At the frame ψ = `ψx hW k₀ x`, the spectral frame reflected through ψ_{k₀} − x, with b_ij = `bAB ψ cls i j x`: the three rows, the caps 2Σ_j b_ij ≤ κ_{m_i}(x) at every nonempty class, and 2Σ_j b_cj ≤ κ_{m_c−1}(x). The rows come from `rowMass_total_any`, `rowB_mass` and `rowC_mass` with `rowC_critical`, the caps from `cap_other_gen` and `cap_self_kappa`. The record's rows and caps match term by term: row (B)'s right side −⟨Wx, x⟩ = −λ_c, row (C)'s ⟨W#x, x⟩ = λ_c(θ − λ_c).

**Is ψx an eigenframe with the same classes?** `refl_eigen` shows a reflection through a μ-eigenvector keeps every λ-eigenvector a λ-eigenvector (the symmetry of W forces ⟨v, y⟩ = 0 when μ ≠ λ, and when μ = λ the image stays in E_λ). Here v = ψ_{k₀} − x lies in E_{λ_c}, so each ψx_k is an eigenvector with eigenvalue `evf k` = lam(cls k). `refl_inner` and `ψx_complete` keep the frame orthonormal and complete. `ψx_self` sends k₀ to x.

**Frame dependence.** The record's b_ab(x) = ⟨(P_a#P_b)x, x⟩ is frame free, and the Lean's `bAB` is written at ψx. The two agree by hand, in two steps:

1. By ad-invariance ⟨[ψ_γ, ψ_δ], x⟩ = ±⟨ψ_δ, [x, ψ_γ]⟩, so Σ_{δ∈b}⟨[ψ_γ, ψ_δ], x⟩² = ‖P_b[x, ψ_γ]‖² for any orthonormal basis of the class-b span, and summing over an orthonormal basis of the class-a span gives ‖P_b ad_x P_a‖²_F. So `bAB` depends only on the two class spans.
2. When lam is injective, the class-a vectors of ψx are orthonormal λ_a-eigenvectors and the whole frame is complete, so they span E_a exactly and their span projection `Pc` is the eigenprojection P_a. `mixQF_Pc` then gives mixQF(P_a, P_b)x = b_ab(x), the record's ⟨(P_a#P_b)x, x⟩.

Neither step is in the kernel as a statement about two frames. Step 2 also needs lam injective, which `L244_i_unit` does not assume. With a non-injective lam the classes refine the eigenspaces, the reflection may rotate a class inside its eigenspace, and `bAB` is a finer mass than the record's. The theorem is still true there, and it is a refinement rather than the record's quantity. The record's (i) is the instance with lam injective, which a labelling of a spectrum by its distinct values always gives.

**Is this a gap for (i) as a statement about W and x?** It is a gap in presentation, not in truth. The Lean statement quantifies a specific frame through x, so it asserts the rows and caps for one adapted frame. The record's rows are frame free, and they follow from the Lean statement by the two hand steps above. The caps are frame free on both sides once b is. So "(i) at every unit vector, PROVED" is accurate with the qualification the INDEX row carries in its closing italic sentence ("taken at a frame adapted to W's eigenspaces whose class c starts at x, where P_a is `Pc` (`hWP_frame`) and `mixQF_Pc` gives ⟨(P_a#P_b)x,x⟩ = b_ab(x)"). The italic sentence should add that the labelling is injective and that frame independence is by hand (O2). A screen for this was unnecessary, as step 1 is a Frobenius-norm identity. Verdict CONFIRMED WITH OBSERVATIONS.

**The record's derivation of (i)'s self cap** says "since x ∈ ker ad_x", and the Lean uses exactly that (`rowMass_drop_self`). The record's κ index for a ≠ c is m_a, the Lean's `Fintype.card {γ // cls γ = i}`, which at injective lam is dim E_i.

## 5. `L244_ceiling_kappa`, `L244_ii`

**`L244_ceiling_kappa`.** At ψx through k₀ in class 0 (nonempty by `h0size`): `L244_rows_gen` gives hA, hB, hC with K = θ/a + 1. The E_0 cap is `cap_self_kappa` at κ_{m₀−1}, the E_2 cap is `cap_other_gen` at κ_{m₂}. Nonnegativity of b00, b01, b11, b22 is by `sq_nonneg`, and `bAB_symm` turns c2's b20, b21 into b02, b12. `per_vector_ceiling` gives K ≤ n − 4, K ≤ κ_{m₀−1}, K ≤ κ_{m₂} − 2, and `theta_bound` with θ = a(K − 1) gives θ ≤ a(n − 5), θ ≤ a(κ_{m₀−1} − 1), θ ≤ a(κ_{m₂} − 3). By hand: hB and hC are rows (B), (C) of (i) at λ = (−a, 0, a), λ_c = −a, divided by a and a². Row (B): a(b12 + b22 + b02 − b00 − b01 − b02) using symmetry, equal to a, so b12 + b22 − b00 − b01 = 1. Row (C): a²(b00 + b22 − 2b02) = −a(θ + a), so 2b02 − b00 − b22 = θ/a + 1. The linear algebra matches the record's proof line for line.

**`L244_ii`.** p := card(class 0). `L244_mult` gives card(class 2) = p and normSq W = 2pa², so p > 0 at unit norm, and `L244_a` gives a = 1/√(2p). Then a·X = X/√(2p). The conclusions are θ ≤ (n − 5)/√(2p), θ ≤ (κ_{p−1}(x) − 1)/√(2p), θ ≤ (κ_p(x) − 3)/√(2p). The record's single bound (min(κ_{p−1}, κ_p − 2, n − 4) − 1)/√(2p) is the minimum of exactly these three, since min(u, v, w) − 1 = min(u − 1, v − 1, w − 1) and division by √(2p) > 0 preserves order. p = card(class 0) is dim E_{−a}, as the spectral frame is an orthonormal eigenbasis. Every quantity in the conclusion (θ, n, p, κ_r(x)) is frame free, so (ii) carries none of (i)'s frame question. `cls` is a labelling of the spectral frame, and `exists_cls` (L244Norm, Gate 2 r1882) shows one exists whenever the spectrum lies in {−a, 0, a}, so the hypothesis is the record's "the indices 0, 1, 2 label the eigenvalues −a, 0, a in that order". CONFIRMED.

Scope, stated once: the Lean class allows N = 2p (empty kernel class), wider than "three eigenvalues", and whether the record's family has a member at any n is open (the record's own note, r1856 O6, r1881 O4). Both are known and neither is a defect.

## 6. The INDEX row and the findings note

**INDEX row.** The L244 row lists the eight files, state **proved**, and its closing clause describes `kappa`, `le_kappa`, `slot_le_kappa`, `kappa_le`, `cap_self_kappa`, `L244_i_unit`, `L244_ceiling_kappa`, `L244_ii` accurately, including that `slotμ_nonneg` turns "largest sum of at most r" into the top-r sum. The **proved** state is right: (ii) is proved as stated, and (i) is proved at every unit x with the frame qualification in the italic sentence. That sentence omits the injectivity of the labelling and the hand status of frame independence (O2).

**Findings note.** The L244 Lean note in [second-order.md](../findings/second-order.md) says "(i) at every unit vector of every eigenspace is `L244_i_unit` and (ii) as stated is `L244_ii`" and that κ_r(x) is "identified with the top-r eigenvalue sum of −ad_x²". The second is accurate as a pair of kernel-checked inequalities plus the hand step of section 1 (O1). The first carries no frame qualification, unlike the INDEX row (O4). The note's other citations (L244Norm, `L244_xfree_op` in L248Op) are as before and outside this target.

## 7. Axioms

`lake env lean` on a scratch file importing `HamiltonsCubic.Results.L244Kappa`, run after the background tree build finished (`Build completed successfully`):

```
'HamiltonsCubic.L244Kappa.L244_ii' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L244Kappa.L244_i_unit' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L244Kappa.kappa_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L244Kappa.slot_le_kappa' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L244Kappa.cap_self_kappa' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L244Kappa.L244_ceiling_kappa' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx`. CONFIRMED.

## Verdict

**CONFIRMED WITH OBSERVATIONS.** `kappa r x` is the record's κ_r(x) at every r, `L244_ii` is (ii) as stated with the multiplicities and a derived, and `L244_i_unit` is (i) at every unit x at the adapted frame ψx, which is the record's frame-free (i) at an injective labelling by a hand identity. The row's **proved** is accurate given its italic qualification, which should name injectivity and the hand step.

**The falsifying object**, and the search. The claims fall to any of: (a) a skew x with a normal form whose slot eigenvalues are not the spectrum of −ad_x² on Λ², or a negative slot eigenvalue, which would split `kappa` from the top-r sum. I derived `negAd_conj` and `slotμ_nonneg` by hand and checked that the N conjugated slot vectors form an orthonormal basis of the N-dimensional Λ², so no such normal form exists. (b) Two adapted orthonormal eigenframes at an injective labelling giving different `bAB` at the same x, which would make (i) frame dependent. Step 1 of section 4 rules it out, `bAB` being ‖P_b ad_x P_a‖²_F up to the factor. (c) A hypothesis of (ii) the Lean assumes beyond the record's, or a conclusion weaker than the record's min. I inventoried every hypothesis of `L244_ii` against the record and matched the three bounds to the min. (d) A `sorryAx` or nonstandard axiom, checked by `#print axioms`. The only computation was the Lean screen of r = 0 and the axiom print, both seconds.

## Observations

**O1.** The identification κ = top-r sum is the pair `slot_le_kappa`, `kappa_le` plus the hand fact that every normal form's slot eigenvalues are the whole spectrum of −ad_x². A one-line Lean corollary `kappa r x = max over |S| ≤ r of Σ_S slotμ N` at a fixed normal form (by `kappa_le` with B that max, which needs the spectrum's independence of the normal form or a restatement of `kappa_le` at one normal form) would put the identification itself in the kernel. Optional.

**O2.** `L244_i_unit` does not assume `lam` injective. At a non-injective labelling its `bAB` is a finer class mass than the record's b_ab and the frame ψx may rotate a class within its eigenspace. The record's (i) is the injective instance. The INDEX row's italic sentence should read, in substance, "at an injective labelling, where the class spans are the eigenspaces, P_a is `Pc` and `mixQF_Pc` gives ⟨(P_a#P_b)x,x⟩ = b_ab(x), the frame independence of b_ab being ‖P_b ad_x P_a‖²_F (by hand)".

**O3.** The caps in `L244_i_unit` include i = c at κ_{m_c}, which the self cap at κ_{m_c−1} dominates. This is harmless and matches the record's "at every nonempty class" reading.

**O4.** The findings/second-order.md L244 Lean note says "(i) at every unit vector of every eigenspace is `L244_i_unit`" without the frame qualification the INDEX row carries. It should add "with b_ab taken at an adapted frame through x, equal to the record's by frame independence (by hand)".
