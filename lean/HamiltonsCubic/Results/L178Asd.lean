import HamiltonsCubic.Results.L178Rot

set_option linter.style.longLine false

/-!
# L178 on `ℝⁿ`: the anti-self-dual mirror

Milestone 3 of [the L178 padding plan](../../../reviews/2026-09-26-lean-L178-padding-plan.md). `K 0, K 1, K 2`
are the three anti-self-dual complex structures on `ℝ⁴`, CP2Real's `J` with the sign of the second block
reversed. They form an `SUFrame` with sign `s = -1`, every matrix fact checked over `ℤ` by `decide`, so
[L178Rot.lean](L178Rot.lean)'s bound holds on `Λ⁻` too:

* **`asdFrame`**: the anti-self-dual `SUFrame`;
* **`WMatA_weyl`**, **`WMatA_bound`**, **`WMatA_theta_le`**: for every nonzero symmetric trace-free `M`,
  `W_M = Σ_{b,c} M_{bc} ⟨·, ω⁻_b⟩ ω⁻_c` is Weyl with `θ(W_M) ≤ √(3/2)`;
* **`J_K_orth`**, **`J_K_cyc`**: the self-dual and anti-self-dual forms are orthogonal and their mixed cyclic
  sums vanish, the two facts the reduction of a general operator will use.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer

def Kz : Fin 3 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => !![0, -1, 0, 0; 1, 0, 0, 0; 0, 0, 0, 1; 0, 0, -1, 0]
  | 1 => !![0, 0, -1, 0; 0, 0, 0, -1; 1, 0, 0, 0; 0, 1, 0, 0]
  | 2 => !![0, 0, 0, -1; 0, 0, 1, 0; 0, -1, 0, 0; 1, 0, 0, 0]

/-- The three anti-self-dual complex structures on `ℝ⁴`. -/
def K (a : Fin 3) : Matrix (Fin 4) (Fin 4) ℝ := fun i j => ((Kz a i j : ℤ) : ℝ)

theorem Kz_skew : ∀ (a : Fin 3) (i j : Fin 4), Kz a j i = -Kz a i j := by decide
theorem Kz_orth : ∀ (a : Fin 3) (i j : Fin 4), ∑ k, Kz a k i * Kz a k j = if i = j then 1 else 0 := by decide
theorem Kz_inner : ∀ (a b : Fin 3), ∑ i, ∑ k, Kz a k i * Kz b k i = if a = b then 4 else 0 := by decide
theorem Kz_br : ∀ (a b : Fin 3) (i j : Fin 4),
    ∑ k, Kz a i k * Kz b k j - ∑ k, Kz b i k * Kz a k j = -2 * ∑ c, eps a b c * Kz c i j := by decide
theorem Kz_cyc : ∀ (a : Fin 3) (p q r t : Fin 4),
    Kz a q p * Kz a t r + Kz a r p * Kz a q t + Kz a t p * Kz a r q
      = Kz 0 q p * Kz 0 t r + Kz 0 r p * Kz 0 q t + Kz 0 t p * Kz 0 r q := by decide
theorem Kz_anti : ∀ a b : Fin 3, a ≠ b → ∀ i j : Fin 4,
    ∑ k, Kz a i k * Kz b k j + ∑ k, Kz b i k * Kz a k j = 0 := by decide
theorem Kz_cyc_cross : ∀ a b : Fin 3, a ≠ b → ∀ p q r t : Fin 4,
    (Kz a q p * Kz b t r + Kz a r p * Kz b q t + Kz a t p * Kz b r q)
      + (Kz b q p * Kz a t r + Kz b r p * Kz a q t + Kz b t p * Kz a r q) = 0 := by decide

/-- **The anti-self-dual structures are an `SUFrame`**, with sign `s = -1`. -/
noncomputable def asdFrame : SUFrame where
  F := K
  s := -1
  s_sq := by norm_num
  skew := fun a => by
    ext i j; simp only [K, Matrix.transpose_apply, Matrix.neg_apply]; exact_mod_cast Kz_skew a i j
  orth := fun a => by
    ext i j
    simp only [K, Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply]
    have h := Kz_orth a i j
    split_ifs at h ⊢ <;> exact_mod_cast h
  inner := fun a b => by
    simp only [K, Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply]
    have h := Kz_inner a b
    split_ifs at h ⊢ <;> exact_mod_cast h
  br := fun a b => by
    ext i j
    have h' : (∑ k, Kz a i k * Kz b k j - ∑ k, Kz b i k * Kz a k j : ℤ) = 2 * (-1) * ∑ c, eps a b c * Kz c i j := by
      rw [Kz_br a b i j]; ring
    simp only [K, Matrix.sub_apply, Matrix.mul_apply, Matrix.smul_apply, Matrix.sum_apply, smul_eq_mul]
    exact_mod_cast h'
  cyc_eq := fun a p q r t => by simp only [cyc, K]; exact_mod_cast Kz_cyc a p q r t
  anti := fun a b hab => by
    ext i j
    have h := Kz_anti a b hab i j
    simp only [K, Matrix.add_apply, Matrix.mul_apply, Matrix.zero_apply]
    exact_mod_cast h
  cyc_cross := fun a b hab p q r t => by simp only [cyc2, K]; exact_mod_cast Kz_cyc_cross a b hab p q r t

variable {n : ℕ}

/-- `W_M` on the anti-self-dual forms. -/
noncomputable abbrev WMatA (n : ℕ) (M : Matrix (Fin 3) (Fin 3) ℝ) := WMatF asdFrame n M

/-- **Every anti-self-dual padded operator is Weyl.** -/
theorem WMatA_weyl (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    IsWeyl (WMatA n M) := WMatF_weyl asdFrame hn hM htr

/-- **L178's bound on every anti-self-dual padded operator.** -/
theorem WMatA_bound (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0) :
    Pcubic (WMatA n M) ^ 2 ≤ (3 / 2) * normSq (WMatA n M) ^ 3 := WMatF_bound asdFrame hn hM htr

/-- **`θ(W_M) ≤ √(3/2)`** on the anti-self-dual forms. -/
theorem WMatA_theta_le (hn : 4 ≤ n) {M : Matrix (Fin 3) (Fin 3) ℝ} (hM : Mᵀ = M) (htr : M.trace = 0)
    (h0 : M ≠ 0) : theta (WMatA n M) ≤ Real.sqrt (3 / 2) := WMatF_theta_le asdFrame hn hM htr h0

theorem JKz_orth : ∀ (a b : Fin 3), ∑ i, ∑ k, Jz a k i * Kz b k i = 0 := by decide
theorem JKz_cyc : ∀ (a b : Fin 3) (p q r t : Fin 4),
    (Jz a q p * Kz b t r + Jz a r p * Kz b q t + Jz a t p * Kz b r q)
      + (Kz b q p * Jz a t r + Kz b r p * Jz a q t + Kz b t p * Jz a r q) = 0 := by decide

/-- **`Λ⁺ ⊥ Λ⁻`**: the self-dual and anti-self-dual structures are Frobenius-orthogonal. -/
theorem J_K_orth (a b : Fin 3) : ((J a)ᵀ * K b).trace = 0 := by
  simp only [K, Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, J_cast]
  exact_mod_cast JKz_orth a b

/-- **The mixed cyclic sum of a self-dual and an anti-self-dual structure vanishes.** -/
theorem J_K_cyc (a b : Fin 3) (p q r t : Fin 4) :
    cyc2 (J a) (K b) p q r t + cyc2 (K b) (J a) p q r t = 0 := by
  simp only [cyc2, K, J_cast]; exact_mod_cast JKz_cyc a b p q r t

end HamiltonsCubic.CP2Real
