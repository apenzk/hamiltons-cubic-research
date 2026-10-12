import Mathlib

set_option linter.style.longLine false

/-!
# `𝔰𝔭𝔦𝔫(7)` fixes no nonzero vector of `ℝ⁸`

[graded-half.md](../../../findings/graded-half.md), Lemma L159's `n = 8` case: an invariant line or `7`-plane would put
`𝔰𝔭𝔦𝔫(7)` inside the stabiliser `𝔰𝔬(7)` of a vector, *"while `𝔰𝔭𝔦𝔫(7)` ... fixes no nonzero vector"*.

- `Lz1`, …, `Lz7`, `Lz`: the left multiplications by the imaginary octonion units `e₁, …, e₇` on `𝕆 = ℝ⁸`, as integer
  matrices generated from the rule `e_a e_b = e_c` for the cyclic triples `(i, i+1, i+3)` mod `7`;
- **`Lz_clifford`**, `Lz_skew`, `Lz_unit`: the Clifford relations `L_i L_j + L_j L_i = −2δ_ij`, skewness, and
  `L_i e₀ = e_i`, all by `decide` in the kernel, so `ℝ⁸` is the octonionic Clifford module;
- `L`, **`spin7`**, **`spin7_skew`**: `𝔰𝔭𝔦𝔫(7)`, spanned by the commutators `[L_i, L_j]`, lies in `𝔰𝔬(8)`;
- `Xz_sq`, **`spin7_no_fixed`**: `[L₁, L₂] ∈ 𝔰𝔭𝔦𝔫(7)` squares to `−4`, so no nonzero vector is fixed by all of
  `𝔰𝔭𝔦𝔫(7)`.
-/

namespace HamiltonsCubic.Spin7

/-! ## The octonionic left multiplications -/

def Lz1 : Matrix (Fin 8) (Fin 8) ℤ := !![0, -1, 0, 0, 0, 0, 0, 0; 1, 0, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, -1, 0, 0, 0; 0, 0, 0, 0, 0, 0, 0, -1; 0, 0, 1, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, -1, 0; 0, 0, 0, 0, 0, 1, 0, 0; 0, 0, 0, 1, 0, 0, 0, 0]
def Lz2 : Matrix (Fin 8) (Fin 8) ℤ := !![0, 0, -1, 0, 0, 0, 0, 0; 0, 0, 0, 0, 1, 0, 0, 0; 1, 0, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, -1, 0, 0; 0, -1, 0, 0, 0, 0, 0, 0; 0, 0, 0, 1, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, 0, -1; 0, 0, 0, 0, 0, 0, 1, 0]
def Lz3 : Matrix (Fin 8) (Fin 8) ℤ := !![0, 0, 0, -1, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, 0, 1; 0, 0, 0, 0, 0, 1, 0, 0; 1, 0, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, -1, 0; 0, 0, -1, 0, 0, 0, 0, 0; 0, 0, 0, 0, 1, 0, 0, 0; 0, -1, 0, 0, 0, 0, 0, 0]
def Lz4 : Matrix (Fin 8) (Fin 8) ℤ := !![0, 0, 0, 0, -1, 0, 0, 0; 0, 0, -1, 0, 0, 0, 0, 0; 0, 1, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, 1, 0; 1, 0, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, 0, -1; 0, 0, 0, -1, 0, 0, 0, 0; 0, 0, 0, 0, 0, 1, 0, 0]
def Lz5 : Matrix (Fin 8) (Fin 8) ℤ := !![0, 0, 0, 0, 0, -1, 0, 0; 0, 0, 0, 0, 0, 0, 1, 0; 0, 0, 0, -1, 0, 0, 0, 0; 0, 0, 1, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, 0, 1; 1, 0, 0, 0, 0, 0, 0, 0; 0, -1, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, -1, 0, 0, 0]
def Lz6 : Matrix (Fin 8) (Fin 8) ℤ := !![0, 0, 0, 0, 0, 0, -1, 0; 0, 0, 0, 0, 0, -1, 0, 0; 0, 0, 0, 0, 0, 0, 0, 1; 0, 0, 0, 0, -1, 0, 0, 0; 0, 0, 0, 1, 0, 0, 0, 0; 0, 1, 0, 0, 0, 0, 0, 0; 1, 0, 0, 0, 0, 0, 0, 0; 0, 0, -1, 0, 0, 0, 0, 0]
def Lz7 : Matrix (Fin 8) (Fin 8) ℤ := !![0, 0, 0, 0, 0, 0, 0, -1; 0, 0, 0, -1, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0, -1, 0; 0, 1, 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, -1, 0, 0; 0, 0, 0, 0, 1, 0, 0, 0; 0, 0, 1, 0, 0, 0, 0, 0; 1, 0, 0, 0, 0, 0, 0, 0]

/-- The seven left multiplications by imaginary octonion units, as integer matrices. -/
def Lz : Fin 7 → Matrix (Fin 8) (Fin 8) ℤ := ![Lz1, Lz2, Lz3, Lz4, Lz5, Lz6, Lz7]

/-- **The Clifford relations** `L_i L_j + L_j L_i = −2 δ_ij`. -/
theorem Lz_clifford : ∀ i j : Fin 7, Lz i * Lz j + Lz j * Lz i = if i = j then -2 • (1 : Matrix (Fin 8) (Fin 8) ℤ) else 0 := by
  intro i j; fin_cases i <;> fin_cases j <;> decide

/-- Each `L_i` is skew. -/
theorem Lz_skew : ∀ i : Fin 7, (Lz i).transpose = -Lz i := by
  intro i; fin_cases i <;> decide

/-- `L_i` sends the unit `e_0` to `e_{i+1}`: these are left multiplications on `𝕆 = ℝ⁸`. -/
theorem Lz_unit : ∀ i : Fin 7, ∀ r : Fin 8, Lz i r 0 = if r = i.succ then 1 else 0 := by
  intro i r; fin_cases i <;> fin_cases r <;> decide

/-- The commutator `[L_1, L_2]` squares to `−4`. -/
theorem Xz_sq : (Lz 0 * Lz 1 - Lz 1 * Lz 0) * (Lz 0 * Lz 1 - Lz 1 * Lz 0) = -4 • (1 : Matrix (Fin 8) (Fin 8) ℤ) := by
  decide

/-! ## `𝔰𝔭𝔦𝔫(7) ⊂ 𝔰𝔬(8)` -/

/-- The left multiplications over `ℝ`. -/
def L (i : Fin 7) : Matrix (Fin 8) (Fin 8) ℝ := (Int.castRingHom ℝ).mapMatrix (Lz i)

/-- **`𝔰𝔭𝔦𝔫(7)`**, spanned by the commutators `[L_i, L_j]` of the octonionic Clifford module. -/
noncomputable def spin7 : Submodule ℝ (Matrix (Fin 8) (Fin 8) ℝ) :=
  Submodule.span ℝ (Set.range fun p : Fin 7 × Fin 7 => L p.1 * L p.2 - L p.2 * L p.1)

theorem L_transpose (i : Fin 7) : (L i).transpose = -L i := by
  unfold L
  rw [RingHom.mapMatrix_apply, ← Matrix.transpose_map, Lz_skew, Matrix.map_neg]
  intro a; simp

/-- **`𝔰𝔭𝔦𝔫(7)` lies in `𝔰𝔬(8)`.** -/
theorem spin7_skew {X : Matrix (Fin 8) (Fin 8) ℝ} (hX : X ∈ spin7) : X.transpose = -X := by
  induction hX using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨⟨a, b⟩, rfl⟩ := hx
    simp only [Matrix.transpose_sub, Matrix.transpose_mul, L_transpose, neg_mul_neg]; abel
  | zero => simp
  | add x y _ _ hx hy => rw [Matrix.transpose_add, hx, hy, neg_add]
  | smul c x _ hx => rw [Matrix.transpose_smul, hx, smul_neg]

/-- **`𝔰𝔭𝔦𝔫(7)` fixes no nonzero vector of `ℝ⁸`**: `[L_1, L_2] ∈ 𝔰𝔭𝔦𝔫(7)` squares to `−4`, so it kills no nonzero
vector. -/
theorem spin7_no_fixed (v : Fin 8 → ℝ) (hv : ∀ X ∈ spin7, X.mulVec v = 0) : v = 0 := by
  have hX : L 0 * L 1 - L 1 * L 0 ∈ spin7 := Submodule.subset_span ⟨(0, 1), rfl⟩
  have hsq : (L 0 * L 1 - L 1 * L 0) * (L 0 * L 1 - L 1 * L 0) = -4 • (1 : Matrix (Fin 8) (Fin 8) ℝ) := by
    have := congrArg (Int.castRingHom ℝ).mapMatrix Xz_sq
    rw [map_mul, map_sub, map_mul, map_mul, map_zsmul, map_one] at this
    exact this
  have h := congrArg (fun w => (L 0 * L 1 - L 1 * L 0).mulVec w) (hv _ hX)
  simp only [Matrix.mulVec_mulVec, hsq, Matrix.mulVec_zero] at h
  rw [Matrix.smul_mulVec, Matrix.one_mulVec] at h
  have : (4 : ℤ) • v = 0 := by rw [← neg_eq_zero, ← neg_smul]; exact h
  have h4 : (4 : ℝ) • v = 0 := by exact_mod_cast this
  exact (smul_eq_zero.mp h4).resolve_left (by norm_num)

end HamiltonsCubic.Spin7
