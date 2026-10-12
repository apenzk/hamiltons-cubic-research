import Mathlib
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option maxHeartbeats 1000000

/-!
# L74, `θ` in closed form for every strongly regular graph

**The record's block, quoted from [diagonal-half.md](../../../findings/diagonal-half.md):**

> #### The strongly regular graph solutions, reduced to one scalar condition
>
> **The ansatz is forced.** A two-eigenvalue hollow zero-row-sum solution on a strongly regular `Γ`
> with parameters `(v,k,λ,μ)` is constant on edges and on non-edges, so `M = aA + b(J-I-A)`; zero row
> sums give `b = -ak/(v-1-k)`. Writing `t := k/(v-1-k)` and `N := (1+t)A - t(J-I)`, we have `M = aN`
> and
> $$\lVert W\rVert^2=\sum_{i<j}M_{ij}^2=\frac{a^2vk(v-1)}{2(v-1-k)},\qquad\text{so}\qquad a^2=\frac{2(v-1-k)}{vk(v-1)}\ \text{ at unit norm.}$$
> **Criticality then reads `θ = aF_ij` with `F_ij = [(N²)_ij + N_ij²]/N_ij`, and it requires `F` to
> take the *same* value on edges and on non-edges**, one scalar equation in `(v,k,λ,μ)`, which is
> DGK's admissibility condition expressed in this record's terms.
>
> #### Lemma L74, `θ` in closed form for every strongly regular graph
>
> **The admissibility condition is the graph identity itself.** Reducing `F_edge = F_non-edge` with
> `w := v-1-k` gives `k(λ-μ) + (v-1)μ - k² + k = 0`, i.e.
> $$k(k-\lambda-1)=(v-k-1)\mu,$$
> **the standard strongly regular graph identity**, so it holds automatically and *every* strongly
> regular graph yields a critical point of the diagonal locus, with no further constraint.
>
> > **LEMMA L74.** *Let `Γ` be strongly regular with parameters `(v,k,λ,μ)` and let `W` be the
> > unit-norm diagonal Weyl tensor it determines. Then `n = v` and*
> > $$\frac{\theta}{\lVert W\rVert}=\frac{(v-1)^2\lambda+2k(v-1)-k^2v+w^2}{w^2}\cdot\sqrt{\frac{2w}{vk(v-1)}},\qquad w=v-1-k.$$
>
> **Gate 1(a), against a value already on the record.** The octahedron `K_{2,2,2} = SRG(6,4,2,4)`
> has `w = 1`, `F = 50 + 40 - 96 + 1 = -5` and `a = 1/√60`, giving `|θ|/‖W‖ = 5/√60 = 0.645497`,
> **exactly this record's catalogued `n = 6` maximal torus** … *The pentagon `C₅ = SRG(5,2,0,1)`
> gives `F = 0` … **every conference graph** has `k = (v-1)/2`, `λ = (v-5)/4`, `μ = (v-1)/4`, which
> makes the numerator `(v-1)²·0`, so `θ = 0` exactly. **The Petersen graph `SRG(10,3,0,1)` also has
> `θ = 0` and is not a conference graph** …*
>
> **The vertex count is the dimension**, so this family populates the diagonal locus at every `n`
> admitting a strongly regular graph …
>
> **Exactly two parameter families satisfy the graph identity under those**: `SRG(2m,m,0,m) = K_{m,m}`
> and `SRG(2m,m-1,m-2,0) = 2K_m` … There `λ_min + (n-2)λ_max = √((2m-1)(m-1))/m = θ₀(2m)`, which the
> closed form returns as `θ`, so the saturating member **is** the balanced sphere product `S^m × S^m`.

## What this file states

The lemma end to end, on the objects [Base/Families.lean](../Base/Families.lean) builds: the weight
`srgWeight A t` is the record's `N`, `diagOp` turns it into the Weyl operator `W`, and `theta` is the
record's `θ`. `IsSRG` is the graph, axiomatised by its counting conditions.

* `srgWeight_isWeight`, the ansatz lands in `𝒟ₙ` at `t = k/w`: symmetric, hollow, **zero row sums**,
  the last being where `t` is forced. `isWeyl_srg` is then `IsWeyl W` from the base layer.
* `srgWeight_mul_entry`, `(N²)_ab = (1+t)²p_ab - 2t(1+t)(k - A_ab) + t²(v-2)` off the diagonal, one
  formula covering edges and non-edges, `p_ab` being the common-neighbour count.
* `srg_isDiagCritical`, **EVERY STRONGLY REGULAR GRAPH IS A DIAGONAL CRITICAL POINT**, with the one
  multiplier `Fclosed v k lam` at both entry values. This is the block's headline, and it is the
  place the graph identity is consumed.
* `admissibility_iff_srg_identity`, **the admissibility condition IS the graph identity**: with
  `w, k ≠ 0`, `F` takes the same value on edges and non-edges exactly when `k(k-λ-1) = wμ`. Stated
  on the parameters alone, since that is what the block's *"one scalar equation in `(v,k,λ,μ)`"* is.
* `srgWeight_normSq` and `srg_unit_scale_sq`, `‖W‖² = a²vk(v-1)/(2w)`, hence the record's
  `a² = 2w/(vk(v-1))` at unit norm.
* `theta_of_critical_unit`, **at a unit-norm critical point `θ` is the multiplier**, proved from
  `Pcubic = ⟨R, Q(R)⟩` and nothing else. This is what turns the multiplier into the record's `θ`.
* `srg_theta_closed_form`, **THE LEMMA**: the unit-norm `W` a strongly regular graph determines is
  a Weyl operator, is critical, and has `θ = F·√(2w/(vk(v-1)))`.
* `thetaSRG_sq_eq_L144_form`, the same number in `[L144Statement.lean](L144Statement.lean)`'s
  parameters, `θ² = (1+λ-μ)²·2(v-1)/(vkw)`, which is what makes that file's arithmetic a statement
  about `θ`; `Fclosed_eq_lam_sub_mu` is the identity behind it.
* `octahedron_F`, `octahedron_thetaSq`, `conference_F_zero`, `petersen_F_zero` and
  `petersen_not_conference`, the block's own Gate 1(a) values, in closed form rather than screened.
* `balanced_product_thetaSq`, `SRG(2m,m,0,m) = K_{m,m}` returns exactly `θ₀(2m)²`, the balanced
  sphere product's value, against `theta0Sq` as [Base/Families.lean](../Base/Families.lean) defines
  it.
* `k22`, `K_{2,2} = SRG(4,2,0,2)` as an instance of `IsSRG`, so nothing above is vacuous.

**`n = v` is a hypothesis, not a conclusion.** `IsSRG` carries `card : Fintype.card ι = v`, so the
record's *"the vertex count is the dimension"* is the shape of the statement rather than something
derived inside it.

## What is NOT typed here

* **That `Q` acts on `φ_ab` by `w_ab² + (w²)_ab` on the diagonal locus**, which is what turns
  `srg_isDiagCritical`'s matrix equation into `IsCritical`. That is the base layer's owed evaluation
  of `sharpOp` on the `φ` basis, which [Base/Families.lean](../Base/Families.lean) names rather than
  proves, its `DiagCubicFormula` was the same gap for `P` and is now PROVED in [SharpDiag.lean](../Base/SharpDiag.lean). It is carried here as the named `Prop`
  `DiagCriticalityIsCritical` and consumed only by `srg_theta_closed_form`. *It is a hypothesis rather than a
  `sorry` because the base layer records the normalisation question itself as open,
  [WeylReal.lean](../Base/WeylReal.lean) says in as many words that *"whether `sharpOp` IS `R#`"* is
  owed, and *"a wrong normalisation there makes `sharpOp` the wrong operator"*. A `sorry` would
  assert the constant that question is about; the `Prop` states the implication the record's own
  derivation gives and leaves the constant where the base layer put it.*
* **That the counting fields of `IsSRG` imply the graph identity.** `IsSRG.hident` is a field rather
  than a theorem. The identity is the standard double count of edges between the neighbourhood of a
  vertex and its complement (classical and in every text on strongly regular graphs) so carrying
  it costs no generality; the double count itself is not typed. `[L144Statement.lean](L144Statement.lean)`
  carries it the same way.
* **That the two-eigenvalue ansatz is forced**, i.e. that a hollow zero-row-sum solution constant on
  edges and non-edges is the only diagonal critical point supported on `Γ`. The block asserts it;
  this file takes `srgWeight` as the object and proves what holds at it.
* **The eigenvalue reading**, that the `Λ²` eigenvalues *are* the entries, hence
  `λ_max/|λ_min| = w/k`, and the saturation analysis of [L70/L71](bounds.md) that follows from it.
  `balanced_product_thetaSq` records the arithmetic conclusion of that analysis and not its route.
* **The identification with the `n = 6` maximal torus**, that the octahedron's `a < 0` branch
  matches `𝔰𝔬(2)³ ⊂ 𝔰𝔬(6)` in eigenvalues, multiplicities and eigenvectors. Only the number is here.
* **The classification** *"exactly two parameter families saturate"*. `balanced_product_thetaSq`
  states one of the two; the exhaustiveness is a statement about all integer solutions of the graph
  identity and is not typed.
-/

namespace HamiltonsCubic.L74Statement

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The graph -/

/-- **A strongly regular graph, by its counting conditions**, with the adjacency matrix carried over
`ℝ` so that it can be multiplied against the weight directly.

*`hident` is the standard identity `k(k-λ-1) = (v-1-k)μ`. It is a consequence of the counting fields
the double count of edges from a neighbourhood to its complement, and is carried as a field
because that double count is not typed here.* -/
structure IsSRG (A : Matrix ι ι ℝ) (v k lam mu : ℝ) : Prop where
  symm : ∀ a b, A a b = A b a
  hollow : ∀ a, A a a = 0
  /-- Every entry is `0` or `1`. -/
  zeroOne : ∀ a b, A a b = 0 ∨ A a b = 1
  /-- `n = v`: the vertex count is the dimension. -/
  card : (Fintype.card ι : ℝ) = v
  /-- Every vertex has degree `k`. -/
  deg : ∀ a, ∑ c : ι, A a c = k
  /-- Adjacent vertices have `λ` common neighbours. -/
  lam_count : ∀ a b, a ≠ b → A a b = 1 → ∑ c : ι, A a c * A c b = lam
  /-- Non-adjacent distinct vertices have `μ` common neighbours. -/
  mu_count : ∀ a b, a ≠ b → A a b = 0 → ∑ c : ι, A a c * A c b = mu
  /-- The standard strongly-regular identity. -/
  hident : k * (k - lam - 1) = (v - 1 - k) * mu

/-! ## The ansatz -/

/-- **The record's `N = (1+t)A - t(J-I)`**: `1` on edges, `-t` on non-edges, hollow. -/
def srgWeight (A : Matrix ι ι ℝ) (t : ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then 0 else (1 + t) * A a b - t

/-- The forced scale, `t = k/(v-1-k)`. -/
noncomputable def tOf (v k : ℝ) : ℝ := k / (v - 1 - k)

/-- The entry, with the hollow `if` traded for a `+ tδ` correction, the form every sum below uses. -/
theorem srgWeight_entry {A : Matrix ι ι ℝ} (hh : ∀ a, A a a = 0) (t : ℝ) (a b : ι) :
    srgWeight A t a b = ((1 + t) * A a b - t) + (if a = b then t else 0) := by
  simp only [srgWeight, Matrix.of_apply]
  by_cases hab : a = b
  · subst hab; rw [if_pos rfl, if_pos rfl, hh a]; ring
  · rw [if_neg hab, if_neg hab]; ring

theorem srgWeight_symm {A : Matrix ι ι ℝ} (hs : ∀ a b, A a b = A b a) (t : ℝ) (a b : ι) :
    srgWeight A t a b = srgWeight A t b a := by
  simp only [srgWeight, Matrix.of_apply]
  by_cases hab : a = b
  · subst hab; rfl
  · rw [if_neg hab, if_neg (Ne.symm hab), hs a b]

theorem srgWeight_hollow (A : Matrix ι ι ℝ) (t : ℝ) (a : ι) : srgWeight A t a a = 0 := by
  simp [srgWeight]

/-- **Zero row sums, and this is what forces `t = k/w`.** *`Σ_c N_ac = k - t(v-1-k)`, so
Ricci-flatness on the locus is exactly the record's `b = -ak/(v-1-k)`.* -/
theorem srgWeight_rowSum {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu) (t : ℝ)
    (a : ι) : ∑ c : ι, srgWeight A t a c = k - t * (v - 1 - k) := by
  have hent : ∀ c : ι, srgWeight A t a c = ((1 + t) * A a c - t) + (if a = c then t else 0) :=
    fun c => srgWeight_entry hA.hollow t a c
  rw [Finset.sum_congr rfl fun c _ => hent c, Finset.sum_add_distrib,
    Finset.sum_ite_eq Finset.univ a (fun _ => t), if_pos (Finset.mem_univ a)]
  have h1 : ∑ c : ι, ((1 + t) * A a c - t) = (1 + t) * k - t * v := by
    rw [Finset.sum_sub_distrib, ← Finset.mul_sum, hA.deg a, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul, hA.card]
    ring
  rw [h1]; ring

/-- **The ansatz lands in `𝒟ₙ`** at `t = k/w`, so `diagOp (srgWeight A (tOf v k))` is a Weyl
operator. -/
theorem srgWeight_isWeight {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hw : v - 1 - k ≠ 0) : IsWeight (srgWeight A (tOf v k)) where
  symm := srgWeight_symm hA.symm _
  hollow := srgWeight_hollow A _
  rowSum a := by
    rw [srgWeight_rowSum hA _ a, tOf, div_mul_cancel₀ _ hw]
    ring

theorem srgWeight_isWeight_smul {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hw : v - 1 - k ≠ 0) (s : ℝ) : IsWeight (s • srgWeight A (tOf v k)) :=
  (srgWeight_isWeight hA hw).smul s

/-- **`W` is a Weyl operator**, from the base layer, so the whole statement is about an admissible
competitor. -/
theorem isWeyl_srg {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hw : v - 1 - k ≠ 0) (s : ℝ) : IsWeyl (diagOp (s • srgWeight A (tOf v k))) :=
  diagOp_isWeyl (srgWeight_isWeight_smul hA hw s)

/-! ## The matrix square, one formula for both entry values -/

/-- **`(N²)_ab = (1+t)²p_ab - 2t(1+t)(k - A_ab) + t²(v-2)`** off the diagonal, `p_ab = Σ_c A_ac A_cb`
the common-neighbour count. *One formula covering edges and non-edges, which is what makes the
criticality check a two-case split on `A_ab ∈ {0,1}` and nothing more.* -/
theorem srgWeight_mul_entry {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu) (t : ℝ)
    {a b : ι} (hab : a ≠ b) :
    (srgWeight A t * srgWeight A t) a b
      = (1 + t) ^ 2 * (∑ c : ι, A a c * A c b) - 2 * t * (1 + t) * (k - A a b) + t ^ 2 * (v - 2) := by
  have hent : ∀ x y : ι, srgWeight A t x y = ((1 + t) * A x y - t) + (if x = y then t else 0) :=
    fun x y => srgWeight_entry hA.hollow t x y
  rw [Matrix.mul_apply]
  have hterm : ∀ c : ι, srgWeight A t a c * srgWeight A t c b
      = ((1 + t) ^ 2 * (A a c * A c b) - t * (1 + t) * A a c - t * (1 + t) * A c b + t ^ 2)
        + (if a = c then t * ((1 + t) * A c b - t) else 0)
        + (if c = b then t * ((1 + t) * A a c - t) else 0) := by
    intro c
    rw [hent a c, hent c b]
    by_cases h1 : a = c
    · by_cases h2 : c = b
      · exact absurd (h1.trans h2) hab
      · rw [if_pos h1, if_neg h2, if_pos h1, if_neg h2]; ring
    · by_cases h2 : c = b
      · rw [if_neg h1, if_pos h2, if_neg h1, if_pos h2]; ring
      · rw [if_neg h1, if_neg h2, if_neg h1, if_neg h2]; ring
  rw [Finset.sum_congr rfl fun c _ => hterm c, Finset.sum_add_distrib, Finset.sum_add_distrib]
  have hA1 : ∑ c : ι, ((1 + t) ^ 2 * (A a c * A c b) - t * (1 + t) * A a c
      - t * (1 + t) * A c b + t ^ 2)
      = (1 + t) ^ 2 * (∑ c : ι, A a c * A c b) - t * (1 + t) * k - t * (1 + t) * k + v * t ^ 2 := by
    rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_sub_distrib,
      ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum, hA.deg a, Finset.sum_const,
      Finset.card_univ, nsmul_eq_mul, hA.card]
    have : ∑ c : ι, A c b = k := by
      rw [Finset.sum_congr rfl fun c _ => hA.symm c b, hA.deg b]
    rw [this]
  have hA2 : ∑ c : ι, (if a = c then t * ((1 + t) * A c b - t) else 0)
      = t * ((1 + t) * A a b - t) := by
    rw [Finset.sum_ite_eq Finset.univ a (fun c => t * ((1 + t) * A c b - t)),
      if_pos (Finset.mem_univ a)]
  have hA3 : ∑ c : ι, (if c = b then t * ((1 + t) * A a c - t) else 0)
      = t * ((1 + t) * A a b - t) := by
    rw [Finset.sum_ite_eq' Finset.univ b (fun c => t * ((1 + t) * A a c - t)),
      if_pos (Finset.mem_univ b)]
  rw [hA1, hA2, hA3]
  ring

/-! ## The multiplier, and the admissibility condition -/

/-- **`F` on edges**, `[(N²)_ab + N_ab²]/N_ab` at `A_ab = 1`, where `N_ab = 1`. -/
noncomputable def Fedge (v k lam t : ℝ) : ℝ :=
  1 + (1 + t) ^ 2 * lam - 2 * t * (1 + t) * (k - 1) + t ^ 2 * (v - 2)

/-- **`F` on non-edges**, the same ratio at `A_ab = 0`, where `N_ab = -t`. -/
noncomputable def Fnon (v k mu t : ℝ) : ℝ :=
  -(t ^ 2 + (1 + t) ^ 2 * mu - 2 * t * (1 + t) * k + t ^ 2 * (v - 2)) / t

/-- **The record's closed form**, `F = [(v-1)²λ + 2k(v-1) - k²v + w²]/w²`. -/
noncomputable def Fclosed (v k lam : ℝ) : ℝ :=
  ((v - 1) ^ 2 * lam + 2 * k * (v - 1) - k ^ 2 * v + (v - 1 - k) ^ 2) / (v - 1 - k) ^ 2

/-- **The edge value IS the closed form**, with no use of the graph identity, the identity is what
the *non-edge* value costs. -/
theorem Fedge_eq_Fclosed {v k lam : ℝ} (hw : v - 1 - k ≠ 0) :
    Fedge v k lam (tOf v k) = Fclosed v k lam := by
  unfold Fedge Fclosed tOf
  field_simp
  ring

/-- **THE ADMISSIBILITY CONDITION IS THE GRAPH IDENTITY.** `F` takes the same value on edges and on
non-edges exactly when `k(k-λ-1) = (v-1-k)μ`. *One scalar equation in `(v,k,λ,μ)`, and it is the
standard strongly regular identity, so it holds automatically and every strongly regular graph
yields a critical point, with no further constraint.* -/
theorem admissibility_iff_srg_identity {v k lam mu : ℝ} (hw : v - 1 - k ≠ 0) (hk : k ≠ 0)
    (hu : v - 1 ≠ 0) :
    Fedge v k lam (tOf v k) = Fnon v k mu (tOf v k) ↔ k * (k - lam - 1) = (v - 1 - k) * mu := by
  have hden : (v - 1 - k) ^ 2 * k ≠ 0 := mul_ne_zero (pow_ne_zero 2 hw) hk
  have hu2 : (v - 1) ^ 2 ≠ 0 := pow_ne_zero 2 hu
  have hdiff : Fedge v k lam (tOf v k) - Fnon v k mu (tOf v k)
      = (v - 1) ^ 2 * ((v - 1 - k) * mu - k * (k - lam - 1)) / ((v - 1 - k) ^ 2 * k) := by
    unfold Fedge Fnon tOf
    field_simp
    ring
  constructor
  · intro h
    have h0 : (v - 1) ^ 2 * ((v - 1 - k) * mu - k * (k - lam - 1)) = 0 := by
      have hz : Fedge v k lam (tOf v k) - Fnon v k mu (tOf v k) = 0 := by rw [h]; ring
      rw [hdiff, div_eq_zero_iff] at hz
      rcases hz with hz | hz
      · exact hz
      · exact absurd hz hden
    rcases mul_eq_zero.mp h0 with hz | hz
    · exact absurd hz hu2
    · linarith
  · intro h
    have hz : Fedge v k lam (tOf v k) - Fnon v k mu (tOf v k) = 0 := by
      rw [hdiff]
      have : (v - 1 - k) * mu - k * (k - lam - 1) = 0 := by linarith
      rw [this]
      simp
    linarith

/-! ## Every strongly regular graph is a diagonal critical point -/

/-- **THE HEADLINE: `M^{∘2} + M² = F·M` off the diagonal**, at every strongly regular graph, with the
one multiplier `Fclosed v k lam`. *The edge row needs no identity; the non-edge row is exactly where
`k(k-λ-1) = wμ` is consumed.* -/
theorem srg_isDiagCritical {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hw : v - 1 - k ≠ 0) (hk : k ≠ 0) {a b : ι} (hab : a ≠ b) :
    srgWeight A (tOf v k) a b ^ 2 + (srgWeight A (tOf v k) * srgWeight A (tOf v k)) a b
      = Fclosed v k lam * srgWeight A (tOf v k) a b := by
  set t := tOf v k with ht
  have hmul := srgWeight_mul_entry hA t hab
  have hmu : mu = k * (k - lam - 1) / (v - 1 - k) := by
    rw [eq_div_iff hw]; linarith [hA.hident]
  rcases hA.zeroOne a b with h0 | h1
  · -- non-edge
    have hp := hA.mu_count a b hab h0
    have hN : srgWeight A t a b = -t := by
      simp only [srgWeight, Matrix.of_apply]; rw [if_neg hab, h0]; ring
    rw [hN, hmul, hp, h0, hmu]
    simp only [ht, tOf, Fclosed]
    field_simp
    ring
  · -- edge
    have hp := hA.lam_count a b hab h1
    have hN : srgWeight A t a b = 1 := by
      simp only [srgWeight, Matrix.of_apply]; rw [if_neg hab, h1]; ring
    rw [hN, hmul, hp, h1]
    simp only [ht, tOf, Fclosed]
    field_simp
    ring

/-! ## The norm, and the record's unit scale -/

/-- **`‖diagOp N‖² = v(k(1-t²) + t²(v-1))/2`**, which at `t = k/w` is the record's
`vk(v-1)/(2w)`. -/
theorem srgWeight_normSq {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu) (t : ℝ) :
    normSq (diagOp (srgWeight A t)) = (1 / 2) * (v * (k * (1 - t ^ 2) + t ^ 2 * (v - 1))) := by
  rw [diagOp_normSq _ (srgWeight_symm hA.symm t) (srgWeight_hollow A t)]
  have hrow : ∀ i : ι, ∑ j : ι, (srgWeight A t i j) ^ 2
      = k * (1 - t ^ 2) + t ^ 2 * (v - 1) := by
    intro i
    have hterm : ∀ j : ι, (srgWeight A t i j) ^ 2
        = ((1 + t) ^ 2 * A i j - 2 * t * (1 + t) * A i j + t ^ 2)
          - (if i = j then t ^ 2 else 0) := by
      intro j
      by_cases hij : i = j
      · subst hij
        rw [srgWeight_hollow A t i, if_pos rfl, hA.hollow i]
        ring
      · rw [if_neg hij]
        simp only [srgWeight, Matrix.of_apply]
        rw [if_neg hij]
        rcases hA.zeroOne i j with h0 | h1
        · rw [h0]; ring
        · rw [h1]; ring
    rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib,
      Finset.sum_ite_eq Finset.univ i (fun _ => t ^ 2), if_pos (Finset.mem_univ i)]
    have h1 : ∑ j : ι, ((1 + t) ^ 2 * A i j - 2 * t * (1 + t) * A i j + t ^ 2)
        = (1 + t) ^ 2 * k - 2 * t * (1 + t) * k + v * t ^ 2 := by
      rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum,
        hA.deg i, Finset.sum_const, Finset.card_univ, nsmul_eq_mul, hA.card]
    rw [h1]; ring
  rw [Finset.sum_congr rfl fun i _ => hrow i, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
    hA.card]

/-- **`‖diagOp N‖² = vk(v-1)/(2w)`** at the forced `t`, which is the record's display. -/
theorem srgWeight_normSq_at_t {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hw : v - 1 - k ≠ 0) :
    normSq (diagOp (srgWeight A (tOf v k))) = v * k * (v - 1) / (2 * (v - 1 - k)) := by
  rw [srgWeight_normSq hA (tOf v k), tOf]
  field_simp
  ring

/-- **The record's unit scale**: `a² = 2w/(vk(v-1))` makes `‖a·N‖² = 1`. -/
theorem srg_unit_scale_sq {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hw : v - 1 - k ≠ 0) (hv : v ≠ 0) (hk : k ≠ 0) (hu : v - 1 ≠ 0) {s : ℝ}
    (hs : s ^ 2 = 2 * (v - 1 - k) / (v * k * (v - 1))) :
    normSq (diagOp (s • srgWeight A (tOf v k))) = 1 := by
  rw [diagOp_normSq_smul _ _ (srgWeight_symm hA.symm _) (srgWeight_hollow A _),
    srgWeight_normSq_at_t hA hw, hs]
  field_simp

/-! ## At a unit-norm critical point `θ` is the multiplier -/

/-- **`θ(R) = θ` at a unit-norm critical point**, from `P = ⟨R, Q(R)⟩` and nothing else. *This is
the step that turns the criticality multiplier into the record's `θ = P/‖W‖³`.* -/
theorem theta_of_critical_unit {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {th : ℝ} (hc : IsCritical R th)
    (hn : normSq R = 1) : theta R = th := by
  have hP : Pcubic R = th := by
    rw [Pcubic_eq_inner_Qop]
    have hterm : ∀ i j : ι, inner2 (R (phi i j)) (Qop R (phi i j))
        = th * inner2 (R (phi i j)) (R (phi i j)) := by
      intro i j
      rw [hc i j, inner2_smul_right]
    unfold innerOp
    rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hterm i j]
    rw [Finset.sum_congr rfl fun i _ =>
      (Finset.mul_sum Finset.univ (fun j => inner2 (R (phi i j)) (R (phi i j))) th).symm,
      ← Finset.mul_sum]
    have hS : ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (R (phi i j)) = 2 := by
      have hd : normSq R = (1 / 2) * ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (R (phi i j)) := rfl
      rw [hn] at hd
      linarith
    rw [hS]
    ring
  unfold theta RealLayer.norm
  rw [hn, Real.sqrt_one, one_pow, div_one, hP]

/-! ## The bridge to the `Λ²` picture, named rather than assumed silently -/

/-! *Defined in [Base/Families.lean](../Base/Families.lean) and used from there.* **It was defined here AND in [L68Statement.lean](L68Statement.lean), identically and under two namespaces**, which defeats the reason it is a `Prop`: one discharge would have left the other file's consumers gated. -/

/-! ## The lemma -/

/-- **`θ/‖W‖` in closed form**, the record's display: `F·√(2w/(vk(v-1)))`. -/
noncomputable def thetaSRG (v k lam : ℝ) : ℝ :=
  Fclosed v k lam * Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1)))

/-- **[Lemma L74](../../../findings/diagonal-half.md) AT ITS OWN WITNESS**, which is what a
consumer holding a particular operator needs.

*The existential below is this statement with the witness forgotten. It was the only form on
file, and an existential hands back A `W` with no reason it is the one in hand, which is exactly
the gap [L144Statement.lean](L144Statement.lean)'s `L74Bridge` could not cross.* **The witness
was explicit in the proof all along**, so this is the same argument with its conclusion stated
rather than a new one. -/
theorem srg_theta_closed_form_at (hbridge : DiagCriticalityIsCritical (ι := ι))
    {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hv : 0 < v) (hk : 0 < k) (hw : 0 < v - 1 - k) (hu : 0 < v - 1) :
    IsWeyl (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k)))
      ∧ normSq (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))) = 1
      ∧ IsCritical (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))) (thetaSRG v k lam)
      ∧ theta (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))) = thetaSRG v k lam := by
  have hwne : v - 1 - k ≠ 0 := ne_of_gt hw
  have hkne : k ≠ 0 := ne_of_gt hk
  have hvne : v ≠ 0 := ne_of_gt hv
  have hune : v - 1 ≠ 0 := ne_of_gt hu
  set s : ℝ := Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) with hsdef
  have hspos : 0 < 2 * (v - 1 - k) / (v * k * (v - 1)) := by positivity
  have hs2 : s ^ 2 = 2 * (v - 1 - k) / (v * k * (v - 1)) := Real.sq_sqrt hspos.le
  refine ⟨isWeyl_srg hA hwne s,
    srg_unit_scale_sq hA hwne hvne hkne hune hs2, ?_, ?_⟩
  · refine hbridge _ _ (srgWeight_isWeight_smul hA hwne s) ?_
    intro a b hab
    have hcrit := srg_isDiagCritical hA hwne hkne hab
    have hmul : ((s • srgWeight A (tOf v k)) * (s • srgWeight A (tOf v k))) a b
        = s ^ 2 * (srgWeight A (tOf v k) * srgWeight A (tOf v k)) a b := by
      simp only [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_apply, smul_eq_mul]
      ring
    simp only [Matrix.smul_apply, smul_eq_mul, hmul, thetaSRG, ← hsdef]
    nlinarith [hcrit]
  · refine theta_of_critical_unit ?_ (srg_unit_scale_sq hA hwne hvne hkne hune hs2)
    refine hbridge _ _ (srgWeight_isWeight_smul hA hwne s) ?_
    intro a b hab
    have hcrit := srg_isDiagCritical hA hwne hkne hab
    have hmul : ((s • srgWeight A (tOf v k)) * (s • srgWeight A (tOf v k))) a b
        = s ^ 2 * (srgWeight A (tOf v k) * srgWeight A (tOf v k)) a b := by
      simp only [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_apply, smul_eq_mul]
      ring
    simp only [Matrix.smul_apply, smul_eq_mul, hmul, thetaSRG, ← hsdef]
    nlinarith [hcrit]

/-- **LEMMA L74.** *Let `Γ` be strongly regular with parameters `(v,k,λ,μ)` (so `n = v`) and let
`W` be the unit-norm diagonal Weyl tensor it determines. Then `W` is a critical point of `P` and*
`θ(W) = F·√(2w/(vk(v-1)))`, `w = v-1-k`.

*The multiplier is proved outright in `srg_isDiagCritical`; the bridge from that matrix equation to
`IsCritical` is the base layer's owed `sharpOp` step, carried as `DiagCriticalityIsCritical`.* -/
theorem srg_theta_closed_form (hbridge : DiagCriticalityIsCritical (ι := ι))
    {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hv : 0 < v) (hk : 0 < k) (hw : 0 < v - 1 - k) (hu : 0 < v - 1) :
    ∃ W : Matrix ι ι ℝ → Matrix ι ι ℝ,
      IsWeyl W ∧ normSq W = 1 ∧ IsCritical W (thetaSRG v k lam)
        ∧ theta W = thetaSRG v k lam :=
  ⟨_, srg_theta_closed_form_at hbridge hA hv hk hw hu⟩

/-! ## The same number in L144's parameters -/

/-- **`F = (1+λ-μ)(v-1)/w`**, the identity that makes the closed form and `L144`'s
`|1+λ-μ|√(2(n-1)/(nk(n-1-k)))` the same number. -/
theorem Fclosed_eq_lam_sub_mu {v k lam mu : ℝ} (hw : v - 1 - k ≠ 0)
    (hid : k * (k - lam - 1) = (v - 1 - k) * mu) :
    Fclosed v k lam = (1 + lam - mu) * (v - 1) / (v - 1 - k) := by
  unfold Fclosed
  field_simp
  linear_combination (-(v - 1)) * hid

/-- **`θ² = (1+λ-μ)²·2(v-1)/(vkw)`**, [L144Statement.lean](L144Statement.lean)'s `SRG.thetaSq`
exactly, so its arithmetic is a statement about the record's `θ`. -/
theorem thetaSRG_sq_eq_L144_form {v k lam mu : ℝ} (hv : 0 < v) (hk : 0 < k) (hw : 0 < v - 1 - k)
    (hu : 0 < v - 1) (hid : k * (k - lam - 1) = (v - 1 - k) * mu) :
    thetaSRG v k lam ^ 2
      = (1 + lam - mu) ^ 2 * (2 * (v - 1)) / (v * k * (v - 1 - k)) := by
  have hwne : v - 1 - k ≠ 0 := ne_of_gt hw
  have hspos : (0 : ℝ) ≤ 2 * (v - 1 - k) / (v * k * (v - 1)) := by positivity
  unfold thetaSRG
  rw [mul_pow, Real.sq_sqrt hspos, Fclosed_eq_lam_sub_mu hwne hid]
  field_simp

/-! ## The block's own Gate 1(a) values, in closed form -/

/-- **The octahedron `K_{2,2,2} = SRG(6,4,2,4)` has `F = -5`.** *`50 + 40 - 96 + 1`.* -/
theorem octahedron_F : Fclosed 6 4 2 = -5 := by unfold Fclosed; norm_num

/-- **and `θ² = 5/12`**, i.e. `|θ| = 5/√60 = 0.645497`, this record's catalogued `n = 6` maximal
torus. -/
theorem octahedron_thetaSq : thetaSRG 6 4 2 ^ 2 = 5 / 12 := by
  unfold thetaSRG
  rw [mul_pow, octahedron_F, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2 * (6 - 1 - 4) / (6 * 4 * (6 - 1)))]
  norm_num

/-- **EVERY CONFERENCE GRAPH HAS `θ = 0` EXACTLY**: `k = (v-1)/2`, `λ = (v-5)/4` make the numerator
`(v-1)²·0`. -/
theorem conference_F_zero (v : ℝ) :
    Fclosed v ((v - 1) / 2) ((v - 5) / 4) = 0 := by
  unfold Fclosed
  rw [div_eq_zero_iff]
  left
  ring

/-- **The Petersen graph `SRG(10,3,0,1)` also has `θ = 0`.** -/
theorem petersen_F_zero : Fclosed 10 3 0 = 0 := by unfold Fclosed; norm_num

/-- **and it is not a conference graph**, those needing `2k = v-1` and `2·3 ≠ 9`, so its vanishing
is a separate solution of `F = 0`. -/
theorem petersen_not_conference : (2 : ℝ) * 3 ≠ 10 - 1 := by norm_num

/-- **The saturating member is the balanced sphere product.** `SRG(2m,m,0,m) = K_{m,m}` returns
exactly `θ₀(2m)²`, the balanced product's own value, at every `m ≥ 2`. -/
theorem balanced_product_thetaSq {m : ℝ} (hm : 2 ≤ m) :
    thetaSRG (2 * m) m 0 ^ 2 = FamilyLayer.theta0Sq (2 * m) := by
  have hm0 : (0 : ℝ) < m := by linarith
  have hm1 : (0 : ℝ) < m - 1 := by linarith
  have hw : (0 : ℝ) < 2 * m - 1 - m := by linarith
  have h2m1 : (0 : ℝ) < 2 * m - 1 := by linarith
  have hm0' : m ≠ 0 := ne_of_gt hm0
  have hm1' : m - 1 ≠ 0 := ne_of_gt hm1
  have h2m1' : 2 * m - 1 ≠ 0 := ne_of_gt h2m1
  have hnn : (0 : ℝ) ≤ 2 * (2 * m - 1 - m) / (2 * m * m * (2 * m - 1)) := by positivity
  unfold thetaSRG FamilyLayer.theta0Sq Fclosed
  rw [mul_pow, Real.sq_sqrt hnn]
  have h1 : (2 * m - 1 - m) = m - 1 := by ring
  rw [h1]
  field_simp
  ring

/-! ## The hypotheses are satisfiable -/

/-- **`K_{2,2} = SRG(4,2,0,2)`**, the `m = 2` member of the saturating family, so nothing above is
vacuous. *Vertices `{0,1}` and `{2,3}`, every cross pair an edge.* -/
def k22 : Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.of fun a b =>
    if ((a : ℕ) < 2 ∧ (b : ℕ) < 2) ∨ (2 ≤ (a : ℕ) ∧ 2 ≤ (b : ℕ)) then 0 else 1

theorem k22_isSRG : IsSRG k22 4 2 0 2 where
  symm a b := by fin_cases a <;> fin_cases b <;> norm_num [k22]
  hollow a := by fin_cases a <;> norm_num [k22]
  zeroOne a b := by fin_cases a <;> fin_cases b <;> norm_num [k22]
  card := by norm_num
  deg a := by fin_cases a <;> norm_num [k22, Fin.sum_univ_succ]
  lam_count a b hab hedge := by
    fin_cases a <;> fin_cases b <;>
      simp_all [k22, Fin.sum_univ_succ]
  mu_count a b hab hnon := by
    fin_cases a <;> fin_cases b <;>
      simp_all [k22, Fin.sum_univ_succ] <;> norm_num
  hident := by norm_num

/-! ## The binder is discharged, 2026-09-22

*`DiagCriticalityIsCritical` was carried as a hypothesis here because the base layer owed the
`sharpOp` step. That debt was paid on 2026-09-21 by `diagCriticalityIsCritical` in
[SharpDiag.lean](../Base/SharpDiag.lean), a file carrying no `sorry`, and three sites in
[L144Statement.lean](L144Statement.lean) went on calling it owed for a day afterwards.*
-/

/-- **THE WITNESS FORM WITH ITS BINDER SUPPLIED**, so a consumer needs no hypothesis AND gets
the operator it is holding rather than an existential.

*This is the pair `L74Bridge` in [L144Statement.lean](L144Statement.lean) was missing: it had
the unconditional form and the translation between the two `IsSRG` spellings, and the only gap
left was that the conclusion forgot its witness.* -/
theorem srg_theta_closed_form_at_uncond
    {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hv : 0 < v) (hk : 0 < k) (hw : 0 < v - 1 - k) (hu : 0 < v - 1) :
    IsWeyl (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k)))
      ∧ normSq (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))) = 1
      ∧ IsCritical (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))) (thetaSRG v k lam)
      ∧ theta (diagOp (Real.sqrt (2 * (v - 1 - k) / (v * k * (v - 1))) • srgWeight A (tOf v k))) = thetaSRG v k lam :=
  srg_theta_closed_form_at HamiltonsCubic.RealLayer.diagCriticalityIsCritical hA hv hk hw hu

/-- **[Lemma L74](../../../findings/diagonal-half.md), UNCONDITIONALLY.** The same statement as
`srg_theta_closed_form` with its binder supplied, so a consumer needs no hypothesis. -/
theorem srg_theta_closed_form_uncond
    {A : Matrix ι ι ℝ} {v k lam mu : ℝ} (hA : IsSRG A v k lam mu)
    (hv : 0 < v) (hk : 0 < k) (hw : 0 < v - 1 - k) (hu : 0 < v - 1) :
    ∃ W : Matrix ι ι ℝ → Matrix ι ι ℝ,
      IsWeyl W ∧ normSq W = 1 ∧ IsCritical W (thetaSRG v k lam)
        ∧ theta W = thetaSRG v k lam :=
  srg_theta_closed_form HamiltonsCubic.RealLayer.diagCriticalityIsCritical hA hv hk hw hu

end HamiltonsCubic.L74Statement
