import Mathlib
import HamiltonsCubic.Results.L245SymmetricIsotropy
import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.WeylAction
import HamiltonsCubic.Results.I117Four

set_option linter.style.longLine false

/-!
# L245's isotropy weights at the operator level

[findings/second-order.md](../../../findings/second-order.md), Lemma L245: *with $A_c=\sum_{\psi\in E_c}\psi\psi^{\mathsf T}$ the
isotropy matrices of $W$'s eigenspaces, every unit $x$ has $a_0+a_1+a_2=n-1$, $\lambda_0a_0+\lambda_1a_1+\lambda_2a_2=0$,
$a_c\ge0$, from $\sum_cA_c=\operatorname{Ric}(\mathrm{Id})$ and $\sum_c\lambda_cA_c=\operatorname{Ric}(W)=0$.*
[L245SymmetricIsotropy.lean](L245SymmetricIsotropy.lean) proves the ceilings from the three facts taken as hypotheses. This
file proves the facts on `CurvOp2`, reading $\langle A_cx,x\rangle$ as the Ricci contraction of the eigenprojector $P_c$:

* `isoW P x` $=\sum_k\langle P(x\wedge e_k),x\wedge e_k\rangle$, which is $\operatorname{Ric}(P)(x,x)$ and, at
  $P=\sum_{\psi\in E}\psi\psi^{\mathsf T}$, the record's $\langle A x,x\rangle$; it is linear in $P$ (`isoW_add`, `isoW_smul`);
* `isoW_id`: $\operatorname{Ric}(I)(x,x)=(n-1)\lvert x\rvert^2$; `isoW_weyl`: $\operatorname{Ric}(W)(x,x)=0$ at a Weyl $W$;
  `isoW_nonneg`: $\ge0$ at a positive semidefinite $P$;
* **`L245_op`**: for positive semidefinite $P_0,P_1,P_2$ with $\sum P_c=I$ and $\sum\lambda_cP_c=W$ Weyl, and unit $x$, the
  weights satisfy the record's three facts, so `ceiling_h0`, `ceiling_h1`, `ceiling_h2` apply (`L245_ceilings`, all three);
* `isoW_rk1`: at a rank-one $\psi\psi^{\mathsf T}$ the weight is $\lvert\psi x\rvert^2$, the record's $\langle\psi\psi^{\mathsf T}x,x\rangle$;
* `isoW_rk1_star`, `L245_star`: $\operatorname{Ric}(\pi_{e\wedge u})(e,e)=1$ for unit $u\perp e$, so a star $e\wedge U\subseteq E_0$
  of dimension $d$ gives $a_0(e)\ge d$ and $(\lambda_2-\lambda_0)d\le(n-1)\lambda_2$; `L245_star_two` and `L245_star_one`
  are the stars in $E_2$ and $E_1$ (`star_weight` in any class).
-/

namespace HamiltonsCubic.L245Op

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.Results

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `x ∧ e_k` as a bivector. -/
noncomputable def xk (x : ι → ℝ) (k : ι) : skewSub ι := ∑ a, x a • ⟨phi a k, phi_mem_skewSub a k⟩

theorem xk_coe (x : ι → ℝ) (k : ι) : ((xk x k : skewSub ι) : Matrix ι ι ℝ) = ∑ a, x a • phi a k := by
  unfold xk
  rw [Submodule.coe_sum]
  rfl

/-- **The isotropy weight** `Ric(P)(x, x) = ∑_k ⟨P(x ∧ e_k), x ∧ e_k⟩`. -/
noncomputable def isoW (P : CurvOp2 ι) (x : ι → ℝ) : ℝ :=
  ∑ k, inner2 ((P (xk x k) : skewSub ι) : Matrix ι ι ℝ) ((xk x k : skewSub ι) : Matrix ι ι ℝ)

theorem isoW_expand (P : CurvOp2 ι) (x : ι → ℝ) :
    isoW P x = ∑ k, ∑ a, ∑ b, x a * x b * inner2 (applyPhi P a k) (phi b k) := by
  unfold isoW
  refine Finset.sum_congr rfl fun k _ => ?_
  have hP : ((P (xk x k) : skewSub ι) : Matrix ι ι ℝ) = ∑ a, x a • applyPhi P a k := by
    unfold xk
    rw [map_sum, Submodule.coe_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [map_smul, Submodule.coe_smul]
  rw [hP, xk_coe, inner2_sumL]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [inner2_smul_left'', inner2_sumR, Finset.mul_sum]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [inner2_smul_right'']
  ring

theorem isoW_add (P Q : CurvOp2 ι) (x : ι → ℝ) : isoW (P + Q) x = isoW P x + isoW Q x := by
  unfold isoW
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [ContinuousLinearMap.add_apply, Submodule.coe_add, i2_add_l]

theorem isoW_smul (c : ℝ) (P : CurvOp2 ι) (x : ι → ℝ) : isoW (c • P) x = c * isoW P x := by
  unfold isoW
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [ContinuousLinearMap.smul_apply, Submodule.coe_smul, i2_smul_l]

theorem isoW_sum {κ : Type*} (s : Finset κ) (P : κ → CurvOp2 ι) (x : ι → ℝ) :
    isoW (∑ c ∈ s, P c) x = ∑ c ∈ s, isoW (P c) x := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      simp only [Finset.sum_empty]
      have h := isoW_smul 0 (0 : CurvOp2 ι) x
      rw [show (0 : ℝ) • (0 : CurvOp2 ι) = 0 by module] at h
      rw [h]; ring
  | insert c s hc ih => rw [Finset.sum_insert hc, Finset.sum_insert hc, isoW_add, ih]

theorem isoW_nonneg {P : CurvOp2 ι} (hP : IsPSD2 P) (x : ι → ℝ) : 0 ≤ isoW P x :=
  Finset.sum_nonneg fun k _ => hP (xk x k)

theorem isoW_weyl {W : CurvOp2 ι} (hW : IsWeyl2 W) (x : ι → ℝ) : isoW W x = 0 := by
  rw [isoW_expand, Finset.sum_comm]
  refine Finset.sum_eq_zero fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero fun b _ => ?_
  have h := hW.ric a b
  calc ∑ k, x a * x b * inner2 (applyPhi W a k) (phi b k)
      = x a * x b * ∑ k, inner2 (applyPhi W a k) (phi b k) := by rw [Finset.mul_sum]
    _ = 0 := by rw [h, mul_zero]

/-- **`Ric(I)(x, x) = (n − 1)|x|²`.** -/
theorem isoW_id (x : ι → ℝ) : isoW (idOp : CurvOp2 ι) x = ((Fintype.card ι : ℝ) - 1) * ∑ a, x a ^ 2 := by
  rw [isoW_expand]
  have hterm : ∀ k a b : ι, x a * x b * inner2 (applyPhi (idOp : CurvOp2 ι) a k) (phi b k)
      = (if a = b then x a * x b else 0) - (if a = k ∧ b = k then x a * x b else 0) := by
    intro k a b
    show x a * x b * inner2 (phi a k) (phi b k) = _
    rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]
    by_cases hab : a = b
    · subst hab
      by_cases hak : a = k
      · subst hak; simp
      · simp [hak]
    · by_cases h1 : k = b ∧ a = k
      · obtain ⟨h1, h2⟩ := h1; exact absurd (h2.trans h1) hab
      · simp only [hab, false_and, if_false]
        have h2 : ¬ (a = k ∧ b = k) := fun h => h1 ⟨h.2.symm, h.1⟩
        simp [h1, h2]
  simp only [hterm, Finset.sum_sub_distrib]
  have hA : ∑ a, ∑ b, (if a = b then x a * x b else 0) = ∑ a, x a ^ 2 := by
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_ite_eq]; simp [sq]
  have hB : ∀ k : ι, ∑ a, ∑ b, (if a = k ∧ b = k then x a * x b else 0) = x k ^ 2 := fun k => by
    rw [Finset.sum_eq_single k]
    · rw [Finset.sum_eq_single k]
      · simp [sq]
      · intro b _ hb; simp [hb]
      · intro h; exact absurd (Finset.mem_univ k) h
    · intro a _ ha
      exact Finset.sum_eq_zero fun b _ => by simp [ha]
    · intro h; exact absurd (Finset.mem_univ k) h
  simp only [hB, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  rw [hA]
  ring

/-- **L245's three facts on `CurvOp2`.** For positive semidefinite `P₀, P₁, P₂` resolving the identity with
`∑ λ_c P_c = W` Weyl, and unit `x`, the weights `a_c = Ric(P_c)(x, x)` satisfy `a₀ + a₁ + a₂ = n − 1`,
`λ₀a₀ + λ₁a₁ + λ₂a₂ = 0` and `a_c ≥ 0`. -/
theorem L245_op {W : CurvOp2 ι} (hW : IsWeyl2 W) (P : Fin 3 → CurvOp2 ι) (lam : Fin 3 → ℝ)
    (hsum : ∑ c, P c = idOp) (hspec : ∑ c, lam c • P c = W) (hpsd : ∀ c, IsPSD2 (P c))
    (x : ι → ℝ) (hx : ∑ a, x a ^ 2 = 1) :
    isoW (P 0) x + isoW (P 1) x + isoW (P 2) x = (Fintype.card ι : ℝ) - 1 ∧
      lam 0 * isoW (P 0) x + lam 1 * isoW (P 1) x + lam 2 * isoW (P 2) x = 0 ∧
      ∀ c, 0 ≤ isoW (P c) x := by
  refine ⟨?_, ?_, fun c => isoW_nonneg (hpsd c) x⟩
  · have h := congrArg (fun T => isoW T x) hsum
    simp only [Fin.sum_univ_three, isoW_add, isoW_id, hx, mul_one] at h
    exact h
  · have h := congrArg (fun T => isoW T x) hspec
    simp only [Fin.sum_univ_three, isoW_add, isoW_smul, isoW_weyl hW] at h
    exact h

/-- **The ceilings**, at `λ₀ ≤ λ₁ ≤ λ₂`: `(λ₂ − λ₀)a₀ ≤ (n − 1)λ₂`, `(λ₂ − λ₀)a₂ ≤ (n − 1)(−λ₀)`, and `a₁` under both
`(λ₁ − λ₀)a₁ ≤ (n − 1)(−λ₀)` and `(λ₂ − λ₁)a₁ ≤ (n − 1)λ₂`, the record's `h₁` being the smaller. -/
theorem L245_ceilings {W : CurvOp2 ι} (hW : IsWeyl2 W) (P : Fin 3 → CurvOp2 ι) (lam : Fin 3 → ℝ)
    (hsum : ∑ c, P c = idOp) (hspec : ∑ c, lam c • P c = W) (hpsd : ∀ c, IsPSD2 (P c))
    (hl01 : lam 0 ≤ lam 1) (hl12 : lam 1 ≤ lam 2) (x : ι → ℝ) (hx : ∑ a, x a ^ 2 = 1) :
    (lam 2 - lam 0) * isoW (P 0) x ≤ ((Fintype.card ι : ℝ) - 1) * lam 2 ∧
      (lam 2 - lam 0) * isoW (P 2) x ≤ ((Fintype.card ι : ℝ) - 1) * (-lam 0) ∧
      (lam 1 - lam 0) * isoW (P 1) x ≤ ((Fintype.card ι : ℝ) - 1) * (-lam 0) ∧
      (lam 2 - lam 1) * isoW (P 1) x ≤ ((Fintype.card ι : ℝ) - 1) * lam 2 := by
  obtain ⟨hs, hr, hn⟩ := L245_op hW P lam hsum hspec hpsd x hx
  exact ⟨HamiltonsCubic.L245SymmetricIsotropy.ceiling_h0 _ _ _ _ _ _ _ hs hr (hn 1) hl12,
    HamiltonsCubic.L245SymmetricIsotropy.ceiling_h2 _ _ _ _ _ _ _ hs hr (hn 1) hl01,
    HamiltonsCubic.L245SymmetricIsotropy.ceiling_h1 _ _ _ _ _ _ _ hs hr (hn 0) (hn 2) hl01 hl12⟩

/-- **At a rank-one `ψψᵀ` the weight is `|ψx|²`**, the record's `⟨ψψᵀx, x⟩`, so at a sum over an orthonormal basis of
`E_c` it is `⟨A_c x, x⟩`. -/
theorem isoW_rk1 (ψ : skewSub ι) (x : ι → ℝ) :
    isoW (rk1 ψ) x = ∑ k, (∑ a, (ψ : Matrix ι ι ℝ) k a * x a) ^ 2 := by
  have hψ : IsSkew (ψ : Matrix ι ι ℝ) := ψ.2
  have hin : ∀ k, inner2 ((xk x k : skewSub ι) : Matrix ι ι ℝ) (ψ : Matrix ι ι ℝ) = ∑ a, (ψ : Matrix ι ι ℝ) k a * x a := by
    intro k
    rw [xk_coe, inner2_sumL]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner2_smul_left'', inner2_comm, inner2_phi _ hψ]
    have hs : (ψ : Matrix ι ι ℝ) a k = -(ψ : Matrix ι ι ℝ) k a := by
      have := congrFun (congrFun hψ k) a
      simpa [Matrix.transpose_apply] using this
    rw [hs]; ring
  unfold isoW
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [rk1_apply, Submodule.coe_smul, i2_smul_l, inner2_comm ((ψ : skewSub ι) : Matrix ι ι ℝ), hin]
  ring

/-! ## The star clause -/

theorem inner_xk (x y : ι → ℝ) (k j : ι) :
    inner2 ((xk x k : skewSub ι) : Matrix ι ι ℝ) ((xk y j : skewSub ι) : Matrix ι ι ℝ)
      = (if k = j then ∑ a, x a * y a else 0) - y k * x j := by
  rw [xk_coe, xk_coe, inner2_sumL]
  have hterm : ∀ a b : ι, x a * y b * inner2 (phi a k) (phi b j)
      = (if a = b ∧ k = j then x a * y b else 0) - (if k = b ∧ a = j then x a * y b else 0) := by
    intro a b
    rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]
    split_ifs <;> ring
  have e : ∀ a, inner2 (x a • phi a k) (∑ b, y b • phi b j) = ∑ b, x a * y b * inner2 (phi a k) (phi b j) := by
    intro a
    rw [inner2_smul_left'', inner2_sumR, Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [inner2_smul_right'']; ring
  simp only [e, hterm, Finset.sum_sub_distrib]
  congr 1
  · by_cases hkj : k = j
    · subst hkj
      simp only [and_true, if_true]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.sum_ite_eq]; simp
    · simp [hkj]
  · rw [Finset.sum_eq_single j]
    · rw [Finset.sum_eq_single k]
      · simp; ring
      · intro b _ hb; simp [Ne.symm hb]
      · intro h; exact absurd (Finset.mem_univ k) h
    · intro a _ ha; exact Finset.sum_eq_zero fun b _ => by simp [ha]
    · intro h; exact absurd (Finset.mem_univ j) h

/-- `e ∧ u` as a bivector. -/
noncomputable def wedgeS (e u : ι → ℝ) : skewSub ι := ∑ j, u j • xk e j

theorem isoW_rk1_star (e u : ι → ℝ) (he : ∑ a, e a ^ 2 = 1) (hu : ∑ a, u a ^ 2 = 1) (heu : ∑ a, e a * u a = 0) :
    isoW (rk1 (wedgeS e u)) e = 1 := by
  have hin : ∀ k, inner2 ((xk e k : skewSub ι) : Matrix ι ι ℝ) ((wedgeS e u : skewSub ι) : Matrix ι ι ℝ) = u k := by
    intro k
    unfold wedgeS
    rw [Submodule.coe_sum, inner2_sumR]
    have e2 : ∀ j, inner2 ((xk e k : skewSub ι) : Matrix ι ι ℝ) (((u j • xk e j : skewSub ι)) : Matrix ι ι ℝ)
        = u j * ((if k = j then ∑ a, e a * e a else 0) - e k * e j) := by
      intro j
      rw [Submodule.coe_smul, inner2_smul_right'', inner_xk]
    simp only [e2, mul_sub, Finset.sum_sub_distrib, mul_ite, mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    have hee : ∑ a, e a * e a = 1 := by rw [← he]; exact Finset.sum_congr rfl fun a _ => by ring
    have hue : ∑ j, u j * (e k * e j) = e k * ∑ a, e a * u a := by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
    rw [hee, hue, heu]; ring
  unfold isoW
  have hk : ∀ k, inner2 ((rk1 (wedgeS e u) (xk e k) : skewSub ι) : Matrix ι ι ℝ) ((xk e k : skewSub ι) : Matrix ι ι ℝ)
      = u k ^ 2 := by
    intro k
    rw [rk1_apply, Submodule.coe_smul, i2_smul_l, hin, inner2_comm, hin]; ring
  rw [Finset.sum_congr rfl fun k _ => hk k, hu]

theorem isoW_mono {P Q : CurvOp2 ι} (h : IsPSD2 (P - Q)) (x : ι → ℝ) : isoW Q x ≤ isoW P x := by
  have e : P = Q + (P - Q) := by abel
  have hn := isoW_nonneg h x
  rw [e, isoW_add]
  linarith

/-- **L245's star clause.** If `E₀ ⊇ e ∧ U` with `U ⊥ e` of dimension `d`, read as `P₀` dominating the projections onto
`e ∧ u_i` for unit `u_i ⊥ e`, then `(λ₂ − λ₀)d ≤ (n − 1)λ₂`. -/
theorem L245_star {W : CurvOp2 ι} (hW : IsWeyl2 W) (P : Fin 3 → CurvOp2 ι) (lam : Fin 3 → ℝ)
    (hsum : ∑ c, P c = idOp) (hspec : ∑ c, lam c • P c = W) (hpsd : ∀ c, IsPSD2 (P c))
    (hl02 : lam 0 < lam 2) (hl12 : lam 1 ≤ lam 2) (e : ι → ℝ) (he : ∑ a, e a ^ 2 = 1)
    {d : ℕ} (u : Fin d → ι → ℝ) (hu : ∀ i, ∑ a, u i a ^ 2 = 1) (heu : ∀ i, ∑ a, e a * u i a = 0)
    (hstar : IsPSD2 (P 0 - ∑ i, rk1 (wedgeS e (u i)))) :
    (lam 2 - lam 0) * d ≤ ((Fintype.card ι : ℝ) - 1) * lam 2 := by
  obtain ⟨hs, hr, hn⟩ := L245_op hW P lam hsum hspec hpsd e he
  have hd : (d : ℝ) ≤ isoW (P 0) e := by
    have h := isoW_mono hstar e
    rw [isoW_sum] at h
    simp only [fun i => isoW_rk1_star e (u i) he (hu i) (heu i), Finset.sum_const, Finset.card_univ,
      Fintype.card_fin, nsmul_eq_mul, mul_one] at h
    exact h
  exact HamiltonsCubic.L245SymmetricIsotropy.star_h0 _ _ _ _ _ _ _ _ (by rw [hs]) hr (hn 1) hl02 hl12 hd

/-- **A star in any class weighs at least its dimension**: `P` dominating the projections onto `e ∧ u_i` gives
`Ric(P)(e, e) ≥ d`. -/
theorem star_weight {P : CurvOp2 ι} (e : ι → ℝ) (he : ∑ a, e a ^ 2 = 1)
    {d : ℕ} (u : Fin d → ι → ℝ) (hu : ∀ i, ∑ a, u i a ^ 2 = 1) (heu : ∀ i, ∑ a, e a * u i a = 0)
    (hstar : IsPSD2 (P - ∑ i, rk1 (wedgeS e (u i)))) : (d : ℝ) ≤ isoW P e := by
  have h := isoW_mono hstar e
  rw [isoW_sum] at h
  simp only [fun i => isoW_rk1_star e (u i) he (hu i) (heu i), Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul, mul_one] at h
  exact h

/-- **The star clause at `E₂`**: `(λ₂ − λ₀)d ≤ (n − 1)(−λ₀)`. -/
theorem L245_star_two {W : CurvOp2 ι} (hW : IsWeyl2 W) (P : Fin 3 → CurvOp2 ι) (lam : Fin 3 → ℝ)
    (hsum : ∑ c, P c = idOp) (hspec : ∑ c, lam c • P c = W) (hpsd : ∀ c, IsPSD2 (P c))
    (hl01 : lam 0 ≤ lam 1) (hl12 : lam 1 ≤ lam 2) (e : ι → ℝ) (he : ∑ a, e a ^ 2 = 1)
    {d : ℕ} (u : Fin d → ι → ℝ) (hu : ∀ i, ∑ a, u i a ^ 2 = 1) (heu : ∀ i, ∑ a, e a * u i a = 0)
    (hstar : IsPSD2 (P 2 - ∑ i, rk1 (wedgeS e (u i)))) :
    (lam 2 - lam 0) * d ≤ ((Fintype.card ι : ℝ) - 1) * (-lam 0) := by
  obtain ⟨hs, hr, hn⟩ := L245_op hW P lam hsum hspec hpsd e he
  have hd := star_weight e he u hu heu hstar
  have h2 := HamiltonsCubic.L245SymmetricIsotropy.ceiling_h2 _ _ _ _ _ _ _ hs hr (hn 1) hl01
  have hl : 0 ≤ lam 2 - lam 0 := by linarith
  nlinarith [mul_le_mul_of_nonneg_left hd hl]

/-- **The star clause at `E₁`**: both halves of `h₁`, `(λ₁ − λ₀)d ≤ (n − 1)(−λ₀)` and `(λ₂ − λ₁)d ≤ (n − 1)λ₂`. -/
theorem L245_star_one {W : CurvOp2 ι} (hW : IsWeyl2 W) (P : Fin 3 → CurvOp2 ι) (lam : Fin 3 → ℝ)
    (hsum : ∑ c, P c = idOp) (hspec : ∑ c, lam c • P c = W) (hpsd : ∀ c, IsPSD2 (P c))
    (hl01 : lam 0 ≤ lam 1) (hl12 : lam 1 ≤ lam 2) (e : ι → ℝ) (he : ∑ a, e a ^ 2 = 1)
    {d : ℕ} (u : Fin d → ι → ℝ) (hu : ∀ i, ∑ a, u i a ^ 2 = 1) (heu : ∀ i, ∑ a, e a * u i a = 0)
    (hstar : IsPSD2 (P 1 - ∑ i, rk1 (wedgeS e (u i)))) :
    (lam 1 - lam 0) * d ≤ ((Fintype.card ι : ℝ) - 1) * (-lam 0) ∧
      (lam 2 - lam 1) * d ≤ ((Fintype.card ι : ℝ) - 1) * lam 2 := by
  obtain ⟨hs, hr, hn⟩ := L245_op hW P lam hsum hspec hpsd e he
  have hd := star_weight e he u hu heu hstar
  obtain ⟨h1, h2⟩ := HamiltonsCubic.L245SymmetricIsotropy.ceiling_h1 _ _ _ _ _ _ _ hs hr (hn 0) (hn 2) hl01 hl12
  exact ⟨by nlinarith [mul_le_mul_of_nonneg_left hd (sub_nonneg.mpr hl01)],
    by nlinarith [mul_le_mul_of_nonneg_left hd (sub_nonneg.mpr hl12)]⟩

end HamiltonsCubic.L245Op
