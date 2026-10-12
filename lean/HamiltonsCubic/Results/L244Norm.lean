import Mathlib
import HamiltonsCubic.Results.L244Unit
import HamiltonsCubic.Base.BivModel

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L244 (ii): `a = 1/√(2p)` from tracelessness and the unit norm

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 (ii) works on the symmetric family `λ = (−a, 0, a)` with
multiplicities `(p, N − 2p, p)` and `a = 1/√(2p)`. [L244Sym.lean](L244Sym.lean) and [L244Unit.lean](L244Unit.lean) hold at any class
sizes and any `a > 0` ([r1856](../../../reviews/REVIEW_r1856.md) O1, O6). Here the two facts that fix `a` are derived from the
operator, at the spectral frame of [L244Frame.lean](L244Frame.lean):

* `parseval2`, polarised Parseval at a complete family;
* **`trace_indep`**, **`sq_indep`**: `∑_k ⟨W ψ_k, ψ_k⟩` and `∑_k ⟨W ψ_k, W ψ_k⟩` are the same at any two complete skew families, `W`
  being symmetric on bivectors;
* **`trace_zero`**: `∑_k λ_k = 0`, the coordinate side being `½ ∑_i Ric_ii = 0`;
* **`normSq_eq`**: `‖W‖² = ∑_k λ_k²`, the coordinate side being `innerOp W W`;
* **`L244_mult`**: at a labelling of values `(−a, 0, a)`, `a ≠ 0`, the classes `0` and `2` have one size `p`, and `‖W‖² = 2pa²`;
* **`L244_a`**: at `‖W‖² = 1` and `a > 0`, `a = 1/√(2p)`;
* **`exists_cls`**: the labelling by classes, constructed from a spectrum in `{−a, 0, a}` ([r1881](../../../reviews/REVIEW_r1881.md) O2).
-/

namespace HamiltonsCubic.L244Norm

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244RowBMass HamiltonsCubic.L244Frame

variable {n : ℕ}

/-- **Polarised Parseval** at a family that expands every skew matrix. -/
theorem parseval2 {ι K : Type*} [Fintype ι] [DecidableEq ι] [Fintype K] (φ : K → Matrix ι ι ℝ)
    (hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (A B : Matrix ι ι ℝ) (hB : IsSkew B) :
    inner2 A B = ∑ k, inner2 (φ k) A * inner2 (φ k) B := by
  have e : ∀ X Y : Matrix ι ι ℝ, inner2 X Y = KyFanPackaging.inner2Form X Y := fun X Y =>
    (KyFanPackaging.inner2Form_apply X Y).symm
  rw [e A B]
  conv_lhs => rw [hexp B hB]
  rw [map_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [map_smul, smul_eq_mul, ← e, inner2_comm A, mul_comm]

variable {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ}

/-- **The trace is basis independent** over complete skew families. -/
theorem trace_indep (hW : IsWeylOp W) {K K' : Type*} [Fintype K] [Fintype K']
    (ψ : K → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (φ : K' → Matrix (Fin n) (Fin n) ℝ) (hφS : ∀ k, IsSkew (φ k)) (hφ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) :
    ∑ k, inner2 (W (ψ k)) (ψ k) = ∑ d, inner2 (W (φ d)) (φ d) := by
  calc ∑ k, inner2 (W (ψ k)) (ψ k)
      = ∑ k, ∑ d, inner2 (φ d) (W (ψ k)) * inner2 (φ d) (ψ k) :=
        Finset.sum_congr rfl fun k _ => parseval2 φ hφ _ _ (hψS k)
    _ = ∑ d, ∑ k, inner2 (ψ k) (W (φ d)) * inner2 (ψ k) (φ d) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun k _ => ?_
        rw [← hW.2.2.1 (φ d) (ψ k) (hφS d) (hψS k), inner2_comm (W (φ d)), inner2_comm (φ d) (ψ k)]
    _ = _ := Finset.sum_congr rfl fun d _ => (parseval2 ψ hψ _ _ (hφS d)).symm

/-- **The squared norm is basis independent** over complete skew families. -/
theorem sq_indep (hW : IsWeylOp W) {K K' : Type*} [Fintype K] [Fintype K']
    (ψ : K → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (φ : K' → Matrix (Fin n) (Fin n) ℝ) (hφS : ∀ k, IsSkew (φ k)) (hφ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) :
    ∑ k, inner2 (W (ψ k)) (W (ψ k)) = ∑ d, inner2 (W (φ d)) (W (φ d)) := by
  calc ∑ k, inner2 (W (ψ k)) (W (ψ k))
      = ∑ k, ∑ d, inner2 (φ d) (W (ψ k)) * inner2 (φ d) (W (ψ k)) :=
        Finset.sum_congr rfl fun k _ => parseval2 φ hφ _ _ (hW.2.1 _ (hψS k))
    _ = ∑ d, ∑ k, inner2 (ψ k) (W (φ d)) * inner2 (ψ k) (W (φ d)) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun k _ => ?_
        rw [← hW.2.2.1 (φ d) (ψ k) (hφS d) (hψS k), inner2_comm (W (φ d))]
    _ = _ := Finset.sum_congr rfl fun d _ => (parseval2 ψ hψ _ _ (hW.2.1 _ (hφS d))).symm

/-- `W φ_{ji} = −W φ_{ij}` and `W φ_{ii} = 0`. -/
theorem W_phi_swap (hW : IsWeylOp W) (i j : Fin n) : W (phi j i) = -W (phi i j) := by
  rw [phi_swap, ← neg_one_smul ℝ (phi i j), hW.1.2, neg_one_smul]

theorem W_phi_self (hW : IsWeylOp W) (i : Fin n) : W (phi i i) = 0 := by
  have h := W_phi_swap hW i i
  ext a b
  have := congrFun (congrFun h a) b
  simp only [Matrix.neg_apply, Matrix.zero_apply] at this ⊢
  linarith

/-- The coordinate family `φ_{ij}`, `i < j`. -/
noncomputable abbrev coordFam (n : ℕ) : HamiltonsCubic.BivModel.Pairs n → Matrix (Fin n) (Fin n) ℝ := fun p => phi p.1.1 p.1.2

theorem coordFam_skew (p : HamiltonsCubic.BivModel.Pairs n) : IsSkew (coordFam n p) := phi_isSkew _ _

theorem coordFam_complete (Y : Matrix (Fin n) (Fin n) ℝ) (hY : IsSkew Y) :
    Y = ∑ p, inner2 (coordFam n p) Y • coordFam n p := L240SlotBasis.phi_expand_ordered Y hY

/-- **The trace vanishes**: `∑_k λ_k = 0` over the spectral frame. -/
theorem trace_zero (hW : IsWeylOp W) : ∑ k, evf W hW k = 0 := by
  have h1 : ∑ k, evf W hW k = ∑ k, inner2 (W (ψf W hW k)) (ψf W hW k) := by
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [ψf_eigen W hW k, HamiltonsCubic.RealLayer.inner2_smul_left, HamiltonsCubic.L244Unit.ψf_orth hW k k, if_pos rfl, mul_one]
  rw [h1, trace_indep hW _ (ψf_skew W hW) (ψf_complete W hW) (coordFam n) coordFam_skew coordFam_complete]
  have hp := HamiltonsCubic.BivModel.sum_pairs (f := fun i j => inner2 (W (phi i j)) (phi i j))
    (fun i => by simp only [W_phi_self hW]; unfold inner2; simp)
    (fun i j => by
      rw [W_phi_swap hW i j, phi_swap i j]
      unfold inner2; simp [Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg])
  have hric : ∑ i, ∑ j, inner2 (W (phi i j)) (phi i j) = 0 := by
    have : ∀ i, ∑ j, inner2 (W (phi i j)) (phi i j) = Ric W i i := fun i => rfl
    rw [Finset.sum_congr rfl fun i _ => this i]
    simp only [hW.2.2.2.2, Finset.sum_const_zero]
  simp only [coordFam]
  linarith

/-- **The squared norm is the sum of squared eigenvalues.** -/
theorem normSq_eq (hW : IsWeylOp W) : normSq W = ∑ k, evf W hW k ^ 2 := by
  have h1 : ∑ k, evf W hW k ^ 2 = ∑ k, inner2 (W (ψf W hW k)) (W (ψf W hW k)) := by
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [ψf_eigen W hW k, HamiltonsCubic.RealLayer.inner2_smul_left, HamiltonsCubic.L244Unit.i_smul_r, HamiltonsCubic.L244Unit.ψf_orth hW k k,
      if_pos rfl]
    ring
  rw [h1, sq_indep hW _ (ψf_skew W hW) (ψf_complete W hW) (coordFam n) coordFam_skew coordFam_complete]
  have hp := HamiltonsCubic.BivModel.sum_pairs (f := fun i j => inner2 (W (phi i j)) (W (phi i j)))
    (fun i => by simp only [W_phi_self hW]; unfold inner2; simp)
    (fun i j => by
      rw [W_phi_swap hW i j]
      unfold inner2; simp [Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg])
  unfold normSq innerOp
  simp only [coordFam]
  rw [hp]; ring

/-- A sum through a labelling is a sum over the classes, weighted by their sizes. -/
theorem sum_cls {r K : ℕ} (cls : Fin r → Fin K) (g : Fin K → ℝ) :
    ∑ k, g (cls k) = ∑ c, (Fintype.card {γ // cls γ = c} : ℝ) * g c := by
  rw [← Finset.sum_fiberwise_of_maps_to (g := cls) (fun _ _ => Finset.mem_univ _)]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_congr rfl fun k hk => by rw [(Finset.mem_filter.mp hk).2], Finset.sum_const, nsmul_eq_mul,
    Fintype.card_subtype]

/-- **The multiplicities of `±a` agree, and `‖W‖² = 2pa²`.** -/
theorem L244_mult (hW : IsWeylOp W) {a : ℝ} (ha : a ≠ 0) (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k)) :
    Fintype.card {γ // cls γ = 0} = Fintype.card {γ // cls γ = 2} ∧
      normSq W = 2 * Fintype.card {γ // cls γ = 0} * a ^ 2 := by
  have ht := trace_zero hW
  have hn := normSq_eq hW
  simp only [hcls] at ht hn
  rw [sum_cls cls (fun c => (![-a, 0, a] : Fin 3 → ℝ) c)] at ht
  rw [sum_cls cls (fun c => (![-a, 0, a] : Fin 3 → ℝ) c ^ 2)] at hn
  simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.head_cons, Matrix.tail_cons] at ht hn
  have heq : (Fintype.card {γ // cls γ = 0} : ℝ) = Fintype.card {γ // cls γ = 2} := by
    have : a * ((Fintype.card {γ // cls γ = 2} : ℝ) - Fintype.card {γ // cls γ = 0}) = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · exact absurd h ha
    · linarith
  refine ⟨by exact_mod_cast heq, ?_⟩
  rw [hn, ← heq]; ring

/-- **`a = 1/√(2p)`** at `‖W‖² = 1` and `a > 0`, `p` the size of the negative class. -/
theorem L244_a (hW : IsWeylOp W) {a : ℝ} (ha : 0 < a) (hnorm : normSq W = 1) (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k)) :
    a = 1 / Real.sqrt (2 * Fintype.card {γ // cls γ = 0}) := by
  obtain ⟨-, hn⟩ := L244_mult hW ha.ne' cls hcls
  rw [hnorm] at hn
  set p : ℝ := (Fintype.card {γ // cls γ = 0} : ℝ) with hpdef
  have hp : 0 < 2 * p := by
    by_contra h
    have h := le_of_not_gt h
    nlinarith [sq_nonneg a]
  have hs : Real.sqrt (2 * p) = 1 / a := by
    rw [Real.sqrt_eq_iff_mul_self_eq_of_pos (by positivity)]
    field_simp
    linarith
  rw [hs, one_div_one_div]

/-- **The labelling from the spectrum** (r1881 O2): when every eigenvalue is one of `−a, 0, a`, `a ≠ 0`, the class of a frame vector is
read off its eigenvalue, so `cls` is constructed rather than quantified. -/
theorem exists_cls (hW : IsWeylOp W) {a : ℝ} (ha : a ≠ 0)
    (hspec : ∀ k, evf W hW k = -a ∨ evf W hW k = 0 ∨ evf W hW k = a) :
    ∃ cls : Fin (Fintype.card (Pairs n)) → Fin 3, ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k) := by
  refine ⟨fun k => if evf W hW k = -a then 0 else if evf W hW k = 0 then 1 else 2, fun k => ?_⟩
  have h1 : a ≠ -a := fun h => ha (by linarith)
  have h2 : (0 : ℝ) ≠ -a := fun h => ha (by linarith)
  rcases hspec k with h | h | h
  · simp only [h, if_pos rfl]; rfl
  · simp only [h, if_neg h2, if_pos rfl]; rfl
  · simp only [h, if_neg h1, if_neg ha]; rfl

end HamiltonsCubic.L244Norm
