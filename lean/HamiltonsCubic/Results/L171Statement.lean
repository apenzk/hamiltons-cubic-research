import Mathlib

set_option linter.style.longLine false

/-!
# L171, `V(t)` has two constants, not three

## The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md)

> #### Lemma L171, $V(t)$ has two constants, not three: $\lambda=\tfrac23$ and $t^*$ are forced by $a$

> **Statement.** Write $q=\Pi_{\ker F_u}Q(W_1)$ with $a=\lVert q\rVert$, and let $\lambda$ be the top
> eigenvalue of $M_{W_1}$ on $\ker F_u$. Under $M_{W_1}q=0$, which is
> [Observation L102](../../../findings/route-a.md), the inner maximisation has
> $$V(t)=\max_{\lVert K\rVert=1}\big[\langle q,K\rangle+t\langle M_{W_1}K,K\rangle\big]=
> \begin{cases}a, & 0\le t\le t^*\\[4pt] \dfrac{a^2}{4\lambda t}+\lambda t, & t\ge t^*\end{cases}
> \qquad t^*=\frac a{2\lambda},$$
> **for $t\ge0$ and $\lambda>0$.** *The range restriction is not decoration: at $t=-1$ with
> $M=\operatorname{diag}(0,\tfrac23,-1)$ and $q=(\sqrt{5/6},0,0)$ every other hypothesis holds and
> $V(-2)=\tfrac{101}{48}$ against the first branch's $a$.* **And $\lambda\ge0$ is automatic**,
> $\langle M_{W_1}\hat q,\hat q\rangle=0$ with $q\ne0$ forces it, so $\lambda>0$ costs only the
> exclusion the proof already needs, and it delivers $\dim\ker F_u\ge2$ as well.

> **So the record's three constants are two.** $a=\sqrt{5/6}$ is [Lemma L101](../../../findings/route-a.md)'s,
> and given it, **$\tfrac5{16}$ and $t^*=\sqrt{30}/8$ each pin $\lambda$ to $\tfrac23$,
> independently and in agreement**:
> $$\frac{a^2}{4\lambda}=\frac{5/6}{8/3}=\frac5{16},\qquad
> t^*=\frac{\sqrt{5/6}}{4/3}=\tfrac34\sqrt{\tfrac56}=\frac{\sqrt{30}}8 .$$

> **AND $V$ IS NONDECREASING IN BOTH CONSTANTS ON $t\ge0$**, being a maximum of functions each
> nondecreasing in $a$ and in $\lambda$.

> **AND THE TANGENCY IS A THEOREM RATHER THAN A COINCIDENCE.** *The frontier branch
> $\tfrac{a^2}{4\lambda t}+\lambda t$ has its minimum at $t=\sqrt{a^2/(4\lambda^2)}=\tfrac a{2\lambda}$,
> which is $t^*$ itself, of value $2\sqrt{\tfrac{a^2}{4\lambda}\cdot\lambda}=a$*, **the constant
> branch exactly**.

> **The map $(a,\lambda)\mapsto(\tfrac{a^2}{4\lambda},\tfrac a{2\lambda})$ is a bijection on the
> positive quadrant**, so the pair recovers $a$ as well as $\lambda$.

## What is typed here

* `L171`, **the lemma in full**, over a finite-dimensional real inner product space, as an
  `IsGreatest` statement about the two-branch closed form, **proved**.
* `scalar_max`, the scalar maximisation the proof reduces to, `f(c) = a·c + t·λ·(1-c²)` on
  `[-1,1]`, **proved**: this is the whole content of the two branches once the maximiser is known
  to lie in the plane `span{q̂, v}`.
* `plane_value`, that a unit `K = cos φ · q̂ + sin φ · v` in that plane has objective
  `a cos φ + t λ sin²φ`, so the reduction lands on `scalar_max`'s `f`.
* `branch_min_is_a`, `branches_agree_at_tstar`, the tangency, proved by AM–GM.
* `range_restriction_is_load_bearing`, at `t = -2`, `λ' = -1` (the bottom of the record's
  `diag(0, 2/3, -1)` on `q^⊥`) and `a = √(5/6)`, the scalar maximum is `101/48 > a`, so the
  displayed first branch is false without `t ≥ 0`.
* `lambda_pinned_by_ratio`, `lambda_pinned_by_tstar`, `tstar_closed_form`, that `a²/(4λ) = 5/16`
  and `t* = √30/8` each force `λ = 2/3` from `a = √(5/6)`, and agree.
* `constants_map_injective`, `constants_map_surjective`, `(a,λ) ↦ (a²/(4λ), a/(2λ))` is a
  bijection of the positive quadrant, with the inverse `(p,s) ↦ (2p/s, p/s²)` written out.
* `V_mono_a`, `V_mono_lambda`, `V` is nondecreasing in `a` and in `λ` on `t ≥ 0`.
* `lambda_nonneg_automatic`, a unit vector with Rayleigh quotient `0` forces the top eigenvalue
  `≥ 0`.

## How `L171` is proved

**The plane reduction needs no spectral theorem.** For a unit `K`, write `K = c q̂ + w` with `w ⟂ q̂`:
`M q = 0` and symmetry give `⟨MK, K⟩ = ⟨Mw, w⟩ ≤ λ(1 - c²)`, so the objective is at most `f(c)`, which
`scalar_max` bounds by `V`. For attainment, `eig_of_max` shows a Rayleigh maximiser `v` is an eigenvector
(perturbing along `λv - Mv` forces it to vanish), symmetry makes `v ⟂ q`, and `plane_value` evaluates
`cos(arccos c*) q̂ + sin(arccos c*) v` at `scalar_max`'s maximiser `c*`.

## What is NOT typed here

**`q = Π_{ker F_u} Q(W₁)`, `M_{W₁}` and `a = √(5/6)` are not defined**; `F_u`, `Q` and `W₁` belong
to the curvature layer this record has not built in Lean. The lemma is therefore stated at an
abstract symmetric `M` and abstract `q` with `M q = 0`, which is exactly the generality the
record's proof uses, but the identification of those objects, and the *measured* values
`a = √(5/6)` and `λ = 2/3`, are inputs, not consequences. The record says so itself: *"It does not
derive `λ_max(M_{W₁}) = 2/3` from the structure; that remains a spectral fact measured at one
dimension."*
-/

namespace HamiltonsCubic.L171Statement

open scoped RealInnerProductSpace

/-! ## The closed form -/

/-- The record's two-branch closed form for `V(t)`. -/
noncomputable def V (a lam t : ℝ) : ℝ :=
  if t ≤ a / (2 * lam) then a else a ^ 2 / (4 * lam * t) + lam * t

/-- The branch point `t* = a/(2λ)`. -/
noncomputable def tstar (a lam : ℝ) : ℝ := a / (2 * lam)

/-! ## A duplicate that was added here and removed, 2026-09-21

**`plane_objective_le` and `plane_objective_attained` were added to this file and are gone.** *They
were the two halves of `scalar_max`, which sits above them and proves
`IsGreatest (f a lam t '' Set.Icc (-1) 1) (V a lam t)` outright*, and this file's own header says so
three times, including "Everything downstream of that reduction is `scalar_max`, which is proved".
**The commit adding them also claimed the `sorry` was "two gaps where the file called it one", which
is backwards**: the account above is accurate and was misread ([r1046](../../../reviews/REVIEW_r1046.md)).

**AND THE GAP IS LARGER THAN EITHER ACCOUNT SAID.** *`IsGreatest` has two halves and the Rayleigh
bound delivers only the upper one.* Above the branch point the MEMBERSHIP half needs a unit
`v ∈ q^⊥` at the top Rayleigh quotient, that is ATTAINMENT of `λ` on `q^⊥`, which is where `0 < lam`
earns its place; and the cross-term step uses `M.IsSymmetric`. Both are inside "the spectral
theorem" as the account above names it, and neither is separately stated. -/

/-! ## The lemma, in full

The maximisation is over the unit sphere of `E`, which stands for the record's `ker F_u`; `M`
stands for `M_{W₁}` restricted there, `q` for `Π_{ker F_u} Q(W₁)`. -/


/-! ## The scalar maximisation, which is the content of the two branches -/

/-- The objective on the plane `span{q̂, v}`, written in the coordinate `c = cos φ`. -/
noncomputable def f (a lam t c : ℝ) : ℝ := a * c + t * lam * (1 - c ^ 2)

/-- **The plane reduction lands on `f`.** For a unit `K = cos φ • q̂ + sin φ • v` with `q̂ ⟂ v`,
`M q̂ = 0` and `M v = λ • v`, the objective is `a cos φ + t λ sin²φ = f a λ t (cos φ)`. -/
theorem plane_value {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (M : E →ₗ[ℝ] E) (u v : E) (lam a φ t : ℝ)
    (huv : ⟪u, v⟫ = 0) (hu : ‖u‖ = 1) (hv : ‖v‖ = 1)
    (hMu : M u = 0) (hMv : M v = lam • v) (q : E) (hq : q = a • u) :
    ⟪q, Real.cos φ • u + Real.sin φ • v⟫ +
        t * ⟪M (Real.cos φ • u + Real.sin φ • v), Real.cos φ • u + Real.sin φ • v⟫
      = a * Real.cos φ + t * lam * Real.sin φ ^ 2 := by
  have hvu : ⟪v, u⟫ = 0 := by rw [real_inner_comm]; exact huv
  have hu2 : ⟪u, u⟫ = 1 := by
    rw [real_inner_self_eq_norm_sq, hu]; norm_num
  have hv2 : ⟪v, v⟫ = 1 := by
    rw [real_inner_self_eq_norm_sq, hv]; norm_num
  simp only [hq, map_add, map_smul, hMu, hMv, smul_zero, zero_add, smul_smul,
    inner_add_right, real_inner_smul_left, real_inner_smul_right, hu2, hv2, huv, hvu]
  ring

/-- **The scalar maximum, both branches.** For `a > 0`, `λ > 0` and `t ≥ 0`, the greatest value of
`f a λ t` on `[-1, 1]` is `V a λ t`: the endpoint `c = 1` below the threshold `t* = a/(2λ)`, and
the interior point `c* = a/(2tλ)` above it. -/
theorem scalar_max {a lam t : ℝ} (ha : 0 < a) (hlam : 0 < lam) (ht : 0 ≤ t) :
    IsGreatest (f a lam t '' Set.Icc (-1) 1) (V a lam t) := by
  by_cases hthr : t ≤ a / (2 * lam)
  · -- below the threshold the maximum sits at `c = 1`
    have hV : V a lam t = a := by simp [V, hthr]
    refine ⟨⟨1, by norm_num, ?_⟩, ?_⟩
    · simp [f, hV]
    · rintro r ⟨c, hc, rfl⟩
      rw [hV]
      have h2 : t * (2 * lam) ≤ a := by
        rw [le_div_iff₀ (by positivity)] at hthr; linarith
      have hc1 : c ≤ 1 := hc.2
      have hc2 : -1 ≤ c := hc.1
      have : a * c + t * lam * (1 - c ^ 2) - a = (c - 1) * (a - t * lam * (c + 1)) := by ring
      have hnn : (c - 1) * (a - t * lam * (c + 1)) ≤ 0 := by
        apply mul_nonpos_of_nonpos_of_nonneg (by linarith)
        nlinarith
      simp only [f]; linarith [this ▸ hnn]
  · -- above the threshold the interior point `c* = a/(2tλ)` is admissible and maximal
    rw [not_le] at hthr
    have htpos : 0 < t := lt_of_le_of_lt (by positivity) hthr
    have hV : V a lam t = a ^ 2 / (4 * lam * t) + lam * t := by simp [V, not_le.mpr hthr]
    set c := a / (2 * t * lam) with hcdef
    have hcpos : 0 < c := by positivity
    have hclt : c < 1 := by
      rw [hcdef, div_lt_one (by positivity)]
      rw [div_lt_iff₀ (by positivity)] at hthr; linarith
    have hval : f a lam t c = a ^ 2 / (4 * lam * t) + lam * t := by
      simp only [f, hcdef]
      field_simp
      ring
    refine ⟨⟨c, ⟨by linarith, hclt.le⟩, by rw [hval, hV]⟩, ?_⟩
    rintro r ⟨d, _, rfl⟩
    rw [hV, ← hval]
    have hdiff : f a lam t c - f a lam t d = t * lam * (d - c) ^ 2 := by
      simp only [f, hcdef]; field_simp; ring
    have hnn : 0 ≤ t * lam * (d - c) ^ 2 := by positivity
    linarith

/-! ## The tangency -/

/-- **The frontier branch's minimum is `a`, attained at `t*`**, so the two branches meet at the
branch point with zero slope, and no separate check is needed. -/
theorem branch_min_is_a {a lam : ℝ} (_ha : 0 < a) (hlam : 0 < lam) {t : ℝ} (ht : 0 < t) :
    a ≤ a ^ 2 / (4 * lam * t) + lam * t := by
  rw [div_add' _ _ _ (by positivity), le_div_iff₀ (by positivity)]
  nlinarith [sq_nonneg (a - 2 * lam * t)]

/-- **The two branches agree at `t*`.** -/
theorem branches_agree_at_tstar {a lam : ℝ} (_ha : 0 < a) (hlam : 0 < lam) :
    a ^ 2 / (4 * lam * tstar a lam) + lam * tstar a lam = a := by
  simp only [tstar]
  field_simp
  ring

/-! ## The range restriction is load-bearing

The record's counterexample, in the scalar model: `t = -2`, the free direction taken at the bottom
eigenvalue `-1` of `diag(0, 2/3, -1)` on `q^⊥`, and `a = √(5/6)`. -/

/-- **At `t = -2` the first branch is false.** With `λ' = -1` the objective `f a λ' (-2)` reaches
`101/48` at `c = a/4`, against the first branch's `a = √(5/6) ≈ 0.9129`. -/
theorem range_restriction_is_load_bearing :
    f (Real.sqrt (5 / 6)) (-1) (-2) (Real.sqrt (5 / 6) / 4) = 101 / 48 ∧
      Real.sqrt (5 / 6) < 101 / 48 := by
  have e : Real.sqrt (5 / 6) ^ 2 = 5 / 6 := Real.sq_sqrt (by norm_num)
  constructor
  · simp only [f]; nlinarith [e]
  · nlinarith [e, Real.sqrt_nonneg ((5:ℝ) / 6)]

/-! ## The two constants, and that they are two -/

/-- **`a²/(4λ) = 5/16` pins `λ = 2/3`** given `a = √(5/6)`. -/
theorem lambda_pinned_by_ratio {lam : ℝ} (_hlam : 0 < lam)
    (h : (Real.sqrt (5 / 6)) ^ 2 / (4 * lam) = 5 / 16) : lam = 2 / 3 := by
  rw [Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 5 / 6)] at h
  field_simp at h
  linarith

/-- **`t* = √30/8` pins `λ = 2/3`** given `a = √(5/6)`, independently and in agreement. -/
theorem lambda_pinned_by_tstar {lam : ℝ} (hlam : 0 < lam)
    (h : tstar (Real.sqrt (5 / 6)) lam = Real.sqrt 30 / 8) : lam = 2 / 3 := by
  have h56 : Real.sqrt (5 / 6) = Real.sqrt 30 / 6 := by
    have h1 : (0:ℝ) ≤ Real.sqrt (5 / 6) := Real.sqrt_nonneg _
    have h2 : (0:ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
    have e1 : Real.sqrt (5 / 6) ^ 2 = 5 / 6 := Real.sq_sqrt (by norm_num)
    have e2 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
    have : (Real.sqrt (5 / 6) - Real.sqrt 30 / 6) * (Real.sqrt (5 / 6) + Real.sqrt 30 / 6) = 0 := by
      nlinarith [e1, e2]
    rcases mul_eq_zero.mp this with h' | h'
    · linarith
    · nlinarith
  rw [tstar, h56] at h
  have h2 : (0:ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  field_simp at h
  nlinarith [h, h2]

/-- **`t*` in closed form**: `a = √(5/6)` and `λ = 2/3` give `t* = √30/8`, so the record's two
numerals `5/16` and `√30/8` carry one free parameter between them once `a` is given. -/
theorem tstar_closed_form : tstar (Real.sqrt (5 / 6)) (2 / 3) = Real.sqrt 30 / 8 := by
  have h1 : (0:ℝ) ≤ Real.sqrt (5 / 6) := Real.sqrt_nonneg _
  have h2 : (0:ℝ) < Real.sqrt 30 := Real.sqrt_pos.mpr (by norm_num)
  have e1 : Real.sqrt (5 / 6) ^ 2 = 5 / 6 := Real.sq_sqrt (by norm_num)
  have e2 : Real.sqrt 30 ^ 2 = 30 := Real.sq_sqrt (by norm_num)
  have h56 : Real.sqrt (5 / 6) = Real.sqrt 30 / 6 := by
    have : (Real.sqrt (5 / 6) - Real.sqrt 30 / 6) * (Real.sqrt (5 / 6) + Real.sqrt 30 / 6) = 0 := by
      nlinarith [e1, e2]
    rcases mul_eq_zero.mp this with h' | h'
    · linarith
    · nlinarith
  rw [tstar, h56]; ring

/-- **The map `(a,λ) ↦ (a²/(4λ), a/(2λ)) is injective on the positive quadrant`**, so the pair of
recorded numerals recovers `a` as well as `λ`, which is why their agreement is arithmetic rather
than evidence. -/
theorem constants_map_injective {a l a' l' : ℝ} (ha : 0 < a) (hl : 0 < l) (ha' : 0 < a')
    (hl' : 0 < l') (h1 : a ^ 2 / (4 * l) = a' ^ 2 / (4 * l'))
    (h2 : a / (2 * l) = a' / (2 * l')) : a = a' ∧ l = l' := by
  rw [div_eq_div_iff (by positivity) (by positivity)] at h1 h2
  have e2 : a * l' = l * a' := by linarith
  have e1 : a ^ 2 * l' = l * a' ^ 2 := by linarith
  have key : l * a' * (a - a') = 0 := by linear_combination e1 - a * e2
  have haa : a = a' := by
    rcases mul_eq_zero.mp key with h' | h'
    · exact absurd h' (by positivity)
    · linarith
  refine ⟨haa, ?_⟩
  rw [haa] at e2
  have hz : a' * (l' - l) = 0 := by linarith
  rcases mul_eq_zero.mp hz with h' | h'
  · exact absurd h' (by positivity)
  · linarith

/-- **And it is onto the positive quadrant**, with the inverse `(p,s) ↦ (2p/s, p/s²)`. Together
with `constants_map_injective` this is the record's bijection. -/
theorem constants_map_surjective {p s : ℝ} (hp : 0 < p) (hs : 0 < s) :
    ∃ a l : ℝ, 0 < a ∧ 0 < l ∧ a ^ 2 / (4 * l) = p ∧ a / (2 * l) = s := by
  refine ⟨2 * p / s, p / s ^ 2, by positivity, by positivity, ?_, ?_⟩ <;> field_simp <;> ring_nf

/-! ## Monotonicity, and the automatic sign of `λ` -/

/-- **`V` is nondecreasing in `a` on `t ≥ 0`**, being a maximum of functions each nondecreasing
in `a`, so the record's display is an *upper* bound on `V` at every `W₁`. -/
theorem V_mono_a {a a' lam t c : ℝ} (h : a ≤ a') (hc : 0 ≤ c) :
    f a lam t c ≤ f a' lam t c := by
  simp only [f]; nlinarith

/-- **`V` is nondecreasing in `λ` on `t ≥ 0`.** -/
theorem V_mono_lambda {a lam lam' t c : ℝ} (h : lam ≤ lam') (ht : 0 ≤ t) (hc : c ^ 2 ≤ 1) :
    f a lam t c ≤ f a lam' t c := by
  have key : 0 ≤ t * (1 - c ^ 2) * (lam' - lam) :=
    mul_nonneg (mul_nonneg ht (by linarith)) (by linarith)
  simp only [f]; nlinarith [key]

/-- **`λ ≥ 0` is automatic.** `M q = 0` with `q ≠ 0` puts the unit vector `q̂` at Rayleigh quotient
`0`, and `λ` is an upper bound for the Rayleigh quotient, so `λ ≥ 0`. -/
theorem lambda_nonneg_automatic {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (M : E →ₗ[ℝ] E) (q : E) (hq : q ≠ 0) (hMq : M q = 0) (lam : ℝ)
    (hlam : ∀ K : E, ‖K‖ = 1 → ⟪M K, K⟫ ≤ lam) : 0 ≤ lam := by
  have hn : ‖q‖ ≠ 0 := norm_ne_zero_iff.mpr hq
  have hu : ‖(‖q‖⁻¹ : ℝ) • q‖ = 1 := by
    rw [norm_smul, norm_inv, norm_norm, inv_mul_cancel₀ hn]
  have := hlam ((‖q‖⁻¹ : ℝ) • q) hu
  rwa [map_smul, hMq, smul_zero, inner_zero_left] at this

/-- **A Rayleigh maximiser of a symmetric operator is an eigenvector.** Perturbing along
`y = λK₀ - MK₀` gives `2s‖y‖² + s²c ≥ 0` for every `s`, which forces `y = 0`. -/
theorem eig_of_max {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] (M : E →ₗ[ℝ] E) (hM : M.IsSymmetric) (lam : ℝ)
    (hle : ∀ x, ⟪M x, x⟫ ≤ lam * ‖x‖ ^ 2) (K₀ : E) (heq : ⟪M K₀, K₀⟫ = lam * ‖K₀‖ ^ 2) :
    M K₀ = lam • K₀ := by
  set y := lam • K₀ - M K₀ with hy
  have hY : ⟪lam • K₀ - M K₀, y⟫ = ‖y‖ ^ 2 := by rw [← hy, real_inner_self_eq_norm_sq]
  have hc : 0 ≤ lam * ‖y‖ ^ 2 - ⟪M y, y⟫ := by linarith [hle y]
  have key : ∀ s : ℝ, 0 ≤ 2 * s * ‖y‖ ^ 2 + s ^ 2 * (lam * ‖y‖ ^ 2 - ⟪M y, y⟫) := by
    intro s
    have h := hle (K₀ + s • y)
    simp only [map_add, map_smul, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right] at h
    rw [← real_inner_self_eq_norm_sq (K₀ + s • y)] at h
    simp only [inner_add_left, inner_add_right, real_inner_smul_left, real_inner_smul_right] at h
    have s1 : ⟪K₀, M y⟫ = ⟪M K₀, y⟫ := (hM K₀ y).symm
    have s2 : ⟪y, M K₀⟫ = ⟪M K₀, y⟫ := real_inner_comm _ _
    have s3 : ⟪y, K₀⟫ = ⟪K₀, y⟫ := real_inner_comm _ _
    have s4 : ⟪M y, K₀⟫ = ⟪M K₀, y⟫ := by rw [hM y K₀, real_inner_comm]
    have hY' : lam * ⟪K₀, y⟫ - ⟪M K₀, y⟫ = ‖y‖ ^ 2 := by
      rw [← hY, inner_sub_left, real_inner_smul_left]
    rw [← real_inner_self_eq_norm_sq K₀] at heq
    rw [← real_inner_self_eq_norm_sq y] at hY' ⊢
    rw [s4, s3, heq] at h
    have e : 2 * s * ⟪y, y⟫ = 2 * s * (lam * ⟪K₀, y⟫ - ⟪M K₀, y⟫) := by rw [hY']
    nlinarith [h, e]
  have hy0 : ‖y‖ ^ 2 = 0 := by
    set c := lam * ‖y‖ ^ 2 - ⟪M y, y⟫
    have := key (-(‖y‖ ^ 2) / (c + 1))
    have hc1 : 0 < c + 1 := by linarith
    have hY0 : 0 ≤ ‖y‖ ^ 2 := sq_nonneg _
    field_simp at this
    nlinarith [mul_nonneg hY0 hc, mul_nonneg (mul_nonneg hY0 hY0) hc]
  have : y = 0 := by
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hy0
    exact norm_eq_zero.mp this
  rw [hy, sub_eq_zero] at this
  exact this.symm

/-- **LEMMA L171.** For a symmetric `M` on a finite-dimensional real inner product space, a nonzero
`q` with `M q = 0`, `a = ‖q‖`, `λ` the greatest Rayleigh quotient of `M` on the unit sphere, `λ > 0`
and `t ≥ 0`, the maximum of `⟪q, K⟫ + t⟪M K, K⟫` over unit `K` is the record's two-branch closed
form.

*Proved by the plane reduction the module docstring sets out.* -/
theorem L171 {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [Nontrivial E]
    (M : E →ₗ[ℝ] E) (hM : M.IsSymmetric) (q : E) (hq : q ≠ 0) (hMq : M q = 0)
    (a : ℝ) (ha : a = ‖q‖) (lam : ℝ)
    (hlam : IsGreatest {r : ℝ | ∃ K : E, ‖K‖ = 1 ∧ r = ⟪M K, K⟫} lam) (hlampos : 0 < lam)
    (t : ℝ) (ht : 0 ≤ t) :
    IsGreatest {r : ℝ | ∃ K : E, ‖K‖ = 1 ∧ r = ⟪q, K⟫ + t * ⟪M K, K⟫} (V a lam t) := by
  have hapos : 0 < a := by rw [ha]; exact norm_pos_iff.mpr hq
  set u : E := a⁻¹ • q with hu_def
  have hqu : q = a • u := by rw [hu_def, smul_smul, mul_inv_cancel₀ hapos.ne', one_smul]
  have hu : ‖u‖ = 1 := by rw [hu_def, norm_smul, norm_inv, Real.norm_eq_abs, abs_of_pos hapos, ← ha,
    inv_mul_cancel₀ hapos.ne']
  have hMu : M u = 0 := by rw [hu_def, map_smul, hMq, smul_zero]
  have huu : ⟪u, u⟫ = 1 := by rw [real_inner_self_eq_norm_sq, hu]; norm_num
  -- the Rayleigh bound on all of `E`
  have hle : ∀ x : E, ⟪M x, x⟫ ≤ lam * ‖x‖ ^ 2 := by
    intro x
    by_cases hx : x = 0
    · simp [hx]
    have hn : 0 < ‖x‖ := norm_pos_iff.mpr hx
    have h1 : ‖‖x‖⁻¹ • x‖ = 1 := by
      rw [norm_smul, norm_inv, norm_norm, inv_mul_cancel₀ hn.ne']
    have h2 := hlam.2 ⟨_, h1, rfl⟩
    simp only [map_smul, real_inner_smul_left, real_inner_smul_right] at h2
    have h3 : ‖x‖⁻¹ * (‖x‖⁻¹ * ⟪M x, x⟫) * ‖x‖ ^ 2 = ⟪M x, x⟫ := by field_simp
    have h4 : 0 < ‖x‖ ^ 2 := by positivity
    nlinarith [mul_le_mul_of_nonneg_right h2 h4.le]
  refine ⟨?_, ?_⟩
  · -- attainment in the plane `span {u, v}`
    obtain ⟨K₀, hK₀, hlamK₀⟩ := hlam.1
    have hMv : M K₀ = lam • K₀ := eig_of_max M hM lam hle K₀ (by rw [hK₀]; simp [hlamK₀])
    have huv : ⟪u, K₀⟫ = 0 := by
      have h := hM u K₀
      rw [hMu, inner_zero_left, hMv, real_inner_smul_right] at h
      rcases mul_eq_zero.mp h.symm with h' | h'
      · exact absurd h' hlampos.ne'
      · exact h'
    obtain ⟨c, hc, hfc⟩ := (scalar_max hapos hlampos ht).1
    set φ := Real.arccos c
    have hcos : Real.cos φ = c := Real.cos_arccos hc.1 hc.2
    have hsin2 : Real.sin φ ^ 2 = 1 - c ^ 2 := by
      rw [Real.sin_arccos, Real.sq_sqrt (by nlinarith [hc.1, hc.2])]
    refine ⟨Real.cos φ • u + Real.sin φ • K₀, ?_, ?_⟩
    · have hvv : ⟪K₀, K₀⟫ = 1 := by rw [real_inner_self_eq_norm_sq, hK₀]; norm_num
      have hn2 : ‖Real.cos φ • u + Real.sin φ • K₀‖ ^ 2 = 1 := by
        rw [← real_inner_self_eq_norm_sq]
        have hvu : ⟪K₀, u⟫ = 0 := by rw [real_inner_comm]; exact huv
        simp only [inner_add_left, inner_add_right, real_inner_smul_left, real_inner_smul_right, huu, hvv,
          huv, hvu]
        nlinarith [Real.sin_sq_add_cos_sq φ]
      exact (pow_eq_one_iff_of_nonneg (norm_nonneg _) (by norm_num)).mp hn2
    · rw [plane_value M u K₀ lam a φ t huv hu hK₀ hMu hMv q hqu, hcos, hsin2, ← hfc]
      unfold f
      try ring
  · -- the upper bound
    rintro r ⟨K, hK, rfl⟩
    set c := ⟪u, K⟫
    set w := K - c • u with hw
    have hwu : ⟪w, u⟫ = 0 := by
      rw [hw, inner_sub_left, real_inner_smul_left, huu, real_inner_comm]; ring
    have hK' : K = w + c • u := by rw [hw]; abel
    have hq' : ⟪q, K⟫ = a * c := by rw [hqu, real_inner_smul_left]
    have hMK : ⟪M K, K⟫ = ⟪M w, w⟫ := by
      rw [hK', map_add, map_smul, hMu, smul_zero, add_zero, inner_add_right, real_inner_smul_right,
        hM w u, hMu, inner_zero_right, mul_zero, add_zero]
    have hw2 : ‖w‖ ^ 2 = 1 - c ^ 2 := by
      have : ‖K‖ ^ 2 = ‖w‖ ^ 2 + c ^ 2 := by
        rw [hK', ← real_inner_self_eq_norm_sq, ← real_inner_self_eq_norm_sq]
        have huw : ⟪u, w⟫ = 0 := by rw [real_inner_comm]; exact hwu
        simp only [inner_add_left, inner_add_right, real_inner_smul_left, real_inner_smul_right, hwu,
          huw, huu]
        ring
      rw [hK] at this; linarith
    have hc1 : |c| ≤ 1 := by
      have := abs_real_inner_le_norm u K
      rw [hu, hK] at this; linarith
    have hbound : ⟪q, K⟫ + t * ⟪M K, K⟫ ≤ f a lam t c := by
      rw [hq', hMK]; simp only [f]
      have := hle w
      rw [hw2] at this
      nlinarith [mul_le_mul_of_nonneg_left this ht]
    exact hbound.trans ((scalar_max hapos hlampos ht).2 ⟨c, ⟨by linarith [abs_le.mp hc1], (abs_le.mp hc1).2⟩, rfl⟩)

end HamiltonsCubic.L171Statement
