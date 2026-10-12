import Mathlib
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L68, the symmetry defect on the diagonal locus, and the entry cap criticality forces

**The record's block, quoted from [diagonal-half.md](../../../findings/diagonal-half.md):**

> #### Lemma L68, the symmetry defect on the diagonal locus, and the entry cap criticality forces
>
> Write `Mₐ` for row `a` of `M` and `sₐ = ‖Mₐ‖²`, and let `g_γ := ‖[ad(v_γ), W]‖²` be the
> Petersen–Wink Prop 1.7 density whose trace over the strictly positive eigenspace is the symmetry
> defect `Δ`. On the diagonal locus every eigenvector is a coordinate bivector `φ_ab`, the structure
> tensor is the single monomial `[φ_ab, φ_bd] = φ_ad`, and everything becomes explicit.
>
> **(i) The density, with no hypothesis at all.** `[ad(φ_ab), W]` moves only the `2(n-2)` directions
> `φ_ad, φ_bd`, sending `φ_bd ↦ (M_bd - M_ad)φ_ad` **and `φ_ad ↦ (M_bd - M_ad)φ_bd`**, **two moved
> families, which is where the factor `2` comes from** …
> $$g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2\lVert M_a-M_b\rVert^2-4M_{ab}^2=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2,$$
> the middle step because `M` is hollow, which makes both dropped coordinates equal to `M_ab²`.
>
> **(ii) `Δ = 0` is a blow-up condition.** Since `Δ = Σ_{M_ab>0} g_ab`, it vanishes exactly when
> every **positive** edge joins **twins**, `M_ad = M_bd` for every `d` outside the pair. Linkage is
> then transitive … So the components of `G⁺ = {ab : M_ab > 0}` are cliques of mutually twin
> vertices … *Corollary (Reviewer 292):* a singleton block forces an identically zero row, since all
> its entries are cross entries, hence `≤ 0`, and they sum to `0`.
>
> **(iii) At a critical point the density is affine in the entry, and caps it.** The criticality
> equation reads off-diagonally `M_ab² + (M²)_ab = θ M_ab`, and substituting into (i) cancels both
> quadratic terms:
> $$g_{ab}=2(s_a+s_b)-4\theta M_{ab}\qquad(a\ne b).$$
> Since `g_ab ≥ 0`, **every entry of a diagonal critical point is capped by its own two row norms**,
> `2θ M_ab ≤ s_a + s_b`, with equality exactly at twin pairs **in the off-pair sense of (ii)**,
> which is *not* equality of rows: identical rows would force `M_ab = 0` … so for `θ > 0`
> $$\theta\ \le\ \min_{M_{ab}>0}\frac{s_a+s_b}{2M_{ab}},\qquad\text{and exactly}\qquad \theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}\ \text{ at every positive edge.}$$
> The cap needs criticality, symmetry, hollowness **and `M𝟙 = 0`** … *No sign condition on `θ` is
> used: the cap holds at every sign, and the `θ > 0` guard on the min form is needed only to divide.*
>
> **(iv) Traced over `𝔭`, and this part needs `M𝟙 = 0` as well as criticality.** *… hollowness with
> `M𝟙 = 0` gives `Σ_{a<b} M_ab = 0`, hence `‖M‖₁ = 2Σ_{M_ab>0} M_ab`.* **Without `M𝟙 = 0` the
> identity is false by a factor of two**, `M = c(J-I)` is hollow, symmetric, unit-norm and satisfies
> the boxed criticality equation with `θ = (n-1)c`, part (iii) holds at it exactly, and (iv) reads
> `3` against `6` at `n = 4`. …
> $$\theta\,\lVert M\rVert_1=\sum_a d_a^+s_a-\tfrac12\Delta .$$

## What this file states

All four parts, over `ℝ` at a general index type, on the **weight** `w` the record calls `M`, the
object [Base/Families.lean](../Base/Families.lean) makes the diagonal locus out of, so `diagOp w` is
the Weyl operator `W` and `IsWeight w` is membership of `𝒟ₙ`.

* **(i)** `gDensity` is the record's `2 Σ_{d ≠ a,b}(w_ad - w_bd)²`, and `pwDensity` is the
  Petersen–Wink density itself, `‖[ad(φ_ab), diagOp w]‖²`, the Hilbert–Schmidt norm of an honest
  operator commutator on `Λ²`. `pwDensity_eq_gDensity` is the identification, **proved** (2026-09-24). `gDensity_closed_form` is the rest of the display, proved.
* **(ii)** `defect_eq_zero_iff`, `Δ = 0` **exactly** when every positive edge joins off-pair twins;
  `twin_of_positive_edge`, `positive_neighbourhood_clique` and `linkage_transitive`, the clique
  structure; `isolated_row_zero`, Reviewer 292's singleton corollary.
* **(iii)** `gDensity_at_critical`, `entry_cap`, `entry_cap_ratio` (the `min` form's per-edge half),
  `theta_exact_at_positive_edge`, `cap_equality_iff_twin`, and `rows_equal_forces_zero_entry`, the
  record's own warning that the equality case is *not* equality of rows.
* **(iv)** `defect_identity`, `θ‖M‖₁ = Σ_a d_a⁺ s_a - ½Δ`, with `M𝟙 = 0` carried as a hypothesis
  and used exactly where the block says it is; `positive_mass_eq_l1` is that use, isolated.
* **The hypotheses of (iv) are load-bearing and satisfiable, both by exhibited points.**
  `completeGraph_not_identity` is the record's own `M = c(J-I)` at `n = 4`, which meets every
  hypothesis but `M𝟙 = 0` and misses (iv) by the factor of two the record names; `balanced_witness`
  is `S¹ × S¹` at `n = 4`, which meets all of them and at which (iv) is an equality, `24 = 24`.

**The convention.** Sums run over **ordered** pairs and `defect` and `l1` carry the compensating
`½`, so `defect` is the record's `Δ` summed over *unordered* positive pairs, the reading (iv) is
stated in, which the block flags as against `conventions.md`'s ordered default.

## What is NOT typed here

* **That the Petersen–Wink density is the record's elementary sum**, `pwDensity = gDensity`. This is
  (i)'s first equality, **proved 2026-09-24**; the remainder of this entry records how it was once
  described as owed. What it needs is the bracket `[φ_ab, φ_cd]` on
  the whole `φ` basis (the structure constants of `𝔰𝔬(n)` in the pair basis) which no file of the
  base layer carries; the record's derivation is the sentence *"`[ad(φ_ab), W]` moves only the
  `2(n-2)` directions `φ_ad, φ_bd`"*, and it is that case analysis that is missing rather than any
  further mathematics.
* **That `Δ` is the trace of `g` over the strictly positive eigenspace**, which is the definition
  the record imports from Petersen–Wink Prop 1.7 and from `bounds.md`. `defect` here is the sum over
  positive **edges**, which on the diagonal locus is that trace because the eigenvectors are the
  coordinate bivectors and the eigenvalues are the entries, a sentence about the spectrum of
  `diagOp w`, not typed.
* **That the diagonal criticality equation is `IsCritical (diagOp w) θ`**, i.e. that `Q` acts on
  `φ_ab` by `w_ab² + (w²)_ab`. That is the base layer's owed evaluation of `sharpOp` on the `φ`
  basis, which [Base/Families.lean](../Base/Families.lean) itself names rather than proves (its
  `DiagCubicFormula` was the same gap for `P` and is now PROVED in [SharpDiag.lean](../Base/SharpDiag.lean)). It is carried here as the named `Prop`
  `DiagCriticalityIsCritical`, and `isCritical_srg_form` is the one theorem that consumes it. *It is a hypothesis rather than a
  `sorry` because the base layer records the normalisation question itself as open,
  [WeylReal.lean](../Base/WeylReal.lean) says in as many words that *"whether `sharpOp` IS `R#`"* is
  owed, and *"a wrong normalisation there makes `sharpOp` the wrong operator"*. A `sorry` would
  assert the constant that question is about; the `Prop` states the implication the record's own
  derivation gives and leaves the constant where the base layer put it.*
* **The specialisation claim**, that (i) is `bounds-relaxations.md`'s `g_γ = 2Σ_α λ_α² R_{γα} - 2Q_γ`
  read on this locus, with `R_{γα}` the share-one-index indicator and `Q_(ab) = 2(M²)_ab`. That is a
  statement about the general `R` and `Q` of `bounds.md`, which no Lean layer carries.
* **Every numerical clause**: the `+0.075 … +0.370` violations criticality rules out, the `C₅`
  blow-up's `Δ = 12`, exactness at `S^{⌊n/2⌋} × S^{⌈n/2⌉}` for `n = 6, …, 20`, and the `n = 7`
  discontinuity witness.
-/

namespace HamiltonsCubic.L68Statement

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The record's objects -/

/-- **`s_a = ‖M_a‖²`**, the squared norm of row `a`. -/
def rowNormSq (w : Matrix ι ι ℝ) (a : ι) : ℝ := ∑ d : ι, w a d ^ 2

/-- **The record's density, `g_ab = 2 Σ_{d ≠ a,b} (M_ad - M_bd)²`.** *The two indices of the pair
are the two dropped coordinates, and dropping them is what the middle step of (i) undoes.* -/
def gDensity (w : Matrix ι ι ℝ) (a b : ι) : ℝ :=
  2 * ∑ d ∈ ({a, b} : Finset ι)ᶜ, (w a d - w b d) ^ 2

/-- **The Petersen–Wink density itself**: `‖[ad(φ_ab), W]‖²` at `W = diagOp w`, the Hilbert–Schmidt
norm of the commutator of the operator `X ↦ [φ_ab, X]` with `W`. *`normSq` is `innerOp` against
itself, which over ordered pairs with `‖φ_ij‖² = 1` is the sum over unordered pairs, the record's
`Λ²` norm exactly.* -/
noncomputable def pwDensity (w : Matrix ι ι ℝ) (a b : ι) : ℝ :=
  normSq (fun X => br (phi a b) (diagOp w X) - diagOp w (br (phi a b) X))

/-- **The symmetry defect `Δ = Σ_{M_ab > 0} g_ab`**, summed over **unordered** positive pairs,
which is what (iv) is stated in. *The `½` is the ordered double count.* -/
noncomputable def defect (w : Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ a : ι, ∑ b : ι, if 0 < w a b then gDensity w a b else 0

/-- **`‖M‖₁ = Σ_{a<b} |M_ab|`**, the record's `ℓ¹` mass over unordered pairs. -/
noncomputable def l1 (w : Matrix ι ι ℝ) : ℝ := (1 / 2) * ∑ a : ι, ∑ b : ι, |w a b|

/-- **`d_a⁺`, the positive degree of vertex `a`.** -/
noncomputable def dplus (w : Matrix ι ι ℝ) (a : ι) : ℝ :=
  ((Finset.univ.filter fun b => 0 < w a b).card : ℝ)

/-- **The diagonal criticality equation**, which is DGK's condition verbatim: `M` symmetric, hollow,
and `M_ab² + (M²)_ab = θ M_ab` off the diagonal. *The `a = b` row is absorbed by the record's
`diag(s)`, so it is no part of the hypothesis.* -/
def IsDiagCritical (w : Matrix ι ι ℝ) (th : ℝ) : Prop :=
  (∀ a b, w a b = w b a) ∧ (∀ a, w a a = 0) ∧
    (∀ a b, a ≠ b → w a b ^ 2 + (w * w) a b = th * w a b)

/-! ## (i) The density, with no hypothesis at all -/

/-- **The Petersen–Wink density is the record's elementary sum**, (i)'s first equality, **PROVED**
(2026-09-24). *`diagOp w` is the Hadamard product, so every entry of `[ad(φ_ab), diagOp w] φ_ij` is a
Kronecker expression; the squared entries collapse to single-index sums, the complement sum over
`{a,b}ᶜ` is the full sum less its two excluded terms, and symmetry of `w` matches the rest.* -/
theorem pwDensity_eq_gDensity (w : Matrix ι ι ℝ) (hs : ∀ a b, w a b = w b a) {a b : ι}
    (hab : a ≠ b) : pwDensity w a b = gDensity w a b := by
  have hc : ∑ d ∈ ({a, b} : Finset ι)ᶜ, (w a d - w b d) ^ 2
      = ∑ d, (w a d - w b d) ^ 2 - (w a a - w b a) ^ 2 - (w a b - w b b) ^ 2 := by
    rw [← Finset.sum_compl_add_sum ({a, b} : Finset ι), Finset.sum_pair hab]; ring
  unfold pwDensity normSq innerOp gDensity
  rw [hc]
  simp only [inner2_eq_sum, br, phi, diagOp, Matrix.sub_apply, Matrix.mul_apply, Matrix.of_apply,
    Matrix.single_apply]
  simp only [sq, mul_sub, sub_mul, ite_mul, mul_ite, zero_mul, mul_zero, one_mul, mul_one,
    Finset.sum_sub_distrib, Finset.mul_sum, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, Finset.sum_ite_irrel, Finset.sum_const_zero, ite_and]
  simp only [hab, Ne.symm hab, if_false, sub_zero, zero_sub, if_true]
  simp only [← Finset.mul_sum]
  have e3 : ∑ i, w i b * w i b = ∑ i, w b i * w b i :=
    Finset.sum_congr rfl fun i _ => by rw [hs i b]
  have e4 : ∑ i, w i a * w i b = ∑ i, w b i * w a i :=
    Finset.sum_congr rfl fun i _ => by rw [hs i a, hs i b]; ring
  have e5 : ∑ i, w a i * w b i = ∑ i, w b i * w a i := Finset.sum_congr rfl fun i _ => mul_comm _ _
  have e6 : ∑ i, w i a * w i a = ∑ i, w a i * w a i :=
    Finset.sum_congr rfl fun i _ => by rw [hs i a]
  have e7 : ∑ i, w i b * w i a = ∑ i, w b i * w a i :=
    Finset.sum_congr rfl fun i _ => by rw [hs i a, hs i b]
  simp only [e3, e4, e5, e6, e7]
  rw [hs b a]
  ring

/-- **The rest of (i), proved**: `g_ab = 2(s_a + s_b) - 4(M²)_ab - 4M_ab²`. *Hollowness is what
makes both dropped coordinates equal `M_ab²`, and symmetry is what turns `(M²)_ab = Σ_d M_ad M_db`
into `Σ_d M_ad M_bd`.* -/
theorem gDensity_closed_form {w : Matrix ι ι ℝ} (hs : ∀ a b, w a b = w b a)
    (hh : ∀ a, w a a = 0) {a b : ι} (hab : a ≠ b) :
    gDensity w a b
      = 2 * (rowNormSq w a + rowNormSq w b) - 4 * (w * w) a b - 4 * w a b ^ 2 := by
  have hpair : ({a, b} : Finset ι).sum (fun d => (w a d - w b d) ^ 2)
      = (w a a - w b a) ^ 2 + (w a b - w b b) ^ 2 := Finset.sum_pair hab
  have hsplit : ∑ d ∈ ({a, b} : Finset ι)ᶜ, (w a d - w b d) ^ 2
      = (∑ d : ι, (w a d - w b d) ^ 2) - ((w a a - w b a) ^ 2 + (w a b - w b b) ^ 2) := by
    have := Finset.sum_compl_add_sum ({a, b} : Finset ι) (fun d => (w a d - w b d) ^ 2)
    rw [hpair] at this
    linarith
  have hexp : ∑ d : ι, (w a d - w b d) ^ 2
      = rowNormSq w a + rowNormSq w b - 2 * ∑ d : ι, w a d * w b d := by
    unfold rowNormSq
    rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun d _ => by ring
  have hmul : (w * w) a b = ∑ d : ι, w a d * w b d := by
    rw [Matrix.mul_apply]
    exact Finset.sum_congr rfl fun d _ => by rw [hs d b]
  have hdrop : (w a a - w b a) ^ 2 + (w a b - w b b) ^ 2 = 2 * w a b ^ 2 := by
    rw [hh a, hh b, hs b a]; ring
  unfold gDensity
  rw [hsplit, hexp, hdrop, hmul]
  ring

/-- **`g_ab ≥ 0`**, which is the whole of the cap below. -/
theorem gDensity_nonneg (w : Matrix ι ι ℝ) (a b : ι) : 0 ≤ gDensity w a b := by
  unfold gDensity
  have : 0 ≤ ∑ d ∈ ({a, b} : Finset ι)ᶜ, (w a d - w b d) ^ 2 :=
    Finset.sum_nonneg fun _ _ => sq_nonneg _
  linarith

/-- **`g_ab = 0` exactly when `a` and `b` are twins off their own pair**, the sentence (ii) turns
`Δ = 0` into. -/
theorem gDensity_eq_zero_iff (w : Matrix ι ι ℝ) (a b : ι) :
    gDensity w a b = 0 ↔ ∀ d, d ≠ a → d ≠ b → w a d = w b d := by
  unfold gDensity
  rw [mul_eq_zero]
  constructor
  · rintro (h | h)
    · norm_num at h
    · intro d hda hdb
      have hmem : d ∈ ({a, b} : Finset ι)ᶜ := by
        simp only [Finset.mem_compl, Finset.mem_insert, Finset.mem_singleton]
        tauto
      have := (Finset.sum_eq_zero_iff_of_nonneg (fun _ _ => sq_nonneg _)).mp h d hmem
      have h2 := sq_eq_zero_iff.mp this
      linarith
  · intro h
    right
    refine Finset.sum_eq_zero fun d hd => ?_
    simp only [Finset.mem_compl, Finset.mem_insert, Finset.mem_singleton, not_or] at hd
    rw [h d hd.1 hd.2]
    ring

/-! ## (ii) `Δ = 0` is a blow-up condition -/

theorem defect_nonneg (w : Matrix ι ι ℝ) : 0 ≤ defect w := by
  have h : 0 ≤ ∑ a : ι, ∑ b : ι, if 0 < w a b then gDensity w a b else 0 :=
    Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => by
      split_ifs with hp
      · exact gDensity_nonneg w a b
      · exact le_refl 0
  unfold defect
  linarith

/-- **`Δ = 0` EXACTLY WHEN EVERY POSITIVE EDGE JOINS TWINS**, in the off-pair sense: `M_ad = M_bd`
for every `d` outside `{a,b}`. *This is (ii), and it is an equivalence rather than an implication.* -/
theorem defect_eq_zero_iff (w : Matrix ι ι ℝ) :
    defect w = 0 ↔ ∀ a b, 0 < w a b → ∀ d, d ≠ a → d ≠ b → w a d = w b d := by
  have hnn : ∀ a ∈ (Finset.univ : Finset ι),
      0 ≤ ∑ b : ι, if 0 < w a b then gDensity w a b else 0 := fun a _ =>
    Finset.sum_nonneg fun b _ => by
      split_ifs with h
      · exact gDensity_nonneg w a b
      · exact le_refl 0
  unfold defect
  rw [mul_eq_zero]
  constructor
  · rintro (h | h)
    · norm_num at h
    · intro a b hab d hda hdb
      have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h a (Finset.mem_univ a)
      have h2 := (Finset.sum_eq_zero_iff_of_nonneg
        (fun b _ => by
          split_ifs with h'
          · exact gDensity_nonneg w a b
          · exact le_refl 0)).mp h1 b (Finset.mem_univ b)
      rw [if_pos hab] at h2
      exact (gDensity_eq_zero_iff w a b).mp h2 d hda hdb
  · intro h
    right
    refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ => ?_
    split_ifs with hab
    · exact (gDensity_eq_zero_iff w a b).mpr (h a b hab)
    · rfl

/-- **A positive edge of a `Δ = 0` point joins twins**, stated on the edge rather than on the sum. -/
theorem twin_of_positive_edge {w : Matrix ι ι ℝ} (h : defect w = 0) {a b : ι} (hab : 0 < w a b)
    (d : ι) (hda : d ≠ a) (hdb : d ≠ b) : w a d = w b d :=
  (defect_eq_zero_iff w).mp h a b hab d hda hdb

/-- **The positive neighbourhood of a vertex is a clique**, which is (ii)'s *"components of `G⁺` are
cliques of mutually twin vertices"* at one vertex. *`w_ab > 0` and `w_ac > 0` with `b ≠ c` force
`w_bc = w_ac > 0`.* -/
theorem positive_neighbourhood_clique {w : Matrix ι ι ℝ} (hh : ∀ a, w a a = 0)
    (h : defect w = 0) {a b c : ι} (hb : 0 < w a b) (hc : 0 < w a c) (hbc : b ≠ c) :
    0 < w b c := by
  have hca : c ≠ a := by
    rintro rfl; rw [hh c] at hc; exact lt_irrefl 0 hc
  have := twin_of_positive_edge h hb c hca (Ne.symm hbc)
  linarith

/-- **Linkage is transitive**, the record's own step: `a-b` and `b-c` positive force `w_ac = w_bc`,
hence positive. -/
theorem linkage_transitive {w : Matrix ι ι ℝ} (hh : ∀ a, w a a = 0) (h : defect w = 0)
    {a b c : ι} (hab : 0 < w a b) (hbc : 0 < w b c) (hac : a ≠ c) :
    w a c = w b c ∧ 0 < w a c := by
  have hcb : c ≠ b := by
    rintro rfl; rw [hh c] at hbc; exact lt_irrefl 0 hbc
  have heq := twin_of_positive_edge h hab c (Ne.symm hac) hcb
  exact ⟨heq, heq ▸ hbc⟩

/-- **REVIEWER 292'S SINGLETON COROLLARY.** A vertex with no positive edge has an identically zero
row: every entry is a cross entry, hence `≤ 0`, and they sum to `0`. *So `Δ = 0` with `ker W = 0`
forces every block to have size `≥ 2`.* -/
theorem isolated_row_zero {w : Matrix ι ι ℝ} {a : ι} (hrow : ∑ c : ι, w a c = 0)
    (hneg : ∀ b, w a b ≤ 0) (b : ι) : w a b = 0 := by
  have hle : ∀ c ∈ (Finset.univ : Finset ι), w a c ≤ 0 := fun c _ => hneg c
  have := (Finset.sum_eq_zero_iff_of_nonpos hle).mp hrow b (Finset.mem_univ b)
  exact this

/-! ## (iii) At a critical point the density is affine in the entry, and caps it -/

/-- **THE DENSITY IS AFFINE IN THE ENTRY**: `g_ab = 2(s_a + s_b) - 4θ M_ab`, both quadratic terms of
(i) cancelling against the criticality equation. -/
theorem gDensity_at_critical {w : Matrix ι ι ℝ} {th : ℝ} (h : IsDiagCritical w th) {a b : ι}
    (hab : a ≠ b) :
    gDensity w a b = 2 * (rowNormSq w a + rowNormSq w b) - 4 * th * w a b := by
  obtain ⟨hs, hh, hc⟩ := h
  rw [gDensity_closed_form hs hh hab]
  linarith [hc a b hab]

/-- **THE ENTRY CAP**: `2θ M_ab ≤ s_a + s_b` at every off-diagonal entry of a diagonal critical
point. *`g_ab ≥ 0` written out, and no sign condition on `θ` enters.* -/
theorem entry_cap {w : Matrix ι ι ℝ} {th : ℝ} (h : IsDiagCritical w th) {a b : ι} (hab : a ≠ b) :
    2 * th * w a b ≤ rowNormSq w a + rowNormSq w b := by
  have h1 := gDensity_at_critical h hab
  have h2 := gDensity_nonneg w a b
  linarith

/-- **The `min` form, per edge**: at a positive edge, `θ ≤ (s_a + s_b)/(2 M_ab)`. *The positivity of
the entry is needed only to divide, which is the record's own gloss.* -/
theorem entry_cap_ratio {w : Matrix ι ι ℝ} {th : ℝ} (h : IsDiagCritical w th) {a b : ι}
    (hpos : 0 < w a b) : th ≤ (rowNormSq w a + rowNormSq w b) / (2 * w a b) := by
  have hab : a ≠ b := by
    rintro rfl; rw [h.2.1 a] at hpos; exact lt_irrefl 0 hpos
  rw [le_div_iff₀ (by linarith)]
  linarith [entry_cap h hab]

/-- **AND EXACTLY**: `θ = (s_a + s_b)/(2M_ab) - g_ab/(4M_ab)` at every positive edge. -/
theorem theta_exact_at_positive_edge {w : Matrix ι ι ℝ} {th : ℝ} (h : IsDiagCritical w th)
    {a b : ι} (hpos : 0 < w a b) :
    th = (rowNormSq w a + rowNormSq w b) / (2 * w a b) - gDensity w a b / (4 * w a b) := by
  have hab : a ≠ b := by
    rintro rfl; rw [h.2.1 a] at hpos; exact lt_irrefl 0 hpos
  have hne : w a b ≠ 0 := ne_of_gt hpos
  have h1 := gDensity_at_critical h hab
  field_simp
  linarith

/-- **Equality in the cap is exactly the off-pair twin condition**, (ii)'s sense, at one edge. -/
theorem cap_equality_iff_twin {w : Matrix ι ι ℝ} {th : ℝ} (h : IsDiagCritical w th) {a b : ι}
    (hab : a ≠ b) :
    2 * th * w a b = rowNormSq w a + rowNormSq w b ↔ ∀ d, d ≠ a → d ≠ b → w a d = w b d := by
  rw [← gDensity_eq_zero_iff w a b]
  have h1 := gDensity_at_critical h hab
  constructor <;> intro h2 <;> linarith

/-- **THE EQUALITY CASE IS NOT EQUALITY OF ROWS**, which the record flags because equality of rows
would miss every positive edge the cap is used on: identical rows force `M_ab = 0`. -/
theorem rows_equal_forces_zero_entry {w : Matrix ι ι ℝ} (hh : ∀ a, w a a = 0) {a b : ι}
    (hrow : ∀ d, w a d = w b d) : w a b = 0 := by
  rw [hrow b]; exact hh b

/-! ## (iv) Traced over `𝔭`, and this part needs `M𝟙 = 0` -/

/-- **`Σ_{ordered, M_ab > 0} M_ab = ‖M‖₁`**, which over unordered pairs is the record's
`‖M‖₁ = 2 Σ_{M_ab>0} M_ab`. *This is the one place `M𝟙 = 0` enters, and it enters through
`x⁺ = (|x| + x)/2`.* -/
theorem positive_mass_eq_l1 {w : Matrix ι ι ℝ} (hrow : ∀ a, ∑ c : ι, w a c = 0) :
    ∑ a : ι, ∑ b : ι, (if 0 < w a b then w a b else 0) = l1 w := by
  have hpart : ∀ x : ℝ, (if 0 < x then x else 0) = (|x| + x) / 2 := by
    intro x
    by_cases hx : 0 < x
    · rw [if_pos hx, abs_of_pos hx]; ring
    · rw [if_neg hx, abs_of_nonpos (le_of_not_gt hx)]; ring
  have htotal : ∑ a : ι, ∑ b : ι, w a b = 0 := by
    rw [Finset.sum_congr rfl fun a _ => hrow a]
    simp
  have key : ∀ a : ι, ∑ b : ι, ((|w a b| + w a b) / 2)
      = (1 / 2) * ((∑ b : ι, |w a b|) + ∑ b : ι, w a b) := by
    intro a
    rw [mul_add, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  calc ∑ a : ι, ∑ b : ι, (if 0 < w a b then w a b else 0)
      = ∑ a : ι, ∑ b : ι, ((|w a b| + w a b) / 2) :=
        Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => hpart _
    _ = ∑ a : ι, (1 / 2) * ((∑ b : ι, |w a b|) + ∑ b : ι, w a b) :=
        Finset.sum_congr rfl fun a _ => key a
    _ = (1 / 2) * ((∑ a : ι, ∑ b : ι, |w a b|) + ∑ a : ι, ∑ b : ι, w a b) := by
        rw [← Finset.mul_sum, Finset.sum_add_distrib]
    _ = l1 w := by rw [htotal, l1]; ring

/-- **`Σ_{ordered, M_ab > 0}(s_a + s_b) = 2 Σ_a d_a⁺ s_a`**, by symmetry of `M`. -/
theorem positive_rowNorm_sum {w : Matrix ι ι ℝ} (hs : ∀ a b, w a b = w b a) :
    ∑ a : ι, ∑ b : ι, (if 0 < w a b then rowNormSq w a + rowNormSq w b else 0)
      = 2 * ∑ a : ι, dplus w a * rowNormSq w a := by
  have hsplit : ∀ a : ι, ∑ b : ι, (if 0 < w a b then rowNormSq w a + rowNormSq w b else 0)
      = (∑ b : ι, (if 0 < w a b then rowNormSq w a else 0))
        + ∑ b : ι, (if 0 < w a b then rowNormSq w b else 0) := by
    intro a
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun b _ => by split_ifs <;> ring
  have hfirst : ∀ a : ι, ∑ b : ι, (if 0 < w a b then rowNormSq w a else 0)
      = dplus w a * rowNormSq w a := by
    intro a
    rw [← Finset.sum_filter, Finset.sum_const, dplus, nsmul_eq_mul]
  have hswap : ∑ a : ι, ∑ b : ι, (if 0 < w a b then rowNormSq w b else 0)
      = ∑ a : ι, dplus w a * rowNormSq w a := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [Finset.sum_congr rfl fun a _ => show (if 0 < w a b then rowNormSq w b else 0)
        = (if 0 < w b a then rowNormSq w b else 0) by rw [hs a b]]
    rw [← Finset.sum_filter, Finset.sum_const, dplus, nsmul_eq_mul]
  rw [Finset.sum_congr rfl fun a _ => hsplit a, Finset.sum_add_distrib,
    Finset.sum_congr rfl fun a _ => hfirst a, hswap]
  ring

/-- **ROUTE R10'S CONVERSION, EXACT**: `θ‖M‖₁ = Σ_a d_a⁺ s_a - ½Δ` at every diagonal critical point
with zero row sums. *No estimate anywhere, and `M𝟙 = 0` is used exactly once, in
`positive_mass_eq_l1`.* -/
theorem defect_identity {w : Matrix ι ι ℝ} {th : ℝ} (h : IsDiagCritical w th)
    (hrow : ∀ a, ∑ c : ι, w a c = 0) :
    th * l1 w = (∑ a : ι, dplus w a * rowNormSq w a) - (1 / 2) * defect w := by
  obtain ⟨hs, hh, hc⟩ := h
  have hcrit : IsDiagCritical w th := ⟨hs, hh, hc⟩
  have hterm : ∀ a b : ι, (if 0 < w a b then gDensity w a b else 0)
      = (if 0 < w a b then rowNormSq w a + rowNormSq w b else 0) * 2
        - 4 * th * (if 0 < w a b then w a b else 0) := by
    intro a b
    by_cases hab : 0 < w a b
    · have hne : a ≠ b := by
        rintro rfl; rw [hh a] at hab; exact lt_irrefl 0 hab
      rw [if_pos hab, if_pos hab, if_pos hab, gDensity_at_critical hcrit hne]
      ring
    · rw [if_neg hab, if_neg hab, if_neg hab]; ring
  have hsum : ∑ a : ι, ∑ b : ι, (if 0 < w a b then gDensity w a b else 0)
      = (∑ a : ι, ∑ b : ι, (if 0 < w a b then rowNormSq w a + rowNormSq w b else 0)) * 2
        - 4 * th * ∑ a : ι, ∑ b : ι, (if 0 < w a b then w a b else 0) := by
    rw [Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => hterm a b]
    rw [Finset.sum_congr rfl fun a _ =>
      show ∑ b : ι, ((if 0 < w a b then rowNormSq w a + rowNormSq w b else 0) * 2
            - 4 * th * (if 0 < w a b then w a b else 0))
          = (∑ b : ι, (if 0 < w a b then rowNormSq w a + rowNormSq w b else 0)) * 2
            - 4 * th * ∑ b : ι, (if 0 < w a b then w a b else 0) by
        rw [Finset.sum_sub_distrib, ← Finset.sum_mul, Finset.mul_sum]]
    rw [Finset.sum_sub_distrib, ← Finset.sum_mul, ← Finset.mul_sum]
  have hA := positive_rowNorm_sum hs
  have hB := positive_mass_eq_l1 hrow
  unfold defect
  rw [hsum, hA, hB]
  ring

/-! ## The bridge to the `Λ²` picture, named rather than assumed silently -/

/-! *Defined in [Base/Families.lean](../Base/Families.lean) and used from there.* **It was defined here AND in [L74Statement.lean](L74Statement.lean), identically and under two namespaces**, which defeats the reason it is a `Prop`: one discharge would have left the other file's consumers gated. -/

/-- **A weight of `𝒟ₙ` satisfying the matrix equation is a critical point of `P`**, from the bridge
and nothing else, so (iii)'s and (iv)'s hypothesis is the record's criticality and not a weaker
surrogate. -/
theorem isCritical_srg_form (hbridge : DiagCriticalityIsCritical (ι := ι)) {w : Matrix ι ι ℝ}
    {th : ℝ} (hw : IsWeight w) (hc : IsDiagCritical w th) : IsCritical (diagOp w) th :=
  hbridge w th hw hc.2.2

/-- **THE SAME, UNCONDITIONALLY, 2026-09-22.** *`DiagCriticalityIsCritical` was the base layer's
owed `sharpOp` step and was discharged on 2026-09-21 by `diagCriticalityIsCritical` in
[SharpDiag.lean](../Base/SharpDiag.lean). This file, and its sibling
[L74Statement.lean](L74Statement.lean), went on binding it.* -/
theorem isCritical_srg_form_uncond {w : Matrix ι ι ℝ} {th : ℝ}
    (hw : IsWeight w) (hc : IsDiagCritical w th) : IsCritical (diagOp w) th :=
  isCritical_srg_form HamiltonsCubic.RealLayer.diagCriticalityIsCritical hw hc

/-- **A `𝒟ₙ` weight satisfying the matrix equation gives a Weyl operator**, so nothing above is a
statement about an inadmissible object. -/
theorem isWeyl_of_isWeight {w : Matrix ι ι ℝ} (hw : IsWeight w) : IsWeyl (diagOp w) :=
  diagOp_isWeyl hw

/-! ## The hypotheses of (iv) are load-bearing, and the record's own witness says so -/

/-- The record's `M = c(J - I)` at `n = 4` and `c = 1`: hollow, symmetric, and critical with
`θ = (n-1)c = 3`, but with row sums `3` rather than `0`. -/
def completeWeight : Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.of fun a b => if (a : ℕ) = (b : ℕ) then 0 else 1

theorem completeWeight_isDiagCritical : IsDiagCritical completeWeight 3 := by
  refine ⟨?_, ?_, ?_⟩
  · intro a b; fin_cases a <;> fin_cases b <;> norm_num [completeWeight]
  · intro a; fin_cases a <;> norm_num [completeWeight]
  · intro a b hab
    fin_cases a <;> fin_cases b <;>
      simp_all [completeWeight, Matrix.mul_apply, Fin.sum_univ_succ] <;> norm_num

/-- Its row sums are `3`, not `0`, the one hypothesis of (iv) it fails. -/
theorem completeWeight_rowSum (a : Fin 4) : ∑ c : Fin 4, completeWeight a c = 3 := by
  fin_cases a <;> norm_num [completeWeight, Fin.sum_univ_succ]

theorem completeWeight_defect : defect completeWeight = 0 := by
  rw [defect_eq_zero_iff]
  intro a b _ d hda hdb
  fin_cases a <;> fin_cases b <;> fin_cases d <;> simp_all [completeWeight]

/-- **WITHOUT `M𝟙 = 0` THE IDENTITY IS FALSE BY A FACTOR OF TWO**, at the record's own witness:
`θ‖M‖₁ = 18` against `Σ_a d_a⁺ s_a - ½Δ = 36`. *So (iv)'s zero-row-sum hypothesis is load-bearing,
and it is exhibited rather than asserted.* -/
theorem completeGraph_not_identity :
    (3 : ℝ) * l1 completeWeight
      ≠ (∑ a : Fin 4, dplus completeWeight a * rowNormSq completeWeight a)
        - (1 / 2) * defect completeWeight := by
  rw [completeWeight_defect]
  have hl1 : l1 completeWeight = 6 := by
    rw [l1]
    norm_num [completeWeight, Fin.sum_univ_succ]
  have hd : ∀ a : Fin 4, dplus completeWeight a = 3 := by
    intro a
    have hfil : (Finset.univ.filter fun b => 0 < completeWeight a b)
        = Finset.univ.erase a := by
      ext b
      rw [Finset.mem_filter, Finset.mem_erase]
      constructor
      · rintro ⟨-, h⟩
        refine ⟨?_, Finset.mem_univ b⟩
        rintro rfl
        simp [completeWeight] at h
      · rintro ⟨hne, -⟩
        refine ⟨Finset.mem_univ b, ?_⟩
        have : ¬ ((a : ℕ) = (b : ℕ)) := fun h => hne (Fin.val_inj.mp h).symm
        simp [completeWeight, this]
    rw [dplus, hfil, Finset.card_erase_of_mem (Finset.mem_univ a)]
    simp
  have hs : ∀ a : Fin 4, rowNormSq completeWeight a = 3 := by
    intro a; fin_cases a <;> norm_num [rowNormSq, completeWeight, Fin.sum_univ_succ]
  rw [hl1]
  simp only [hd, hs]
  norm_num

/-- `S¹ × S¹` at `n = 4`, the balanced two-block weight: symmetric, hollow, **zero row sums**, and
critical with `θ = 3`. *The two blocks are `{0,1}` and `{2,3}`, which the index sum `1` or `5`
picks out.* -/
def balancedWeight : Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.of fun a b =>
    if (a : ℕ) = (b : ℕ) then 0
    else if (a : ℕ) + (b : ℕ) = 1 ∨ (a : ℕ) + (b : ℕ) = 5 then 2 else -1

theorem balancedWeight_isDiagCritical : IsDiagCritical balancedWeight 3 := by
  refine ⟨?_, ?_, ?_⟩
  · intro a b; fin_cases a <;> fin_cases b <;> norm_num [balancedWeight]
  · intro a; fin_cases a <;> norm_num [balancedWeight]
  · intro a b hab
    fin_cases a <;> fin_cases b <;>
      simp_all [balancedWeight, Matrix.mul_apply, Fin.sum_univ_succ] <;> norm_num

theorem balancedWeight_rowSum (a : Fin 4) : ∑ c : Fin 4, balancedWeight a c = 0 := by
  fin_cases a <;> norm_num [balancedWeight, Fin.sum_univ_succ]

/-- **AND AT A POINT MEETING EVERY HYPOTHESIS (iv) IS AN EQUALITY**, so the identity is not
vacuous, and the witness above isolates exactly the missing hypothesis. -/
theorem balanced_witness :
    (3 : ℝ) * l1 balancedWeight
      = (∑ a : Fin 4, dplus balancedWeight a * rowNormSq balancedWeight a)
        - (1 / 2) * defect balancedWeight :=
  defect_identity balancedWeight_isDiagCritical balancedWeight_rowSum

end HamiltonsCubic.L68Statement
