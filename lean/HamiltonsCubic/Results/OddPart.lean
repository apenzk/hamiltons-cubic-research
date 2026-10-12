import Mathlib
import HamiltonsCubic.Results.ItemFour
import HamiltonsCubic.Results.L222Swap

set_option linter.style.longLine false

/-!
# L222 item 4's identification: the swap-odd part of `𝒟_n` is `{D⁻_y : Σ y = 0}`

[findings/second-order.md](../../../findings/second-order.md), Lemma L222: *$D=D^++D^-$ its even and odd parts, the odd part having
entries $K_{ja}=-K_{ka}$*, and item 4: *on the odd part, identified with $\{y:\sum y=0\}$, $L_{G_x}$ acts as
$y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$.* [ItemFour.lean](ItemFour.lean) proves the action on $D^-_y$; this file
proves that the swap-odd Weyl operators of character $1$ are exactly the $D^-_y$ with $\sum y=0$, $y$ zero at $j,k$.

* `coordOp_weight_eq`: a coordinate operator determines its symmetric weight off the diagonal;
* `rotR_swap_coordOp`: the swap of $j,k$ permutes the weight, $w\mapsto w_{\sigma p,\sigma q}$;
* **`odd_eq_Dminus`**: a Weyl operator of character $1$ with $\sigma\cdot V=-V$ is $D^-_y$, $y_a=K_{ja}$ off $\{j,k\}$ and $\sum y=0$;
* **`Dminus_swap_odd`**: conversely $\sigma\cdot D^-_y=-D^-_y$;
* `Dminus_weight`, `Dminus_charOne`, **`odd_iff`**: $D^-_y$ with $\sum y=0$ is Weyl of character $1$, so the odd part is exactly $\{D^-_y\}$;
* **`LG_odd`**: item 4 on the odd part as the record states it, $G_x\circ V=D^-_z$, $z=\tfrac12\lVert x\rVert^2y+\langle x,y\rangle x$;
* `LG_sum`: $\sum z=\tfrac12\lVert x\rVert^2\sum y+\langle x,y\rangle\sum x$, so the map keeps $\{\sum y=0\}$ when $\sum x=0$;
* **`odd_half_eq_Dminus`**, **`Q_odd_half`**: at a Weyl $D$ of character $1$, L224's $D^-=\tfrac12(D-\sigma D)$ is $D^-_y$ with
  $\sum y=0$, and $D^-\circ D^-=G_y$.
-/

namespace HamiltonsCubic.OddPart

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.FrameOp2 HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent
  HamiltonsCubic.ItemFour HamiltonsCubic.L222Swap HamiltonsCubic.L120Hess HamiltonsCubic.L222Op

variable {n : ℕ} {j k : Fin n}

/-- **A coordinate operator determines its symmetric weight off the diagonal.** -/
theorem coordOp_weight_eq {a b : Matrix (Fin n) (Fin n) ℝ} (ha : aᵀ = a) (hb : bᵀ = b) (h : coordOp a = coordOp b)
    {p q : Fin n} (hpq : p ≠ q) : a p q = b p q := by
  have e := congrArg (fun T : CurvOp2 (Fin n) =>
    ((T ⟨phi q p, phi_mem_skewSub q p⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) p q) h
  simp only [coordOp_coe a ha, coordOp_coe b hb, Matrix.hadamard_apply, phi, Matrix.sub_apply,
    Matrix.single_apply] at e
  simpa [hpq, Ne.symm hpq] using e

theorem swapM_entry' (j k : Fin n) (A : Matrix (Fin n) (Fin n) ℝ) (p q : Fin n) :
    (swapM j k * A * swapM j k) p q = A (Equiv.swap j k p) (Equiv.swap j k q) := by
  simpa [swapM_T] using swapM_entry j k A p q

/-- **The swap permutes a coordinate operator's weight.** -/
theorem rotR_swap_coordOp (j k : Fin n) (a : Matrix (Fin n) (Fin n) ℝ) (ha : aᵀ = a) :
    rotR (swapM j k) (coordOp a) = coordOp (Matrix.of fun p q => a (Equiv.swap j k p) (Equiv.swap j k q)) := by
  have hs : (Matrix.of fun p q => a (Equiv.swap j k p) (Equiv.swap j k q))ᵀ
      = Matrix.of fun p q => a (Equiv.swap j k p) (Equiv.swap j k q) := by
    ext p q; simp only [Matrix.transpose_apply, Matrix.of_apply]
    rw [← Matrix.transpose_apply a (Equiv.swap j k q) (Equiv.swap j k p), ha]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe, coordOp_coe a ha, cU_coe, coordOp_coe _ hs, swapM_T]
  ext p q
  rw [swapM_entry', Matrix.hadamard_apply, Matrix.hadamard_apply, swapM_entry', Matrix.of_apply,
    Equiv.swap_apply_self, Equiv.swap_apply_self]

/-- **L222, the odd part**: a Weyl operator of character `1` that the swap of `j, k` negates is `D⁻_y`, with `y`
zero at `j, k`, `y_a = w_{ja}` off them, and `Σ y = 0`. -/
theorem odd_eq_Dminus (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V) (hV : SignChar (fun _ => 1) V)
    (hodd : rotR (swapM j k) V = -V) :
    ∃ y : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ V = coordOp (Dminus j k y) := by
  obtain ⟨w, hw, rfl⟩ := (L120Ident.trivial_block_iff V hVW).mp hV
  rw [← coordOp_eq_restrict hw] at hodd ⊢
  have hT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  have hnT : ((-1 : ℝ) • w)ᵀ = (-1 : ℝ) • w := by rw [Matrix.transpose_smul, hT]
  have hsT : (Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q))ᵀ
      = Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q) := by
    ext p q; simp only [Matrix.transpose_apply, Matrix.of_apply]; exact hw.symm _ _
  have hneg : -coordOp w = coordOp ((-1 : ℝ) • w) := by rw [coordOp_smul']; module
  rw [rotR_swap_coordOp j k w hT, hneg] at hodd
  have hodd' : ∀ p q, p ≠ q → w (Equiv.swap j k p) (Equiv.swap j k q) = -w p q := fun p q hpq => by
    have := coordOp_weight_eq hsT hnT hodd hpq
    simpa [Matrix.of_apply, Matrix.smul_apply] using this
  have hjk0 : w j k = 0 := by
    have := hodd' j k hjk
    rw [Equiv.swap_apply_left, Equiv.swap_apply_right, hw.symm k j] at this
    linarith
  have hka : ∀ a, a ≠ j → a ≠ k → w k a = -w j a := fun a h1 h2 => by
    have := hodd' j a (Ne.symm h1)
    rwa [Equiv.swap_apply_left, Equiv.swap_apply_of_ne_of_ne h1 h2] at this
  have hab : ∀ a b, a ≠ j → a ≠ k → b ≠ j → b ≠ k → a ≠ b → w a b = 0 := fun a b h1 h2 h3 h4 hab => by
    have := hodd' a b hab
    rw [Equiv.swap_apply_of_ne_of_ne h1 h2, Equiv.swap_apply_of_ne_of_ne h3 h4] at this
    linarith
  set y : Fin n → ℝ := fun i => if i = j ∨ i = k then 0 else w j i with hy
  have hyj : y j = 0 := by simp [hy]
  have hyk : y k = 0 := by simp [hy]
  have hyo : ∀ i, i ≠ j → i ≠ k → y i = w j i := fun i h1 h2 => by simp [hy, h1, h2]
  refine ⟨y, hyj, hyk, ?_, ?_⟩
  · have e : ∀ i, y i = w j i - if i = k then w j k else 0 := fun i => by
      by_cases h1 : i = j
      · subst h1; simp [hyj, hw.hollow, hjk]
      · by_cases h2 : i = k
        · subst h2; simp [hyk]
        · rw [hyo i h1 h2, if_neg h2]; ring
    rw [Finset.sum_congr rfl fun i _ => e i, Finset.sum_sub_distrib, hw.rowSum j, Finset.sum_ite_eq']
    simp [hjk0]
  · have hvy : vy j k y = y := vy_of_zero y hyj hyk
    apply coordOp_congr_off
    intro p q hpq
    simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, hvy, uj]
    by_cases hpj : p = j
    · subst hpj
      by_cases hqk : q = k
      · subst hqk; simp [hyj, hyk, hjk0, Ne.symm hjk]
      · have hqj : q ≠ p := Ne.symm hpq
        simp [hyj, hyo q hqj hqk, hqj, hqk]
    · by_cases hpk : p = k
      · subst hpk
        by_cases hqj : q = j
        · subst hqj; rw [hw.symm]; simp [hyj, hyk, hjk0, hpj]
        · have hqk : q ≠ p := Ne.symm hpq
          simp [hyk, hyo q hqj hqk, hqj, hqk, hpj, hka q hqj hqk]
      · by_cases hqj : q = j
        · subst hqj; rw [hw.symm]; simp [hyj, hyo p hpj hpk, hpj, hpk]
        · by_cases hqk : q = k
          · subst hqk; rw [hw.symm, hka p hpj hpk]; simp [hyk, hyo p hpj hpk, hpj, hpk, hqj]
          · simp [hyo p hpj hpk, hyo q hqj hqk, hpj, hpk, hqj, hqk, hab p q hpj hpk hqj hqk hpq]

/-- **`D⁻_y` is swap-odd.** -/
theorem Dminus_swap_odd (hjk : j ≠ k) (y : Fin n → ℝ) :
    rotR (swapM j k) (coordOp (Dminus j k y)) = -coordOp (Dminus j k y) := by
  have hT : (Dminus j k y)ᵀ = Dminus j k y := vv_sym _ _
  have hu : ∀ p, uj j k (Equiv.swap j k p) = -uj j k p := fun p => by
    unfold uj
    by_cases h1 : p = j
    · subst h1; simp [Equiv.swap_apply_left, Ne.symm hjk]
    · by_cases h2 : p = k
      · subst h2; simp [Equiv.swap_apply_right, h1]
      · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]; simp [h1, h2]
  have hv : ∀ p, vy j k y (Equiv.swap j k p) = vy j k y p := fun p => by
    unfold vy
    by_cases h1 : p = j
    · subst h1; simp [Equiv.swap_apply_left]
    · by_cases h2 : p = k
      · subst h2; simp [Equiv.swap_apply_right]
      · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]
  have e : (Matrix.of fun p q => Dminus j k y (Equiv.swap j k p) (Equiv.swap j k q)) = (-1 : ℝ) • Dminus j k y := by
    ext p q
    simp only [Matrix.of_apply, Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, Matrix.smul_apply, smul_eq_mul, hu, hv]
    ring
  rw [rotR_swap_coordOp j k _ hT, e, coordOp_smul']
  module

/-- `D⁻_y` has a weight in the base layer's sense when `Σ y = 0` off `{j, k}`. -/
theorem Dminus_weight (hjk : j ≠ k) (y : Fin n → ℝ) (hsum : ∑ c, vy j k y c = 0) :
    FamilyLayer.IsWeight (Dminus j k y) := by
  have hu : ∑ c, uj j k c = 0 := by
    unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]]
    ring
  refine ⟨fun a b => ?_, fun a => ?_, fun a => ?_⟩
  · simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]; ring
  · simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]; rw [uj_vy, mul_comm (vy j k y a), uj_vy]; ring
  · simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, Finset.sum_add_distrib, ← Finset.mul_sum, hsum, hu]
    ring

/-- **`D⁻_y` has character `1`** when `Σ y = 0` off `{j, k}`. -/
theorem Dminus_charOne (hjk : j ≠ k) (y : Fin n → ℝ) (hsum : ∑ c, vy j k y c = 0) :
    SignChar (fun _ => 1) (coordOp (Dminus j k y)) := by
  have hw := Dminus_weight hjk y hsum
  exact (L120Ident.trivial_block_iff _ (Dminus_weyl hjk y hsum)).mpr ⟨Dminus j k y, hw, coordOp_eq_restrict hw⟩

/-- **L222, the odd part as a set**: the Weyl operators of character `1` that the swap negates are exactly the `D⁻_y`
with `y` zero at `j, k` and `Σ y = 0`. -/
theorem odd_iff (hjk : j ≠ k) (V : CurvOp2 (Fin n)) :
    (IsWeyl2 V ∧ SignChar (fun _ => 1) V ∧ rotR (swapM j k) V = -V) ↔
      ∃ y : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ V = coordOp (Dminus j k y) := by
  constructor
  · rintro ⟨hW, h1, hodd⟩
    exact odd_eq_Dminus hjk hW h1 hodd
  · rintro ⟨y, hyj, hyk, hs, rfl⟩
    have hs' : ∑ c, vy j k y c = 0 := by rw [vy_of_zero y hyj hyk]; exact hs
    exact ⟨Dminus_weyl hjk y hs', Dminus_charOne hjk y hs', Dminus_swap_odd hjk y⟩

/-- **L222 (4) on the odd part, as the record states it**: at a Weyl operator `V` of character `1` that the swap negates,
`G_x ∘ V = D⁻_z` with `z = ½‖x‖² y + ⟨x, y⟩ x`, `y` the odd part's coordinate vector (`Σ y = 0`). -/
theorem LG_odd (hjk : j ≠ k) (x : Fin n → ℝ) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V) (hV : SignChar (fun _ => 1) V)
    (hodd : rotR (swapM j k) V = -V) :
    ∃ y : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ V = coordOp (Dminus j k y) ∧
      foxProd2 (coordOp (Gy j k x)) V
        = coordOp (Dminus j k (fun i => (1 / 2 : ℝ) * (∑ c, vy j k x c * vy j k x c) * y i
            + (∑ c, vy j k x c * y c) * vy j k x i)) := by
  obtain ⟨y, hyj, hyk, hsum, rfl⟩ := odd_eq_Dminus hjk hVW hV hodd
  refine ⟨y, hyj, hyk, hsum, rfl, ?_⟩
  rw [LG_Dminus hjk x y, vy_of_zero y hyj hyk]

/-- **Item 4's map keeps the sum-zero plane** when `Σ x = 0`: `Σ z = ½‖x‖² Σ y + ⟨x, y⟩ Σ x`. -/
theorem LG_sum (x y : Fin n → ℝ) :
    ∑ i, ((1 / 2 : ℝ) * (∑ c, vy j k x c * vy j k x c) * y i + (∑ c, vy j k x c * y c) * vy j k x i)
      = (1 / 2 : ℝ) * (∑ c, vy j k x c * vy j k x c) * ∑ i, y i + (∑ c, vy j k x c * y c) * ∑ i, vy j k x i := by
  rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum]

/-- **L224's odd part is `D⁻_y`**: at a Weyl `D` of character `1`, `½(D − σD) = D⁻_y` with `y` zero at `j, k` and
`Σ y = 0`. -/
theorem odd_half_eq_Dminus (hjk : j ≠ k) {D : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) :
    ∃ y : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) := by
  have hσDW : IsWeyl2 (rotR (swapM j k) D) := rotR_isWeyl2 (swapM_orth j k) hDW
  have hσD1 : SignChar (fun _ => 1) (rotR (swapM j k) D) := signChar_rotR_swap j k hD fun _ _ => rfl
  have e : (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = (1 / 2 : ℝ) • (D + (-1 : ℝ) • rotR (swapM j k) D) := by module
  have hMW : IsWeyl2 ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) := by
    rw [e]; exact isWeyl2_smul _ (isWeyl2_add hDW (isWeyl2_smul _ hσDW))
  have hM1 : SignChar (fun _ => 1) ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) := by
    rw [e]; exact signChar_smul (signChar_add hD (signChar_smul hσD1 (-1))) _
  have hσσ : rotR (swapM j k) (rotR (swapM j k) D) = D := by
    rw [L219GenOps.rotR_comp, swapM_sq, L219GenOps.rotR_one]
  have hodd : rotR (swapM j k) ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) = -((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) := by
    rw [e, LinearMap.map_smul, LinearMap.map_add, LinearMap.map_smul, hσσ]; module
  exact odd_eq_Dminus hjk hMW hM1 hodd

/-- **The link L224 uses**: at a Weyl `D` of character `1`, `D⁻ ∘ D⁻ = G_y` for `D⁻ = ½(D − σD) = D⁻_y`. -/
theorem Q_odd_half (hjk : j ≠ k) {D : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) :
    ∃ y : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧
      Qop2 ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) = coordOp (Gy j k y) := by
  obtain ⟨y, hyj, hyk, hsum, he⟩ := odd_half_eq_Dminus hjk hDW hD
  exact ⟨y, hyj, hyk, hsum, he, by rw [he, Q_Dminus]⟩

end HamiltonsCubic.OddPart
