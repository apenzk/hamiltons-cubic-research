import Mathlib
import HamiltonsCubic.Results.L216IsolationRadius
import HamiltonsCubic.Results.L214Op

set_option linter.style.longLine false

/-!
# L216: Bernstein's inequality on the great circle, and step 5 on `P` itself

[findings/second-order.md](../../../findings/second-order.md), the L216 block: along the great circle
$\varphi(\sigma)=P(\cos\sigma\,W_1+\sin\sigma\,H)$, *"$\lvert\varphi'''\rvert\le27M$ by Bernstein"*, $M$ bounding
$\lvert P\rvert$ on the unit sphere. [L216IsolationRadius.lean](L216IsolationRadius.lean) proves the calculus of step 5
with that bound as the hypothesis `hbern`, noting Bernstein's inequality for trigonometric polynomials is absent from
Mathlib. This file proves it for the case at hand:

* `cub`, `Dq`, `hasDerivAt_cub`: $\varphi(\sigma)=F(\cos\sigma,\sin\sigma)$ for a binary cubic form $F$ has derivative
  $(DF)(\cos\sigma,\sin\sigma)$, $DF=F_x\cdot(-y)+F_y\cdot x$ again a cubic form;
* `riesz`: M. Riesz's interpolation formula at degree three, $DF(v)=\sum_k\lambda_kF(R_{t_k}v)$ at
  $t_k=(2k+1)\pi/6$, a polynomial identity for cubic forms, with $\sum_k\lvert\lambda_k\rvert=3$ (`sum_abs_lk`);
* `bern1`, `bern3`: $\lvert DF\rvert\le3\sup\lvert F\rvert$ and $\lvert D^3F\rvert\le27\sup\lvert F\rvert$ on the unit
  circle;
* `no_critical_in_tube_cubic`: step 5 with `hbern` discharged for every such $\varphi$;
* `qP`, `P_plane`, `P_plane_bound`, `plane_unit`, `hasDerivAt_P`, `no_critical_in_tube_P`: $P(xW+yH)$ is the cubic
  form with coefficients $(P(W),3T(W,W,H),3T(W,H,H),P(H))$, bounded by $M$ on the circle when
  $\lvert P\rvert\le M$ on the plane's unit circle (for orthonormal Weyl $W,H$ that circle lies in the unit Weyl
  sphere, where L143 bounds $P$), so step 5 holds along $\sigma\mapsto P(\cos\sigma\,W+\sin\sigma\,H)$ from
  $T(W,W,H)=0$ and $6T(W,H,H)-3P(W)\le-6\theta\gamma$;
* `no_critical_in_tube_crit`: at a unit self-adjoint $W$ with $Q(W)=\theta W$ those two come from criticality
  (`Tsym_crit`) and the gap in the form $T(W,H,H)\le\theta(\tfrac12-\gamma)$.

Step 1 (the attained distance, the normal geodesic, equivariance), L143's value of $M$, and the gap's reading as
$T(W,H,H)\le\theta(\tfrac12-\gamma)$ through L24's Hessian $T(W,H,H)=\theta\langle L_eH,H\rangle$ stay with the record.
-/

namespace HamiltonsCubic.L216Bern

open Real

/-- A binary cubic form `q₀x³ + q₁x²y + q₂xy² + q₃y³`. -/
def cub (q : Fin 4 → ℝ) (x y : ℝ) : ℝ := q 0 * x ^ 3 + q 1 * (x ^ 2 * y) + q 2 * (x * y ^ 2) + q 3 * y ^ 3

/-- The rotation derivative `F_x·(-y) + F_y·x` of a cubic form, again a cubic form. -/
def Dq (q : Fin 4 → ℝ) : Fin 4 → ℝ := ![q 1, 2 * q 2 - 3 * q 0, 3 * q 3 - 2 * q 1, -q 2]

theorem hasDerivAt_cub (q : Fin 4 → ℝ) (σ : ℝ) :
    HasDerivAt (fun σ => cub q (cos σ) (sin σ)) (cub (Dq q) (cos σ) (sin σ)) σ := by
  have hc := hasDerivAt_cos σ
  have hs := hasDerivAt_sin σ
  have h := ((((hc.pow 3).const_mul (q 0)).add (((hc.pow 2).mul hs).const_mul (q 1))).add
    ((hc.mul (hs.pow 2)).const_mul (q 2))).add ((hs.pow 3).const_mul (q 3))
  refine h.congr_deriv ?_
  simp only [cub, Dq, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_two,
    Matrix.cons_val_three, Function.comp, Pi.pow_apply, Nat.cast_ofNat, Matrix.cons_val_succ, Matrix.head_cons]
  ring

/-- The six nodes `t_k = (2k+1)π/6` of M. Riesz's interpolation formula at degree three, as `(cos t_k, sin t_k)`. -/
noncomputable def ck : Fin 6 → ℝ := ![√3 / 2, 0, -(√3 / 2), -(√3 / 2), 0, √3 / 2]
noncomputable def sk : Fin 6 → ℝ := ![1 / 2, 1, 1 / 2, -(1 / 2), -1, -(1 / 2)]

/-- Riesz's weights `(-1)^k / (12 sin²(t_k/2))`. -/
noncomputable def lk : Fin 6 → ℝ := ![(2 + √3) / 3, -(1 / 6), (2 - √3) / 3, -((2 - √3) / 3), 1 / 6, -((2 + √3) / 3)]

/-- **M. Riesz's interpolation formula for cubic forms**: `D F(x, y) = ∑ λ_k F(R_{t_k}(x, y))`. -/
theorem riesz (q : Fin 4 → ℝ) (x y : ℝ) :
    cub (Dq q) x y = ∑ k, lk k * cub q (x * ck k - y * sk k) (y * ck k + x * sk k) := by
  have hr : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hr3 : √3 ^ 3 = 3 * √3 := by rw [pow_succ, hr]
  have hr4 : √3 ^ 4 = 9 := by rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul, hr]; norm_num
  simp only [Fin.sum_univ_succ, Fin.sum_univ_zero, ck, sk, lk, cub, Dq, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, Matrix.cons_val_succ, Matrix.head_cons,
    Fin.succ_zero_eq_one, Fin.succ_one_eq_two, Matrix.vecHead, Matrix.vecTail, Function.comp]
  ring_nf
  simp only [hr, hr3, hr4]
  ring

theorem node_unit (k : Fin 6) : ck k ^ 2 + sk k ^ 2 = 1 := by
  have hr : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  fin_cases k <;> simp [ck, sk, Matrix.vecHead, Matrix.vecTail] <;> nlinarith [hr]

theorem sum_abs_lk : ∑ k, |lk k| = 3 := by
  have h3 : √3 < 2 := by
    rw [show (2 : ℝ) = √4 by rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  have h0 : 0 ≤ √3 := Real.sqrt_nonneg 3
  simp only [Fin.sum_univ_succ, Fin.sum_univ_zero, lk, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_succ,
    Matrix.head_cons, Fin.succ_zero_eq_one, Fin.succ_one_eq_two]
  rw [abs_of_pos (by linarith), abs_of_neg (by norm_num), abs_of_pos (by linarith), abs_of_neg (by linarith),
    abs_of_pos (by norm_num), abs_of_neg (by linarith)]
  ring

/-- **Bernstein's inequality for a cubic form on the circle**: `|D F| ≤ 3 sup |F|`. -/
theorem bern1 (q : Fin 4 → ℝ) (M : ℝ) (hM : ∀ x y, x ^ 2 + y ^ 2 = 1 → |cub q x y| ≤ M) (x y : ℝ)
    (hxy : x ^ 2 + y ^ 2 = 1) : |cub (Dq q) x y| ≤ 3 * M := by
  rw [riesz]
  calc |∑ k, lk k * cub q (x * ck k - y * sk k) (y * ck k + x * sk k)|
      ≤ ∑ k, |lk k * cub q (x * ck k - y * sk k) (y * ck k + x * sk k)| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ k, |lk k| * M := Finset.sum_le_sum fun k _ => by
        rw [abs_mul]
        refine mul_le_mul_of_nonneg_left (hM _ _ ?_) (abs_nonneg _)
        have := node_unit k
        linear_combination (ck k ^ 2 + sk k ^ 2) * hxy + this
    _ = 3 * M := by rw [← Finset.sum_mul, sum_abs_lk]

/-- **Bernstein three times**: `|D³ F| ≤ 27 sup |F|` on the circle. -/
theorem bern3 (q : Fin 4 → ℝ) (M : ℝ) (hM : ∀ x y, x ^ 2 + y ^ 2 = 1 → |cub q x y| ≤ M) (x y : ℝ)
    (hxy : x ^ 2 + y ^ 2 = 1) : |cub (Dq (Dq (Dq q))) x y| ≤ 27 * M := by
  have h1 := bern1 q M hM
  have h2 := bern1 (Dq q) (3 * M) h1
  have h3 := bern1 (Dq (Dq q)) (3 * (3 * M)) h2 x y hxy
  linarith

/-- **L216's step 5 with Bernstein discharged.** Along `φ(σ) = F(cos σ, sin σ)` with `F` a binary cubic form bounded
by `M` on the unit circle, `φ'(0) = 0` and `φ''(0) ≤ -6θγ` give `φ'(s) < 0` for `0 < s < 4θγ/(9M)`. -/
theorem no_critical_in_tube_cubic (q : Fin 4 → ℝ) {θ γ M s : ℝ} (hM0 : 0 < M)
    (hM : ∀ x y, x ^ 2 + y ^ 2 = 1 → |cub q x y| ≤ M)
    (h0 : cub (Dq q) (cos 0) (sin 0) = 0) (h1 : cub (Dq (Dq q)) (cos 0) (sin 0) ≤ -(6 * θ * γ))
    (hs0 : 0 < s) (hsr : s < 4 * θ * γ / (9 * M)) :
    cub (Dq q) (cos s) (sin s) < 0 :=
  HamiltonsCubic.Results.no_critical_in_tube (f := fun σ => cub (Dq q) (cos σ) (sin σ))
    (f1 := fun σ => cub (Dq (Dq q)) (cos σ) (sin σ)) (f2 := fun σ => cub (Dq (Dq (Dq q))) (cos σ) (sin σ))
    (fun u => hasDerivAt_cub (Dq q) u) (fun u => hasDerivAt_cub (Dq (Dq q)) u) hM0
    (fun u _ => le_trans (le_abs_self _) (bern3 q M hM _ _ (sin_sq_add_cos_sq u ▸ by ring)))
    h0 h1 hs0 hsr

section OnP

open HamiltonsCubic.RealLayer HamiltonsCubic.L214Op

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The cubic form of `P` on the plane of `W` and `H`. -/
noncomputable def qP (W H : CurvOp2 ι) : Fin 4 → ℝ := ![Pcubic2 W, 3 * Tsym W W H, 3 * Tsym W H H, Pcubic2 H]

/-- **`P` on a great circle is a binary cubic form**: `P(xW + yH) = cub (qP W H) x y`. -/
theorem P_plane (W H : CurvOp2 ι) (x y : ℝ) : Pcubic2 (x • W + y • H) = cub (qP W H) x y := by
  rw [← Tsym_diag]
  simp only [Tsym_add_left, Tsym_add_mid, Tsym_add_right, Tsym_smul_left, Tsym_smul_mid, Tsym_smul_right]
  rw [Tsym_12 H W W, Tsym_23 W H W, Tsym_12 H W H, Tsym_12 H H W, Tsym_23 W H H]
  simp only [cub, qP, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_succ, Matrix.head_cons,
    Fin.succ_zero_eq_one, Fin.succ_one_eq_two, Matrix.vecHead, Matrix.vecTail, Function.comp, ← Tsym_diag,
    Matrix.cons_val_two, Matrix.cons_val_three]
  have e : Tsym H H W = Tsym W H H := by rw [Tsym_23, Tsym_12]
  rw [e]
  ring

/-- A bound `|P| ≤ M` on the unit circle of the plane of `W`, `H` bounds the form on the unit circle. For orthonormal
Weyl `W`, `H` the plane's unit circle lies in the unit Weyl sphere, where L143 bounds `P`. -/
theorem P_plane_bound (W H : CurvOp2 ι) (M : ℝ)
    (hM : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 → |Pcubic2 (x • W + y • H)| ≤ M) :
    ∀ x y, x ^ 2 + y ^ 2 = 1 → |cub (qP W H) x y| ≤ M := fun x y hxy => by
  rw [← P_plane]; exact hM x y hxy

/-- The plane of orthonormal `W`, `H` meets the unit sphere in its unit circle. -/
theorem plane_unit (W H : CurvOp2 ι) (hW : normSq2 W = 1) (hH : normSq2 H = 1) (hWH : innerOp2 W H = 0) (x y : ℝ)
    (hxy : x ^ 2 + y ^ 2 = 1) : normSq2 (x • W + y • H) = 1 := by
  have hHW : innerOp2 H W = 0 := by rw [innerOp2_comm]; exact hWH
  show innerOp2 (x • W + y • H) (x • W + y • H) = 1
  simp only [innerOp2_add_left, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_right, hWH, hHW]
  unfold normSq2 at hW hH
  rw [hW, hH]
  linear_combination hxy

/-- The derivative of `σ ↦ P(cos σ W + sin σ H)`. -/
theorem hasDerivAt_P (W H : CurvOp2 ι) (σ : ℝ) :
    HasDerivAt (fun σ => Pcubic2 (cos σ • W + sin σ • H)) (cub (Dq (qP W H)) (cos σ) (sin σ)) σ := by
  simp only [P_plane]
  exact hasDerivAt_cub _ σ

/-- **L216's step 5 on `P` itself.** With `|P| ≤ M` on the unit circle of the plane of `W`, `H`, along
`σ ↦ P(cos σ W + sin σ H)`, `φ'(0) = 3T(W, W, H) = 0` and `φ''(0) = 6T(W, H, H) - 3P(W) ≤ -6θγ` give `φ'(s) < 0` for
`0 < s < 4θγ/(9M)`, `φ'` being the derivative `hasDerivAt_P` names. -/
theorem no_critical_in_tube_P (W H : CurvOp2 ι)
    {θ γ M s : ℝ} (hM0 : 0 < M) (hM : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 → |Pcubic2 (x • W + y • H)| ≤ M)
    (h0 : Tsym W W H = 0) (h1 : 6 * Tsym W H H - 3 * Pcubic2 W ≤ -(6 * θ * γ))
    (hs0 : 0 < s) (hsr : s < 4 * θ * γ / (9 * M)) :
    cub (Dq (qP W H)) (cos s) (sin s) < 0 := by
  refine no_critical_in_tube_cubic (qP W H) hM0 (P_plane_bound W H M hM) ?_ ?_ hs0 hsr
  · simp [cub, Dq, qP, h0]
  · simp [cub, Dq, qP]
    linarith

/-- **Step 5 at a critical point, from the gap.** At a unit self-adjoint `W` with `Q(W) = θW`, a unit `H ⊥ W` with
the gap `T(W, H, H) ≤ θ(½ - γ)` gives `φ'(s) < 0` on `0 < s < 4θγ/(9M)`: `φ'(0) = 3T(W, W, H) = 3θ⟨W, H⟩ = 0` by
`Tsym_crit`, and `φ''(0) = 6T(W, H, H) - 3P(W) ≤ -6θγ` with `P(W) = θ`. -/
theorem no_critical_in_tube_crit (W H : CurvOp2 ι) (hWs : IsSelfAdjoint2 W) {θ γ M s : ℝ} (hQ : Qop2 W = θ • W)
    (hW : normSq2 W = 1) (hWH : innerOp2 W H = 0)
    (hM0 : 0 < M) (hM : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 → |Pcubic2 (x • W + y • H)| ≤ M)
    (hgap : Tsym W H H ≤ θ * (1 / 2 - γ)) (hs0 : 0 < s) (hsr : s < 4 * θ * γ / (9 * M)) :
    cub (Dq (qP W H)) (cos s) (sin s) < 0 := by
  have hPW : Pcubic2 W = θ := by
    rw [← Tsym_diag, Tsym_crit hWs hQ, show innerOp2 W W = normSq2 W from rfl, hW, mul_one]
  refine no_critical_in_tube_P W H hM0 hM ?_ ?_ hs0 hsr
  · rw [Tsym_crit hWs hQ, hWH, mul_zero]
  · rw [hPW]; linarith

end OnP

end HamiltonsCubic.L216Bern
