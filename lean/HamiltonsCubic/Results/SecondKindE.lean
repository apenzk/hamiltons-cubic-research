import HamiltonsCubic.Results.L50Spectra
import HamiltonsCubic.Results.SmallMassE

set_option linter.style.longLine false

/-!
# `E` is the second-kind cubic, and it is bounded by the bottom of `W̊`

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121's small-mass node,
"`E` is the second-kind cubic". With `E = P − (3/2) tr M³` the quantity of the node's reduction and
`W̊` the curvature operator of the second kind in Li's `iklj` order:

- `E_eq_ring`: **`E = −½ tr_{S²} W̊³`**, which is [L50](../../../findings/bispectral.md)'s identity
  `θ = (3/2) p₃(μ) − ½ p₃(ω)` read with `E` in place of `θ − (3/2) p₃(μ)`;
- `trS2_cube_ge`: if `⟨W̊ h, h⟩ ≥ −m ‖h‖²` on symmetric `h`, then `tr_{S²} W̊³ ≥ −m tr_{S²} W̊²`,
  since the trace is `∑ ⟨(W̊ + m) v, v⟩` over `v = W̊ s` for `s` the symmetric basis;
- `E_le`: under the same hypothesis, **`E ≤ (3/2) m ‖W‖²`**, with L50's `tr_{S²} W̊² = 3‖W‖²`;
- `neg_frob_ringW`: `−⟨W̊ h, h⟩ = ∑ W_{abcd} h_{ac} h_{bd}`, the pairing of `W` with `Λ²h`;
- `hollow_quad_sq_le` and `sumsq_sq_le`: for a hollow matrix `K` and a vector `d`,
  `(dᵀKd)² ≤ ‖K‖²_F ((∑d²)² − ∑d⁴)` and `(∑d²)² ≤ n ∑d⁴`, the scalar half of the frame step.

- `eigen_expand`, `quad_eigen`, `frob_eigen`, `secK_diag`: in the eigenframe of a symmetric `h`
  (Mathlib's spectral theorem), `∑ W_{abcd} h_{ac} h_{bd} = eᵀ K e` with `K` the hollow sectional
  matrix of that frame and `‖h‖² = ∑ e²`;
- `neg_frob_ringW_le`: so `−⟨W̊ h, h⟩ ≤ √((n−1)/n) √B ‖h‖²` whenever every frame has `∑ K² ≤ B`;
- **`E_le_frame`: `E ≤ (3/2) √((n−1)/n) √B ‖W‖²`**, which at the least such `B`, `κ² = 2 t²_max`,
  is `E ≤ (3/2) √(2(n−1)/n) t_max ‖W‖²`.

**Not typed**: the identification of the least `B` with the record's `κ²` and `2 t²_max`, which is
the definition of those quantities ([L94](../../../findings/bispectral.md)), and the application at
a critical point, which is `crit_E_bound` in [SmallMassE.lean](SmallMassE.lean).
-/

namespace HamiltonsCubic.SecondKindE

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.SecondKind
  HamiltonsCubic.L50Spectra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [Fintype ι] in
/-- The symmetric basis tensor is symmetric. -/
theorem symB_symm (a b : ι) : (symB a b)ᵀ = symB a b := by
  ext i j
  simp only [symB, Matrix.transpose_apply, Matrix.smul_apply, Matrix.add_apply,
    Matrix.single_apply, smul_eq_mul]
  by_cases h1 : a = i <;> by_cases h2 : b = j <;> by_cases h3 : a = j <;> by_cases h4 : b = i <;>
    simp_all

/-- Pairing a symmetric matrix with the symmetric basis tensor reads off its entry. -/
theorem frob_symB (X : Matrix ι ι ℝ) (hX : Xᵀ = X) (a b : ι) : frob X (symB a b) = X a b := by
  have hba : X b a = X a b := by
    have := congrFun (congrFun hX a) b; simpa [Matrix.transpose_apply] using this
  unfold frob symB
  simp only [Matrix.smul_apply, Matrix.add_apply, Matrix.single_apply, smul_eq_mul, mul_add,
    Finset.sum_add_distrib, mul_ite, mul_one, mul_zero, ite_and]
  simp [Finset.sum_ite_eq, hba]
  ring

section trace

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- **Trace positivity.** If `⟨W̊ h, h⟩ ≥ −m ‖h‖²` for every symmetric `h`, then
`tr_{S²} W̊³ ≥ −m tr_{S²} W̊²`. *Each basis term is `⟨(W̊ + m) v, v⟩` at `v = W̊ s`.* -/
theorem trS2_cube_ge (m : ℝ)
    (hm : ∀ h : Matrix ι ι ℝ, hᵀ = h → -m * frob h h ≤ frob (ringW R h) h) :
    -m * trS2 (fun h => ringW R (ringW R h)) ≤ trS2 (fun h => ringW R (ringW R (ringW R h))) := by
  unfold trS2
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun a _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun b _ => ?_
  have hs : (symB a b)ᵀ = symB a b := symB_symm a b
  have h1 := ringW_symm R hR hskew hsym _ hs
  have h2 := ringW_symm R hR hskew hsym _ h1
  have h3 := ringW_symm R hR hskew hsym _ h2
  show -m * ringW R (ringW R (symB a b)) a b ≤ ringW R (ringW R (ringW R (symB a b))) a b
  rw [← frob_symB _ h3 a b, ← frob_symB _ h2 a b,
    ringW_selfAdjoint R hR hskew hsym (ringW R (ringW R (symB a b))) (symB a b),
    ringW_selfAdjoint R hR hskew hsym (ringW R (symB a b)) (symB a b)]
  exact hm _ h1

variable (hB : ∀ i j k l, bianchi R i j k l = 0)
include hB

/-- **`E` IS THE SECOND-KIND CUBIC**: `P − (3/2) tr M³ = −½ tr_{S²} W̊³`. -/
theorem E_eq_ring :
    Pcubic R - (3 / 2) * trCube R = -(1 / 2) * trS2 (fun h => ringW R (ringW R (ringW R h))) := by
  rw [L50_bispectral R hR hskew hsym hB]; ring

/-- **`E ≤ (3/2) m ‖W‖²`** whenever `⟨W̊ h, h⟩ ≥ −m ‖h‖²` on symmetric `h`. -/
theorem E_le (m : ℝ)
    (hm : ∀ h : Matrix ι ι ℝ, hᵀ = h → -m * frob h h ≤ frob (ringW R h) h) :
    Pcubic R - (3 / 2) * trCube R ≤ (3 / 2) * m * normSq R := by
  rw [E_eq_ring R hR hskew hsym hB]
  have key := trS2_cube_ge R hR hskew hsym m hm
  rw [L50_norm R hR hskew hsym hB] at key
  linarith

end trace

section quad

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
include hR

/-- **`−⟨W̊ h, h⟩ = ∑ W_{abcd} h_{ac} h_{bd}`**, the pairing of `W` with `Λ²h`. -/
theorem neg_frob_ringW (h : Matrix ι ι ℝ) :
    -frob (ringW R h) h = ∑ a, ∑ b, ∑ c, ∑ d, R4 R a b c d * h a c * h b d := by
  unfold frob ringW
  simp only [Finset.sum_mul, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun l _ => ?_
  rw [R4_anti2 R hR i k j l]; ring

end quad

/-! ## The scalar half of the frame step -/

/-- **A hollow quadratic form is bounded by the off-diagonal mass of `d ⊗ d`.**
`(∑ K_pq d_p d_q)² ≤ (∑ K_pq²) ((∑ d²)² − ∑ d⁴)` when `K_pp = 0`. -/
theorem hollow_quad_sq_le (K : ι → ι → ℝ) (hK : ∀ p, K p p = 0) (d : ι → ℝ) :
    (∑ p, ∑ q, K p q * d p * d q) ^ 2
      ≤ (∑ p, ∑ q, K p q ^ 2) * ((∑ p, d p ^ 2) ^ 2 - ∑ p, d p ^ 4) := by
  set x : ι × ι → ℝ := fun pq => if pq.1 = pq.2 then 0 else d pq.1 * d pq.2 with hx
  have e1 : (∑ p, ∑ q, K p q * d p * d q) = ∑ pq : ι × ι, K pq.1 pq.2 * x pq := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    simp only [hx]
    split_ifs with hpq
    · subst hpq; rw [hK]; ring
    · ring
  have e2 : (∑ p, ∑ q, K p q ^ 2) = ∑ pq : ι × ι, K pq.1 pq.2 ^ 2 := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
  have hx2 : ∀ p q, x (p, q) ^ 2 = d p ^ 2 * d q ^ 2 - (if p = q then d p ^ 4 else 0) := by
    intro p q
    simp only [hx]
    split_ifs with h
    · subst h; ring
    · ring
  have e3 : (∑ p, d p ^ 2) ^ 2 - ∑ p, d p ^ 4 = ∑ pq : ι × ι, x pq ^ 2 := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
    simp only [hx2, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [sq, Finset.sum_mul_sum]
  rw [e1, e2, e3]
  exact Finset.sum_mul_sq_le_sq_mul_sq _ _ _

omit [DecidableEq ι] in
/-- `(∑ d²)² ≤ n ∑ d⁴`, Cauchy–Schwarz against the constant vector. -/
theorem sumsq_sq_le (d : ι → ℝ) :
    (∑ p, d p ^ 2) ^ 2 ≤ (Fintype.card ι : ℝ) * ∑ p, d p ^ 4 := by
  have := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun _ => (1 : ℝ)) (fun p => d p ^ 2)
  simp only [one_mul, one_pow, Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at this
  calc (∑ p, d p ^ 2) ^ 2 ≤ (Fintype.card ι : ℝ) * ∑ p, (d p ^ 2) ^ 2 := this
    _ = (Fintype.card ι : ℝ) * ∑ p, d p ^ 4 := by
        congr 1; exact Finset.sum_congr rfl fun p _ => by ring

/-- `(∑ d²)² − ∑ d⁴ ≥ 0`, the off-diagonal mass of `d ⊗ d`. -/
theorem offdiag_nonneg (d : ι → ℝ) : 0 ≤ (∑ p, d p ^ 2) ^ 2 - ∑ p, d p ^ 4 := by
  have h := hollow_quad_sq_le (fun _ _ => (0 : ℝ)) (fun _ => rfl) d
  have e : (∑ p, d p ^ 2) ^ 2 - ∑ p, d p ^ 4
      = ∑ p, ∑ q, (if p = q then (0 : ℝ) else d p * d q) ^ 2 := by
    have hx2 : ∀ p q, (if p = q then (0 : ℝ) else d p * d q) ^ 2
        = d p ^ 2 * d q ^ 2 - (if p = q then d p ^ 4 else 0) := by
      intro p q; split_ifs with hpq
      · subst hpq; ring
      · ring
    simp only [hx2, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [sq, Finset.sum_mul_sum]
  rw [e]; positivity

/-! ## The frame step: `h` is diagonal in its eigenframe -/

omit [DecidableEq ι] in
/-- Moving two inner sums to the front of six. -/
theorem sum6_move (F : ι → ι → ι → ι → ι → ι → ℝ) :
    (∑ a, ∑ b, ∑ c, ∑ d, ∑ p, ∑ q, F a b c d p q)
      = ∑ p, ∑ q, ∑ a, ∑ b, ∑ c, ∑ d, F a b c d p q := by
  calc (∑ a, ∑ b, ∑ c, ∑ d, ∑ p, ∑ q, F a b c d p q)
      = ∑ a, ∑ b, ∑ c, ∑ p, ∑ d, ∑ q, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ a, ∑ b, ∑ p, ∑ c, ∑ d, ∑ q, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ a, ∑ p, ∑ b, ∑ c, ∑ d, ∑ q, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ p, ∑ a, ∑ b, ∑ c, ∑ d, ∑ q, F a b c d p q := Finset.sum_comm
    _ = ∑ p, ∑ a, ∑ b, ∑ c, ∑ q, ∑ d, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ p, ∑ a, ∑ b, ∑ q, ∑ c, ∑ d, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ p, ∑ a, ∑ q, ∑ b, ∑ c, ∑ d, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ p, ∑ q, ∑ a, ∑ b, ∑ c, ∑ d, F a b c d p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm

omit [DecidableEq ι] in
/-- Moving two inner sums to the front of four. -/
theorem sum4_move (F : ι → ι → ι → ι → ℝ) :
    (∑ i, ∑ j, ∑ p, ∑ q, F i j p q) = ∑ p, ∑ q, ∑ i, ∑ j, F i j p q := by
  calc (∑ i, ∑ j, ∑ p, ∑ q, F i j p q) = ∑ i, ∑ p, ∑ j, ∑ q, F i j p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ p, ∑ i, ∑ j, ∑ q, F i j p q := Finset.sum_comm
    _ = ∑ p, ∑ i, ∑ q, ∑ j, F i j p q :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ p, ∑ q, ∑ i, ∑ j, F i j p q := Finset.sum_congr rfl fun _ _ => Finset.sum_comm

/-- **Every symmetric real matrix is diagonal in an orthonormal frame**: `h_ij = ∑_p e_p U_ip U_jp`
with `Uᵀ U = 1`, from Mathlib's spectral theorem. -/
theorem eigen_expand (h : Matrix ι ι ℝ) (hh : hᵀ = h) :
    ∃ U : Matrix ι ι ℝ, Uᵀ * U = 1 ∧ ∃ e : ι → ℝ, ∀ i j, h i j = ∑ p, e p * U i p * U j p := by
  have hH : h.IsHermitian := by
    unfold Matrix.IsHermitian; rw [Matrix.conjTranspose_eq_transpose_of_trivial]; exact hh
  refine ⟨(hH.eigenvectorUnitary : Matrix ι ι ℝ), ?_, hH.eigenvalues, ?_⟩
  · have := Unitary.coe_star_mul_self hH.eigenvectorUnitary
    rwa [Matrix.star_eq_conjTranspose, Matrix.conjTranspose_eq_transpose_of_trivial] at this
  · intro i j
    have e := congrFun (congrFun hH.spectral_theorem i) j
    rw [Unitary.conjStarAlgAut_apply] at e
    rw [e, Matrix.mul_apply]
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [Matrix.mul_diagonal, Matrix.star_apply, star_trivial, Function.comp_apply,
      RCLike.ofReal_real_eq_id, id]
    ring

section frame

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- **The sectional matrix of `W` in the frame of `U`'s columns**, `K_pq = W(u_p, u_q, u_p, u_q)`. -/
noncomputable def secK (U : Matrix ι ι ℝ) (p q : ι) : ℝ :=
  ∑ a, ∑ b, ∑ c, ∑ d, R4 R a b c d * U a p * U b q * U c p * U d q

/-- In the eigenframe of `h`, the pairing with `Λ²h` is the quadratic form of the sectional
matrix: `∑ W_{abcd} h_{ac} h_{bd} = ∑ e_p e_q K_pq`. -/
theorem quad_eigen (U : Matrix ι ι ℝ) (e : ι → ℝ) (h : Matrix ι ι ℝ)
    (hh : ∀ i j, h i j = ∑ p, e p * U i p * U j p) :
    (∑ a, ∑ b, ∑ c, ∑ d, R4 R a b c d * h a c * h b d) = ∑ p, ∑ q, e p * e q * secK R U p q := by
  unfold secK
  simp only [hh, Finset.mul_sum, Finset.sum_mul]
  rw [sum6_move, Finset.sum_comm]
  refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ =>
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
  ring

/-- The frame norm: `‖h‖²_F = ∑ e_p²` when `Uᵀ U = 1`. -/
theorem frob_eigen (U : Matrix ι ι ℝ) (hU : Uᵀ * U = 1) (e : ι → ℝ) (h : Matrix ι ι ℝ)
    (hh : ∀ i j, h i j = ∑ p, e p * U i p * U j p) :
    frob h h = ∑ p, e p ^ 2 := by
  have hUU : ∀ p q, (∑ i, U i p * U i q) = if p = q then 1 else 0 := fun p q => by
    have := congrFun (congrFun hU p) q
    simpa [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using this
  unfold frob
  simp only [hh, Finset.mul_sum, Finset.sum_mul]
  rw [sum4_move]
  have step : ∀ p q, (∑ i, ∑ j, e p * U i p * U j p * (e q * U i q * U j q))
      = e p * e q * ((∑ i, U i p * U i q) * (∑ j, U j p * U j q)) := fun p q => by
    rw [Finset.sum_mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring
  simp only [step, hUU]
  refine Finset.sum_congr rfl fun p _ => ?_
  rw [Finset.sum_eq_single p (fun q _ hq => by rw [if_neg hq]; ring)
    (fun hp => absurd (Finset.mem_univ p) hp), if_pos rfl]
  ring

include hR hskew hsym

/-- **The sectional matrix is hollow**: `K_pp = 0`, by antisymmetry in the first pair. -/
theorem secK_diag (U : Matrix ι ι ℝ) (p : ι) : secK R U p p = 0 := by
  unfold secK
  set G : ι → ι → ℝ := fun a b => ∑ c, ∑ d, R4 R a b c d * U a p * U b p * U c p * U d p with hG
  have hGs : ∀ a b, G b a = -G a b := fun a b => by
    simp only [hG, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
    rw [R4_anti1 R hR hskew hsym a b c d]; ring
  have e : (∑ a, ∑ b, G a b) = -(∑ a, ∑ b, G a b) := by
    calc (∑ a, ∑ b, G a b) = ∑ b, ∑ a, G a b := Finset.sum_comm
      _ = ∑ b, ∑ a, -G b a := Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun a _ => by rw [hGs b a]
      _ = -(∑ a, ∑ b, G a b) := by simp only [Finset.sum_neg_distrib]
  have : (∑ a, ∑ b, G a b) = 0 := by linarith
  simpa [hG] using this

variable [Nonempty ι]

/-- **THE FRAME STEP.** If every orthonormal frame has `∑ K_pq² ≤ B`, then on symmetric `h`,
`−⟨W̊ h, h⟩ ≤ √((n−1)/n) √B ‖h‖²`. *The frame is `h`'s eigenframe.* -/
theorem neg_frob_ringW_le (B : ℝ)
    (hKB : ∀ U : Matrix ι ι ℝ, Uᵀ * U = 1 → ∑ p, ∑ q, secK R U p q ^ 2 ≤ B)
    (h : Matrix ι ι ℝ) (hh : hᵀ = h) :
    -frob (ringW R h) h
      ≤ Real.sqrt (((Fintype.card ι : ℝ) - 1) / Fintype.card ι) * Real.sqrt B * frob h h := by
  obtain ⟨U, hU, e, he⟩ := eigen_expand h hh
  rw [neg_frob_ringW R hR h, quad_eigen R U e h he, frob_eigen U hU e h he]
  set X := ∑ p, ∑ q, e p * e q * secK R U p q with hX
  set S := ∑ p, e p ^ 2 with hS
  have hn : (0 : ℝ) < Fintype.card ι := by exact_mod_cast Fintype.card_pos
  have hS0 : 0 ≤ S := Finset.sum_nonneg fun p _ => sq_nonneg _
  have hK := hKB U hU
  have hK0 : 0 ≤ ∑ p, ∑ q, secK R U p q ^ 2 :=
    Finset.sum_nonneg fun p _ => Finset.sum_nonneg fun q _ => sq_nonneg _
  have hq := hollow_quad_sq_le (secK R U) (secK_diag R hR hskew hsym U) e
  have hX' : X = ∑ p, ∑ q, secK R U p q * e p * e q := Finset.sum_congr rfl fun p _ =>
    Finset.sum_congr rfl fun q _ => by ring
  rw [← hX'] at hq
  have hoff := offdiag_nonneg e
  have h4 := sumsq_sq_le e
  -- (∑e²)² − ∑e⁴ ≤ ((n−1)/n) S²
  have hY : (∑ p, e p ^ 2) ^ 2 - ∑ p, e p ^ 4 ≤ ((Fintype.card ι : ℝ) - 1) / Fintype.card ι * S ^ 2 := by
    rw [div_mul_eq_mul_div, le_div_iff₀ hn]
    nlinarith
  have hX2 : X ^ 2 ≤ B * (((Fintype.card ι : ℝ) - 1) / Fintype.card ι * S ^ 2) := by
    calc X ^ 2 ≤ (∑ p, ∑ q, secK R U p q ^ 2) * ((∑ p, e p ^ 2) ^ 2 - ∑ p, e p ^ 4) := hq
      _ ≤ B * ((∑ p, e p ^ 2) ^ 2 - ∑ p, e p ^ 4) := mul_le_mul_of_nonneg_right hK hoff
      _ ≤ B * (((Fintype.card ι : ℝ) - 1) / Fintype.card ι * S ^ 2) :=
          mul_le_mul_of_nonneg_left hY (hK0.trans hK)
  have hB0 : 0 ≤ B := hK0.trans hK
  have hc0 : 0 ≤ ((Fintype.card ι : ℝ) - 1) / Fintype.card ι := by
    have : (1 : ℝ) ≤ Fintype.card ι := by exact_mod_cast Fintype.card_pos
    positivity
  calc X ≤ |X| := le_abs_self X
    _ ≤ Real.sqrt (B * (((Fintype.card ι : ℝ) - 1) / Fintype.card ι * S ^ 2)) := Real.abs_le_sqrt hX2
    _ = Real.sqrt (((Fintype.card ι : ℝ) - 1) / Fintype.card ι) * Real.sqrt B * S := by
        rw [Real.sqrt_mul hB0, Real.sqrt_mul hc0, Real.sqrt_sq hS0]; ring

variable (hB : ∀ i j k l, bianchi R i j k l = 0)
include hB

/-- **THE FRAME-FREE BOUND.** If every orthonormal frame has `∑ K_pq² ≤ B` (so `B = κ² = 2 t²_max`
at its least), then `E = P − (3/2) tr M³ ≤ (3/2) √((n−1)/n) √B ‖W‖²`. -/
theorem E_le_frame (B : ℝ)
    (hKB : ∀ U : Matrix ι ι ℝ, Uᵀ * U = 1 → ∑ p, ∑ q, secK R U p q ^ 2 ≤ B) :
    Pcubic R - (3 / 2) * trCube R
      ≤ (3 / 2) * (Real.sqrt (((Fintype.card ι : ℝ) - 1) / Fintype.card ι) * Real.sqrt B)
          * normSq R := by
  refine E_le R hR hskew hsym hB _ fun h hh => ?_
  have := neg_frob_ringW_le R hR hskew hsym B hKB h hh
  linarith

/-- **`E ≤ (3/2) √(2(n−1)/n) t ‖W‖²`** whenever every orthonormal frame has diagonal mass
`∑_{p<q} K_pq² ≤ t²`, that is `∑_{p,q} K_pq² ≤ 2t²`: the frame-free bound in the record's `t_max`. -/
theorem E_le_tmax (t : ℝ) (ht : 0 ≤ t)
    (hKB : ∀ U : Matrix ι ι ℝ, Uᵀ * U = 1 → ∑ p, ∑ q, secK R U p q ^ 2 ≤ 2 * t ^ 2) :
    Pcubic R - (3 / 2) * trCube R
      ≤ (3 / 2) * Real.sqrt (2 * (((Fintype.card ι : ℝ) - 1) / Fintype.card ι)) * t
          * normSq R := by
  have key := E_le_frame R hR hskew hsym hB (2 * t ^ 2) hKB
  have e : Real.sqrt (((Fintype.card ι : ℝ) - 1) / Fintype.card ι) * Real.sqrt (2 * t ^ 2)
      = Real.sqrt (2 * (((Fintype.card ι : ℝ) - 1) / Fintype.card ι)) * t := by
    rw [Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2) (t ^ 2), Real.sqrt_sq ht,
      Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]
    ring
  rw [e] at key
  linarith

end frame

/-! ## At the node -/

/-- **The uniform threshold.** At a unit critical point with `θ ≥ θ₀ > 0`, `θ² ≤ 3/2 + θE`
(`crit_E_bound` in [SmallMassE.lean](SmallMassE.lean)) and `E ≤ c t` with `c > 0` (`E_le_tmax`,
`c = (3/2)√(2(n−1)/n)`) give `t ≥ (θ₀ − 3/(2θ₀))/c`. -/
theorem t_ge_of_crit (θ θ₀ E c t : ℝ) (hθ₀ : 0 < θ₀) (hθ : θ₀ ≤ θ)
    (hb : θ ^ 2 ≤ 3 / 2 + θ * E) (hE : E ≤ c * t) (hc : 0 < c) :
    (θ₀ - 3 / (2 * θ₀)) / c ≤ t := by
  have hE' : θ₀ - 3 / (2 * θ₀) ≤ E := by
    by_contra h
    have h := not_le.mp h
    have := crit_E_lt θ θ₀ E (lt_of_lt_of_le hθ₀ hθ) hθ₀ hb h
    linarith
  rw [div_le_iff₀ hc]; linarith

end HamiltonsCubic.SecondKindE
