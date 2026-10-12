import Mathlib

set_option linter.style.longLine false

/-!
# L114, the block-mass identity and its `𝔥`-row twin, proved from the row marginal

**The record's statement, quoted verbatim from [bounds-relaxations.md](../../../findings/bounds-relaxations.md):**

> #### Lemma L114, the block-mass identity $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$, and its $\mathfrak h$-row twin
>
> **THE IDENTITY IS A THEOREM, AND WIDER THAN ITS HYPOTHESIS SAYS.** It holds at every $n$, every $d$ and **every** orthogonal two-block split of $\mathfrak{so}(n)$ (no criticality, no Weyl symmetries, no isotropy) so *"the negative eigenspace"* overstates what is needed. The coefficients are slot-occupancy counts, $3\times2$, $2\times2$, $1\times2$, and hollowness of $T$ is load-bearing for them and uncited.
>
> $$6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2),\qquad 6S_{\mathfrak{hhh}}+4S_{\mathfrak{mhh}}+2S_{\mathfrak{mmh}}=2(N-d)(n-2).$$
>
> **THE CONVENTION IS SETTLED: THIS BLOCK COUNTS UNORDERED TRIPLES, AND THE REST OF THE RECORD COUNTS ORDERED SLOTS.** ... **The conversion is per pattern**, $S^{\mathrm{ord}}=6S^{\mathrm{unord}}$ on $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $\times2$ on the mixed ones, *not a global constant.*
>
> **THIS CLOSES THE [L77](isotropy-cap.md) DISPUTE WITH BOTH ITS REVIEWERS CORRECT.** $\gamma=S_{\mathfrak{mhh}}$ ordered, $\gamma=2S_{\mathfrak{mhh}}$ unordered, and the general law is $\gamma=S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$.

## What this file states

Both identities and the `γ` law, proved with no `sorry`, from exactly the inputs the block names:
total symmetry of `T` and the row marginal `∑_{β,γ} T_{αβγ} = 2(n-2)`, which is the record's
Lemma L153. **No criticality, no Weyl symmetries, no isotropy, and no hypothesis on the split**:
`𝔪` is an arbitrary `Finset` of basis indices and `𝔥` is its complement.

The primitives are the **ordered** slot sums, which is the convention both source reviewers
recommend adopting and the only one the record ever defined in writing. The unordered sums are
then the per-pattern quotients, `Sord/6` on `mmm` and `hhh`, `Sord/2` on the mixed patterns,
and with them the record's display appears verbatim as `block_identity_unordered`.

**Hollowness is where those quotients get their meaning**, and it is carried as a field of
`IsBracketTensor` for that reason: it is what makes `Sord/6` and `Sord/2` count each unordered
triple once. The ordered identities themselves never use it.
-/

namespace HamiltonsCubic.L114

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The record's inputs: `T` totally symmetric and hollow, with every row marginal `2(n-2)`
(Lemma L153). -/
structure IsBracketTensor (T : ι → ι → ι → ℝ) (n : ℝ) : Prop where
  swap12 : ∀ a b c, T a b c = T b a c
  swap23 : ∀ a b c, T a b c = T a c b
  hollow : ∀ a b c, a = b ∨ b = c ∨ a = c → T a b c = 0
  marginal : ∀ a, ∑ b, ∑ c, T a b c = 2 * (n - 2)

/-- The ordered slot sum over a typed triple of blocks. -/
noncomputable def Sord (T : ι → ι → ι → ℝ) (X Y Z : Finset ι) : ℝ :=
  ∑ a ∈ X, ∑ b ∈ Y, ∑ c ∈ Z, T a b c

/-! ## The split -/

/-- **One row, split by the block memberships of its two free slots.** -/
theorem row_split (T : ι → ι → ι → ℝ) (m : Finset ι) (a : ι) :
    ∑ b, ∑ c, T a b c
      = ((∑ b ∈ m, ∑ c ∈ m, T a b c) + ∑ b ∈ m, ∑ c ∈ mᶜ, T a b c)
        + ((∑ b ∈ mᶜ, ∑ c ∈ m, T a b c) + ∑ b ∈ mᶜ, ∑ c ∈ mᶜ, T a b c) := by
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib,
    Finset.sum_add_sum_compl m (fun b => (∑ c ∈ m, T a b c) + ∑ c ∈ mᶜ, T a b c)]
  exact Finset.sum_congr rfl fun b _ => (Finset.sum_add_sum_compl m (fun c => T a b c)).symm

/-- **The two mixed patterns coincide**, by symmetry in the second and third slots. -/
theorem Sord_swap23 {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n) (X Y Z : Finset ι) :
    Sord T X Y Z = Sord T X Z Y := by
  simp only [Sord]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun b _ => hT.swap23 a b c

/-- **The first two slots are interchangeable too.** -/
theorem Sord_swap12 {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n) (X Y Z : Finset ι) :
    Sord T X Y Z = Sord T Y X Z := by
  simp only [Sord]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun c _ => hT.swap12 a b c

/-- **Every slot is interchangeable**: the first and third too, which the twin identity needs. -/
theorem Sord_swap13 {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n) (X Y Z : Finset ι) :
    Sord T X Y Z = Sord T Z Y X := by
  rw [Sord_swap12 hT X Y Z, Sord_swap23 hT Y X Z, Sord_swap12 hT Y Z X]

/-! ## The two identities, in ordered slots -/

/-- **The block-mass identity, ordered.** For every block `m`,
`S_mmm + 2S_mmh + S_mhh = 2d(n-2)` with `d = #m`. This is L36's boxed identity with the 3-form
mass `α = S_mmm` put back. -/
theorem block_identity_ord {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n)
    (m : Finset ι) :
    Sord T m m m + 2 * Sord T m m mᶜ + Sord T m mᶜ mᶜ = 2 * (m.card : ℝ) * (n - 2) := by
  have hrow : ∑ a ∈ m, ∑ b, ∑ c, T a b c = (m.card : ℝ) * (2 * (n - 2)) := by
    rw [Finset.sum_congr rfl fun a _ => hT.marginal a, Finset.sum_const, nsmul_eq_mul]
  have hsplit : ∑ a ∈ m, ∑ b, ∑ c, T a b c
      = Sord T m m m + Sord T m m mᶜ + (Sord T m mᶜ m + Sord T m mᶜ mᶜ) := by
    simp only [Sord]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun a _ => row_split T m a
  have hmix : Sord T m mᶜ m = Sord T m m mᶜ := Sord_swap23 hT m mᶜ m
  rw [hmix] at hsplit
  linarith [hrow, hsplit]

/-- **The `𝔥`-row twin, ordered**: `S_hhh + 2S_mhh + S_mmh = 2(N-d)(n-2)`. It is the same
theorem at the complementary block, with the slot symmetries used to name the mixed patterns from
the `𝔪` side. -/
theorem twin_identity_ord {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n)
    (m : Finset ι) :
    Sord T mᶜ mᶜ mᶜ + 2 * Sord T m mᶜ mᶜ + Sord T m m mᶜ
      = 2 * ((mᶜ).card : ℝ) * (n - 2) := by
  have h := block_identity_ord hT mᶜ
  rw [compl_compl] at h
  have h1 : Sord T mᶜ mᶜ m = Sord T m mᶜ mᶜ := Sord_swap13 hT mᶜ mᶜ m
  have h2 : Sord T mᶜ m m = Sord T m m mᶜ := by
    rw [Sord_swap13 hT mᶜ m m]
  rw [h1, h2] at h
  linarith

/-- **Their sum is the `1/3/3/1` identity**, which therefore carries strictly less information
than the pair, it cannot resolve `d`. -/
theorem sum_is_one_three_three_one {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n)
    (m : Finset ι) :
    Sord T m m m + 3 * Sord T m m mᶜ + 3 * Sord T m mᶜ mᶜ + Sord T mᶜ mᶜ mᶜ
      = 2 * ((m.card : ℝ) + ((mᶜ).card : ℝ)) * (n - 2) := by
  have h1 := block_identity_ord hT m
  have h2 := twin_identity_ord hT m
  linarith

/-! ## The record's display, in unordered triples -/

/-- The unordered counts, as the per-pattern quotients the block's conversion law names:
`S^ord = 6S^unord` on `mmm` and `hhh`, `×2` on the mixed patterns. -/
noncomputable def Su_mmm (T : ι → ι → ι → ℝ) (m : Finset ι) : ℝ := Sord T m m m / 6
noncomputable def Su_mmh (T : ι → ι → ι → ℝ) (m : Finset ι) : ℝ := Sord T m m mᶜ / 2
noncomputable def Su_mhh (T : ι → ι → ι → ℝ) (m : Finset ι) : ℝ := Sord T m mᶜ mᶜ / 2
noncomputable def Su_hhh (T : ι → ι → ι → ℝ) (m : Finset ι) : ℝ := Sord T mᶜ mᶜ mᶜ / 6

/-- **The record's display**: `6S_mmm + 4S_mmh + 2S_mhh = 2d(n-2)`. -/
theorem block_identity_unordered {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n)
    (m : Finset ι) :
    6 * Su_mmm T m + 4 * Su_mmh T m + 2 * Su_mhh T m = 2 * (m.card : ℝ) * (n - 2) := by
  have h := block_identity_ord hT m
  simp only [Su_mmm, Su_mmh, Su_mhh]
  linarith

/-- **And its twin**: `6S_hhh + 4S_mhh + 2S_mmh = 2(N-d)(n-2)`. -/
theorem twin_identity_unordered {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n)
    (m : Finset ι) :
    6 * Su_hhh T m + 4 * Su_mhh T m + 2 * Su_mmh T m = 2 * ((mᶜ).card : ℝ) * (n - 2) := by
  have h := twin_identity_ord hT m
  simp only [Su_hhh, Su_mhh, Su_mmh]
  linarith

/-! ## The `γ` law, which closes the L77 dispute -/

/-- The `𝔪`-bracket mass `μ = ∑_{a,b ∈ 𝔪} ‖[e_a,e_b]‖²`, which in slot sums is
`S^ord_mmm + S^ord_mmh`. -/
noncomputable def mu (T : ι → ι → ι → ℝ) (m : Finset ι) : ℝ := Sord T m m m + Sord T m m mᶜ

/-- **`γ = S^ord_mhh - S^ord_mmm`**, the general law. With `γ` defined by L36's
`2μ + γ = 2(n-2)d`, the two readings the record's reviewers each defended are the two special
cases: `γ = S_mhh` when the 3-form mass vanishes, and the difference otherwise. -/
theorem gamma_law {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n) (m : Finset ι)
    {γ : ℝ} (hγ : 2 * mu T m + γ = 2 * (n - 2) * (m.card : ℝ)) :
    γ = Sord T m mᶜ mᶜ - Sord T m m m := by
  have h := block_identity_ord hT m
  simp only [mu] at hγ
  linarith

/-- **Under isotropy the 3-form mass vanishes and `γ = S^ord_mhh`**, one reviewer's reading. -/
theorem gamma_of_isotropic {T : ι → ι → ι → ℝ} {n : ℝ} (hT : IsBracketTensor T n)
    (m : Finset ι) {γ : ℝ} (hγ : 2 * mu T m + γ = 2 * (n - 2) * (m.card : ℝ))
    (hiso : Sord T m m m = 0) :
    γ = Sord T m mᶜ mᶜ := by
  rw [gamma_law hT m hγ, hiso, sub_zero]

/-! ## The hypotheses are not empty -/

/-- **A witness for `IsBracketTensor`**: the zero tensor at `n = 2`, whose row marginals are
`2(2-2) = 0`. So the identities are not vacuous. -/
example : IsBracketTensor (fun _ _ _ : Fin 3 => (0 : ℝ)) 2 :=
  ⟨fun _ _ _ => rfl, fun _ _ _ => rfl, fun _ _ _ _ => rfl, fun _ => by simp⟩
