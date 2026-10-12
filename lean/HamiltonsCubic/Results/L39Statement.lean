import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.FrameExtension
import HamiltonsCubic.Results.L41Statement

/-!
# L39, the two-eigenvalue formula for an arbitrary symmetric pair, STATED

From [target.md](../../../findings/target.md), the block headed *"Lemma L39, the two-eigenvalue
formula for an arbitrary symmetric pair"*, quoted verbatim:

> **Statement.** Let $(\mathfrak g,\mathfrak k)$ be a symmetric pair inside $\mathfrak{so}(n)$ with
> $\mathfrak g=\mathfrak k\oplus\mathfrak m$ **orthogonal in the ambient $\Lambda^2$ metric**,
> $p=\dim\mathfrak k\ge1$, $q=\dim\mathfrak m\ge1$, and let $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$
> be the two-eigenvalue point, **extended by zero on $\mathfrak g^\perp$** and assumed to lie in
> $\mathcal W_n$. Then $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ and
> $$\theta^2=\frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}.$$
> **When $\mathfrak g$ is simple with Killing constant $c$, three invariants suffice**,
> $S_{\mathfrak{kmm}}=cq/2$ and hence $S_{\mathfrak{kkk}}=c(p-q/2)$ are both determined, and the
> display reduces exactly to
> $$\theta^2=\frac{\big(cq(3p-q)-4p(p-q)\big)^2}{16\,p^3q(p+q)},$$
> by $3p^2+2pq-q^2=(3p-q)(p+q)$.

> **Both vanishings are properties of the decomposition, free of $W$ and of any grading.**
> $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ kills $S_{\mathfrak{kkm}}$ and
> $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ kills $S_{\mathfrak{mmm}}$.
> **The denominator is produced rather than asserted**, by $a^6=q^3/(p^3(p+q)^3)$.

> **Two corollaries.** $q\le2p$ for every symmetric pair with $\mathfrak g$ simple and $c>0$,
> **with equality exactly when $\mathfrak k$ is abelian** […]. And at the balanced pair
> $(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$ with $p=k(k-1)$, $q=k^2$ and
> $c=4(k-1)$ **forced**, the numerator collapses to $4k^2(k-1)^2(2k-1)$ and the formula returns
> $\theta^2=\frac{(k-1)(2k-1)}{k^2}=\frac{2(n-1)(n-2)}{n^2}$ exactly. *That needs $k\ge3$.*

and the block's own list of what the two prose copies dropped:

> **WHAT IS OWED: FOUR LOAD-BEARING HYPOTHESES, NONE OF THEM ONCE STATED HERE.** *The $\Lambda^2$
> metric normalisation […]; the extension by zero on $\mathfrak g^\perp$ […]; $p,q\ge1$ […]; and
> **$W\in\mathcal W_n$ itself.*** *Also owed: $\mathfrak k\perp\mathfrak m$ in the AMBIENT form.*

**All four are hypotheses of `L39` below**, and two of them are structural rather than written: the
`Λ²` metric is [WeylReal.lean](../Base/WeylReal.lean)'s `inner2`, which carries the `½`, and the
extension by zero is forced by `twoEigen` being built from the two projections alone.

## What is proved

**The value `θ² = …` itself**, by completing the pair to an eigenframe of `W` with
[FrameExtension.lean](FrameExtension.lean) and reading `P(W)` off
[L41Statement.lean](L41Statement.lean)'s frame formulas. The file carries no `sorry`.

**Also proved:** both vanishing clauses `S_kkm = S_mmm = 0`, from the two bracket
closures and ambient orthogonality alone and with no reference to `W`, the record's *"properties of
the decomposition"*; the normalisation `a⁶ = q³/(p³(p+q)³)` that produces the denominator, from
trace-freeness and unit norm; the exact reduction of the four-invariant display to the
three-invariant one; `q ≤ 2p` with its equality case; and the balanced pair's collapse to
`2(n-1)(n-2)/n²`.
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L39Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {κ μ : Type*} [Fintype κ] [Fintype μ] [DecidableEq κ] [DecidableEq μ]

/-! ## Linearity of the `Λ²` pairing in its first slot -/

theorem inner2_zero_left (Y : Matrix ι ι ℝ) : inner2 (0 : Matrix ι ι ℝ) Y = 0 := by
  simp [inner2]

theorem inner2_add_left (X Y Z : Matrix ι ι ℝ) : inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  unfold inner2
  rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]
  ring

theorem inner2_smul_left (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  unfold inner2
  rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul]
  simp only [smul_eq_mul]
  ring

/-- **Anything in the span of a set orthogonal to `T` is orthogonal to `T`.** *This is the whole of
the record's "$[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ kills
$S_{\mathfrak{kkm}}$".* -/
theorem inner2_eq_zero_of_mem_span {S : Set (Matrix ι ι ℝ)} {T Y : Matrix ι ι ℝ}
    (hS : ∀ Z ∈ S, inner2 Z T = 0) (hY : Y ∈ Submodule.span ℝ S) : inner2 Y T = 0 := by
  induction hY using Submodule.span_induction with
  | mem x hx => exact hS x hx
  | zero => exact inner2_zero_left T
  | add x y _ _ hx hy => rw [inner2_add_left, hx, hy]; ring
  | smul c x _ hx => rw [inner2_smul_left, hx]; ring

/-! ## The symmetric pair, as data -/

/-- **A symmetric pair inside `𝔰𝔬(n)`, presented by orthonormal bases of its two summands.**

`kb` is an orthonormal basis of `𝔨` and `mb` one of `𝔪`, both inside the skew matrices, and the two
are orthogonal **in the ambient `Λ²` metric**, the hypothesis the record records as owed and which
fails for `𝔰𝔲(2)⊕𝔰𝔲(2)` inside `𝔰𝔬(12)` at unequal multiplicities. The three bracket clauses are
`[𝔨,𝔨] ⊆ 𝔨`, `[𝔨,𝔪] ⊆ 𝔪` and `[𝔪,𝔪] ⊆ 𝔨`, which is what *symmetric pair* means. -/
structure IsPair (kb : κ → Matrix ι ι ℝ) (mb : μ → Matrix ι ι ℝ) : Prop where
  kskew : ∀ a, IsSkew (kb a)
  mskew : ∀ x, IsSkew (mb x)
  korth : ∀ a b, inner2 (kb a) (kb b) = if a = b then 1 else 0
  morth : ∀ x y, inner2 (mb x) (mb y) = if x = y then 1 else 0
  cross : ∀ a x, inner2 (kb a) (mb x) = 0
  kk : ∀ a b, br (kb a) (kb b) ∈ Submodule.span ℝ (Set.range kb)
  km : ∀ a x, br (kb a) (mb x) ∈ Submodule.span ℝ (Set.range mb)
  mm : ∀ x y, br (mb x) (mb y) ∈ Submodule.span ℝ (Set.range kb)

/-! ## The four bracket masses -/

/-- `S_𝔨𝔨𝔨`, the bracket mass on `𝔨×𝔨×𝔨`. -/
noncomputable def Skkk (kb : κ → Matrix ι ι ℝ) : ℝ :=
  ∑ a : κ, ∑ b : κ, ∑ c : κ, inner2 (br (kb a) (kb b)) (kb c) ^ 2

/-- `S_𝔨𝔨𝔪`. -/
noncomputable def Skkm (kb : κ → Matrix ι ι ℝ) (mb : μ → Matrix ι ι ℝ) : ℝ :=
  ∑ a : κ, ∑ b : κ, ∑ x : μ, inner2 (br (kb a) (kb b)) (mb x) ^ 2

/-- `S_𝔨𝔪𝔪`. -/
noncomputable def Skmm (kb : κ → Matrix ι ι ℝ) (mb : μ → Matrix ι ι ℝ) : ℝ :=
  ∑ a : κ, ∑ x : μ, ∑ y : μ, inner2 (br (kb a) (mb x)) (mb y) ^ 2

/-- `S_𝔪𝔪𝔪`. -/
noncomputable def Smmm (mb : μ → Matrix ι ι ℝ) : ℝ :=
  ∑ x : μ, ∑ y : μ, ∑ z : μ, inner2 (br (mb x) (mb y)) (mb z) ^ 2

/-! ## The two-eigenvalue operator -/

/-- The orthogonal projection onto the span of an orthonormal family. -/
noncomputable def proj (fb : κ → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  ∑ a : κ, inner2 (fb a) X • fb a

/-- **`W = a Π_𝔨 + b Π_𝔪`, extended by zero on `𝔤^⊥`**, the extension being forced by the
definition rather than assumed. -/
noncomputable def twoEigen (kb : κ → Matrix ι ι ℝ) (mb : μ → Matrix ι ι ℝ) (a b : ℝ) :
    Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => a • proj kb X + b • proj mb X

/-! ## The two vanishing clauses, proved -/

/-- **`S_𝔨𝔨𝔪 = 0`**, from `[𝔨,𝔨] ⊆ 𝔨 ⊥ 𝔪` alone. *Free of `W` and of any grading.* -/
theorem Skkm_eq_zero {kb : κ → Matrix ι ι ℝ} {mb : μ → Matrix ι ι ℝ} (h : IsPair kb mb) :
    Skkm kb mb = 0 := by
  unfold Skkm
  refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ =>
    Finset.sum_eq_zero fun x _ => ?_
  have : inner2 (br (kb a) (kb b)) (mb x) = 0 := by
    refine inner2_eq_zero_of_mem_span ?_ (h.kk a b)
    rintro Z ⟨c, rfl⟩
    exact h.cross c x
  rw [this]; ring

/-- **`S_𝔪𝔪𝔪 = 0`**, from `[𝔪,𝔪] ⊆ 𝔨 ⊥ 𝔪` alone. -/
theorem Smmm_eq_zero {kb : κ → Matrix ι ι ℝ} {mb : μ → Matrix ι ι ℝ} (h : IsPair kb mb) :
    Smmm mb = 0 := by
  unfold Smmm
  refine Finset.sum_eq_zero fun x _ => Finset.sum_eq_zero fun y _ =>
    Finset.sum_eq_zero fun z _ => ?_
  have : inner2 (br (mb x) (mb y)) (mb z) = 0 := by
    refine inner2_eq_zero_of_mem_span ?_ (h.mm x y)
    rintro Z ⟨c, rfl⟩
    exact h.cross c z
  rw [this]; ring

/-! ## The statement -/

/-! ## The denominator is produced rather than asserted -/

/-- **`a⁶ = q³/(p³(p+q)³)`**, from trace-freeness and unit norm, the record's line that the
denominator `4p³q(p+q)³` is produced by the normalisation. -/
theorem a_pow_six {p q a b : ℝ} (hp : 0 < p) (hq : 0 < q)
    (htrace : a * p + b * q = 0) (hnorm : a ^ 2 * p + b ^ 2 * q = 1) :
    a ^ 6 = q ^ 3 / (p ^ 3 * (p + q) ^ 3) := by
  have hq0 : q ≠ 0 := ne_of_gt hq
  have hb : b = -(a * p) / q := by field_simp at htrace ⊢; linarith
  subst hb
  have hpq : (0:ℝ) < p + q := by linarith
  have key : a ^ 2 * (p * (p + q)) = q := by
    field_simp at hnorm
    nlinarith [hnorm]
  have hden : p ^ 3 * (p + q) ^ 3 ≠ 0 := by positivity
  have hcube : a ^ 6 * (p ^ 3 * (p + q) ^ 3) = q ^ 3 := by
    linear_combination ((a ^ 2 * (p * (p + q))) ^ 2 + (a ^ 2 * (p * (p + q))) * q + q ^ 2) * key
  rw [eq_div_iff hden]
  exact hcube

/-! ## The reduction to three invariants, when `𝔤` is simple -/

/-- **The general numerator factors**, once `S_kmm = cq/2` and hence `S_kkk = c(p − q/2)`. -/
theorem numerator_factors (p q c : ℝ) :
    (c * (p - q / 2)) * q ^ 2 + 3 * (c * q / 2) * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2
      = ((p + q) / 2) * (c * q * (3 * p - q) - 4 * p * (p - q)) := by
  ring

/-- **So the four-invariant display reduces exactly to the three-invariant one**, by
`3p² + 2pq − q² = (3p − q)(p + q)`, which pulls one factor of `(p+q)` out of the numerator. -/
theorem theta_sq_reduced {p q c : ℝ} (hp : 0 < p) (hq : 0 < q) :
    ((c * (p - q / 2)) * q ^ 2 + 3 * (c * q / 2) * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2) ^ 2
        / (4 * p ^ 3 * q * (p + q) ^ 3)
      = (c * q * (3 * p - q) - 4 * p * (p - q)) ^ 2 / (16 * p ^ 3 * q * (p + q)) := by
  have hpq : (0:ℝ) < p + q := by linarith
  have h1 : p ≠ 0 := ne_of_gt hp
  have h2 : q ≠ 0 := ne_of_gt hq
  have h3 : p + q ≠ 0 := ne_of_gt hpq
  rw [numerator_factors]
  field_simp
  ring

/-! ## The first corollary: `q ≤ 2p`, with its equality case -/

/-- `S_𝔨𝔨𝔨` is a sum of squares, hence non-negative. -/
theorem Skkk_nonneg (kb : κ → Matrix ι ι ℝ) : 0 ≤ Skkk kb :=
  Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ =>
    Finset.sum_nonneg fun _ _ => sq_nonneg _

/-- **`q ≤ 2p` for every symmetric pair with `𝔤` simple and `c > 0`.** *The input is
`S_kkk = c(p − q/2)` together with `S_kkk ≥ 0`, which is proved above rather than assumed.* -/
theorem q_le_two_p {kb : κ → Matrix ι ι ℝ} {p q c : ℝ} (hc : 0 < c)
    (hS : Skkk kb = c * (p - q / 2)) : q ≤ 2 * p := by
  have h := Skkk_nonneg kb
  rw [hS] at h
  nlinarith [h, hc]

/-- **Equality is exactly `S_kkk = 0`**, which is the vanishing of every structure constant on `𝔨`
the record's *"exactly when `𝔨` is abelian"*, stated at the level of the structure constants.

*The last step from there (that the brackets themselves vanish), needs `[𝔨,𝔨] ⊆ 𝔨` together with
the orthonormal expansion inside `𝔨`, and is not taken here.* -/
theorem q_eq_two_p_iff {kb : κ → Matrix ι ι ℝ} {p q c : ℝ} (hc : 0 < c)
    (hS : Skkk kb = c * (p - q / 2)) :
    q = 2 * p ↔ ∀ a b d : κ, inner2 (br (kb a) (kb b)) (kb d) = 0 := by
  constructor
  · intro h
    have hz : Skkk kb = 0 := by rw [hS, h]; ring
    intro a b d
    have h1 : ∀ a' ∈ (Finset.univ : Finset κ),
        (∑ b' : κ, ∑ d' : κ, inner2 (br (kb a') (kb b')) (kb d') ^ 2) = 0 := by
      refine (Finset.sum_eq_zero_iff_of_nonneg ?_).mp hz
      exact fun _ _ => Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _
    have h2 := h1 a (Finset.mem_univ a)
    have h3 : ∀ b' ∈ (Finset.univ : Finset κ),
        (∑ d' : κ, inner2 (br (kb a) (kb b')) (kb d') ^ 2) = 0 := by
      refine (Finset.sum_eq_zero_iff_of_nonneg ?_).mp h2
      exact fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _
    have h4 := h3 b (Finset.mem_univ b)
    have h5 : ∀ d' ∈ (Finset.univ : Finset κ), inner2 (br (kb a) (kb b)) (kb d') ^ 2 = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg (fun _ _ => sq_nonneg _)).mp h4
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp (h5 d (Finset.mem_univ d))
  · intro h
    have hz : Skkk kb = 0 := by
      unfold Skkk
      refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ =>
        Finset.sum_eq_zero fun d _ => ?_
      rw [h a b d]; ring
    rw [hS] at hz
    have : p - q / 2 = 0 := by
      rcases mul_eq_zero.mp hz with h' | h'
      · exact absurd h' (ne_of_gt hc)
      · exact h'
    linarith

/-! ## The second corollary: the balanced pair -/

/-- **At `(𝔰𝔬(2k), 𝔰𝔬(k)⊕𝔰𝔬(k))` the numerator collapses to `4k²(k−1)²(2k−1)`.** -/
theorem balanced_numerator (k : ℝ) :
    (4 * (k - 1)) * k ^ 2 * (3 * (k * (k - 1)) - k ^ 2) - 4 * (k * (k - 1)) * (k * (k - 1) - k ^ 2)
      = 4 * k ^ 2 * (k - 1) ^ 2 * (2 * k - 1) := by
  ring

/-- **And the formula returns `θ² = (k−1)(2k−1)/k²`**, at `p = k(k−1)`, `q = k²`, `c = 4(k−1)`.
*Read at `k ≥ 3`: at `k = 2` the pair's `𝔤 = 𝔰𝔬(4)` is not simple.* -/
theorem balanced_value {k : ℝ} (hk : 3 ≤ k) :
    ((4 * (k - 1)) * k ^ 2 * (3 * (k * (k - 1)) - k ^ 2)
        - 4 * (k * (k - 1)) * (k * (k - 1) - k ^ 2)) ^ 2
        / (16 * (k * (k - 1)) ^ 3 * k ^ 2 * (k * (k - 1) + k ^ 2))
      = (k - 1) * (2 * k - 1) / k ^ 2 := by
  have h1 : (0:ℝ) < k := by linarith
  have h2 : (0:ℝ) < k - 1 := by linarith
  have hkk : (0:ℝ) < k * (k - 1) := mul_pos h1 h2
  have hd : (0:ℝ) < 16 * (k * (k - 1)) ^ 3 * k ^ 2 * (k * (k - 1) + k ^ 2) :=
    mul_pos (mul_pos (mul_pos (by norm_num) (pow_pos hkk 3)) (pow_pos h1 2)) (by nlinarith)
  rw [balanced_numerator, div_eq_div_iff (ne_of_gt hd) (ne_of_gt (pow_pos h1 2))]
  ring

/-- **`(k−1)(2k−1)/k²` is `θ₀(n)² = 2(n−1)(n−2)/n²` at `n = 2k`, exactly.** -/
theorem balanced_is_theta0 {k : ℝ} (hk : 3 ≤ k) :
    (k - 1) * (2 * k - 1) / k ^ 2 = 2 * (2 * k - 1) * (2 * k - 2) / (2 * k) ^ 2 := by
  have hk0 : k ≠ 0 := by intro h; rw [h] at hk; linarith
  field_simp

/-! ## A witness for the normalisation, so the hypotheses are not empty -/

/-- **The smallest admissible pair is `(𝔰𝔲(2), 𝔲(1))` at `(p,q) = (1,2)`**, where the record records
`q = 2p` realised. The normalisation constraints are satisfiable there, which is what this
`example` exhibits: `a = −2/√6`, `b = 1/√6` is trace-free and of unit norm at `(p,q) = (1,2)`. -/
example : ∃ a b : ℝ, a * 1 + b * 2 = 0 ∧ a ^ 2 * 1 + b ^ 2 * 2 = 1 := by
  refine ⟨-2 / Real.sqrt 6, 1 / Real.sqrt 6, by ring, ?_⟩
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have hne : Real.sqrt 6 ≠ 0 := by positivity
  field_simp
  nlinarith [h6]

/-! ## The statement -/

/-- **L39.** For a symmetric pair presented as above, with `p = dim 𝔨 ≥ 1`, `q = dim 𝔪 ≥ 1`, and
`W = aΠ_𝔨 + bΠ_𝔪` the two-eigenvalue point, trace-free (`ap + bq = 0`), of unit norm
(`a²p + b²q = 1`), and **assumed to lie in `𝒲ₙ`**,

`θ(W)² = (S_kkk q² + 3 S_kmm p² − 2p³ + 2pq²)² / (4p³q(p+q)³)`.

**Proved.** `extend_frame` completes `𝔨 ∪ 𝔪` to an eigenframe of `W` with eigenvalues `a`, `b`
and `0`, and [L41Statement.lean](L41Statement.lean)'s `trCube_frame` and `sharpPair_T` give
`P(W) = pa³ + qb³ + ½(a³S_𝔨𝔨𝔨 + 3ab²S_𝔨𝔪𝔪)`: the `𝔨𝔨𝔪` and `𝔪𝔪𝔪` blocks vanish by the pair's
bracket clauses, and the three `𝔨𝔪𝔪` arrangements agree by the structure constants' antisymmetry.
`b = -ap/q` and `a_pow_six` then produce the display.

*`θ` is [WeylReal.lean](../Base/WeylReal.lean)'s, whose own docstring records that its `sharpPair`
term is even in `R` and so is `tr(R#)` rather than `⟨R#,R⟩`; the statement here is against that
`theta`, so that a repair at the base repairs this consumer with it.* -/
theorem L39 {kb : κ → Matrix ι ι ℝ} {mb : μ → Matrix ι ι ℝ} (hpair : IsPair kb mb)
    (p q : ℝ) (hp : p = Fintype.card κ) (hq : q = Fintype.card μ) (hp1 : 1 ≤ p) (hq1 : 1 ≤ q)
    (a b : ℝ) (htrace : a * p + b * q = 0) (hnorm : a ^ 2 * p + b ^ 2 * q = 1)
    (hW : IsWeyl (twoEigen kb mb a b)) :
    theta (twoEigen kb mb a b) ^ 2 =
      (Skkk kb * q ^ 2 + 3 * Skmm kb mb * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2) ^ 2
        / (4 * p ^ 3 * q * (p + q) ^ 3) := by
  classical
  let f : κ ⊕ μ → Matrix ι ι ℝ := Sum.elim kb mb
  have hmk : ∀ x c, inner2 (mb x) (kb c) = 0 := fun x c => by rw [inner2_comm]; exact hpair.cross c x
  have hfs : ∀ c, IsSkew (f c) := by rintro (c|c); exacts [hpair.kskew c, hpair.mskew c]
  have hfon : ∀ c d, inner2 (f c) (f d) = if c = d then 1 else 0 := by
    rintro (c|c) (d|d)
    · simp [f, hpair.korth]
    · simp [f, hpair.cross]
    · simp [f, hmk]
    · simp [f, hpair.morth]
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ := HamiltonsCubic.FrameExtension.extend_frame f hfs hfon
  have hkg : ∀ c d, inner2 (kb c) (g d) = 0 := fun c d => hfg (Sum.inl c) d
  have hmg : ∀ x d, inner2 (mb x) (g d) = 0 := fun x d => hfg (Sum.inr x) d
  have hgk : ∀ d c, inner2 (g d) (kb c) = 0 := fun d c => by rw [inner2_comm]; exact hkg c d
  have hgm : ∀ d x, inner2 (g d) (mb x) = 0 := fun d x => by rw [inner2_comm]; exact hmg x d
  let v : (κ ⊕ μ) ⊕ Fin r → Matrix ι ι ℝ := Sum.elim f g
  let lam : (κ ⊕ μ) ⊕ Fin r → ℝ := Sum.elim (Sum.elim (fun _ => a) (fun _ => b)) (fun _ => 0)
  have pk : ∀ Y : Matrix ι ι ℝ, proj kb Y = ∑ c, inner2 (kb c) Y • kb c := fun _ => rfl
  have hf : HamiltonsCubic.L41Statement.EigenFrame (twoEigen kb mb a b) v lam := by
    refine ⟨?_, ?_, ?_, ?_⟩
    · rintro ((c|c)|c)
      exacts [hpair.kskew c, hpair.mskew c, hgs c]
    · rintro ((c|c)|c) ((d|d)|d) <;>
        simp [v, f, hpair.korth, hpair.morth, hpair.cross, hmk, hkg, hmg, hgk, hgm, hgon]
    · rintro ((c|c)|c) <;>
        simp [twoEigen, proj, v, f, lam, hpair.korth, hpair.morth, hpair.cross, hmk, hkg, hmg]
    · intro X hX
      have h := hcomp X hX
      rw [Fintype.sum_sum_type] at h
      rw [Fintype.sum_sum_type, Fintype.sum_sum_type]
      exact h
  have hnsq := HamiltonsCubic.L41Statement.Frame.normSq_frame hW hf
  simp only [Fintype.sum_sum_type, lam, Sum.elim_inl, Sum.elim_inr, Finset.sum_const,
    Finset.card_univ, nsmul_eq_mul, Fintype.card_fin] at hnsq
  have hn1 : normSq (twoEigen kb mb a b) = 1 := by
    rw [hnsq, ← hp, ← hq]; linear_combination hnorm
  have hnorm' : HamiltonsCubic.RealLayer.norm (twoEigen kb mb a b) = 1 := by
    unfold HamiltonsCubic.RealLayer.norm; rw [hn1, Real.sqrt_one]
  -- the structure constants on the blocks
  have z_kkm : ∀ c d x, HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
      (Sum.inl (Sum.inl d)) (Sum.inl (Sum.inr x)) = 0 := fun c d x => by
    show inner2 (br (kb c) (kb d)) (mb x) = 0
    exact inner2_eq_zero_of_mem_span (by rintro Z ⟨e, rfl⟩; exact hpair.cross e x) (hpair.kk c d)
  have z_kmk : ∀ c x d, HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
      (Sum.inl (Sum.inr x)) (Sum.inl (Sum.inl d)) = 0 := fun c x d => by
    show inner2 (br (kb c) (mb x)) (kb d) = 0
    exact inner2_eq_zero_of_mem_span (by rintro Z ⟨y, rfl⟩; exact hmk y d) (hpair.km c x)
  have z_mkk : ∀ x c d, HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inr x))
      (Sum.inl (Sum.inl c)) (Sum.inl (Sum.inl d)) = 0 := fun x c d => by
    rw [HamiltonsCubic.L41Statement.Frame.cst_swap12 hf, z_kmk, neg_zero]
  have z_mmm : ∀ x y z, HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inr x))
      (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inr z)) = 0 := fun x y z => by
    show inner2 (br (mb x) (mb y)) (mb z) = 0
    exact inner2_eq_zero_of_mem_span (by rintro Z ⟨e, rfl⟩; exact hpair.cross e z) (hpair.mm x y)
  have hKKK : ∑ c, ∑ d, ∑ e, a * a * a * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
      (Sum.inl (Sum.inl d)) (Sum.inl (Sum.inl e)) ^ 2 = a ^ 3 * Skkk kb := by
    unfold Skkk
    simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ =>
      Finset.sum_congr rfl fun e _ => by
        simp only [HamiltonsCubic.L41Statement.Frame.cst, v, f, Sum.elim_inl, Sum.elim_inr]; ring
  have hKMM : ∑ c, ∑ x, ∑ y, a * b * b * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
      (Sum.inl (Sum.inr x)) (Sum.inl (Sum.inr y)) ^ 2 = a * b ^ 2 * Skmm kb mb := by
    unfold Skmm
    simp only [Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun x _ =>
      Finset.sum_congr rfl fun y _ => by
        simp only [HamiltonsCubic.L41Statement.Frame.cst, v, f, Sum.elim_inl, Sum.elim_inr]; ring
  have hMKM : ∑ x, ∑ c, ∑ y, b * a * b * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inr x))
      (Sum.inl (Sum.inl c)) (Sum.inl (Sum.inr y)) ^ 2 = a * b ^ 2 * Skmm kb mb := by
    rw [← hKMM, Finset.sum_comm]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun x _ =>
      Finset.sum_congr rfl fun y _ => by rw [HamiltonsCubic.L41Statement.Frame.cst_swap12 hf]; ring
  have hMMK : ∑ x, ∑ y, ∑ c, b * b * a * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inr x))
      (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inl c)) ^ 2 = a * b ^ 2 * Skmm kb mb := by
    have e : ∀ x y c, HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inr x))
        (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inl c)) ^ 2
        = HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
          (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inr x)) ^ 2 := by
      intro x y c
      rw [HamiltonsCubic.L41Statement.Frame.cst_swap12 hf, HamiltonsCubic.L41Statement.Frame.cst_swap23 hf,
        HamiltonsCubic.L41Statement.Frame.cst_swap12 hf]
      ring
    simp only [e]
    rw [← hKMM]
    calc _ = ∑ x, ∑ c, ∑ y, b * b * a * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
          (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inr x)) ^ 2 :=
          Finset.sum_congr rfl fun x _ => Finset.sum_comm
      _ = ∑ c, ∑ x, ∑ y, b * b * a * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
          (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inr x)) ^ 2 := Finset.sum_comm
      _ = ∑ c, ∑ y, ∑ x, b * b * a * HamiltonsCubic.L41Statement.Frame.cst v (Sum.inl (Sum.inl c))
          (Sum.inl (Sum.inr y)) (Sum.inl (Sum.inr x)) ^ 2 :=
          Finset.sum_congr rfl fun c _ => Finset.sum_comm
      _ = _ := Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun y _ =>
          Finset.sum_congr rfl fun x _ => by ring
  have hPval : Pcubic (twoEigen kb mb a b)
      = p * a ^ 3 + q * b ^ 3 + 1 / 2 * (a ^ 3 * Skkk kb + 3 * (a * b ^ 2 * Skmm kb mb)) := by
    unfold Pcubic
    rw [HamiltonsCubic.L41Statement.Frame.trCube_frame hW hf,
      HamiltonsCubic.L41Statement.Frame.sharpPair_T hW hf]
    simp only [Fintype.sum_sum_type, lam, Sum.elim_inl, Sum.elim_inr, Finset.sum_const,
      Finset.card_univ, nsmul_eq_mul, Fintype.card_fin, zero_mul, mul_zero, Finset.sum_const_zero,
      add_zero, zero_add, z_kkm, z_kmk, z_mkk, z_mmm, (zero_pow two_ne_zero : (0:ℝ) ^ 2 = 0),
      (zero_pow three_ne_zero : (0:ℝ) ^ 3 = 0), Finset.sum_add_distrib]
    rw [← hp, ← hq, hKKK, hKMM, hMKM, hMMK]
    ring
  have hp0 : 0 < p := by linarith
  have hq0 : 0 < q := by linarith
  have h6 := a_pow_six hp0 hq0 htrace hnorm
  have hb : b = -(a * p) / q := by field_simp; linarith
  have hP2 : Pcubic (twoEigen kb mb a b)
      = a ^ 3 * (Skkk kb * q ^ 2 + 3 * Skmm kb mb * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2) / (2 * q ^ 2) := by
    rw [hPval, hb]; field_simp; ring
  unfold theta
  rw [hnorm', one_pow, div_one, hP2,
    show (a ^ 3 * (Skkk kb * q ^ 2 + 3 * Skmm kb mb * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2) / (2 * q ^ 2)) ^ 2
      = a ^ 6 * (Skkk kb * q ^ 2 + 3 * Skmm kb mb * p ^ 2 - 2 * p ^ 3 + 2 * p * q ^ 2) ^ 2 / (4 * q ^ 4)
      by ring, h6]
  field_simp


end HamiltonsCubic.L39Statement
