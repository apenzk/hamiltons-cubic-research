import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# L70, the deficiency identity, and what saturates it

## The record's statement, verbatim

[bounds.md](../../../findings/bounds.md)'s *Lemma L70, the deficiency identity, and what
saturates it*:

> **The bound is one step of an identity, and keeping the step gives equality.** The bound
> replaces every product $\lambda_a\lambda_b$ by its minimum $\lambda_{\min}\lambda_{\max}$ over
> the spectrum and spends the fixed mass $\sum c_{vab}^2=2(n-2)$. Keeping the difference instead,
> **at every critical point and for every unit $v\in E_{\min}(W)$**,
> $$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert},\qquad D(v)=\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2\ \ge\ 0,$$
> each summand being a nonnegative weight against a nonnegative factor. **The sign needs only
> $\lambda_{\min}\le0\le\lambda_{\max}$**, $\lambda_{\min}\lambda_{\max}$ is then the corner
> minimum of $xy$ on $[\lambda_{\min},\lambda_{\max}]^2$ [...] **And it needs
> $\lVert W\rVert=1$** [...]
> **So equality holds exactly when $\mathrm{ad}(v)$ is supported on
> $E_{\min}\otimes E_{\max}$**, every one of its $2(n-2)$ units of bracket mass landing on a pair
> with one index at $\lambda_{\min}$ and the other at $\lambda_{\max}$, for every unit
> $v\in E_{\min}$.

and, from the same block, the two per-index relations the identity consumes:

> $$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),$$
> each holding for every $k$. [...] **(A) AND (B) ARE PUBLISHED** [...]
> [Böhm–Wilking](../../../references/boehm-wilking-2008-space-forms/notes.md) **Lemma 2.1** [...]
> giving $I\#I=(n-2)I$, relation (A) [...]; (C) is criticality.

and the preceding bound it is the exact form of,

> $$\theta\le\lambda_{\min}+(n-2)\lambda_{\max}.$$

## How this is typed, and against what

Everything below is stated for a finite index type `ι` carrying the eigenvalue list `lam` and the
row weights `T a b = c_{vab}^2`, with the two per-index relations **(A)** and **(C)** as named
hypotheses. That placement is deliberate:

* **(A)** is Böhm–Wilking 2008, Lemma 2.1, a published, external input, which is the one thing
  the brief allows into a binder;
* **(C)** is the criticality equation `Q(W) = θW` contracted at the row `v`. It is an *input* to
  L70 and not L70's conclusion; it is carried as a hypothesis because the structure constants
  `c_{vab}` have no Lean layer here, so the contraction cannot be performed inside Lean.

`D`, the deficiency, is **defined** here exactly as the record defines it, and every conclusion
below (the identity, the sign, the bound, the equality characterisation), is *derived*, with no
`sorry`.

## What is NOT typed here

**The geometry that produces `lam` and `T` from a critical Weyl tensor.** The eigenvalues of `W`
on `Λ²`, the eigenspaces `E_min`/`E_max`, the bracket structure constants
`c_{vab}=\langle[v,v_a],v_b\rangle`, and the derivation of (A) and (C) from `IsWeyl` and
`IsCritical` all need `ad`, an eigenbasis of `Λ²` and the Killing form, none of which
[WeylReal.lean](../Base/WeylReal.lean) carries (it has `IsWeyl`, `Qop`, `IsCritical`, `Pcubic`,
`theta`, and no spectral theory). So `lam`, `T`, `lmin`, `lmax` and `n` are free here.

**The dimension theorem**: *"Saturation forces `dim E_min ≥ n/2` and `dim E_max ≥ (n-2)/2`"*,
which consumes [L31](../../../findings/stratum-two-negative.md)'s pair cap. It is about
eigenspace dimensions, which are not in scope for the same reason.

**The Lie-theoretic reduction on L23's two-eigenvalue family** (*saturation ⟺ symmetric pair*),
which needs `Π_h` and `[𝔪,𝔪]`.

**The Hilbert–Schmidt rewriting** below the block, the record itself records that it *"carries no
new information"*, being the same data under `2ab = a²+b²-(a-b)²`.

## Convention

`‖W‖ = 1` is where the record's `θ = P(W)/‖W‖³` makes the identity's two sides homogeneous of the
same degree; here that enters only as the assertion that `lam`, `T` and `θ` are read at unit
norm, since no norm is formed below. The `Λ²` pairing carrying the `½`
([WeylReal.inner2](../Base/WeylReal.lean)) is what fixes `∑ T = 2(n-2)` on **ordered** pairs, and
that is the convention (A) is written in here.
-/

namespace HamiltonsCubic.L70Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-- **The deficiency `D(v)`**, exactly as the record defines it:
`D = ½ ∑_{a,b} (λ_a λ_b − λ_min λ_max) T_{ab}` with `T_{ab} = c_{vab}²`. -/
noncomputable def defic (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax : ℝ) : ℝ :=
  (1 / 2) * ∑ a : ι, ∑ b : ι, (lam a * lam b - lmin * lmax) * T a b

/-! ## The identity

Two relations in, one identity out. -/

/-- **`D` in closed form**: the two marginals collapse the double sum to
`D = λ_min(θ − λ_min) − (n−2) λ_min λ_max`. -/
theorem defic_closed (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax n th : ℝ)
    (hA : ∑ a : ι, ∑ b : ι, T a b = 2 * (n - 2))
    (hC : ∑ a : ι, ∑ b : ι, lam a * lam b * T a b = 2 * lmin * (th - lmin)) :
    defic lam T lmin lmax = lmin * (th - lmin) - (n - 2) * (lmin * lmax) := by
  have hsplit : ∑ a : ι, ∑ b : ι, (lam a * lam b - lmin * lmax) * T a b
      = (∑ a : ι, ∑ b : ι, lam a * lam b * T a b)
        - lmin * lmax * ∑ a : ι, ∑ b : ι, T a b := by
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  unfold defic
  rw [hsplit, hA, hC]
  ring

/-- **THE DEFICIENCY IDENTITY.** At a critical point, for every unit `v ∈ E_min`, with
`λ_min < 0`,
`θ = λ_min + (n−2) λ_max − D(v)/|λ_min|`. -/
theorem theta_eq_bound_sub_defic (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax n th : ℝ)
    (hmin : lmin < 0)
    (hA : ∑ a : ι, ∑ b : ι, T a b = 2 * (n - 2))
    (hC : ∑ a : ι, ∑ b : ι, lam a * lam b * T a b = 2 * lmin * (th - lmin)) :
    th = lmin + (n - 2) * lmax - defic lam T lmin lmax / |lmin| := by
  have habs : |lmin| = -lmin := abs_of_neg hmin
  have hne : lmin ≠ 0 := ne_of_lt hmin
  rw [defic_closed lam T lmin lmax n th hA hC, habs]
  field_simp
  ring

/-! ## The sign

*"The sign needs only `λ_min ≤ 0 ≤ λ_max`"*, the corner minimum of `xy` on
`[λ_min, λ_max]²`. -/

/-- **The corner minimum.** With `λ_min ≤ 0 ≤ λ_max`, `λ_min λ_max` is the minimum of `xy` over
the square, which is the termwise step `D ≥ 0` rests on. -/
theorem corner_min {lmin lmax x y : ℝ} (hmin : lmin ≤ 0) (hmax : 0 ≤ lmax)
    (hx : lmin ≤ x) (hx' : x ≤ lmax) (hy : lmin ≤ y) (hy' : y ≤ lmax) :
    lmin * lmax ≤ x * y := by
  rcases le_total 0 x with hx0 | hx0
  · rcases le_total 0 y with hy0 | hy0 <;> nlinarith
  · rcases le_total 0 y with hy0 | hy0 <;> nlinarith

/-- **`D ≥ 0`**, each summand a nonnegative weight against a nonnegative factor. -/
theorem defic_nonneg (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax : ℝ)
    (hmin : lmin ≤ 0) (hmax : 0 ≤ lmax)
    (hT : ∀ a b, 0 ≤ T a b) (hlo : ∀ a, lmin ≤ lam a) (hhi : ∀ a, lam a ≤ lmax) :
    0 ≤ defic lam T lmin lmax := by
  unfold defic
  have : 0 ≤ ∑ a : ι, ∑ b : ι, (lam a * lam b - lmin * lmax) * T a b := by
    refine Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => ?_
    exact mul_nonneg (by
      have := corner_min hmin hmax (hlo a) (hhi a) (hlo b) (hhi b); linarith) (hT a b)
  linarith

/-- **THE BOUND, as the lossy half of the identity**: `θ ≤ λ_min + (n−2) λ_max`. -/
theorem theta_le (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax n th : ℝ)
    (hmin : lmin < 0) (hmax : 0 ≤ lmax)
    (hT : ∀ a b, 0 ≤ T a b) (hlo : ∀ a, lmin ≤ lam a) (hhi : ∀ a, lam a ≤ lmax)
    (hA : ∑ a : ι, ∑ b : ι, T a b = 2 * (n - 2))
    (hC : ∑ a : ι, ∑ b : ι, lam a * lam b * T a b = 2 * lmin * (th - lmin)) :
    th ≤ lmin + (n - 2) * lmax := by
  have hid := theta_eq_bound_sub_defic lam T lmin lmax n th hmin hA hC
  have hD := defic_nonneg lam T lmin lmax hmin.le hmax hT hlo hhi
  have habs : (0:ℝ) < |lmin| := abs_pos.mpr (ne_of_lt hmin)
  have : 0 ≤ defic lam T lmin lmax / |lmin| := div_nonneg hD habs.le
  linarith

/-! ## The equality case

*"Equality holds exactly when `ad(v)` is supported on `E_min ⊗ E_max`"*, every unit of bracket
mass on a pair with one index at `λ_min` and the other at `λ_max`. -/

/-- **The corner minimum is attained only at the corners**, when the signs are strict: for
`λ_min < 0 < λ_max` and `x, y` in the range, `xy = λ_min λ_max` forces `{x,y} = {λ_min, λ_max}`. -/
theorem corner_min_eq_iff {lmin lmax x y : ℝ} (hmin : lmin < 0) (hmax : 0 < lmax)
    (hx : lmin ≤ x) (hx' : x ≤ lmax) (hy : lmin ≤ y) (hy' : y ≤ lmax) :
    x * y = lmin * lmax ↔ (x = lmin ∧ y = lmax) ∨ (x = lmax ∧ y = lmin) := by
  constructor
  · intro h
    rcases le_total 0 x with hx0 | hx0
    · -- `x ≥ 0`, so `y < 0` (the product is negative), and then `x = lmax`, `y = lmin`.
      have hxpos : 0 < x := by
        rcases eq_or_lt_of_le hx0 with h0 | h0
        · exfalso; nlinarith
        · exact h0
      have hy0 : y < 0 := by nlinarith
      refine Or.inr ⟨?_, ?_⟩ <;> nlinarith
    · rcases eq_or_lt_of_le hx0 with h0 | h0
      · exfalso; nlinarith
      · have hy0 : 0 < y := by nlinarith
        refine Or.inl ⟨?_, ?_⟩ <;> nlinarith
  · rintro (⟨h1, h2⟩ | ⟨h1, h2⟩) <;> subst h1 <;> subst h2 <;> ring

/-- **SATURATION IS SUPPORT ON `E_min ⊗ E_max`.** With strict signs, `D(v) = 0` holds exactly
when every pair `(a,b)` carrying bracket mass has one index at `λ_min` and the other at
`λ_max`. -/
theorem defic_eq_zero_iff (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax : ℝ)
    (hmin : lmin < 0) (hmax : 0 < lmax)
    (hT : ∀ a b, 0 ≤ T a b) (hlo : ∀ a, lmin ≤ lam a) (hhi : ∀ a, lam a ≤ lmax) :
    defic lam T lmin lmax = 0 ↔
      ∀ a b, T a b ≠ 0 →
        (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin) := by
  have hterm : ∀ a b : ι, 0 ≤ (lam a * lam b - lmin * lmax) * T a b := fun a b =>
    mul_nonneg (by have := corner_min hmin.le hmax.le (hlo a) (hhi a) (hlo b) (hhi b); linarith)
      (hT a b)
  constructor
  · intro h a b hab
    have hzero : ∑ a : ι, ∑ b : ι, (lam a * lam b - lmin * lmax) * T a b = 0 := by
      unfold defic at h; linarith
    have houter : ∀ a ∈ (Finset.univ : Finset ι),
        ∑ b : ι, (lam a * lam b - lmin * lmax) * T a b = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg
        (fun a _ => Finset.sum_nonneg fun b _ => hterm a b)).mp hzero
    have hinner := (Finset.sum_eq_zero_iff_of_nonneg
      (fun b _ => hterm a b)).mp (houter a (Finset.mem_univ a)) b (Finset.mem_univ b)
    have : lam a * lam b - lmin * lmax = 0 := by
      rcases mul_eq_zero.mp hinner with h1 | h2
      · exact h1
      · exact absurd h2 hab
    exact (corner_min_eq_iff hmin hmax (hlo a) (hhi a) (hlo b) (hhi b)).mp (by linarith)
  · intro h
    unfold defic
    have : ∑ a : ι, ∑ b : ι, (lam a * lam b - lmin * lmax) * T a b = 0 := by
      refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ => ?_
      by_cases hab : T a b = 0
      · rw [hab]; ring
      · rcases h a b hab with ⟨h1, h2⟩ | ⟨h1, h2⟩ <;> rw [h1, h2] <;> ring
    rw [this]; ring

/-- **The identity is an equality exactly at saturation**, which is the shape a consumer reads:
`θ = λ_min + (n−2)λ_max` iff `ad(v)` is supported on `E_min ⊗ E_max`. -/
theorem theta_eq_bound_iff (lam : ι → ℝ) (T : ι → ι → ℝ) (lmin lmax n th : ℝ)
    (hmin : lmin < 0) (hmax : 0 < lmax)
    (hT : ∀ a b, 0 ≤ T a b) (hlo : ∀ a, lmin ≤ lam a) (hhi : ∀ a, lam a ≤ lmax)
    (hA : ∑ a : ι, ∑ b : ι, T a b = 2 * (n - 2))
    (hC : ∑ a : ι, ∑ b : ι, lam a * lam b * T a b = 2 * lmin * (th - lmin)) :
    th = lmin + (n - 2) * lmax ↔
      ∀ a b, T a b ≠ 0 →
        (lam a = lmin ∧ lam b = lmax) ∨ (lam a = lmax ∧ lam b = lmin) := by
  rw [← defic_eq_zero_iff lam T lmin lmax hmin hmax hT hlo hhi]
  have hid := theta_eq_bound_sub_defic lam T lmin lmax n th hmin hA hC
  have habs : (0:ℝ) < |lmin| := abs_pos.mpr (ne_of_lt hmin)
  constructor
  · intro h
    have h0 : defic lam T lmin lmax / |lmin| = 0 := by linarith
    rcases div_eq_zero_iff.mp h0 with h1 | h2
    · exact h1
    · exact absurd h2 (ne_of_gt habs)
  · intro h; rw [h] at hid; simpa using hid

/-! ## Where the sign fails, and where it does not

The record's two boundary readings, both typed. -/

/-- **On an all-negative spectrum the termwise step fails**, the block's own counterexample with
the exact witness `(-3,-2,-1)` in place of decimals: the true minimum product is `2` against
`λ_min λ_max = 3`. -/
example : (-3 : ℝ) * (-1) = 3 ∧ (-2 : ℝ) * (-1) = 2 ∧ (2:ℝ) < 3 := by norm_num

/-- **On `𝒲ₙ` the strict signs are free**: `tr W = 0` at `W ≠ 0` forces `λ_min < 0 < λ_max`. -/
theorem strict_signs_of_traceless (lam : ι → ℝ) (lmin lmax : ℝ)
    (hlo : ∀ a, lmin ≤ lam a) (hhi : ∀ a, lam a ≤ lmax)
    (htr : ∑ a : ι, lam a = 0) (hne : ∃ a : ι, lam a ≠ 0) :
    lmin < 0 ∧ 0 < lmax := by
  obtain ⟨a₀, ha₀⟩ := hne
  have hmaxpos : 0 < lmax := by
    by_contra hcon
    push Not at hcon
    have hall : ∀ a ∈ (Finset.univ : Finset ι), lam a ≤ 0 := fun a _ => (hhi a).trans hcon
    exact ha₀ ((Finset.sum_eq_zero_iff_of_nonpos hall).mp htr a₀ (Finset.mem_univ a₀))
  have hminneg : lmin < 0 := by
    by_contra hcon
    push Not at hcon
    have hall : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ lam a := fun a _ => hcon.trans (hlo a)
    exact ha₀ ((Finset.sum_eq_zero_iff_of_nonneg hall).mp htr a₀ (Finset.mem_univ a₀))
  exact ⟨hminneg, hmaxpos⟩

/-! ## Non-vacuity

The hypotheses are satisfiable, so nothing above is empty. -/

/-- **A witness at saturation.** Two indices, `lam = (−1, 1)`, all bracket mass on the two mixed
ordered pairs: (A) and (C) hold with `n = 3` and `θ = 0`, `D = 0`, and the bound is an equality. -/
example :
    let lam : Fin 2 → ℝ := ![-1, 1]
    let T : Fin 2 → Fin 2 → ℝ := ![![0, 1], ![1, 0]]
    (∑ a : Fin 2, ∑ b : Fin 2, T a b) = 2 * ((3:ℝ) - 2) ∧
      (∑ a : Fin 2, ∑ b : Fin 2, lam a * lam b * T a b) = 2 * (-1) * ((0:ℝ) - (-1)) ∧
      defic lam T (-1) 1 = 0 := by
  intro lam T
  refine ⟨?_, ?_, ?_⟩ <;>
    simp [lam, T, defic, Fin.sum_univ_two] <;> norm_num

end HamiltonsCubic.L70Statement
