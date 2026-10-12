import Mathlib
import HamiltonsCubic.Results.L244Frame
import HamiltonsCubic.Results.L244SymmetricPerVector
import HamiltonsCubic.Results.L244Bridge

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L244 (ii)'s rows at the operators, on the symmetric family

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 (ii): *If the eigenvalues are $(-a,0,a)$ … $E_0$ is the NEGATIVE
eigenspace and $E_1$ the kernel of $W$ … At $x\in E_0$, row (B) divided by $a$ is $b_{12}+b_{22}-b_{00}-b_{01}=1$, and row (C) divided
by $a^2$ is $2b_{02}-b_{00}-b_{22}=K$ with $K=\theta/a+1$. Row (A) then gives $K=(n-4)-4b_{00}-4b_{01}-b_{11}\le n-4$.*

At a critical linear Weyl `W` whose spectral eigenframe is labelled by three classes with values `(−a, 0, a)`, and `x` a frame vector of
class `0`, the rows of [L244Frame.lean](L244Frame.lean) become the three linear equations `per_vector_ceiling` takes:

* `bAB_symm`: `b_ab(x) = b_ba(x)` (the same fact as `L244RowA.bAB_symm`, r1856 O3);
* **`L244_rows`**: `hA`, `hB`, `hC` in the record's variables, with `K = θ/a + 1`;
* `class_equiv`, `class_orth`: a class frame reindexed by `Fin`, orthonormal, sending `0` to `x`'s index;
* **`cap_self`**, **`cap_other`**: the `E₀` and `E₂` Ky Fan caps, through `L244Bridge.rowMass_class`;
* **`L244_ceiling`**: `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)`, `θ ≤ a(κ₂ − 3)` at every frame vector of `E₀` (r1856 O7).
-/

namespace HamiltonsCubic.L244Sym

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244RowBMass HamiltonsCubic.L244Frame

variable {n : ℕ}

/-- `b_ab(x) = b_ba(x)`, the bracket being antisymmetric. -/
theorem bAB_symm {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a b : Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) :
    HamiltonsCubic.L244RowA.bAB ψ cls a b x = HamiltonsCubic.L244RowA.bAB ψ cls b a x := by
  unfold HamiltonsCubic.L244RowA.bAB
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun δ _ => Finset.sum_congr rfl fun γ _ => ?_
  have : br (ψ δ) (ψ γ) = -br (ψ γ) (ψ δ) := by unfold br; abel
  rw [this]
  unfold inner2
  simp [Matrix.trace_neg, neg_sq]

variable {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} {hW : IsWeylOp W}

/-- **L244 (ii)'s rows at the operators**: with classes `0, 1, 2` of values `−a, 0, a` and `x = ψ_{k₀}` of class `0`, rows (A), (B),
(C) are `per_vector_ceiling`'s `hA`, `hB`, `hC`. -/
theorem L244_rows {θ a : ℝ} (ha : 0 < a) (hc : IsCritical W θ)
    (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k)) (k₀ : Fin (Fintype.card (Pairs n)))
    (hk₀ : cls k₀ = 0) :
    let b := fun i j => HamiltonsCubic.L244RowA.bAB (ψf W hW) cls i j (ψf W hW k₀)
    b 0 0 + b 1 1 + b 2 2 + 2 * (b 0 1 + b 0 2 + b 1 2) = n - 2 ∧
      b 1 2 + b 2 2 - b 0 0 - b 0 1 = 1 ∧
      2 * b 0 2 - b 0 0 - b 2 2 = θ / a + 1 := by
  intro b
  set x := ψf W hW k₀ with hxdef
  have hx : IsSkew x := ψf_skew W hW k₀
  have hunit : inner2 x x = 1 := by
    have := (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1).orthonormal ((eF n).symm k₀) ((eF n).symm k₀)
    rw [if_pos rfl] at this
    exact this
  have hev : evf W hW k₀ = -a := by rw [hcls, hk₀]; rfl
  have hWx : W x = (-a) • x := by rw [hxdef, ψf_eigen W hW k₀, hev]
  have rA := rowA_frame (W := W) (hW := hW) cls x hx
  have rB := rowB_frame (W := W) (hW := hW) cls ![-a, 0, a] hcls x hx
  have rC := rowC_frame (W := W) (hW := hW) cls ![-a, 0, a] hcls x hx
  rw [rowC_critical W hW θ hc x hx (-a) hWx hunit] at rC
  rw [hWx, HamiltonsCubic.RealLayer.inner2_smul_left, hunit] at rB
  rw [hunit] at rA
  simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.head_cons, Matrix.tail_cons] at rA rB rC
  have s01 := bAB_symm (ψf W hW) cls 0 1 x
  have s02 := bAB_symm (ψf W hW) cls 0 2 x
  have s12 := bAB_symm (ψf W hW) cls 1 2 x
  simp only [b, ← hxdef]
  refine ⟨by linarith, ?_, ?_⟩
  · have : a * (HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 1 2 x + HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 2 2 x
        - HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 0 0 x - HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 0 1 x) = a * 1 := by
      linear_combination rB - a * s01 - a * s02
    exact mul_left_cancel₀ ha.ne' this
  · have : a * (2 * HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 0 2 x - HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 0 0 x
        - HamiltonsCubic.L244RowA.bAB (ψf W hW) cls 2 2 x) = a * (θ / a + 1) := by
      have e : a * (θ / a + 1) = θ + a := by field_simp
      rw [e]
      nlinarith
    exact mul_left_cancel₀ ha.ne' this

/-- A frame of class `c`, reindexed by `Fin m` with `m` the class size, sending `0` to a chosen member. -/
theorem class_equiv {r K : ℕ} (cls : Fin r → Fin K) (c : Fin K) (k₀ : Fin r) (hk₀ : cls k₀ = c) :
    ∃ m : ℕ, ∃ e : Fin (m + 1) ≃ {γ // cls γ = c}, (e 0).1 = k₀ := by
  have hpos : 0 < Fintype.card {γ // cls γ = c} := Fintype.card_pos_iff.mpr ⟨⟨k₀, hk₀⟩⟩
  refine ⟨Fintype.card {γ // cls γ = c} - 1, ?_⟩
  have hm : Fintype.card {γ // cls γ = c} - 1 + 1 = Fintype.card {γ // cls γ = c} := Nat.sub_add_cancel hpos
  let e0 : Fin (Fintype.card {γ // cls γ = c} - 1 + 1) ≃ {γ // cls γ = c} :=
    (finCongr hm).trans (Fintype.equivFin _).symm
  refine ⟨e0.trans (Equiv.swap (e0 0) ⟨k₀, hk₀⟩), ?_⟩
  simp [Equiv.swap_apply_left]

/-- The class family is orthonormal, the frame being orthonormal and `e` injective. -/
theorem class_orth {K m : ℕ} (cls : Fin (Fintype.card (Pairs n)) → Fin K) (c : Fin K)
    (e : Fin m ≃ {γ // cls γ = c}) (i j : Fin m) :
    inner2 (ψf W hW (e i).1) (ψf W hW (e j).1) = if i = j then 1 else 0 := by
  have h := (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1).orthonormal ((eF n).symm (e i).1) ((eF n).symm (e j).1)
  have hiff : ((eF n).symm (e i).1 = (eF n).symm (e j).1) ↔ i = j := by
    rw [Equiv.apply_eq_iff_eq, Subtype.val_inj, Equiv.apply_eq_iff_eq]
  simp only [hiff] at h
  exact h

/-- **The `E₀` cap**: with `x = ψ_{k₀}` of class `0` and `κ₀` bounding every set of at most `m₀ − 1` slot eigenvalues of every normal
form of `x`, `2(b₀₀ + b₀₁ + b₀₂) ≤ κ₀`. -/
theorem cap_self {K : ℕ} (cls : Fin (Fintype.card (Pairs n)) → Fin K) (c : Fin K) (k₀ : Fin (Fintype.card (Pairs n)))
    (hk₀ : cls k₀ = c) (κ₀ : ℝ)
    (htop : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → ψf W hW k₀ = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = c} - 1 →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₀)
    (hsize : 2 ≤ Fintype.card {γ // cls γ = c}) :
    2 * ∑ b, HamiltonsCubic.L244RowA.bAB (ψf W hW) cls c b (ψf W hW k₀) ≤ κ₀ := by
  obtain ⟨m, e, he⟩ := class_equiv cls c k₀ hk₀
  have hcard : Fintype.card {γ // cls γ = c} = m + 1 := by rw [← Fintype.card_fin (m + 1)]; exact (Fintype.card_congr e).symm
  rw [← HamiltonsCubic.L244Bridge.rowMass_class (ψf W hW) cls c e]
  obtain ⟨k, N, O, hO, hO', hxO, hdual⟩ := HamiltonsCubic.L244Caps.rowMass_cap_self (fun i => ψf W hW (e i).1)
    (fun i => ψf_skew W hW _) (class_orth cls c e) (ψf W hW) (ψf_complete W hW) (ψf W hW k₀) (ψf_skew W hW k₀)
    (by rw [he])
  have hm : 0 < m := by omega
  exact HamiltonsCubic.L244Caps.twice_rowMass_le_of_top hm N _ κ₀ hdual
    (fun S hS => htop k N O hO hO' hxO S (by rw [hcard]; simpa using hS))

/-- **The `E₂` cap**: `2(b₂₀ + b₂₁ + b₂₂) ≤ κ₂` with `κ₂` bounding every set of at most `m₂` slot eigenvalues. -/
theorem cap_other {K : ℕ} (cls : Fin (Fintype.card (Pairs n)) → Fin K) (c : Fin K) (x : Matrix (Fin n) (Fin n) ℝ)
    (hx : IsSkew x) (κ₂ : ℝ) (hsize : 0 < Fintype.card {γ // cls γ = c})
    (htop : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → x = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = c} →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₂) :
    2 * ∑ b, HamiltonsCubic.L244RowA.bAB (ψf W hW) cls c b x ≤ κ₂ := by
  let e : Fin (Fintype.card {γ // cls γ = c}) ≃ {γ // cls γ = c} := (Fintype.equivFin _).symm
  rw [← HamiltonsCubic.L244Bridge.rowMass_class (ψf W hW) cls c e]
  obtain ⟨k, N, O, hO, hO', hxO, hdual⟩ := HamiltonsCubic.L244Caps.rowMass_cap_x (fun i => ψf W hW (e i).1)
    (fun i => ψf_skew W hW _) (class_orth cls c e) (ψf W hW) (ψf_complete W hW) x hx
  exact HamiltonsCubic.L244Caps.twice_rowMass_le_of_top hsize N _ κ₂ hdual (fun S hS => htop k N O hO hO' hxO S hS)

/-- **L244 (ii) at the operators**: at a critical linear Weyl `W` whose eigenframe is labelled by three classes of values `(−a, 0, a)`,
`a > 0`, and `x = ψ_{k₀}` a frame vector of the negative class, with `κ₀` bounding the top `m₀ − 1` and `κ₂` the top `m₂` slot
eigenvalues of every normal form of `x`, `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)` and `θ ≤ a(κ₂ − 3)`, the record's
`θ ≤ (min(κ_{p−1}, κ_p − 2, n − 4) − 1)/√(2p)` at `a = 1/√(2p)`. -/
theorem L244_ceiling {θ a κ₀ κ₂ : ℝ} (ha : 0 < a) (hc : IsCritical W θ)
    (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k)) (k₀ : Fin (Fintype.card (Pairs n)))
    (hk₀ : cls k₀ = 0) (h0size : 2 ≤ Fintype.card {γ // cls γ = 0}) (h2size : 0 < Fintype.card {γ // cls γ = 2})
    (htop0 : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → ψf W hW k₀ = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = 0} - 1 →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₀)
    (htop2 : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → ψf W hW k₀ = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = 2} →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₂) :
    θ ≤ a * (n - 5) ∧ θ ≤ a * (κ₀ - 1) ∧ θ ≤ a * (κ₂ - 3) := by
  obtain ⟨hA, hB, hC⟩ := L244_rows (W := W) (hW := hW) ha hc cls hcls k₀ hk₀
  set x := ψf W hW k₀
  have c0 := cap_self (W := W) (hW := hW) cls 0 k₀ hk₀ κ₀ htop0 h0size
  have c2 := cap_other (W := W) (hW := hW) cls 2 x (ψf_skew W hW k₀) κ₂ h2size htop2
  simp only [Fin.sum_univ_three] at c0 c2
  have s02 := bAB_symm (ψf W hW) cls 0 2 x
  have s12 := bAB_symm (ψf W hW) cls 1 2 x
  have n00 := HamiltonsCubic.L244Caps.bMass_nonneg (fun γ => ψf W hW γ) (ψf W hW) cls 0 x
  have hnn : ∀ i j, 0 ≤ HamiltonsCubic.L244RowA.bAB (ψf W hW) cls i j x := fun i j => by
    unfold HamiltonsCubic.L244RowA.bAB
    exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _)
  have hK := HamiltonsCubic.L244SymmetricPerVector.per_vector_ceiling n (θ / a + 1) κ₀ κ₂ _ _ _ _ _ _
    (hnn 0 0) (hnn 0 1) (hnn 1 1) (hnn 2 2) hA hB hC c0 (by linarith)
  exact HamiltonsCubic.L244SymmetricPerVector.theta_bound n a θ (θ / a + 1) κ₀ κ₂ ha (by field_simp; ring) hK

end HamiltonsCubic.L244Sym
