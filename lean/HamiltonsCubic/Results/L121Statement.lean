import Mathlib

set_option linter.style.longLine false

/-!
# L121, the four-set block, its spectrum, and one necessary condition per four-subset

## The record's statement, verbatim

> #### Lemma L121, the $4$-set block, its spectrum, and one necessary condition per $4$-subset
>
> **Fix a **pair-diagonal** $M$ and a $4$-subset $\{i,j,k,l\}$, the block and its spectrum need
> diagonality alone, with no criticality and no row sum entering, which is what makes them
> applicable to $\operatorname{diag}(M)$ in a frame where $W$ is not diagonal. **The necessary
> condition below is the part that needs a maximiser**, through Lemma L24. Let $A=M_{ij}+M_{kl}$,
> $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ be the three opposite-pair sums. Then in signed coordinates
> $L_M$ restricted to the $4$-set space is $\tfrac12G$ with
> $G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$; **the Bianchi subspace is $\mathbf 1^\perp$**
> because $\hat a+\hat b+\hat c=0$ in these signed coordinates, and $G\mathbf 1=(A+B+C)\mathbf 1$
> then makes that subspace **invariant**, two joints, not one. **The restriction to
> $\mathbf 1^\perp$ is traceless**; $\tfrac12G$ itself is not, its trace being
> $\tfrac12(A+B+C)$. Spectrum**
> $$\pm\tfrac12\sqrt{A^2+B^2+C^2-AB-BC-CA}\;=\;\pm\tfrac12\sqrt{\tfrac12\big[(A-B)^2+(B-C)^2+(C-A)^2\big]}.$$
>
> **The list is complete, not short a root.** $G$'s third eigenvalue is $A+B+C$ on the vector
> $\mathbf 1$, and first Bianchi is exactly $\mathbf 1^\perp$ in these signed coordinates, so that
> root is removed rather than missing.
>
> **Consequently Lemma L24 gives, at every maximiser **that is coordinate-diagonal in the frame**
> and every $4$-subset, $A^2+B^2+C^2-AB-BC-CA\le\theta^2$.**

[second-order.md](../../../findings/second-order.md), Lemma L121.

## What this file states

Everything about the matrix `G` is stated and PROVED: symmetry, `G𝟙 = (A+B+C)𝟙`, invariance of
`𝟙^⊥`, tracelessness of the restriction, the identity
`Σ = ½[(A-B)² + (B-C)² + (C-A)²]`, and (the spectrum clause) that `G² = Σ` on `𝟙^⊥` together
with an explicit eigenvector at `+√Σ`, which is what the necessary condition consumes.

**The necessary condition `Σ ≤ θ²` is proved from Lemma L24 taken as an explicit hypothesis**
(`hcap`). That is legitimate here because L24 is **classical and external**, Proposition 6.6 of
Krasnov–Tkachev, *Variety of idempotents in nonassociative algebras*, and Proposition 2.5 of
Tkachev's survey, as [second-order.md](../../../findings/second-order.md) records, and because
the maximiser hypothesis of the record is spent on nothing else. `hcap` is written for `½G` on the
Bianchi subspace `𝟙^⊥`, with the cap `θ/2`, which is L24's cap read in `L_M` units rather than
`L_e` units.

**The record's frame hypothesis is not decoration and is not dropped**: `hcap` is asserted for the
one block, so nothing here says the inequality holds in every frame, the reading two reviewers
refuted.

## What is NOT typed here

**That `½G` *is* the four-set block of `L_M`** is proved in [L121Block.lean](L121Block.lean)
(`fourSet_G`, `fourSet_span`), with the `diag(1,-1,1)` sign flip, and first Bianchi cuts out
exactly `𝟏^⊥` at every index tuple in [L121Bianchi.lean](L121Bianchi.lean) (`fourSet_bianchi_iff`). Here `A`, `B`, `C` stay three real numbers
named after the opposite-pair sums. Absent from both files: the sphere-product evaluations
`μ_{p,q} = (n-2)/(2(p-1)(q-1))` which the record shares with Lemma L26.
-/

namespace HamiltonsCubic.L121Statement

open Matrix

/-- **`G`**, the Latin square with diagonal `(A,B,C)` whose off-diagonal `(m,m')` entry is the
third letter. -/
def Gmat (A B C : ℝ) : Matrix (Fin 3) (Fin 3) ℝ := !![A, C, B; C, B, A; B, A, C]

/-- **`Σ = A² + B² + C² - AB - BC - CA`**, the record's discriminant. -/
def Sig (A B C : ℝ) : ℝ := A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A

/-- The Bianchi subspace, `𝟙^⊥` in the signed coordinates. -/
def Bianchi (x : Fin 3 → ℝ) : Prop := x 0 + x 1 + x 2 = 0

/-! ## The matrix, its symmetry, and the two joints -/

/-- Componentwise equality of vectors in `Fin 3 → ℝ`. -/
theorem funext3 {f g : Fin 3 → ℝ} (h0 : f 0 = g 0) (h1 : f 1 = g 1) (h2 : f 2 = g 2) : f = g := by
  funext i; fin_cases i <;> assumption

/-- **`G` is symmetric.** -/
theorem Gmat_symm (A B C : ℝ) : (Gmat A B C)ᵀ = Gmat A B C := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Gmat]

theorem mulVec_apply (A B C : ℝ) (x : Fin 3 → ℝ) :
    (Gmat A B C *ᵥ x) 0 = A * x 0 + C * x 1 + B * x 2 ∧
    (Gmat A B C *ᵥ x) 1 = C * x 0 + B * x 1 + A * x 2 ∧
    (Gmat A B C *ᵥ x) 2 = B * x 0 + A * x 1 + C * x 2 := by
  refine ⟨?_, ?_, ?_⟩
  · show ∑ j, Gmat A B C 0 j * x j = _
    rw [Fin.sum_univ_three]; simp [Gmat]
  · show ∑ j, Gmat A B C 1 j * x j = _
    rw [Fin.sum_univ_three]; simp [Gmat]
  · show ∑ j, Gmat A B C 2 j * x j = _
    rw [Fin.sum_univ_three]; simp [Gmat]

/-- **`G𝟙 = (A+B+C)𝟙`**, the first joint. -/
theorem Gmat_mulVec_one (A B C : ℝ) :
    Gmat A B C *ᵥ (fun _ => 1) = fun _ => A + B + C := by
  obtain ⟨h0, h1, h2⟩ := mulVec_apply A B C (fun _ => (1 : ℝ))
  refine funext3 ?_ ?_ ?_
  · rw [h0]; ring
  · rw [h1]; ring
  · rw [h2]; ring

/-- **`𝟙^⊥` is `G`-invariant**, the second joint. It is the column sums, all `A+B+C`, that give
it. -/
theorem Gmat_preserves_bianchi (A B C : ℝ) (x : Fin 3 → ℝ) (hx : Bianchi x) :
    Bianchi (Gmat A B C *ᵥ x) := by
  obtain ⟨h0, h1, h2⟩ := mulVec_apply A B C x
  unfold Bianchi at hx ⊢
  rw [h0, h1, h2]
  linear_combination (A + B + C) * hx

/-- **`tr(½G) = ½(A+B+C)`**, `½G` itself is not traceless. -/
theorem trace_half_G (A B C : ℝ) :
    ((1 / 2 : ℝ) • Gmat A B C).trace = (1 / 2) * (A + B + C) := by
  simp [Gmat, Matrix.trace, Fin.sum_univ_three]
  ring

/-- **The restriction to `𝟙^⊥` is traceless**: `tr G` minus the `𝟙`-eigenvalue is `0`. -/
theorem trace_on_bianchi (A B C : ℝ) : (Gmat A B C).trace - (A + B + C) = 0 := by
  simp [Gmat, Matrix.trace, Fin.sum_univ_three]

/-! ## The spectrum on the Bianchi subspace -/

/-- **The record's two forms of `Σ` agree.** -/
theorem Sig_eq_half_sum_sq (A B C : ℝ) :
    Sig A B C = (1 / 2) * ((A - B) ^ 2 + (B - C) ^ 2 + (C - A) ^ 2) := by
  unfold Sig; ring

/-- **`Σ ≥ 0`**, so `√Σ` is real and the spectrum clause makes sense. -/
theorem Sig_nonneg (A B C : ℝ) : 0 ≤ Sig A B C := by
  rw [Sig_eq_half_sum_sq]; positivity

/-- **`G² = Σ·Id` on the Bianchi subspace.** The whole of `G²` is `Σ·Id + (AB+BC+CA)·J`, and `J`
kills `𝟙^⊥`, which is why the two roots on that subspace are `±√Σ`. -/
theorem Gmat_sq_on_bianchi (A B C : ℝ) (x : Fin 3 → ℝ) (hx : Bianchi x) :
    Gmat A B C *ᵥ (Gmat A B C *ᵥ x) = Sig A B C • x := by
  obtain ⟨h0, h1, h2⟩ := mulVec_apply A B C x
  obtain ⟨g0, g1, g2⟩ := mulVec_apply A B C (Gmat A B C *ᵥ x)
  unfold Bianchi at hx
  refine funext3 ?_ ?_ ?_
  · rw [g0, h0, h1, h2]
    simp only [Pi.smul_apply, smul_eq_mul, Sig]
    linear_combination (A * B + B * C + C * A) * hx
  · rw [g1, h0, h1, h2]
    simp only [Pi.smul_apply, smul_eq_mul, Sig]
    linear_combination (A * B + B * C + C * A) * hx
  · rw [g2, h0, h1, h2]
    simp only [Pi.smul_apply, smul_eq_mul, Sig]
    linear_combination (A * B + B * C + C * A) * hx

/-- **An explicit `+√Σ` eigenvector on `𝟙^⊥`**: `v = √Σ·u + Gu` for `u ∈ 𝟙^⊥`. -/
theorem eigen_of_bianchi (A B C : ℝ) (u : Fin 3 → ℝ) (hu : Bianchi u) :
    Bianchi (Real.sqrt (Sig A B C) • u + Gmat A B C *ᵥ u) ∧
    Gmat A B C *ᵥ (Real.sqrt (Sig A B C) • u + Gmat A B C *ᵥ u)
      = Real.sqrt (Sig A B C) • (Real.sqrt (Sig A B C) • u + Gmat A B C *ᵥ u) := by
  set μ := Real.sqrt (Sig A B C) with hμdef
  have hsq : Sig A B C = μ ^ 2 := (Real.sq_sqrt (Sig_nonneg A B C)).symm
  have hGu := Gmat_preserves_bianchi A B C u hu
  constructor
  · unfold Bianchi at hu hGu ⊢
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    linear_combination μ * hu + hGu
  · rw [Matrix.mulVec_add, Matrix.mulVec_smul, Gmat_sq_on_bianchi A B C u hu]
    refine funext3 ?_ ?_ ?_ <;>
      · simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
        rw [hsq]; ring

/-! ## The necessary condition, one per four-subset -/

/-- The Rayleigh numerator `⟨x, Gx⟩`. -/
def quadG (A B C : ℝ) (x : Fin 3 → ℝ) : ℝ := ∑ i, x i * ((Gmat A B C *ᵥ x) i)

/-- `‖x‖²`. -/
def nrm2 (x : Fin 3 → ℝ) : ℝ := ∑ i, x i * x i

theorem nrm2_pos {x : Fin 3 → ℝ} (hx : x ≠ 0) : 0 < nrm2 x := by
  unfold nrm2
  rcases Function.ne_iff.1 hx with ⟨i, hi⟩
  refine Finset.sum_pos' (fun j _ => mul_self_nonneg _) ⟨i, Finset.mem_univ i, ?_⟩
  have : x i ≠ 0 := by simpa using hi
  exact mul_self_pos.2 this

/-- **L121's consequence.** With Lemma L24's cap on this block, `⟨x, ½Gx⟩ ≤ (θ/2)‖x‖²` for `x`
in the Bianchi subspace, which is `σ(L_e|_{W^⊥}) ⊆ (-∞,½]` read in `L_M` units, the discriminant
is capped by `θ²`.

*The cap is Krasnov–Tkachev Proposition 6.6, the classical input the record's maximiser hypothesis
supplies; it is asserted for this one block, so nothing here reads the bound off a general
frame.* -/
theorem four_set_necessary (A B C θ : ℝ) (hθ : 0 ≤ θ)
    (hcap : ∀ x : Fin 3 → ℝ, Bianchi x →
      (1 / 2 : ℝ) * quadG A B C x ≤ (θ / 2) * nrm2 x) :
    Sig A B C ≤ θ ^ 2 := by
  set μ := Real.sqrt (Sig A B C) with hμdef
  have hμ0 : 0 ≤ μ := Real.sqrt_nonneg _
  have hsq : μ ^ 2 = Sig A B C := Real.sq_sqrt (Sig_nonneg A B C)
  suffices h : μ ≤ θ by nlinarith [hsq, hμ0, hθ]
  have key : ∀ u : Fin 3 → ℝ, Bianchi u → (μ • u + Gmat A B C *ᵥ u) ≠ 0 → μ ≤ θ := by
    intro u hu hv
    obtain ⟨hvB, hvE⟩ := eigen_of_bianchi A B C u hu
    set v := μ • u + Gmat A B C *ᵥ u with hvdef
    have hcomp : ∀ i, (Gmat A B C *ᵥ v) i = μ * v i := by
      intro i
      rw [hvE]
      simp only [Pi.smul_apply, smul_eq_mul, ← hμdef]
    have hq : quadG A B C v = μ * nrm2 v := by
      unfold quadG nrm2
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun i _ => ?_
      rw [hcomp i]; ring
    have hpos : 0 < nrm2 v := nrm2_pos hv
    have hcapv := hcap v hvB
    rw [hq] at hcapv
    nlinarith [hpos, hcapv]
  by_cases hABC : A = B ∧ B = C
  · obtain ⟨h1, h2⟩ := hABC
    have hz : Sig A B C = 0 := by unfold Sig; subst h1; subst h2; ring
    rw [hμdef, hz, Real.sqrt_zero]
    exact hθ
  · by_cases hAB : A = B
    · have hBC : B ≠ C := fun h => hABC ⟨hAB, h⟩
      refine key ![0, 1, -1] (by simp [Bianchi]) ?_
      intro hv
      obtain ⟨h0, _, _⟩ := mulVec_apply A B C ![0, 1, -1]
      have hc := congrFun hv 0
      simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, Pi.zero_apply] at hc
      rw [h0] at hc
      simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
        Matrix.cons_val_two, Matrix.tail_cons] at hc
      exact hBC (by linarith)
    · refine key ![1, -1, 0] (by simp [Bianchi]) ?_
      intro hv
      obtain ⟨_, _, h2⟩ := mulVec_apply A B C ![1, -1, 0]
      have hc := congrFun hv 2
      simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, Pi.zero_apply] at hc
      rw [h2] at hc
      simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
        Matrix.cons_val_two, Matrix.tail_cons] at hc
      exact hAB (by linarith)

/-! ## A witness, so the hypotheses are not empty

*`A = B = C = 0` and `θ = 0`: the cap holds and the conclusion is `0 ≤ 0`.* -/

example : ∀ x : Fin 3 → ℝ, Bianchi x →
    (1 / 2 : ℝ) * quadG 0 0 0 x ≤ ((0 : ℝ) / 2) * nrm2 x := by
  intro x _
  have hz : ∀ i, (Gmat 0 0 0 *ᵥ x) i = 0 := by
    intro i
    obtain ⟨h0, h1, h2⟩ := mulVec_apply 0 0 0 x
    fin_cases i
    · rw [show ((⟨0, by norm_num⟩ : Fin 3)) = 0 from rfl, h0]; ring
    · rw [show ((⟨1, by norm_num⟩ : Fin 3)) = 1 from rfl, h1]; ring
    · rw [show ((⟨2, by norm_num⟩ : Fin 3)) = 2 from rfl, h2]; ring
  have : quadG 0 0 0 x = 0 := by
    unfold quadG
    refine Finset.sum_eq_zero fun i _ => ?_
    rw [hz i]; ring
  rw [this]; norm_num

end HamiltonsCubic.L121Statement
