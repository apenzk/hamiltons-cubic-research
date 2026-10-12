import HamiltonsCubic.Results.OrbitDeriv

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# `D = [ad A, ·]` preserves `𝒲ₙ`, so the orbit tangent of a critical point is a `½`-eigenvector in `𝒲ₙ`

[OrbitDeriv.lean](OrbitDeriv.lean) proves the Fox form invariant under `D R = [A, R ·] − R [A, ·]` and derives
`orbit_half` on any class closed under `D`. **This file proves `𝒲ₙ` is such a class**, the infinitesimal form of
[WeylAction.lean](WeylAction.lean)'s `act_mem`, by index calculus in the `φ` basis:

- `br_phi_expand`: `[A, φ_ij] = ∑_m (A_mi φ_mj + A_mj φ_im)` at skew `A`;
- `Dop_coord`: `⟨DR φ_ij, φ_kl⟩ = −∑_m (A_mk R_ijml + A_ml R_ijkm + A_mi R_mjkl + A_mj R_imkl)`;
- `bianchi_Dop`: the Bianchi sum of `DR` is `−∑_m` of `A` against four Bianchi sums of `R`;
- `ric_Dop`: the Ricci contraction of `DR` is `A` against the Ricci contraction of `R`, the two inner terms
  cancelling by the skewness of `A`;
- `sym_Dop`, and with `Dop_lin` and `Dop_skew`, **`Dop_weylOp`**: `IsWeylOp R → IsWeylOp (Dop A R)`;
- **`orbit_half_weyl`**: at `u` critical on `𝒲ₙ`, `T(Du, u, r) = (θ/2)⟨Du, r⟩` for every `r ∈ 𝒲ₙ`.
-/

namespace HamiltonsCubic.OrbitDeriv

open Finset Matrix HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem br_phi_expand (A : Matrix ι ι ℝ) (hA : IsSkew A) (i j : ι) :
    br A (phi i j) = ∑ m, (A m i • phi m j + A m j • phi i m) := by
  have hA' : ∀ a b, A a b = -A b a := fun a b => by
    have := congrFun (congrFun hA b) a; simpa [Matrix.transpose_apply] using this
  ext a b
  simp only [br, phi, Matrix.sub_apply, Matrix.mul_apply, Matrix.sum_apply, Matrix.add_apply,
    Matrix.smul_apply, Matrix.single_apply, smul_eq_mul, mul_sub, sub_mul, Finset.sum_sub_distrib,
    Finset.sum_add_distrib, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul, ite_and]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, Finset.sum_ite_irrel, Finset.sum_const_zero]
  rw [hA' b i, hA' b j]
  clear hA' hA
  split_ifs <;> subst_vars <;> ring

theorem linOp_sum (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (f : ι → Matrix ι ι ℝ) :
    R (∑ m, f m) = ∑ m, R (f m) := by
  let L : Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ := ⟨⟨R, hR.1⟩, hR.2⟩
  exact map_sum L f Finset.univ

/-- **The coordinates of `D R`**: `⟨DR φ_ij, φ_kl⟩ = −∑_m (A_mk R_ijml + A_ml R_ijkm + A_mi R_mjkl + A_mj R_imkl)`. -/
theorem Dop_coord (A : Matrix ι ι ℝ) (hA : IsSkew A) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (i j k l : ι) :
    inner2 (Dop A R (phi i j)) (phi k l) = -∑ m, (A m k * inner2 (R (phi i j)) (phi m l)
      + A m l * inner2 (R (phi i j)) (phi k m) + A m i * inner2 (R (phi m j)) (phi k l)
      + A m j * inner2 (R (phi i m)) (phi k l)) := by
  unfold Dop
  rw [inner2_sub_l', HamiltonsCubic.Results.inner2_br_skew A _ _ hA, br_phi_expand A hA k l,
    br_phi_expand A hA i j, linOp_sum R hR]
  simp only [hR.1, hR.2, inner2_sum_r', inner2_sum_l', inner2_add_r', inner2_add_l', inner2_smul_r',
    inner2_smul_l', ← Finset.sum_neg_distrib, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  ring

theorem bianchi_Dop (A : Matrix ι ι ℝ) (hA : IsSkew A) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hb : ∀ i j k l, bianchi R i j k l = 0) (i j k l : ι) : bianchi (Dop A R) i j k l = 0 := by
  have e : bianchi (Dop A R) i j k l = -∑ m, (A m i * bianchi R m j k l + A m j * bianchi R i m k l
      + A m k * bianchi R i j m l + A m l * bianchi R i j k m) := by
    unfold bianchi
    rw [Dop_coord A hA R hR, Dop_coord A hA R hR, Dop_coord A hA R hR, ← neg_add, ← neg_add,
      ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    congr 1
    refine Finset.sum_congr rfl fun m _ => ?_
    ring
  rw [e]; simp [hb]

theorem ric_Dop (A : Matrix ι ι ℝ) (hA : IsSkew A) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hric : ∀ a b, Ric R a b = 0) (a b : ι) : Ric (Dop A R) a b = 0 := by
  have hA' : ∀ x y, A x y = -A y x := fun x y => by
    have := congrFun (congrFun hA y) x; simpa [Matrix.transpose_apply] using this
  unfold Ric
  simp only [Dop_coord A hA R hR, Finset.sum_neg_distrib, Finset.sum_add_distrib]
  have h1 : ∑ c, ∑ m, A m b * inner2 (R (phi a c)) (phi m c) = ∑ m, A m b * Ric R a m := by
    rw [Finset.sum_comm]; simp only [Ric, Finset.mul_sum]
  have h2 : ∑ c, ∑ m, A m a * inner2 (R (phi m c)) (phi b c) = ∑ m, A m a * Ric R m b := by
    rw [Finset.sum_comm]; simp only [Ric, Finset.mul_sum]
  have h3 : ∑ c, ∑ m, A m c * inner2 (R (phi a m)) (phi b c) = -∑ c, ∑ m, A m c * inner2 (R (phi a c)) (phi b m) := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [hA' c m]; ring
  rw [h1, h2, h3]
  simp [hric]

theorem sym_Dop (A : Matrix ι ι ℝ) (hA : IsSkew A) (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) : inner2 (Dop A R X) Y = inner2 X (Dop A R Y) := by
  have sX := HamiltonsCubic.Results.br_isSkew_real A X hA hX
  have sY := HamiltonsCubic.Results.br_isSkew_real A Y hA hY
  unfold Dop
  rw [inner2_sub_l', inner2_comm X, inner2_sub_l', HamiltonsCubic.Results.inner2_br_skew A _ _ hA,
    HamiltonsCubic.Results.inner2_br_skew A _ _ hA, hsym _ _ sX hY, hsym _ _ hX sY]
  have c1 := inner2_comm (R Y) (br A X)
  have c2 := inner2_comm (R (br A Y)) X
  have c3 := inner2_comm (R X) (br A Y)
  linarith

/-- **`D = [ad A, ·]` PRESERVES `𝒲ₙ`** at skew `A`: the infinitesimal form of `act_mem`. -/
theorem Dop_weylOp (A : Matrix ι ι ℝ) (hA : IsSkew A) (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsWeylOp R) :
    IsWeylOp (Dop A R) := by
  obtain ⟨hl, hs, hsym, hb, hric⟩ := hR
  exact ⟨Dop_lin A R hl, Dop_skew A hA R hs, fun X Y hX hY => sym_Dop A hA R hsym X Y hX hY,
    bianchi_Dop A hA R hl hb, ric_Dop A hA R hl hric⟩

/-- **L25's equivariance step on `𝒲ₙ`**: if `T(u, u, r) = θ⟨u, r⟩` for every `r ∈ 𝒲ₙ`, then
`T(Du, u, r) = (θ/2)⟨Du, r⟩` for every `r ∈ 𝒲ₙ`, and `Du ∈ 𝒲ₙ`. -/
theorem orbit_half_weyl (A : Matrix ι ι ℝ) (hA : IsSkew A) (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hu : IsWeylOp u)
    (θ : ℝ) (hcrit : ∀ r, IsWeylOp r → foxTri u u r = θ * innerOp u r) :
    IsWeylOp (Dop A u) ∧ ∀ r, IsWeylOp r → foxTri (Dop A u) u r = (θ / 2) * innerOp (Dop A u) r :=
  ⟨Dop_weylOp A hA u hu, orbit_half A hA u hu.1 θ IsWeylOp (fun r hr => ⟨hr.1, hr.2.1⟩)
    (fun r hr => Dop_weylOp A hA r hr) hcrit⟩

end HamiltonsCubic.OrbitDeriv
