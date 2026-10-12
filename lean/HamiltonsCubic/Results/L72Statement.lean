import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L41Statement

set_option linter.style.longLine false

/-!
# L72, the rank-3 stratum is overdetermined, and the spectrum is forced

**The record's statement, quoted verbatim from [stratum-two-negative.md](../../../findings/stratum-two-negative.md):**

> #### Lemma L72, the rank-3 stratum is overdetermined, and its converse clause closes in three lines
>
> **At a critical point, the criticality rows close what the stratum analysis left open.** With spectrum $(\lambda_1,-a,-b,0,\dots)$, $a,b>0$, the only bracket entry the rows see is $T:=T_{1,N-1,N}$, and the three non-kernel rows of $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$ read
>
> $$\text{(i)}\ Tab=\lambda_1(\theta-\lambda_1),\qquad\text{(ii)}\ T\lambda_1b=a(\theta+a),\qquad\text{(iii)}\ T\lambda_1a=b(\theta+b).$$
>
> Three expressions for one number. (ii)$=$(iii) forces $a=b$ or $\theta=-(a^2+ab+b^2)/(a+b)$; on the second branch $\theta+a=-b^2/(a+b)$, so (ii) gives $T=-ab/(\lambda_1(a+b))=-ab/\lambda_1^2<0$, impossible for $T=c^2$; and $T=0$ fails the pair (i)&(ii), (i) forces $\theta=\lambda_1>0$ while (ii) forces $\theta=-a<0$, neither row killing it alone. **So $a=b$, and then $\lambda_1=2a$, $\theta=3a$, $T=2$, unit norm $6a^2=1$:**
>
> > **LEMMA L72.** *Every critical point of $\mathcal W_n$ with exactly one positive and two negative eigenvalues has spectrum $(2,-1,-1)/\sqrt6$ on its support and $\theta=\sqrt{3/2}$, for every $n$, with no numerics and no case analysis.*
>
> **Why this stratum and no other**: the rows give $r$ equations against $\binom r3$ live entries, so $T$ is *overdetermined* at rank $3$, determined at rank $4$, and free from rank $5$ on, the collapse boundary is exactly where the count crosses.

## What this file states

`L72` below is the boxed **LEMMA L72** in full, against
[WeylReal.lean](../Base/WeylReal.lean)'s `IsWeyl`, `IsCritical` and `normSq` at a general index
type (*"for every `n`"*), with the spectrum carried by an explicit orthonormal eigen-decomposition
of `R` on bivectors (`EigenData`). **It is proved, with no `sorry`.**

**The three criticality rows** `(W#)_ββ = λ_β(θ - λ_β)` are derived from `IsCritical` by
`crit_all` and `crit_row`, reading `sharpOp` in the eigenframe through
[L41Statement.lean](L41Statement.lean)'s `sharpQF_frame`, with the bracket tensor its `cst`.

**Everything downstream of the rows is proved**, and is the whole of the block's argument:
`branch_split`, `second_branch_negative_T`, `T_zero_fails`, and `rows_force_spectrum`, which
takes the three rows plus `T ≥ 0`, `a, b > 0`, `λ₁ = a + b` and `λ₁² + a² + b² = 1`, and returns
`a = b`, `λ₁ = 2a`, `θ = 3a`, `T = 2`, `a = 1/√6` and `θ = √(3/2)`.

**A correction the record's own Lean file records and the block does not.** The block writes
*"`T = 0` fails (ii)"*; it does not, `(ii)` with `T = 0` gives `θ = -a`, which is satisfiable.
What fails is the **pair** `(i)` and `(ii)`. `T_zero_fails` takes both.

**No sign hypothesis on `θ` is used**: `θ = 3a > 0` comes out rather than going in.

## What is NOT typed here

* **The overdetermination count** (*"`r` equations against `C(r,3)` live entries"*), is a remark
  about the shape of the system, not part of the boxed lemma, and is not stated.
* **That the stratum is nonempty.** `witness_arithmetic` below exhibits numbers satisfying every
  hypothesis of `rows_force_spectrum`, so that theorem is not vacuous; exhibiting a Weyl tensor
  satisfying `L72`'s hypotheses is geometric content this file does not attempt.
-/

namespace HamiltonsCubic.L72Statement

open HamiltonsCubic.RealLayer

/-! ## The arithmetic of the three rows, proved -/

/-- **`a·(ii) = b·(iii)` gives the branch equation.** Both sides equal `T λ₁ a b`, so
`a²(θ+a) = b²(θ+b)`, which factors as `(a-b)(θ(a+b) + a² + ab + b²) = 0`. -/
theorem branch_split (a b th T lam : ℝ)
    (hii : T * lam * b = a * (th + a)) (hiii : T * lam * a = b * (th + b)) :
    (a - b) * (th * (a + b) + a ^ 2 + a * b + b ^ 2) = 0 := by
  have h : a ^ 2 * (th + a) = b ^ 2 * (th + b) := by
    linear_combination b * hiii - a * hii
  linear_combination h

/-- **The second branch forces `T < 0`.** With `θ(a+b) = -(a²+ab+b²)` and `λ₁ = a + b`, row (ii)
gives `T λ₁² = -ab`, so `T = -ab/λ₁² < 0`, impossible for a `T` that is a square. -/
theorem second_branch_negative_T {a b th T : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hbranch : th * (a + b) + a ^ 2 + a * b + b ^ 2 = 0)
    (hii : T * (a + b) * b = a * (th + a)) : T * (a + b) ^ 2 = -(a * b) := by
  have hab : 0 < a + b := by linarith
  have hth : th * (a + b) = -(a ^ 2 + a * b + b ^ 2) := by linarith
  have h1 : (th + a) * (a + b) = -(b ^ 2) := by nlinarith [hth]
  have h2 : T * (a + b) * b * (a + b) = a * ((th + a) * (a + b)) := by
    rw [← mul_assoc] at *
    nlinarith [hii]
  nlinarith [h1, h2, hab]

/-- **And `T ≥ 0` therefore excludes it.** -/
theorem second_branch_impossible {a b th T : ℝ} (ha : 0 < a) (hb : 0 < b) (hT : 0 ≤ T)
    (hbranch : th * (a + b) + a ^ 2 + a * b + b ^ 2 = 0)
    (hii : T * (a + b) * b = a * (th + a)) : False := by
  have h := second_branch_negative_T ha hb hbranch hii
  nlinarith [h, mul_pos ha hb, sq_nonneg (a + b), hT]

/-- **`T = 0` fails the PAIR (i) & (ii), and neither row alone.** *(i)* forces `θ = λ₁ > 0`,
*(ii)* forces `θ = -a < 0`. The block writes that *(ii)* fails on its own; it does not. -/
theorem T_zero_fails {a b th lam : ℝ} (ha : 0 < a) (hlam : 0 < lam)
    (hi : (0:ℝ) * a * b = lam * (th - lam)) (hii : (0:ℝ) * lam * b = a * (th + a)) : False := by
  have h1 : th = lam := by
    have : lam * (th - lam) = 0 := by linarith [hi]
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · linarith
  have h2 : th = -a := by
    have : a * (th + a) = 0 := by linarith [hii]
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · linarith
  linarith

/-- **THE BLOCK'S ARGUMENT, END TO END.** The three rows, `T ≥ 0`, `a, b > 0`, trace-zero
`λ₁ = a + b` and unit norm `λ₁² + a² + b² = 1` force `a = b`, `λ₁ = 2a`, `θ = 3a`, `T = 2`, and
then `a = 1/√6` and `θ = √(3/2)`. *No sign hypothesis on `θ` enters.* -/
theorem rows_force_spectrum {a b th T lam : ℝ} (ha : 0 < a) (hb : 0 < b) (hT : 0 ≤ T)
    (htr : lam = a + b) (hnorm : lam ^ 2 + a ^ 2 + b ^ 2 = 1)
    (hi : T * a * b = lam * (th - lam))
    (hii : T * lam * b = a * (th + a))
    (hiii : T * lam * a = b * (th + b)) :
    a = b ∧ lam = 2 * a ∧ th = 3 * a ∧ T = 2 ∧ a = 1 / Real.sqrt 6 ∧ th = Real.sqrt (3 / 2) := by
  have hsplit := branch_split a b th T lam hii hiii
  have hab : a = b := by
    rcases mul_eq_zero.mp hsplit with h | h
    · linarith
    · exact (second_branch_impossible ha hb hT h (by rw [htr] at hii; exact hii)).elim
  subst hab
  have hlam2 : lam = 2 * a := by rw [htr]; ring
  subst hlam2
  have hane : a ≠ 0 := ne_of_gt ha
  -- `T = 0` is excluded by the PAIR (i) & (ii)
  have hTne : T ≠ 0 := by
    intro h
    subst h
    exact T_zero_fails (a := a) (b := a) (th := th) (lam := 2 * a) ha (by linarith) hi hii
  -- row (i) gives `T a = 2(θ - 2a)`; row (ii) gives `2 T a = θ + a`
  have e1 : T * a = 2 * (th - 2 * a) := by
    refine mul_right_cancel₀ hane ?_
    linear_combination hi
  have e2 : 2 * (T * a) = th + a := by
    refine mul_right_cancel₀ hane ?_
    linear_combination hii
  have hth : th = 3 * a := by linarith [e1, e2]
  have hTval : T = 2 := by
    refine mul_right_cancel₀ hane ?_
    rw [e1, hth]; ring
  have hsix : 6 * a ^ 2 = 1 := by nlinarith [hnorm]
  have h6 : (0:ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hsq6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have haval : a = 1 / Real.sqrt 6 := by
    have hpos : 0 < a * Real.sqrt 6 := mul_pos ha h6
    have hfac : (a * Real.sqrt 6 - 1) * (a * Real.sqrt 6 + 1) = 0 := by
      have : (a * Real.sqrt 6) ^ 2 = 1 := by
        rw [mul_pow, hsq6]; linarith [hsix]
      linear_combination this
    rw [eq_div_iff (ne_of_gt h6)]
    rcases mul_eq_zero.mp hfac with h | h
    · linarith
    · linarith
  refine ⟨rfl, rfl, hth, hTval, haval, ?_⟩
  have h32 : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have h32pos : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
  have hthsq : th ^ 2 = 3 / 2 := by rw [hth]; nlinarith [hsix]
  have hthpos : 0 < th := by rw [hth]; linarith
  have hfac : (th - Real.sqrt (3 / 2)) * (th + Real.sqrt (3 / 2)) = 0 := by
    linear_combination hthsq - h32
  rcases mul_eq_zero.mp hfac with h | h
  · linarith
  · linarith

/-- **The hypotheses of `rows_force_spectrum` are satisfiable**, so it is not vacuous:
`a = b = 1/√6`, `λ₁ = 2/√6`, `θ = 3/√6`, `T = 2`. -/
theorem witness_arithmetic :
    ∃ a b th T lam : ℝ, 0 < a ∧ 0 < b ∧ 0 ≤ T ∧ lam = a + b ∧ lam ^ 2 + a ^ 2 + b ^ 2 = 1 ∧
      T * a * b = lam * (th - lam) ∧ T * lam * b = a * (th + a) ∧ T * lam * a = b * (th + b) := by
  have h6 : (0:ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hsq : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  refine ⟨1 / Real.sqrt 6, 1 / Real.sqrt 6, 3 / Real.sqrt 6, 2, 2 / Real.sqrt 6,
    by positivity, by positivity, by norm_num, by ring, ?_, ?_, ?_, ?_⟩
  · field_simp
    nlinarith [hsq]
  · field_simp
    ring
  · field_simp
    ring
  · field_simp
    ring

/-! ## The lemma -/

/-! ## The three rows, from `IsCritical` in the eigenframe -/

section Rows

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

/-- A critical point satisfies `Q(R) X = θ R X` on every bivector, not only on the `φ` basis. -/
theorem crit_all {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {th : ℝ} (hW : IsWeyl R) (hcrit : IsCritical R th)
    (X : Matrix ι ι ℝ) (hX : IsSkew X) : Qop R X = th • R X := by
  set c : ι × ι → ℝ := fun p => (1 / 2) * inner2 X (phi p.1 p.2) with hc
  set x : ι × ι → Matrix ι ι ℝ := fun p => phi p.1 p.2 with hx
  have hxs : ∀ p, IsSkew (x p) := fun p => HamiltonsCubic.RealLayer.phi_isSkew p.1 p.2
  have hE : X = ∑ p, c p • x p := by
    rw [Fintype.sum_prod_type]; exact phi_expand X hX
  have hR : R X = ∑ p, c p • R (x p) := by rw [hE]; exact weyl_lin hW _ c x hxs
  have hRR : R (R X) = ∑ p, c p • R (R (x p)) := by
    rw [hR]; exact weyl_lin hW _ c (fun p => R (x p)) (fun p => hW.1 _ (hxs p))
  have hS : sharpOp R X = ∑ p, c p • sharpOp R (x p) := by rw [hE]; exact sharpOp_lin hW hxs c
  have hQ : ∀ p, Qop R (x p) = th • R (x p) := fun p => hcrit p.1 p.2
  show R (R X) + sharpOp R X = th • R X
  rw [hRR, hS, hR, ← Finset.sum_add_distrib, Finset.smul_sum]
  refine Finset.sum_congr rfl fun p _ => ?_
  rw [← smul_add, smul_comm]
  have := hQ p
  unfold Qop compOp at this
  rw [this]

/-- **The criticality row in the frame**: `λ_β² + ½ Σ_{αγ} λ_α λ_γ c_{βαγ}² = θ λ_β`. -/
theorem crit_row {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {th : ℝ} (hW : IsWeyl R) (hcrit : IsCritical R th)
    {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ} (hf : EigenFrame R v lam) (β : Γ) :
    lam β ^ 2 + (1 / 2) * ∑ α, ∑ γ, lam α * lam γ * cst v β α γ ^ 2 = th * lam β := by
  have h := congrArg (fun Y => inner2 Y (v β)) (crit_all hW hcrit (v β) (hf.skew β))
  have hWs : R (lam β • v β) = lam β • R (v β) := by
    have := weyl_lin hW (Finset.univ : Finset (Fin 1)) (fun _ => lam β) (fun _ => v β)
      (fun _ => hf.skew β)
    simpa using this
  have h1 : inner2 (R (R (v β))) (v β) = lam β ^ 2 := by
    rw [hf.eigen β, hWs, hf.eigen β, inner2_smul_l, inner2_smul_l, hf.orthonormal, if_pos rfl]; ring
  have h2 : inner2 (sharpOp R (v β)) (v β)
      = (1 / 2) * ∑ α, ∑ γ, lam α * lam γ * cst v β α γ ^ 2 := by
    rw [inner2_comm, inner_sharpOp hW _ (hf.skew β), sharpQF_frame hW hf _ (hf.skew β)]; rfl
  have h3 : inner2 (th • R (v β)) (v β) = th * lam β := by
    rw [hf.eigen β, inner2_smul_l, inner2_smul_l, hf.orthonormal, if_pos rfl]; ring
  simp only [Qop, compOp, inner2_add_l, h1, h2, h3] at h
  exact h

/-- A sum supported on three distinct indices. -/
theorem sum3 {p a b : Γ} (hpa : p ≠ a) (hpb : p ≠ b) (hab : a ≠ b) (f : Γ → ℝ)
    (hrest : ∀ α, α ≠ p → α ≠ a → α ≠ b → f α = 0) : ∑ α, f α = f p + f a + f b := by
  rw [← Finset.sum_subset (Finset.subset_univ {p, a, b}) (fun α _ hα => by
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hα
    exact hrest α hα.1 hα.2.1 hα.2.2)]
  rw [Finset.sum_insert (by simp [hpa, hpb]), Finset.sum_insert (by simp [hab]), Finset.sum_singleton]
  ring

end Rows

/-- A complete orthonormal eigen-decomposition of a curvature operator on bivectors. *This is what
"spectrum" means in the block: `R` is self-adjoint on `Λ²` under `IsWeyl`, so such data exists;
the record's `(λ₁, -a, -b, 0, …)` is a statement about `lam`.* -/
structure EigenData {ι κ : Type*} [Fintype ι] [DecidableEq ι] [Fintype κ] [DecidableEq κ]
    (R : Matrix ι ι ℝ → Matrix ι ι ℝ) where
  /-- the eigenbivectors -/
  v : κ → Matrix ι ι ℝ
  /-- their eigenvalues -/
  lam : κ → ℝ
  skew : ∀ α, IsSkew (v α)
  ortho : ∀ α β, inner2 (v α) (v β) = if α = β then 1 else 0
  eigen : ∀ α, R (v α) = lam α • v α
  complete : ∀ X, IsSkew X → X = ∑ α, inner2 X (v α) • v α

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
/-- **LEMMA L72, in full.** *Every critical point of `𝒲ₙ` with exactly one positive and two
negative eigenvalues has spectrum `(2,-1,-1)/√6` on its support and `θ = √(3/2)`, for every `n`.*

**Proved.** `crit_all` extends the eigen-equation from the `φ` basis to every bivector, `crit_row`
pairs it with `v_β` to give `λ_β² + ½ Σ_{αγ} λ_α λ_γ c_{βαγ}² = θ λ_β`, which on the support
`{p, a, b}` is exactly the three rows with `T = c_{pab}²`. Trace-freeness gives `λ_p = a + b` and
[L41](L41Statement.lean)'s `normSq_frame` the unit norm, and `rows_force_spectrum` finishes.
*`hp` is not used: `λ_p = a + b > 0` follows from the other two signs.* -/
theorem L72 {ι κ : Type*} [Fintype ι] [DecidableEq ι] [Fintype κ] [DecidableEq κ]
    {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {th : ℝ}
    (hW : IsWeyl R) (hcrit : IsCritical R th) (hnorm : normSq R = 1)
    (E : EigenData (κ := κ) R)
    {p a b : κ} (hpa : p ≠ a) (hpb : p ≠ b) (hab : a ≠ b)
    (hp : 0 < E.lam p) (ha : E.lam a < 0) (hb : E.lam b < 0)
    (hrest : ∀ α, α ≠ p → α ≠ a → α ≠ b → E.lam α = 0) :
    E.lam p = 2 / Real.sqrt 6 ∧ E.lam a = -(1 / Real.sqrt 6) ∧ E.lam b = -(1 / Real.sqrt 6)
      ∧ th = Real.sqrt (3 / 2) := by
  have hf : EigenFrame R E.v E.lam := ⟨E.skew, E.ortho, E.eigen, E.complete⟩
  set v := E.v
  set lam := E.lam
  have S3 := fun f => sum3 hpa hpb hab (Γ := κ) f
  -- trace-freeness and the norm
  have htr : lam p + lam a + lam b = 0 := by
    have e1 := innerOp_frame hf R (fun X => X) (fun c => weyl_lin hW _ c v hf.skew) (fun c => rfl)
    have e3 : innerOp R (fun X => X) = 0 := by
      unfold innerOp
      have : ∀ i, ∑ j, inner2 (R (phi i j)) (phi i j) = 0 := fun i => hW.2.2.2 i i
      simp [this]
    rw [e3] at e1
    simp only [hf.eigen, inner2_smul_l, hf.orthonormal, if_true, mul_one] at e1
    rw [S3 _ hrest] at e1
    linarith
  have hn : lam p ^ 2 + lam a ^ 2 + lam b ^ 2 = 1 := by
    rw [normSq_frame hW hf, S3 (fun γ => lam γ ^ 2) (fun α h1 h2 h3 => by simp [hrest α h1 h2 h3])] at hnorm
    exact hnorm
  -- the structure constants
  have c12 : ∀ x y, cst v x x y = 0 := fun x y => by
    unfold cst; simp [br, inner2]
  have c23 : ∀ x y, cst v x y y = 0 := fun x y => by
    have := cst_swap23 hf x y y; linarith
  have c13 : ∀ x y, cst v x y x = 0 := fun x y => by
    rw [cst_swap23 hf, c12, neg_zero]
  set T := cst v p a b ^ 2 with hT
  have q1 : cst v p b a ^ 2 = T := by rw [T23 hf]
  have q2 : cst v a p b ^ 2 = T := by rw [T12 hf]
  have q3 : cst v a b p ^ 2 = T := by rw [T23 hf, T12 hf]
  have q4 : cst v b p a ^ 2 = T := by rw [T12 hf, T23 hf]
  have q5 : cst v b a p ^ 2 = T := by rw [T23 hf, T12 hf, T23 hf]
  -- the three rows
  have row : ∀ β, lam β ^ 2 + (1 / 2) * ((lam p * lam p * cst v β p p ^ 2 + lam p * lam a * cst v β p a ^ 2
      + lam p * lam b * cst v β p b ^ 2) + (lam a * lam p * cst v β a p ^ 2 + lam a * lam a * cst v β a a ^ 2
      + lam a * lam b * cst v β a b ^ 2) + (lam b * lam p * cst v β b p ^ 2 + lam b * lam a * cst v β b a ^ 2
      + lam b * lam b * cst v β b b ^ 2)) = th * lam β := by
    intro β
    have h := crit_row hW hcrit hf β
    have inner : ∀ α, ∑ γ, lam α * lam γ * cst v β α γ ^ 2
        = lam α * lam p * cst v β α p ^ 2 + lam α * lam a * cst v β α a ^ 2 + lam α * lam b * cst v β α b ^ 2 :=
      fun α => S3 _ (fun γ h1 h2 h3 => by simp [hrest γ h1 h2 h3])
    simp only [inner] at h
    rw [S3 _ (fun α h1 h2 h3 => by simp [hrest α h1 h2 h3])] at h
    exact h
  have ri := row p
  have rii := row a
  have riii := row b
  simp only [c12, c23, c13, q1, q2, q3, q4, q5] at ri rii riii
  have key := rows_force_spectrum (a := -lam a) (b := -lam b) (th := th) (T := T) (lam := lam p)
    (by linarith) (by linarith) (by positivity) (by linarith) (by nlinarith [hn])
    (by linarith [ri]) (by linarith [rii]) (by linarith [riii])
  obtain ⟨hab', hl2, -, -, ha6, hth⟩ := key
  refine ⟨?_, ?_, ?_, hth⟩
  · rw [hl2, ha6]; ring
  · linarith
  · linarith


end HamiltonsCubic.L72Statement
