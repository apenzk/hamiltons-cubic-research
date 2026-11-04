# REVIEW r1762: L260One.lean, L260 (1) at every operator in the rows-together convention

**Standfirst.** Cold Gate 2 reading of [L260One.lean](../lean/HamiltonsCubic/Results/L260One.lean) at commit e2085a50 against [findings/second-order.md](../findings/second-order.md) Lemma L260 (1), the layer's `Ftri`, `phiTri`, `IsPSD2`, `IsSelfAdjoint2`, and the [lean/INDEX.md](../lean/INDEX.md) L260 row. Statement fidelity only, the kernel having checked the proofs. Analysis-only footing: the identification of `Ftri X Xᵀ X` with the record's F is derived by hand below. A seconds-long numpy screen on so(4) and one small check file (`#print axioms`, three `example`/`theorem` instantiations) were run, and are reported as a screen and as kernel checks respectively.

**Summary.** `Ftri X Xt X` is exactly the record's rows-together F(X), P and Q are exactly |X| and |Xᵀ|, the hypothesis is satisfiable for every X (adjoint existence proved in the check file), the self-adjoint case recovers the inequality behind `L260_psd_cone`, and the axioms are the standard three. The INDEX row and one docstring in I117Statements.lean still carry text written before this commit.

## Claim table

| Claim | Verdict |
|---|---|
| `Ftri_rk1_sum`: F(Σ c_a u_a u_aᵀ) = ½ Σ c_b c_d c_a ⟨[u_b,u_d],u_a⟩² for any family u | CONFIRMED |
| `onb_expand`, `onb_inner`: expansion and orthonormality in an ONB of so(n) for `inner2` | CONFIRMED |
| `sum_rk1_sa`, `sum_rk1_psd`: Σ c_a rk1 u_a is self-adjoint, and PSD for c ≥ 0 | CONFIRMED |
| `adj_left`, `gram_sa`: with ⟨XY,Z⟩ = ⟨Y,XtZ⟩, the adjoint relation read the other way, and XtX self-adjoint | CONFIRMED |
| `amgm`: pq ≤ ½(sp² + tq²) for s, t ≥ 0 with st = 1 or q = 0 | CONFIRMED |
| `L260_one`: `Ftri X Xt X` is the record's F(X) in the stated convention (Q1) | CONFIRMED |
| `L260_one`: P, Q are exactly \|X\| and \|Xᵀ\| (Q2) | CONFIRMED |
| `L260_one`: statement non-vacuous for every X (Q3) | CONFIRMED |
| `L260_one` at Xt = X reduces to the record's use, consistent with `L260_psd_cone` (Q4) | CONFIRMED (norm clause derivable, O3) |
| `#print axioms L260_one` (Q5) | CONFIRMED: propext, Classical.choice, Quot.sound |
| INDEX row L260 as edited in e2085a50 (Q7) | CONFIRMED WITH OBSERVATIONS (O1, O2) |

## The record

Statement (1), quoted in full: *"(1) For every $X\in\mathop{\mathrm{End}}(\mathfrak{so}(n))$, with $\#$ extended off $\mathop{\mathrm{Sym}}^2$ by $(X\#Y)_{\alpha\beta}=\tfrac12c_\alpha^{\gamma\delta}c_\beta^{\varepsilon\zeta}X_{\gamma\varepsilon}Y_{\delta\zeta}$ (the rows of both factors in one structure constant, so $F(X)=\tfrac12\sum\sigma_a\sigma_b\sigma_c\langle u_c,[u_a,u_b]\rangle\langle v_c,[v_a,v_b]\rangle$ at $X=\sum\sigma_au_a\otimes v_a$), $F(X)\le\tfrac12\big(F(|X^{\mathsf T}|)+F(|X|)\big)$, so [L259]'s $\kappa_n$ is attained on the PSD cone and a norm-minimal $\#$-idempotent can be taken PSD."*

The convention paragraph, quoted in full: *"**The convention in (1) is load-bearing off $\mathop{\mathrm{Sym}}^2$.** In the layer's operator convention, $\langle(A\#B)\varphi,\psi\rangle=\tfrac12\sum\langle[A\omega_a,B\omega_b],\varphi\rangle\langle[\omega_a,\omega_b],\psi\rangle$, the matrix of $X\#X$ is the transpose of the one above, $F$ pairs rows with columns, and (1) fails: a screen of 2000 random $X$ on $\mathfrak{so}(4)$ gives a gap up to $+24.5$ there against at most $-6.3$ in the convention above, the two agreeing on $\mathop{\mathrm{Sym}}^2$ (the lean session's finding, reproduced independently). Nothing downstream moves: $\kappa_n$ is a supremum over $\mathop{\mathrm{Sym}}^2$, and (1) is used only at self-adjoint $X$, where `L260_psd_cone` proves it."*

Proof (1), quoted in full: *"(1) Expand $F$ over the singular value decomposition and apply $ab\le\tfrac12(a^2+b^2)$ to each term, whose weight $\sigma_k\sigma_l\sigma_m$ is nonnegative. A PSD maximiser is then a global maximiser, hence critical."*

## Q1. `Ftri X Xt X` is the record's F(X)

- The layer: `Ftri A B C = -(1/2) * phiTri A B C` and `phiTri A B C = -(1/4) Σ_{ijkl} ⟨B[Aφ_ij, Cφ_kl], [φ_ij, φ_kl]⟩`, with φ_ij = E_ji − E_ij of `inner2`-norm 1. The diagonal terms vanish and each unordered pair appears twice in each double sum, so the quadruple sum is 4 Σ over an ONB, which is `phiTri_onb`: phiTri A B C = −Σ_{β,γ} ⟨B[Ae_β, Ce_γ], [e_β, e_γ]⟩.
- Hence Ftri X Xt X = ½ Σ_{β,γ} ⟨Xt[Xe_β, Xe_γ], [e_β, e_γ]⟩ = ½ Σ_{β,γ} ⟨[Xe_β, Xe_γ], X[e_β, e_γ]⟩ by `hXt`.
- The record, with c_α^{γδ} = ⟨e_α, [e_γ, e_δ]⟩ and X_{γε} = ⟨e_γ, Xe_ε⟩: F(X) = Σ_{αβ} (X#X)_{αβ} X_{αβ} = ½ Σ c_α^{γδ} c_β^{εζ} X_{γε} X_{δζ} X_{αβ}. Contracting the row indices γ, δ, α gives Σ_{γδα} c_α^{γδ} X_{γε} X_{δζ} X_{αβ} = ⟨Xe_β, [Xe_ε, Xe_ζ]⟩, and contracting β against c_β^{εζ} gives ⟨[Xe_ε, Xe_ζ], X[e_ε, e_ζ]⟩. So F(X) = ½ Σ_{ε,ζ} ⟨[Xe_ε, Xe_ζ], X[e_ε, e_ζ]⟩, which is the Lean expression term for term.
- At X = Σ σ_a u_a ⊗ v_a the same contraction gives the record's ½ Σ σσσ ⟨u_c,[u_a,u_b]⟩⟨v_c,[v_a,v_b]⟩, and Lean's `hF` gives ½ Σ ⟨[v_b,v_d],v_a⟩⟨[w_b,w_d],w_a⟩ with w_a = Xv_a = σ_a u_a. The two agree.
- The formula is symmetric under u ↔ v, so F(X) = F(Xᵀ) in this convention, and the reading of which index of X_{γε} is the row does not change the value. The screen confirms Ftri X Xᵀ X = Ftri Xᵀ X Xᵀ.
- **Screen** (seed 1762, so(4), standard normal 6×6 X in an `inner2`-orthonormal basis, `phiTri` evaluated literally from the φ_ij quadruple sum): over 200 samples max |Ftri X Xᵀ X − ½ c c X X X| = 1.6·10⁻¹³, and max |F(X) − F(Xᵀ)| at the same level. Over 2000 samples (vectorised, cross-checked against the literal sum) the gap F(X) − ½(F(|Xᵀ|) + F(|X|)) is at most −5.64 in the rows-together convention and reaches +13.9 with the layer's `Ftri X X X`, the same signs as the record's −6.3 and +24.5. On a random symmetric X the two conventions agree (198.18 both), and F(I) = 12 = (n−2)⟨I,I⟩. A screen, and no evidence for the inequality beyond the proof.

## Q2. P and Q are |X| and |Xᵀ|

- The conclusion gives P self-adjoint, PSD, P∘P = Xt∘X, and Q self-adjoint, PSD, Q∘Q = X∘Xt. On the finite-dimensional inner-product space (so(n), `inner2`), a self-adjoint PSD square root of a PSD operator is unique, so P = |X| = √(XᵀX) and Q = |Xᵀ| = √(XXᵀ), matching the record's F(|Xᵀ|) + F(|X|) (the sum is symmetric in the two anyway).
- The witnesses are |X| = Σ σ_a v_a v_aᵀ and |Xᵀ| = Σ σ_a⁻¹ w_a w_aᵀ = Σ σ_a u_a u_aᵀ, which are the record's. At σ_a = 0 Lean's 0⁻¹ = 0 drops the term, harmless because `hwz` gives w_a = 0 there.
- Nothing extra is stated. The one consequence the record draws that the conclusion omits is ‖|X|‖ = ‖X‖ (O3).

## Q3. Non-vacuity

- The hypothesis is the adjoint relation. The check file proves `adj_exists`: for every X : CurvOp2 ι there is Xt with ⟨XY,Z⟩ = ⟨Y,XtZ⟩, built from `LinearMap.adjoint (opSk X)` on `SkewSp` and `LinearMap.toContinuousLinearMap`, axioms propext, Classical.choice, Quot.sound. Since `inner2` is definite on skew matrices, Xt is the unique adjoint, so `L260_one` quantifies over every X exactly once.
- The conclusion is existential over P, Q with properties that pin them uniquely (Q2), so the existential carries the record's content.

## Q4. The self-adjoint case

- With Xt = X, `hXt` is literally `IsSelfAdjoint2 X`, and the check file instantiates `L260_one X X hX`. Then P∘P = Q∘Q = X∘X, so P = Q = |X| by uniqueness, and the inequality reads Ftri X X X ≤ Ftri |X| |X| |X|, the layer's F on both sides.
- `L260_psd_cone` states ∃ Y self-adjoint PSD with normSq2 Y = normSq2 X and Ftri X X X ≤ Ftri Y Y Y. `L260_one` gives the inequality with Y = |X|, the same witness `L260_psd_cone` uses. The norm equality follows from P∘P = X∘X, since `normSq2` is `innerOp2 R R` = ½ Σ_{ij} ⟨Rφ_ij, Rφ_ij⟩ = Σ_β ⟨R²e_β, e_β⟩ for self-adjoint R, so normSq2 P = Σ_β ⟨X²e_β, e_β⟩ = normSq2 X. `L260_one` leaves this to the reader (O3). Consistent.

## Q5. Axioms

`#print axioms L260_one`: [propext, Classical.choice, Quot.sound]. The `#check` output matches the file's statement verbatim.

## Q6. An object meeting the hypotheses

- X = I (`idOp`), Xt = I, `hXt` by `rfl`: the check file's `example` compiles. P = Q = I, and the inequality is F(I) ≤ F(I), equality, with F(I) = (n−2)⟨I,I⟩ = (n−2)N (12 at n = 4 in the screen).
- Any X meets the hypotheses with its adjoint (Q3). For X = u ⊗ v, a rank-one operator Y ↦ ⟨Y,v⟩u with unit u, v, P = v vᵀ and Q = u uᵀ, and both sides vanish since [v,v] = 0.

## Q7. The INDEX row

- Correct: the file list adds L260One.lean, the new clause "**(1) at every $X$ is PROVED** in L260One.lean, in the rows-together extension of $F$ off $\mathop{\mathrm{Sym}}^2$ the record now states" describes `L260_one` accurately, and the screen paragraph matches both the record and this review's screen.
- Stale (O1): the row's opening summary still reads *"every typed clause proved, at $\mathfrak h=\mathfrak{so}(n)$ and self-adjoint $X$"*, and the screen paragraph still ends *"Routed to the research session."*, although the record now states the convention and the row itself says (1) is proved at every X.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** `L260_one` states Lemma L260 (1) exactly, in the convention the record fixes, with |X| and |Xᵀ| pinned by uniqueness and a hypothesis satisfiable for every X.

1. **O1.** [lean/INDEX.md](../lean/INDEX.md) L260 row: the opening "*every typed clause proved, at $\mathfrak h=\mathfrak{so}(n)$ and self-adjoint $X$*" should read "at $\mathfrak h=\mathfrak{so}(n)$, (1) at every $X$", and "Routed to the research session." should record the routing as resolved (the record's convention paragraph).
2. **O2.** [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) line 2206, the docstring of `L260_psd_cone`, still says the non-self-adjoint mechanism "is not typed". It is now `L260_one` in L260One.lean, and the docstring should say so.
3. **O3.** `L260_one` omits normSq2 P = normSq2 X, which the record's "κ_n is attained on the PSD cone" uses. At self-adjoint X `L260_psd_cone` supplies it, and the record uses (1) only there, so nothing is owed. A one-line corollary would make `L260_one` imply `L260_psd_cone` outright.
4. **O4.** In the rows-together convention F(X) = F(Xᵀ) (the SVD formula is symmetric in u and v), so the record's index reading X_{γε} is immaterial. The record could say so in its convention paragraph, which would pre-empt the question of which index is the row.

## Falsifiers

- `Ftri_rk1_sum`: a family u, weights c with F(Σ c_a u_a u_aᵀ) ≠ ½ Σ c_b c_d c_a ⟨[u_b,u_d],u_a⟩².
- `sum_rk1_psd`: nonnegative c and Z with ⟨Σ c_a rk1(u_a) Z, Z⟩ < 0.
- `gram_sa`: X, Xt satisfying `hXt` with XtX not self-adjoint.
- `amgm`: s, t ≥ 0 with st = 1 or q = 0 and pq > ½(sp² + tq²).
- `L260_one` (fidelity): an X on so(n) with Ftri X Xᵀ X ≠ ½ Σ c_α^{γδ} c_β^{εζ} X_{γε} X_{δζ} X_{αβ}.
- `L260_one` (content): an X with adjoint Xt and PSD roots P, Q where Ftri X Xt X > ½(Ftri P P P + Ftri Q Q Q).
- Q2: two distinct self-adjoint PSD operators with the same square.
