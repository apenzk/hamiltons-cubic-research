# Adjudication brief, round L115, step F1

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From the heading of Lemma L115 in Passage A.

**The step: $\lambda_{\max}(M)=\theta$ at every global maximiser of $P$ on the unit sphere of $\mathcal W_n$, for every $n$ the heading covers.**

## Passage A, the heading and the lemma as the file carries it ([findings/bounds-relaxations.md](../findings/bounds-relaxations.md) lines 268, 284, 286, 288, 290, 292 and 294)

The numbered heading is followed only by annotations, and the lemma's content sits under the two headings after it.

#### Lemma L115, $\lambda_{\max}(M)=\theta$ at every global maximiser, with $\theta\ge\max_\alpha\lambda_\alpha$ there

#### And that settles what the route is worth

Lemma L24 (the extremal spectral bound $\sigma(L_e|_{W^\perp})\subseteq(-\infty,\tfrac12]$ with $1$ simple), caps every eigenvalue off $W$ at $\tfrac12$, **on $\mathcal W_n\cap W^\perp$ and nowhere else**. The step to $\lambda_{\max}(L_e|_{\mathcal D})=1$ reads that cap over the whole eigenframe-diagonal algebra $\mathcal D$, whose elements are generically neither trace-free nor Bianchi, and **that is the step [Lemma L115](../findings/bounds-relaxations.md#lemma-l115-lambda_maxmtheta-at-every-global-maximiser-with-thetagemax_alphalambda_alpha-there) grades a `GAP` eighteen lines above.** So

$$\lambda_{\max}(M)=\theta\qquad\text{at every COORDINATE-DIAGONAL global maximiser, and at every }S^m\times S^m,\ m\ge4.$$

**The unrestricted form is not citable**, and what would close it is a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$, which is nowhere on the record.

#### The Rayleigh bound is tight where it matters and slack elsewhere

So $\sup_W\lambda_{\max}(M)\le\theta_0$ (B3's target as posed), is **strictly stronger than Conjecture A**: the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$. The equivalent target is the pointwise statement at maximisers, and that is Conjecture A rewritten, neither easier nor harder. A free by-product: since $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)=\theta$ at a maximiser, $\theta\ge\max_\alpha\lambda_\alpha$, the largest eigenvalue of a maximiser is at most its own $\theta$.

## Passage B, the definition of $M$ and its first facts ([findings/second-order.md](../findings/second-order.md) lines 532-548, odd lines)

#### $P$ is a Rayleigh quotient, and $\theta$ is an eigenvalue of its own matrix

**One line turns the cubic into a quadratic form.** In an eigenbasis of $W$, with $c'$ transported there,

$$P=\sum_\alpha\lambda_\alpha^3+\tfrac12\sum c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=\langle\lambda,M(\lambda)\lambda\rangle,\qquad M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma ,$$

with $M$ symmetric because $c'^2$ is symmetric in its first two indices. Since $\|\lambda\|=1$,

$$\boxed{\ \theta\le\lambda_{\max}\big(M(\lambda)\big)\ }$$

**and at a critical point $\theta$ is already an eigenvalue of $M$**, not merely bounded by one: $Q(W)=\theta W$ is diagonal in the eigenbasis, so $M\lambda=\theta\lambda$ exactly. Across the catalogue $\lambda_{\max}(M)$ equals $\theta$ to six digits at every point except the $C_5$ blow-up, where $\lambda$ is not the top eigenvector, $0.809017$ against $\theta=0.670820$.

**Its supremum over $\mathrm{Weyl}_n$ is $\sqrt{3/2}$ at $n=6,8,10$** by full-gradient ascent, which is exactly $\max(\sqrt{3/2},\theta_0(n))$ there, since $\theta_0$ is $1.054093$, $1.145644$ and $1.200000$ there and padded $W_{\mathbb{CP}^2}$ dominates. From $n=12$ the ordering reverses. **If the supremum is $\max(\sqrt{3/2},\theta_0(n))$ in general, then for $n\ge12$**

$$M(n)\le\sup\lambda_{\max}(M)=\theta_0(n),$$

**which is Conjecture A**, with equality at the balanced sphere product.

## Passage C, Lemma L24, a given ([findings/second-order.md](../findings/second-order.md) lines 55, 61 and 63)

#### Lemma L24, second-order optimality as an eigenvalue bound, the canonical statement

**Statement.** Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$, the restriction of the ambient second differential **plus** the constraint's $-3\theta\,\mathrm{Id}$, the two differing by exactly that, is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

## Passage D, the Lean files, declarations with docstrings removed ([lean/HamiltonsCubic/Results/L115.lean](../lean/HamiltonsCubic/Results/L115.lean) and [lean/HamiltonsCubic/Results/L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean))

```lean
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith


namespace HamiltonsCubic.OutsideItsSpace


theorem lambda2_six : 6 * 5 / 2 = 15 := by norm_num

theorem ambient_dim : 16 * 15 / 2 = 120 := by norm_num

theorem weyl_six : 6 * 7 * 8 * 3 / 12 = 84 := by norm_num

theorem intersection_share_ambient : (1 : ℚ) / 120 < 1 / 100 := by norm_num

theorem intersection_share_weyl : (1 : ℚ) / 100 < 1 / 84 := by norm_num

theorem share_bracket : (1 : ℚ) / 84 < 12 / 1000 := by norm_num


theorem cap_on_subspace_transfers_nothing :
    ∃ (f : ℚ × ℚ → ℚ) (c : ℚ), (∀ t : ℚ, f (t, 0) ≤ c) ∧ ∀ B : ℚ, ∃ p, B < f p := by
  refine ⟨fun p => p.2, 0, ?_, ?_⟩
  · intro t; norm_num
  · intro B; exact ⟨(0, B + 1), by norm_num⟩

theorem true_claim_bad_argument {C : Prop} (hC : C) {H : Prop} (hH : ¬ H) : (H → C) ∧ C :=
  ⟨fun h => absurd h hH, hC⟩

end HamiltonsCubic.OutsideItsSpace
```

```lean
import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false


namespace HamiltonsCubic.L115Statement

open Finset Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

def IsTopRayleigh (A : Matrix ι ι ℝ) (t : ℝ) : Prop :=
  ∀ x : ι → ℝ, x ⬝ᵥ (A *ᵥ x) ≤ t * (x ⬝ᵥ x)


def evec (α : ι) : ι → ℝ := fun i => if i = α then 1 else 0

theorem diag_is_rayleigh (A : Matrix ι ι ℝ) (α : ι) :
    evec α ⬝ᵥ (A *ᵥ evec α) = A α α ∧ evec α ⬝ᵥ evec α = 1 := by
  have hrow : ∀ i : ι, (∑ j, A i j * evec α j) = A i α := by
    intro i
    simp [evec, Finset.sum_ite_eq']
  constructor
  · show ∑ i, evec α i * (∑ j, A i j * evec α j) = A α α
    simp only [hrow]
    simp [evec, Finset.sum_ite_eq']
  · show ∑ i, evec α i * evec α i = 1
    simp [evec, Finset.sum_ite_eq']

theorem theta_ge_diag (A : Matrix ι ι ℝ) (lam : ι → ℝ) (θ : ℝ)
    (hdiag : ∀ α, A α α = lam α) (hlam : IsTopRayleigh A θ) :
    ∀ α, lam α ≤ θ := by
  intro α
  obtain ⟨h1, h2⟩ := diag_is_rayleigh A α
  have h := hlam (evec α)
  rw [h1, h2, hdiag α] at h
  linarith


theorem le_norm_of_sum_sq (lam : ι → ℝ) (hnorm : ∑ a, lam a ^ 2 = 1) (α : ι) :
    lam α ≤ 1 := by
  have hle : lam α ^ 2 ≤ ∑ a, lam a ^ 2 :=
    Finset.single_le_sum (f := fun a => lam a ^ 2) (fun a _ => sq_nonneg _) (Finset.mem_univ α)
  rw [hnorm] at hle
  nlinarith [hle, sq_nonneg (lam α - 1), sq_nonneg (lam α + 1)]

theorem one_lt_sqrt_three_halves : (1 : ℝ) < Real.sqrt (3 / 2) := by
  rw [show (1 : ℝ) = Real.sqrt 1 by simp]
  exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)

theorem margin : (0.2247 : ℝ) ≤ Real.sqrt (3 / 2) - 1 := by
  have h : (1.2247 : ℝ) ≤ Real.sqrt (3 / 2) := by
    rw [show (1.2247 : ℝ) = Real.sqrt (1.2247 ^ 2) from (Real.sqrt_sq (by norm_num)).symm]
    exact Real.sqrt_le_sqrt (by norm_num)
  linarith

theorem theta_gt_lambda (lam : ι → ℝ) (θ : ℝ)
    (hnorm : ∑ a, lam a ^ 2 = 1) (hθ : Real.sqrt (3 / 2) ≤ θ) :
    ∀ α, lam α < θ := by
  intro α
  have h1 := le_norm_of_sum_sq lam hnorm α
  have h2 := one_lt_sqrt_three_halves
  linarith

theorem theta_sub_lambda_ge (lam : ι → ℝ) (θ : ℝ)
    (hnorm : ∑ a, lam a ^ 2 = 1) (hθ : Real.sqrt (3 / 2) ≤ θ) :
    ∀ α, (0.2247 : ℝ) ≤ θ - lam α := by
  intro α
  have h1 := le_norm_of_sum_sq lam hnorm α
  have h2 := margin
  linarith


theorem c5_exceeds_nonWeyl_cap : 1 / Real.sqrt 2 < (0.809017 : ℝ) := by
  have h2 : (1.4142 : ℝ) ≤ Real.sqrt 2 := by
    rw [show (1.4142 : ℝ) = Real.sqrt (1.4142 ^ 2) from (Real.sqrt_sq (by norm_num)).symm]
    exact Real.sqrt_le_sqrt (by norm_num)
  have hpos : (0 : ℝ) < Real.sqrt 2 := Real.sqrt_pos.2 (by norm_num)
  rw [div_lt_iff₀ hpos]
  nlinarith [h2]


noncomputable def witLam : Fin 2 → ℝ := ![1 / Real.sqrt 2, -(1 / Real.sqrt 2)]

theorem wit_norm : ∑ a, witLam a ^ 2 = 1 := by
  have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have h2' : Real.sqrt 2 ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by norm_num))
  simp only [witLam, Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one]
  field_simp
  linarith [h2]

example : ∀ α, witLam α < Real.sqrt (3 / 2) :=
  theta_gt_lambda witLam (Real.sqrt (3 / 2)) wit_norm le_rfl

end HamiltonsCubic.L115Statement
```

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with the Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, and a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$. $M(n)$ is the maximum of $P$ on the unit sphere of $\mathcal W_n$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, and a **global maximiser** is a unit $W$ with $P(W)=M(n)$.
- $\lambda$ is the spectrum of $W$ on $\Lambda^2$ in an orthonormal eigenbasis $\{v_\alpha\}$, $c'$ the structure constants in that basis, and $\mathcal D$ the operators diagonal in that eigenframe. A **coordinate-diagonal** $W$ is one diagonal on the coordinate 2-planes $e_i\wedge e_j$.
- Lemma L24 is a given, as quoted. Padded $W_{\mathbb{CP}^2}$ has $P=\sqrt{3/2}$ at every $n\ge4$, so $M(n)\ge\sqrt{3/2}$.
- The lemma has **no entry in [results.md](../results.md)**.
- **This task does no numerical work.** Write no scripts and run no computations. An argument or an exact closed form settles the question, and a decimal is not an argument.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit in closed form exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.
