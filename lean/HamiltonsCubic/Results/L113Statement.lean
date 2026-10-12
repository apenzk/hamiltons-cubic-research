import Mathlib

set_option linter.style.longLine false

/-!
# L113, what moment analysis of the `g`-distribution can and cannot decide

## The record's statement, as audited in [ROUND_L113](../../../verification/ROUND_L113.md)

[bounds.md](../../../findings/bounds.md)'s Lemma L113: at unit norm, every conclusion about
$(\lambda,\theta)$ drawn from inequalities in the moments of $g$ that hold for every nonnegative $g$
supported on the spectrum, with $m_0=4(n-1)$, $m_1=-4\theta$ and every free moment eliminated,
follows from $\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0$, which at $\theta\ge0$ is
[Lemma L107](../../../findings/bounds.md)'s $\theta\le(n-1)\lvert\lambda_{\min}\rvert$.

## What is typed here

`Feasible` is the reviewers' system, and it is a predicate in `(λ, c, s)` **alone**. That is the
block's tautology diagnosis made precise: every consequence of the class is a statement about the
spectrum and `θ`, because the class is defined by them and nothing else.

* `feasible_iff`, the exact characterisation: the system is feasible **iff** `s` lies between
  `c·λ_min` and `c·λ_max`. Proved in both directions, the backward direction by the reviewers'
  two-atom witness.
* `feasible_iff_theta`, the same at the record's data `c = 4(n-1)`, `s = -4θ`, giving the
  reviewers' sentence `θ ≤ (n-1)|λ_min|` once `θ ≥ 0 ≥ λ_min ≤ 0 ≤ λ_max` is in hand. **The record's
  "iff" is the upper half only**; the lower half `-(n-1)λ_max ≤ θ` is what those sign conditions
  discharge, and it is stated here rather than dropped.
* `moment_add`, `moment_smul`, the moments are linear in `T`.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The block's headline, "moment analysis of the `g`-distribution cannot leave the pinned class",
is not a proposition and is not typed.** The Gate 2 verdict is that its class is undelimited:
*"built from"* is never defined, *"any pair"* is the wrong arity when `m₃, m₄, …` are equally free,
and *"pinned class"* carries two incompatible senses in the block's own file. What replaces it here
is the reviewers' theorem, which is a proposition and is proved. The record's identification of
`m₀ = 4(n-1)` and `m₁ = -4θ` with the moments of `g` needs the tensor `T` and the relations (A),
(B) and (C), so it is absent too: the file takes `c` and `s` as data.
-/

namespace HamiltonsCubic.L113Statement

open Finset

variable {N : ℕ}

/-! ## The system

*The reviewers' class: nonnegativity, a pinned total mass and a pinned first moment against the
spectrum. Nothing else enters, which is the point.* -/

/-- **The `g`-system**: `g ≥ 0`, `∑ gₖ = c`, `∑ λₖgₖ = s`. Its three arguments are the spectrum,
the total mass and the first moment, so any conclusion drawn from it is a statement about those
three and nothing more. -/
def Feasible (lam : Fin N → ℝ) (c s : ℝ) : Prop :=
  ∃ g : Fin N → ℝ, (∀ k, 0 ≤ g k) ∧ ∑ k, g k = c ∧ ∑ k, lam k * g k = s

/-! ## The characterisation -/

/-- **Feasibility is exactly `c·λ_min ≤ s ≤ c·λ_max`.**

The forward direction is the range of an average; the backward direction is the reviewers'
two-atom witness, all the mass at `argmin` and `argmax`. -/
theorem feasible_iff (hne : (univ : Finset (Fin N)).Nonempty) (lam : Fin N → ℝ) {c s : ℝ}
    (hc : 0 < c) :
    Feasible lam c s ↔
      c * (univ.inf' hne lam) ≤ s ∧ s ≤ c * (univ.sup' hne lam) := by
  classical
  obtain ⟨i, -, hi⟩ := Finset.exists_mem_eq_inf' hne lam
  obtain ⟨j, -, hj⟩ := Finset.exists_mem_eq_sup' hne lam
  set lmin := univ.inf' hne lam with hlmin
  set lmax := univ.sup' hne lam with hlmax
  have hminle : ∀ k, lmin ≤ lam k := fun k => Finset.inf'_le lam (mem_univ k)
  have hlemax : ∀ k, lam k ≤ lmax := fun k => Finset.le_sup' lam (mem_univ k)
  constructor
  · rintro ⟨g, hg0, hgc, hgs⟩
    constructor
    · calc c * lmin = ∑ k, lmin * g k := by rw [← Finset.mul_sum, hgc]; ring
        _ ≤ ∑ k, lam k * g k := Finset.sum_le_sum fun k _ =>
              mul_le_mul_of_nonneg_right (hminle k) (hg0 k)
        _ = s := hgs
    · calc s = ∑ k, lam k * g k := hgs.symm
        _ ≤ ∑ k, lmax * g k := Finset.sum_le_sum fun k _ =>
              mul_le_mul_of_nonneg_right (hlemax k) (hg0 k)
        _ = c * lmax := by rw [← Finset.mul_sum, hgc]; ring
  · rintro ⟨hlo, hhi⟩
    by_cases heq : lmin = lmax
    · -- degenerate spectrum: every eigenvalue equals `lmin`, and `s = c·lmin` is forced
      have hall : ∀ k, lam k = lmin := fun k =>
        le_antisymm (by rw [heq]; exact hlemax k) (hminle k)
      have hs : s = c * lmin := by rw [← heq] at hhi; linarith
      refine ⟨fun k => if k = i then c else 0, fun k => by positivity, by simp, ?_⟩
      have hcongr : ∀ k, lam k * (if k = i then c else 0) = if k = i then lmin * c else 0 := by
        intro k
        split_ifs with h
        · rw [hall k]
        · ring
      rw [Finset.sum_congr rfl fun k _ => hcongr k]
      simp only [Finset.sum_ite_eq', mem_univ, if_true]
      rw [hs]; ring
    · -- the reviewers' two-atom witness
      have hlt : lmin < lmax := lt_of_le_of_ne (le_trans (hminle i) (hlemax i)) heq
      have hij : i ≠ j := fun h => heq (by rw [hi, h, ← hj])
      have hden : 0 < lmax - lmin := by linarith
      set t := (s - c * lmin) / (lmax - lmin) with ht
      have ht0 : 0 ≤ t := div_nonneg (by linarith) hden.le
      have htc : t ≤ c := by
        rw [ht, div_le_iff₀ hden]
        nlinarith
      refine ⟨fun k => (if k = j then t else 0) + (if k = i then c - t else 0),
        fun k => by positivity, ?_, ?_⟩
      · rw [Finset.sum_add_distrib]
        simp only [Finset.sum_ite_eq', mem_univ, if_true]
        ring
      · have hstep : ∀ k, lam k * ((if k = j then t else 0) + (if k = i then c - t else 0))
            = (if k = j then lmax * t else 0) + (if k = i then lmin * (c - t) else 0) := by
          intro k
          split_ifs with h1 h2 h3
          · exact absurd (h1.symm.trans h2) hij.symm
          · rw [h1, ← hj]; ring
          · rw [h3, ← hi]; ring
          · ring
        rw [Finset.sum_congr rfl fun k _ => hstep k, Finset.sum_add_distrib]
        simp only [Finset.sum_ite_eq', mem_univ, if_true]
        rw [ht]
        field_simp
        ring

/-- **The characterisation at the record's data.** With `c = 4(n-1)` and `s = -4θ`, and with the
sign facts the record's setting supplies (`θ ≥ 0`, `λ_min ≤ 0 ≤ λ_max`), feasibility is exactly
`θ ≤ (n-1)|λ_min|`, which is [Lemma L107](../../../findings/bounds.md). -/
theorem feasible_iff_theta (hne : (univ : Finset (Fin N)).Nonempty) (lam : Fin N → ℝ) {n : ℕ}
    (hn : 2 ≤ n) {θ : ℝ} (hθ : 0 ≤ θ) (hmin : univ.inf' hne lam ≤ 0)
    (hmax : 0 ≤ univ.sup' hne lam) :
    Feasible lam (4 * ((n : ℝ) - 1)) (-4 * θ) ↔ θ ≤ ((n : ℝ) - 1) * |univ.inf' hne lam| := by
  have hn2 : (2 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hc : (0 : ℝ) < 4 * ((n : ℝ) - 1) := by linarith
  have habs : |univ.inf' hne lam| = -(univ.inf' hne lam) := abs_of_nonpos hmin
  rw [feasible_iff hne lam hc, habs]
  constructor
  · rintro ⟨hlo, -⟩; nlinarith
  · intro h
    refine ⟨by nlinarith, by nlinarith⟩

/-! ## The moments are linear in `T`

*The reviewers' first observation, and the reason the class is closed under taking any number of
moment inequalities: nothing nonlinear in `T` is ever formed.* -/

/-- The `j`-th moment of the `g`-distribution,
`m_j = ∑_{kαβ} λₖ^j (λ_α - λ_β)² T_{kαβ}`. -/
def moment (lam : Fin N → ℝ) (j : ℕ) (T : Fin N → Fin N → Fin N → ℝ) : ℝ :=
  ∑ k, ∑ a, ∑ b, lam k ^ j * (lam a - lam b) ^ 2 * T k a b

/-- **Additivity in `T`.** -/
theorem moment_add (lam : Fin N → ℝ) (j : ℕ) (T T' : Fin N → Fin N → Fin N → ℝ) :
    moment lam j (fun k a b => T k a b + T' k a b) = moment lam j T + moment lam j T' := by
  simp only [moment, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => ?_
  ring

/-- **Homogeneity in `T`.** -/
theorem moment_smul (lam : Fin N → ℝ) (j : ℕ) (r : ℝ) (T : Fin N → Fin N → Fin N → ℝ) :
    moment lam j (fun k a b => r * T k a b) = r * moment lam j T := by
  simp only [moment, Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => ?_
  ring

/-! ## The hypotheses are not empty -/

/-- A witness: at `N = 2` with spectrum `(1, -1)`, mass `c = 4` and first moment `s = 0`, the
system is feasible, so `Feasible` is not a vacuous predicate. -/
example : Feasible (N := 2) ![1, -1] 4 0 := by
  refine ⟨![2, 2], ?_, ?_, ?_⟩
  · intro k; fin_cases k <;> norm_num
  · simp [Fin.sum_univ_two]; norm_num
  · simp [Fin.sum_univ_two]

end HamiltonsCubic.L113Statement
