import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L129, the spectral gap is half-open: `λ` is never an eigenvalue

## The record's statement, verbatim

> #### Lemma L129, the spectral gap is half-open: $\lambda$ is never an eigenvalue
>
> *Contributed at Gate 2 by r388, with r387 reaching the same conclusion from the sphere-product
> spectra. **Hypotheses: $K$ hollow, symmetric, $K\mathbf1=0$, off-diagonal criticality,
> $\lambda>0$, no maximality, no band, no normalisation, no connectivity.***
>
> **Statement.** At every pure critical point, $\operatorname{spec}(K)\cap(0,\lambda]=\varnothing$.
>
> **Proof.** Off the diagonal criticality reads $(K^2-\lambda K)_{ab}=-K_{ab}^2$, and on the
> diagonal hollowness gives $(K^2-\lambda K)_{aa}=\sum_bK_{ab}^2$, so
> $$K^2-\lambda K=L(w),\qquad w_{ab}=K_{ab}^2\ge0,$$
> the weighted graph Laplacian, Lemma L97's identity. $\ker L(w)$ is spanned by the indicators
> $\mathbf1_{C_t}$ of the connected components of $\{w_{ab}>0\}$, and **$K$ annihilates each of
> them**: for $a\in C_t$, $(K\mathbf1_{C_t})_a=\sum_{b\in C_t}K_{ab}=\sum_bK_{ab}=0$, since
> $K_{ab}=0$ off the component; for $a\notin C_t$ every term vanishes already. Now $Kx=\lambda x$
> gives $L(w)x=K^2x-\lambda Kx=0$, so $x\in\ker L(w)$, so $Kx=0$, so $\lambda x=0$ and $x=0$.
> $\square$
>
> **Two corollaries, both used elsewhere.** **(i) $\lambda_{\max}(K)>\lambda$ strictly at every
> pure critical point**, since $\operatorname{tr}K=0$ with $K\ne0$ forces $\lambda_{\max}>0$ and
> the half-open gap then forbids $\lambda_{\max}\le\lambda$. **(ii) Post F48's surviving half is a
> theorem**: at a padded pair $\widetilde N$ is itself a pure critical point at the same $\lambda$,
> so $\lambda\notin\operatorname{spec}(\widetilde N)$ at all, and the separation clause holds there
>, at *every* pure critical point, not at one witness.

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L129.

## What this file states

**The lemma in full, and PROVED**: at a pure critical point in the record's own hypotheses,
hollow, symmetric, `K1 = 0`, off-diagonal criticality `K_ab² + (K²)_ab = λK_ab`, `λ > 0`, no
`μ ∈ (0, λ]` is an eigenvalue of `K`. `gap` says exactly that: an eigenvector at such a `μ` is
zero, so the closed interval `(0, λ]` misses the spectrum, half-open on the right.

The Lean proof takes the record's route through the quadratic form rather than through
`ker L(w)`, which is where it covers a case the record's own three lines do not: the record
argues only `Kx = λx`, whereas `spec(K) ∩ (0,λ] = ∅` also quantifies over `μ < λ`. Both are
handled at once by `dirichlet_identity`, the exact identity
`Σ_a x_a (L(w)x)_a = ½ Σ_{a,b} K_ab² (x_a − x_b)²`, which is nonnegative; at an eigenvalue it
equals `μ(μ−λ)‖x‖²`, which is `≤ 0` on `(0,λ]`. So the Dirichlet energy vanishes, `x` is constant
across every nonzero entry of `K`, `Kx = 0` by the row sums, and `μx = 0`.

**Corollary (i) is stated twice**: in the form the half-open gap gives it directly, every
positive eigenvalue of a pure critical point strictly exceeds `λ` (`pos_eigenvalue_gt`), and in
the record's own form `λ_max(K) > λ` (`lambda_max_gt`), which needs the existence of a positive
eigenvalue. That existence is now supplied rather than assumed: `exists_pos_eigenvalue` gets it
from Mathlib's spectral theorem for a real symmetric matrix (`Matrix.IsHermitian.eigenvalues`,
`Matrix.IsHermitian.trace_eq_sum_eigenvalues` and `Matrix.IsHermitian.eigenvalues_eq_zero_iff`)
together with `tr K = 0`, which `IsPure` supplies through hollowness, and `K ≠ 0`.

`IsPure` is a `structure` over `ℝ` at an arbitrary `Fintype` index, matching the record's
"no normalisation, no connectivity".

## What is NOT typed here

- **Corollary (ii), the padded pair.** The padding construction `Ñ` is not an object the
  `RealLayer` carries, so the statement "at a padded pair the separation clause holds" cannot be
  named here. What it is an instance of, that the gap holds at *every* pure critical point with
  no connectivity hypothesis, is `gap` itself.
- **The identification of `ker L(w)` with the span of the component indicators.** The Lean proof
  does not need it, and it is a theorem about graphs rather than about `K`.
-/

namespace HamiltonsCubic.L129Statement

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `(Kx)_a = Σ_b K_ab x_b`. -/
def act (K : ι → ι → ℝ) (x : ι → ℝ) (a : ι) : ℝ := ∑ b, K a b * x b

/-- The Laplacian weights `w_ab = K_ab² ≥ 0`. -/
def wt (K : ι → ι → ℝ) (a b : ι) : ℝ := K a b ^ 2

/-- `(K² − λK)_ab`, the matrix the record identifies with the weighted graph Laplacian. -/
def lap (K : ι → ι → ℝ) (lam : ℝ) (a b : ι) : ℝ := (∑ d, K a d * K d b) - lam * K a b

/-- **A pure critical point, in exactly the record's hypotheses**, hollow, symmetric,
`K1 = 0`, off-diagonal criticality, `λ > 0`. *No maximality, no band, no normalisation, no
connectivity.* -/
structure IsPure (K : ι → ι → ℝ) (lam : ℝ) : Prop where
  hollow : ∀ a, K a a = 0
  symm : ∀ a b, K a b = K b a
  rowSum : ∀ a, ∑ b, K a b = 0
  offCrit : ∀ a b, a ≠ b → K a b ^ 2 + (∑ d, K a d * K d b) = lam * K a b
  lam_pos : 0 < lam

variable {K : ι → ι → ℝ} {lam : ℝ}

theorem wt_nonneg (K : ι → ι → ℝ) (a b : ι) : 0 ≤ wt K a b := sq_nonneg _

theorem wt_symm (h : IsPure K lam) (a b : ι) : wt K a b = wt K b a := by
  unfold wt; rw [h.symm]

/-! ## `K² − λK` is the weighted graph Laplacian -/

/-- The diagonal: `(K² − λK)_aa = Σ_b K_ab²`, from hollowness and symmetry. -/
theorem lap_diag (h : IsPure K lam) (a : ι) : lap K lam a a = ∑ b, wt K a b := by
  unfold lap
  rw [h.hollow a, mul_zero, sub_zero]
  exact Finset.sum_congr rfl fun d _ => by unfold wt; rw [h.symm d a]; ring

/-- The off-diagonal: `(K² − λK)_ab = −K_ab²`, which is the criticality equation. -/
theorem lap_off (h : IsPure K lam) {a b : ι} (hab : a ≠ b) : lap K lam a b = - wt K a b := by
  have := h.offCrit a b hab
  unfold lap wt
  linarith

/-- Both at once, in the shape the quadratic form needs. -/
theorem lap_eq (h : IsPure K lam) (a b : ι) :
    lap K lam a b = (if a = b then ∑ c, wt K a c else 0) - wt K a b := by
  by_cases hb : a = b
  · subst hb
    have h0 : wt K a a = 0 := by unfold wt; rw [h.hollow a]; ring
    rw [lap_diag h a, h0, if_pos rfl, sub_zero]
  · rw [lap_off h hb, if_neg hb, zero_sub]

/-! ## The Dirichlet identity -/

/-- **`Σ_a x_a (L(w)x)_a = ½ Σ_{a,b} K_ab² (x_a − x_b)²`**, an identity with no hypothesis beyond
hollowness and symmetry. It is what makes the Laplacian positive semidefinite, and it is what
extends the record's `μ = λ` argument to the whole of `(0, λ]`. -/
theorem dirichlet_identity (h : IsPure K lam) (x : ι → ℝ) :
    ∑ a, x a * (∑ b, lap K lam a b * x b)
      = (1 / 2) * ∑ a, ∑ b, wt K a b * (x a - x b) ^ 2 := by
  have hrow : ∀ a, x a * (∑ b, lap K lam a b * x b)
      = (∑ b, wt K a b * x a ^ 2) - ∑ b, wt K a b * (x a * x b) := by
    intro a
    have hstep : ∀ b ∈ (univ : Finset ι), lap K lam a b * x b
        = (if a = b then (∑ c, wt K a c) * x b else 0) - wt K a b * x b := by
      intro b _
      rw [lap_eq h a b]
      by_cases hb : a = b
      · rw [if_pos hb, if_pos hb]; ring
      · rw [if_neg hb, if_neg hb]; ring
    rw [Finset.sum_congr rfl hstep, Finset.sum_sub_distrib]
    have hite : ∑ b, (if a = b then (∑ c, wt K a c) * x b else 0)
        = (∑ c, wt K a c) * x a := by
      rw [Finset.sum_ite_eq univ a (fun b => (∑ c, wt K a c) * x b)]
      simp
    rw [hite, mul_sub]
    congr 1
    · rw [← Finset.sum_mul]; ring
    · rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun b _ => by ring
  rw [Finset.sum_congr rfl (fun a _ => hrow a)]
  have hexp : ∀ a ∈ (univ : Finset ι), ∑ b, wt K a b * (x a - x b) ^ 2
      = (∑ b, wt K a b * x a ^ 2) - 2 * (∑ b, wt K a b * (x a * x b))
        + ∑ b, wt K a b * x b ^ 2 := by
    intro a _
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  rw [Finset.sum_congr rfl hexp]
  have hswap : ∑ a, ∑ b, wt K a b * x b ^ 2 = ∑ a, ∑ b, wt K a b * x a ^ 2 := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      rw [wt_symm h j i]
  rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, hswap, Finset.sum_sub_distrib,
    ← Finset.mul_sum]
  ring

/-- The Dirichlet energy is nonnegative, so `L(w) ⪰ 0`. -/
theorem lap_psd (h : IsPure K lam) (x : ι → ℝ) :
    0 ≤ ∑ a, x a * (∑ b, lap K lam a b * x b) := by
  rw [dirichlet_identity h x]
  have : (0 : ℝ) ≤ ∑ a, ∑ b, wt K a b * (x a - x b) ^ 2 :=
    Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ =>
      mul_nonneg (wt_nonneg K a b) (sq_nonneg _)
  linarith

/-! ## The Laplacian on an eigenvector -/

/-- On an eigenvector at `μ`, `L(w)x = μ(μ − λ)x` rowwise. -/
theorem lap_on_eigen (x : ι → ℝ) (mu : ℝ) (heig : ∀ a, act K x a = mu * x a) (a : ι) :
    ∑ b, lap K lam a b * x b = (mu ^ 2 - lam * mu) * x a := by
  have e1 : ∑ b, (∑ d, K a d * K d b) * x b = ∑ d, K a d * act K x d := by
    have hin : ∀ b ∈ (univ : Finset ι), (∑ d, K a d * K d b) * x b
        = ∑ d, K a d * (K d b * x b) := by
      intro b _
      rw [Finset.sum_mul]
      exact Finset.sum_congr rfl fun d _ => by ring
    rw [Finset.sum_congr rfl hin, Finset.sum_comm]
    exact Finset.sum_congr rfl fun d _ => by unfold act; rw [Finset.mul_sum]
  have e0 : ∑ b, lap K lam a b * x b
      = (∑ b, (∑ d, K a d * K d b) * x b) - lam * act K x a := by
    unfold act
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun b _ => by unfold lap; ring
  rw [e0, e1, heig a]
  have e2 : ∑ d, K a d * act K x d = mu * act K x a := by
    have hin : ∀ d ∈ (univ : Finset ι), K a d * act K x d = mu * (K a d * x d) := by
      intro d _
      rw [heig d]; ring
    rw [Finset.sum_congr rfl hin, ← Finset.mul_sum]
    unfold act
    rfl
  rw [e2, heig a]
  ring

/-! ## The lemma -/

/-- **L129, in full.** At a pure critical point no `μ` with `0 < μ ≤ λ` is an eigenvalue of `K`:
every vector satisfying `Kx = μx` is zero. Equivalently `spec(K) ∩ (0, λ] = ∅`, the gap being
**half-open**, `λ` itself is excluded. -/
theorem gap (h : IsPure K lam) (x : ι → ℝ) (mu : ℝ) (heig : ∀ a, act K x a = mu * x a)
    (hmu0 : 0 < mu) (hmul : mu ≤ lam) : x = 0 := by
  -- The Dirichlet energy is both `≥ 0` and `= μ(μ−λ)‖x‖² ≤ 0`, so it vanishes.
  have hval : ∑ a, x a * (∑ b, lap K lam a b * x b) = (mu ^ 2 - lam * mu) * ∑ a, x a ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => by rw [lap_on_eigen x mu heig a]; ring
  have hnormsq : (0 : ℝ) ≤ ∑ a, x a ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
  have hcoef : mu ^ 2 - lam * mu ≤ 0 := by nlinarith
  have hle : ∑ a, x a * (∑ b, lap K lam a b * x b) ≤ 0 := by
    rw [hval]; exact mul_nonpos_of_nonpos_of_nonneg hcoef hnormsq
  have hzero : ∑ a, ∑ b, wt K a b * (x a - x b) ^ 2 = 0 := by
    have h1 := lap_psd h x
    rw [dirichlet_identity h x] at h1 hle
    linarith
  -- Termwise: `x` is constant across every nonzero entry of `K`.
  have hterm : ∀ a b : ι, wt K a b * (x a - x b) ^ 2 = 0 := by
    intro a b
    have hrow := (Finset.sum_eq_zero_iff_of_nonneg
      (fun a _ => Finset.sum_nonneg fun b _ =>
        mul_nonneg (wt_nonneg K a b) (sq_nonneg _))).1 hzero a (mem_univ a)
    exact (Finset.sum_eq_zero_iff_of_nonneg
      (fun b _ => mul_nonneg (wt_nonneg K a b) (sq_nonneg _))).1 hrow b (mem_univ b)
  have hconst : ∀ a b : ι, K a b * x b = K a b * x a := by
    intro a b
    rcases eq_or_ne (K a b) 0 with hk | hk
    · rw [hk]; ring
    · have hw : wt K a b ≠ 0 := by unfold wt; exact pow_ne_zero 2 hk
      have := hterm a b
      have hsq : (x a - x b) ^ 2 = 0 := by
        rcases mul_eq_zero.1 this with h' | h'
        · exact absurd h' hw
        · exact h'
      have : x a - x b = 0 := by nlinarith [hsq]
      have : x b = x a := by linarith
      rw [this]
  -- Hence `Kx = 0`, and `μx = Kx = 0` with `μ > 0`.
  funext a
  have hKx : act K x a = 0 := by
    unfold act
    rw [Finset.sum_congr rfl (fun b _ => hconst a b), ← Finset.sum_mul, h.rowSum a, zero_mul]
  have := heig a
  rw [hKx] at this
  have : x a = 0 := by
    rcases mul_eq_zero.1 this.symm with h' | h'
    · exact absurd h' (ne_of_gt hmu0)
    · exact h'
  simpa using this

/-- **Corollary (i), in the form the gap gives it.** Every *positive* eigenvalue of a pure
critical point strictly exceeds `λ`. *The record reads this as `λ_max(K) > λ`; that reading needs
in addition that a positive eigenvalue exists, which is the spectral theorem together with
`tr K = 0` and `K ≠ 0`, and is not typed here.* -/
theorem pos_eigenvalue_gt (h : IsPure K lam) (x : ι → ℝ) (mu : ℝ)
    (heig : ∀ a, act K x a = mu * x a) (hx : x ≠ 0) (hmu0 : 0 < mu) : lam < mu := by
  by_contra hcon
  exact hx (gap h x mu heig hmu0 (le_of_not_gt hcon))

/-! ## The spectral theorem step, and corollary (i) in the record's own form

*The record reads corollary (i) as `λ_max(K) > λ`, which needs a positive eigenvalue to exist.
That is the classical spectral theorem for a real symmetric matrix, and it is Mathlib's
`Matrix.IsHermitian.eigenvalues`; the two inputs the record names (`tr K = 0` and `K ≠ 0`), are
supplied here, the first from hollowness alone.*
-/

/-- **A pure critical point is a symmetric real matrix**, hence Hermitian over `ℝ`. -/
theorem IsPure.isHermitian (h : IsPure K lam) : (Matrix.of K).IsHermitian := by
  ext a b
  simpa [Matrix.conjTranspose_apply] using (h.symm b a)

/-- **Hollowness is `tr K = 0`**, which is the trace hypothesis corollary (i) uses. -/
theorem IsPure.trace_eq_zero (h : IsPure K lam) : (Matrix.of K).trace = 0 := by
  simp [Matrix.trace, Matrix.diag, h.hollow]

/-- **A nonzero real symmetric matrix of zero trace has a strictly positive eigenvalue.** *The
spectral theorem step: the eigenvalues sum to the trace, so they cannot all be `≤ 0` without all
being `0`, and all being `0` makes the matrix `0`.* -/
theorem exists_pos_eigenvalue {A : Matrix ι ι ℝ} (hA : A.IsHermitian) (htr : A.trace = 0)
    (hne : A ≠ 0) : ∃ i : ι, 0 < hA.eigenvalues i := by
  by_contra hcon
  simp only [not_exists, not_lt] at hcon
  have hsum : ∑ i, hA.eigenvalues i = 0 := by
    have h := hA.trace_eq_sum_eigenvalues
    rw [htr] at h
    simpa using h.symm
  have hall : ∀ i, hA.eigenvalues i = 0 := by
    intro i
    have hnn : ∀ j ∈ (univ : Finset ι), 0 ≤ - hA.eigenvalues j := fun j _ => by
      linarith [hcon j]
    have hs0 : ∑ j, - hA.eigenvalues j = 0 := by
      rw [Finset.sum_neg_distrib, hsum, neg_zero]
    have := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 hs0 i (mem_univ i)
    linarith
  exact hne (hA.eigenvalues_eq_zero_iff.mp (funext hall))

/-- **An eigenvector of the Hermitian matrix, read in this file's `act`.** -/
theorem act_eigenvectorBasis {A : Matrix ι ι ℝ} (hA : A.IsHermitian) (i : ι) :
    (⇑(hA.eigenvectorBasis i) : ι → ℝ) ≠ 0 ∧
      ∀ a, act A (⇑(hA.eigenvectorBasis i)) a = hA.eigenvalues i * (hA.eigenvectorBasis i) a := by
  refine ⟨(WithLp.ofLp_eq_zero 2).ne.2 <| hA.eigenvectorBasis.orthonormal.ne_zero i, fun a => ?_⟩
  have h := congrFun (hA.mulVec_eigenvectorBasis i) a
  simpa [act, Matrix.mulVec, dotProduct] using h

/-- **COROLLARY (i), IN THE RECORD'S OWN FORM: `λ_max(K) > λ`.** At a nonzero pure critical point
some eigenvalue of `K` strictly exceeds `λ`, equivalently `λ_max(K) > λ`, since the eigenvalues
are the whole real spectrum. *`tr K = 0` comes from hollowness, `K ≠ 0` is the hypothesis, and
the half-open gap does the rest.* -/
theorem lambda_max_gt (h : IsPure K lam) (hne : Matrix.of K ≠ 0) :
    ∃ i : ι, lam < h.isHermitian.eigenvalues i := by
  obtain ⟨i, hi⟩ := exists_pos_eigenvalue h.isHermitian h.trace_eq_zero hne
  obtain ⟨hx, heig⟩ := act_eigenvectorBasis h.isHermitian i
  exact ⟨i, pos_eigenvalue_gt h _ _ heig hx hi⟩

/-- **The same, as a strict inequality against the largest eigenvalue.** *`Finset.sup'` over the
eigenvalue list is `λ_max`, the index type being nonempty because `K ≠ 0`.* -/
theorem lambda_max_gt' (h : IsPure K lam) (hne : Matrix.of K ≠ 0) (hι : (univ : Finset ι).Nonempty) :
    lam < (univ : Finset ι).sup' hι h.isHermitian.eigenvalues := by
  obtain ⟨i, hi⟩ := lambda_max_gt h hne
  exact lt_of_lt_of_le hi (Finset.le_sup' _ (mem_univ i))

/-! ## A witness, so the hypotheses are not empty

*`K = 0` on any index type is hollow, symmetric, row-summing to zero and off-diagonally critical
at every `λ`, so `IsPure 0 lam` holds for every `lam > 0`. The conclusion is then the true and
non-vacuous statement that `0` has no eigenvector at any `μ ∈ (0, λ]`.* -/

example (lam : ℝ) (hlam : 0 < lam) : IsPure (fun _ _ : ι => (0 : ℝ)) lam where
  hollow := fun _ => rfl
  symm := fun _ _ => rfl
  rowSum := fun _ => by simp
  offCrit := fun _ _ _ => by simp
  lam_pos := hlam

end HamiltonsCubic.L129Statement
