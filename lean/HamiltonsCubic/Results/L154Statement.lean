import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L154, the three steps of the proof that are not about curvature

## The record's statement, verbatim

> **LEMMA L154.** *Let $W\ne0$ be a critical point, $Q(W)=\theta W$, and
> $X_{\mathrm{inv}}=\lvert W\rvert^\#-P_+W^\#P_++P_-W^\#P_-$. **(i)** $\operatorname{tr}X_{\mathrm{inv}}=0$
> if and only if $X_{\mathrm{inv}}=0$. **(ii)** If $h=\mathrm{Ric}(\lvert W\rvert)=\lambda\,\mathrm{id}$
>, as it is whenever the isotropy group of $W$ acts irreducibly on $\mathbb R^n$ over $\mathbb R$,
> then $\lambda=2\operatorname{tr}\lvert W\rvert/n>0$, $H=\mathrm{Ric}^*(h)=2\lambda\,\mathrm{Id}$,
> $J_5=\lambda\operatorname{scal}(X_{\mathrm{inv}})\ge0$, and $J_5=0$ if and only if
> $X_{\mathrm{inv}}=0$.*

> **Proof.** (i) The three spectral-diagonal blocks […] each PSD because $\#$ preserves the PSD
> cone; so $\operatorname{tr}X_{\mathrm{inv}}$ is a sum of three nonnegative traces and vanishes only
> if every block does. **A PSD operator with a vanishing diagonal block vanishes on that block's
> whole row** […] (ii) $h$ is symmetric and built equivariantly from $W$, so under an irreducible
> isotropy action over $\mathbb R$ each eigenspace of $h$ is an invariant subspace and $h$ is scalar;
> $\lambda=\operatorname{tr}h/n=2\operatorname{tr}\lvert W\rvert/n>0$ for $W\ne0$. $H=\mathrm{Ric}^*(h)$
> is diagonal in $h$'s eigenframe with eigenvalues $\eta_i+\eta_j$, here $2\lambda$, so
> $J_5=\langle X_{\mathrm{inv}},H\rangle=2\lambda\operatorname{tr}X_{\mathrm{inv}}=\lambda\operatorname{scal}(X_{\mathrm{inv}})$,
> and (i) finishes. $\square$

[bounds.md](../../../findings/bounds.md), Lemma L154.

## What this file states

[L154.lean](L154.lean) proves the arithmetic core of (i), a sum of nonnegative eigenvalues vanishes
only when every one does, and records that the implication fails once signs are free. **What it
lists as owed is that `X_inv` is semidefinite and that `J₅ = λ scal(X_inv)` at scalar `h`.** The
semidefiniteness is `#`-preservation and stays owed; the three steps the proof runs *on* it are
ordinary linear algebra, and they are PROVED here with no `sorry`:

- `psd_row_vanishes` and `psd_diagonal_zero_kills_block`, **the sentence the record states without
  proof**: for a PSD symmetric operator, a vector on which the quadratic form vanishes is killed
  outright, `X v = 0`. The argument is Cauchy–Schwarz in its degenerate case, run as a sign
  condition on `t ↦ ⟪X(v + tw), v + tw⟫`, and it needs no diagonalisation.
- `psd_zero_of_trace_zero`, **and the upgrade (i) actually makes.** A PSD symmetric operator whose
  trace vanishes on a spanning family is the zero operator. *That is stronger than
  [L154.lean](L154.lean)'s eigenvalue form: no diagonalisation is used, so it applies to the block
  decomposition directly, which is how the record's proof reads.*
- `trace_scalar` and `lambda_pos`, `tr(λ·Id) = nλ` on `ℝⁿ`, so `λ = tr h / n`, and with
  `tr h = 2 tr|W|` and `n > 0` the sign of `λ` is the sign of `tr|W|`.
- `J5_of_scalar_h`, **the pairing (ii) computes**: against `H = 2λ·Id` the Frobenius pairing of any
  `X` is `2λ tr X`, which is `λ scal(X)` for `scal = 2 tr`. *So the identity is the pairing and the
  scalar `H`, and nothing else.*
- `scalar_of_irreducible`, **(ii)'s Schur step.** An operator commuting with a family whose only
  invariant subspaces are `⊥` and `⊤` is scalar as soon as it has one eigenvector. The eigenspace's
  invariance is `eigenspace_invariant`, and irreducibility does the rest.

## What is NOT typed here

- **That `X_inv` is positive semidefinite**, block by block, the record's *"each PSD because `#`
  preserves the PSD cone"*, read off [Result 5(a)](../../../ATTEMPTS.md). It is the hypothesis
  `hpsd` throughout, and it is the one thing (i) genuinely needs from the curvature layer.
- **The three blocks themselves**, `P₊X_invP₊ = 4P₊CP₊`, `P₋X_invP₋ = 2P₋(W₊^# + W₋^#)P₋` and
  `P₀X_invP₀ = P₀|W|^#P₀`, and the step `W^# = θW − W²` that kills `ker W`. These need `#`, the
  spectral projectors and criticality.
- **That `h = Ric(|W|)` is equivariant and that `Ric*(h)` has eigenvalues `ηᵢ + ηⱼ`.** The first is
  what makes the isotropy action relevant at all; here the commutation is the hypothesis `hcomm`,
  and `H = 2λ·Id` is the input to `J5_of_scalar_h` rather than a conclusion.
- **That the isotropy group acts irreducibly over `ℝ`** at the points where the record applies it.
  Irreducibility appears as `hirr`, a property of the family of commuting maps.
- **The equality locus itself**, which is [L155](../../../findings/bounds.md)'s `ℤ₂`-graded
  subalgebra statement, and which the record notes gives (i) a shorter proof than the one above.
-/

namespace HamiltonsCubic.L154Statement

open RealInnerProductSpace Finset

/-! ## 1. A PSD operator with a vanishing diagonal entry vanishes on the whole row -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **The record's sentence, proved.** If `X` is symmetric and positive semidefinite and
`⟪X v, v⟫ = 0`, then `⟪X v, w⟫ = 0` at every `w`. *The mechanism is the degenerate case of
Cauchy–Schwarz: `t ↦ 2t⟪Xv,w⟫ + t²⟪Xw,w⟫` is nonnegative at every real `t`, which a nonzero linear
coefficient forbids.* -/
theorem psd_row_vanishes {X : E →ₗ[ℝ] E} (hsymm : ∀ v w, ⟪X v, w⟫ = ⟪v, X w⟫)
    (hpsd : ∀ v, 0 ≤ ⟪X v, v⟫) {v : E} (hv : ⟪X v, v⟫ = 0) (w : E) :
    ⟪X v, w⟫ = 0 := by
  have hcross : ⟪X w, v⟫ = ⟪X v, w⟫ := by rw [hsymm w v, real_inner_comm]
  have key : ∀ t : ℝ, 0 ≤ 2 * t * ⟪X v, w⟫ + t ^ 2 * ⟪X w, w⟫ := by
    intro t
    have h := hpsd (v + t • w)
    have expand : ⟪X (v + t • w), v + t • w⟫
        = ⟪X v, v⟫ + t * ⟪X v, w⟫ + t * ⟪X w, v⟫ + t ^ 2 * ⟪X w, w⟫ := by
      simp only [map_add, map_smul, inner_add_left, inner_add_right, real_inner_smul_left,
        real_inner_smul_right]
      ring
    rw [expand, hv, hcross] at h
    linarith
  have hq : 0 ≤ ⟪X w, w⟫ := hpsd w
  rcases eq_or_lt_of_le hq with hq0 | hqpos
  · have h1 := key 1
    have h2 := key (-1)
    rw [← hq0] at h1 h2
    linarith
  · have h := key (-(⟪X v, w⟫ / ⟪X w, w⟫))
    have hne : ⟪X w, w⟫ ≠ 0 := ne_of_gt hqpos
    have hexp : 2 * (-(⟪X v, w⟫ / ⟪X w, w⟫)) * ⟪X v, w⟫
        + (-(⟪X v, w⟫ / ⟪X w, w⟫)) ^ 2 * ⟪X w, w⟫ = -(⟪X v, w⟫ ^ 2 / ⟪X w, w⟫) := by
      field_simp
      ring
    rw [hexp] at h
    have hnn : 0 ≤ ⟪X v, w⟫ ^ 2 / ⟪X w, w⟫ := by positivity
    have hzero : ⟪X v, w⟫ ^ 2 / ⟪X w, w⟫ = 0 := le_antisymm (by linarith) hnn
    have hsq : ⟪X v, w⟫ ^ 2 = 0 := by
      field_simp at hzero
      simpa using hzero
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hsq

/-- **So the vector itself is killed**: taking `w = X v` and using definiteness of the inner
product, `X v = 0`. -/
theorem psd_diagonal_zero_kills_block {X : E →ₗ[ℝ] E} (hsymm : ∀ v w, ⟪X v, w⟫ = ⟪v, X w⟫)
    (hpsd : ∀ v, 0 ≤ ⟪X v, v⟫) {v : E} (hv : ⟪X v, v⟫ = 0) :
    X v = 0 :=
  inner_self_eq_zero.mp (psd_row_vanishes hsymm hpsd hv (X v))

/-- **The upgrade (i) makes, without diagonalising.** If the trace of a PSD symmetric `X`, read on a
spanning family, vanishes, then `X = 0`: each term is nonnegative, so each vanishes, so each basis
vector is killed, and linearity carries it everywhere. -/
theorem psd_zero_of_trace_zero {ι : Type*} [Fintype ι] {X : E →ₗ[ℝ] E}
    (hsymm : ∀ v w, ⟪X v, w⟫ = ⟪v, X w⟫) (hpsd : ∀ v, 0 ≤ ⟪X v, v⟫)
    (e : ι → E) (hspan : ∀ v : E, ∃ c : ι → ℝ, v = ∑ i, c i • e i)
    (htr : ∑ i, ⟪X (e i), e i⟫ = 0) :
    ∀ v : E, X v = 0 := by
  have hterm : ∀ i ∈ (univ : Finset ι), ⟪X (e i), e i⟫ = 0 := by
    intro i _
    exact (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => hpsd (e j))).mp htr i (mem_univ i)
  intro v
  obtain ⟨c, hc⟩ := hspan v
  rw [hc, map_sum]
  refine Finset.sum_eq_zero ?_
  intro i _
  rw [map_smul, psd_diagonal_zero_kills_block hsymm hpsd (hterm i (mem_univ i)), smul_zero]

/-! ## 2. The scalar `h`, and the pairing that gives `J₅` -/

open Matrix

/-- `tr(λ·Id) = nλ`, so a scalar `h` has `λ = tr h / n`. -/
theorem trace_scalar {m : Type*} [Fintype m] [DecidableEq m] (lam : ℝ) :
    trace ((lam : ℝ) • (1 : Matrix m m ℝ)) = (Fintype.card m : ℝ) * lam := by
  simp [Matrix.trace_smul, Matrix.trace_one, mul_comm]

/-- **And its sign is the sign of `tr|W|`.** With `tr h = 2 tr|W|` and `n > 0`, `λ > 0` exactly when
`tr|W| > 0`, which for `W ≠ 0` is where the record's `#`-positivity enters. -/
theorem lambda_pos {n lam trW : ℝ} (hn : 0 < n) (hlam : n * lam = 2 * trW) (htr : 0 < trW) :
    0 < lam := by
  nlinarith

/-- **The pairing (ii) computes.** Against `H = 2λ·Id` the Frobenius pairing of any `X` is
`2λ tr X`, i.e. `λ·scal(X)` with `scal = 2 tr`. *No property of `X` is used, which is why (i) is
what finishes (ii).* -/
theorem J5_of_scalar_h {m : Type*} [Fintype m] [DecidableEq m] (X : Matrix m m ℝ) (lam : ℝ) :
    trace (Xᵀ * ((2 * lam) • (1 : Matrix m m ℝ))) = lam * (2 * trace X) := by
  simp [Matrix.trace_smul, Matrix.trace_transpose]
  ring

/-! ## 3. Schur's step: an equivariant symmetric operator on an irreducible module is scalar -/

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- **Eigenspaces of a commuting operator are invariant.** -/
theorem eigenspace_invariant {h g : V →ₗ[ℝ] V} (hcomm : ∀ x, h (g x) = g (h x)) {mu : ℝ} {v : V}
    (hv : h v = mu • v) :
    h (g v) = mu • g v := by
  rw [hcomm v, hv, map_smul]

/-- **So under irreducibility one eigenvector makes `h` scalar.** `hirr` says the family `G` has no
invariant subspace but `⊥` and `⊤`; the `μ`-eigenspace of `h` is invariant and nonzero, hence
everything. -/
theorem scalar_of_irreducible {h : V →ₗ[ℝ] V} {G : Set (V →ₗ[ℝ] V)}
    (hcomm : ∀ g ∈ G, ∀ x, h (g x) = g (h x))
    (hirr : ∀ S : Submodule ℝ V, (∀ g ∈ G, ∀ v ∈ S, g v ∈ S) → S = ⊥ ∨ S = ⊤)
    {mu : ℝ} {v₀ : V} (hv₀ : v₀ ≠ 0) (heig : h v₀ = mu • v₀) :
    ∀ x, h x = mu • x := by
  set S : Submodule ℝ V := LinearMap.ker (h - mu • LinearMap.id) with hS
  have hmem : ∀ x, x ∈ S ↔ h x = mu • x := by
    intro x
    simp [hS, LinearMap.mem_ker, sub_eq_zero]
  have hinv : ∀ g ∈ G, ∀ w ∈ S, g w ∈ S := by
    intro g hg w hw
    exact (hmem _).mpr (eigenspace_invariant (hcomm g hg) ((hmem w).mp hw))
  rcases hirr S hinv with hbot | htop
  · exact absurd ((hmem v₀).mpr heig) (by rw [hbot]; simpa using hv₀)
  · intro x
    exact (hmem x).mp (by rw [htop]; trivial)

end HamiltonsCubic.L154Statement
