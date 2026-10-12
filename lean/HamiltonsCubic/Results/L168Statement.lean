import Mathlib

set_option linter.style.longLine false

/-!
# L168, the two pinned moments of `F_u`, and what they check in L21's table

The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md):

> **Statement.** Let `T` be the symmetric trilinear form with `T(W,W,W) = P(W)`, so that
> `⟨F_u h, k⟩ = T(u,h,k)` exactly. Then for every `u ∈ 𝒲_n`, the first identity at `n ≥ 5`, the
> second and third at `n ≥ 6`, where the inherited constant holds,
> $$\operatorname{tr}(F_u) = 0,\qquad \operatorname{tr}(F_u^2) = \frac{(n-1)(2n-1)}4\,‖u‖^2,\qquad
> ‖T‖^2 = \frac{(n-1)(2n-1)}4·\dim 𝒲_n .$$
>
> **And the table of L21 satisfies both, identically in `m`**, the first blockwise, the second after
> weighting by `dim V_λ`.

> **Proof of the identities.** … So `u ↦ tr(F_u)` is an `O(n)`-invariant **linear** functional on
> `𝒲_n`, which is irreducible and nontrivial, hence zero; and `u ↦ tr(F_u²)` is an `O(n)`-invariant
> **quadratic** form on the same space, which is absolutely irreducible, hence a multiple of `‖u‖²`.
> **The multiple is Lemma L161's Killing constant**, `tr(L_W²) = (n−1)(2n−1)/4` at unit `W` with
> `L_W = F_W`. Summing `tr(F_{u_a}²) = ∑_{b,c} T(u_a,u_b,u_c)²` over an orthonormal basis gives
> `‖T‖²` on the left and `((n−1)(2n−1)/4)·dim 𝒲_n` on the right. `□`

> **WHAT THIS NARROWS, AND THE DEBT STANDS WITH A WITNESS.** … both audits built the witness: the
> alternative rational spectrum `{1, ½, −3/2}` on the trivial row, `{1, ½, −½, −1}` on the vector,
> `{2/3, −1/3, −1/3}` on `Λ²` and zero elsewhere reproduces `M₁ = 0` and `M₂ = (m+3)(2m+7)/6`
> identically in `m`. *So the `m`-freeness debt stands, now with a falsifier exhibited rather than
> assumed absent.*

## What this file types

**The third identity, from the second, in full.** `normTsq_of_second_moment` is the record's own
closing inference, written over an arbitrary fully symmetric trilinear coefficient array: if
`tr(F_u²) = c₀‖u‖²` for every `u`, then `‖T‖² = c₀ · dim`. The supporting apparatus is proved with
it, `Fmat_symm`, `inner_F_eq_T` (that `⟨F_u h, k⟩ = T(u,h,k)` holds on the nose for the array
construction), `trace_Fsq_eq_sum_sq`, and `Fmat_basis`. This is the closed form
[I54](../../../plan.md) asked for, and it is derived here from irreducibility plus one evaluation
exactly as the record derives it.

**The whole of the L21 check.** `second_moment_collapse` is the weighted collapse as a polynomial
identity in `m`; `at_n_twelve` its value; `first_moments_blockwise` the four separately-vanishing
block traces; `third_moment_at_twelve` the third moment's value; `dimW_values` the Weyl-space
dimension at `n = 6` and `n = 12`; `table_fails_at_m_two` the recorded `86` against `84`.

**The falsifier.** `alternative_spectrum_reproduces_both`, the alternative rational spectrum both
audits built returns `M₁ = 0` and `M₂ = (m+3)(2m+7)/6` identically in `m`, so the two moment
identities do not pin the table's eigenvalues.

## What is NOT typed here

**THE TWO MOMENT IDENTITIES THEMSELVES ARE NOT STATED.** `tr(F_u) = 0` and
`tr(F_u²) = ((n−1)(2n−1)/4)‖u‖²` are claims about the *Weyl* cubic on `𝒲_n` as an `O(n)`
representation, and stating them needs `𝒲_n`, algebraic curvature tensors with vanishing Ricci,
together with `B(X,Y) = ½(XY+YX) + X#Y` and the `O(n)` action, none of which this file builds. So
this file carries no `sorry`, and it is **not** a complete typing of L168: the first two displays are
absent, and what is typed is the third display's derivation from the second, plus the arithmetic of
the check. In particular:

* **the Schur steps**, `𝒲_n` irreducible and nontrivial, hence no invariant linear functional;
  absolutely irreducible, hence the invariant quadratic form is a multiple of `‖u‖²`;
* **L161's Killing constant** `tr(L_W²) = (n−1)(2n−1)/4`, the inherited value;
* **that `𝒲_n` is closed under `B(u,·)`**, which the record names as the real step the display
  presumes;
* **that `F_u = ⊕_λ F_λ ⊗ Id_{V_λ}`** and that the tabled numbers are the spectra of the `F_λ`.
-/

namespace HamiltonsCubic.L168Statement

open Finset

/-! ## The `T`-to-`F` correspondence, and the third identity from the second -/

variable {N : ℕ}

/-- A fully symmetric trilinear coefficient array, the record's `T`, in an orthonormal basis. -/
def IsSymm3 (t : Fin N → Fin N → Fin N → ℝ) : Prop :=
  (∀ a b c, t a b c = t b a c) ∧ (∀ a b c, t a b c = t a c b)

/-- `T(u,h,k)`. -/
def Tform (t : Fin N → Fin N → Fin N → ℝ) (u h k : Fin N → ℝ) : ℝ :=
  ∑ a, ∑ b, ∑ c, u a * h b * k c * t a b c

/-- `F_u` as a matrix: `(F_u)_{bc} = ∑_a u_a t_{abc}`. -/
def Fmat (t : Fin N → Fin N → Fin N → ℝ) (u : Fin N → ℝ) : Matrix (Fin N) (Fin N) ℝ :=
  Matrix.of fun b c => ∑ a, u a * t a b c

/-- `‖T‖² = ∑_{a,b,c} t_{abc}²`. -/
def normTsq (t : Fin N → Fin N → Fin N → ℝ) : ℝ := ∑ a, ∑ b, ∑ c, (t a b c) ^ 2

/-- `F_u` is symmetric, from the symmetry of `T` in its last two slots. -/
theorem Fmat_symm (t : Fin N → Fin N → Fin N → ℝ) (ht : IsSymm3 t) (u : Fin N → ℝ) (b c : Fin N) :
    Fmat t u b c = Fmat t u c b := by
  simp only [Fmat, Matrix.of_apply]
  exact Finset.sum_congr rfl fun a _ => by rw [ht.2 a b c]

/-- **`⟨F_u h, k⟩ = T(u,h,k)` on the nose**, which is the display the record says holds exactly. -/
theorem inner_F_eq_T (t : Fin N → Fin N → Fin N → ℝ) (u h k : Fin N → ℝ) :
    ∑ c, (∑ b, Fmat t u b c * h b) * k c = Tform t u h k := by
  have lhs_eq : ∑ c, (∑ b, Fmat t u b c * h b) * k c
      = ∑ c, ∑ b, ∑ a, u a * h b * k c * t a b c := by
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun b _ => ?_
    simp only [Fmat, Matrix.of_apply, Finset.sum_mul]
    exact Finset.sum_congr rfl fun a _ => by ring
  rw [lhs_eq, Tform]
  calc ∑ c, ∑ b, ∑ a, u a * h b * k c * t a b c
      = ∑ b, ∑ c, ∑ a, u a * h b * k c * t a b c := Finset.sum_comm
    _ = ∑ b, ∑ a, ∑ c, u a * h b * k c * t a b c :=
        Finset.sum_congr rfl (fun b _ => Finset.sum_comm)
    _ = ∑ a, ∑ b, ∑ c, u a * h b * k c * t a b c := Finset.sum_comm

/-- `tr(F_u²) = ∑_{b,c} (F_u)_{bc}²`. -/
theorem trace_Fsq_eq_sum_sq (t : Fin N → Fin N → Fin N → ℝ) (ht : IsSymm3 t) (u : Fin N → ℝ) :
    Matrix.trace (Fmat t u * Fmat t u) = ∑ b, ∑ c, (Fmat t u b c) ^ 2 := by
  simp only [Matrix.trace, Matrix.diag_apply, Matrix.mul_apply]
  refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => ?_
  rw [Fmat_symm t ht u c b]; ring

/-- Evaluated at a basis vector, `F` returns the array's slice. -/
theorem Fmat_basis (t : Fin N → Fin N → Fin N → ℝ) (a b c : Fin N) :
    Fmat t (Pi.single a 1) b c = t a b c := by
  simp only [Fmat, Matrix.of_apply]
  rw [Finset.sum_eq_single a]
  · simp
  · intro b' _ hb'
    simp [Pi.single_apply, hb']
  · intro hcon
    exact absurd (Finset.mem_univ a) hcon

/-- **The third identity, from the second.** If `tr(F_u²) = c₀‖u‖²` for every `u`, then
`‖T‖² = c₀ · dim`, the record's closing inference, and the closed form I54 asked for. -/
theorem normTsq_of_second_moment (t : Fin N → Fin N → Fin N → ℝ) (ht : IsSymm3 t) (c₀ : ℝ)
    (hsecond : ∀ u : Fin N → ℝ, Matrix.trace (Fmat t u * Fmat t u) = c₀ * ∑ a, (u a) ^ 2) :
    normTsq t = c₀ * (N : ℝ) := by
  have hslice : ∀ a : Fin N, ∑ b, ∑ c, (t a b c) ^ 2 = c₀ := by
    intro a
    have h := hsecond (Pi.single a (1 : ℝ))
    rw [trace_Fsq_eq_sum_sq t ht] at h
    simp only [Fmat_basis] at h
    rw [h]
    have hone : (∑ x : Fin N, (Pi.single a (1 : ℝ) x) ^ 2) = (1 : ℝ) := by
      rw [Finset.sum_eq_single a]
      · simp
      · intro b' _ hb'; simp [Pi.single_apply, hb']
      · intro hcon; exact absurd (Finset.mem_univ a) hcon
    rw [hone, mul_one]
  rw [normTsq]
  have hsum : ∑ a : Fin N, ∑ b, ∑ c, (t a b c) ^ 2 = ∑ _a : Fin N, c₀ :=
    Finset.sum_congr rfl (fun a _ => hslice a)
  rw [hsum, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mul_comm]

/-! ## The check on L21's table -/

/-- **The weighted second-moment collapse**, as a polynomial identity in `m`: the four blocks'
`tr(F_λ²)/θ*²` weighted by `dim V_λ`. -/
theorem second_moment_collapse (m : ℚ) :
    4 * 1 + 2 * m + (1 / 6) * (m * (m - 1) / 2) + (1 / 2) * ((m + 2) * (m - 1) / 2)
      = (2 * m + 7) * (m + 3) / 6 := by
  ring

/-- And with `n = m + 4`, multiplying by `θ*² = 3/2` returns `(n−1)(2n−1)/4`. -/
theorem second_moment_in_n (n : ℚ) :
    (3 / 2) * ((2 * (n - 4) + 7) * ((n - 4) + 3) / 6) = (n - 1) * (2 * n - 1) / 4 := by
  ring

/-- **At `n = 12` both sides read `253/4`.** -/
theorem at_n_twelve : ((12 : ℚ) - 1) * (2 * 12 - 1) / 4 = 253 / 4 := by norm_num

/-- **The first moment, blockwise**: each of the four nonzero blocks is separately traceless, which
is more than the identity demands. -/
theorem first_moments_blockwise :
    ((-2 : ℚ) + (-1) + 1 + 1 + 1 = 0) ∧ ((-2 : ℚ) + 2 = 0)
      ∧ ((-1 / 3 : ℚ) + 1 / 3 = 0) ∧ ((-1 : ℚ) + 1 = 0) := by
  norm_num

/-- **The third moment carries no check**: the table returns `θ*³(2n²−15n+1)/36`, which at `n = 12`
is `109/36`; the invariant cubics form a two-dimensional space, so the value defines the two
coefficients rather than testing the table. -/
theorem third_moment_at_twelve : (2 * (12 : ℚ) ^ 2 - 15 * 12 + 1) / 36 = 109 / 36 := by norm_num

/-! ## The Weyl space's dimension, and where the table's range fails -/

/-- `dim 𝒲_n = n(n+1)(n+2)(n−3)/12`. -/
def dimW (n : ℚ) : ℚ := n * (n + 1) * (n + 2) * (n - 3) / 12

theorem dimW_values : dimW 4 = 10 ∧ dimW 6 = 84 ∧ dimW 12 = 1638 := by
  refine ⟨by norm_num [dimW], by norm_num [dimW], by norm_num [dimW]⟩

/-- **The table's range is `n ≥ 7`, not `n ≥ 6`.** At `m = 2` the six rows total `86` against
`dim 𝒲_6 = 84`. The identities themselves are untouched; it is the check that is vacuous there. -/
theorem table_fails_at_m_two : dimW 6 = 84 ∧ (86 : ℚ) ≠ dimW 6 := by
  refine ⟨by norm_num [dimW], ?_⟩
  rw [dimW]; norm_num

/-! ## The falsifier: the moments do not pin the eigenvalues -/

/-- **Both audits' witness.** The alternative rational spectrum, `{1, ½, −3/2}` on the trivial row,
`{1, ½, −½, −1}` on the vector, `{2/3, −1/3, −1/3}` on `Λ²` and zero elsewhere, reproduces `M₁ = 0`
and `M₂ = (m+3)(2m+7)/6` identically in `m`. So the `m`-freeness debt stands with a falsifier
exhibited rather than assumed absent. -/
theorem alternative_spectrum_reproduces_both (m : ℚ) :
    (1 * ((1 : ℚ) + 1 / 2 + (-3 / 2)) + m * (1 + 1 / 2 + (-1 / 2) + (-1))
        + (m * (m - 1) / 2) * (2 / 3 + (-1 / 3) + (-1 / 3))
        + ((m + 2) * (m - 1) / 2) * 0 = 0)
      ∧ (1 * ((1 : ℚ) ^ 2 + (1 / 2) ^ 2 + (-3 / 2) ^ 2)
          + m * (1 ^ 2 + (1 / 2) ^ 2 + (-1 / 2) ^ 2 + (-1) ^ 2)
          + (m * (m - 1) / 2) * ((2 / 3) ^ 2 + (-1 / 3) ^ 2 + (-1 / 3) ^ 2)
          + ((m + 2) * (m - 1) / 2) * 0
        = (m + 3) * (2 * m + 7) / 6) := by
  constructor <;> ring

/-- And it differs from the tabled spectrum, which is what makes it a falsifier: the trivial row's
tabled second moment is `4`, the alternative's is `7/2`. -/
theorem falsifier_differs : (1 : ℚ) ^ 2 + (1 / 2) ^ 2 + (-3 / 2) ^ 2 = 7 / 2 ∧ (7 : ℚ) / 2 ≠ 4 := by
  norm_num

/-! ## A witness, so the abstract theorem is not vacuous -/

/-- The hypotheses of `normTsq_of_second_moment` are satisfiable: the zero array, with `c₀ = 0`. -/
example : IsSymm3 (fun _ _ _ => (0 : ℝ) : Fin 3 → Fin 3 → Fin 3 → ℝ)
    ∧ normTsq (fun _ _ _ => (0 : ℝ) : Fin 3 → Fin 3 → Fin 3 → ℝ) = 0 * (3 : ℝ) := by
  refine ⟨⟨fun _ _ _ => rfl, fun _ _ _ => rfl⟩, ?_⟩
  simp [normTsq]

end HamiltonsCubic.L168Statement
