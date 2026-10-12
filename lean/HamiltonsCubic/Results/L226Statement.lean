import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Results.CubicBridge
import HamiltonsCubic.Results.PhiTri

set_option linter.style.longLine false

/-!
# L226, the cubic on the block subalgebra `𝒮_J` at `|J| = 3`

## The claim

[second-order.md](../../../findings/second-order.md)'s Lemma L226, item 3: with `J = Fin 3`, outer set `Fin m`,
`R_J` written in the frame `φ₂₃, φ₃₁, φ₁₂` as a symmetric `S`, blocks `M a` on `V_a` and outer diagonal `K`,
`P(W) = tr S³ + 3 det S + Σ_a (tr M_a³ + 3 tr(S adj M_a)) + Σ_{a<b} (K_ab³ + 3 K_ab tr(M_a M_b))
+ 3 Σ_{a<b<c} K_ab K_ac K_bc`, and Ricci-flatness on `J` reads `(tr S) I - S + Σ_a M_a = 0`.

## What is typed

* `blockCoeff`, `blockOp`: the operator on `Λ²(ℝ^{3+m})` the blocks define, in the base layer's `phi` basis,
  with `R_J`'s entries `W_{pq,rs} = Σ ε_{pqx} ε_{rsy} S_{xy}`;
* `blockP`: the polynomial of item 3;
* `Pcubic_blockOp`, `normSq_blockOp`, `Ric_blockOp_J`, `Ric_blockOp_outer`: item 1 at `k = 3` with `S` free, the norm, and the
  diagonal Ricci entries on `J` and at an outer index, against the base layer's `Pcubic`, `normSq` and `Ric`.
  All four are proved: `Pcubic_blockOp` through the `Λ²` bridge `Pcubic_opOf`, `trCube_blockOp` for `tr W³`, and
  the `Φ` formula `sharpPair_blockOp_formula` split by `quad_split` into the family-pair sums `QJJ`, `QSMM`,
  `QKMM`, `QKK_total`. The Bianchi clause, the vanishing
  mixed Ricci entries, the equivalence of item 2 and `k ≠ 3` are outside this file;
* `ricciJ_inverse`: `(tr S) I - S = -N ↔ S = N - ½ (tr N) I`, proved;
* `cubicJ_diagonal`, `coupling_diagonal`: at diagonal blocks the two `J` terms are the triangle terms of the
  diagonal form, proved;
* `blockP_identity`: at `S = I`, `M_a = I`, `K = 1` off the diagonal and `m = 3`, `blockP = 75 = P(id)` at `n = 6`, proved.
-/

namespace HamiltonsCubic.L226Statement

open Finset Matrix HamiltonsCubic.RealLayer

variable {m : ℕ}

/-- The Levi-Civita symbol on `Fin 3`, as the determinant of the rows `e_p, e_q, e_x`. -/
noncomputable def eps (p q x : Fin 3) : ℝ :=
  Matrix.det (Matrix.of ![Pi.single p (1 : ℝ), Pi.single q 1, Pi.single x 1])

/-- `tr S³ + 3 det S`, the cubic of `Λ²ℝ³` in the frame `φ₂₃, φ₃₁, φ₁₂`. -/
def cubicJ (S : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := (S * S * S).trace + 3 * S.det

/-- **The polynomial of L226, item 3.** -/
def blockP (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin m → Fin m → ℝ) : ℝ :=
  cubicJ S + ∑ a, ((M a * M a * M a).trace + 3 * (S * (M a).adjugate).trace)
    + ∑ a, ∑ b, (if a < b then K a b ^ 3 + 3 * K a b * (M a * M b).trace else 0)
    + 3 * ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0)

/-- **The entries `W_{ij,kl} = ⟨W φ_ij, φ_kl⟩` of the block operator**, indices in `J = Fin 3` on the left of
the sum and in the outer set on the right. -/
noncomputable def blockCoeff (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) : Fin 3 ⊕ Fin m → Fin 3 ⊕ Fin m → Fin 3 ⊕ Fin m → Fin 3 ⊕ Fin m → ℝ
  | .inl p, .inl q, .inl r, .inl s => ∑ x, ∑ y, eps p q x * eps r s y * S x y
  | .inl p, .inr a, .inl q, .inr b => if a = b then M a p q else 0
  | .inr a, .inl p, .inl q, .inr b => if a = b then -M a p q else 0
  | .inl p, .inr a, .inr b, .inl q => if a = b then -M a p q else 0
  | .inr a, .inl p, .inr b, .inl q => if a = b then M a p q else 0
  | .inr a, .inr b, .inr c, .inr d =>
      if a ≠ b ∧ a = c ∧ b = d then K a b else if a ≠ b ∧ a = d ∧ b = c then -K a b else 0
  | _, _, _, _ => 0

/-- **The block operator**: `X = ½ Σ ⟨X, φ_ij⟩ φ_ij` and `W φ_ij = ½ Σ W_{ij,kl} φ_kl`. -/
noncomputable def blockOp (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) :
    Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ → Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ :=
  fun X => (1 / 4 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, (inner2 X (phi i j) * blockCoeff S M K i j k l) • phi k l

section Collapse
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

theorem phi_collapse (a b : κ) (F : κ → κ → ℝ) :
    ∑ i, ∑ j, inner2 (phi a b) (phi i j) * F i j = F a b - F b a := by
  simp only [HamiltonsCubic.FamilyLayer.inner2_phi_phi, sub_mul, Finset.sum_sub_distrib]
  congr 1
  · rw [Finset.sum_eq_single a (fun i _ hi => Finset.sum_eq_zero fun j _ => by simp [Ne.symm hi]) (by simp)]
    rw [Finset.sum_eq_single b (fun j _ hj => by simp [Ne.symm hj]) (by simp)]
    simp
  · rw [Finset.sum_eq_single b (fun i _ hi => Finset.sum_eq_zero fun j _ => by simp [Ne.symm hi]) (by simp)]
    rw [Finset.sum_eq_single a (fun j _ hj => by simp [Ne.symm hj]) (by simp)]
    simp

theorem phi_collapse' (c d : κ) (F : κ → κ → ℝ) :
    ∑ k, ∑ l, F k l * inner2 (phi k l) (phi c d) = F c d - F d c := by
  have := phi_collapse c d F
  rw [← this]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [mul_comm, HamiltonsCubic.FamilyLayer.inner2_phi_phi, HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  by_cases h1 : k = c <;> by_cases h2 : l = d <;> by_cases h3 : l = c <;> by_cases h4 : k = d <;>
    simp_all [eq_comm]



theorem pairing (C : κ → κ → κ → κ → ℝ) (a b c d : κ) :
    inner2 ((1 / 4 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, (inner2 (phi a b) (phi i j) * C i j k l) • phi k l)
      (phi c d) = (1 / 4) * (C a b c d - C b a c d - (C a b d c - C b a d c)) := by
  simp only [HamiltonsCubic.FamilyLayer.inner2_smul_left]
  congr 1
  have h : inner2 (∑ i, ∑ j, ∑ k, ∑ l, (inner2 (phi a b) (phi i j) * C i j k l) • phi k l) (phi c d)
      = ∑ i, ∑ j, inner2 (phi a b) (phi i j) * (∑ k, ∑ l, C i j k l * inner2 (phi k l) (phi c d)) := by
    simp only [inner2, Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Matrix.transpose_smul,
      Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl
      fun k _ => Finset.sum_congr rfl fun l _ => by ring
  rw [h]
  simp only [phi_collapse' c d]
  rw [phi_collapse a b (fun i j => C i j c d - C i j d c)]
  ring

end Collapse

/-! ### The Levi-Civita symbol on `Fin 3` -/

theorem eps_swap12 (p r x : Fin 3) : eps r p x = -eps p r x := by
  fin_cases p <;> fin_cases r <;> fin_cases x <;>
    simp [eps, Matrix.det_fin_three, Pi.single_apply]

theorem eps_contract (p q x y : Fin 3) :
    ∑ r, eps p r x * eps q r y = (if p = q ∧ x = y then 1 else 0) - (if p = y ∧ q = x then 1 else 0) := by
  fin_cases p <;> fin_cases q <;> fin_cases x <;> fin_cases y <;>
    simp [eps, Matrix.det_fin_three, Pi.single_apply, Fin.sum_univ_three]

theorem eps_S_contract (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) (p q : Fin 3) :
    ∑ r, ∑ x, ∑ y, eps p r x * eps q r y * S x y = (S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S) p q := by
  have h : ∑ r, ∑ x, ∑ y, eps p r x * eps q r y * S x y
      = ∑ x, ∑ y, (∑ r, eps p r x * eps q r y) * S x y := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun y _ => ?_
    rw [Finset.sum_mul]
  rw [h]
  simp only [eps_contract, sub_mul, ite_mul, one_mul, zero_mul, Finset.sum_sub_distrib, ite_and]
  have hsq : S q p = S p q := by have := congrFun (congrFun hS p) q; simpa [Matrix.transpose_apply] using this
  by_cases hpq : p = q
  · subst hpq
    simp [Matrix.trace, Matrix.diag, Matrix.sub_apply, Matrix.smul_apply, Finset.sum_ite_eq, Finset.sum_ite_eq']
  · simp [hpq, Matrix.sub_apply, Matrix.smul_apply, Matrix.one_apply, Finset.sum_ite_eq, Finset.sum_ite_eq', hsq]

section NormSq
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

theorem inner2_phi_eq' (M : Matrix κ κ ℝ) (k l : κ) : inner2 M (phi k l) = (1 / 2) * (M l k - M k l) := by
  rw [inner2_eq_sum]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, mul_sub, mul_ite, mul_one, mul_zero,
    Finset.sum_sub_distrib, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']

/-- **A skew matrix's square norm in `φ`-coordinates.** -/
theorem inner2_self_phi_expand (Y : Matrix κ κ ℝ) (hY : IsSkew Y) :
    inner2 Y Y = (1 / 2) * ∑ k, ∑ l, (inner2 Y (phi k l)) ^ 2 := by
  have hs : ∀ a b, Y a b = -Y b a := by
    intro a b; have := congrFun (congrFun hY b) a
    simpa [Matrix.transpose_apply] using this
  rw [inner2_eq_sum]
  simp only [inner2_phi_eq']
  rw [Finset.sum_comm]
  congr 1
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [hs k l]; ring

/-- The operator built from a coefficient array, `blockOp`'s shape. -/
noncomputable def opOf (C : κ → κ → κ → κ → ℝ) (X : Matrix κ κ ℝ) : Matrix κ κ ℝ :=
  (1 / 4 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, (inner2 X (phi i j) * C i j k l) • phi k l

theorem opOf_isSkew (C : κ → κ → κ → κ → ℝ) (X : Matrix κ κ ℝ) : IsSkew (opOf C X) := by
  unfold IsSkew opOf
  simp only [Matrix.transpose_smul, Matrix.transpose_sum, smul_sum]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [phi_isSkew k l]; simp [smul_neg]

theorem normSq_opOf (C : κ → κ → κ → κ → ℝ) :
    normSq (opOf C) = (1 / 4) * ∑ i, ∑ j, ∑ k, ∑ l,
      ((1 / 4) * (C i j k l - C j i k l - (C i j l k - C j i l k))) ^ 2 := by
  unfold normSq innerOp
  simp only [inner2_self_phi_expand _ (opOf_isSkew C _)]
  simp only [opOf, pairing]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  ring

/-- The Levi-Civita symbol as an explicit array. -/
def E3 : Fin 3 → Fin 3 → Fin 3 → ℝ :=
  ![![![0, 0, 0], ![0, 0, 1], ![0, -1, 0]],
    ![![0, 0, -1], ![0, 0, 0], ![1, 0, 0]],
    ![![0, 1, 0], ![-1, 0, 0], ![0, 0, 0]]]

theorem eps_table (p q x : Fin 3) : eps p q x = E3 p q x := by
  fin_cases p <;> fin_cases q <;> fin_cases x <;>
    simp [eps, E3, Matrix.det_fin_three, Pi.single_apply]

/-- **`Σ_rs (Σ_y w_y ε_rsy)² = 2 Σ_y w_y²`**, on `Fin 3`. -/
theorem eps_w_sq (w : Fin 3 → ℝ) :
    ∑ r, ∑ s, (∑ y, w y * eps r s y) ^ 2 = 2 * ∑ y, (w y) ^ 2 := by
  simp only [eps_table]
  simp [Fin.sum_univ_three, E3]
  ring

theorem eps_S_sq (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) :
    ∑ p, ∑ q, ∑ r, ∑ s, (∑ x, ∑ y, eps p q x * eps r s y * S x y) ^ 2 = 4 * (S * S).trace := by
  have h1 : ∀ p q, ∑ r, ∑ s, (∑ x, ∑ y, eps p q x * eps r s y * S x y) ^ 2
      = 2 * ∑ y, (∑ x, S x y * eps p q x) ^ 2 := by
    intro p q
    rw [← eps_w_sq (fun y => ∑ x, S x y * eps p q x)]
    refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun s _ => ?_
    congr 1
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun y _ => ?_
    rw [Finset.sum_mul]
    exact Finset.sum_congr rfl fun x _ => by ring
  simp only [h1, ← Finset.mul_sum]
  have h2 : ∀ y, ∑ p, ∑ q, (∑ x, S x y * eps p q x) ^ 2 = 2 * ∑ x, (S x y) ^ 2 :=
    fun y => eps_w_sq (fun x => S x y)
  rw [show (∑ p, ∑ q, ∑ y, (∑ x, S x y * eps p q x) ^ 2)
      = ∑ y, ∑ p, ∑ q, (∑ x, S x y * eps p q x) ^ 2 from by
    rw [Finset.sum_congr rfl fun p _ => Finset.sum_comm]; exact Finset.sum_comm]
  simp only [h2]
  have hsym : ∀ x y, S y x = S x y := by
    intro x y; have := congrFun (congrFun hS x) y; simpa [Matrix.transpose_apply] using this
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, hsym, ← Finset.mul_sum]
  simp only [sq]
  ring_nf

theorem J_bracket (S : Matrix (Fin 3) (Fin 3) ℝ) (p q r s : Fin 3) :
    1 / 4 * (∑ x, ∑ y, eps p q x * eps r s y * S x y - ∑ x, ∑ y, eps q p x * eps r s y * S x y -
      (∑ x, ∑ y, eps p q x * eps s r y * S x y - ∑ x, ∑ y, eps q p x * eps s r y * S x y))
      = ∑ x, ∑ y, eps p q x * eps r s y * S x y := by
  simp only [eps_swap12 p q, eps_swap12 r s, neg_mul, mul_neg, neg_neg, Finset.sum_neg_distrib]
  ring

theorem ite_bracket_pos (c : Prop) [Decidable c] (a : ℝ) :
    (1 / 4 * (((if c then a else 0) - if c then -a else 0) -
      ((if c then -a else 0) - if c then a else 0))) ^ 2 = if c then a ^ 2 else 0 := by
  split_ifs <;> ring

theorem ite_bracket_neg (c : Prop) [Decidable c] (a : ℝ) :
    (1 / 4 * (((if c then -a else 0) - if c then a else 0) -
      ((if c then a else 0) - if c then -a else 0))) ^ 2 = if c then a ^ 2 else 0 := by
  split_ifs <;> ring

theorem K_bracket {m : ℕ} (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (x x1 x2 x3 : Fin m) :
    (1 / 4 *
      (((if x ≠ x1 ∧ x = x2 ∧ x1 = x3 then K x x1
          else if x ≠ x1 ∧ x = x3 ∧ x1 = x2 then -K x x1 else 0) -
          if x1 ≠ x ∧ x1 = x2 ∧ x = x3 then K x1 x
          else if x1 ≠ x ∧ x1 = x3 ∧ x = x2 then -K x1 x else 0) -
        ((if x ≠ x1 ∧ x = x3 ∧ x1 = x2 then K x x1
          else if x ≠ x1 ∧ x = x2 ∧ x1 = x3 then -K x x1 else 0) -
          if x1 ≠ x ∧ x1 = x3 ∧ x = x2 then K x1 x
          else if x1 ≠ x ∧ x1 = x2 ∧ x = x3 then -K x1 x else 0))) ^ 2
      = (if x ≠ x1 ∧ x = x2 ∧ x1 = x3 then K x x1 ^ 2 else 0)
        + (if x ≠ x1 ∧ x = x3 ∧ x1 = x2 then K x x1 ^ 2 else 0) := by
  have hs := hK x1 x
  by_cases h1 : x = x1
  · subst h1; simp
  · by_cases h2 : x = x2 <;> by_cases h3 : x1 = x3 <;> by_cases h4 : x = x3 <;> by_cases h5 : x1 = x2 <;>
      simp_all <;> ring

theorem coll1 {α β : Type*} [Fintype α] [Fintype β] [DecidableEq α] (a : α) (g : β → ℝ) :
    ∑ x2 : α, ∑ x3 : β, (if a = x2 then g x3 else 0) = ∑ x3, g x3 := by
  rw [Finset.sum_eq_single a (fun b _ hb => by simp [Ne.symm hb]) (by simp)]
  simp

theorem coll2 {α β : Type*} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]
    (a : α) (b : β) (c : ℝ) :
    ∑ x2 : α, ∑ x3 : β, (if a = x2 ∧ b = x3 then c else 0) = c := by
  simp only [ite_and]
  rw [coll1 a (fun x3 => if b = x3 then c else 0)]
  simp

theorem coll2' {α β : Type*} [Fintype α] [Fintype β] [DecidableEq α] [DecidableEq β]
    (a : β) (b : α) (c : ℝ) :
    ∑ x2 : α, ∑ x3 : β, (if a = x3 ∧ b = x2 then c else 0) = c := by
  simp only [and_comm (a := a = _)]
  exact coll2 b a c

theorem K_coll {m : ℕ} (x x1 : Fin m) (c : ℝ) :
    ∑ x2 : Fin m, ∑ x3 : Fin m, (if ¬x = x1 ∧ x = x2 ∧ x1 = x3 then c else 0)
      = if ¬x = x1 then c else 0 := by
  by_cases h : x = x1
  · simp [h]
  · simp only [h, not_false_eq_true, true_and, if_true]; exact coll2 x x1 c

theorem K_coll' {m : ℕ} (x x1 : Fin m) (c : ℝ) :
    ∑ x2 : Fin m, ∑ x3 : Fin m, (if ¬x = x1 ∧ x = x3 ∧ x1 = x2 then c else 0)
      = if ¬x = x1 then c else 0 := by
  by_cases h : x = x1
  · simp [h]
  · simp only [h, not_false_eq_true, true_and, if_true]; exact coll2' x x1 c

theorem K_offdiag {m : ℕ} (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    ∑ a, ∑ b, (if ¬a = b then K a b ^ 2 else 0)
      = 2 * ∑ a, ∑ b, (if a < b then K a b ^ 2 else 0) := by
  have e : ∀ a b : Fin m, (if ¬a = b then K a b ^ 2 else 0)
      = (if a < b then K a b ^ 2 else 0) + (if b < a then K b a ^ 2 else 0) := by
    intro a b
    rcases lt_trichotomy a b with h | rfl | h
    · simp [h, h.ne, h.asymm]
    · simp
    · simp [h, h.ne', h.asymm, hK a b]
  have hs : ∑ a : Fin m, ∑ b : Fin m, (if b < a then K b a ^ 2 else 0)
      = ∑ a, ∑ b, (if a < b then K a b ^ 2 else 0) := Finset.sum_comm
  simp only [e, Finset.sum_add_distrib, hs]
  ring

end NormSq

theorem blockOp_eq_opOf (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) : blockOp S M K = opOf (blockCoeff S M K) := rfl

section Bridge
variable {κ : Type*} [Fintype κ] [DecidableEq κ]
open HamiltonsCubic.TensorBridge HamiltonsCubic.FamilyLayer

theorem opOf_add (C : κ → κ → κ → κ → ℝ) (X Y : Matrix κ κ ℝ) :
    opOf C (X + Y) = opOf C X + opOf C Y := by
  ext p q
  simp only [opOf, Matrix.smul_apply, Matrix.add_apply, Matrix.sum_apply, inner2_phi_eq', smul_eq_mul,
    Finset.mul_sum, ← Finset.sum_add_distrib]
  refine sum_congr rfl fun _ _ => sum_congr rfl fun _ _ => sum_congr rfl fun _ _ =>
    sum_congr rfl fun _ _ => ?_
  ring

theorem opOf_smul (C : κ → κ → κ → κ → ℝ) (c : ℝ) (X : Matrix κ κ ℝ) :
    opOf C (c • X) = c • opOf C X := by
  ext p q
  simp only [opOf, Matrix.smul_apply, Matrix.sum_apply, inner2_phi_eq', smul_eq_mul, Finset.mul_sum]
  refine sum_congr rfl fun _ _ => sum_congr rfl fun _ _ => sum_congr rfl fun _ _ =>
    sum_congr rfl fun _ _ => ?_
  ring

theorem opOf_skewProj (C : κ → κ → κ → κ → ℝ) (X : Matrix κ κ ℝ) :
    opOf C (skewProj X) = opOf C X := by
  ext p q
  simp only [opOf, Matrix.smul_apply, Matrix.sum_apply, inner2_phi_eq', smul_eq_mul, skewProj,
    Matrix.sub_apply, Matrix.transpose_apply]
  congr 1
  refine sum_congr rfl fun _ _ => sum_congr rfl fun _ _ => sum_congr rfl fun _ _ =>
    sum_congr rfl fun _ _ => ?_
  ring

/-- **The operator `opOf C` on `Λ²`**, as a `CurvOp2`. -/
noncomputable def opL (C : κ → κ → κ → κ → ℝ) : CurvOp2 κ :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨opOf C X, opOf_isSkew C X⟩
      map_add' := fun X Y => Subtype.ext (opOf_add C X Y)
      map_smul' := fun c X => Subtype.ext (opOf_smul C c X) }

theorem extend_opL (C : κ → κ → κ → κ → ℝ) : extend (opL C) = opOf C := by
  funext X
  show opOf C (skewProj X) = _
  exact opOf_skewProj C X

theorem Pcubic_opOf (C : κ → κ → κ → κ → ℝ) : Pcubic (opOf C) = Pcubic2 (opL C) := by
  rw [← extend_opL, Pcubic_extend]

theorem sum4_swap {β : Type*} [AddCommMonoid β] (f : κ → κ → κ → κ → β) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
  calc ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ i, ∑ k, ∑ l, ∑ j, f i j k l :=
        sum_congr rfl fun i _ => by rw [Finset.sum_comm]; exact sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
        rw [Finset.sum_comm]; exact sum_congr rfl fun k _ => Finset.sum_comm

theorem opOf_phi (C : κ → κ → κ → κ → ℝ) (a b : κ) :
    opOf C (phi a b) = (1 / 4 : ℝ) • ∑ k, ∑ l, (C a b k l - C b a k l) • phi k l := by
  unfold opOf
  congr 1
  rw [sum4_swap]
  refine sum_congr rfl fun k _ => sum_congr rfl fun l _ => ?_
  rw [← phi_collapse a b (fun i j => C i j k l), Finset.sum_smul]
  refine sum_congr rfl fun i _ => ?_
  rw [Finset.sum_smul]

omit [DecidableEq κ] in
theorem sum_pt {β : Type*} [AddCommMonoid β] [DecidableEq κ] (a b : κ) (f : κ → κ → β) :
    ∑ x, ∑ y, (if x = a ∧ y = b then f x y else 0) = f a b := by
  rw [Finset.sum_eq_single a (fun x _ hx => by simp [hx]) (by simp),
    Finset.sum_eq_single b (fun y _ hy => by simp [hy]) (by simp)]
  simp

omit [DecidableEq κ] in
theorem coll_fst {β : Type*} [AddCommMonoid β] [DecidableEq κ] {ι' : Type*} [Fintype ι'] (a : κ)
    (g : κ → ι' → β) : ∑ x, ∑ y, (if a = x then g x y else 0) = ∑ y, g a y := by
  rw [Finset.sum_eq_single a (fun x _ hx => by simp [Ne.symm hx]) (by simp)]
  simp

theorem ite_sub_neg (c : Prop) [Decidable c] (u : ℝ) :
    ((if c then u else 0) - if c then -u else 0) = if c then 2 * u else 0 := by
  split_ifs <;> ring

theorem ite_neg_sub (c : Prop) [Decidable c] (u : ℝ) :
    ((if c then -u else 0) - if c then u else 0) = if c then -(2 * u) else 0 := by
  split_ifs <;> ring

end Bridge

/-! ### The action of `blockOp` on the three blocks of `Λ²` -/

theorem blockOp_K (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b : Fin m) (hab : a ≠ b) :
    blockOp S M K (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) := by
  rw [blockOp_eq_opOf, opOf_phi]
  simp only [Fintype.sum_sum_type, blockCoeff]
  have e : ∀ x x1 : Fin m,
      ((if a ≠ b ∧ a = x ∧ b = x1 then K a b else if a ≠ b ∧ a = x1 ∧ b = x then -K a b else 0) -
        if b ≠ a ∧ b = x ∧ a = x1 then K b a else if b ≠ a ∧ b = x1 ∧ a = x then -K b a else 0)
      = (if x = a ∧ x1 = b then 2 * K a b else 0) + (if x = b ∧ x1 = a then -(2 * K a b) else 0) := by
    intro x x1
    rw [hK b a]
    by_cases h1 : x = a <;> by_cases h2 : x1 = b <;> by_cases h3 : x = b <;> by_cases h4 : x1 = a <;>
      subst_vars <;> simp_all [eq_comm] <;> ring
  simp only [sub_self, zero_smul, Finset.sum_const_zero, zero_add, e, add_smul, ite_smul,
    Finset.sum_add_distrib, sum_pt]
  rw [phi_swap (Sum.inr a) (Sum.inr b)]
  module

theorem blockOp_M (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (p : Fin 3) (a : Fin m) :
    blockOp S M K (phi (.inl p) (.inr a)) = ∑ q, M a p q • phi (.inl q) (.inr a) := by
  rw [blockOp_eq_opOf, opOf_phi]
  simp only [Fintype.sum_sum_type, blockCoeff, sub_self, zero_smul, Finset.sum_const_zero,
    zero_add, add_zero, ite_sub_neg, ite_neg_sub, ite_smul, Finset.sum_ite_eq, Finset.mem_univ,
    if_true, coll_fst]
  simp only [phi_swap (Sum.inr a), smul_neg, neg_smul, Finset.sum_neg_distrib]
  simp only [← Finset.sum_neg_distrib, ← Finset.sum_add_distrib, Finset.smul_sum]
  refine Finset.sum_congr rfl fun q _ => ?_
  module

theorem blockOp_J (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (p q : Fin 3) :
    blockOp S M K (phi (.inl p) (.inl q))
      = (1 / 2 : ℝ) • ∑ r, ∑ s, (∑ x, ∑ y, eps p q x * eps r s y * S x y) • phi (.inl r) (.inl s) := by
  rw [blockOp_eq_opOf, opOf_phi]
  simp only [Fintype.sum_sum_type, blockCoeff, sub_self, zero_smul, Finset.sum_const_zero,
    add_zero, eps_swap12 p q, neg_mul, Finset.sum_neg_distrib, sub_neg_eq_add, smul_sum]
  refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun s _ => ?_
  rw [smul_smul, smul_smul]
  congr 1
  ring

section TrCubeGen
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

theorem inner2_sum_left' {I : Type*} (s : Finset I) (f : I → Matrix κ κ ℝ) (Y : Matrix κ κ ℝ) :
    inner2 (∑ i ∈ s, f i) Y = ∑ i ∈ s, inner2 (f i) Y := by
  simp [inner2, Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_sum_right' {I : Type*} (s : Finset I) (f : I → Matrix κ κ ℝ) (X : Matrix κ κ ℝ) :
    inner2 X (∑ i ∈ s, f i) = ∑ i ∈ s, inner2 X (f i) := by
  simp [inner2, Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_smul_left' (c : ℝ) (X Y : Matrix κ κ ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  simp [inner2, Matrix.trace_smul]; ring

theorem inner2_smul_right' (c : ℝ) (X Y : Matrix κ κ ℝ) : inner2 X (c • Y) = c * inner2 X Y := by
  simp [inner2, Matrix.trace_smul]; ring

theorem inner2_neg_left' (X Y : Matrix κ κ ℝ) : inner2 (-X) Y = -inner2 X Y := by
  simp [inner2]

theorem inner2_neg_right' (X Y : Matrix κ κ ℝ) : inner2 X (-Y) = -inner2 X Y := by
  simp [inner2]

/-- **The cubic trace on an orthonormal family carried by a matrix.** -/
theorem tri_orth {I : Type*} [Fintype I] [DecidableEq I] (L : Matrix κ κ ℝ →ₗ[ℝ] Matrix κ κ ℝ)
    (e : I → Matrix κ κ ℝ) (A : I → I → ℝ)
    (horth : ∀ i j, inner2 (e i) (e j) = if i = j then 1 else 0)
    (hL : ∀ i, L (e i) = ∑ j, A i j • e j) :
    ∑ i, inner2 (L (L (e i))) (L (e i)) = ∑ i, ∑ j, ∑ k, A i j * A j k * A i k := by
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [hL i, map_sum]
  simp only [map_smul, hL, inner2_sum_left', inner2_sum_right', inner2_smul_left', inner2_smul_right',
    Finset.smul_sum, smul_smul, horth, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq']
  simp only [Finset.mul_sum]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by simp only [Finset.mem_univ, if_true]; ring

/-- **`opOf C` as a linear map.** -/
noncomputable def opLin (C : κ → κ → κ → κ → ℝ) : Matrix κ κ ℝ →ₗ[ℝ] Matrix κ κ ℝ where
  toFun := opOf C
  map_add' := opOf_add C
  map_smul' := opOf_smul C

theorem offdiag_sym {m : ℕ} (f : Fin m → Fin m → ℝ) (hf : ∀ a b, f a b = f b a) :
    ∑ a, ∑ b, (if ¬a = b then f a b else 0) = 2 * ∑ a, ∑ b, (if a < b then f a b else 0) := by
  have e : ∀ a b : Fin m, (if ¬a = b then f a b else 0)
      = (if a < b then f a b else 0) + (if b < a then f b a else 0) := by
    intro a b
    rcases lt_trichotomy a b with h | rfl | h
    · simp [h, h.ne, h.asymm]
    · simp
    · simp [h, h.ne', h.asymm, hf a b]
  have hs : ∑ a : Fin m, ∑ b : Fin m, (if b < a then f b a else 0)
      = ∑ a, ∑ b, (if a < b then f a b else 0) := Finset.sum_comm
  simp only [e, Finset.sum_add_distrib, hs]
  ring

end TrCubeGen

/-! ### `tr W³` on the three blocks -/

theorem blockOp_K' (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b : Fin m) :
    blockOp S M K (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) := by
  by_cases h : a = b
  · subst h
    rw [phi_self, smul_zero, blockOp_eq_opOf]
    have := opOf_smul (blockCoeff S M K) 0 0
    rwa [zero_smul, zero_smul] at this
  · exact blockOp_K S M K hK a b h

/-- The J-block as a vector: `v 0 = φ₁₂`, `v 1 = φ₂₀`, `v 2 = φ₀₁`. -/
noncomputable def vJ (x : Fin 3) : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ :=
  (1 / 2 : ℝ) • ∑ r, ∑ s, eps r s x • phi (.inl r) (.inl s)

theorem vJ_orth (x y : Fin 3) : inner2 (vJ (m := m) x) (vJ y) = if x = y then 1 else 0 := by
  simp only [vJ, inner2_smul_left', inner2_smul_right', inner2_sum_left', inner2_sum_right',
    HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  simp only [Sum.inl.injEq]
  fin_cases x <;> fin_cases y <;> simp [eps_table, E3, Fin.sum_univ_three] <;> norm_num

theorem blockOp_vJ (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (x : Fin 3) :
    blockOp S M K (vJ x) = ∑ y, S x y • vJ y := by
  change opLin (blockCoeff S M K) (vJ x) = _
  have hJ : ∀ p q, opLin (blockCoeff S M K) (phi (.inl p) (.inl q)) = (1 / 2 : ℝ) •
      ∑ r, ∑ s, (∑ a, ∑ b, eps p q a * eps r s b * S a b) • phi (.inl r) (.inl s) :=
    fun p q => blockOp_J S M K p q
  have rot : ∀ f : Fin 3 → Fin 3 → Fin 3 → Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ,
      ∑ y, ∑ r, ∑ s, f y r s = ∑ r, ∑ s, ∑ y, f y r s := fun f => by
    rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun _ _ => Finset.sum_comm
  simp only [vJ, map_smul, map_sum, hJ, Finset.smul_sum, smul_smul]
  rw [sum4_swap]
  conv_rhs => rw [rot]
  refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun s _ => ?_
  simp only [← Finset.sum_smul]
  congr 1
  fin_cases x <;> fin_cases r <;> fin_cases s <;> simp [eps_table, E3, Fin.sum_univ_three] <;> ring

theorem vJ0 : vJ (m := m) 0 = phi (.inl 1) (.inl 2) := by
  simp [vJ, eps_table, E3, Fin.sum_univ_three, phi_self]
  rw [phi_swap (Sum.inl 1) (Sum.inl 2)]; module

theorem vJ1 : vJ (m := m) 1 = phi (.inl 2) (.inl 0) := by
  simp [vJ, eps_table, E3, Fin.sum_univ_three, phi_self]
  rw [phi_swap (Sum.inl 2) (Sum.inl 0)]; module

theorem vJ2 : vJ (m := m) 2 = phi (.inl 0) (.inl 1) := by
  simp [vJ, eps_table, E3, Fin.sum_univ_three, phi_self]
  rw [phi_swap (Sum.inl 0) (Sum.inl 1)]; module

theorem phi_vJ (p q : Fin 3) : phi (.inl p) (.inl q) = ∑ x, eps p q x • vJ (m := m) x := by
  fin_cases p <;> fin_cases q <;> simp [eps_table, E3, Fin.sum_univ_three, vJ0, vJ1, vJ2, phi_self] <;>
    exact phi_swap _ _

theorem eps_pair (x y : Fin 3) : ∑ p, ∑ q, eps p q x * eps p q y = 2 * (if x = y then 1 else 0) := by
  fin_cases x <;> fin_cases y <;> simp [eps_table, E3, Fin.sum_univ_three] <;> norm_num

theorem tr3 (A : Matrix (Fin 3) (Fin 3) ℝ) (hA : A.IsSymm) :
    ∑ i, ∑ j, ∑ k, A i j * A j k * A i k = (A * A * A).trace := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
  rw [hA.apply i j]

theorem trCube_blockOp (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) :
    trCube (blockOp S M K) = (S * S * S).trace + ∑ a, (M a * M a * M a).trace
      + ∑ a, ∑ b, (if a < b then K a b ^ 3 else 0) := by
  set L := opLin (blockCoeff S M K) with hLdef
  have hL : ∀ X, blockOp S M K X = L X := fun _ => rfl
  have LJ : ∀ x, L (vJ x) = ∑ y, S x y • vJ y := fun x => blockOp_vJ S M K x
  have LM : ∀ a p, L (phi (.inl p) (.inr a)) = ∑ q, M a p q • phi (.inl q) (.inr a) :=
    fun a p => blockOp_M S M K p a
  have LK : ∀ a b, L (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOp_K' S M K hK a b
  -- the J block
  have B1 : ∑ p, ∑ q, inner2 (L (L (phi (.inl p) (.inl q)))) (L (phi (.inl p) (.inl q)))
      = 2 * (S * S * S).trace := by
    have e : ∑ p, ∑ q, inner2 (L (L (phi (.inl p) (.inl q)))) (L (phi (.inl p) (.inl q)))
        = ∑ x, ∑ y, (∑ p, ∑ q, eps p q x * eps p q y) * inner2 (L (L (vJ y))) (L (vJ x)) := by
      simp only [phi_vJ, map_sum, map_smul, inner2_sum_left', inner2_sum_right', inner2_smul_left',
        inner2_smul_right', Finset.mul_sum, Finset.sum_mul]
      rw [sum4_swap]
      exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
    rw [e]
    simp only [eps_pair, mul_assoc, ite_mul, one_mul, zero_mul, mul_ite, mul_zero,
      Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [← Finset.mul_sum, tri_orth L vJ S vJ_orth LJ, tr3 S hS, Matrix.mul_assoc]
  -- the mixed blocks
  have orthM : ∀ a : Fin m, ∀ p q : Fin 3,
      inner2 (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr a)) (phi (Sum.inl q) (Sum.inr a))
      = if p = q then 1 else 0 := by
    intro a p q
    rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp
  have B2 : ∑ p, ∑ a, inner2 (L (L (phi (.inl p) (.inr a)))) (L (phi (.inl p) (.inr a)))
      = ∑ a, (M a * M a * M a).trace := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => by
      rw [tri_orth L (fun p => phi (.inl p) (.inr a)) (M a) (orthM a) (LM a), tr3 _ (hM a)]
  have B3 : ∑ a, ∑ p, inner2 (L (L (phi (.inr a) (.inl p)))) (L (phi (.inr a) (.inl p)))
      = ∑ a, (M a * M a * M a).trace := by
    rw [← B2, Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ => ?_
    rw [phi_swap (Sum.inl p) (Sum.inr a), map_neg, map_neg,
      inner2_neg_left', inner2_neg_right', neg_neg]
  -- the outer block
  have B4 : ∑ a, ∑ b, inner2 (L (L (phi (.inr a) (.inr b)))) (L (phi (.inr a) (.inr b)))
      = 2 * ∑ a, ∑ b, (if a < b then K a b ^ 3 else 0) := by
    rw [← offdiag_sym (fun a b => K a b ^ 3) (fun a b => by rw [hK])]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [LK, map_smul, LK, inner2_smul_left', inner2_smul_left', inner2_smul_right',
      HamiltonsCubic.FamilyLayer.inner2_phi_phi]
    by_cases h : a = b
    · subst h; simp
    · simp [h]; ring
  simp only [trCube, innerOp, compOp, hL, Fintype.sum_sum_type, Finset.sum_add_distrib]
  rw [B1, B2, B3, B4]
  ring

/-! ### `⟨W, W#⟩`: the `Φ` formula, the block split, and the brackets of the three families -/

theorem sharpPair_blockOp_formula (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) :
    sharpPair (blockOp S M K) = (1 / 8) * ∑ i, ∑ j, ∑ k, ∑ l,
      inner2 (blockOp S M K (br (blockOp S M K (phi i j)) (blockOp S M K (phi k l))))
        (br (phi i j) (phi k l)) := by
  have h1 : sharpPair (blockOp S M K)
      = -(1 / 2) * phiTri (opL (blockCoeff S M K)) (opL (blockCoeff S M K)) (opL (blockCoeff S M K)) := by
    rw [show blockOp S M K = HamiltonsCubic.TensorBridge.extend (opL (blockCoeff S M K)) from
      (extend_opL _).symm, HamiltonsCubic.TensorBridge.sharpPair_extend,
      sharpPair2_eq_phiTri]
  rw [h1]
  unfold phiTri
  have hc : ∀ x : ℝ, -(1 / 2 : ℝ) * (-(1 / 4) * x) = 1 / 8 * x := fun x => by ring
  rw [hc]
  rfl

/-- **A quadratic sum over the ordered `φ` pairs, split by block.** -/
theorem quad_split (B : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ →ₗ[ℝ]
      Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ →ₗ[ℝ] ℝ) :
    ∑ i, ∑ j, B (phi i j) (phi i j)
      = 2 * ∑ x, B (vJ x) (vJ x) + 2 * ∑ p, ∑ a, B (phi (.inl p) (.inr a)) (phi (.inl p) (.inr a))
        + ∑ a, ∑ b, B (phi (.inr a) (.inr b)) (phi (.inr a) (.inr b)) := by
  have hJ : ∑ p, ∑ q, B (phi (.inl p) (.inl q)) (phi (.inl p) (.inl q)) = 2 * ∑ x, B (vJ x) (vJ x) := by
    calc _ = ∑ x, ∑ y, (∑ p, ∑ q, eps p q x * eps p q y) * B (vJ y) (vJ x) := by
          simp only [phi_vJ, map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul,
            Finset.mul_sum, Finset.sum_mul]
          rw [HamiltonsCubic.L226Statement.sum4_swap]
          exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
            Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
      _ = 2 * ∑ x, B (vJ x) (vJ x) := by
          simp only [eps_pair, mul_ite, mul_one, mul_zero, ite_mul, zero_mul, Finset.sum_ite_eq,
            Finset.mem_univ, if_true, Finset.mul_sum]
  have hM : ∑ a, ∑ p, B (phi (.inr a) (.inl p)) (phi (.inr a) (.inl p))
      = ∑ p, ∑ a, B (phi (.inl p) (.inr a)) (phi (.inl p) (.inr a)) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun a _ => ?_
    rw [phi_swap (Sum.inl p) (Sum.inr a), map_neg, map_neg, LinearMap.neg_apply, neg_neg]
  simp only [Fintype.sum_sum_type, Finset.sum_add_distrib]
  rw [hJ, hM]
  ring

section BrB
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-- **The bracket as a bilinear map.** -/
noncomputable def brB : Matrix κ κ ℝ →ₗ[ℝ] Matrix κ κ ℝ →ₗ[ℝ] Matrix κ κ ℝ :=
  LinearMap.mk₂ ℝ br
    (fun X Y Z => by simp only [br, Matrix.add_mul, Matrix.mul_add]; abel)
    (fun c X Y => by simp only [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub])
    (fun X Y Z => by simp only [br, Matrix.add_mul, Matrix.mul_add]; abel)
    (fun c X Y => by simp only [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub])

omit [DecidableEq κ] in
theorem br_neg_left' (X Y : Matrix κ κ ℝ) : br (-X) Y = -br X Y := by
  simp only [br, Matrix.neg_mul, Matrix.mul_neg]; abel

omit [DecidableEq κ] in
theorem br_neg_right' (X Y : Matrix κ κ ℝ) : br X (-Y) = -br X Y := by
  simp only [br, Matrix.neg_mul, Matrix.mul_neg]; abel

omit [DecidableEq κ] in
theorem brB_apply (X Y : Matrix κ κ ℝ) : brB X Y = br X Y := rfl

end BrB

theorem sw01 : phi (Sum.inl (1 : Fin 3) : Fin 3 ⊕ Fin m) (Sum.inl 0) = -phi (Sum.inl 0) (Sum.inl 1) :=
  phi_swap _ _
theorem sw02 : phi (Sum.inl (2 : Fin 3) : Fin 3 ⊕ Fin m) (Sum.inl 0) = -phi (Sum.inl 0) (Sum.inl 2) :=
  phi_swap _ _
theorem sw12 : phi (Sum.inl (2 : Fin 3) : Fin 3 ⊕ Fin m) (Sum.inl 1) = -phi (Sum.inl 1) (Sum.inl 2) :=
  phi_swap _ _

theorem br_vJ_vJ (x y : Fin 3) : br (vJ (m := m) x) (vJ y) = ∑ z, eps x y z • vJ z := by
  fin_cases x <;> fin_cases y <;>
    simp [vJ0, vJ1, vJ2, br_neg_left', br_neg_right', br_phi_phi, Fin.sum_univ_three, eps_table, E3,
      phi_self, sw01, sw02, sw12]

theorem br_vJ_M (x p : Fin 3) (a : Fin m) :
    br (vJ x) (phi (.inl p) (.inr a)) = ∑ s, eps p s x • phi (.inl s) (.inr a) := by
  fin_cases x <;> fin_cases p <;>
    simp [vJ0, vJ1, vJ2, br_phi_phi, Fin.sum_univ_three, eps_table, E3]

theorem br_vJ_K (x : Fin 3) (a b : Fin m) : br (vJ x) (phi (.inr a) (.inr b)) = 0 := by
  fin_cases x <;> simp [vJ0, vJ1, vJ2, br_phi_phi]

theorem br_M_M (p q : Fin 3) (a b : Fin m) :
    br (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr a)) (phi (Sum.inl q) (Sum.inr b))
      = (if p = q then phi (Sum.inr a) (Sum.inr b) else 0) + (if a = b then phi (Sum.inl p) (Sum.inl q) else 0) := by
  rw [br_phi_phi]; simp

theorem br_K_M (a b c : Fin m) (p : Fin 3) :
    br (phi (Sum.inr a : Fin 3 ⊕ Fin m) (Sum.inr b)) (phi (Sum.inl p) (Sum.inr c))
      = (if a = c then phi (Sum.inl p) (Sum.inr b) else 0) - (if b = c then phi (Sum.inl p) (Sum.inr a) else 0) := by
  rw [br_phi_phi]
  simp only [reduceCtorEq, if_false, zero_smul, zero_add, sub_zero, Sum.inr.injEq,
    phi_swap (Sum.inl p) (Sum.inr a), phi_swap (Sum.inl p) (Sum.inr b)]
  split_ifs <;> simp <;> abel

/-! ### `⟨W, W#⟩`: the family-pair sums -/

theorem QJJ (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) :
    ∑ x, ∑ y, inner2 (blockOp S M K (br (blockOp S M K (vJ x)) (blockOp S M K (vJ y))))
      (br (vJ x) (vJ y)) = 6 * S.det := by
  have hL : ∀ X, blockOp S M K X = opLin (blockCoeff S M K) X := fun _ => rfl
  have LJ : ∀ x, opLin (blockCoeff S M K) (vJ x) = ∑ y, S x y • vJ y := fun x => blockOp_vJ S M K x
  simp only [hL, LJ, br_vJ_vJ]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, brB_apply, br_vJ_vJ, LJ,
    inner2_sum_left', inner2_sum_right', inner2_smul_left', HamiltonsCubic.L226Statement.inner2_smul_right', vJ_orth, Finset.smul_sum]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have h10 := hS.apply 0 1
  have h20 := hS.apply 0 2
  have h21 := hS.apply 1 2
  simp only [Fin.sum_univ_three, eps_table, E3, Matrix.det_fin_three]
  simp [h10, h20, h21]
  ring

theorem br_anti' {κ : Type*} [Fintype κ] (X Y : Matrix κ κ ℝ) : br X Y = -br Y X := by
  simp only [br]; abel

theorem br_M_vJ (x p : Fin 3) (a : Fin m) :
    br (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr a)) (vJ x) = -∑ s, eps p s x • phi (.inl s) (.inr a) := by
  rw [br_anti', br_vJ_M]

theorem orthM (a : Fin m) (p q : Fin 3) :
    inner2 (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr a)) (phi (Sum.inl q) (Sum.inr a))
      = if p = q then 1 else 0 := by
  rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp

theorem QSMM (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (a : Fin m) :
    (∑ x, ∑ p, inner2 (blockOp S M K (br (blockOp S M K (vJ x)) (blockOp S M K (phi (.inl p) (.inr a)))))
        (br (vJ x) (phi (.inl p) (.inr a))))
    + (∑ p, ∑ x, inner2 (blockOp S M K (br (blockOp S M K (phi (.inl p) (.inr a))) (blockOp S M K (vJ x))))
        (br (phi (.inl p) (.inr a)) (vJ x)))
    + (∑ p, ∑ q, inner2 (blockOp S M K (br (blockOp S M K (phi (.inl p) (.inr a)))
          (blockOp S M K (phi (.inl q) (.inr a))))) (br (phi (.inl p) (.inr a)) (phi (.inl q) (.inr a))))
      = 6 * (S * (M a).adjugate).trace := by
  have hL : ∀ X, blockOp S M K X = opLin (blockCoeff S M K) X := fun _ => rfl
  have LJ : ∀ x, opLin (blockCoeff S M K) (vJ x) = ∑ y, S x y • vJ y := fun x => blockOp_vJ S M K x
  have LM : ∀ p, opLin (blockCoeff S M K) (phi (.inl p) (.inr a)) = ∑ q, M a p q • phi (.inl q) (.inr a) :=
    fun p => blockOp_M S M K p a
  have LP : ∀ p q, opLin (blockCoeff S M K) (phi (.inl p) (.inl q))
      = ∑ x, eps p q x • ∑ y, S x y • vJ y := by
    intro p q; rw [phi_vJ, map_sum]; simp only [map_smul, LJ]
  simp only [hL, LJ, LM, br_vJ_M, br_M_vJ, br_M_M, if_true, phi_self, ite_self, add_zero, zero_add]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, map_neg, LinearMap.sum_apply, LinearMap.smul_apply, LinearMap.neg_apply,
    brB_apply, br_vJ_M, br_M_vJ, br_M_M, if_true, phi_self, ite_self, add_zero, zero_add, LM, LP, LJ, phi_vJ,
    inner2_sum_left', inner2_sum_right', inner2_smul_left', HamiltonsCubic.L226Statement.inner2_smul_right',
    inner2_neg_left', inner2_neg_right', vJ_orth, orthM, Finset.smul_sum]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have h10 := hS.apply 0 1
  have h20 := hS.apply 0 2
  have h21 := hS.apply 1 2
  have m10 := (hM a).apply 0 1
  have m20 := (hM a).apply 0 2
  have m21 := (hM a).apply 1 2
  simp only [Fin.sum_univ_three, eps_table, E3, Matrix.adjugate_fin_three, Matrix.trace_fin_three,
    Matrix.mul_apply]
  simp [h10, h20, h21, m10, m20, m21]
  ring

theorem inner2_zero_l {κ : Type*} [Fintype κ] (X : Matrix κ κ ℝ) : inner2 0 X = 0 := by simp [inner2]
theorem inner2_zero_r {κ : Type*} [Fintype κ] (X : Matrix κ κ ℝ) : inner2 X 0 = 0 := by simp [inner2]

theorem br_M_K (a b c : Fin m) (p : Fin 3) :
    br (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr c)) (phi (Sum.inr a) (Sum.inr b))
      = -((if a = c then phi (Sum.inl p) (Sum.inr b) else 0) - (if b = c then phi (Sum.inl p) (Sum.inr a) else 0)) := by
  rw [br_anti', br_K_M]

theorem orthMM (p q : Fin 3) (a b : Fin m) :
    inner2 (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr a)) (phi (Sum.inl q) (Sum.inr b))
      = if p = q ∧ a = b then 1 else 0 := by
  rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp

theorem orthKK (a b : Fin m) (hab : a ≠ b) :
    inner2 (phi (Sum.inr a : Fin 3 ⊕ Fin m) (Sum.inr b)) (phi (Sum.inr a) (Sum.inr b)) = 1 := by
  rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]; simp [hab]

theorem QKMM (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (hM : ∀ a, (M a).IsSymm) (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (a b : Fin m) (hab : a ≠ b) :
    4 * (∑ p, ∑ q, inner2 (blockOp S M K (br (blockOp S M K (phi (.inl p) (.inr a)))
          (blockOp S M K (phi (.inl q) (.inr b))))) (br (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b))))
    + 2 * (∑ c, ∑ p, inner2 (blockOp S M K (br (blockOp S M K (phi (.inl p) (.inr c)))
          (blockOp S M K (phi (.inr a) (.inr b))))) (br (phi (.inl p) (.inr c)) (phi (.inr a) (.inr b))))
    + 2 * (∑ c, ∑ p, inner2 (blockOp S M K (br (blockOp S M K (phi (.inr a) (.inr b)))
          (blockOp S M K (phi (.inl p) (.inr c))))) (br (phi (.inr a) (.inr b)) (phi (.inl p) (.inr c))))
      = 12 * (K a b * (M a * M b).trace) := by
  have hL : ∀ X, blockOp S M K X = opLin (blockCoeff S M K) X := fun _ => rfl
  have LM : ∀ c p, opLin (blockCoeff S M K) (phi (.inl p) (.inr c)) = ∑ q, M c p q • phi (.inl q) (.inr c) :=
    fun c p => blockOp_M S M K p c
  have LK : ∀ a b, opLin (blockCoeff S M K) (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOp_K' S M K hK a b
  have hba : b ≠ a := Ne.symm hab
  have hz : ∀ c, c ≠ a ∧ c ≠ b → ∀ p : Fin 3,
      br (phi (Sum.inl p : Fin 3 ⊕ Fin m) (Sum.inr c)) (phi (Sum.inr a) (Sum.inr b)) = 0 := by
    intro c hc p; rw [br_M_K]; simp [Ne.symm hc.1, Ne.symm hc.2]
  have hz' : ∀ c, c ≠ a ∧ c ≠ b → ∀ p : Fin 3,
      br (phi (Sum.inr a : Fin 3 ⊕ Fin m) (Sum.inr b)) (phi (Sum.inl p) (Sum.inr c)) = 0 := by
    intro c hc p; rw [br_K_M]; simp [Ne.symm hc.1, Ne.symm hc.2]
  rw [Fintype.sum_eq_add a b hab, Fintype.sum_eq_add a b hab]
  rotate_left
  · intro c hc; exact Finset.sum_eq_zero fun p _ => by rw [hz' c hc p]; simp [inner2]
  · intro c hc; exact Finset.sum_eq_zero fun p _ => by rw [hz c hc p]; simp [inner2]
  simp only [hL, LM, LK]
  simp only [← brB_apply]
  simp only [map_sum, map_smul, map_neg, map_sub, LinearMap.sum_apply, LinearMap.smul_apply,
    LinearMap.neg_apply, LinearMap.sub_apply, brB_apply, br_M_M, br_M_K, br_K_M, hab, hba, if_false,
    if_true, add_zero, sub_zero, zero_sub, smul_ite, smul_zero, map_add, ite_smul, zero_smul]
  simp only [apply_ite (opLin (blockCoeff S M K)), map_zero, map_sum, map_smul, map_neg, map_sub, LM, LK]
  simp only [inner2_sum_left', inner2_sum_right', inner2_smul_left',
    HamiltonsCubic.L226Statement.inner2_smul_right', inner2_neg_left', inner2_neg_right', orthMM,
    orthKK a b hab, apply_ite (fun X => inner2 X _), apply_ite (inner2 _), hab, hba, and_false, and_true,
    if_false, if_true, mul_ite, mul_one, mul_zero, ite_mul, zero_mul]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, Finset.sum_const_zero]
  have ma := fun i j => (hM a).apply i j
  have mb := fun i j => (hM b).apply i j
  simp only [Fin.sum_univ_three, Matrix.trace_fin_three, Matrix.mul_apply]
  simp only [inner2_zero_l, inner2_zero_r, inner2_smul_left', HamiltonsCubic.L226Statement.inner2_smul_right',
    orthKK a b hab]
  simp [ma 0 1, ma 0 2, ma 1 2, mb 0 1, mb 0 2, mb 1 2, hK b a, inner2_zero_l, inner2_zero_r,
    HamiltonsCubic.L226Statement.inner2_smul_left', orthKK a b hab]
  ring

theorem inner2_add_l {κ : Type*} [Fintype κ] (X Y Z : Matrix κ κ ℝ) : inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  simp [inner2, Matrix.add_mul, Matrix.trace_add]; ring
theorem inner2_add_r {κ : Type*} [Fintype κ] (X Y Z : Matrix κ κ ℝ) : inner2 Z (X + Y) = inner2 Z X + inner2 Z Y := by
  simp [inner2, Matrix.mul_add, Matrix.trace_add]; ring
theorem inner2_sub_l {κ : Type*} [Fintype κ] (X Y Z : Matrix κ κ ℝ) : inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  simp [inner2, Matrix.sub_mul, Matrix.trace_sub]; ring
theorem inner2_sub_r {κ : Type*} [Fintype κ] (X Y Z : Matrix κ κ ℝ) : inner2 Z (X - Y) = inner2 Z X - inner2 Z Y := by
  simp [inner2, Matrix.mul_sub, Matrix.trace_sub]; ring

theorem KK_pair (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) (a b c d : Fin m) (hab : a ≠ b) (hcd : c ≠ d) :
    inner2 (blockOp S M K (br (phi (Sum.inr a : Fin 3 ⊕ Fin m) (Sum.inr b)) (phi (Sum.inr c) (Sum.inr d))))
        (br (phi (Sum.inr a : Fin 3 ⊕ Fin m) (Sum.inr b)) (phi (Sum.inr c) (Sum.inr d)))
      = (if a = c then K b d else 0) + (if b = d then K a c else 0) + (if a = d then K b c else 0)
        + (if b = c then K a d else 0) := by
  have hL : ∀ X, blockOp S M K X = opLin (blockCoeff S M K) X := fun _ => rfl
  have LK : ∀ a b, opLin (blockCoeff S M K) (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOp_K' S M K hK a b
  rw [br_phi_phi, hL]
  simp only [Sum.inr.injEq, map_add, map_sub, map_smul, LK, inner2_add_l, inner2_add_r, inner2_sub_l,
    inner2_sub_r, inner2_smul_left', HamiltonsCubic.L226Statement.inner2_smul_right',
    HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  by_cases h1 : a = c <;> by_cases h2 : b = d <;> by_cases h3 : a = d <;> by_cases h4 : b = c <;>
    by_cases h5 : c = d <;> subst_vars <;> simp_all [hK0] <;> ring_nf <;> simp_all [hK0, hK]

theorem coll_fst' {β ι' : Type*} [AddCommMonoid β] [Fintype ι'] (a : Fin m) (g : Fin m → ι' → β) :
    ∑ x, ∑ y, (if a = x then g x y else 0) = ∑ y, g a y := by
  rw [Finset.sum_eq_single a (fun x _ hx => by simp [Ne.symm hx]) (by simp)]
  simp

theorem QKK_total (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    ∑ a, ∑ b, ∑ c, ∑ d, inner2 (blockOp S M K (br (blockOp S M K (phi (.inr a) (.inr b)))
        (blockOp S M K (phi (.inr c) (.inr d))))) (br (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d)))
      = 4 * ∑ a, ∑ b, ∑ d, K a b * K a d * K b d := by
  have hL : ∀ X, blockOp S M K X = opLin (blockCoeff S M K) X := fun _ => rfl
  have LK : ∀ a b, opLin (blockCoeff S M K) (phi (.inr a) (.inr b)) = K a b • phi (.inr a) (.inr b) :=
    fun a b => blockOp_K' S M K hK a b
  have Qg : ∀ a b c d : Fin m, inner2 (blockOp S M K (br (blockOp S M K (phi (.inr a) (.inr b)))
        (blockOp S M K (phi (.inr c) (.inr d))))) (br (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d)))
      = K a b * K c d * ((if a = c then K b d else 0) + (if b = d then K a c else 0)
          + (if a = d then K b c else 0) + (if b = c then K a d else 0)) := by
    intro a b c d
    by_cases hab : a = b
    · subst hab; simp [phi_self, hK0, br, inner2]
    by_cases hcd : c = d
    · subst hcd; simp [phi_self, hK0, br, inner2]
    rw [← KK_pair S M K hK hK0 a b c d hab hcd]
    simp only [hL, LK]
    simp only [← brB_apply]
    simp only [map_smul, LinearMap.smul_apply, brB_apply, inner2_smul_left']
    ring
  simp only [Qg, mul_add, mul_ite, mul_zero, Finset.sum_add_distrib]
  simp only [Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true, coll_fst']
  have e2 : ∑ a, ∑ b, ∑ c, K a b * K c b * K a c = ∑ a, ∑ b, ∑ d, K a b * K a d * K b d :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by
      rw [hK c b]; ring
  have e3 : ∑ a, ∑ b, ∑ c, K a b * K c a * K b c = ∑ a, ∑ b, ∑ d, K a b * K a d * K b d :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by
      rw [hK c a]
  have e4 : ∑ a, ∑ b, ∑ d, K a b * K b d * K a d = ∑ a, ∑ b, ∑ d, K a b * K a d * K b d :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by
      ring
  linarith [e2, e3, e4]

theorem tri6 (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    ∑ a, ∑ b, ∑ d, K a b * K a d * K b d
      = 6 * ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0) := by
  have rot3 : ∀ F : Fin m → Fin m → Fin m → ℝ, ∑ a, ∑ b, ∑ c, F a b c = ∑ c, ∑ a, ∑ b, F a b c :=
    fun F => by
      calc ∑ a, ∑ b, ∑ c, F a b c = ∑ a, ∑ c, ∑ b, F a b c := Finset.sum_congr rfl fun a _ => Finset.sum_comm
        _ = ∑ c, ∑ a, ∑ b, F a b c := Finset.sum_comm
  have sw23 : ∀ F : Fin m → Fin m → Fin m → ℝ, ∑ a, ∑ b, ∑ c, F a b c = ∑ a, ∑ c, ∑ b, F a b c :=
    fun F => Finset.sum_congr rfl fun a _ => Finset.sum_comm
  -- step 1: split off `a < b`
  have s1 : ∀ a b c : Fin m, K a b * K a c * K b c
      = (if a < b then K a b * K a c * K b c else 0) + (if b < a then K b a * K b c * K a c else 0) := by
    intro a b c
    rcases lt_trichotomy a b with h | rfl | h
    · simp [h, h.asymm]
    · simp [hK0]
    · simp [h, h.asymm]; rw [hK a b]; ring
  have step1 : ∑ a, ∑ b, ∑ d, K a b * K a d * K b d
      = 2 * ∑ a, ∑ b, ∑ c, (if a < b then K a b * K a c * K b c else 0) := by
    rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
      s1 a b c]
    simp only [Finset.sum_add_distrib]
    have : ∑ a, ∑ b, ∑ c, (if b < a then K b a * K b c * K a c else 0)
        = ∑ a, ∑ b, ∑ c, (if a < b then K a b * K a c * K b c else 0) := Finset.sum_comm
    rw [this]; ring
  -- step 2: place `c` relative to `a < b`
  have s2 : ∀ a b c : Fin m, (if a < b then K a b * K a c * K b c else 0)
      = (if c < a ∧ a < b then K a b * K a c * K b c else 0)
        + (if a < c ∧ c < b then K a b * K a c * K b c else 0)
        + (if a < b ∧ b < c then K a b * K a c * K b c else 0) := by
    intro a b c
    by_cases hab : a < b
    · rcases lt_trichotomy c a with h | rfl | h
      · simp [hab, h, h.asymm, (h.trans hab).asymm]
      · simp [hab, hK0]
      · rcases lt_trichotomy c b with h2 | rfl | h2
        · simp [hab, h, h2, h.asymm, h2.asymm]
        · simp [hab, hK0, h.asymm]
        · simp [hab, h, h2, h.asymm, h2.asymm]
    · have hn : ¬(a < c ∧ c < b) := fun h => hab (h.1.trans h.2)
      simp [hab, hn]
  have tA : ∑ a, ∑ b, ∑ c, (if c < a ∧ a < b then K a b * K a c * K b c else 0)
      = ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0) := by
    rw [rot3]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => ?_
    split_ifs <;> first | rfl | (rw [hK c a, hK b a]; ring) | ring
  have tB : ∑ a, ∑ b, ∑ c, (if a < c ∧ c < b then K a b * K a c * K b c else 0)
      = ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0) := by
    rw [sw23]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => ?_
    split_ifs <;> first | rfl | (rw [hK c b]; ring) | ring
  rw [step1]
  rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
    s2 a b c]
  simp only [Finset.sum_add_distrib]
  rw [tA, tB]
  ring

/-! ### `P(W) = blockP`: the assembly -/

local notation "Mt" m => Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ

/-- The summand of the `Φ` formula. -/
noncomputable def QF (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (X Y : Mt m) : ℝ :=
  inner2 (blockOp S M K (br (blockOp S M K X) (blockOp S M K Y))) (br X Y)

/-- `QF · Y` polarised in its first slot. -/
noncomputable def BL (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (Y : Mt m) : (Mt m) →ₗ[ℝ] (Mt m) →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ (fun X X' => inner2 (opLin (blockCoeff S M K) (brB (opLin (blockCoeff S M K) X)
      (opLin (blockCoeff S M K) Y))) (brB X' Y))
    (fun X1 X2 X' => by simp only [map_add, LinearMap.add_apply, inner2_add_l])
    (fun c X X' => by simp only [map_smul, LinearMap.smul_apply, inner2_smul_left', smul_eq_mul])
    (fun X X1 X2 => by simp only [map_add, LinearMap.add_apply, inner2_add_r])
    (fun c X X' => by simp only [map_smul, LinearMap.smul_apply,
      HamiltonsCubic.L226Statement.inner2_smul_right', smul_eq_mul])

/-- `QF X ·` polarised in its second slot. -/
noncomputable def BR (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (X : Mt m) : (Mt m) →ₗ[ℝ] (Mt m) →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ (fun Y Y' => inner2 (opLin (blockCoeff S M K) (brB (opLin (blockCoeff S M K) X)
      (opLin (blockCoeff S M K) Y))) (brB X Y'))
    (fun Y1 Y2 Y' => by simp only [map_add, inner2_add_l])
    (fun c Y Y' => by simp only [map_smul, inner2_smul_left', smul_eq_mul])
    (fun Y Y1 Y2 => by simp only [map_add, inner2_add_r])
    (fun c Y Y' => by simp only [map_smul, HamiltonsCubic.L226Statement.inner2_smul_right', smul_eq_mul])

theorem BL_apply (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (X Y : Mt m) : BL S M K Y X X = QF S M K X Y := rfl

theorem BR_apply (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (X Y : Mt m) : BR S M K X Y Y = QF S M K X Y := rfl

theorem sum_QF (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, QF S M K (phi i j) (phi k l)
      = 2 * ∑ x, (2 * ∑ y, QF S M K (vJ x) (vJ y)
            + 2 * ∑ q, ∑ b, QF S M K (vJ x) (phi (.inl q) (.inr b))
            + ∑ c, ∑ d, QF S M K (vJ x) (phi (.inr c) (.inr d)))
        + 2 * ∑ p, ∑ a, (2 * ∑ y, QF S M K (phi (.inl p) (.inr a)) (vJ y)
            + 2 * ∑ q, ∑ b, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b))
            + ∑ c, ∑ d, QF S M K (phi (.inl p) (.inr a)) (phi (.inr c) (.inr d)))
        + ∑ a, ∑ b, (2 * ∑ y, QF S M K (phi (.inr a) (.inr b)) (vJ y)
            + 2 * ∑ q, ∑ c, QF S M K (phi (.inr a) (.inr b)) (phi (.inl q) (.inr c))
            + ∑ c, ∑ d, QF S M K (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d))) := by
  have h1 : ∀ X : Mt m, ∑ k, ∑ l, QF S M K X (phi k l)
      = 2 * ∑ y, QF S M K X (vJ y) + 2 * ∑ q, ∑ b, QF S M K X (phi (.inl q) (.inr b))
        + ∑ c, ∑ d, QF S M K X (phi (.inr c) (.inr d)) := fun X => quad_split (BR S M K X)
  have hF : ∀ X : Mt m, ∑ k, ∑ l, QF S M K X (phi k l)
      = (∑ k, ∑ l, BL S M K (phi k l)) X X := by
    intro X; simp only [LinearMap.sum_apply, BL_apply]
  simp only [hF]
  rw [quad_split]
  simp only [← hF, h1]

theorem rot3' {α β γ : Type*} [Fintype α] [Fintype β] [Fintype γ] (F : α → β → γ → ℝ) :
    ∑ a, ∑ b, ∑ c, F a b c = ∑ c, ∑ a, ∑ b, F a b c := by
  calc ∑ a, ∑ b, ∑ c, F a b c = ∑ a, ∑ c, ∑ b, F a b c := Finset.sum_congr rfl fun a _ => Finset.sum_comm
    _ = ∑ c, ∑ a, ∑ b, F a b c := Finset.sum_comm

theorem perm_MM {α β : Type*} [Fintype α] [Fintype β] (F : α → β → α → β → ℝ) :
    ∑ p, ∑ a, ∑ q, ∑ b, F p a q b = ∑ a, ∑ b, ∑ p, ∑ q, F p a q b := by
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun a _ => rot3' (fun p q b => F p a q b)

theorem sum4_swap' {α β γ δ : Type*} [Fintype α] [Fintype β] [Fintype γ] [Fintype δ]
    (f : α → β → γ → δ → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
  calc ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ i, ∑ k, ∑ l, ∑ j, f i j k l :=
        Finset.sum_congr rfl fun i _ => by rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
        rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun k _ => Finset.sum_comm

theorem split_diag (f : Fin m → Fin m → ℝ) :
    ∑ a, ∑ b, f a b = ∑ a, f a a + ∑ a, ∑ b, (if ¬a = b then f a b else 0) := by
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun a _ => ?_
  have e : ∀ b, f a b = (if a = b then f a b else 0) + (if ¬a = b then f a b else 0) := by
    intro b; by_cases h : a = b <;> simp [h]
  rw [Finset.sum_congr rfl fun b _ => e b, Finset.sum_add_distrib, Finset.sum_ite_eq]
  simp

theorem offdiag_of_diag (f : Fin m → Fin m → ℝ) (h : ∀ a, f a a = 0) :
    ∑ a, ∑ b, f a b = ∑ a, ∑ b, (if ¬a = b then f a b else 0) := by
  rw [split_diag]; simp [h]

theorem ite_mul_zero (c : Prop) [Decidable c] (k x : ℝ) :
    (if c then k * x else 0) = k * (if c then x else 0) := by
  split_ifs <;> simp

theorem ite_three (c : Prop) [Decidable c] (x : ℝ) :
    (if c then 3 * x else 0) = 3 * (if c then x else 0) := by
  split_ifs <;> simp

theorem ite_add_zero' (c : Prop) [Decidable c] (x y : ℝ) :
    (if c then x + y else 0) = (if c then x else 0) + (if c then y else 0) := by
  split_ifs <;> simp

theorem Pcubic_final (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    Pcubic (blockOp S M K) = blockP S M K := by
  have hT := trCube_blockOp S hS M hM K hK
  have hP : sharpPair (blockOp S M K)
      = (1 / 8) * ∑ i, ∑ j, ∑ k, ∑ l, QF S M K (phi i j) (phi k l) := sharpPair_blockOp_formula S M K
  rw [sum_QF] at hP
  -- the J-K pairs vanish
  have JK : ∀ x c d, QF S M K (vJ x) (phi (.inr c) (.inr d)) = 0 := by
    intro x c d; simp only [QF, br_vJ_K, inner2_zero_r]
  have KJ : ∀ a b y, QF S M K (phi (.inr a) (.inr b)) (vJ y) = 0 := by
    intro a b y; simp only [QF]; rw [br_anti' (phi _ _) (vJ y), br_vJ_K, neg_zero, inner2_zero_r]
  -- a degenerate outer pair vanishes
  have Kd1 : ∀ a p c, QF S M K (phi (.inl p) (.inr c)) (phi (.inr a) (.inr a)) = 0 := by
    intro a p c; simp only [QF, phi_self, br, Matrix.mul_zero, Matrix.zero_mul, sub_zero, inner2_zero_r]
  have Kd2 : ∀ a p c, QF S M K (phi (.inr a) (.inr a)) (phi (.inl p) (.inr c)) = 0 := by
    intro a p c; simp only [QF, phi_self, br, Matrix.mul_zero, Matrix.zero_mul, sub_zero, inner2_zero_r]
  simp only [JK, KJ, Finset.sum_const_zero, mul_zero, add_zero] at hP
  -- the S·M·M sums
  have hJM : ∑ x, ∑ q, ∑ b, QF S M K (vJ x) (phi (.inl q) (.inr b))
      = ∑ b, ∑ x, ∑ q, QF S M K (vJ x) (phi (.inl q) (.inr b)) := rot3' _
  have hMJ : ∑ p, ∑ a, ∑ y, QF S M K (phi (.inl p) (.inr a)) (vJ y)
      = ∑ a, ∑ p, ∑ y, QF S M K (phi (.inl p) (.inr a)) (vJ y) := Finset.sum_comm
  have hSMM : ∀ a, (∑ x, ∑ p, QF S M K (vJ x) (phi (.inl p) (.inr a)))
      + (∑ p, ∑ x, QF S M K (phi (.inl p) (.inr a)) (vJ x))
      + (∑ p, ∑ q, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr a)))
      = 6 * (S * (M a).adjugate).trace := fun a => QSMM S hS M hM K a
  -- the cross sums
  have hMK : ∑ p, ∑ a, ∑ c, ∑ d, QF S M K (phi (.inl p) (.inr a)) (phi (.inr c) (.inr d))
      = ∑ c, ∑ d, (if ¬c = d then ∑ a, ∑ p, QF S M K (phi (.inl p) (.inr a)) (phi (.inr c) (.inr d)) else 0) := by
    rw [sum4_swap', offdiag_of_diag _ (fun c => by simp only [Kd1, Finset.sum_const_zero])]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => by rw [Finset.sum_comm]
  have hKM : ∑ a, ∑ b, ∑ q, ∑ c, QF S M K (phi (.inr a) (.inr b)) (phi (.inl q) (.inr c))
      = ∑ a, ∑ b, (if ¬a = b then ∑ c, ∑ q, QF S M K (phi (.inr a) (.inr b)) (phi (.inl q) (.inr c)) else 0) := by
    rw [offdiag_of_diag _ (fun a => by simp only [Kd2, Finset.sum_const_zero])]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [Finset.sum_comm]
  have hcross : 4 * (∑ a, ∑ b, (if ¬a = b then
          ∑ p, ∑ q, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b)) else 0))
      + 2 * (∑ c, ∑ d, (if ¬c = d then ∑ a, ∑ p, QF S M K (phi (.inl p) (.inr a)) (phi (.inr c) (.inr d)) else 0))
      + 2 * (∑ a, ∑ b, (if ¬a = b then ∑ c, ∑ q, QF S M K (phi (.inr a) (.inr b)) (phi (.inl q) (.inr c)) else 0))
      = 24 * ∑ a, ∑ b, (if a < b then K a b * (M a * M b).trace else 0) := by
    calc _ = ∑ a, ∑ b, 12 * (if ¬a = b then K a b * (M a * M b).trace else 0) := by
          simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
          refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
          by_cases hab : a = b
          · simp [hab]
          · simp only [hab, not_false_eq_true, if_true]
            have := QKMM S M hM K hK a b hab
            simp only [QF]
            linarith [this]
      _ = 24 * ∑ a, ∑ b, (if a < b then K a b * (M a * M b).trace else 0) := by
          simp only [← Finset.mul_sum]
          rw [offdiag_sym (fun a b => K a b * (M a * M b).trace)
            (fun a b => by rw [hK a b, Matrix.trace_mul_comm])]
          ring
  have hKK : ∑ a, ∑ b, ∑ c, ∑ d, QF S M K (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d))
      = 24 * ∑ a, ∑ b, ∑ c, (if a < b ∧ b < c then K a b * K a c * K b c else 0) := by
    rw [show ∑ a, ∑ b, ∑ c, ∑ d, QF S M K (phi (.inr a) (.inr b)) (phi (.inr c) (.inr d))
        = 4 * ∑ a, ∑ b, ∑ d, K a b * K a d * K b d from QKK_total S M K hK hK0, tri6 K hK hK0]
    ring
  have hJJ : ∑ x, ∑ y, QF S M K (vJ x) (vJ y) = 6 * S.det := QJJ S hS M K
  have hSMMt : ∑ x, ∑ q, ∑ b, QF S M K (vJ x) (phi (.inl q) (.inr b))
      + ∑ p, ∑ a, ∑ y, QF S M K (phi (.inl p) (.inr a)) (vJ y)
      + ∑ a, (∑ p, ∑ q, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr a)))
      = 6 * ∑ a, (S * (M a).adjugate).trace := by
    rw [hJM, hMJ, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib, Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => hSMM a
  have hMM' : ∑ p, ∑ a, ∑ q, ∑ b, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b))
      = ∑ a, (∑ p, ∑ q, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr a)))
        + ∑ a, ∑ b, (if ¬a = b then
            ∑ p, ∑ q, QF S M K (phi (.inl p) (.inr a)) (phi (.inl q) (.inr b)) else 0) := by
    rw [perm_MM, split_diag]
  simp only [Finset.sum_add_distrib, ← Finset.mul_sum, zero_add] at hP
  unfold Pcubic
  rw [hT, hP]
  unfold blockP cubicJ
  simp only [Finset.sum_add_distrib, ite_add_zero', mul_assoc (3 : ℝ), ite_three, ← Finset.mul_sum]
  linear_combination (1 / 8 : ℝ) * (4 * hJJ + 4 * hSMMt + 4 * hMM' + 2 * hMK + 2 * hKM + hcross + hKK)

/-- **L226, items 1 and 3, against the base layer's `P`.** -/
theorem Pcubic_blockOp (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    Pcubic (blockOp S M K) = blockP S M K :=
  Pcubic_final S hS M hM K hK hK0


set_option maxHeartbeats 2000000 in
/-- **The norm on `𝒮_J`**: `‖W‖² = |S|² + Σ |M_a|² + Σ_{a<b} K_ab²`. -/
theorem normSq_blockOp (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) :
    normSq (blockOp S M K) = (S * S).trace + ∑ a, (M a * M a).trace
      + ∑ a, ∑ b, (if a < b then K a b ^ 2 else 0) := by
  rw [blockOp_eq_opOf, normSq_opOf]
  simp only [Fintype.sum_sum_type, blockCoeff]
  simp only [J_bracket, ite_bracket_pos, ite_bracket_neg, K_bracket K hK, sub_self, mul_zero,
    ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, Finset.sum_const_zero, add_zero,
    zero_add, Finset.sum_add_distrib]
  have hT : ∑ a, (M a * M a).trace = ∑ a, ∑ p, ∑ q, M a p q ^ 2 := by
    refine Finset.sum_congr rfl fun a _ => ?_
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, pow_two]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [(hM a).apply p q]
  have h1 : ∑ x : Fin 3, ∑ x_1 : Fin m, ∑ x_2 : Fin 3, ∑ x_3 : Fin m,
      (if x_1 = x_3 then M x_1 x x_2 ^ 2 else 0) = ∑ a, ∑ p, ∑ q, M a p q ^ 2 := by
    simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
    exact Finset.sum_comm
  have h2 : ∑ x : Fin 3, ∑ x_1 : Fin m, ∑ x_2 : Fin m, ∑ x_3 : Fin 3,
      (if x_1 = x_2 then M x_1 x x_3 ^ 2 else 0) = ∑ a, ∑ p, ∑ q, M a p q ^ 2 := by
    simp only [coll1]
    exact Finset.sum_comm
  have h3 : ∑ x : Fin m, ∑ x_1 : Fin 3, ∑ x_2 : Fin 3, ∑ x_3 : Fin m,
      (if x = x_3 then M x x_1 x_2 ^ 2 else 0) = ∑ a, ∑ p, ∑ q, M a p q ^ 2 := by
    simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have h4 : ∑ x : Fin m, ∑ x_1 : Fin 3, ∑ x_2 : Fin m, ∑ x_3 : Fin 3,
      (if x = x_2 then M x x_1 x_3 ^ 2 else 0) = ∑ a, ∑ p, ∑ q, M a p q ^ 2 := by
    simp only [coll1]
  simp only [K_coll, K_coll']
  rw [eps_S_sq S hS, h1, h2, h3, h4, K_offdiag K hK, hT]
  ring

/-- **L226, items 2 and 3, Ricci on `J`**: `Ric_pq = ((tr S) I - S)_pq + Σ_a (M_a)_pq`. -/
theorem Ric_blockOp_J (S : Matrix (Fin 3) (Fin 3) ℝ) (hS : S.IsSymm)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ) (hM : ∀ a, (M a).IsSymm)
    (K : Fin m → Fin m → ℝ) (p q : Fin 3) :
    Ric (blockOp S M K) (.inl p) (.inl q) = (S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S) p q + ∑ a, M a p q := by
  unfold HamiltonsCubic.RealLayer.Ric blockOp
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp only [blockCoeff, if_true]
  congr 1
  · rw [← eps_S_contract S hS p q]
    refine Finset.sum_congr rfl fun r _ => ?_
    simp only [eps_swap12 p r, eps_swap12 q r, neg_mul, mul_neg, neg_neg, Finset.sum_neg_distrib]
    ring
  · refine Finset.sum_congr rfl fun a _ => ?_
    ring

/-- **L226, item 2, Ricci at an outer index**: `Ric_aa = tr M_a + Σ_b K_ab`. -/
theorem Ric_blockOp_outer (S : Matrix (Fin 3) (Fin 3) ℝ)
    (M : Fin m → Matrix (Fin 3) (Fin 3) ℝ)
    (K : Fin m → Fin m → ℝ) (hK : ∀ a b, K a b = K b a) (hK0 : ∀ a, K a a = 0) (a : Fin m) :
    Ric (blockOp S M K) (.inr a) (.inr a) = (M a).trace + ∑ b, K a b := by
  unfold Ric blockOp
  simp only [pairing]
  rw [Fintype.sum_sum_type]
  simp only [blockCoeff, if_true, and_self, Matrix.trace, Matrix.diag]
  congr 1
  · refine Finset.sum_congr rfl fun p _ => ?_; ring
  · refine Finset.sum_congr rfl fun b _ => ?_
    by_cases hab : a = b
    · subst hab; simp [hK0]
    · simp [hab, Ne.symm hab, hK b a]; ring

/-- **Ricci-flatness on `J` fixes `R_J`**: `(tr S) I - S = -N` exactly when `S = N - ½ (tr N) I`. -/
theorem ricciJ_inverse (S N : Matrix (Fin 3) (Fin 3) ℝ) :
    S.trace • (1 : Matrix (Fin 3) (Fin 3) ℝ) - S = -N ↔ S = N - ((1 / 2 : ℝ) * N.trace) • 1 := by
  constructor
  · intro h
    have hij : ∀ i j, S.trace * (1 : Matrix (Fin 3) (Fin 3) ℝ) i j - S i j = -N i j := fun i j => by
      have := congrFun (congrFun h i) j
      simpa [Matrix.sub_apply, Matrix.smul_apply] using this
    have h00 := hij 0 0
    have h11 := hij 1 1
    have h22 := hij 2 2
    simp only [Matrix.one_apply_eq, mul_one] at h00 h11 h22
    have htr : S.trace = -(1 / 2) * N.trace := by
      have e1 := trace_fin_three S
      have e2 := trace_fin_three N
      linarith
    ext i j
    have := hij i j
    rw [htr] at this
    simp only [Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul]
    linear_combination (-1 : ℝ) * this
  · rintro rfl
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.sub_apply, Matrix.smul_apply, trace_fin_three] <;> ring

/-- **At a diagonal `S`**, `tr S³ + 3 det S` is the three cubes and the one triangle of `J`. -/
theorem cubicJ_diagonal (s : Fin 3 → ℝ) :
    cubicJ (diagonal s) = s 0 ^ 3 + s 1 ^ 3 + s 2 ^ 3 + 3 * (s 0 * s 1 * s 2) := by
  simp [cubicJ, diagonal_mul_diagonal, Fin.sum_univ_three, Fin.prod_univ_three]
  ring

/-- **At diagonal `S` and `M`**, `tr(S adj M)` is the three triangles through the outer index:
`S`'s entry on `φ₂₃` meets `M`'s entries on `φ₂ₐ` and `φ₃ₐ`. -/
theorem coupling_diagonal (s u : Fin 3 → ℝ) :
    (diagonal s * (diagonal u).adjugate).trace
      = s 0 * (u 1 * u 2) + s 1 * (u 0 * u 2) + s 2 * (u 0 * u 1) := by
  simp [adjugate_fin_three, trace_fin_three, Matrix.mul_apply, diagonal]

/-- **The identity at `n = 6`**: `blockP` at `S = I`, `M_a = I`, `K = 1` off the diagonal is `75`, which is
`P(id) = (n-1) dim Λ² = 5 · 15`. -/
theorem blockP_identity :
    blockP (m := 3) (1 : Matrix (Fin 3) (Fin 3) ℝ) (fun _ => 1) (fun a b => if a = b then 0 else 1) = 75 := by
  simp [blockP, cubicJ, Fin.sum_univ_three]
  norm_num

end HamiltonsCubic.L226Statement
