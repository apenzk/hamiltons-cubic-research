# Adjudication brief, round L111, step D3

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From the sentence "every diagonal Weyl tensor satisfies it while being nowhere near critical" in Passage A.

**The step: every coordinate-diagonal Weyl tensor satisfies the bracket form and is not critical, in the sense the words "nowhere near critical" give.**


## The object to check against

The unit Weyl tensors of $S^2\times S^2$ in $\mathcal W_4$ and of $S^3\times S^3$ in $\mathcal W_6$, each in an orthonormal frame of $\mathbb R^n$ adapted to the product.

## Passage A, the heading and the lemma as the block carries it ([findings/bounds.md](../findings/bounds.md) lines 636, 652, 654, 656, 658, 660 and 662)

#### Lemma L111, criticality in bracket coordinates is $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, and the bracket form is strictly weaker

#### Criticality in bracket coordinates, the form the deficiency route needs

**Criticality written in the same currency as $D$.** *[post F41](../findings/fence-posts.md) holds that the marginals cannot supply the deficiency bound, and that motivation is withdrawn, [Reviewer 326](../reviews/REVIEW_r326.md) showed a marginal the post omitted supplies it exactly. The algebra below stands on its own; only the reason for reaching for it was wrong.* Polarising $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ and substituting $W^\#=\theta W-W^2$ gives exactly that. Define $M_{kl}=\operatorname{tr}\big(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W\big)$ over an eigenbasis. Then **criticality is equivalent to**

$$M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl},\qquad\text{i.e.}\qquad \sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}=0\ \text{ whenever }\lambda_k\ne\lambda_l,$$

a family of scalar relations correlating the bracket data of distinct eigenvectors.

> **BUT THE "EQUIVALENTLY" IS FALSE, AND THE SCREEN THAT PASSED IT WAS BLIND.** *[Reviewer 326](../reviews/REVIEW_r326.md), verified here.* The matrix form $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ **is** criticality; the bracket form is **strictly weaker**, it is exactly $[W,Q(W)]=0$, and **every diagonal Weyl tensor satisfies it while being nowhere near critical**. Measured here on six diagonal elements of $\mathcal W_6$ (distance from $\mathcal W_6$ $\le5\times10^{-17}$): off-diagonal residual $0.000\times10^{0}$ exactly, at criticality residuals $0.527$ to $0.741$. That is an $n(n-3)/2$-dimensional family. **The record's screen used *random* Weyl tensors, which are never diagonal**, they give off-diagonal $1.5\times10^{-1}$ and so passed the test the diagonal family fails. *A control drawn from a measure-zero-avoiding distribution cannot see a measure-zero counterexample, and that is the error.* The restriction "whenever $\lambda_k\ne\lambda_l$" is also wrong: criticality forces vanishing for **all** $k\ne l$, basis-independently.

> **This is a change of language, not new information, and it is recorded as one.** It is $W^\#=\theta W-W^2$ written out in bracket coordinates; a route may not count it as an extra constraint, exactly as with the Hilbert–Schmidt form above. **What it buys is that criticality and $D$ are now expressed in the same variables $c_{k\alpha\beta}$**, the diagonal entries pin $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$ for every $k$, which is $N$ constraints where the record used one, and the off-diagonal entries are the only place the Jacobi identity can enter a bound on $D$.

## Passage B, the relations and conventions the lemma is written in ([findings/bounds.md](../findings/bounds.md) lines 258-264, [findings/conventions.md](../findings/conventions.md) lines 61, 77 and 151)

#### What a critical point carries beyond its spectrum, the free data, located exactly

**The question every dead route needed answered first.** At a critical point $W^\#=\theta W-W^2$, so $W^\#$ is a polynomial in $W$ and every scalar built from it at one eigenvector is a function of $(\lambda,\theta)$. That is what made [R14](../routes.md) circular. **So: which contractions of the bracket data are *not* functions of $(\lambda,\theta)$?** With $T_{abc}=c_{abc}^2$ totally symmetric, the record holds **three** per-index relations, and they are the whole of what the Killing form, Ricci-flatness and criticality give:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad \text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k),$$

each holding for every $k$.

- **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

**THE INDEX FORMULA FOR $\#$ CARRIES A $\tfrac12$, AND A DISPLAY WITHOUT IT IS TWICE THE RECORD'S $\#$.** $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$; dropped, the formula returns $\mathrm{id}^\#=2(n-2)\mathrm{id}$ against the halved Böhm–Wilking product's $(n-2)\mathrm{id}$, which is what $Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere pins. *A step reading only the index support of $W^\#$ is untouched by the factor; a step reading a value off it is out by two.* **Two reviewers derived the clash independently, each from $\mathrm{id}^\#$.**

- **"Critical point" is $Q(W)=\theta W$**, the first-order condition on $\{\lVert W\rVert=1\}$. The bracket form $[W,Q(W)]=0$ is strictly weaker and is satisfied by every diagonal Weyl tensor.

## Passage C, the Lean files, declarations with docstrings removed ([lean/HamiltonsCubic/Results/L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) and [lean/HamiltonsCubic/Results/L111.lean](../lean/HamiltonsCubic/Results/L111.lean))

```lean
import Mathlib

set_option linter.style.longLine false


namespace HamiltonsCubic.L111Statement

open Finset

variable {κ : Type*} [DecidableEq κ]


def diagW (lam : κ → ℝ) (k l : κ) : ℝ := if k = l then lam k else 0

def Qmat (lam : κ → ℝ) (Ws : κ → κ → ℝ) (k l : κ) : ℝ :=
  (if k = l then lam k ^ 2 else 0) + Ws k l

def Mmat (Ws : κ → κ → ℝ) (k l : κ) : ℝ := -2 * Ws k l

def IsCriticalHere (lam : κ → ℝ) (Ws : κ → κ → ℝ) (θ : ℝ) : Prop :=
  ∀ k l, Qmat lam Ws k l = θ * diagW lam k l

def BracketForm (lam : κ → ℝ) (Ws : κ → κ → ℝ) : Prop :=
  ∀ k l, lam k ≠ lam l → Ws k l = 0

def CommutesWithW (lam : κ → ℝ) (Ws : κ → κ → ℝ) : Prop :=
  ∀ k l, lam k * Qmat lam Ws k l = Qmat lam Ws k l * lam l


theorem matrix_form_is_criticality (lam : κ → ℝ) (Ws : κ → κ → ℝ) (θ : ℝ) :
    IsCriticalHere lam Ws θ ↔
      ∀ k l, Mmat Ws k l = 2 * lam k * (lam k - θ) * (if k = l then 1 else 0) := by
  unfold IsCriticalHere Qmat Mmat diagW
  constructor
  · intro h k l
    have hkl := h k l
    by_cases he : k = l
    · subst he
      simp only [ite_true] at hkl ⊢
      linarith
    · simp only [if_neg he] at hkl ⊢
      linarith
  · intro h k l
    have hkl := h k l
    by_cases he : k = l
    · subst he
      simp only [ite_true] at hkl ⊢
      linarith
    · simp only [if_neg he] at hkl ⊢
      linarith


theorem commutes_iff_bracket_form (lam : κ → ℝ) (Ws : κ → κ → ℝ) :
    CommutesWithW lam Ws ↔ BracketForm lam Ws := by
  unfold CommutesWithW BracketForm Qmat
  constructor
  · intro h k l hne
    have hkl := h k l
    have hkne : k ≠ l := fun he => hne (by rw [he])
    simp only [if_neg hkne] at hkl
    have : (lam k - lam l) * Ws k l = 0 := by linarith [hkl]
    rcases mul_eq_zero.mp this with h1 | h2
    · exact absurd (by linarith : lam k = lam l) hne
    · exact h2
  · intro h k l
    by_cases hne : lam k = lam l
    · by_cases he : k = l
      · subst he; ring
      · simp only [if_neg he]; rw [hne]; ring
    · have hkne : k ≠ l := fun he => hne (by rw [he])
      simp only [if_neg hkne, h k l hne]
      ring

theorem critical_forces_all_offdiagonal {lam : κ → ℝ} {Ws : κ → κ → ℝ} {θ : ℝ}
    (h : IsCriticalHere lam Ws θ) : ∀ k l, k ≠ l → Ws k l = 0 := by
  intro k l hne
  have hkl := h k l
  unfold Qmat diagW at hkl
  simp only [if_neg hne] at hkl
  linarith

theorem critical_imp_bracket_form {lam : κ → ℝ} {Ws : κ → κ → ℝ} {θ : ℝ}
    (h : IsCriticalHere lam Ws θ) : BracketForm lam Ws := by
  intro k l hne
  exact critical_forces_all_offdiagonal h k l (fun he => hne (by rw [he]))

theorem bracket_form_strictly_weaker :
    BracketForm (![1, -1] : Fin 2 → ℝ) (fun _ _ => 0) ∧
      ¬ ∃ θ : ℝ, IsCriticalHere (![1, -1] : Fin 2 → ℝ) (fun _ _ => 0) θ := by
  constructor
  · intro k l _; rfl
  · rintro ⟨θ, h⟩
    have h0 := h 0 0
    have h1 := h 1 1
    unfold Qmat diagW at h0 h1
    norm_num at h0 h1
    linarith


theorem dropped_count_identity {ι : Type*} [Fintype ι] (m : ι → ℚ) (N : ℚ)
    (hN : ∑ i, m i = N) :
    ∑ i, m i * (m i + 1) / 2 = ((∑ i, m i ^ 2) + N) / 2 := by
  subst hN
  rw [eq_div_iff (by norm_num : (2 : ℚ) ≠ 0), Finset.sum_mul, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring

theorem counts_at_balanced_products :
    ((6 : ℚ) + 9 = 15 ∧ 6 * 7 / 2 + 9 * 10 / 2 = 66 ∧ (15 : ℚ) * 16 / 2 = 120) ∧
    ((30 : ℚ) + 36 = 66 ∧ 30 * 31 / 2 + 36 * 37 / 2 = 1131 ∧ (66 : ℚ) * 67 / 2 = 2211) := by
  refine ⟨⟨by norm_num, by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num, by norm_num⟩⟩

theorem dropped_fractions :
    (66 : ℚ) / 120 = 11 / 20 ∧ (511 : ℚ) / 1000 < 1130 / 2210 ∧ (1130 : ℚ) / 2210 < 512 / 1000 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.L111Statement
```

```lean
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith


namespace HamiltonsCubic.BracketStrictness

def dropped (m : ℕ) : ℕ := Nat.choose (m + 1) 2


theorem multiplicities_six : 3 + 3 + 9 = Nat.choose 6 2 := by decide

theorem split_from_L76 : Nat.choose 3 2 = 3 ∧ 3 * 3 = 9 := by
  refine ⟨by decide, by decide⟩

theorem dropped_six : dropped 3 + dropped 3 + dropped 9 = 57 := by decide

theorem total_six : Nat.choose 16 2 = 120 := by decide

theorem share_six : (57 : ℚ) / 120 = 19 / 40 := by norm_num

theorem share_in_range : (45 : ℚ) / 100 < 19 / 40 ∧ (19 : ℚ) / 40 < 51 / 100 := by
  constructor <;> norm_num


theorem multiplicities_four : 1 + 1 + 4 = Nat.choose 4 2 := by decide

theorem dropped_four : dropped 1 + dropped 1 + dropped 4 = 12 := by decide

theorem total_four : Nat.choose 7 2 = 21 := by decide

theorem share_four_above : (51 : ℚ) / 100 < 12 / 21 := by norm_num


theorem cross_dominates : dropped 9 = 45 ∧ 45 * 100 > 78 * 57 := by
  refine ⟨by decide, by decide⟩

end HamiltonsCubic.BracketStrictness
```

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$, with the Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, and a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$.
- $\{\varphi_k\}=\{v_k\}$ is an orthonormal eigenbasis of $W$ on $\Lambda^2$ with $W\varphi_k=\lambda_k\varphi_k$, $\mathrm{ad}(v)=[v,\cdot]$ on $\mathfrak{so}(n)$, and $c_{abc}$ the structure constants in that basis.
- A **coordinate-diagonal** Weyl tensor is one diagonal on the coordinate 2-planes $e_i\wedge e_j$.
- The lemma has **no entry in [results.md](../results.md)**.
- **This task does no numerical work.** Write no scripts and run no computations. An argument or an exact closed form settles the question, and a decimal is not an argument.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit in closed form exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.
