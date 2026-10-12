import Mathlib
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Results.L74Statement
import HamiltonsCubic.Results.I73ScaleUnique

set_option linter.style.longLine false

/-!
# L144, no DGK point lies in the band except the balanced product

The record's block, quoted verbatim from
[diagonal-half.md](../../../findings/diagonal-half.md):

> #### Observation L144, no DGK point lies in the band except the balanced product
>
> **The normalisation is pinned from criticality alone**, so no transcription of the DGK
> conventions is needed: the constant equation *is* the strongly-regular identity, hence every
> strongly regular graph is a diagonal critical point (Lemma L74 proves this and gives the closed
> form in `(v,k,λ,μ)`). In the parameters used here,
> $$\theta(\Gamma)=\lvert1+\lambda-\mu\rvert\sqrt{\frac{2(n-1)}{nk(n-1-k)}} .$$
>
> > **THE IMPRIMITIVE HALF, PROVED.** Imprimitive strongly regular graphs give
> > `θ = √(2(n-1)(g-1)/(n(n-g)))`, **maximised uniquely at `g = n/2`**, which is the balanced
> > product.
>
> > **THE PRIMITIVE HALF, SCREENED AND NOT PROVED.** Primitive strongly regular graphs satisfy
> > `θ < ½` over the range examined … *a uniform bound over all primitive parameter sets is owed.*
>
> **What it discharges.** Granting the screened half, no DGK point lies in the band except the
> balanced product.

and the Gate 2 boxes that supersede those two, also verbatim:

> **THE PRIMITIVE HALF IS NOW PROVED, SO THIS IS A LEMMA.** In eigenvalue coordinates
> `θ² = 2f²μ(μ+B)/(ABCD)`, and using `D > A`, the AM–GM `A² ≥ 4μr(S+1)` and complement-invariance
> to assume `r ≥ S`, the bound reduces to one inequality **affine in `μ`** whose two coefficients
> both hold. **So `θ < ½` for every primitive strongly regular graph, at every `n`, with no census**
>, conference graphs giving `f = 0` exactly, and `¼` the **sharp, never-attained** supremum …
>
> **THE PARABOLA ROUTE ALONE FAILS, AND INTEGRALITY IS WHAT CARRIES IT.** `θ²` **is** convex in `μ`
> at fixed `(n,k)`, but at `(100,50,1)`, admissible, with `λ = 48.02 ≥ 0`, it returns
> `θ² = 1.8636 > 3/2`. *So the endpoint argument is not the proof, and multiplicity integrality is
> the load-bearing hypothesis.*
>
> **THE IMPRIMITIVE HALF IS MISSING THE TWO QUALIFIERS THAT REFUTED L96 …** `θ` is **strictly
> increasing** in `g` with no stationary point, and `g` runs over divisors of `n` with `g ≤ n/2`, so
> *"maximised uniquely at `g = n/2`"* needs **`n` even** and holds only **up to complementation**.
> *The conclusion is unharmed: every `g ≤ n/3` gives `θ² ≤ (n-1)(n-3)/n² < 1`, and the uniform bound
> one reviewer supplies covers the rest.*

## What this file types

The conclusion in full, with the two halves separated exactly as the record separates them.

**The imprimitive half, proved outright.**

* `thetaImpSq` is the record's `θ² = 2(n-1)(g-1)/(n(n-g))`.
* `thetaImpSq_strictMono`, **strictly increasing in `g`, with no stationary point**, on `1 ≤ g < n`.
* `thetaImpSq_lt_one`, **every `g ≤ n/3` gives `θ² < 1`**, hence out of the band.
* `divisor_step`, the qualifier that finishes it: a divisor `g ∣ n` with `n/3 < g ≤ n/2` has
  `2g = n`, since `n/g` is then an integer in `[2,3)`.
* `imprimitive_in_band`, putting those together: an imprimitive DGK point in the band has
  `2g = n`, and `thetaImpSq_at_half` identifies its value as `θ₀(n)²`, the balanced product's.
* `theta0Sq_in_band`, the balanced product **is** in the band at every `n ≥ 12`, which is
  `n² - 12n + 8 ≥ 0`, so the conclusion is not vacuous.

**The primitive half, proved.**

* `SRG` carries the parameters `(v,k,λ,μ)` as integers with the strongly-regular counting identity
  `k(k-λ-1) = (v-k-1)μ`, together with the restricted eigenvalues `r ≥ 0 > s` and their
  multiplicities `f, g` **as integers**, the multiplicity integrality the record names as the
  load-bearing hypothesis, without which its own witness `(100,50,1)` returns `θ² = 1.8636`.
* `SRG.Primitive` is `0 < μ < k`.
* `primitive_thetaSq_lt_quarter`, `θ² < ¼` for every primitive strongly regular graph, **proved**
  by an argument built here: the record's block gives only an outline (eigenvalue coordinates,
  `D > A`, an AM–GM, complement invariance, and one inequality affine in `μ`), and the proof here
  splits on `f = g` instead, using multiplicity integrality once (see its docstring).
* `primitive_not_in_band`, the consequence, `¼ < 3/2`.
* `clebsch`, the Clebsch graph `(16,5,0,2)` as an instance of `SRG`, so the structure's hypotheses
  are satisfiable and the primitive statement is not vacuous.

**The DGK point as a Weyl tensor, and criticality named.**

* `IsRegularGraph` and `IsSRG` are the adjacency matrix's own conditions, and `graphWeight` is the
  record's diagonal weight, `+1` on edges, `−k/(n−1−k)` on non-edges, which is its `a` and `−at`
  at `a = 1`.
* `graphWeight_rowSum` and `graphWeight_isWeight`, **the weight lies in `𝒟ₙ`**, the `k` edges
  cancelling the `n−1−k` non-edges identically.
* `graphWeight_isWeyl` and `realises_isWeyl`, **EVERY DGK POINT IS A WEYL TENSOR**, at every
  scale, through [Families.lean](../Base/Families.lean)'s `diagOp_isWeyl`. *So the comparison is
  inside `𝒲ₙ` rather than about a formula in `(v,k,λ,μ)` alone.* `realises_w_pos` gets the one
  side condition `n − 1 − k > 0` from `SRG`'s own `k < v − 1`, so no hypothesis is added.
* `L74Bridge`, **[Lemma L74](../../../findings/diagonal-half.md)'s content as a named `Prop`**:
  that a unit-norm DGK point is `IsCritical` at a multiplier whose square is the closed form. *It
  needs the CRITICALITY equation on the diagonal locus, `DiagCriticalityIsCritical`, which is
  PROVED as of 2026-09-21 by `diagCriticalityIsCritical` in [SharpDiag.lean](../Base/SharpDiag.lean),
  a file carrying no `sorry`. **AND THE DISCHARGE IS DONE, 2026-09-23: `l74Bridge_holds` PROVES
  `L74Bridge`**, so this is no longer a binder anyone is owed. *The paragraph below is kept for the
  history of what blocked it, and nothing in it is still outstanding.* **WHAT BLOCKS THE
  DISCHARGE IS A NAME COLLISION, NOT A MISSING PROOF, 2026-09-22.** *`srg_theta_closed_form_uncond`
  in [L74Statement.lean](L74Statement.lean) proves exactly this content unconditionally, but it
  speaks a DIFFERENT `IsSRG`: the tree carries THREE structures of that name, this file's taking
  `(A, k, lam, mu)` and extending `IsRegularGraph`, L74's taking `(A, v, k, lam, mu)` and carrying
  `card : Fintype.card ι = v`, and a third in [L96Statement.lean](L96Statement.lean) taking four.*
  **The weights DO agree and that half is one `ext`**: `graphWeight A k = A - (1-A)t = (1+t)A - t`
  with `t = k/(n-1-k)`, which is `srgWeight A (tOf n k)` exactly. *So the bridge is a translation
  between two spellings of one hypothesis, and the honest first step is to decide whether the three
  `IsSRG`s should be one.* `Pcubic` on the
  locus is `DiagCubicFormula` and is a DIFFERENT gap, now proved in
  [SharpDiag.lean](../Base/SharpDiag.lean), and neither conjunct of `L74Bridge` needs it.*
* `primitive_critical_not_in_band`, **the primitive half at the critical point itself**: on that
  bridge, a unit-norm DGK point of a primitive parameter set is a Weyl tensor, a critical point of
  `P`, and has `θ² < ¼`, hence out of the band.

**The conclusion.**

* `no_dgk_in_band_except_balanced`, at every `n ≥ 12`: no primitive DGK point is in the band, and
  every imprimitive one that is in the band has `2g = n` with `θ² = θ₀(n)²`.

## What is NOT typed here

* **That a strongly regular graph is a diagonal CRITICAL point**, and that the displayed closed
  form is its `θ`. That a DGK point is a **Weyl tensor** is now proved (`realises_isWeyl`); that it
  is critical, and at that multiplier, is [Lemma L74](../../../findings/diagonal-half.md)'s and WAS
  carried as the named hypothesis `L74Bridge`, **which `l74Bridge_holds` proves as of 2026-09-23**,
  so this bullet no longer names anything untyped. *It reduces to the CRITICALITY equation on the diagonal
  locus, `DiagCriticalityIsCritical`, and NOT to `DiagCubicFormula`. BOTH are now proved in
  [SharpDiag.lean](../Base/SharpDiag.lean), so the reduction names no outstanding gap.*
* **That a realising graph exists at each parameter set.** `Realises` relates an `SRG` to an
  adjacency matrix on `ι`, and no existence is claimed: `primitive_critical_not_in_band` is a
  statement about a graph supplied to it. *`clebsch` witnesses the parameter side only.*
* **The `±` of the multiplier.** The record's `θ(Γ) = |1+λ−μ|·√(2(n−1)/(nk(n−1−k)))` carries an
  absolute value because criticality is odd in `M`, so `±M` are both critical with `θ ↦ −θ`;
  `L74Bridge` fixes only `θ²`, and the sign branch is not typed.
* **That the two families above exhaust the DGK points**, i.e. that a strongly regular graph is
  primitive or imprimitive and that imprimitive ones are exactly the `g ∣ n` family with the
  displayed `θ`. The record states both; this file takes the split as the shape of its conclusion.
* **The primitive bound's sharpness**, that `¼` is the supremum. The bound itself is proved, and its
  strictness is the "never attained" half.
* **"Up to complementation"** in the imprimitive half, the file restricts to `2g ≤ n`, which is
  the record's own normalisation, and does not type the complementation that justifies it.
* **The record's own warning that "the band" carries two inequivalent senses.** `InBand` here is
  `3/2 ≤ θ²`, the sense under which the headline is non-vacuous.
-/

namespace HamiltonsCubic.L144Statement

/-! ## The band, and the balanced product's value -/

/-- The band, in the sense that makes the headline non-vacuous: `θ² ≥ 3/2`. -/
def InBand (thsq : ℝ) : Prop := 3 / 2 ≤ thsq

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`, the balanced product's own value. -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **The balanced product is in the band** at every `n ≥ 12`, which is `n² - 12n + 8 ≥ 0`. -/
theorem theta0Sq_in_band {n : ℝ} (hn : 12 ≤ n) : InBand (theta0Sq n) := by
  rw [InBand, theta0Sq, le_div_iff₀ (by positivity)]
  nlinarith

/-! ## The imprimitive half -/

/-- The record's imprimitive closed form, `θ² = 2(n-1)(g-1)/(n(n-g))`. -/
noncomputable def thetaImpSq (n g : ℝ) : ℝ := 2 * (n - 1) * (g - 1) / (n * (n - g))

/-- **Strictly increasing in `g`, with no stationary point**, the qualifier the record's Gate 2
box adds to the imprimitive half. -/
theorem thetaImpSq_strictMono {n g₁ g₂ : ℝ} (hn : 1 < n) (h1 : 1 ≤ g₁) (h12 : g₁ < g₂)
    (h2 : g₂ < n) : thetaImpSq n g₁ < thetaImpSq n g₂ := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hd1 : (0 : ℝ) < n * (n - g₁) := by
    apply mul_pos hn0; linarith
  have hd2 : (0 : ℝ) < n * (n - g₂) := by
    apply mul_pos hn0; linarith
  rw [thetaImpSq, thetaImpSq, div_lt_div_iff₀ hd1 hd2]
  have key : 2 * (n - 1) * (g₂ - 1) * (n * (n - g₁)) - 2 * (n - 1) * (g₁ - 1) * (n * (n - g₂))
      = 2 * n * (n - 1) ^ 2 * (g₂ - g₁) := by ring
  have hpos : (0 : ℝ) < 2 * n * (n - 1) ^ 2 * (g₂ - g₁) := by
    have h1' : (0 : ℝ) < (n - 1) ^ 2 := by positivity
    have h2' : (0 : ℝ) < g₂ - g₁ := by linarith
    positivity
  linarith

/-- **Every `g ≤ n/3` gives `θ² < 1`**, hence lies below the band. *The reduction is
`n(n-g) - 2(n-1)(g-1) = n(n-3g) + 2n + 2g - 2`, positive term by term.* -/
theorem thetaImpSq_lt_one {n g : ℝ} (hn : 12 ≤ n) (hg : 1 ≤ g) (h3 : 3 * g ≤ n) :
    thetaImpSq n g < 1 := by
  have hn0 : (0 : ℝ) < n := by linarith
  have hd : (0 : ℝ) < n * (n - g) := by
    apply mul_pos hn0; linarith
  rw [thetaImpSq, div_lt_one hd]
  nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ n) (by linarith : (0:ℝ) ≤ n - 3 * g)]

/-- **At `g = n/2` the value is the balanced product's `θ₀(n)²`.** -/
theorem thetaImpSq_at_half {n g : ℝ} (hn : 0 < n) (hg : 2 * g = n) :
    thetaImpSq n g = theta0Sq n := by
  have hgv : g = n / 2 := by linarith
  subst hgv
  have hne : n ≠ 0 := ne_of_gt hn
  rw [thetaImpSq, theta0Sq]
  field_simp
  ring

/-- **The divisor qualifier.** A divisor `g ∣ n` with `n < 3g` and `2g ≤ n` has `2g = n`, since
`n/g` is then an integer in `[2,3)`. -/
theorem divisor_step {n g : ℕ} (hdvd : g ∣ n) (hlt : n < 3 * g) (hle : 2 * g ≤ n) : 2 * g = n := by
  obtain ⟨q, rfl⟩ := hdvd
  have hg : 0 < g := by
    rcases Nat.eq_zero_or_pos g with h | h
    · subst h; simp at hlt
    · exact h
  have hle' : 2 * g ≤ q * g := by rw [Nat.mul_comm q g]; exact hle
  have hlt' : q * g < 3 * g := by rw [Nat.mul_comm q g]; exact hlt
  have h2 : 2 ≤ q := Nat.le_of_mul_le_mul_right hle' hg
  have h3 : q < 3 := Nat.lt_of_mul_lt_mul_right hlt'
  have hq : q = 2 := by omega
  subst hq
  ring

/-- **THE IMPRIMITIVE HALF.** An imprimitive DGK point in the band has `2g = n`, and its value is
then the balanced product's `θ₀(n)²`. -/
theorem imprimitive_in_band {n g : ℕ} (hn : 12 ≤ n) (hg : 1 ≤ g) (hdvd : g ∣ n)
    (hle : 2 * g ≤ n) (hband : InBand (thetaImpSq n g)) :
    2 * g = n ∧ thetaImpSq n g = theta0Sq n := by
  have hnR : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  have hgR : (1 : ℝ) ≤ (g : ℝ) := by exact_mod_cast hg
  have hlt : n < 3 * g := by
    by_contra hcon
    push_neg at hcon
    have h3R : 3 * (g : ℝ) ≤ (n : ℝ) := by exact_mod_cast hcon
    have := thetaImpSq_lt_one hnR hgR h3R
    rw [InBand] at hband
    linarith
  have heq := divisor_step hdvd hlt hle
  refine ⟨heq, thetaImpSq_at_half (by linarith) ?_⟩
  exact_mod_cast congrArg (fun x : ℕ => (x : ℝ)) heq

/-! ## The primitive half -/

/-- The parameters of a strongly regular graph, with the counting identity, the restricted
eigenvalues `r ≥ 0 > s`, and their multiplicities `f, g` **as integers**, the multiplicity
integrality the record names as the load-bearing hypothesis. -/
structure SRG where
  v : ℤ
  k : ℤ
  lam : ℤ
  mu : ℤ
  /-- The larger restricted eigenvalue. -/
  r : ℝ
  /-- The smaller restricted eigenvalue. -/
  s : ℝ
  /-- The multiplicity of `r`. -/
  f : ℤ
  /-- The multiplicity of `s`. -/
  g : ℤ
  hk : 0 < k
  hklt : k < v - 1
  hlam : 0 ≤ lam
  hmu : 0 ≤ mu
  /-- The strongly-regular counting identity. -/
  hident : k * (k - lam - 1) = (v - k - 1) * mu
  hr : 0 ≤ r
  hs : s < 0
  hsum : r + s = (lam : ℝ) - (mu : ℝ)
  hprod : r * s = -((k : ℝ) - (mu : ℝ))
  hmult : (f : ℝ) + (g : ℝ) = (v : ℝ) - 1
  htrace : (k : ℝ) + (f : ℝ) * r + (g : ℝ) * s = 0

/-- **Primitive**: neither the graph nor its complement is disconnected, i.e. `0 < μ < k`. -/
def SRG.Primitive (Γ : SRG) : Prop := 0 < Γ.mu ∧ Γ.mu < Γ.k

/-- The record's closed form, squared: `θ² = (1+λ-μ)² · 2(v-1)/(v k (v-1-k))`. -/
noncomputable def SRG.thetaSq (Γ : SRG) : ℝ :=
  ((1 : ℝ) + (Γ.lam : ℝ) - (Γ.mu : ℝ)) ^ 2 * (2 * ((Γ.v : ℝ) - 1)) /
    ((Γ.v : ℝ) * (Γ.k : ℝ) * ((Γ.v : ℝ) - 1 - (Γ.k : ℝ)))

/-- A rational root of a monic integer quadratic is an integer. -/
theorem rat_root_int {q : ℚ} {b c : ℤ} (h : q ^ 2 = b * q + c) : ∃ z : ℤ, (z : ℚ) = q := by
  have hd : (q.den : ℚ) ≠ 0 := by exact_mod_cast q.den_nz
  have hq : q = q.num / q.den := (Rat.num_div_den q).symm
  have key : (q.num : ℚ) ^ 2 = q.den * (b * q.num + c * q.den) := by
    have := h
    rw [hq] at this
    field_simp at this
    linear_combination this
  have keyZ : q.num ^ 2 = (q.den : ℤ) * (b * q.num + c * q.den) := by exact_mod_cast key
  have hdvd : (q.den : ℤ) ∣ q.num ^ 2 := ⟨_, keyZ⟩
  have hcop : IsCoprime (q.den : ℤ) q.num := by
    rw [Int.isCoprime_iff_gcd_eq_one]
    have := q.reduced
    rw [Int.gcd_comm]
    exact_mod_cast this
  have h1 : (q.den : ℤ) ∣ 1 :=
    (hcop.pow_right (n := 2)).dvd_of_dvd_mul_left (by simpa using hdvd : (q.den : ℤ) ∣ q.num ^ 2 * 1)
  have hden : q.den = 1 := by
    have := Int.eq_one_of_dvd_one (by positivity) h1
    exact_mod_cast this
  exact ⟨q.num, by rw [hq, hden]; simp⟩

/-- `2(r - B)² ≤ rB(r+1)(B+1)` at `r, B ≥ 1`. -/
theorem poly_le {r B : ℝ} (hr : 1 ≤ r) (hB : 1 ≤ B) : 2 * (r - B) ^ 2 ≤ r * B * (r + 1) * (B + 1) := by
  rcases le_total B r with h | h
  · have h1 : (r - B) ^ 2 ≤ r ^ 2 := by nlinarith
    have h2 : 2 * r ^ 2 ≤ r * B * (r + 1) * (B + 1) := by
      have : r * B * (r + 1) * (B + 1) = r * (r + 1) * (B * (B + 1)) := by ring
      rw [this]
      have hb : 2 ≤ B * (B + 1) := by nlinarith
      have hr' : 0 ≤ r * (r + 1) := by positivity
      nlinarith
    linarith
  · have h1 : (r - B) ^ 2 ≤ B ^ 2 := by nlinarith
    have h2 : 2 * B ^ 2 ≤ r * B * (r + 1) * (B + 1) := by
      have : r * B * (r + 1) * (B + 1) = B * (B + 1) * (r * (r + 1)) := by ring
      rw [this]
      have hb : 2 ≤ r * (r + 1) := by nlinarith
      have hr' : 0 ≤ B * (B + 1) := by positivity
      nlinarith
    linarith

/-- **The integral case's inequality**, in the eigenvalue coordinates `r ≥ 1`, `B = -s - 1 ≥ 1`,
`k = μ + r(B + 1)`. -/
theorem core_ineq {r B μ k v : ℝ} (hr : 1 ≤ r) (hB : 1 ≤ B) (hμ : 0 < μ) (hk : k = μ + r * (B + 1)) (hv : 1 < v) :
    (r - B) ^ 2 * (2 * (v - 1)) * 4 * μ < v * k ^ 2 * ((r + 1) * B) := by
  have hamgm : 4 * μ * (r * (B + 1)) ≤ k ^ 2 := by rw [hk]; nlinarith [sq_nonneg (μ - r * (B + 1))]
  have hp := poly_le hr hB
  have hY : 0 < k ^ 2 * ((r + 1) * B) := by
    have : 0 < k := by rw [hk]; positivity
    positivity
  have step : 8 * (r - B) ^ 2 * μ ≤ k ^ 2 * ((r + 1) * B) := by
    have e : 4 * μ * (r * B * (r + 1) * (B + 1)) = (4 * μ * (r * (B + 1))) * ((r + 1) * B) := by ring
    have h1 : 8 * (r - B) ^ 2 * μ ≤ 4 * μ * (r * B * (r + 1) * (B + 1)) := by nlinarith
    have h2 : (4 * μ * (r * (B + 1))) * ((r + 1) * B) ≤ k ^ 2 * ((r + 1) * B) :=
      mul_le_mul_of_nonneg_right hamgm (by positivity)
    linarith
  have e2 : (r - B) ^ 2 * (2 * (v - 1)) * 4 * μ = (v - 1) * (8 * (r - B) ^ 2 * μ) := by ring
  rw [e2]
  have h3 : (v - 1) * (8 * (r - B) ^ 2 * μ) ≤ (v - 1) * (k ^ 2 * ((r + 1) * B)) :=
    mul_le_mul_of_nonneg_left step (by linarith)
  nlinarith

/-- **THE PRIMITIVE HALF: `θ < ½` for every primitive strongly regular graph, at every `n`.**

**Proved**, by the eigenvalue coordinates and the multiplicity integrality the structure carries. The trace and
multiplicity identities give `(f - g)(r - s) = -2k - (v - 1)(λ - μ)`, which splits the proof:

* **`f = g`, the conference case**: then `(v - 1)(μ - λ) = 2k` with `0 < k < v - 1`, so the integer `μ - λ` lies
  in `(0, 2)` and is `1`, which makes `1 + λ - μ = 0` and `θ = 0`;
* **`f ≠ g`**: then `r - s` is rational, so `r` is a rational root of `x² - (λ - μ)x - (k - μ)`, hence an integer
  (`rat_root_int`), with `r ≥ 1` since `rs = μ - k < 0`. And `s ≤ -2`, since `s = -1` forces `λ = k - 1` and the
  counting identity then forces `μ = 0`. With `B = -s - 1 ≥ 1` and `k = μ + r(B + 1)`, AM–GM gives
  `k² ≥ 4μr(B + 1)`, and `2(r - B)² ≤ rB(r + 1)(B + 1)` (`poly_le`) closes `core_ineq`. -/
theorem primitive_thetaSq_lt_quarter (Γ : SRG) (hp : Γ.Primitive) : Γ.thetaSq < 1 / 4 := by
  obtain ⟨hmu0, hmuk⟩ := hp
  obtain ⟨v, k, lam, mu, r, s, f, g, hk, hklt, hlam, hmu, hident, hr, hs, hsum, hprod, hmult, htrace⟩ := Γ
  simp only at hmu0 hmuk ⊢
  unfold SRG.thetaSq
  simp only
  have hkR : (0 : ℝ) < k := by exact_mod_cast hk
  have hkltR : (k : ℝ) < v - 1 := by exact_mod_cast hklt
  have hmu0R : (0 : ℝ) < mu := by exact_mod_cast hmu0
  have hmukR : (mu : ℝ) < k := by exact_mod_cast hmuk
  have hidR : (k : ℝ) * (k - lam - 1) = (v - k - 1) * mu := by exact_mod_cast hident
  have hvpos : (0 : ℝ) < v := by linarith
  have hden : 0 < (v : ℝ) * k * (v - 1 - k) := by
    have : (0 : ℝ) < v - 1 - k := by linarith
    positivity
  have hr0 : 0 < r := by nlinarith
  have hfg : ((f : ℝ) - g) * (r - s) = -2 * k - (v - 1) * (lam - mu) := by
    linear_combination 2 * htrace - (lam - mu : ℝ) * hmult - ((f : ℝ) + g) * hsum
  rw [div_lt_iff₀ hden]
  by_cases hfge : f = g
  · -- the conference case: `μ - λ = 1`, so `θ = 0`
    subst hfge
    have hz : (2 : ℝ) * k + (v - 1) * (lam - mu) = 0 := by linarith [hfg, show ((f : ℝ) - f) * (r - s) = 0 by ring]
    have hzZ : 2 * k + (v - 1) * (lam - mu) = 0 := by exact_mod_cast hz
    have h1 : mu - lam = 1 := by
      have hv1 : 0 < v - 1 := by omega
      rcases lt_trichotomy (mu - lam) 1 with h | h | h
      · have : mu - lam ≤ 0 := by omega
        nlinarith
      · exact h
      · have : 2 ≤ mu - lam := by omega
        nlinarith
    have h1R : (1 : ℝ) + lam - mu = 0 := by
      have : ((mu - lam : ℤ) : ℝ) = 1 := by exact_mod_cast h1
      push_cast at this; linarith
    rw [h1R, zero_pow two_ne_zero, zero_mul]; positivity
  · -- the integral case: `r`, `s` are integers with `r ≥ 1`, `s ≤ -2`
    have hfgR : (f : ℝ) - g ≠ 0 := by
      intro h; apply hfge; exact_mod_cast (sub_eq_zero.mp h)
    have hrq : ∃ q : ℚ, (q : ℝ) = r := by
      refine ⟨((lam - mu : ℤ) + (-2 * k - (v - 1) * (lam - mu) : ℤ) / (f - g : ℤ)) / 2, ?_⟩
      push_cast
      rw [← hfg]; field_simp; linarith
    obtain ⟨q, hq⟩ := hrq
    have hqroot : q ^ 2 = ((lam - mu : ℤ) : ℚ) * q + ((k - mu : ℤ) : ℚ) := by
      have hR : r ^ 2 = (lam - mu) * r + (k - mu) := by nlinarith
      have : (q : ℝ) ^ 2 = ((lam : ℝ) - mu) * q + ((k : ℝ) - mu) := by rw [hq]; exact hR
      exact_mod_cast this
    obtain ⟨zr, hzr⟩ := rat_root_int hqroot
    have hzrR : (zr : ℝ) = r := by rw [← hq, ← hzr]; norm_cast
    have hzsR : ((lam - mu - zr : ℤ) : ℝ) = s := by push_cast; rw [hzrR]; linarith
    have hr1 : (1 : ℝ) ≤ r := by
      have : 0 < zr := by exact_mod_cast (hzrR ▸ hr0)
      rw [← hzrR]; exact_mod_cast this
    have hs2 : s ≤ -2 := by
      have hneg : lam - mu - zr < 0 := by exact_mod_cast (hzsR ▸ hs)
      have hne : lam - mu - zr ≠ -1 := by
        intro he
        have hs1 : s = -1 := by rw [← hzsR, he]; norm_num
        rw [hs1] at hprod hsum
        -- `λ = k - 1`, so the counting identity forces `μ = 0`
        have hl : (lam : ℝ) = k - 1 := by linarith
        rw [hl] at hidR
        have : ((v : ℝ) - k - 1) * mu = 0 := by linarith
        rcases mul_eq_zero.mp this with h | h
        · linarith
        · linarith
      have : lam - mu - zr ≤ -2 := by omega
      rw [← hzsR]; exact_mod_cast this
    -- set `B = -s - 1 ≥ 1`
    set B : ℝ := -s - 1 with hB
    have hB1 : 1 ≤ B := by linarith
    have hlm : (1 : ℝ) + lam - mu = r - B := by linarith
    have hkB : (k : ℝ) = mu + r * (B + 1) := by rw [hB]; linear_combination hprod
    have hkl : (k : ℝ) - lam - 1 = (r + 1) * B := by rw [hB]; linear_combination hprod + hsum
    -- `μ(v - 1 - k) = k(r + 1)B`
    have hvk : (mu : ℝ) * (v - 1 - k) = k * ((r + 1) * B) := by rw [← hkl]; linarith
    rw [hlm]
    have hc := core_ineq (v := (v : ℝ)) hr1 hB1 hmu0R hkB (by linarith)
    have e : (v * k * (v - 1 - k)) * (mu : ℝ) = v * k ^ 2 * ((r + 1) * B) := by
      rw [mul_assoc, mul_comm _ (mu : ℝ), hvk]; ring
    rw [← e] at hc
    exact lt_of_mul_lt_mul_right (by linarith) hmu0R.le


/-- **So no primitive DGK point is in the band**, `¼` being far below `3/2`. -/
theorem primitive_not_in_band (Γ : SRG) (hp : Γ.Primitive) : ¬ InBand Γ.thetaSq := by
  intro hband
  have := primitive_thetaSq_lt_quarter Γ hp
  rw [InBand] at hband
  linarith

/-! ## The DGK point as a Weyl tensor, and criticality named

*The record's L74: "every strongly regular graph yields a critical point of the diagonal locus".
[Families.lean](../Base/Families.lean) carries the diagonal locus as `diagOp` and
[WeylReal.lean](../Base/WeylReal.lean) carries `IsCritical`, so the family can be built here and
the closed form can be attached to the record's own `θ` rather than standing as a formula in
`(v,k,λ,μ)`.*
-/

section Family

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable section

/-- **A `k`-regular graph, as its adjacency matrix**: symmetric, hollow, `0/1`, constant row
sums. -/
structure IsRegularGraph (A : Matrix ι ι ℝ) (k : ℝ) : Prop where
  symm : ∀ a b, A a b = A b a
  hollow : ∀ a, A a a = 0
  zeroOne : ∀ a b, A a b = 0 ∨ A a b = 1
  regular : ∀ a, ∑ b, A a b = k

/-- **The strongly-regular conditions**, `(A²)_ab = λ` on edges and `μ` on non-edges. -/
structure IsSRG (A : Matrix ι ι ℝ) (k lam mu : ℝ) : Prop extends IsRegularGraph A k where
  adjSq : ∀ a b, a ≠ b → (∑ c, A a c * A c b) = lam * A a b + mu * (1 - A a b)

/-- **THE DGK POINT'S WEIGHT**: `+1` on edges and `−k/w` on non-edges, `w = n − 1 − k`. *The
record's own `a` on edges and `−at` on non-edges with `t = k/w`, at the scale `a = 1`; `θ` is
scale-invariant, so the scale is the unit-norm existential's rather than a choice made here.* -/
def graphWeight (A : Matrix ι ι ℝ) (k : ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b =>
    if a = b then 0 else A a b - (1 - A a b) * (k / ((Fintype.card ι : ℝ) - 1 - k))

/-- **THE TWO WEIGHTS ARE THE SAME MATRIX**, and the identification `L74Bridge` needs is a `ring`
step rather than a construction.

*`graphWeight A k` is `A - (1 - A)t` off the diagonal and `srgWeight A t` is `(1 + t)A - t`, and
those are the same polynomial in `A` and `t`.* **So the bridge's remaining content is not this
identity but the SCALE**: the bridge fixes its scale by `normSq = 1` at an arbitrary positive `t`,
while [L74Statement.lean](L74Statement.lean)'s witness carries a named square root, and matching
them is the uniqueness of a positive scale making a norm one. -/
theorem graphWeight_eq_srgWeight (A : Matrix ι ι ℝ) (k : ℝ) :
    graphWeight A k = HamiltonsCubic.L74Statement.srgWeight A
      (HamiltonsCubic.L74Statement.tOf (Fintype.card ι : ℝ) k) := by
  ext a b
  simp only [graphWeight, HamiltonsCubic.L74Statement.srgWeight,
    HamiltonsCubic.L74Statement.tOf, Matrix.of_apply]
  split
  · rfl
  · ring

theorem graphWeight_edge {A : Matrix ι ι ℝ} {k : ℝ} {a b : ι} (hab : a ≠ b) (h : A a b = 1) :
    graphWeight A k a b = 1 := by
  simp [graphWeight, hab, h]

theorem graphWeight_nonedge {A : Matrix ι ι ℝ} {k : ℝ} {a b : ι} (hab : a ≠ b) (h : A a b = 0) :
    graphWeight A k a b = - (k / ((Fintype.card ι : ℝ) - 1 - k)) := by
  simp [graphWeight, hab, h]

theorem graphWeight_symm {A : Matrix ι ι ℝ} {k : ℝ} (hA : IsRegularGraph A k) (a b : ι) :
    graphWeight A k a b = graphWeight A k b a := by
  by_cases hab : a = b
  · subst hab; rfl
  · simp only [graphWeight, Matrix.of_apply, if_neg hab, if_neg (Ne.symm hab), hA.symm a b]

theorem graphWeight_hollow (A : Matrix ι ι ℝ) (k : ℝ) (a : ι) : graphWeight A k a a = 0 := by
  simp [graphWeight]

/-- **The row sums vanish**, which is Ricci-flatness on the diagonal locus. *`k` edges at `+1`
against `n − 1 − k` non-edges at `−k/(n−1−k)`, and the two cancel identically.* -/
theorem graphWeight_rowSum {A : Matrix ι ι ℝ} {k : ℝ} (hA : IsRegularGraph A k)
    (hw : (Fintype.card ι : ℝ) - 1 - k ≠ 0) (a : ι) : ∑ b, graphWeight A k a b = 0 := by
  have hc : (k / ((Fintype.card ι : ℝ) - 1 - k)) * ((Fintype.card ι : ℝ) - 1 - k) = k := by
    field_simp
  have hcong : ∀ b ∈ (univ : Finset ι), graphWeight A k a b
      = (A a b - (1 - A a b) * (k / ((Fintype.card ι : ℝ) - 1 - k)))
        - (if a = b then (A a b - (1 - A a b) * (k / ((Fintype.card ι : ℝ) - 1 - k))) else 0) := by
    intro b _
    by_cases hb : a = b
    · subst hb
      simp [graphWeight, hA.hollow a]
    · simp only [graphWeight, Matrix.of_apply, if_neg hb, sub_zero]
  rw [Finset.sum_congr rfl hcong, Finset.sum_sub_distrib,
    Finset.sum_ite_eq univ a
      (fun b => A a b - (1 - A a b) * (k / ((Fintype.card ι : ℝ) - 1 - k)))]
  have hsum : ∑ b, (A a b - (1 - A a b) * (k / ((Fintype.card ι : ℝ) - 1 - k)))
      = k + (k / ((Fintype.card ι : ℝ) - 1 - k)) * k
        - (Fintype.card ι : ℝ) * (k / ((Fintype.card ι : ℝ) - 1 - k)) := by
    have hstep : ∀ b : ι, A a b - (1 - A a b) * (k / ((Fintype.card ι : ℝ) - 1 - k))
        = A a b + (k / ((Fintype.card ι : ℝ) - 1 - k)) * A a b
          - (k / ((Fintype.card ι : ℝ) - 1 - k)) := fun b => by ring
    simp only [hstep]
    rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, hA.regular a,
      Finset.sum_const, nsmul_eq_mul, Finset.card_univ]
  rw [hsum, if_pos (mem_univ a), hA.hollow a]
  linear_combination -hc

theorem graphWeight_isWeight {A : Matrix ι ι ℝ} {k : ℝ} (hA : IsRegularGraph A k)
    (hw : (Fintype.card ι : ℝ) - 1 - k ≠ 0) : IsWeight (graphWeight A k) where
  symm := graphWeight_symm hA
  hollow := graphWeight_hollow A k
  rowSum := graphWeight_rowSum hA hw

/-- **THE DGK POINT IS A WEYL TENSOR**, at every scale. *This is what makes the whole comparison a
statement inside `𝒲ₙ`: `diagOp` of a weight with zero row sums is self-adjoint on `Λ²`, satisfies
first Bianchi and is Ricci-flat, by [Families.lean](../Base/Families.lean)'s `diagOp_isWeyl`.* -/
theorem graphWeight_isWeyl {A : Matrix ι ι ℝ} {k : ℝ} (hA : IsRegularGraph A k)
    (hw : (Fintype.card ι : ℝ) - 1 - k ≠ 0) (t : ℝ) :
    IsWeyl (diagOp (t • graphWeight A k)) :=
  diagOp_isWeyl ((graphWeight_isWeight hA hw).smul t)

/-- **A graph realises a parameter set** when it has the right vertex count and the strongly
regular conditions at `(k, λ, μ)`. -/
def Realises (Γ : SRG) (A : Matrix ι ι ℝ) : Prop :=
  (Fintype.card ι : ℝ) = (Γ.v : ℝ) ∧ IsSRG A (Γ.k : ℝ) (Γ.lam : ℝ) (Γ.mu : ℝ)

omit [DecidableEq ι] in
/-- `w = n − 1 − k > 0`, from `SRG`'s own `k < v − 1`. *So the weight is defined and the Weyl
clause below needs no extra hypothesis.* -/
theorem realises_w_pos {Γ : SRG} {A : Matrix ι ι ℝ} (hre : Realises Γ A) :
    (0 : ℝ) < (Fintype.card ι : ℝ) - 1 - (Γ.k : ℝ) := by
  have h : ((Γ.k : ℝ)) < ((Γ.v : ℝ)) - 1 := by exact_mod_cast Γ.hklt
  rw [hre.1]; linarith

/-- **EVERY DGK POINT IS A WEYL TENSOR ON THE DIAGONAL LOCUS.** -/
theorem realises_isWeyl {Γ : SRG} {A : Matrix ι ι ℝ} (hre : Realises Γ A) (t : ℝ) :
    IsWeyl (diagOp (t • graphWeight A (Γ.k : ℝ))) :=
  graphWeight_isWeyl hre.2.toIsRegularGraph (ne_of_gt (realises_w_pos hre)) t

/-- **THE TWO `IsSRG`s ARE THE SAME HYPOTHESIS IN TWO SPELLINGS, 2026-09-22.** This file's takes
`(A, k, lam, mu)` and packs the counting conditions into one equation `adjSq`; the one in
[L74Statement.lean](L74Statement.lean) takes `(A, v, k, lam, mu)` and splits them, carrying
`card : Fintype.card ι = v` and the identity as fields.

*Given `zeroOne`, `adjSq` splits into the two counts: at `A a b = 1` it reads `lam` and at
`A a b = 0` it reads `mu`.* **So this file's predicate plus the two extra facts is exactly the
other's**, and `L74Bridge` is a translation rather than a missing proof. -/
theorem IsSRG.toL74 {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (h : IsSRG A k lam mu)
    (hcard : (Fintype.card ι : ℝ) = v) (hid : k * (k - lam - 1) = (v - 1 - k) * mu) :
    HamiltonsCubic.L74Statement.IsSRG A v k lam mu where
  symm := h.symm
  hollow := h.hollow
  zeroOne := h.zeroOne
  card := hcard
  deg := h.regular
  lam_count := by
    intro a b hab hone
    have := h.adjSq a b hab
    rw [hone] at this; simpa using this
  mu_count := by
    intro a b hab hzero
    have := h.adjSq a b hab
    rw [hzero] at this; simpa using this
  hident := hid

/-- **LEMMA L74's BRIDGE, NAMED RATHER THAN ASSUMED.** That a unit-norm DGK point **is a critical
point of `P`** (`IsCritical` at a multiplier `θ`) and that the record's closed form is `θ²`.

*This is [Lemma L74](../../../findings/diagonal-half.md)'s content, a different numbered result,
and it needs the CRITICALITY equation on the diagonal locus, `DiagCriticalityIsCritical`, which now
lives once in [Base/Families.lean](../Base/Families.lean) and is **PROVED**, by
`diagCriticalityIsCritical` in [SharpDiag.lean](../Base/SharpDiag.lean). **THIS SENTENCE HAS NOW BEEN
WRONG TWICE, IN TWO DIFFERENT WAYS.** *A first version attributed the gap to `DiagCubicFormula`, a
DIFFERENT statement, and [r1028](../../../reviews/REVIEW_r1028.md)'s repair fixed the attribution
while keeping the words "still owed", which the discharge of 2026-09-21 then made false.* **A repair
that corrects WHICH declaration a gap names must re-check WHETHER it is still a gap**, the two being
independent and only the first being what the reviewer was looking at. It WAS carried as a hypothesis, in the same
way `SphereProductValue` is carried there, so that nothing below silently assumed it, and
`l74Bridge_holds` PROVES it as of 2026-09-23.*

**PHASE 1'S SPLIT ON `L74Bridge`, 2026-09-23, AND THE GAP IS AN EXISTENTIAL RATHER THAN A
THEOREM.**

*The pieces this bridge needs are all on file.* `IsSRG.toL74` above translates this file's
predicate into [L74Statement.lean](L74Statement.lean)'s, `srgWeight_entry` and `graphWeight`
agree one `ext` apart, and `srg_theta_closed_form_uncond` supplies criticality and the closed
form with no hypothesis debt of its own.

**What it does NOT supply is the WITNESS.** *It concludes `∃ W, IsWeyl W ∧ normSq W = 1 ∧
IsCritical W (thetaSRG v k lam) ∧ ...`, while the bridge needs exactly those four facts about
`diagOp (t • graphWeight A k)`, the operator it was handed.* An existential gives a `W` and no
reason it is that one.

**SO THIS WAS A BLOCKER THE CYCLE COULD BUILD, AND IT WAS BUILT.** *Restating an existing proof about the witness it already constructs is refactoring, not new mathematics*, and the rule is that such a blocker is built rather than written into a trailer.

**`srg_theta_closed_form_at` AND `srg_theta_closed_form_at_uncond` NOW STATE THE FOUR FACTS ABOUT THE OPERATOR ITSELF**, and the existential is a one-line corollary of the first, so the proof MOVED rather than being duplicated. *The witness was explicit in the proof all along, `diagOp (s . srgWeight A (tOf v k))` with `s` the square root of `2(v-1-k)/(vk(v-1))`; only the conclusion had forgotten it.*

**WHAT REMAINED FOR THIS BRIDGE WAS THE WEIGHT IDENTIFICATION AND THE SCALE, AND BOTH ARE DONE**: `graphWeight_eq_srgWeight` proves the two weights are the same matrix with no hypothesis, and `scale_unique_of_normSq_one` matches the two scale factors. *`l74Bridge_holds` assembles them, so nothing here is owed.* **This sentence said "that is the next round" AFTER its own headline said the work was done** ([r1089](../../../reviews/REVIEW_r1089.md)): the repair replaced the headline and left the rest byte for byte, which is the third time this file has carried a claim its own neighbouring text refutes.
-/
def L74Bridge : Prop :=
  ∀ (Γ : SRG) (A : Matrix ι ι ℝ) (t : ℝ), Realises Γ A → 0 < t →
    normSq (diagOp (t • graphWeight A (Γ.k : ℝ))) = 1 →
      ∃ th : ℝ, IsCritical (diagOp (t • graphWeight A (Γ.k : ℝ))) th ∧ th ^ 2 = Γ.thetaSq

/-- **`L74Bridge` IS A THEOREM, 2026-09-23**, and it was never blocked on mathematics.

*Three rounds found the gap was bookkeeping each time: an existential that had forgotten its own
witness, two spellings of one matrix, and a normalisation. The pieces are
`srg_theta_closed_form_at_uncond`, `graphWeight_eq_srgWeight` and `scale_unique_of_normSq_one`,
and this assembles them.* -/
theorem l74Bridge_holds : L74Bridge (ι := ι) := by
  intro Γ A t hre ht hn
  have hvz : (0 : ℤ) < Γ.v := by linarith [Γ.hk, Γ.hklt]
  have hv : (0 : ℝ) < (Fintype.card ι : ℝ) := by
    rw [hre.1]; exact_mod_cast hvz
  have hk : (0 : ℝ) < (Γ.k : ℝ) := by exact_mod_cast Γ.hk
  have hw : (0 : ℝ) < (Fintype.card ι : ℝ) - 1 - (Γ.k : ℝ) := realises_w_pos hre
  have hu : (0 : ℝ) < (Fintype.card ι : ℝ) - 1 := by linarith
  have hid : (Γ.k : ℝ) * ((Γ.k : ℝ) - (Γ.lam : ℝ) - 1)
      = ((Fintype.card ι : ℝ) - 1 - (Γ.k : ℝ)) * (Γ.mu : ℝ) := by
    have h : (Γ.k : ℝ) * ((Γ.k : ℝ) - (Γ.lam : ℝ) - 1)
        = ((Γ.v : ℝ) - (Γ.k : ℝ) - 1) * (Γ.mu : ℝ) := by exact_mod_cast Γ.hident
    rw [hre.1]; linarith [h]
  have hL74 := (hre.2).toL74 rfl hid
  obtain ⟨hWeyl, hnorm, hcrit, _⟩ :=
    HamiltonsCubic.L74Statement.srg_theta_closed_form_at_uncond hL74 hv hk hw hu
  set s : ℝ := Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1 - (Γ.k : ℝ)) /
    ((Fintype.card ι : ℝ) * (Γ.k : ℝ) * ((Fintype.card ι : ℝ) - 1))) with hsdef
  have hspos : 0 < s := by
    rw [hsdef]; exact Real.sqrt_pos.2 (by positivity)
  have hgw : graphWeight A (Γ.k : ℝ)
      = HamiltonsCubic.L74Statement.srgWeight A
        (HamiltonsCubic.L74Statement.tOf (Fintype.card ι : ℝ) (Γ.k : ℝ)) :=
    graphWeight_eq_srgWeight A (Γ.k : ℝ)
  rw [hgw] at hn
  have hst : s = t :=
    HamiltonsCubic.Results.scale_unique_of_normSq_one
      (HamiltonsCubic.L74Statement.srgWeight_symm (hre.2).symm _)
      (HamiltonsCubic.L74Statement.srgWeight_hollow A _) hspos ht hnorm hn
  refine ⟨HamiltonsCubic.L74Statement.thetaSRG (Fintype.card ι : ℝ) (Γ.k : ℝ) (Γ.lam : ℝ), ?_, ?_⟩
  · rw [hgw, ← hst]; exact hcrit
  · rw [HamiltonsCubic.L74Statement.thetaSRG_sq_eq_L144_form hv hk hw hu hid, SRG.thetaSq, hre.1]

/-- **THE PRIMITIVE HALF, AT THE CRITICAL POINT ITSELF.** On L74's bridge, a unit-norm DGK point
of a primitive parameter set is a critical point of `P` whose multiplier satisfies `θ² < ¼`, so it
is out of the band. *This is the conclusion `no_dgk_in_band_except_balanced` states on the closed
form, restated about the record's own Weyl tensor and its own criticality multiplier.* -/
theorem primitive_critical_not_in_band (h74 : L74Bridge (ι := ι)) (Γ : SRG) (hp : Γ.Primitive)
    (A : Matrix ι ι ℝ) (t : ℝ) (hre : Realises Γ A) (ht : 0 < t)
    (hn : normSq (diagOp (t • graphWeight A (Γ.k : ℝ))) = 1) :
    ∃ th : ℝ, IsCritical (diagOp (t • graphWeight A (Γ.k : ℝ))) th
      ∧ IsWeyl (diagOp (t • graphWeight A (Γ.k : ℝ)))
      ∧ th ^ 2 < 1 / 4 ∧ ¬ InBand (th ^ 2) := by
  obtain ⟨th, hcrit, hval⟩ := h74 Γ A t hre ht hn
  refine ⟨th, hcrit, realises_isWeyl hre t, ?_, ?_⟩
  · rw [hval]; exact primitive_thetaSq_lt_quarter Γ hp
  · rw [hval]; exact primitive_not_in_band Γ hp

end

end Family

/-! ## The conclusion -/

/-- **NO DGK POINT LIES IN THE BAND EXCEPT THE BALANCED PRODUCT.** No primitive one is in the band;
and every imprimitive one in the band has `2g = n`, where its value is exactly the balanced
product's `θ₀(n)²`. -/
theorem no_dgk_in_band_except_balanced {n : ℕ} (hn : 12 ≤ n) :
    (∀ Γ : SRG, Γ.Primitive → ¬ InBand Γ.thetaSq) ∧
      (∀ g : ℕ, 1 ≤ g → g ∣ n → 2 * g ≤ n → InBand (thetaImpSq n g) →
        2 * g = n ∧ thetaImpSq n g = theta0Sq n) :=
  ⟨fun Γ hp => primitive_not_in_band Γ hp,
   fun g hg hdvd hle hband => imprimitive_in_band hn hg hdvd hle hband⟩

/-! ## The primitive statement is not vacuous -/

/-- The **Clebsch graph** `(16,5,0,2)`, with restricted eigenvalues `1` and `-3` of multiplicities
`10` and `5`. It satisfies every hypothesis of `SRG` and is primitive, so
`primitive_thetaSq_lt_quarter` is a statement about a nonempty class. -/
noncomputable def clebsch : SRG where
  v := 16
  k := 5
  lam := 0
  mu := 2
  r := 1
  s := -3
  f := 10
  g := 5
  hk := by norm_num
  hklt := by norm_num
  hlam := by norm_num
  hmu := by norm_num
  hident := by norm_num
  hr := by norm_num
  hs := by norm_num
  hsum := by norm_num
  hprod := by norm_num
  hmult := by norm_num
  htrace := by norm_num

theorem clebsch_primitive : clebsch.Primitive := by
  constructor <;> norm_num [SRG.Primitive, clebsch]

end HamiltonsCubic.L144Statement
