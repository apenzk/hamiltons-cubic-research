import HamiltonsCubic.Results.L2Statement
import HamiltonsCubic.Results.L130Statement
import HamiltonsCubic.Results.CP2Real

set_option linter.style.longLine false

/-!
# L2 at the operators: sphere products against the padded `ℂP²`

[L2Statement.lean](L2Statement.lean) proves Lemma L2's threshold with its two input values
imported: `θ(S^p × S^q)²` taken as the definition `thetaSpSq`, and `θ(ℂP²-type)² = 3/2` as a
numeral. **Both are now theorems of the layer**, and this file states L2 against the operators
themselves:

- `theta_sq_sphere`: at a unit-norm sphere product `diagOp (t • sphereWeight S)` with `|S| = p`,
  `|Sᶜ| = q`, `θ² = thetaSpSq p q`, from [Families.lean](../Base/Families.lean)'s
  `theta_sphereProduct` and [SphereValue.lean](../Base/SphereValue.lean)'s `sphereProductValue`;
- `sphere_unit`: such a unit scale `t > 0` exists;
- `theta_sq_Wc`: `θ(Wc n)² = 3/2` for the padded `ℂP²` operator at every `n ≥ 4`, from
  [CP2Real.lean](CP2Real.lean)'s `Wc_theta`;
- `L2_operators`: **for `4 ≤ n ≤ 11` every sphere product `S^p × S^q` with `p, q ≥ 2` has
  `θ² < θ(Wc n)²`, and for `n ≥ 12` some sphere product with `p, q ≥ 2` has `θ² > θ(Wc n)²`.**
-/

namespace HamiltonsCubic.L2Operators

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2Statement
  HamiltonsCubic.L130Statement HamiltonsCubic.CP2Real

variable {n : ℕ}

/-- A unit scale exists for every admissible split. -/
theorem sphere_unit (S : Finset (Fin n)) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    ∃ t : ℝ, 0 < t ∧ normSq (diagOp (t • sphereWeight S)) = 1 := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  set N := normSq (diagOp (sphereWeight S)) with hN
  have hNpos : 0 < N := by
    rw [hN, diagOp_normSq _ (sphereWeight_symm S) (sphereWeight_hollow S),
      sphereWeight_sumSq S hp hq]
    have h1 : (0 : ℝ) < (S.card : ℝ) - 1 := by linarith
    have h2 : (0 : ℝ) < (Sᶜ.card : ℝ) - 1 := by linarith
    apply mul_pos (by norm_num)
    apply div_pos _ (mul_pos h1 h2)
    have : (0 : ℝ) < (S.card : ℝ) + (Sᶜ.card : ℝ) - 2 := by linarith
    have : (0 : ℝ) < (S.card : ℝ) + (Sᶜ.card : ℝ) - 1 := by linarith
    positivity
  refine ⟨1 / Real.sqrt N, by positivity, ?_⟩
  rw [diagOp_normSq_smul _ _ (sphereWeight_symm S) (sphereWeight_hollow S), ← hN, div_pow,
    Real.sq_sqrt hNpos.le]
  field_simp

/-- **`θ² = thetaSpSq p q` at a unit sphere product.** -/
theorem theta_sq_sphere (S : Finset (Fin n)) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ)
    (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight S)) = 1) :
    theta (diagOp (t • sphereWeight S)) ^ 2 = thetaSpSq S.card Sᶜ.card := by
  rw [theta_sphereProduct sphereProductValue S hp hq t ht hn, thetaSplit,
    Real.sq_sqrt (thetaSplitSq_pos S hp hq).le]
  unfold thetaSplitSq thetaSpSq
  ring

/-- **`θ(Wc n)² = 3/2`** at every `n ≥ 4`. -/
theorem theta_sq_Wc (hn : 4 ≤ n) : theta (Wc n) ^ 2 = 3 / 2 := by
  rw [Wc_theta hn, Real.sq_sqrt (by norm_num)]

/-- The first `p` indices of `Fin n`. -/
def firstP (n p : ℕ) : Finset (Fin n) := univ.filter fun i => i.val < p

theorem card_firstP {p : ℕ} (hp : p ≤ n) : (firstP n p).card = p := by
  unfold firstP
  rw [show (univ.filter fun i : Fin n => i.val < p) = (Finset.range p).attachFin (fun m hm =>
      lt_of_lt_of_le (Finset.mem_range.mp hm) hp) by ext i; simp]
  simp

theorem card_compl_firstP {p : ℕ} (hp : p ≤ n) : (firstP n p)ᶜ.card = n - p := by
  rw [card_compl, card_firstP hp, Fintype.card_fin]

/-- **L2 AT THE OPERATORS.** -/
theorem L2_operators (h4 : 4 ≤ n) :
    (n ≤ 11 → ∀ (S : Finset (Fin n)) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ), 0 < t →
        normSq (diagOp (t • sphereWeight S)) = 1 →
        theta (diagOp (t • sphereWeight S)) ^ 2 < theta (Wc n) ^ 2)
    ∧ (12 ≤ n → ∃ (S : Finset (Fin n)) (t : ℝ), 2 ≤ S.card ∧ 2 ≤ Sᶜ.card ∧ 0 < t ∧
        normSq (diagOp (t • sphereWeight S)) = 1 ∧
        theta (Wc n) ^ 2 < theta (diagOp (t • sphereWeight S)) ^ 2) := by
  refine ⟨fun h11 S hp hq t ht hn => ?_, fun h12 => ?_⟩
  · rw [theta_sq_sphere S hp hq t ht hn, theta_sq_Wc h4]
    have hsum : S.card + Sᶜ.card = n := by rw [card_add_card_compl, Fintype.card_fin]
    exact lt_three_halves_of_le_eleven h4 h11 hp hq hsum
  · obtain ⟨p, q, hp, hq, hpq, hlt⟩ := exists_gt_three_halves h12
    have hpn : p ≤ n := by omega
    have hS : (firstP n p).card = p := card_firstP hpn
    have hSc : (firstP n p)ᶜ.card = q := by rw [card_compl_firstP hpn]; omega
    have hp' : 2 ≤ (firstP n p).card := by rw [hS]; exact hp
    have hq' : 2 ≤ (firstP n p)ᶜ.card := by rw [hSc]; exact hq
    obtain ⟨t, ht, hn⟩ := sphere_unit (firstP n p) hp' hq'
    refine ⟨firstP n p, t, hp', hq', ht, hn, ?_⟩
    rw [theta_sq_sphere _ hp' hq' t ht hn, theta_sq_Wc h4, hS, hSc]
    exact hlt

end HamiltonsCubic.L2Operators
