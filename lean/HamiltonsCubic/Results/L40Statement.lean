import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.CP2Real

/-!
# L40, the surviving target, measured, STATED

From [target.md](../../../findings/target.md), the block headed *"Observation L40, the surviving
target, measured"*, quoted verbatim:

> Over the **catalogued** critical points $\mathcal C$, membership decided by
> [Lemma L37](../../../findings/target.md) rather than by frame inspection,
> $$\sup\{\theta:W\in\mathcal C,\ Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\sqrt{3/2},$$
> **attained at $W_{\mathbb{CP}^2}$ and at every padding of it**. Diagonal controls are correctly
> excluded, $S^5\times S^7$ at $1.228239$ among them, the strongest available control, since it
> sits *above* $\sqrt{3/2}$ and is the point whose misclassification would break the measurement.

with the two clauses the block attaches, both of which this file types:

> **THIS BOUNDS THE RESIDUAL FROM BELOW, AND THE RESIDUAL NEEDS THE OTHER DIRECTION.** A supremum
> over a catalogue gives $\sup_{\mathcal N}\theta\ge\sqrt{3/2}$ over the full non-diagonal set
> $\mathcal N$, while the statement that would close the conjecture is
> $\sup_{\mathcal N}\theta\le\sqrt{3/2}$. **L40 reaches that direction not at all.**

> **The attainment is a theorem, not this measurement.** $\theta^2=3/2$ holds exactly at
> $W_{\mathbb{CP}^2}$ by the closed form.

## What is typed here, and how the catalogue is handled

**L40 is a measurement over a catalogue, and the catalogue is data this Lean layer does not carry.**
So the observation is typed as `L40Claim C`, a predicate on a set `C` of operators, saying that
`√(3/2)` is the greatest `θ` over the members of `C` that are critical, have `S = 0`, and are
non-diagonal. *The record's own instance, `C` = the symmetric-space sweep, cannot be written down
here, and no theorem below asserts `L40Claim` of any particular `C`.*

**Proved here, with no `sorry`:**

* **the direction clause**, from `L40Claim C` and `C ⊆ 𝒩`, every upper bound for `θ` over `𝒩` is
  at least `√(3/2)`, and nothing in the other direction follows: this is the record's *"bounds the
  residual from below"*, stated positively;
* **the control**, `√(3/2) < 1.228239`, so `S⁵×S⁷` does sit above the measured supremum and its
  misclassification would indeed break the measurement;
* `√(3/2)² = 3/2`, the closed form the attainment is a theorem by.

**Proved: `L40_attained`**, the half of the observation that is a claim about `𝒲ₙ` rather than
about a catalogue, that some critical, `S = 0`, non-diagonal `W` has `θ = √(3/2)`, at every
`n ≥ 4`. *The witness is `W_{ℂP²}` padded by zero, built in [CP2Real.lean](CP2Real.lean).* **The frame's index is existential**: it was the caller's `κ` until 2026-09-24, which made
the statement false at every `κ` of the wrong size, `no_empty_frame` proving it at `κ = Empty`.

## What is NOT typed here

**The measurement itself.** No statement below asserts that any particular catalogue's supremum is
`√(3/2)`; that is the observation's content and it is data. **And the observation's own scope
caveat is part of the record's statement**: *"This is a measurement over a catalogue and proves
nothing about points outside it."*

*`θ` is [WeylReal.lean](../Base/WeylReal.lean)'s, whose own docstring records that its `sharpPair`
term is even in `R` and so is `tr(R#)` rather than `⟨R#,R⟩`; `Q(W) = θW` below is written through
`sharpBil`, the polarisation, which that defect does not touch.*
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L40Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-! ## The three predicates the set-builder uses -/

/-- **`Q(W) = t·W`**, written on bivectors: `⟨W²X, Y⟩ + ⟨W#X, Y⟩ = t⟨WX, Y⟩`. *The sharp enters
through `sharpBil`, the polarisation of `sharpQF`.* -/
def IsCritical (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (t : ℝ) : Prop :=
  ∀ X Y : Matrix ι ι ℝ, IsSkew X → IsSkew Y →
    inner2 (compOp W X) Y + sharpBil W X Y = t * inner2 (W X) Y

/-- **An orthonormal eigenframe for `W` on `Λ²`.** -/
structure Eigenframe (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) :
    Prop where
  skew : ∀ a, IsSkew (v a)
  orthonormal : ∀ a b, inner2 (v a) (v b) = if a = b then 1 else 0
  eigen : ∀ a, W (v a) = lam a • v a
  complete : ∀ X : Matrix ι ι ℝ, IsSkew X → X ∈ Submodule.span ℝ (Set.range v)

/-- **`S(W)`, the structure mass carried by the negative eigenspace**, the sum of
`⟨[v_α,v_β],v_γ⟩²` over triples of negative eigenvectors. -/
noncomputable def Sneg (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) : ℝ :=
  ∑ a ∈ Finset.univ.filter fun a => lam a < 0,
    ∑ b ∈ Finset.univ.filter fun b => lam b < 0,
      ∑ c ∈ Finset.univ.filter fun c => lam c < 0, inner2 (br (v a) (v b)) (v c) ^ 2

/-- The `i`-th column of a frame. -/
def frameCol (g : Matrix ι ι ℝ) (i : ι) : ι → ℝ := fun p => g p i

/-- `u ∧ w`, normalised so that `e_i ∧ e_j = φ_{ij}`. -/
noncomputable def wedgeVec (u w : ι → ℝ) : Matrix ι ι ℝ :=
  Matrix.vecMulVec w u - Matrix.vecMulVec u w

/-- **`W` is diagonal in some orthonormal frame**, every coordinate `2`-plane of that frame an
eigenvector. *The record decides this by [L37](../../../findings/target.md)'s kernel criterion
rather than by frame inspection; the notion being decided is this one.* -/
def IsDiagonal (W : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∃ g : Matrix ι ι ℝ, gᵀ * g = 1 ∧
    ∀ i j : ι, ∃ c : ℝ, W (wedgeVec (frameCol g i) (frameCol g j))
      = c • wedgeVec (frameCol g i) (frameCol g j)

/-! ## The observation, as a claim about a catalogue -/

/-- **The `θ`-values of the surviving members of a catalogue `C`**: critical, with `S = 0`, and
non-diagonal. -/
def surviving (C : Set (Matrix ι ι ℝ → Matrix ι ι ℝ)) : Set ℝ :=
  {t | ∃ W ∈ C, ∃ v : κ → Matrix ι ι ℝ, ∃ lam : κ → ℝ,
      IsWeyl W ∧ Eigenframe W v lam ∧ IsCritical W t ∧ Sneg v lam = 0 ∧ ¬ IsDiagonal W ∧
        theta W = t}

/-- **L40, as a claim about a given catalogue.** `√(3/2)` is the greatest `θ` over the catalogue's
critical, `S = 0`, non-diagonal members.

*No theorem in this file asserts this of any particular `C`: the catalogue is the observation's data
and it is not in this Lean layer.* -/
def L40Claim (C : Set (Matrix ι ι ℝ → Matrix ι ι ℝ)) : Prop :=
  IsGreatest (surviving (κ := κ) C) (Real.sqrt (3 / 2))

/-! ## The direction clause, proved -/

/-- **A supremum over a catalogue bounds the residual from below and nothing more.** If the
observation holds of `C` and `C`'s surviving values sit inside the full non-diagonal set's values
`N`, then every upper bound for `N` is at least `√(3/2)`.

*This is the whole of what L40 gives towards the conjecture; the direction that would close it,
`sup N ≤ √(3/2)`, does not follow, the hypothesis is a statement about `C` alone.* -/
theorem L40_bounds_below {C : Set (Matrix ι ι ℝ → Matrix ι ι ℝ)} {N : Set ℝ}
    (hC : L40Claim (κ := κ) C) (hsub : surviving (κ := κ) C ⊆ N) {b : ℝ} (hb : b ∈ upperBounds N) :
    Real.sqrt (3 / 2) ≤ b :=
  hb (hsub hC.1)

/-- **And `√(3/2)` is a member of the smaller set, so the lower bound is attained there.** -/
theorem L40_mem {C : Set (Matrix ι ι ℝ → Matrix ι ι ℝ)} (hC : L40Claim (κ := κ) C) :
    Real.sqrt (3 / 2) ∈ surviving (κ := κ) C := hC.1

/-! ## The control -/

/-- **`√(3/2) < 1.228239`.** The diagonal control `S⁵×S⁷` sits *above* the measured supremum, which
is why it is the point whose misclassification would break the measurement. -/
theorem control_above : Real.sqrt (3 / 2) < 1.228239 := by
  have h : Real.sqrt (3 / 2) < Real.sqrt (1.228239 ^ 2) := by
    apply Real.sqrt_lt_sqrt (by norm_num)
    norm_num
  rwa [Real.sqrt_sq (by norm_num)] at h

/-- **`√(3/2)² = 3/2`**, the closed form by which the attainment at `W_{ℂP²}` is a theorem rather
than a measurement. -/
theorem sqrt_three_halves_sq : Real.sqrt (3 / 2) ^ 2 = 3 / 2 :=
  Real.sq_sqrt (by norm_num)

/-! ## The half of the observation that is a claim about `𝒲ₙ` -/

/-- **No eigenframe is indexed by an empty type**, since the frame must span `φ₀₁ ≠ 0`. *This is why
the frame's index in `L40_attained` is existential: an eigenframe of `Λ²ℝⁿ` has exactly `n(n-1)/2`
members, so a statement quantifying the index type universally is false at every other size.* -/
theorem no_empty_frame (W : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin 4) (Fin 4) ℝ)
    (v : Empty → Matrix (Fin 4) (Fin 4) ℝ) (lam : Empty → ℝ) : ¬ Eigenframe W v lam := by
  intro h
  have hc := h.complete (phi 0 1) (phi_isSkew 0 1)
  rw [Set.range_eq_empty, Submodule.span_empty, Submodule.mem_bot] at hc
  have := congrFun (congrFun hc 1) 0
  simp [phi, Matrix.single_apply] at this

/-- **The attainment.** Some critical, `S = 0`, non-diagonal `W ∈ 𝒲ₙ` has `θ = √(3/2)`. *The frame
is indexed by `Fin m` for some `m`; `no_empty_frame` is why the index cannot be the caller's.*

**Proved.** *The witness is [CP2Real.lean](CP2Real.lean)'s `Wc n`, `W_{ℂP²}` padded by zero off
the first four coordinates, with its frame reindexed from `Fin 3 ⊕ Fin r` to `Fin (3 + r)`. `S = 0`
because the two negative eigenvectors are `ω₁, ω₂` and a structure constant with its three indices
in a two-element set vanishes.* -/
theorem L40_attained (n : ℕ) (hn : 4 ≤ n) :
    ∃ (m : ℕ) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
      (v : Fin m → Matrix (Fin n) (Fin n) ℝ) (lam : Fin m → ℝ),
      IsWeyl W ∧ Eigenframe W v lam ∧ IsCritical W (Real.sqrt (3 / 2)) ∧ Sneg v lam = 0 ∧
        ¬ IsDiagonal W ∧ theta W = Real.sqrt (3 / 2) := by
  open HamiltonsCubic.CP2Real in
  obtain ⟨r, g, hgf, hf⟩ := Wc_frame hn
  let e : Fin 3 ⊕ Fin r ≃ Fin (3 + r) := finSumFinEquiv
  let V : Fin 3 ⊕ Fin r → Matrix (Fin n) (Fin n) ℝ := Sum.elim om g
  let L : Fin 3 ⊕ Fin r → ℝ := Sum.elim mu (fun _ => 0)
  refine ⟨3 + r, Wc n, fun t => V (e.symm t), fun t => L (e.symm t), Wc_weyl hn, ⟨?_, ?_, ?_, ?_⟩,
    fun X Y hX hY => Wc_crit hn X Y hX hY, ?_, ?_, Wc_theta hn⟩
  · exact fun t => hf.skew _
  · intro a b
    rw [hf.orthonormal]
    by_cases h : a = b
    · simp [h]
    · rw [if_neg (fun h' => h (e.symm.injective h')), if_neg h]
  · exact fun t => hf.eigen _
  · intro X hX
    rw [hf.complete X hX]
    refine Submodule.sum_mem _ fun s _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨e s, ?_⟩)
    simp only [Equiv.symm_apply_apply]
    rfl
  · -- the negative eigenvectors are `ω₁, ω₂`, and `ε` vanishes on `{1, 2}`
    have hneg : ∀ t, L (e.symm t) < 0 → ∃ i : Fin 3, i ≠ 0 ∧ e.symm t = Sum.inl i := by
      intro t ht
      cases h : e.symm t with
      | inl i =>
        refine ⟨i, fun h0 => ?_, rfl⟩
        rw [h, h0] at ht
        simp only [L, Sum.elim_inl, mu_vals.1] at ht
        have := s6_pos
        have : 0 < 2 / s6 := by positivity
        linarith
      | inr c => rw [h] at ht; simp [L] at ht
    unfold Sneg
    refine Finset.sum_eq_zero fun a ha => Finset.sum_eq_zero fun b hb => Finset.sum_eq_zero fun c hc => ?_
    obtain ⟨i, hi, hia⟩ := hneg a (Finset.mem_filter.mp ha).2
    obtain ⟨j, hj, hjb⟩ := hneg b (Finset.mem_filter.mp hb).2
    obtain ⟨k, hk, hkc⟩ := hneg c (Finset.mem_filter.mp hc).2
    simp only [V, hia, hjb, hkc, Sum.elim_inl]
    rw [cst_om hn, eps_neg i j k hi hj hk]
    simp
  · rintro ⟨g', hg', hd⟩
    exact Wc_not_diag hn g' hg' hd

end HamiltonsCubic.L40Statement
