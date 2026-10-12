import HamiltonsCubic.Results.L126Main
import HamiltonsCubic.Results.L26

set_option linter.style.longLine false

/-!
# L26 stated as one theorem

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L26: *"let `X` be `φ_π ⊙ φ_ρ` with its `Λ⁴`
component removed. Then `X ∈ Weyl_n`, and for the sphere product's `e`, `e ∘ X = μ X`, `μ = (n−2)/(2(p−1)(q−1))`,
`μ ≥ ½ ⟺ (p−2)(q−2) ≤ 1`."* The Bianchi vector `v = 2a − b − c` of [L126Assembly.lean](L126Assembly.lean) is `3X`,
its `Λ⁴` component being the one first Bianchi removes. On `Fin n`, at a unit sphere product and a `(2,2)`-split:

* **`mu_ge_half_iff`**: `μ ≥ ½ ⟺ (p − 2)(q − 2) ≤ 1`;
* **`L26_main`**: `v` is Weyl (`splitVec_isWeyl2`), nonzero (`splitVec_ne_zero`), `L_e v = μ v` (`split_LeLin`), and
  the criterion. L26's comparison with the within-factor top and the uniqueness of `(3,4)` are [L26.lean](L26.lean)'s.
-/

namespace HamiltonsCubic.L126Assembly

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

/-- **The criterion**: `μ_{p,q} ≥ ½` exactly when `(p − 2)(q − 2) ≤ 1`, at `p, q ≥ 2`. -/
theorem mu_ge_half_iff (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    1 / 2 ≤ HamiltonsCubic.L126Statement.mu p q ↔ ((p : ℝ) - 2) * ((q : ℝ) - 2) ≤ 1 := by
  have hpR : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
  have hd : 0 < 2 * ((p : ℝ) - 1) * ((q : ℝ) - 1) := by
    have : 0 < (p : ℝ) - 1 := by linarith
    have : 0 < (q : ℝ) - 1 := by linarith
    positivity
  unfold HamiltonsCubic.L126Statement.mu
  rw [le_div_iff₀ hd]
  constructor <;> intro h <;> nlinarith [h]

/-- **L26**: at a unit sphere product on `Fin n` and a `(2,2)`-split, the Bianchi vector `v = 3X` is Weyl, is a
nonzero `L_e`-eigenvector at `μ_{p,q}`, and `μ_{p,q} ≥ ½` exactly when `(p − 2)(q − 2) ≤ 1`. -/
theorem L26_main (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {i j k l : Fin n} (hi : i ∈ T) (hj : j ∈ T) (hk : k ∉ T)
    (hl : l ∉ T) (hij : i ≠ j) (hkl : k ≠ l) :
    let hW : IsWeyl (diagOp (t • sphereWeight T)) := diagOp_isWeyl ((sphereWeight_isWeight T hp hq).smul t)
    let v := restrictLin (splitVec_lin i j k l) (fun X _ => splitVec_skew i j k l X)
    IsWeyl2 v ∧ v ≠ 0 ∧ LeLin (restrict hW) v = HamiltonsCubic.L126Statement.mu T.card Tᶜ.card • v
      ∧ (1 / 2 ≤ HamiltonsCubic.L126Statement.mu T.card Tᶜ.card ↔ ((T.card : ℝ) - 2) * ((Tᶜ.card : ℝ) - 2) ≤ 1) := by
  intro hW v
  have hik : i ≠ k := fun h => hk (h ▸ hi)
  have hil : i ≠ l := fun h => hl (h ▸ hi)
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hjl : j ≠ l := fun h => hl (h ▸ hj)
  exact ⟨splitVec_isWeyl2 hij hik hil hjk hjl hkl, splitVec_ne_zero hij hik hil hjk hjl hkl, split_LeLin T hp hq t ht hn hi hj hk hl hij hkl,
    mu_ge_half_iff _ _ hp hq⟩

end HamiltonsCubic.L126Assembly
