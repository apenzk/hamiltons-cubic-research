import Mathlib

/-!
# L116, `b(W^#) = -b(W²)` on every curvature operator, PROVED

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L116, quoted verbatim:

> Böhm–Wilking define `S²_B(𝔰𝔬(n))` as the self-adjoint endomorphisms satisfying Bianchi, and
> state Hamilton's principle for the ODE `Ṙ = R² + R^#` on it, so **the sum** preserves Bianchi.
> `R^#` alone does not, and the inference *"`Q(W) = θW` is Bianchi, hence `b(W²) = 0`"* is
> therefore false. What holds on every curvature operator is the cancellation
> `b(W^#) = -b(W²) = -Σ_α λ_α² (v_α ∧ v_α)`, with both sides genuinely nonzero, `0.962` at `ℂP³`,
> `0.953` at `ℂP⁴`.

**What [L116.lean](L116.lean) already carries and this file does not repeat**: that `b(X) = -b(Y)`
and `b(X+Y) = 0` are one proposition once `b` is additive, and the asymmetry of the two
hypotheses. **That file states those over `b : ℚ → ℚ`**, an additive map on the rationals, with
no tensor, no `#` and no `b`, so it never states L116. The tensors are typed here.

## The display has two equalities and they are of different kinds

* **`b(W^#) = -b(W²)`** is Hamilton's principle: `b(R² + R^#) = 0` whenever `R` satisfies the
  first Bianchi identity. It is the lemma's content and is proved below by one contraction.
* **`b(W²) = Σ_α λ_α² (v_α ∧ v_α)`** is bookkeeping: `b` is linear, `W² = Σ λ_α² v_α ⊗ v_α` by
  the spectral theorem, and `b(v ⊗ v) = v ∧ v` holds by unfolding. All three steps are proved
  below, the spectral decomposition entering as a hypothesis because it is the classical spectral
  theorem on `Λ²ℝⁿ` rather than anything this record proves.

## The conventions, stated because the identity is convention-dependent

`b` is the un-normalised Bianchi sum `b(R)_{ijkl} = R_{ijkl} + R_{iklj} + R_{iljk}`; `R²` is
operator composition on `Λ²` with the `½` at the contraction,
`(R²)_{ijkl} = ½ Σ_{p,q} R_{ijpq} R_{pqkl}`; and `#` is Böhm–Wilking's equation (4),
`(R^#)_{ijkl} = Σ_{p,q} (R_{ipkq} R_{jplq} - R_{iplq} R_{jpkq})`, which
[fence-posts.md](../../../findings/fence-posts.md) records as matching the record's own
`R_sharp_quadform` with no rescaling. **Under the other `#` in circulation the identity is false
rather than rescaled**, which is why the convention sits in the file and not in a comment.

## What the record says beyond this file

**That both sides are genuinely nonzero**, `0.962` at `ℂP³`, `0.953` at `ℂP⁴`, is a numerical
evaluation at named points, and a screen; it is not a statement this file can carry.

**That `R^#` alone fails to preserve Bianchi**, and the degenerate point where `b(W²)` and `b(W^#)`
both vanish (`S³ × S³`, and the whole coordinate-diagonal locus), are proved in
[L116Sharp.lean](L116Sharp.lean) (`sharp_not_bianchi`, `degenerate_diag`).
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L116Statement

open Finset

variable {n : ℕ}

/-- A four-index tensor on `ℝⁿ`; a symmetric operator on `Λ²ℝⁿ` is one of these. -/
abbrev Tensor4 (n : ℕ) := Fin n → Fin n → Fin n → Fin n → ℝ

/-- A bivector, as a skew matrix of components. -/
abbrev Bivector (n : ℕ) := Fin n → Fin n → ℝ

/-- **The Bianchi map `b`**, the projection onto `Λ⁴` up to normalisation:
`b(R)_{ijkl} = R_{ijkl} + R_{iklj} + R_{iljk}`. -/
def bianchi (R : Tensor4 n) : Tensor4 n := fun i j k l => R i j k l + R i k l j + R i l j k

/-- **Operator composition on `Λ²`**, with the `½` at the contraction. -/
noncomputable def comp (R S : Tensor4 n) : Tensor4 n :=
  fun i j k l => (1 / 2) * ∑ p, ∑ q, R i j p q * S p q k l

/-- **Böhm–Wilking's `#`**, equation (4). -/
def sharp (R : Tensor4 n) : Tensor4 n :=
  fun i j k l => ∑ p, ∑ q, (R i p k q * R j p l q - R i p l q * R j p k q)

/-- `v ⊗ v`, the rank-one operator on `Λ²` carried by a bivector. -/
def rankOne (v : Bivector n) : Tensor4 n := fun i j k l => v i j * v k l

/-- `v ∧ v`, the `Λ⁴` element the display's right-hand side is built from. -/
def wedgeSelf (v : Bivector n) : Tensor4 n :=
  fun i j k l => v i j * v k l + v i k * v l j + v i l * v j k

/-- The first Bianchi identity. **A curvature operator satisfies it; `R^#` need not.** -/
def FirstBianchi (R : Tensor4 n) : Prop := bianchi R = 0

/-! ## The bookkeeping half, proved -/

/-- **`b(v ⊗ v) = v ∧ v`**, by unfolding both sides. -/
theorem bianchi_rankOne (v : Bivector n) : bianchi (rankOne v) = wedgeSelf v := rfl

/-- **`b` is additive.** -/
theorem bianchi_add (R S : Tensor4 n) : bianchi (R + S) = bianchi R + bianchi S := by
  funext i j k l; simp only [bianchi, Pi.add_apply]; ring

/-- **`b` is homogeneous.** -/
theorem bianchi_smul (c : ℝ) (R : Tensor4 n) : bianchi (c • R) = c • bianchi R := by
  funext i j k l; simp only [bianchi, Pi.smul_apply, smul_eq_mul]; ring

/-- **`b` commutes with finite sums**, which is what carries it across a spectral decomposition. -/
theorem bianchi_sum {N : ℕ} (x : Fin N → ℝ) (v : Fin N → Bivector n) :
    bianchi (fun i j k l => ∑ a, x a * v a i j * v a k l)
      = fun i j k l => ∑ a, x a * wedgeSelf (v a) i j k l := by
  funext i j k l
  simp only [bianchi, wedgeSelf, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl ?_
  intro a _
  ring

/-- **The display's second equality**, in full: with `W² = Σ_α λ_α² v_α ⊗ v_α`, the spectral
theorem on `Λ²ℝⁿ`, taken as a hypothesis, `b(W²) = Σ_α λ_α² (v_α ∧ v_α)`.

*The `−` of the display sits on the other equality; this one is the plain sum.* -/
theorem bianchi_sq_spectral {N : ℕ} (lam : Fin N → ℝ) (v : Fin N → Bivector n) (Wsq : Tensor4 n)
    (hspec : Wsq = fun i j k l => ∑ a, lam a ^ 2 * v a i j * v a k l) :
    bianchi Wsq = fun i j k l => ∑ a, lam a ^ 2 * wedgeSelf (v a) i j k l := by
  subst hspec
  exact bianchi_sum (fun a => lam a ^ 2) v

/-- **The identity and the vanishing are one proposition**, at the tensor level rather than over
`ℚ`: `b(R^#) = -b(R²)` and `b(R² + R^#) = 0` say the same thing, because `b` is additive. -/
theorem identity_iff_vanishing (R : Tensor4 n) :
    bianchi (sharp R) = -bianchi (comp R R) ↔ bianchi (comp R R + sharp R) = 0 := by
  rw [bianchi_add]
  constructor
  · intro h; rw [h]; abel
  · intro h; funext i j k l
    have := congrFun (congrFun (congrFun (congrFun h i) j) k) l
    simp only [Pi.add_apply, Pi.zero_apply] at this
    simp only [Pi.neg_apply]
    linarith

/-! ## The contraction both products reduce to -/

/-- `P(a,b,c,d) = Σ_{p,q} R_{apbq} R_{cpdq}`, the one contraction both products reduce to. -/
def P (R : Tensor4 n) (a b c d : Fin n) : ℝ := ∑ p, ∑ q, R a p b q * R c p d q

theorem sharp_P (R : Tensor4 n) (i j k l : Fin n) : sharp R i j k l = P R i k j l - P R i l j k := by
  simp only [sharp, P, ← Finset.sum_sub_distrib]

theorem comp_P (R : Tensor4 n)
    (hskew₁ : ∀ i j k l, R i j k l = -R j i k l)
    (hskew₂ : ∀ i j k l, R i j k l = -R i j l k)
    (hB : FirstBianchi R) (i j k l : Fin n) :
    comp R R i j k l = P R i j k l - P R i j l k := by
  have hB' : ∀ a b p q, R a b p q = R a p b q - R a q b p := fun a b p q => by
    have := congrFun (congrFun (congrFun (congrFun hB a) b) p) q
    simp only [bianchi, Pi.zero_apply] at this
    have := hskew₂ a p q b
    linarith
  have h1 : ∑ p, ∑ q, R i q j p * R p q k l = -∑ p, ∑ q, R i p j q * R p q k l := by
    rw [Finset.sum_comm]
    simp only [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by
      rw [hskew₁ b a k l]; ring
  have e : ∀ p q, R p q k l = R k p l q - R l p k q := fun p q => by
    have := hB' p q k l
    have := hskew₁ p k q l; have := hskew₂ k p q l
    have := hskew₁ p l q k; have := hskew₂ l p q k
    linarith
  unfold comp
  calc (1 / 2) * ∑ p, ∑ q, R i j p q * R p q k l
      = (1 / 2) * (∑ p, ∑ q, R i p j q * R p q k l - ∑ p, ∑ q, R i q j p * R p q k l) := by
        rw [← Finset.sum_sub_distrib]
        congr 1
        exact Finset.sum_congr rfl fun p _ => by
          rw [← Finset.sum_sub_distrib]
          exact Finset.sum_congr rfl fun q _ => by rw [hB' i j p q]; ring
    _ = ∑ p, ∑ q, R i p j q * R p q k l := by rw [h1]; ring
    _ = P R i j k l - P R i j l k := by
        unfold P
        rw [← Finset.sum_sub_distrib]
        exact Finset.sum_congr rfl fun p _ => by
          rw [← Finset.sum_sub_distrib]
          exact Finset.sum_congr rfl fun q _ => by rw [e p q]; ring

/-! ## The statement itself -/

/-- **L116.** On every curvature operator, a symmetric operator on `Λ²ℝⁿ` satisfying the first
Bianchi identity, the sharp and squared parts cancel in `Λ⁴`: `b(R^#) = -b(R²)`.

**Proved by one contraction.** With `P(a,b,c,d) = Σ_{p,q} R_{apbq} R_{cpdq}`, the first Bianchi
identity gives `(R²)_{ijkl} = P(i,j,k,l) - P(i,j,l,k)` (`comp_P`), and `(R^#)_{ijkl} =
P(i,k,j,l) - P(i,l,j,k)` is the definition read off (`sharp_P`). Under the cyclic sum `b` the six
`P` terms of `b(R^#)` are those of `b(R²)` with opposite signs. **The pair symmetry `hpair` is
not used**: Bianchi and the two antisymmetries carry the whole identity.

**The hypotheses are the four algebraic curvature symmetries plus Bianchi**, and the conclusion
is not that either side vanishes, the record's whole point is that both are nonzero at `ℂP³`
and `ℂP⁴`. -/
theorem L116 (R : Tensor4 n)
    (hskew₁ : ∀ i j k l, R i j k l = -R j i k l)
    (hskew₂ : ∀ i j k l, R i j k l = -R i j l k)
    (hpair : ∀ i j k l, R i j k l = R k l i j)
    (hB : FirstBianchi R) :
    bianchi (sharp R) = -bianchi (comp R R) := by
  funext i j k l
  simp only [bianchi, Pi.neg_apply, sharp_P, comp_P R hskew₁ hskew₂ hB]
  ring

/-- **The hypotheses of `L116` are not empty**: the zero tensor is a curvature operator. *A
vacuous reading is the hazard the record itself names at `S³ × S³`, where both sides vanish and
a screen run only there confirms the false claim; the zero tensor is the same degeneracy in its
purest form, which is why it is recorded as a witness for inhabitation and nothing else.* -/
example : FirstBianchi (0 : Tensor4 n) ∧ (∀ i j k l, (0 : Tensor4 n) i j k l = -(0 : Tensor4 n) j i k l) := by
  constructor
  · funext i j k l; simp [bianchi]
  · intro i j k l; simp

end HamiltonsCubic.L116Statement
