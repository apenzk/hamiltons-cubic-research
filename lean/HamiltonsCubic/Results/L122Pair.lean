import HamiltonsCubic.Results.L122Block
import HamiltonsCubic.Results.L126Orbit
import HamiltonsCubic.Base.FoxBilinear

set_option linter.style.longLine false

/-!
# L122's pair block: the Gram matrix, the Ricci cut, and invariance

[findings/second-order.md](../../../findings/second-order.md), Lemma L122, and [r1606](../../../reviews/REVIEW_r1606.md)'s
owed items, in the basis `f_i = φ_ji ⊙ φ_ki` of [L122Block.lean](L122Block.lean):

* **`pair_gram`**: `⟨f_i, f_i'⟩ = 2 δ_ii'` for `i, i' ∉ {j, k}`, so the `f_i` are orthogonal with common norm `√2`;
* **`pair_ric`**: the Ricci contraction of `∑ c_i f_i` is `∑ c_i` at `(j,k)` and at `(k,j)` and zero elsewhere, so
  the Ricci cut on the block is `∑ c_i = 0`, the record's *"exactly `∑_i x_i = 0`"*;
* **`foxProd_sum_right`**, **`pair_invariant`**: `∘` is linear over finite sums in its second slot, so the span of
  the `f_i` is carried into itself by `M ∘`, with `pairBlock` giving the images.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

open HamiltonsCubic.FamilyLayer in
/-- **The Gram matrix of the pair basis**: `⟨f_i, f_i'⟩ = 2 δ_ii'`. -/
theorem pair_gram {j k i i' : ι} (hjk : j ≠ k) (hji : j ≠ i) (hki : k ≠ i) (hji' : j ≠ i') (hki' : k ≠ i') :
    innerOp (rk2 (phi j i) (phi k i)) (rk2 (phi j i') (phi k i')) = if i = i' then 2 else 0 := by
  rw [innerOp_rk2 _ (isLinOp_rk2 _ _) (phi_isSkew j i') (phi_isSkew k i')]
  unfold rk2
  simp only [ip_add_l, ip_smul_l, inner2_phi_phi]
  by_cases h : i = i'
  · subst h; simp [hjk, hji, hki, hjk.symm, hji.symm, hki.symm]; norm_num
  · simp [h, hjk, hjk.symm, hji.symm, hki.symm, hji', hki']

open HamiltonsCubic.FamilyLayer in
/-- The Ricci contraction of one pair-basis operator: `1` at `(k,j)` and at `(j,k)`. -/
theorem ric_pairBasis {j k i : ι} (hjk : j ≠ k) (hji : j ≠ i) (hki : k ≠ i) (a b : ι) :
    Ric (rk2 (phi j i) (phi k i)) a b = (if k = a ∧ j = b then 1 else 0) + (if j = a ∧ k = b then 1 else 0) := by
  unfold Ric rk2
  simp only [ip_add_l, ip_smul_l, inner2_phi_phi, Finset.sum_add_distrib]
  simp only [mul_sub, ite_and, mul_ite, mul_one, mul_zero, Finset.sum_sub_distrib]
  by_cases h1 : k = a <;> by_cases h2 : j = b <;> by_cases h3 : j = a <;> by_cases h4 : k = b <;>
    by_cases h5 : i = a <;> by_cases h6 : i = b <;>
    simp_all <;> (try (intro h; subst h; simp_all))

/-- **The Ricci cut on the pair block**: the Ricci contraction of `∑_{i∈s} c_i f_i`, `s` avoiding `j` and `k`, is
`∑ c_i` at `(k,j)` and at `(j,k)` and zero elsewhere. So `∑ c_i f_i` is Ricci-flat exactly when `∑ c_i = 0`. -/
theorem pair_ric {j k : ι} (hjk : j ≠ k) (s : Finset ι) (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) (a b : ι) :
    Ric (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) a b
      = (∑ i ∈ s, c i) * ((if k = a ∧ j = b then 1 else 0) + (if j = a ∧ k = b then 1 else 0)) := by
  have lin : Ric (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) a b
      = ∑ i ∈ s, c i * Ric (rk2 (phi j i) (phi k i)) a b := by
    unfold Ric
    simp only [ip_sum_l, ip_smul_l]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]
  rw [lin, Finset.sum_mul]
  exact Finset.sum_congr rfl fun i hi => by rw [ric_pairBasis hjk (hs i hi).1 (hs i hi).2]

theorem pair_ricciFlat_iff {j k : ι} (hjk : j ≠ k) (s : Finset ι) (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) :
    (∀ a b, Ric (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) a b = 0) ↔ ∑ i ∈ s, c i = 0 := by
  constructor
  · intro h
    have := h k j
    rw [pair_ric hjk s hs] at this
    simpa [hjk, hjk.symm] using this
  · intro h a b
    rw [pair_ric hjk s hs, h, zero_mul]

/-- **`∘` is linear over finite sums in its second slot**, at linear arguments. -/
theorem foxProd_sum_right (e : CurvOp ι) (he : IsLinOp e) {κ : Type*} (s : Finset κ) (c : κ → ℝ) (F : κ → CurvOp ι)
    (hF : ∀ x, IsLinOp (F x)) (X : Matrix ι ι ℝ) :
    foxProd e (fun Y => ∑ x ∈ s, c x • F x Y) X = ∑ x ∈ s, c x • foxProd e (F x) X := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.sum_empty]
    exact congrFun (foxProd_zero_right e) X
  | insert a s ha ih =>
    have hS : IsLinOp (fun Y => ∑ x ∈ s, c x • F x Y) :=
      ⟨fun P Q => by simp only [(hF _).1, smul_add, Finset.sum_add_distrib],
       fun d P => by simp only [(hF _).2, Finset.smul_sum, smul_comm d]⟩
    have hA : IsLinOp (fun Y => c a • F a Y) :=
      ⟨fun P Q => by simp only [(hF a).1, smul_add], fun d P => by simp only [(hF a).2, smul_comm d]⟩
    have e1 : (fun Y => ∑ x ∈ insert a s, c x • F x Y) = fun Y => c a • F a Y + ∑ x ∈ s, c x • F x Y := by
      funext Y; rw [Finset.sum_insert ha]
    rw [e1, foxProd_add_right e _ _ he hA hS, foxProd_smul_right _ e _ he (hF a), ih, Finset.sum_insert ha]

open HamiltonsCubic.FamilyLayer in
/-- **THE PAIR SPAN IS INVARIANT**: at a symmetric hollow weight, `M ∘ ∑_{i∈s} c_i f_i` is a combination of the
`f_q`, namely `∑_{i∈s} c_i · ½((w_ji + w_ki − w_jk) f_i + ∑_q w_iq f_q)`, on every bivector. -/
theorem pair_invariant (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {j k : ι} (hjk : j ≠ k)
    (s : Finset ι) (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    foxProd (diagOp w) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) X
      = ∑ i ∈ s, c i • ((1 / 2 : ℝ) • ((w j i + w k i - w j k) • rk2 (phi j i) (phi k i) X
          + ∑ q, w i q • rk2 (phi j q) (phi k q) X)) := by
  rw [foxProd_sum_right _ (isLinOp_diagOp w) s c _ (fun _ => isLinOp_rk2 _ _)]
  exact Finset.sum_congr rfl fun i hi => by rw [pairBlock w hw hh hjk (hs i hi).1 (hs i hi).2 hX]

end HamiltonsCubic.L121Block
