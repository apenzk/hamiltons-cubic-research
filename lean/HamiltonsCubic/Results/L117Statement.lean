import Mathlib

set_option linter.style.longLine false

/-!
# L117, the rigidity theorem: `D(v)=0 ⟹ θ = (n-1)|λ_min|` and `θ ≥ θ₀(n)`

## The record's statement, verbatim

> #### Lemma L117 (a rigidity theorem, corollary of Lemma L70), $D(v)=0\Rightarrow\theta=(n-1)\lvert\lambda_{\min}\rvert$ and $\theta\ge\theta_0(n)$
>
> **The block carried no argument. Here it is, in three steps from material already in this file.**
> *(1)* $D(v)=0$ puts the mass $2(n-2)$ on $E_{\min}\times E_{\max}$, and relation (B) with total
> symmetry gives $(n-2)(M-m)=2m$, so $M=nm/(n-2)$. *(2)* L70's boxed identity then gives
> $\theta=(n-1)m$, **clauses (i) and (ii) are one statement read twice**. *(3)* Summing the chord
> inequality $(\lambda_a+m)(M-\lambda_a)\ge0$ over all $N=\binom n2$ eigenvalues, with
> $\operatorname{tr}W=0$ and $\lVert W\rVert=1$, gives $1\le mMN$ and hence
>
> $$\theta=(n-1)m\ \ge\ \frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n),\qquad\text{equality iff $W$ has two eigenvalues and no kernel.}$$

and Lemma L70's identity, which this one is a corollary of:

> $$\boxed{\;\theta\;=\;\lambda_{\min}+(n-2)\lambda_{\max}\;-\;\frac{D(v)}{\lvert\lambda_{\min}\rvert}\;},\qquad D(v)=\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2\;\ge\;0 .$$

[bounds.md](../../../findings/bounds.md), Lemmas L117 and L70.

## What this file states, and which hypothesis carries what

**Step (3) is proved outright, from nothing but the spectrum.** `chord_bound` is `1 ≤ mMN` from
`tr W = 0`, `‖W‖ = 1` and `-m ≤ λ_a ≤ M`; `chord_equality` is the record's own equality clause,
that saturation forces every eigenvalue to be `-m` or `M`. Neither consumes criticality, `D`, or
anything geometric.

**Steps (1) and (2) enter as two named hypotheses**, and the file is explicit that they are
inputs rather than results proved here:

* `hL70`, Lemma L70's boxed identity read at `D(v) = 0`, i.e. `θ = λ_min + (n-2)λ_max`. It is a
  **separate numbered result** whose corollary this lemma is recorded to be.
* `hB`, relation (B) with total symmetry, `(n-2)(M - m) = 2m`, which is what `D(v) = 0` buys by
  putting the bracket mass `2(n-2)` on `E_min × E_max`.

Everything downstream of those two is proved: the ratio `M = nm/(n-2)`, clause (i)
`θ = (n-1)m`, and clause (ii) `θ ≥ θ₀(n)`.

**The record's own reading is that clauses (i) and (ii) are one statement read twice**, and
`L117` below states them as one conjunction, from one set of hypotheses, for that reason.

The spectrum is indexed by an arbitrary `Fintype ι` of cardinality `N`, with `N = n(n-1)/2` a
hypothesis rather than a construction, so nothing here depends on how `Λ²ℝⁿ` is coordinatised.

## What is NOT typed here

**`D(v)` itself is absent, and so is step (1)'s first half.** `D(v) = ½∑(λ_aλ_b - λ_min λ_max)c²`
needs the structure constants `c_{vab}` of `𝔰𝔬(n)` against an eigenframe of `W`, and relation (B)
needs the pinned system of the row marginals; neither is in `HamiltonsCubic.Base.WeylReal`. So
`hL70` and `hB` stand for the two consequences of `D(v) = 0` that the record derives, and the
derivation of them is what is missing.

**Also absent**: the record's `n = 4` caveat, that `W_{ℂP²}` saturates with three eigenvalues and
is no sphere product, which is a statement about Lemma L71's classification and not about the
inequality proved here.
-/

namespace HamiltonsCubic.L117Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-- **`θ₀(n) = √(2(n-1)(n-2))/n`.** -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-! ## Step (3): the chord inequality, summed -/

/-- **The chord sum, in closed form.** `∑(λ_a + m)(M - λ_a) = mMN - 1` at `tr W = 0`,
`‖W‖ = 1`. -/
theorem chord_sum (lam : ι → ℝ) (m M : ℝ)
    (htr : ∑ a, lam a = 0) (hnorm : ∑ a, lam a ^ 2 = 1) :
    ∑ a, (lam a + m) * (M - lam a) = m * M * (Fintype.card ι : ℝ) - 1 := by
  have hexp : ∑ a, (lam a + m) * (M - lam a)
      = (∑ a, M * lam a) - (∑ a, lam a ^ 2) + (∑ _a : ι, m * M) - (∑ a, m * lam a) := by
    rw [← Finset.sum_sub_distrib, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun a _ => by ring
  have h1 : ∑ a, M * lam a = 0 := by rw [← Finset.mul_sum, htr]; ring
  have h2 : ∑ a, m * lam a = 0 := by rw [← Finset.mul_sum, htr]; ring
  have h3 : ∑ _a : ι, m * M = (Fintype.card ι : ℝ) * (m * M) := by
    rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  rw [hexp, h1, h2, h3, hnorm]
  ring

/-- **Step (3): `1 ≤ mMN`.** Every chord factor is nonnegative on `[-m, M]`. -/
theorem chord_bound (lam : ι → ℝ) (m M : ℝ)
    (hlow : ∀ a, -m ≤ lam a) (hhigh : ∀ a, lam a ≤ M)
    (htr : ∑ a, lam a = 0) (hnorm : ∑ a, lam a ^ 2 = 1) :
    1 ≤ m * M * (Fintype.card ι : ℝ) := by
  have hsum : 0 ≤ ∑ a, (lam a + m) * (M - lam a) :=
    Finset.sum_nonneg fun a _ =>
      mul_nonneg (by linarith [hlow a]) (by linarith [hhigh a])
  rw [chord_sum lam m M htr hnorm] at hsum
  linarith

/-- **The record's equality clause**: `1 = mMN` forces every eigenvalue to be `-m` or `M`, which
is "two eigenvalues and no kernel" once `m ≠ 0 ≠ M`. -/
theorem chord_equality (lam : ι → ℝ) (m M : ℝ)
    (hlow : ∀ a, -m ≤ lam a) (hhigh : ∀ a, lam a ≤ M)
    (htr : ∑ a, lam a = 0) (hnorm : ∑ a, lam a ^ 2 = 1)
    (heq : m * M * (Fintype.card ι : ℝ) = 1) :
    ∀ a, lam a = -m ∨ lam a = M := by
  have hz : ∑ a, (lam a + m) * (M - lam a) = 0 := by
    rw [chord_sum lam m M htr hnorm, heq]; ring
  have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ (lam a + m) * (M - lam a) := fun a _ =>
    mul_nonneg (by linarith [hlow a]) (by linarith [hhigh a])
  intro a
  have := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 hz a (Finset.mem_univ a)
  rcases mul_eq_zero.1 this with h | h
  · exact Or.inl (by linarith)
  · exact Or.inr (by linarith)

/-! ## Steps (1) and (2), and the two clauses -/

/-- **The ratio, from relation (B)**: `(n-2)(M - m) = 2m` gives `(n-2)M = nm`. -/
theorem ratio_of_relB (n m M : ℝ) (hB : (n - 2) * (M - m) = 2 * m) : (n - 2) * M = n * m := by
  linarith [hB]

/-- **L117, both clauses.**

`hL70` is Lemma L70's boxed identity at `D(v) = 0`; `hB` is relation (B) with total symmetry.
Both are recorded above as inputs, not as anything this file proves. Everything else is the
spectrum of a unit trace-free `W` with `λ_min = -m` and `λ_max = M`, and `N = n(n-1)/2`. -/
theorem L117 (n : ℝ) (hn : 4 ≤ n) (lam : ι → ℝ) (m M θ : ℝ)
    (hm : 0 ≤ m)
    (hlow : ∀ a, -m ≤ lam a) (hhigh : ∀ a, lam a ≤ M)
    (htr : ∑ a, lam a = 0) (hnorm : ∑ a, lam a ^ 2 = 1)
    (hN : (Fintype.card ι : ℝ) = n * (n - 1) / 2)
    (hL70 : θ = -m + (n - 2) * M)
    (hB : (n - 2) * (M - m) = 2 * m) :
    θ = (n - 1) * m ∧ theta0 n ≤ θ := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hratio : (n - 2) * M = n * m := ratio_of_relB n m M hB
  -- clause (i)
  have hi : θ = (n - 1) * m := by rw [hL70, hratio]; ring
  refine ⟨hi, ?_⟩
  -- clause (ii)
  have hchord := chord_bound lam m M hlow hhigh htr hnorm
  rw [hN] at hchord
  -- `1 ≤ m M n(n-1)/2` with `(n-2)M = nm` gives `2(n-2) ≤ n²(n-1) m²`
  have hn2 : (0 : ℝ) < n - 2 := by linarith
  have haux : m * ((n - 2) * M) * (n * (n - 1) / 2) = m * (n * m) * (n * (n - 1) / 2) := by
    rw [hratio]
  have hkey : 2 * (n - 2) ≤ n ^ 2 * (n - 1) * m ^ 2 := by
    nlinarith [mul_le_mul_of_nonneg_left hchord hn2.le, haux]
  have hθ0 : 0 ≤ θ := by
    rw [hi]
    have : 0 ≤ (n : ℝ) - 1 := by linarith
    exact mul_nonneg this hm
  have hsq : 2 * (n - 1) * (n - 2) ≤ (n * θ) ^ 2 := by
    rw [hi]
    nlinarith [hkey, hn0]
  unfold theta0
  rw [div_le_iff₀ hn0]
  calc Real.sqrt (2 * (n - 1) * (n - 2)) ≤ Real.sqrt ((n * θ) ^ 2) :=
        Real.sqrt_le_sqrt hsq
    _ = n * θ := Real.sqrt_sq (by positivity)
    _ = θ * n := by ring

/-! ## A witness, so the hypotheses are not empty

*Two eigenvalues, `λ = (1/√2, -1/√2)`: trace-free of unit norm, with `m = M = 1/√2` and `N = 2`,
so `mMN = 1` and the chord bound is attained. It witnesses step (3) and its equality clause, which
is the part proved here from nothing.* -/

/-- The witness spectrum. -/
noncomputable def witLam : Fin 2 → ℝ := ![1 / Real.sqrt 2, -(1 / Real.sqrt 2)]

theorem wit_tr : ∑ a, witLam a = 0 := by
  simp [witLam, Fin.sum_univ_two]

theorem wit_norm : ∑ a, witLam a ^ 2 = 1 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h2' : Real.sqrt 2 ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by norm_num))
  simp only [witLam, Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one]
  field_simp
  linarith [h2]

/-- **The witness saturates the chord bound**, so `chord_equality` is not vacuous. -/
theorem wit_saturates :
    (1 / Real.sqrt 2) * (1 / Real.sqrt 2) * (Fintype.card (Fin 2) : ℝ) = 1 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h2' : Real.sqrt 2 ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by norm_num))
  simp only [Fintype.card_fin]
  field_simp
  push_cast
  linarith [h2]

end HamiltonsCubic.L117Statement
