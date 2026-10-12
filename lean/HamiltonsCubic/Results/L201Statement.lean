import HamiltonsCubic.Results.PencilProjections

/-!
# Lemma L201, integrality of the pairwise plane traces forces a common frame

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I36 section. A `W` carrying an
orthonormal eigenbasis of decomposable forms is described by its planes `P_a`, and the record's
$\Theta$ identity gives $\sum_a \Pi_{P_a}=(n-1)\mathrm{Id}$. This file types the two exact
identities that come out of that, and the theorem they feed.

`sum_trace_off` is the per-index identity: at every `a`, the off-diagonal traces against `a` sum to
`2(n-2)`, under no hypothesis beyond completeness and each `P a` being a rank-two projection.

`sum_sq_le_sum` and `sum_sq_eq_sum_iff` are the scalar half of the extremal characterisation: with
every trace in `[0,1]`, the sum of squares is at most the sum, with equality exactly at
integrality.

`integrality_forces_frame` is the theorem, proved from two halves, `commuting_of_integral` and `frame_of_commuting`, both proved. The file carries no `sorry`. Its conclusion is a common
orthonormal frame carrying every plane as a coordinate plane, which is coordinate-diagonality.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Matrix

variable {n N : ℕ}

/-- **The per-index identity.** With `∑ a, P a = (n-1) • 1` and each `P a` an idempotent of trace
two, the traces of `P a * P b` over `b ≠ a` sum to `2(n-2)`, so under integrality every index has
exactly `2(n-2)` neighbours. -/
theorem sum_trace_off (P : Fin N → Matrix (Fin n) (Fin n) ℝ)
    (hidem : ∀ a, P a * P a = P a) (htr : ∀ a, (P a).trace = 2)
    (hsum : ∑ a, P a = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ)) (a : Fin N) :
    ∑ b ∈ Finset.univ.erase a, (P a * P b).trace = 2 * ((n : ℝ) - 2) := by
  have hall : ∑ b, (P a * P b).trace = 2 * ((n : ℝ) - 1) := by
    calc ∑ b, (P a * P b).trace = (∑ b, P a * P b).trace := (Matrix.trace_sum _ _).symm
      _ = (P a * ∑ b, P b).trace := by rw [Finset.mul_sum]
      _ = (P a * (((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ))).trace := by rw [hsum]
      _ = 2 * ((n : ℝ) - 1) := by
          rw [Matrix.mul_smul, Matrix.mul_one, Matrix.trace_smul, htr a, smul_eq_mul]; ring
  have hsplit : (P a * P a).trace + ∑ b ∈ Finset.univ.erase a, (P a * P b).trace
      = ∑ b, (P a * P b).trace :=
    Finset.add_sum_erase Finset.univ (fun b => (P a * P b).trace) (Finset.mem_univ a)
  rw [hidem a, htr a, hall] at hsplit
  linarith

/-- **The sum of squares is at most the sum** when every value lies in `[0,1]`. -/
theorem sum_sq_le_sum {s : Finset (Fin N)} (t : Fin N → ℝ)
    (h : ∀ b ∈ s, 0 ≤ t b ∧ t b ≤ 1) : ∑ b ∈ s, t b ^ 2 ≤ ∑ b ∈ s, t b :=
  Finset.sum_le_sum fun b hb => by nlinarith [(h b hb).1, (h b hb).2]

/-- **And equality holds exactly at integrality**, which is what makes the extremal case a
characterisation rather than a bound. -/
theorem sum_sq_eq_sum_iff {s : Finset (Fin N)} (t : Fin N → ℝ)
    (h : ∀ b ∈ s, 0 ≤ t b ∧ t b ≤ 1) :
    ∑ b ∈ s, t b ^ 2 = ∑ b ∈ s, t b ↔ ∀ b ∈ s, t b = 0 ∨ t b = 1 := by
  rw [Finset.sum_eq_sum_iff_of_le fun b hb => by nlinarith [(h b hb).1, (h b hb).2]]
  refine ⟨fun hb b hbs => ?_, fun hb b hbs => ?_⟩
  · have := hb b hbs
    have hz : t b * (t b - 1) = 0 := by nlinarith [this]
    rcases mul_eq_zero.mp hz with h0 | h1
    · exact Or.inl h0
    · exact Or.inr (by linarith)
  · rcases hb b hbs with h0 | h1
    · rw [h0]; ring
    · rw [h1]; ring

/-! ## The commutator norm in the cross Gram matrix

*With `M` the `2 × 2` matrix of dot products between the two planes' orthonormal bases and
`S = ‖M‖²`, the commutator of the two projections has `‖[P,Q]‖² = 2S - 2S² + 4 det(M)²`, read off
its eight rank-one terms by `frob_sq`.* -/

namespace L201Proof

/-- The dot product, written as the sums the statement uses. -/
def d (x y : Fin n → ℝ) : ℝ := ∑ r, x r * y r

theorem d_comm (x y : Fin n → ℝ) : d x y = d y x := by
  unfold d; exact Finset.sum_congr rfl fun r _ => mul_comm _ _

theorem PQ_apply (x y x' y' : Fin n → ℝ) (p q : Fin n) :
    (planeProj x y * planeProj x' y') p q
      = d x x' * x p * x' q + d x y' * x p * y' q + d y x' * y p * x' q + d y y' * y p * y' q := by
  simp only [planeProj, outer, Matrix.mul_apply, Matrix.add_apply, Matrix.of_apply, d,
    Finset.sum_mul, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun r _ => by ring

theorem reorder {α β : Type*} [Fintype α] [Fintype β] (F : α → α → β → β → ℝ) :
    ∑ p, ∑ q, ∑ k, ∑ l, F p q k l = ∑ k, ∑ l, ∑ p, ∑ q, F p q k l := by
  calc ∑ p, ∑ q, ∑ k, ∑ l, F p q k l = ∑ p, ∑ k, ∑ q, ∑ l, F p q k l :=
        Finset.sum_congr rfl fun p _ => Finset.sum_comm
    _ = ∑ p, ∑ k, ∑ l, ∑ q, F p q k l :=
        Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k, ∑ p, ∑ l, ∑ q, F p q k l := Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ p, ∑ q, F p q k l := Finset.sum_congr rfl fun k _ => Finset.sum_comm

theorem frob_sq (α : Fin 8 → ℝ) (X Y : Fin 8 → Fin n → ℝ) :
    ∑ p, ∑ q, (∑ k, α k * X k p * Y k q) ^ 2
      = ∑ k, ∑ l, α k * α l * d (X k) (X l) * d (Y k) (Y l) := by
  have hL : ∑ p, ∑ q, (∑ k, α k * X k p * Y k q) ^ 2
      = ∑ p, ∑ q, ∑ k, ∑ l, α k * X k p * Y k q * (α l * X l p * Y l q) :=
    Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => by rw [sq, Finset.sum_mul_sum]
  rw [hL, reorder (fun p q k l => α k * X k p * Y k q * (α l * X l p * Y l q))]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  unfold d
  simp only [Finset.mul_sum, Finset.sum_mul]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => by ring

end L201Proof

open L201Proof in
/-- **The geometric half of L201, PROVED.** Integrality of the pairwise plane traces is
commutativity of the projections. With `M` the cross Gram matrix of the two planes,
`‖[Π_α,Π_β]‖² = 2S - 2S² + 4 det(M)²` where `S = tr(Π_α Π_β) = ‖M‖²`; `horth` is `det M = 0`
and integrality is `S(1 - S) = 0`, so the commutator vanishes. *This replaces the
principal-angle normal form an earlier docstring named as the missing input: the identity is
polynomial in the four cross dot products and needs no normal form.* The factor is also
machine-checked at an instance by `frobSq_commutator_inst` above. -/
theorem commuting_of_integral (u v : Fin N → (Fin n → ℝ))
    (hu : ∀ a, ∑ p, u a p * u a p = 1) (hv : ∀ a, ∑ p, v a p * v a p = 1)
    (huv : ∀ a, ∑ p, u a p * v a p = 0)
    (horth : ∀ a b, a ≠ b →
      (∑ p, u a p * u b p) * (∑ p, v a p * v b p)
        - (∑ p, u a p * v b p) * (∑ p, v a p * u b p) = 0)
    (hint : ∀ a b, a ≠ b →
      (planeProj (u a) (v a) * planeProj (u b) (v b)).trace = 0 ∨
      (planeProj (u a) (v a) * planeProj (u b) (v b)).trace = 1) (a b : Fin N) :
    planeProj (u a) (v a) * planeProj (u b) (v b)
      = planeProj (u b) (v b) * planeProj (u a) (v a) := by
  by_cases hab : a = b
  · rw [hab]
  set x := u a; set y := v a; set x' := u b; set y' := v b
  have hxx : d x x = 1 := hu a
  have hyy : d y y = 1 := hv a
  have hxy : d x y = 0 := huv a
  have hyx : d y x = 0 := by rw [d_comm]; exact hxy
  have hx'x' : d x' x' = 1 := hu b
  have hy'y' : d y' y' = 1 := hv b
  have hx'y' : d x' y' = 0 := huv b
  have hy'x' : d y' x' = 0 := by rw [d_comm]; exact hx'y'
  have c1 : d x' x = d x x' := d_comm _ _
  have c2 : d x' y = d y x' := d_comm _ _
  have c3 : d y' x = d x y' := d_comm _ _
  have c4 : d y' y = d y y' := d_comm _ _
  have hdet : d x x' * d y y' - d x y' * d y x' = 0 := horth a b hab
  have htr : (planeProj x y * planeProj x' y').trace
      = d x x' ^ 2 + d x y' ^ 2 + d y x' ^ 2 + d y y' ^ 2 := by
    simp only [Matrix.trace, Matrix.diag, PQ_apply, Finset.sum_add_distrib]
    simp only [mul_assoc, ← Finset.mul_sum]
    unfold d; ring
  have hS : (d x x' ^ 2 + d x y' ^ 2 + d y x' ^ 2 + d y y' ^ 2)
      * (1 - (d x x' ^ 2 + d x y' ^ 2 + d y x' ^ 2 + d y y' ^ 2)) = 0 := by
    rw [← htr]; rcases hint a b hab with h | h <;> rw [h] <;> ring
  let α : Fin 8 → ℝ := ![d x x', d x y', d y x', d y y', -d x' x, -d x' y, -d y' x, -d y' y]
  let X : Fin 8 → Fin n → ℝ := ![x, x, y, y, x', x', y', y']
  let Y : Fin 8 → Fin n → ℝ := ![x', y', x', y', x, y, x, y]
  have hC : ∀ p q, (planeProj x y * planeProj x' y' - planeProj x' y' * planeProj x y) p q
      = ∑ k, α k * X k p * Y k q := by
    intro p q
    simp only [Matrix.sub_apply, PQ_apply, Fin.sum_univ_eight, α, X, Y, Matrix.cons_val_zero,
      Matrix.cons_val_one, Matrix.cons_val]
    ring
  have hF : ∑ p, ∑ q, ((planeProj x y * planeProj x' y' - planeProj x' y' * planeProj x y) p q) ^ 2
      = 0 := by
    simp only [hC]
    rw [frob_sq]
    simp only [Fin.sum_univ_eight, α, X, Y, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val]
    rw [c1, c2, c3, c4]
    simp only [hxx, hyy, hxy, hyx, hx'x', hy'y', hx'y', hy'x']
    linear_combination 2 * hS + 4 * (d x x' * d y y' - d x y' * d y x') * hdet
  have hz : ∀ p q, (planeProj x y * planeProj x' y' - planeProj x' y' * planeProj x y) p q = 0 := by
    intro p q
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun p _ => Finset.sum_nonneg fun q _ => sq_nonneg _)).mp
      hF p (Finset.mem_univ p)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun q _ => sq_nonneg _)).mp h1 q (Finset.mem_univ q)
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h2
  ext p q
  exact sub_eq_zero.mp (by simpa [Matrix.sub_apply] using hz p q)


/-! ## A common eigenframe for commuting symmetric idempotents

*Mathlib's joint eigenspace decomposition, `directSum_isInternal_of_pairwise_commute`, is indexed
by every eigenvalue function `Fin N → ℝ`, and its adapted orthonormal basis needs a finite index.
Idempotence confines every eigenvalue to `{0, 1}`, so the family re-indexed by `Fin N → Bool` is
still internal, and `subordinateOrthonormalBasis` applies to it.* -/

namespace L201Frame

open WithLp

set_option maxHeartbeats 1000000 in
/-- **A common orthonormal eigenframe** for a commuting family of symmetric idempotents. -/
theorem joint_frame (P : Fin N → Matrix (Fin n) (Fin n) ℝ) (hsym : ∀ a, (P a)ᵀ = P a)
    (hidem : ∀ a, P a * P a = P a) (hcomm : ∀ a b, P a * P b = P b * P a) :
    ∃ (f : Fin n → Fin n → ℝ) (μ : Fin n → Fin N → ℝ),
      (∀ p q, ∑ r, f p r * f q r = if p = q then 1 else 0) ∧
      (∀ k a, P a *ᵥ f k = μ k a • f k) := by
  classical
  let T : Fin N → Module.End ℝ (EuclideanSpace ℝ (Fin n)) := fun a => Matrix.toEuclideanLin (P a)
  have happ : ∀ a (x : EuclideanSpace ℝ (Fin n)), ofLp (T a x) = P a *ᵥ ofLp x := fun _ _ => rfl
  have hT : ∀ a, (T a).IsSymmetric := fun a => Matrix.isSymmetric_toEuclideanLin_iff.mpr (by
    unfold Matrix.IsHermitian; rw [Matrix.conjTranspose_eq_transpose_of_trivial]; exact hsym a)
  have hC : Pairwise (fun a b => Commute (T a) (T b)) := fun a b _ => by
    show T a * T b = T b * T a
    apply LinearMap.ext; intro x
    apply ofLp_injective 2
    show ofLp (T a (T b x)) = ofLp (T b (T a x))
    rw [happ, happ, happ, happ, Matrix.mulVec_mulVec, Matrix.mulVec_mulVec, hcomm a b]
  have hTT : ∀ a x, T a (T a x) = T a x := fun a x => by
    apply ofLp_injective 2
    simp only [happ, Matrix.mulVec_mulVec, hidem]
  have heig_bot : ∀ a (μ : ℝ), μ ≠ 0 → μ ≠ 1 → Module.End.eigenspace (T a) μ = ⊥ := by
    intro a μ h0 h1
    rw [eq_bot_iff]; intro x hx
    rw [Module.End.mem_eigenspace_iff] at hx
    have h := hTT a x
    rw [hx, map_smul, hx, smul_smul] at h
    have h2 : (μ * μ - μ) • x = 0 := by rw [sub_smul, h, sub_self]
    have h3 : μ * μ - μ ≠ 0 := by
      intro h4; have : μ * (μ - 1) = 0 := by linarith
      rcases mul_eq_zero.mp this with h5 | h5
      · exact h0 h5
      · exact h1 (by linarith)
    exact (smul_eq_zero.mp h2).resolve_left h3
  let γB : (Fin N → Bool) → (Fin N → ℝ) := fun s j => if s j then 1 else 0
  have hinj : Function.Injective γB := by
    intro s t hst; funext j
    have := congrFun hst j
    simp only [γB] at this
    cases hs : s j <;> cases ht : t j <;> simp_all
  let V : (Fin N → Bool) → Submodule ℝ (EuclideanSpace ℝ (Fin n)) :=
    fun s => ⨅ j, Module.End.eigenspace (T j) (γB s j)
  have hV' : OrthogonalFamily ℝ (fun s => V s) fun s => (V s).subtypeₗᵢ :=
    (LinearMap.IsSymmetric.orthogonalFamily_iInf_eigenspaces hT).comp hinj
  have hV : DirectSum.IsInternal V := by
    rw [hV'.isInternal_iff]
    have htop := LinearMap.IsSymmetric.iSup_iInf_eq_top_of_commute hT hC
    suffices h : (⨆ s, V s) = ⊤ by rw [h, Submodule.top_orthogonal_eq_bot]
    rw [eq_top_iff, ← htop]
    refine iSup_le fun γ => ?_
    by_cases hγ : ∀ j, γ j = 0 ∨ γ j = 1
    · have hs : γB (fun j => decide (γ j = 1)) = γ := by
        funext j; simp only [γB]
        rcases hγ j with h | h <;> simp [h]
      refine le_iSup_of_le (fun j => decide (γ j = 1)) ?_
      show _ ≤ ⨅ j, Module.End.eigenspace (T j) (γB (fun j => decide (γ j = 1)) j)
      rw [hs]
    · push Not at hγ
      obtain ⟨j, h0, h1⟩ := hγ
      calc ⨅ i, Module.End.eigenspace (T i) (γ i) ≤ Module.End.eigenspace (T j) (γ j) := iInf_le _ j
        _ = ⊥ := heig_bot j (γ j) h0 h1
        _ ≤ _ := bot_le
  let b := hV.subordinateOrthonormalBasis finrank_euclideanSpace_fin hV'
  refine ⟨fun k => ofLp (b k),
    fun k a => γB (hV.subordinateOrthonormalBasisIndex finrank_euclideanSpace_fin k hV') a,
    fun p q => ?_, fun k a => ?_⟩
  · have := orthonormal_iff_ite.mp b.orthonormal p q
    rw [EuclideanSpace.inner_eq_star_dotProduct] at this
    simp only [dotProduct, star_trivial] at this
    rw [← this]
    exact Finset.sum_congr rfl fun r _ => mul_comm _ _
  · have hmem := hV.subordinateOrthonormalBasis_subordinate finrank_euclideanSpace_fin k hV'
    have hk := (Submodule.mem_iInf _).mp hmem a
    rw [Module.End.mem_eigenspace_iff] at hk
    have := congrArg ofLp hk
    rw [happ] at this
    simpa using this

end L201Frame

/-- **The textbook half of L201, PROVED.** A pairwise commuting family of symmetric rank-two
projections has a common orthonormal frame in which every plane is a COORDINATE plane.

`L201Frame.joint_frame` gives an orthonormal frame `f` of joint eigenvectors. Completeness of the
frame writes each projection as `Σ_k μ_k f_k f_kᵀ`, idempotence puts every `μ_k` in `{0, 1}`,
and trace two leaves exactly two indices, which `Finset.card_eq_two` names `i a ≠ j a`. *This is
the step that makes the conclusion stronger than diagonalisability: rank two is what turns a
common eigenbasis into a frame carrying each plane as a coordinate plane.* -/
theorem frame_of_commuting (u v : Fin N → (Fin n → ℝ))
    (hu : ∀ a, ∑ p, u a p * u a p = 1) (hv : ∀ a, ∑ p, v a p * v a p = 1)
    (huv : ∀ a, ∑ p, u a p * v a p = 0)
    (hcomm : ∀ a b, planeProj (u a) (v a) * planeProj (u b) (v b)
      = planeProj (u b) (v b) * planeProj (u a) (v a)) :
    ∃ (f : Fin n → (Fin n → ℝ)) (i j : Fin N → Fin n),
      (∀ p q, ∑ r, f p r * f q r = if p = q then 1 else 0) ∧
      (∀ a, i a ≠ j a) ∧
      (∀ a, planeProj (u a) (v a) = planeProj (f (i a)) (f (j a))) := by
  classical
  have hsym : ∀ a, (planeProj (u a) (v a))ᵀ = planeProj (u a) (v a) := fun a => by
    ext p q; simp [planeProj, outer, Matrix.transpose_apply, mul_comm]
  have hidem : ∀ a, planeProj (u a) (v a) * planeProj (u a) (v a) = planeProj (u a) (v a) := by
    intro a; ext p q
    have hvu : ∑ r, v a r * u a r = 0 := by
      rw [← huv a]; exact Finset.sum_congr rfl fun r _ => mul_comm _ _
    rw [L201Proof.PQ_apply]
    simp only [L201Proof.d, hu a, hv a, huv a, hvu]
    simp [planeProj, outer]
  obtain ⟨f, μ, hf, heig⟩ := L201Frame.joint_frame (fun a => planeProj (u a) (v a)) hsym hidem hcomm
  let F : Matrix (Fin n) (Fin n) ℝ := Matrix.of f
  have hFF : F * Fᵀ = 1 := by
    ext p q; simp only [F, Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply, Matrix.one_apply, hf p q]
  have hFtF : Fᵀ * F = 1 := mul_eq_one_comm.mp hFF
  have hcomp : ∀ p q, ∑ k, f k p * f k q = if p = q then 1 else 0 := by
    intro p q
    have := congrFun (congrFun hFtF p) q
    simpa [F, Matrix.mul_apply, Matrix.one_apply] using this
  have hPf : ∀ a k r, ∑ s, planeProj (u a) (v a) r s * f k s = μ k a * f k r := fun a k r => by
    have := congrFun (heig k a) r
    simpa [Matrix.mulVec, dotProduct] using this
  have hexp : ∀ a p q, planeProj (u a) (v a) p q = ∑ k, μ k a * f k p * f k q := by
    intro a p q
    calc planeProj (u a) (v a) p q
        = ∑ r, planeProj (u a) (v a) p r * (if r = q then 1 else 0) := by simp
      _ = ∑ r, planeProj (u a) (v a) p r * ∑ k, f k r * f k q := by simp only [hcomp]
      _ = ∑ k, (∑ r, planeProj (u a) (v a) p r * f k r) * f k q := by
          simp only [Finset.mul_sum, Finset.sum_mul]
          rw [Finset.sum_comm]
          exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun r _ => by ring
      _ = ∑ k, μ k a * f k p * f k q := by simp only [hPf]
  have hn : ∀ k, ∑ r, f k r * f k r = 1 := fun k => by simpa using hf k k
  have hμ : ∀ k a, μ k a = 0 ∨ μ k a = 1 := by
    intro k a
    have h1 : planeProj (u a) (v a) *ᵥ (planeProj (u a) (v a) *ᵥ f k) = planeProj (u a) (v a) *ᵥ f k := by
      rw [Matrix.mulVec_mulVec, hidem]
    rw [heig, Matrix.mulVec_smul, heig, smul_smul] at h1
    have h2 := congrArg (fun g : Fin n → ℝ => ∑ r, g r * f k r) h1
    simp only [Pi.smul_apply, smul_eq_mul, mul_assoc, ← Finset.mul_sum, hn, mul_one] at h2
    have h3 : μ k a * (μ k a - 1) = 0 := by linarith
    rcases mul_eq_zero.mp h3 with h | h
    · exact Or.inl h
    · exact Or.inr (by linarith)
  have htr : ∀ a, ∑ k, μ k a = 2 := by
    intro a
    have h1 : ∑ p, planeProj (u a) (v a) p p = 2 := by
      simp only [planeProj, outer, Matrix.add_apply, Matrix.of_apply, Finset.sum_add_distrib, hu a, hv a]
      norm_num
    rw [← h1]
    simp only [hexp]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [eq_comm]
    simp only [mul_assoc, ← Finset.mul_sum, hn k, mul_one]
  have hcard : ∀ a, (Finset.univ.filter (fun k => μ k a = 1)).card = 2 := by
    intro a
    have h1 : ∑ k, μ k a = ∑ k, if μ k a = 1 then (1 : ℝ) else 0 :=
      Finset.sum_congr rfl fun k _ => by rcases hμ k a with h | h <;> simp [h]
    rw [Finset.sum_boole, htr a] at h1
    exact_mod_cast h1.symm
  choose i j hij hS using fun a => Finset.card_eq_two.mp (hcard a)
  refine ⟨f, i, j, hf, hij, fun a => ?_⟩
  ext p q
  rw [hexp]
  have h1 : ∑ k, μ k a * f k p * f k q
      = ∑ k ∈ Finset.univ.filter (fun k => μ k a = 1), f k p * f k q := by
    rw [Finset.sum_filter]
    exact Finset.sum_congr rfl fun k _ => by rcases hμ k a with h | h <;> simp [h]
  rw [h1, hS a, Finset.sum_pair (hij a)]
  simp [planeProj, outer]


/-- **Lemma L201.** Integrality of the pairwise plane traces forces a common frame. **This
is PROVED from the two halves above**, `commuting_of_integral` (the commutator norm
`2S - 2S² + 4 det(M)²` in the cross Gram matrix) and `frame_of_commuting` (a common eigenframe
of the commuting projections, with rank two selecting two coordinate vectors per plane). -/
theorem integrality_forces_frame (hn : 3 ≤ n) (u v : Fin N → (Fin n → ℝ))
    (hu : ∀ a, ∑ p, u a p * u a p = 1) (hv : ∀ a, ∑ p, v a p * v a p = 1)
    (huv : ∀ a, ∑ p, u a p * v a p = 0)
    (hcomplete : ∑ a, planeProj (u a) (v a) = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ))
    (horth : ∀ a b, a ≠ b →
      (∑ p, u a p * u b p) * (∑ p, v a p * v b p)
        - (∑ p, u a p * v b p) * (∑ p, v a p * u b p) = 0)
    (hint : ∀ a b, a ≠ b →
      (planeProj (u a) (v a) * planeProj (u b) (v b)).trace = 0 ∨
      (planeProj (u a) (v a) * planeProj (u b) (v b)).trace = 1) :
    ∃ (f : Fin n → (Fin n → ℝ)) (i j : Fin N → Fin n),
      (∀ p q, ∑ r, f p r * f q r = if p = q then 1 else 0) ∧
      (∀ a, i a ≠ j a) ∧
      (∀ a, planeProj (u a) (v a) = planeProj (f (i a)) (f (j a))) :=
  frame_of_commuting u v hu hv huv
    (fun a b => commuting_of_integral u v hu hv huv horth hint a b)

/-! ## The commutator identity, pinned at one instance

`‖[Π_α,Π_β]‖_F² = 2 t (1 - t)` at `t = tr(Π_α Π_β)` is what makes integrality
commutativity, and the factor `2` is the whole content. It is checked here at an
explicit pair whose principal angle is neither right nor zero: `u = e₀`, `v = e₁`,
`x = e₂`, `y = e₃` and `u' = (3/5)e₀ + (4/5)e₂`, so `t = 9/25` and the identity
predicts `2·(9/25)·(16/25) = 288/625`.
-/

/-- The first plane of the instance, `span{e₀, e₁}`. -/
def instA : Matrix (Fin 4) (Fin 4) ℝ :=
  planeProj (fun i => if i = 0 then 1 else 0) (fun i => if i = 1 then 1 else 0)

/-- The second plane, `span{(3/5)e₀ + (4/5)e₂, e₃}`. -/
noncomputable def instB : Matrix (Fin 4) (Fin 4) ℝ :=
  planeProj (fun i => if i = 0 then 3/5 else if i = 2 then 4/5 else 0)
    (fun i => if i = 3 then 1 else 0)

/-- **The trace of the product is `9/25`**, the squared cosine of the one angle that
is not right. -/
theorem trace_instA_instB : (instA * instB).trace = 9 / 25 := by
  simp [instA, instB, planeProj, outer, Matrix.trace, Matrix.diag, Matrix.mul_apply,
    Fin.sum_univ_succ]
  norm_num

/-- **And the commutator's squared Frobenius norm is `288/625`**, which is
`2 t (1 - t)` at `t = 9/25`. The factor `2` is pinned by this instance. -/
theorem frobSq_commutator_inst :
    ∑ i, ∑ j, (instA * instB - instB * instA) i j ^ 2 = 288 / 625 := by
  simp [instA, instB, planeProj, outer, Matrix.sub_apply, Matrix.mul_apply,
    Fin.sum_univ_succ]
  norm_num


/-! ## [I76](../../../plan.md): two eigenvalues force the Gram matrix to be `A`-regular

At two distinct eigenvalues, Ricci-flatness `S λ = 0` and completeness `S 1 = 2(n-1) 1`
subtract and the weights cancel: the `A`-row sums of `S` are the constant
`2(n-1)|A|/N` at EVERY index. The weights enter only through trace-freeness.
-/

/-- **The row identity behind it**: the full row sum of `S` is `2(n-1)` at every index. -/
theorem sum_trace_row (P : Fin N → Matrix (Fin n) (Fin n) ℝ)
    (htr : ∀ a, (P a).trace = 2)
    (hsum : ∑ a, P a = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ)) (a : Fin N) :
    ∑ b, (P a * P b).trace = 2 * ((n : ℝ) - 1) := by
  calc ∑ b, (P a * P b).trace = (∑ b, P a * P b).trace := (Matrix.trace_sum _ _).symm
    _ = (P a * ∑ b, P b).trace := by rw [Finset.mul_sum]
    _ = (P a * (((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ))).trace := by rw [hsum]
    _ = 2 * ((n : ℝ) - 1) := by
        rw [Matrix.mul_smul, Matrix.mul_one, Matrix.trace_smul, htr a, smul_eq_mul]; ring

/-- **`A`-regularity at two eigenvalues.** With the weights `μ` on `A` and `ν` off it,
trace-free and Ricci-flat, the `A`-row sums of the Gram matrix are constant and equal to
`2(n-1)|A|/N`. The eigenvalues cancel, so the conclusion is a condition on the
configuration alone. -/
theorem two_eigenvalue_A_regular (P : Fin N → Matrix (Fin n) (Fin n) ℝ)
    (htr : ∀ a, (P a).trace = 2)
    (hsum : ∑ a, P a = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ))
    (A : Finset (Fin N)) (μ ν : ℝ) (hne : μ ≠ ν) (hN : (N : ℝ) ≠ 0)
    (htf : (A.card : ℝ) * μ + ((N : ℝ) - A.card) * ν = 0)
    (hricci : ∀ a, ∑ b, (if b ∈ A then μ else ν) * (P a * P b).trace = 0) (a : Fin N) :
    ∑ b ∈ A, (P a * P b).trace = 2 * ((n : ℝ) - 1) * A.card / (N : ℝ) := by
  set X := ∑ b ∈ A, (P a * P b).trace with hX
  set T := 2 * ((n : ℝ) - 1) with hT
  have hrow : ∑ b, (P a * P b).trace = T := sum_trace_row P htr hsum a
  have hsplit : X + ∑ b ∈ Aᶜ, (P a * P b).trace = T := by
    rw [hX, ← hrow, ← Finset.sum_add_sum_compl A]
  have hA : ∑ b ∈ A, (if b ∈ A then μ else ν) * (P a * P b).trace = μ * X := by
    rw [hX, Finset.mul_sum]
    exact Finset.sum_congr rfl fun b hb => by rw [if_pos hb]
  have hAc : ∑ b ∈ Aᶜ, (if b ∈ A then μ else ν) * (P a * P b).trace
      = ν * ∑ b ∈ Aᶜ, (P a * P b).trace := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b hb => by rw [if_neg (Finset.mem_compl.mp hb)]
  have hric : μ * X + ν * (∑ b ∈ Aᶜ, (P a * P b).trace) = 0 := by
    have h := hricci a
    rw [← Finset.sum_add_sum_compl A, hA, hAc] at h
    exact h
  have hkey : (μ - ν) * X = -ν * T := by
    have hc : ∑ b ∈ Aᶜ, (P a * P b).trace = T - X := by linarith
    rw [hc] at hric
    linear_combination hric
  have hsub : μ - ν ≠ 0 := sub_ne_zero_of_ne hne
  have h0 : (μ - ν) * (X * (N : ℝ) - T * A.card) = 0 := by
    linear_combination (N : ℝ) * hkey - T * htf
  have hXN : X * (N : ℝ) = T * A.card := by
    rcases mul_eq_zero.mp h0 with h | h
    · exact absurd h hsub
    · linarith
  field_simp
  linarith [hXN]

/-- **The isotropy form, which is strictly stronger than `A`-regularity.** At two
eigenvalues, Ricci-flatness as a MATRIX equation forces the sum of the projections over
the positive eigenspace to be a multiple of the identity, `Θ(E) = (2a/n) Id`. The weights
cancel, so the conclusion mentions only the configuration and `a = |A|`. -/
theorem two_eigenvalue_isotropic (P : Fin N → Matrix (Fin n) (Fin n) ℝ)
    (hsum : ∑ a, P a = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ))
    (A : Finset (Fin N)) (μ ν : ℝ) (hne : μ ≠ ν) (hn : (n : ℝ) ≠ 0)
    (hNn : (N : ℝ) = (n : ℝ) * ((n : ℝ) - 1) / 2)
    (htf : (A.card : ℝ) * μ + ((N : ℝ) - A.card) * ν = 0)
    (hricci : ∑ a, (if a ∈ A then μ else ν) • P a = (0 : Matrix (Fin n) (Fin n) ℝ)) :
    ∑ a ∈ A, P a = (2 * (A.card : ℝ) / (n : ℝ)) • (1 : Matrix (Fin n) (Fin n) ℝ) := by
  set X := ∑ a ∈ A, P a with hX
  have hsplit : X + ∑ a ∈ Aᶜ, P a = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ) := by
    rw [hX, Finset.sum_add_sum_compl, hsum]
  have hA : ∑ a ∈ A, (if a ∈ A then μ else ν) • P a = μ • X := by
    rw [hX, Finset.smul_sum]
    exact Finset.sum_congr rfl fun b hb => by rw [if_pos hb]
  have hAc : ∑ a ∈ Aᶜ, (if a ∈ A then μ else ν) • P a = ν • ∑ a ∈ Aᶜ, P a := by
    rw [Finset.smul_sum]
    exact Finset.sum_congr rfl fun b hb => by rw [if_neg (Finset.mem_compl.mp hb)]
  have hric : μ • X + ν • (∑ a ∈ Aᶜ, P a) = (0 : Matrix (Fin n) (Fin n) ℝ) := by
    have h := hricci
    rw [← Finset.sum_add_sum_compl A, hA, hAc] at h
    exact h
  have hcompl : ∑ a ∈ Aᶜ, P a = ((n : ℝ) - 1) • (1 : Matrix (Fin n) (Fin n) ℝ) - X := by
    rw [← hsplit]; abel
  rw [hcompl, smul_sub, smul_smul] at hric
  have hkey : (μ - ν) • X = (-(ν * ((n : ℝ) - 1))) • (1 : Matrix (Fin n) (Fin n) ℝ) := by
    have h := hric
    rw [sub_smul]
    linear_combination (norm := module) h
  have hcoef : -(ν * ((n : ℝ) - 1)) = (μ - ν) * (2 * (A.card : ℝ) / (n : ℝ)) := by
    field_simp
    rw [hNn] at htf
    field_simp at htf
    linarith
  rw [hcoef, ← smul_smul] at hkey
  exact smul_right_injective _ (sub_ne_zero_of_ne hne) hkey

end HamiltonsCubic.Results
