import HamiltonsCubic.Results.L209FoxClosure
import HamiltonsCubic.Results.L244RowB

set_option linter.style.longLine false

/-!
# The curvature operator of the second kind, `W̊`

[findings/conventions.md](../../../findings/conventions.md), *the second-kind operator, and the
index order, SETTLED on Li's `iklj`*: on symmetric 2-tensors
`(W̊ h)_{ij} = ∑_{k,l} W_{iklj} h_{kl}`, with `W_{ijkl} = ⟨W φ_ij, φ_kl⟩` the layer's `R4`, which
carries the record's normalisation `‖W‖² = ¼ ∑ W_{ijkl}²`.

**This file is the base piece [L50](../../../findings/bispectral.md), [L52], [L54] and [L67] wait
on**, each of which names `W̊` as untyped. *It defines `ringW` on all square matrices and proves the
structural facts every consumer uses first:*

- `ringW_selfAdjoint`: `⟨W̊ h, h'⟩ = ⟨h, W̊ h'⟩` in the Frobenius pairing, from pair symmetry and
  the two antisymmetries alone;
- `ringW_symm`: `W̊` maps symmetric tensors to symmetric tensors;
- `ringW_one`: `W̊ g = −Ric`, so a Ricci-flat `W` kills the metric;
- `trace_ringW`: `tr (W̊ h) = −⟨Ric, h⟩`, so a Ricci-flat `W̊` lands in the trace-free tensors.

So at a Weyl operator `W̊` is a self-adjoint operator on `S²` with `g` in its kernel and image in
`S²₀`, which is the object the record's `ω = spec(W̊)` is the spectrum of. **The two trace
identities L50's bi-spectral identity rests on are proved over `S²`** (Dai–Fu's Lemma 3.3 at
`s = 0`): `trS2_ringW_sq`, `tr W̊² = ¾ ∑ W²`, and `trS2_ringW_cube`, `tr W̊³ = α/8 − β`, both for a
linear operator self-adjoint on bivectors satisfying first Bianchi.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`W̊`**, in Li's `iklj` order. -/
noncomputable def ringW (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (h : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  fun i j => ∑ k, ∑ l, R4 R i k l j * h k l

/-- The Frobenius pairing of two matrices. -/
def frob (A B : Matrix ι ι ℝ) : ℝ := ∑ i, ∑ j, A i j * B i j

omit [DecidableEq ι] in
/-- Reordering a four-fold sum, `(i,j,k,l) ↦ (k,l,i,j)`. -/
theorem sum4_swap (f : ι → ι → ι → ι → ℝ) :
    (∑ i, ∑ j, ∑ k, ∑ l, f i j k l) = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
  calc (∑ i, ∑ j, ∑ k, ∑ l, f i j k l) = ∑ i, ∑ k, ∑ j, ∑ l, f i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k, ∑ i, ∑ j, ∑ l, f i j k l := Finset.sum_comm
    _ = ∑ k, ∑ i, ∑ l, ∑ j, f i j k l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_comm


omit [DecidableEq ι] in
/-- Relabelling the outer two of three summation variables, `(j,k,l) ↦ (l,k,j)`. -/
theorem sum3_swap13 (g : ι → ι → ι → ℝ) :
    (∑ j, ∑ k, ∑ l, g j k l) = ∑ j, ∑ k, ∑ l, g l k j := by
  calc (∑ j, ∑ k, ∑ l, g j k l) = ∑ j, ∑ l, ∑ k, g j k l :=
        Finset.sum_congr rfl fun j _ => Finset.sum_comm
    _ = ∑ l, ∑ j, ∑ k, g j k l := Finset.sum_comm
    _ = ∑ l, ∑ k, ∑ j, g j k l := Finset.sum_congr rfl fun l _ => Finset.sum_comm

section structural

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- Antisymmetry in the first pair. -/
theorem R4_anti1 (a b c d : ι) : R4 R b a c d = -R4 R a b c d := by
  rw [R4_pair R hR hskew hsym b a c d, R4_anti2 R hR c d a b, R4_pair R hR hskew hsym c d a b]

/-- `W_{iklj} = W_{kijl}`: both antisymmetries. -/
theorem R4_iklj (i k l j : ι) : R4 R i k l j = R4 R k i j l := by
  rw [R4_anti2 R hR i k j l, R4_anti1 R hR hskew hsym k i j l]; ring

/-- **`W̊` is self-adjoint** for the Frobenius pairing, on all matrices. -/
theorem ringW_selfAdjoint (h h' : Matrix ι ι ℝ) :
    frob (ringW R h) h' = frob h (ringW R h') := by
  unfold frob ringW
  simp only [Finset.sum_mul, Finset.mul_sum]
  rw [sum4_swap (fun i j k l => h i j * (R4 R i k l j * h' k l))]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [R4_iklj R hR hskew hsym k i j l]
  ring

/-- **`W̊` maps symmetric tensors to symmetric tensors.** -/
theorem ringW_symm (h : Matrix ι ι ℝ) (hh : hᵀ = h) : (ringW R h)ᵀ = ringW R h := by
  ext i j
  simp only [Matrix.transpose_apply, ringW]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  have hkl : h l k = h k l := by
    have := congrFun (congrFun hh k) l; simpa [Matrix.transpose_apply] using this
  rw [R4_iklj R hR hskew hsym j l k i, R4_pair R hR hskew hsym l j i k, hkl]

omit hskew hsym in
/-- **`W̊ g = −Ric`**, so a Ricci-flat `W` kills the metric. -/
theorem ringW_one (i j : ι) : ringW R 1 i j = -Ric R i j := by
  unfold ringW Ric
  have e : ∀ k, (∑ l, R4 R i k l j * (1 : Matrix ι ι ℝ) k l) = R4 R i k k j := fun k => by
    rw [Finset.sum_eq_single k (fun l _ hl => by rw [Matrix.one_apply_ne (Ne.symm hl), mul_zero])
      (fun h => absurd (Finset.mem_univ k) h), Matrix.one_apply_eq, mul_one]
  simp only [e]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [R4_anti2 R hR i k j k]; rfl

/-- **`tr (W̊ h) = −⟨Ric, h⟩`**, so a Ricci-flat `W̊` lands in the trace-free tensors. -/
theorem trace_ringW (h : Matrix ι ι ℝ) :
    (ringW R h).trace = -frob (fun k l => Ric R k l) h := by
  have key : ∀ k l, (∑ i, R4 R i k l i) = -Ric R k l := fun k l => by
    unfold Ric
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [R4_anti2 R hR i k i l, R4_anti1 R hR hskew hsym k i i l, R4_anti2 R hR k i l i]
    unfold R4; ring
  calc (ringW R h).trace = ∑ i, ∑ k, ∑ l, R4 R i k l i * h k l := rfl
    _ = ∑ k, ∑ l, ∑ i, R4 R i k l i * h k l := by
        rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k, ∑ l, (∑ i, R4 R i k l i) * h k l := by simp only [Finset.sum_mul]
    _ = -frob (fun k l => Ric R k l) h := by
        simp only [key, frob, neg_mul, Finset.sum_neg_distrib]

end structural

/-- **Li's anchor, in the kernel**: at the round sphere, the identity on bivectors,
`W̊ h = hᵀ − (tr h) g`, so `W̊ = +Id` on trace-free symmetric `h`. *The order `ikjl` would give
`−Id` there, so this fixes the index order the whole file uses
([r1401](../../../reviews/REVIEW_r1401.md)).* -/
theorem ringW_id (h : Matrix ι ι ℝ) (i j : ι) :
    ringW (fun X => X) h i j = h j i - (if i = j then h.trace else 0) := by
  unfold ringW R4
  simp only [FamilyLayer.inner2_phi_phi, sub_mul, Finset.sum_sub_distrib, ite_mul, one_mul,
    zero_mul, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq', Matrix.trace, eq_comm]

/-- **So `W̊ = +Id` on trace-free symmetric tensors at the round sphere.** -/
theorem ringW_id_S20 (h : Matrix ι ι ℝ) (hh : hᵀ = h) (htr : h.trace = 0) :
    ringW (fun X => X) h = h := by
  ext i j
  rw [ringW_id, htr]
  have : h j i = h i j := by
    have := congrFun (congrFun hh i) j; simpa [Matrix.transpose_apply] using this
  simp [this]

/-! ## The trace over `S²`, and `tr W̊² = ¾ |W|²` -/

/-- The symmetric basis tensor `½(E_ab + E_ba)`. -/
noncomputable def symB (a b : ι) : Matrix ι ι ℝ :=
  (1 / 2 : ℝ) • (Matrix.single a b 1 + Matrix.single b a 1)

/-- **The trace of a map on `S²`**, `∑_{a,b} (A (½(E_ab + E_ba)))_ab`. *For `A` preserving symmetric
tensors this is the trace of `A|S²` in the basis `{E_aa} ∪ {E_ab + E_ba}_{a<b}`: the diagonal terms
are `(A E_aa)_aa`, and each `a<b` pair contributes `½((A s)_ab + (A s)_ba) = (A s)_ab` with
`s = E_ab + E_ba`, `A s` being symmetric.* `ringW` preserves `S²` (`ringW_symm`). -/
noncomputable def trS2 (A : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  ∑ a, ∑ b, A (symB a b) a b

/-- `W̊` on a symmetric basis tensor. -/
theorem ringW_symB (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b k l : ι) :
    ringW R (symB a b) k l = (1 / 2) * (R4 R k a b l + R4 R k b a l) := by
  unfold ringW symB
  simp only [Matrix.smul_apply, Matrix.add_apply, Matrix.single_apply, smul_eq_mul]
  simp only [mul_add, Finset.sum_add_distrib, mul_ite, mul_one, mul_zero, ite_and]
  simp [Finset.sum_ite_eq', Finset.sum_ite_eq]
  ring

section trace

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0)
include hR hskew hsym hB

/-- **`X = ½ |W|²`**: `∑ W_{aklb} W_{alkb} = ½ ∑ W_{ijkl}²`, by first Bianchi and a relabelling. -/
theorem cross_half :
    (∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b * R4 R a l k b)
      = (1 / 2) * ∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b ^ 2 := by
  have hBi : ∀ i j k l, R4 R i j k l = -R4 R i k l j - R4 R i l j k := by
    intro i j k l; have := hB i j k l; unfold bianchi at this; unfold R4; linarith
  have hA2 := R4_anti2 R hR
  -- `W_{alkb} = W_{aklb} + W_{abkl}`
  have hsplit : ∀ a b k l, R4 R a l k b = R4 R a k l b + R4 R a b k l := by
    intro a b k l
    rw [hBi a l k b, hA2 a k b l, hA2 a b l k]; ring
  set X := ∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b * R4 R a l k b with hX
  set S := ∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b ^ 2 with hS
  set Y := ∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b * R4 R a b k l with hY
  have hXY : X = S + Y := by
    rw [hX, hS, hY, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [hsplit a b k l]; ring
  -- `Y = −X`: the `Y` term at `(b,k,l)` is minus the `X` term at `(l,b,k)`
  have hYX : Y = -X := by
    rw [hY, hX, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    calc (∑ b, ∑ k, ∑ l, R4 R a k l b * R4 R a b k l)
        = ∑ b, ∑ k, ∑ l, -(R4 R a b k l * R4 R a k b l) := by
          refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun k _ =>
            Finset.sum_congr rfl fun l _ => ?_
          rw [hA2 a k l b]; ring
      _ = ∑ b, ∑ l, ∑ k, -(R4 R a b k l * R4 R a k b l) :=
          Finset.sum_congr rfl fun b _ => Finset.sum_comm
      _ = ∑ l, ∑ b, ∑ k, -(R4 R a b k l * R4 R a k b l) := Finset.sum_comm
      _ = -(∑ b, ∑ k, ∑ l, R4 R a k l b * R4 R a l k b) := by
          simp only [Finset.sum_neg_distrib]
  linarith

/-- **`tr_{S²} W̊² = ¾ |W|²`**, with `|W|² = ∑ W_{ijkl}²`, the first of Dai–Fu's Lemma 3.3 identities
at `s = 0`. *At the record's unit norm `|W|² = 4‖W‖² = 4` this is `∑ ω² = 3`.* -/
theorem trS2_ringW_sq :
    trS2 (fun h => ringW R (ringW R h))
      = (3 / 4) * ∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b ^ 2 := by
  have hX := cross_half R hR hskew hsym hB
  have e : trS2 (fun h => ringW R (ringW R h))
      = ∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b * ((1 / 2) * (R4 R a k l b + R4 R a l k b)) := by
    unfold trS2
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    show (∑ k, ∑ l, R4 R a k l b * ringW R (symB a b) k l) = _
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    rw [ringW_symB, ← R4_iklj R hR hskew hsym a k l b, R4_pair R hR hskew hsym k b a l]
  rw [e]
  have e2 : (∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b * ((1 / 2) * (R4 R a k l b + R4 R a l k b)))
      = (1 / 2) * (∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b ^ 2)
        + (1 / 2) * (∑ a, ∑ b, ∑ k, ∑ l, R4 R a k l b * R4 R a l k b) := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    ring
  rw [e2, hX]; ring

/-! ## The cubic identity `tr_{S²} W̊³ = α/8 − β` -/

/-- **`α = ∑ W_{ijkl} W_{ijmn} W_{klmn}`.** -/
noncomputable def alphaW : ℝ :=
  ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i j k l * R4 R i j m n * R4 R k l m n

/-- **`β = ∑ W_{ijkl} W_{imkn} W_{jmln}`**, the record's `W_{tspq} W_{tjpl} W_{sjql}`. -/
noncomputable def betaW : ℝ :=
  ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i j k l * R4 R i m k n * R4 R j m l n

/-- The other ordering of `β`'s last factor, `β' = ∑ W_{ijkl} W_{imkn} W_{jnlm}`. -/
noncomputable def betaW' : ℝ :=
  ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i j k l * R4 R i m k n * R4 R j n l m

/-- **`2 ∑ W_{ikjl} W_{imkn} W_{jlnm} = −α`**: relabel `m ↔ n`, antisymmetrise, relabel `j ↔ k`. -/
theorem two_E_eq : 2 * (∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n,
    R4 R i k j l * R4 R i m k n * R4 R j l n m) = -alphaW R := by
  have hBi : ∀ i j k l, R4 R i j k l = -R4 R i k l j - R4 R i l j k := by
    intro i j k l; have := hB i j k l; unfold bianchi at this; unfold R4; linarith
  have hA2 := R4_anti2 R hR
  have hanti : ∀ i j k l, R4 R i j k l - R4 R i l k j = R4 R i k j l := by
    intro i j k l; rw [hBi i j k l, hA2 i k j l, hA2 i l j k]; ring
  set E := ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i k j l * R4 R i m k n * R4 R j l n m with hE
  have hsw : E = -∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n,
      R4 R i k j l * R4 R i n k m * R4 R j l n m := by
    rw [hE, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    simp only [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
      Finset.sum_congr rfl fun l _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun m _ => Finset.sum_congr rfl fun n _ => ?_
    rw [hA2 j l n m]; ring
  -- `2E = ∑ W_{ikjl} W_{ikmn} W_{jlnm} = −∑ W_{ikjl} W_{ikmn} W_{jlmn}`
  have h2E : 2 * E = -∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n,
      R4 R i k j l * R4 R i k m n * R4 R j l m n := by
    have : 2 * E = E + E := by ring
    rw [this]; nth_rewrite 2 [hsw]; rw [hE, ← sub_eq_add_neg, ← Finset.sum_sub_distrib,
      ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    simp only [← Finset.sum_sub_distrib, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
      Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ =>
      Finset.sum_congr rfl fun n _ => ?_
    rw [← hanti i m k n, hA2 j l m n]; ring
  -- relabel `j ↔ k` to reach `α`
  rw [h2E, alphaW, neg_inj]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_comm

/-- **`β' = β − α/4`**, by first Bianchi and two antisymmetrisations. -/
theorem betaW'_eq : betaW' R = betaW R - alphaW R / 4 := by
  have hBi : ∀ i j k l, R4 R i j k l = -R4 R i k l j - R4 R i l j k := by
    intro i j k l; have := hB i j k l; unfold bianchi at this; unfold R4; linarith
  have hA2 := R4_anti2 R hR
  -- `W_{ijkl} − W_{ilkj} = W_{ikjl}`
  have hanti : ∀ i j k l, R4 R i j k l - R4 R i l k j = R4 R i k j l := by
    intro i j k l; rw [hBi i j k l, hA2 i k j l, hA2 i l j k]; ring
  -- `W_{jnlm} = W_{jmln} + W_{jlnm}`
  have hlast : ∀ j l m n, R4 R j n l m = R4 R j m l n + R4 R j l n m := by
    intro j l m n; rw [hBi j m l n, hA2 j n m l]; ring
  set D := ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i j k l * R4 R i m k n * R4 R j l n m with hD
  have h1 : betaW' R = betaW R + D := by
    unfold betaW' betaW
    rw [hD]; simp only [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
      Finset.sum_congr rfl fun m _ => Finset.sum_congr rfl fun n _ => ?_
    rw [hlast j l m n]; ring
  -- `2D = ∑ W_{ikjl} W_{imkn} W_{jlnm}`: relabel `j ↔ l`
  set E := ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i k j l * R4 R i m k n * R4 R j l n m with hE
  have h2 : 2 * D = E := by
    have hsw : D = -∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, R4 R i l k j * R4 R i m k n * R4 R j l n m := by
      rw [hD, ← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun i _ => ?_
      rw [sum3_swap13 (fun j k l => ∑ m, ∑ n, R4 R i j k l * R4 R i m k n * R4 R j l n m)]
      simp only [← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
        Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ =>
        Finset.sum_congr rfl fun n _ => ?_
      rw [R4_anti1 R hR hskew hsym l j n m]; ring
    rw [hE]
    have : 2 * D = D + D := by ring
    rw [this]; nth_rewrite 2 [hsw]; rw [hD, ← sub_eq_add_neg, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    simp only [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
      Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ =>
      Finset.sum_congr rfl fun n _ => ?_
    rw [← hanti i j k l]; ring
  -- `2E = ∑ W_{ikjl} W_{ikmn} W_{jlnm}`: relabel `m ↔ n`
  have h3 : 2 * E = -alphaW R := two_E_eq R hR hskew hsym hB
  linarith

/-- The first term of `tr W̊³`, `A = ∑ W_{aklb} W_{kpql} W_{pabq} = −β`. -/
theorem cubeA_eq : (∑ a, ∑ b, ∑ k, ∑ l, ∑ p, ∑ q,
    R4 R a k l b * R4 R k p q l * R4 R p a b q) = -betaW R := by
  have hA2 := R4_anti2 R hR
  have e : ∀ a b k l p q : ι, R4 R a k l b * R4 R k p q l * R4 R p a b q
      = -(R4 R a k b l * R4 R a p b q * R4 R k p l q) := by
    intro a b k l p q
    rw [hA2 a k b l, hA2 k p l q, R4_anti1 R hR hskew hsym a p b q]; ring
  simp only [e, Finset.sum_neg_distrib]
  rw [betaW, neg_inj]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_comm

/-- The second term of `tr W̊³`, `B = ∑ W_{aklb} W_{kpql} W_{pbaq} = −β'`. -/
theorem cubeB_eq : (∑ a, ∑ b, ∑ k, ∑ l, ∑ p, ∑ q,
    R4 R a k l b * R4 R k p q l * R4 R p b a q) = -betaW' R := by
  have hA2 := R4_anti2 R hR
  have e : ∀ a b k l p q : ι, R4 R a k l b * R4 R k p q l * R4 R p b a q
      = -(R4 R a k b l * R4 R a q b p * R4 R k p l q) := by
    intro a b k l p q
    rw [hA2 a k b l, hA2 k p l q, R4_pair R hR hskew hsym p b a q, hA2 a q b p]; ring
  simp only [e, Finset.sum_neg_distrib]
  rw [betaW', neg_inj]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun l _ => ?_
  exact Finset.sum_comm

/-- **`tr_{S²} W̊³ = α/8 − β`**, the cubic identity L50 rests on: the trace expands to `½(A + B)`,
`A = −β`, `B = −β'`, and `β' = β − α/4`. -/
theorem trS2_ringW_cube :
    trS2 (fun h => ringW R (ringW R (ringW R h))) = alphaW R / 8 - betaW R := by
  have e : trS2 (fun h => ringW R (ringW R (ringW R h)))
      = ∑ a, ∑ b, ∑ k, ∑ l, ∑ p, ∑ q,
          R4 R a k l b * R4 R k p q l * ((1 / 2) * (R4 R p a b q + R4 R p b a q)) := by
    unfold trS2
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    show (∑ k, ∑ l, R4 R a k l b * ringW R (ringW R (symB a b)) k l) = _
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    show R4 R a k l b * (∑ p, ∑ q, R4 R k p q l * ringW R (symB a b) p q) = _
    simp only [Finset.mul_sum]
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [ringW_symB]; ring
  have e2 : (∑ a, ∑ b, ∑ k, ∑ l, ∑ p, ∑ q,
        R4 R a k l b * R4 R k p q l * ((1 / 2) * (R4 R p a b q + R4 R p b a q)))
      = (1 / 2) * (∑ a, ∑ b, ∑ k, ∑ l, ∑ p, ∑ q, R4 R a k l b * R4 R k p q l * R4 R p a b q)
        + (1 / 2) * (∑ a, ∑ b, ∑ k, ∑ l, ∑ p, ∑ q, R4 R a k l b * R4 R k p q l * R4 R p b a q) := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
      Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    ring
  rw [e, e2, cubeA_eq R hR hskew hsym hB, cubeB_eq R hR hskew hsym hB,
    betaW'_eq R hR hskew hsym hB]
  ring

end trace

end HamiltonsCubic.SecondKind
