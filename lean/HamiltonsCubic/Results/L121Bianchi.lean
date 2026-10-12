import HamiltonsCubic.Results.L121Block

set_option linter.style.longLine false

/-!
# L121's Bianchi cut at every index tuple: the four-set span meets `𝒲` exactly in `𝟏^⊥`

[findings/second-order.md](../../../findings/second-order.md), Lemma L121: *"the Bianchi subspace is `𝟏^⊥` because
`â + b̂ + ĉ = 0` in these signed coordinates"*. [L121Block.lean](L121Block.lean)'s `fourSet_bianchi` reads first
Bianchi at the one tuple `(i,j,k,l)`. This file reads it at every tuple:

* **`bianchi_b_eq_a`**, **`bianchi_c_eq_a`**: the three signed basis operators `a = φ_ij ⊙ φ_kl`, `b = φ_ki ⊙ φ_jl`,
  `c = φ_il ⊙ φ_jk` have the same Bianchi number at every tuple `(p,q,r,s)`, by splitting each index over
  `i, j, k, l` and the rest;
* **`fourSet_bianchi_all`**: on `x a + y b + z c` the Bianchi number at every tuple is `(x + y + z)` times `a`'s;
* **`fourSet_bianchi_iff`**: so `x a + y b + z c` satisfies first Bianchi at every tuple exactly when
  `x + y + z = 0`, `a`'s number at `(i,j,k,l)` being `1`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option maxHeartbeats 4000000 in
-- the proof splits each of the four indices over `i, j, k, l` and the rest, 625 branches each closed by `simp_all`
/-- `b` and `a` have the same Bianchi number at every tuple. -/
theorem bianchi_b_eq_a {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (p q r s : ι) :
    bianchi (rk2 (phi k i) (phi j l)) p q r s = bianchi (rk2 (phi i j) (phi k l)) p q r s := by
  unfold bianchi rk2
  simp only [ip_add_l, ip_smul_l, inner2_phi_phi]
  rcases (show i = p ∨ j = p ∨ k = p ∨ l = p ∨ (p ≠ i ∧ p ≠ j ∧ p ≠ k ∧ p ≠ l ∧ i ≠ p ∧ j ≠ p ∧ k ≠ p ∧ l ≠ p) by tauto)
    with hp | hp | hp | hp | hp <;> (try subst hp) <;>
  rcases (show i = q ∨ j = q ∨ k = q ∨ l = q ∨ (q ≠ i ∧ q ≠ j ∧ q ≠ k ∧ q ≠ l ∧ i ≠ q ∧ j ≠ q ∧ k ≠ q ∧ l ≠ q) by tauto)
    with hq | hq | hq | hq | hq <;> (try subst hq) <;>
  rcases (show i = r ∨ j = r ∨ k = r ∨ l = r ∨ (r ≠ i ∧ r ≠ j ∧ r ≠ k ∧ r ≠ l ∧ i ≠ r ∧ j ≠ r ∧ k ≠ r ∧ l ≠ r) by tauto)
    with hr | hr | hr | hr | hr <;> (try subst hr) <;>
  rcases (show i = s ∨ j = s ∨ k = s ∨ l = s ∨ (s ≠ i ∧ s ≠ j ∧ s ≠ k ∧ s ≠ l ∧ i ≠ s ∧ j ≠ s ∧ k ≠ s ∧ l ≠ s) by tauto)
    with hs | hs | hs | hs | hs <;> (try subst hs) <;>
  simp_all [hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm]


set_option maxHeartbeats 4000000 in
-- the proof splits each of the four indices over `i, j, k, l` and the rest, 625 branches each closed by `simp_all`
/-- `c` and `a` have the same Bianchi number at every tuple. -/
theorem bianchi_c_eq_a {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (p q r s : ι) :
    bianchi (rk2 (phi i l) (phi j k)) p q r s = bianchi (rk2 (phi i j) (phi k l)) p q r s := by
  unfold bianchi rk2
  simp only [ip_add_l, ip_smul_l, inner2_phi_phi]
  rcases (show i = p ∨ j = p ∨ k = p ∨ l = p ∨ (p ≠ i ∧ p ≠ j ∧ p ≠ k ∧ p ≠ l ∧ i ≠ p ∧ j ≠ p ∧ k ≠ p ∧ l ≠ p) by tauto)
    with hp | hp | hp | hp | hp <;> (try subst hp) <;>
  rcases (show i = q ∨ j = q ∨ k = q ∨ l = q ∨ (q ≠ i ∧ q ≠ j ∧ q ≠ k ∧ q ≠ l ∧ i ≠ q ∧ j ≠ q ∧ k ≠ q ∧ l ≠ q) by tauto)
    with hq | hq | hq | hq | hq <;> (try subst hq) <;>
  rcases (show i = r ∨ j = r ∨ k = r ∨ l = r ∨ (r ≠ i ∧ r ≠ j ∧ r ≠ k ∧ r ≠ l ∧ i ≠ r ∧ j ≠ r ∧ k ≠ r ∧ l ≠ r) by tauto)
    with hr | hr | hr | hr | hr <;> (try subst hr) <;>
  rcases (show i = s ∨ j = s ∨ k = s ∨ l = s ∨ (s ≠ i ∧ s ≠ j ∧ s ≠ k ∧ s ≠ l ∧ i ≠ s ∧ j ≠ s ∧ k ≠ s ∧ l ≠ s) by tauto)
    with hs | hs | hs | hs | hs <;> (try subst hs) <;>
  simp_all [hij.symm, hik.symm, hil.symm, hjk.symm, hjl.symm, hkl.symm]


theorem bianchi_lin (x y z : ℝ) (a b c : CurvOp ι) (p q r s : ι) :
    bianchi (fun Y => x • a Y + y • b Y + z • c Y) p q r s
      = x * bianchi a p q r s + y * bianchi b p q r s + z * bianchi c p q r s := by
  unfold bianchi; simp only [ip_add_l, ip_smul_l]; ring

/-- **The Bianchi number of `x a + y b + z c` at every tuple is `(x + y + z)` times `a`'s.** -/
theorem fourSet_bianchi_all {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (x y z : ℝ) (p q r s : ι) :
    bianchi (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y + z • rk2 (phi i l) (phi j k) Y)
      p q r s = (x + y + z) * bianchi (rk2 (phi i j) (phi k l)) p q r s := by
  rw [bianchi_lin, bianchi_b_eq_a hij hik hil hjk hjl hkl, bianchi_c_eq_a hij hik hil hjk hjl hkl]; ring

/-- **THE BIANCHI SUBSPACE OF THE FOUR-SET SPAN IS `𝟏^⊥`**: `x a + y b + z c` satisfies first Bianchi at every tuple
exactly when `x + y + z = 0`. -/
theorem fourSet_bianchi_iff {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (x y z : ℝ) :
    (∀ p q r s, bianchi (fun Y => x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y
        + z • rk2 (phi i l) (phi j k) Y) p q r s = 0) ↔ x + y + z = 0 := by
  constructor
  · intro h
    have := h i j k l
    rwa [fourSet_bianchi hij hik hil hjk hjl hkl] at this
  · intro h p q r s
    rw [fourSet_bianchi_all hij hik hil hjk hjl hkl, h, zero_mul]

end HamiltonsCubic.L121Block
