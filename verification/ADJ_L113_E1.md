# Adjudication brief, round L113, step E1

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From the bolded sentence of Passage A and the sentence before it.

**The step: "any pair of moment inequalities built from [positivity of $g$ and the support of its measure], however the free moment enters, can only return a pinned conclusion once the free moment is eliminated", and hence "moment analysis of the $g$-distribution cannot leave the pinned class", as a statement the `Lemma` label asserts is proved. Say what the step asserts under its strongest reading, whether the passages prove that reading, and whether it is a proposition as written.**

## Passage A, the heading and the lemma as the block carries it ([findings/bounds.md](../findings/bounds.md) lines 508 and 526)

#### Lemma L113, moment analysis of the $g$-distribution cannot leave the pinned class

**The moral, and it is a theorem-shaped extension of [post F42](../findings/fence-posts.md).** Positivity of $g$ and the support of its measure are consequences of the spectrum alone, so *any* pair of moment inequalities built from them, however the free moment enters, can only return a pinned conclusion once the free moment is eliminated. **Moment analysis of the $g$-distribution cannot leave the pinned class.** The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see, and the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself**, before squaring to $T$. *That is now the single open door, and r331/r332's Q1 (whether Jacobi or Bianchi yields a usable relation), is no longer one audit question among five but the question the whole route stands on.*

## Passage B, the relations and the $g$-distribution ([findings/bounds.md](../findings/bounds.md) lines 258-264, [findings/conventions.md](../findings/conventions.md) line 50)

#### What a critical point carries beyond its spectrum, the free data, located exactly

**The question every dead route needed answered first.** At a critical point $W^\#=\theta W-W^2$, so $W^\#$ is a polynomial in $W$ and every scalar built from it at one eigenvector is a function of $(\lambda,\theta)$. That is what made [R14](../routes.md) circular. **So: which contractions of the bracket data are *not* functions of $(\lambda,\theta)$?** With $T_{abc}=c_{abc}^2$ totally symmetric, the record holds **three** per-index relations, and they are the whole of what the Killing form, Ricci-flatness and criticality give:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad \text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),$$

each holding for every $k$.

| $g_k$, $G_2$ | $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, the squared **orbit-tangent** norm in direction $v_k$, manifestly $\ge0$ at every $W$; $G_2:=\sum_k\lambda_k^2g_k$ is the second $\lambda$-moment of that distribution. **The first two moments are pinned**, $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$, both from (A) and (B) with the cubic identity and **neither needing criticality**, so all free content sits at $G_2$ and above. In Hamilton's calculus $S_{22}=2\operatorname{tr}(W^2\#W^2)$ carries the same free content, via $S_{22}=2\theta\operatorname{tr}W^3-2\operatorname{tr}W^4+\tfrac12G_2$ **at a critical point only**. *Neither symbol was tabled while [L108](../findings/bounds.md) and [L113](../findings/bounds.md) ran on both.* **$G_2$ collides with the exceptional Lie group $G_2$ across five files, read it from context** | [bounds.md](../findings/bounds.md) |

## Passage C, Lemma L107, a given ([findings/bounds.md](../findings/bounds.md) lines 562 and 566)

#### Lemma L107, the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$

**Quantifier: the bound holds at every $W\in\mathcal W_n$, not only at critical points.** The row derivation below uses relation (C), which needs criticality; the $g$-route does not, $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}\ge0$ manifestly at every $W$, and $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$ follow from (A) and (B) with the cubic identity. *So the record files as a critical-point bound something that holds everywhere*, and the \"unstated link\" [r441](../reviews/REVIEW_r441.md) flags in the $M(n)\le n-1$ chain (that (C) holds only at critical points), is unnecessary.

## Passage D, post F42, which Passage A says it extends ([findings/fence-posts.md](../findings/fence-posts.md) lines 417, 419 and 423)

## Post F42, no route through the pinned data can close the conjecture, and the census says which moment a successor must reach

**This converts a measured fact into a structural one, and it applies to every relaxation the record has tried.** The census in [bounds.md](../findings/bounds.md) shows that the three per-index relations on $T_{abc}=c_{abc}^2$ ((A) the Killing row mass, (B) the per-row identity $A(W)=2W$, (C) criticality), pin a contraction $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$ **exactly when at least two of $p,q,r$ are $\le1$**. Call that the *pinned data*: everything a critical point's spectrum and $\theta$ already determine.

> **THIS POST'S CONCLUSION IS WITHDRAWN IN BOTH DIRECTIONS. It rests on a measurement that was never made.** *[Reviewer 331](../reviews/REVIEW_r331.md) Q3.* Reviewer 324's relaxation was **single-row** ((A) and (B) at one index, with (C) entering only as the objective), not the full pinned system; and the quoted "$1.5$–$3.7\times$" splices a capped column (computed at $n=5,6$ only) with an uncapped one. **The full $3N$-row system was then screened and its max-$\theta$ at fixed spectrum is *exact* at all seven catalogued spectra tested, the maximal tori (this post's own witness family), included.** *So the pinned class is far stronger than this post claimed, and "sharpening inside it cannot work" is unsupported.*

## Passage E, Lemma L109, a given ([findings/bounds-relaxations.md](../findings/bounds-relaxations.md) lines 47, 51 and 53)

#### Lemma L109, the per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$

Substituting [Prop 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) into a **single** $g_\gamma$ rather than into the $\lambda$-weighted sum, and using $T\ge0$ with the row marginal $\rho_\alpha=2(n-2)$, **[Lemma L153](../findings/bounds.md)**, gives

$$g_\gamma\ \le\ 2(n-2)\,(\lambda_{\max}-\lambda_{\min})^2 .$$

## Passage F, the Lean files, declarations with docstrings removed ([lean/HamiltonsCubic/Results/L113.lean](../lean/HamiltonsCubic/Results/L113.lean) and [lean/HamiltonsCubic/Results/L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean))

```lean
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring


namespace HamiltonsCubic.MomentAnalysis


theorem moment_of_combination (m : ℝ → ℝ)
    (hlin : ∀ a b x y : ℝ, m (a * x + b * y) = a * m x + b * m y)
    (α T₁ T₂ : ℝ) : m (α * T₁ + (1 - α) * T₂) = α * m T₁ + (1 - α) * m T₂ :=
  hlin α (1 - α) T₁ T₂

theorem constraints_convex {T₁ T₂ α c : ℝ} (h₁ : 0 ≤ T₁) (h₂ : 0 ≤ T₂)
    (hα : 0 ≤ α) (hα' : α ≤ 1) (he₁ : T₁ = c) (he₂ : T₂ = c) :
    0 ≤ α * T₁ + (1 - α) * T₂ ∧ α * T₁ + (1 - α) * T₂ = c := by
  constructor
  · have : 0 ≤ 1 - α := by linarith
    nlinarith [h₁, h₂, hα, this]
  · rw [he₁, he₂]; ring

theorem reachable_convex (m : ℝ → ℝ)
    (hlin : ∀ a b x y : ℝ, m (a * x + b * y) = a * m x + b * m y)
    {T₁ T₂ α : ℝ} (hα : 0 ≤ α) (hα' : α ≤ 1) {v₁ v₂ : ℝ}
    (h₁ : m T₁ = v₁) (h₂ : m T₂ = v₂) :
    m (α * T₁ + (1 - α) * T₂) = α * v₁ + (1 - α) * v₂ := by
  rw [moment_of_combination m hlin, h₁, h₂]


theorem unused_hypothesis {A B C Concl : Prop} (h : A → B → Concl) : A → B → C → Concl :=
  fun ha hb _ => h ha hb


theorem closure_with_content :
    ∃ (S : Set ℕ), (0 : ℕ) ∈ S ∧ (1 : ℕ) ∉ S := by
  refine ⟨{0}, by simp, by simp⟩

end HamiltonsCubic.MomentAnalysis
```

```lean
import Mathlib

set_option linter.style.longLine false


namespace HamiltonsCubic.L113Statement

open Finset

variable {N : ℕ}


def Feasible (lam : Fin N → ℝ) (c s : ℝ) : Prop :=
  ∃ g : Fin N → ℝ, (∀ k, 0 ≤ g k) ∧ ∑ k, g k = c ∧ ∑ k, lam k * g k = s


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


def moment (lam : Fin N → ℝ) (j : ℕ) (T : Fin N → Fin N → Fin N → ℝ) : ℝ :=
  ∑ k, ∑ a, ∑ b, lam k ^ j * (lam a - lam b) ^ 2 * T k a b

theorem moment_add (lam : Fin N → ℝ) (j : ℕ) (T T' : Fin N → Fin N → Fin N → ℝ) :
    moment lam j (fun k a b => T k a b + T' k a b) = moment lam j T + moment lam j T' := by
  simp only [moment, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => ?_
  ring

theorem moment_smul (lam : Fin N → ℝ) (j : ℕ) (r : ℝ) (T : Fin N → Fin N → Fin N → ℝ) :
    moment lam j (fun k a b => r * T k a b) = r * moment lam j T := by
  simp only [moment, Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => ?_
  ring


example : Feasible (N := 2) ![1, -1] 4 0 := by
  refine ⟨![2, 2], ?_, ?_, ?_⟩
  · intro k; fin_cases k <;> norm_num
  · simp [Fin.sum_univ_two]; norm_num
  · simp [Fin.sum_univ_two]

end HamiltonsCubic.L113Statement
```

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with the Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, and a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$.
- $\{v_k\}$ is an orthonormal eigenbasis of $W$ on $\Lambda^2$ with eigenvalues $\lambda_k$, $c_{abc}$ the structure constants in that basis, $T_{abc}=c_{abc}^2$, and $m_j=\sum_k\lambda_k^jg_k$ the $j$-th moment of the $g$-distribution.
- Lemmas L107 and L109 are givens, as quoted.
- The lemma has **no entry in [results.md](../results.md)**.
- **This task does no numerical work.** Write no scripts and run no computations. An argument or an exact closed form settles the question, and a decimal is not an argument.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit in closed form exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.
