import HamiltonsCubic.Results.L176Statement
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Results.L41Statement

set_option linter.style.longLine false

/-!
# L176's two bridges, in the operator model

[L176Statement.lean](L176Statement.lean) proves L176 as a matrix theorem, `four_le_card_edges`, and declares
two bridges as prose: that the coordinate-diagonal Weyl locus is exactly the hollow symmetric matrices with
vanishing row sums, and that the `Λ²`-rank is the number of nonzero entries above the diagonal. Both are
proved here for the operator `W_K` diagonal in the coordinate frame:

* **`WD`**, `W_K = ½ Σ_{a,b} K_{ab} ⟨·, φ_{ab}⟩ φ_{ab}`, and **`WD_phi`**: `W_K φ_{cd} = K_{cd} φ_{cd}`, the
  locus identity `W(f_a ∧ f_b) = K_{ab} f_a ∧ f_b`;
* **`WD_weyl_iff`**: for `K` symmetric and hollow, `W_K` is Weyl exactly when every row of `K` sums to zero;
* **`coeffD_eq`**, **`rank_coeffD`**: the matrix of `W_K` on the orthonormal basis `{φ_{ab}}_{a<b}` is
  diagonal with entries `K_{ab}`, so its rank is the number of edges of `K`'s support graph;
* **`L176_op`**: a nonzero Weyl operator diagonal in the coordinate frame has `Λ²`-rank at least four.
-/

namespace HamiltonsCubic.L176

open Matrix Finset HamiltonsCubic.RealLayer

variable {n : ℕ}

/-- **The coordinate-diagonal operator** `W_K = ½ Σ_{a,b} K_{ab} ⟨·, φ_{ab}⟩ φ_{ab}`. -/
noncomputable def WD (K : Matrix (Fin n) (Fin n) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, ∑ b, ((1 / 2) * K a b * inner2 X (phi a b)) • phi a b

theorem WD_inner (K : Matrix (Fin n) (Fin n) ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (WD K X) Y = ∑ a, ∑ b, (1 / 2) * K a b * inner2 X (phi a b) * inner2 (phi a b) Y := by
  unfold WD
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  exact Finset.sum_congr rfl fun b _ => by rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l]

theorem dsum_ite {M : Type*} [AddCommMonoid M] (f : Fin n → Fin n → M) (c d : Fin n) :
    (∑ x, ∑ y, if c = x then (if d = y then f x y else 0) else 0) = f c d := by
  rw [Finset.sum_eq_single c (fun x _ hx => by simp [Ne.symm hx]) (by simp)]
  simp

/-- **The locus identity**: `W_K φ_{cd} = K_{cd} φ_{cd}` for symmetric `K`. -/
theorem WD_phi (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a) (c d : Fin n) :
    WD K (phi c d) = K c d • phi c d := by
  unfold WD
  simp only [HamiltonsCubic.FamilyLayer.inner2_phi_phi, mul_sub, sub_smul, Finset.sum_sub_distrib, mul_ite,
    mul_one, mul_zero, ite_smul, zero_smul, ite_and]
  rw [dsum_ite (fun x y => (1 / 2 * K x y) • phi x y), dsum_ite (fun x y => (1 / 2 * K x y) • phi x y)]
  rw [phi_swap d c, hs d c]
  module

theorem WD_skew (K : Matrix (Fin n) (Fin n) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : IsSkew (WD K X) := by
  have hp : ∀ a b : Fin n, (phi a b)ᵀ = -phi a b := fun a b => phi_isSkew a b
  unfold IsSkew WD
  simp only [Matrix.transpose_sum, Matrix.transpose_smul, hp, smul_neg, Finset.sum_neg_distrib]

set_option linter.flexible false in
theorem ric_WD (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a) (hh : ∀ a, K a a = 0) (a b : Fin n) :
    Ric (WD K) a b = if a = b then ∑ c, K a c else 0 := by
  unfold Ric
  simp only [WD_phi K hs, HamiltonsCubic.L41Statement.Frame.inner2_smul_l,
    HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  by_cases hab : a = b
  · subst hab
    simp only [true_and, if_true, mul_sub, mul_one, mul_ite, mul_zero, Finset.sum_sub_distrib]
    have : ∑ x, (if x = a ∧ a = x then K a x else 0) = 0 :=
      Finset.sum_eq_zero fun x _ => by
        split_ifs with h
        · rw [h.1, hh]
        · rfl
    rw [this, sub_zero]
  · simp [hab]
    refine Finset.sum_eq_zero fun c _ => ?_
    split_ifs with h
    · obtain ⟨rfl, rfl⟩ := h; simp [hh]
    · simp

/-- **First Bianchi holds on the whole coordinate-diagonal family**, with no condition beyond symmetry. -/
theorem bianchi_WD (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a)
    (i j k l : Fin n) : bianchi (WD K) i j k l = 0 := by
  unfold bianchi
  simp only [WD_phi K hs, HamiltonsCubic.L41Statement.Frame.inner2_smul_l,
    HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  split_ifs <;> grind

/-- **The coordinate-diagonal Weyl locus**: for `K` symmetric and hollow, `W_K` is Weyl exactly when every
row of `K` sums to zero. -/
theorem WD_weyl_iff (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a) (hh : ∀ a, K a a = 0) :
    IsWeyl (WD K) ↔ ∀ a, ∑ b, K a b = 0 := by
  constructor
  · intro hW a
    have h := hW.2.2.2 a a
    rw [ric_WD K hs hh, if_pos rfl] at h
    exact h
  · intro hrow
    refine ⟨fun X _ => WD_skew K X, fun X Y _ _ => ?_, fun i j k l => bianchi_WD K hs i j k l,
      fun a b => ?_⟩
    · rw [WD_inner, inner2_comm X, WD_inner]
      refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
      rw [inner2_comm (phi a b) Y, inner2_comm X (phi a b)]; ring
    · rw [ric_WD K hs hh]
      split_ifs with h
      · exact hrow a
      · rfl

/-- The ordered pairs `a < b`, indexing the orthonormal basis `{φ_{ab}}_{a<b}` of `Λ²ℝⁿ`. -/
abbrev Pr (n : ℕ) := {p : Fin n × Fin n // p.1 < p.2}

/-- The matrix of `W_K` on the basis `{φ_{ab}}_{a<b}`. -/
noncomputable def coeffD (K : Matrix (Fin n) (Fin n) ℝ) : Matrix (Pr n) (Pr n) ℝ :=
  fun p q => inner2 (WD K (phi p.1.1 p.1.2)) (phi q.1.1 q.1.2)

/-- **The matrix of `W_K` is diagonal with entries `K_{ab}`.** -/
theorem coeffD_eq (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a) :
    coeffD K = Matrix.diagonal (fun p : Pr n => K p.1.1 p.1.2) := by
  ext p q
  simp only [coeffD, WD_phi K hs, HamiltonsCubic.L41Statement.Frame.inner2_smul_l,
    HamiltonsCubic.FamilyLayer.inner2_phi_phi, Matrix.diagonal_apply]
  have hp := p.2; have hq := q.2
  by_cases hpq : p = q
  · subst hpq
    have : ¬ ((p.1.2 = p.1.1) ∧ (p.1.1 = p.1.2)) := fun h => absurd hp (by rw [h.2]; exact lt_irrefl _)
    simp [this]
  · have h1 : ¬ (p.1.1 = q.1.1 ∧ p.1.2 = q.1.2) := fun h => hpq (Subtype.ext (Prod.ext h.1 h.2))
    have h2 : ¬ (p.1.2 = q.1.1 ∧ p.1.1 = q.1.2) := fun h => by
      have := Fin.lt_def.mp hp; have := Fin.lt_def.mp hq
      rw [h.1, h.2] at *; omega
    simp [h1, h2, hpq]

/-- **The `Λ²`-rank of `W_K` is the number of edges** of `K`'s support graph. -/
theorem rank_coeffD (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a) :
    (coeffD K).rank = (edges K).card := by
  classical
  rw [coeffD_eq K hs, Matrix.rank_diagonal, edges]
  rw [Fintype.card_subtype]
  refine Finset.card_bij (fun p _ => p.1) (fun p hp => ?_) (fun p _ q _ h => Subtype.ext h) (fun q hq => ?_)
  · simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
    exact ⟨p.2, hp⟩
  · simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hq
    exact ⟨⟨q, hq.1⟩, by simp [hq.2], rfl⟩

/-- **L176 for the operator**: a nonzero Weyl operator diagonal in the coordinate frame, `W_K` with `K`
symmetric and hollow, has `Λ²`-rank at least four. -/
theorem L176_op (K : Matrix (Fin n) (Fin n) ℝ) (hs : ∀ a b, K a b = K b a) (hh : ∀ a, K a a = 0)
    (hW : IsWeyl (WD K)) (h0 : K ≠ 0) : 4 ≤ (coeffD K).rank := by
  rw [rank_coeffD K hs]
  exact four_le_card_edges K ⟨hs, hh, (WD_weyl_iff K hs hh).mp hW⟩ h0

end HamiltonsCubic.L176
