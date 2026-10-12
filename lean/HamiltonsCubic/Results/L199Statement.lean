import HamiltonsCubic.Base.Sharp

/-!
# L199, the orbit-tangent form is `4(W²#I) - 4W#`

[findings/bounds.md](../../../findings/bounds.md), Lemma L199. The record's
`g_k = ‖[ad(v_k), W]‖²` is the diagonal, in an eigenbasis, of a symmetric
operator `G` on `Λ²`, and the lemma says what `G` is:

`G = 4 (W² # I) - 4 (W # W)`

for **every** symmetric `W` on `Λ²ℝⁿ`. No first Bianchi, no Ricci-flatness, no
criticality, no dimension restriction. Composing with
[L131](../../../findings/isotropy-cap.md)'s
`Ric(R) ∧ id = R + R#I - 3 Alt(R)` at `R = W²` turns the first term into
`4(Ric(W²) ∧ id) + 12 Alt(W²) - 4W²`, which is the form the findings block
states, and `⟨G x, x⟩ ≥ 0` is then the bound at every index.

Stated here at `n = 4`, where the base layer carries `#`, its normalisation
anchor `Id# = (n-2) Id`, and the Weyl conditions. What is left out is recorded
in [lean/INDEX.md](../../INDEX.md): `Ric(W²) ∧ id` and `Alt(W²)` are not built
here, so this file carries the `#`-form and not the L131-composed form.
-/

set_option linter.style.longLine false
set_option maxRecDepth 100000

namespace HamiltonsCubic.Results

open Matrix HamiltonsCubic.Base

/-- The bilinear `#`, polarised from the quadratic `sharpMat`. -/
def sharpBil (A B : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun a b => (1/2 : ℚ) * (sharpMat (A + B) a b - sharpMat A a b - sharpMat B a b)

/-- `ad(φ_j)` as an operator on `Λ²ℝ⁴`, column `a` being `[φ_j, φ_a]`. -/
def adMat (j : Fin 6) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun a' a => coord4 (br (basis4 j) (basis4 a)) a'

/-- `[ad(φ_j), R]`, the commutator whose norm the record calls `g_j`. -/
def adComm (j : Fin 6) (R : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  adMat j * R - R * adMat j

/-- The orbit-tangent form: `G_{jk} = ⟨[ad(φ_j), R], [ad(φ_k), R]⟩` in the plain
Frobenius pairing at the operator level. Its diagonal in an eigenbasis of `R` is
the record's `g_k`. -/
def Gmat (R : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun j k => ((adComm j R)ᵀ * (adComm k R)).trace

set_option maxHeartbeats 1000000 in
/-- **`ad(φ_j)` IS SKEW as a matrix on `Λ²`**, which is what makes the commutator below symmetric.
*The bracket is antisymmetric and the `Λ²` pairing is symmetric, so the matrix of `ad` in an
orthonormal basis is skew.* -/
theorem adMat_isSkew (j : Fin 6) : (adMat j)ᵀ = -adMat j := by
  ext a b
  fin_cases j <;> fin_cases a <;> fin_cases b <;>
    simp [adMat, Matrix.transpose_apply, Matrix.of_apply, Matrix.neg_apply, coord4, basis4,
      pair4, br, phi, Matrix.sub_apply, Matrix.mul_apply, Matrix.single_apply, Fin.sum_univ_four,
      Fin.isValue]

/-- **`[ad(φ_j), R]` IS SYMMETRIC at a symmetric `R`**, and this is the step that makes `Gmat`'s
diagonal a square of a symmetric matrix rather than a general Frobenius pairing.

*`(AR - RA)ᵀ = RᵀAᵀ - AᵀRᵀ = -RA + AR` when `Aᵀ = -A` and `Rᵀ = R`.* **THE CONSEQUENCE IS THE
ROUTE TO `trace_Gmat`**: `‖[A,R]‖² = tr([A,R]²) = 2 tr(ARAR) - 2 tr(A²R²)`, so summing over `j`
reduces the claim to two STRUCTURE SUMS, `Σ_j ad(φ_j)²` and `Σ_j ad(φ_j) X ad(φ_j)`, rather than to
a polynomial identity in the thirty-six entries of `R`. *Expanding that identity directly is on the
order of thirty thousand terms for `ring`, which is the shape that exhausts memory.* -/
theorem adComm_isSymm (j : Fin 6) {R : Matrix (Fin 6) (Fin 6) ℚ} (hR : R.IsSymm) :
    (adComm j R).IsSymm := by
  have hA : (adMat j)ᵀ = -adMat j := adMat_isSkew j
  have hRt : Rᵀ = R := hR
  unfold Matrix.IsSymm adComm
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hA, hRt,
    Matrix.neg_mul, Matrix.mul_neg, neg_sub_neg]

/-! ## The structure-constant route to `G_eq_sharp`

*Everything below is abstract in the structure constants `cc x y z` of `Λ²ℝ⁴`, used only through
their antisymmetry in the last two slots (`adMat_isSkew`).* `sharpQF_K` writes `#` as a quadratic
form with kernel `K`, `sharpMat_eq` identifies it with `sb R R` at symmetric `R`, and `sharpBil_eq`
polarises. No step expands a polynomial in the entries of `R`. -/

namespace G199

/-- The structure constants of `Λ²ℝ⁴`: `[φ_x, φ_y] = Σ_z cc x y z φ_z`. -/
def cc (x y z : Fin 6) : ℚ := adMat x z y

theorem cc_skew (x y z : Fin 6) : cc x y z = -cc x z y := by
  have := congrFun (congrFun (adMat_isSkew x) y) z
  simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
  unfold cc; linarith

theorem br_toMat4 (u w : Fin 6 → ℚ) :
    br (toMat4 u) (toMat4 w) = ∑ x, ∑ y, (u x * w y) • br (basis4 x) (basis4 y) := by
  have h1 : toMat4 u * toMat4 w = ∑ x, ∑ y, (u x * w y) • (basis4 x * basis4 y) := by
    simp only [toMat4, Finset.sum_mul, Finset.mul_sum, Matrix.smul_mul, Matrix.mul_smul, smul_smul]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by rw [mul_comm]
  have h2 : toMat4 w * toMat4 u = ∑ x, ∑ y, (u x * w y) • (basis4 y * basis4 x) := by
    simp only [toMat4, Finset.sum_mul, Finset.mul_sum, Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  unfold br
  rw [h1, h2, ← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun x _ => by
    rw [← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun y _ => by rw [smul_sub]

theorem coord4_br (u w : Fin 6 → ℚ) :
    coord4 (br (toMat4 u) (toMat4 w)) = fun z => ∑ x, ∑ y, u x * w y * cc x y z := by
  funext z
  rw [br_toMat4]
  simp only [coord4, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, cc, adMat, Matrix.of_apply]

/-- The `#` quadratic form's kernel. -/
def K (R : Matrix (Fin 6) (Fin 6) ℚ) (v x : Fin 6) : ℚ :=
  -(1 / 2) * ∑ i, ∑ u, ∑ z, ∑ y, R u z * R y i * cc x y z * cc v u i

theorem sharpQF_K (R : Matrix (Fin 6) (Fin 6) ℚ) (η : Fin 6 → ℚ) :
    sharpQF R η = ∑ v, ∑ x, η v * η x * K R v x := by
  unfold sharpQF K
  simp only [coord4_br, Matrix.mulVec, dotProduct, Pi.single_apply, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]
  simp only [Finset.mul_sum, Finset.sum_mul]
  symm
  refine Eq.trans ?_ Finset.sum_comm
  refine Finset.sum_congr rfl fun v _ => ?_
  refine Finset.sum_comm.trans ?_
  refine Finset.sum_congr rfl fun i _ => ?_
  refine Finset.sum_comm.trans ?_
  refine Finset.sum_congr rfl fun u _ => ?_
  refine Finset.sum_comm.trans ?_
  exact Finset.sum_congr rfl fun z _ => Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by ring

theorem reindex {ι : Type*} [Fintype ι] (f g : ι → ι → ι → ι → ℚ) (c : ℚ) (σ : ι × ι × ι × ι ≃ ι × ι × ι × ι)
    (h : ∀ a b c' d, f a b c' d
      = c * g (σ (a, b, c', d)).1 (σ (a, b, c', d)).2.1 (σ (a, b, c', d)).2.2.1 (σ (a, b, c', d)).2.2.2) :
    ∑ a, ∑ b, ∑ c', ∑ d, f a b c' d = c * ∑ a, ∑ b, ∑ c', ∑ d, g a b c' d := by
  have e : ∀ F : ι → ι → ι → ι → ℚ,
      ∑ a, ∑ b, ∑ c', ∑ d, F a b c' d = ∑ p : ι × ι × ι × ι, F p.1 p.2.1 p.2.2.1 p.2.2.2 := by
    intro F; simp only [Fintype.sum_prod_type]
  rw [e f, e g, Finset.mul_sum]
  exact Fintype.sum_equiv σ _ _ fun ⟨a, b, c', d⟩ => h a b c' d

/-- The bilinear `#` in structure constants. -/
def sb (A C : Matrix (Fin 6) (Fin 6) ℚ) (j k : Fin 6) : ℚ :=
  (1 / 2) * ∑ p, ∑ q, ∑ r, ∑ s, cc j p q * cc k r s * A p r * C q s

section Sym
variable {R : Matrix (Fin 6) (Fin 6) ℚ} (hs : ∀ x y, R x y = R y x)
include hs

theorem K_eq_sb (v x : Fin 6) : K R v x = sb R R v x := by
  have := reindex (fun i u z y => R u z * R y i * cc x y z * cc v u i)
    (fun p q r s => cc v p q * cc x r s * R p r * R q s) (-1)
    ⟨fun p => (p.2.1, p.1, p.2.2.1, p.2.2.2), fun p => (p.2.1, p.1, p.2.2.1, p.2.2.2),
      fun _ => rfl, fun _ => rfl⟩
    (fun i u z y => by
      show R u z * R y i * cc x y z * cc v u i = -1 * (cc v u i * cc x z y * R u z * R i y)
      rw [cc_skew x y z, hs y i]; ring)
  unfold K sb; rw [this]; ring

theorem sb_symm (j k : Fin 6) : sb R R j k = sb R R k j := by
  unfold sb
  congr 1
  exact reindex (fun p q r s => cc j p q * cc k r s * R p r * R q s)
    (fun p q r s => cc k p q * cc j r s * R p r * R q s) 1
    ⟨fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1),
      fun _ => rfl, fun _ => rfl⟩
    (fun p q r s => by
      show cc j p q * cc k r s * R p r * R q s = 1 * (cc k r s * cc j p q * R r p * R s q)
      rw [hs r p, hs s q]; ring) |>.trans (by ring)

theorem sharpMat_eq : sharpMat R = Matrix.of (sb R R) := by
  ext a b
  unfold sharpMat
  simp only [Matrix.of_apply, sharpQF_K, K_eq_sb hs]
  split_ifs with h
  · subst h
    simp [Pi.single_apply]
  · simp [Pi.single_apply, Pi.add_apply, add_mul, mul_add, Finset.sum_add_distrib, ite_mul, mul_ite, h,
      Ne.symm h]
    rw [sb_symm hs b a]; ring

end Sym

theorem sharpBil_eq {A C : Matrix (Fin 6) (Fin 6) ℚ} (hA : ∀ x y, A x y = A y x)
    (hC : ∀ x y, C x y = C y x) (j k : Fin 6) :
    sharpBil A C j k = (1 / 2) * (sb A C j k + sb C A j k) := by
  have hAC : ∀ x y, (A + C) x y = (A + C) y x := fun x y => by
    simp only [Matrix.add_apply, hA x y, hC x y]
  unfold sharpBil
  simp only [Matrix.of_apply, sharpMat_eq hAC, sharpMat_eq hA, sharpMat_eq hC]
  unfold sb
  simp only [Matrix.add_apply, mul_add, add_mul, Finset.sum_add_distrib]
  ring

end G199

open G199 in
/-- **L199, the operator form.** For every symmetric `R` on `Λ²ℝ⁴`,
`G = 4(R² # I) - 4(R # R)`.

**PROVED 2026-09-24, by structure constants rather than by evaluation.** *Three attempts to price
a whole-matrix check failed on the cost of unfolding `sharpMat` through `sharpBil`
([r1044](../../../reviews/REVIEW_r1044.md), [r1046](../../../reviews/REVIEW_r1046.md)); the proof
never evaluates `sharpMat` at all.* `Gmat`'s trace splits into four sums, and each is a relabelling
of `2·sb(R², I)`, `2·sb(I, R²)` or `-2·sb(R, R)` using only `R`'s symmetry. **The symmetry is
needed**: a screen at three random symmetric `R` gave defects near `10⁻¹²` against entries near
`260`, and at non-symmetric `R` the identity fails by order `100`. -/
theorem G_eq_sharp (R : Matrix (Fin 6) (Fin 6) ℚ) (_hR : R.IsSymm) :
    Gmat R = Matrix.of fun j k => 4 * sharpBil (R * R) 1 j k - 4 * sharpMat R j k := by
  have hR := _hR
  have hs : ∀ x y, R x y = R y x := fun x y => by
    have := congrFun (congrFun hR y) x; simpa [Matrix.transpose_apply] using this
  have hS : ∀ x y, (R * R) x y = (R * R) y x := fun x y => by
    simp only [Matrix.mul_apply]
    exact Finset.sum_congr rfl fun t _ => by rw [hs x t, hs t y]; ring
  have h1 : ∀ x y, (1 : Matrix (Fin 6) (Fin 6) ℚ) x y = (1 : Matrix (Fin 6) (Fin 6) ℚ) y x := fun x y => by
    simp only [Matrix.one_apply, eq_comm]
  ext j k
  simp only [Matrix.of_apply, sharpBil_eq hS h1, sharpMat_eq hs]
  unfold sb
  simp only [Matrix.one_apply, Matrix.mul_apply]
  unfold Gmat adComm
  simp only [Matrix.of_apply, Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Matrix.sub_apply]
  have hU1 : ∑ p, ∑ q, ∑ r, ∑ s, (cc j p q * cc k r s * ∑ t, R p t * R t r) * (if q = s then (1 : ℚ) else 0)
      = ∑ p, ∑ q, ∑ r, ∑ t, cc j p q * cc k r q * (R p t * R t r) := by
    simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.mul_sum]
  have hU2 : ∑ p, ∑ q, ∑ r, ∑ s, (cc j p q * cc k r s * (if p = r then (1 : ℚ) else 0)) * ∑ t, R q t * R t s
      = ∑ p, ∑ q, ∑ s, ∑ t, cc j p q * cc k p s * (R q t * R t s) := by
    simp only [mul_ite, ite_mul, mul_one, mul_zero, zero_mul, Finset.sum_ite_irrel, Finset.sum_const_zero,
      Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.mul_sum]
  have hG0 : ∑ a, ∑ b, (∑ x, adMat j b x * R x a - ∑ x, R b x * adMat j x a) *
        (∑ y, adMat k b y * R y a - ∑ y, R b y * adMat k y a)
      = ∑ a, ∑ b, ∑ x, ∑ y, (cc j x b * R x a * (cc k y b * R y a)
          + -(cc j x b * R x a * (R b y * cc k a y)) + -(R b x * cc j a x * (cc k y b * R y a))
          + R b x * cc j a x * (R b y * cc k a y)) := by
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib, Finset.sum_mul_sum]
    exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by unfold cc; ring
  have e1 := reindex (fun a b x y => cc j x b * R x a * (cc k y b * R y a))
    (fun p q r t => cc j p q * cc k r q * (R p t * R t r)) 1
    ⟨fun p => (p.2.2.1, p.2.1, p.2.2.2, p.1), fun p => (p.2.2.2, p.2.1, p.1, p.2.2.1),
      fun _ => rfl, fun _ => rfl⟩
    (fun a b x y => by
      show cc j x b * R x a * (cc k y b * R y a) = 1 * (cc j x b * cc k y b * (R x a * R a y))
      rw [hs y a]; ring)
  have e2 := reindex (fun a b x y => -(cc j x b * R x a * (R b y * cc k a y)))
    (fun p q r s => cc j p q * cc k r s * R p r * R q s) (-1)
    ⟨fun p => (p.2.2.1, p.2.1, p.1, p.2.2.2), fun p => (p.2.2.1, p.2.1, p.1, p.2.2.2),
      fun _ => rfl, fun _ => rfl⟩
    (fun a b x y => by
      show -(cc j x b * R x a * (R b y * cc k a y)) = -1 * (cc j x b * cc k a y * R x a * R b y)
      ring)
  have e3 := reindex (fun a b x y => -(R b x * cc j a x * (cc k y b * R y a)))
    (fun p q r s => cc j p q * cc k r s * R p r * R q s) (-1)
    ⟨fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1), fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1),
      fun _ => rfl, fun _ => rfl⟩
    (fun a b x y => by
      show -(R b x * cc j a x * (cc k y b * R y a)) = -1 * (cc j a x * cc k y b * R a y * R x b)
      rw [hs y a, hs b x]; ring)
  have e4 := reindex (fun a b x y => R b x * cc j a x * (R b y * cc k a y))
    (fun p q s t => cc j p q * cc k p s * (R q t * R t s)) 1
    ⟨fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1), fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1),
      fun _ => rfl, fun _ => rfl⟩
    (fun a b x y => by
      show R b x * cc j a x * (R b y * cc k a y) = 1 * (cc j a x * cc k a y * (R x b * R b y))
      rw [hs b x]; ring)
  rw [hG0, hU1, hU2]
  simp only [Finset.sum_add_distrib]
  rw [e1, e2, e3, e4]
  ring


/-! ### The reduction the route needs, typed

*The docstring above names it and no declaration carried it.* **It is trace cyclicity and nothing
else**, so it holds at every size and touches no entry: the thirty-thousand-term expansion the file
warns about is what this avoids. -/

/-- **At skew `A` and symmetric `R` the commutator is symmetric**, stated at a general size so the
reduction below is about the algebra rather than about `Fin 6`. -/
theorem comm_isSymm_gen {m : ℕ} {A R : Matrix (Fin m) (Fin m) ℚ} (hA : Aᵀ = -A) (hR : Rᵀ = R) :
    (A * R - R * A)ᵀ = A * R - R * A := by
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hA, hR,
    Matrix.neg_mul, Matrix.mul_neg, neg_sub_neg]

/-- **THE REDUCTION**: `‖[A,R]‖² = 2 tr(ARAR) - 2 tr(A²R²)`.

*Summed over `j` this turns `tr(Gmat R)` into the two STRUCTURE SUMS `Σ_j ad(φ_j)²` and
`Σ_j ad(φ_j) R ad(φ_j) R`, neither of which mentions an entry of `R`.* -/
theorem trace_comm_sq {m : ℕ} {A R : Matrix (Fin m) (Fin m) ℚ} (hA : Aᵀ = -A) (hR : Rᵀ = R) :
    ((A * R - R * A)ᵀ * (A * R - R * A)).trace
      = 2 * (A * R * (A * R)).trace - 2 * (A * A * (R * R)).trace := by
  rw [comm_isSymm_gen hA hR]
  have e : (A * R - R * A) * (A * R - R * A)
      = A * R * (A * R) - A * R * (R * A) - R * A * (A * R) + R * A * (R * A) := by
    noncomm_ring
  have h1 : (R * A * (R * A)).trace = (A * R * (A * R)).trace := by
    rw [show R * A * (R * A) = R * (A * R * A) by noncomm_ring, Matrix.trace_mul_comm,
      show A * R * A * R = A * R * (A * R) by noncomm_ring]
  -- `tr(RRAA) = tr(AARR)` is a CYCLIC identity and not a ring one, so it takes a second
  -- `trace_mul_comm` rather than a `noncomm_ring` step that would be false as an equation.
  have h2 : (A * R * (R * A)).trace = (A * A * (R * R)).trace := by
    rw [show A * R * (R * A) = A * (R * R * A) by noncomm_ring, Matrix.trace_mul_comm,
      show R * R * A * A = (R * R) * (A * A) by noncomm_ring, Matrix.trace_mul_comm]
  have h3 : (R * A * (A * R)).trace = (A * A * (R * R)).trace := by
    rw [show R * A * (A * R) = R * (A * A * R) by noncomm_ring, Matrix.trace_mul_comm,
      show A * A * R * R = A * A * (R * R) by noncomm_ring]
  rw [e, Matrix.trace_add, Matrix.trace_sub, Matrix.trace_sub, h1, h2, h3]
  ring

/-! ### The first moment is NOT a statement about every symmetric `R`

**AN EARLIER VERSION OF THIS FILE TYPED `tr(Gmat R) = 12 tr(RᵀR)` AT EVERY SYMMETRIC `R`, AND THAT
IS FALSE.** *Evaluated in this file's own definitions over `ℚ`:*

| `R` | `tr(Gmat R)` | `12 tr(RᵀR)` |
|---|---|---|
| `diagonal ![1,0,0,0,0,0]` | `8` | `12` |
| `diagonal ![1,1,0,0,0,0]` | `12` | `24` |
| `diagonal ![1,2,3,0,0,0]` | `68` | `168` |

*The ratios differ, so this is not a lost normalisation.* **The record never claimed it at that
generality**: [bounds.md](../../../findings/bounds.md)'s L199 block calls the two moments
`Σ_k g_k = 4(n-1)‖W‖²` and `Σ_k λ_k g_k = -4P(W)` *"checks at a Weyl tensor rather than at the
statement's full generality"*, and says they consume relation (B). **The operator identity
`G_eq_sharp` is the one that holds with no hypothesis**; the moment is its contraction against
objects the Weyl conditions constrain.

*The unused `_hR` binder was the visible tell: a hypothesis nobody needed because nobody had
attempted the proof.*

**AND THE REPAIR WAS AVAILABLE ALL ALONG, IN THIS FILE'S ONLY IMPORT.** *A first version of this
paragraph said the Weyl conditions "are not in this file", which is false*: `IsWeyl` is
`R.IsSymm ∧ IsBianchi R ∧ IsRicciFlat R` in [Base/Sharp.lean](../Base/Sharp.lean), at this file's
own type, and the header docstring above says so in as many words. **The header and the withdrawal
note contradicted each other inside one file and the header was right**
([r1044](../../../reviews/REVIEW_r1044.md)).

**THE DEFICIT IS A SUM OF SQUARES AND THE WEYL CONDITIONS ARE ITS EQUALITY LOCUS.** Writing `R` in a
basis adapted to `Λ²₊ ⊕ Λ²₋` with mixed block `B`,
`tr(Gmat R) = 12‖R‖² - 2(tr R)² - 8(R₀₅ - R₁₄ + R₂₃)² - 8‖B‖²`,
*verified on forty random symmetric `R` over `ℚ` against this file's own `adMat`.* **So
`tr(Gmat R) ≤ 12 tr(RᵀR)` holds at EVERY symmetric `R` with no hypothesis**, the three
counterexamples above are the three deficits, and equality is exactly trace-free plus first Bianchi
plus `B = 0`, which is `IsWeyl`. *The mismatch was a lost scalar-curvature term and a lost Ricci
term, not a lost normalisation.* -/

set_option maxHeartbeats 8000000 in
/-- **THE FIRST MOMENT, WITH THE HYPOTHESIS IT NEEDS.** `Σ_k g_k = 4(n-1)‖W‖²` at `n = 4`.

**Screened before being typed**, at the rational Weyl tensor
`!![6,2,1,3,2,-4; 2,-1,1,1,-5,-2; 1,1,-5,-1,-1,3; 3,1,-1,-5,-1,1; 2,-5,-1,-1,-1,-2; -4,-2,3,1,-2,6]`,
which meets every clause of `IsWeyl`: `tr(Gmat W) = 3456` against `12 tr(WᵀW) = 12 * 288 = 3456`.
*The right side was checked by hand here, the left in the layer's own definitions.*

**PROVED by an exact certificate**: `tr(Gmat R) - 12 tr(RᵀR)` is the combination
`(8R₁₄ - 8R₀₅ - 8R₂₃)·Bianchi + Σ L_{ab}·Ric_{ab}` of the Weyl conditions with explicit linear forms
`L_{ab}`, found by exact linear algebra over `ℚ` and checked here by `linear_combination`. -/
theorem trace_Gmat_weyl (R : Matrix (Fin 6) (Fin 6) ℚ) (hR : IsWeyl R) :
    (Gmat R).trace = (12 : ℚ) * (Rᵀ * R).trace := by
  obtain ⟨hsym, hB, hRic⟩ := hR
  have s : ∀ i j, R j i = R i j := fun i j => hsym.apply i j
  have h00 := hRic 0 0
  have h01 := hRic 0 1
  have h02 := hRic 0 2
  have h03 := hRic 0 3
  have h11 := hRic 1 1
  have h12 := hRic 1 2
  have h13 := hRic 1 3
  have h22 := hRic 2 2
  have h23 := hRic 2 3
  have h33 := hRic 3 3
  unfold IsBianchi at hB
  simp only [Ric, toMat4, coord4, basis4, pair4, br, phi, inner2, Matrix.mul_apply, Matrix.single,
    Matrix.mulVec, dotProduct, Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.trace, Matrix.diag,
    Matrix.transpose_apply, Matrix.sum_apply] at h00 h01 h02 h03 h11 h12 h13 h22 h23 h33
  norm_num [Fin.ext_iff] at h00 h01 h02 h03 h11 h12 h13 h22 h23 h33
  unfold Gmat adComm adMat
  simp only [coord4, basis4, pair4, br, phi, Matrix.mul_apply, Matrix.single, Fin.sum_univ_six,
    Fin.sum_univ_four, Matrix.sub_apply, Matrix.of_apply, Matrix.trace, Matrix.diag, Matrix.transpose_apply,
    Fin.isValue]
  norm_num [Fin.ext_iff]
  rw [s 0 1, s 0 2, s 0 3, s 0 4, s 0 5, s 1 2, s 1 3, s 1 4, s 1 5, s 2 3, s 2 4, s 2 5, s 3 4, s 3 5, s 4 5] at *
  linear_combination (-8 * R 2 3 - 8 * R 0 5 + 8 * R 1 4) * hB
    + (-4 * (R 0 0 + R 2 2 + R 3 3 + R 4 4 + R 5 5 + R 1 1)) * h00
    + (-4 * R 2 4 - 4 * R 1 3) * h01 + (-4 * R 2 5 + 4 * R 0 3) * h02 + (4 * R 1 5 + 4 * R 0 4) * h03
    + (-4 * (R 3 3 + R 4 4 + R 5 5)) * h11 + (-4 * R 0 1 - 4 * R 4 5) * h12
    + (4 * R 3 5 - 4 * R 0 2) * h13 + (4 * R 0 0 - 4 * R 5 5) * h22 + (-4 * R 3 4 - 4 * R 1 2) * h23
    + (4 * R 0 0 + 4 * R 3 3 + 4 * R 1 1) * h33

/-- The hypotheses are inhabited, so nothing above is vacuous: the record's own
`diagTest` is symmetric, and its `G` is nonzero. -/
theorem diagTest_isSymm : (diagTest : Matrix (Fin 6) (Fin 6) ℚ).IsSymm :=
  Matrix.diagonal_transpose _

/-- `tr(AᵀA)` is the Frobenius square, `Σ_j Σ_i A i j ^ 2`. *Mathlib carries `trace_transpose_mul`
and no lemma for this shape, so it is written here.* -/
theorem trace_transpose_mul_self (A : Matrix (Fin 6) (Fin 6) ℚ) :
    (Aᵀ * A).trace = ∑ b, ∑ a, A a b ^ 2 := by
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, sq]

/-- **`Gmat`'s diagonal is a sum of squares**, at EVERY `R` and every `j`, with no hypothesis. -/
theorem Gmat_diag_eq_sum_sq (R : Matrix (Fin 6) (Fin 6) ℚ) (j : Fin 6) :
    Gmat R j j = ∑ b, ∑ a, (adComm j R) a b ^ 2 := by
  simp only [Gmat, Matrix.of_apply]
  exact trace_transpose_mul_self _

/-- **`Gmat R` is nonzero as soon as ONE commutator is**, at every `R`.

*This is what replaces a compiled evaluation of all thirty-six entries: a matrix is nonzero when
one entry is, and `Gmat`'s diagonal entry vanishes exactly when its whole commutator does.* -/
theorem Gmat_ne_zero_of_adComm_ne_zero (R : Matrix (Fin 6) (Fin 6) ℚ) (j : Fin 6)
    (h : adComm j R ≠ 0) : Gmat R ≠ 0 := by
  intro hG
  apply h
  have hjj : Gmat R j j = 0 := by rw [hG]; rfl
  rw [Gmat_diag_eq_sum_sq] at hjj
  have houter : ∀ b' ∈ Finset.univ, (0:ℚ) ≤ ∑ a', (adComm j R) a' b' ^ 2 :=
    fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _
  ext a b
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg houter).mp hjj b (Finset.mem_univ b)
  have h3 : ∀ a' ∈ Finset.univ, (0:ℚ) ≤ (adComm j R) a' b ^ 2 := fun _ _ => sq_nonneg _
  have h4 := (Finset.sum_eq_zero_iff_of_nonneg h3).mp h2 a (Finset.mem_univ a)
  simpa using (pow_eq_zero_iff two_ne_zero).mp h4

set_option maxHeartbeats 1000000 in
/-- `[ad(φ₀), diagTest]` is nonzero, witnessed at ONE entry: `(1,3)` is `-2`.

*A commutator with a diagonal has entry `adMat j a b * (d b - d a)`, so any `adMat` entry off
the diagonal of a `diagTest` with distinct entries witnesses this.* -/
theorem adComm_zero_diagTest_ne_zero :
    adComm 0 (diagTest : Matrix (Fin 6) (Fin 6) ℚ) ≠ 0 := by
  intro h
  have e : (adComm 0 (diagTest : Matrix (Fin 6) (Fin 6) ℚ)) 1 3 = 0 := by rw [h]; rfl
  simp [adComm, adMat, diagTest, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
    Matrix.of_apply, Matrix.sub_apply, Matrix.single_apply, Matrix.diagonal,
    Fin.sum_univ_four, Fin.isValue] at e
  norm_num at e

/-- **The hypotheses are inhabited and `Gmat diagTest` is nonzero**, by ONE commutator entry
rather than by evaluating all thirty-six.

*This retires the file's first `native_decide`: the route is `Gmat_ne_zero_of_adComm_ne_zero`,
which holds at every `R`, together with the single entry above.* -/
theorem Gmat_diagTest_ne_zero : Gmat diagTest ≠ 0 :=
  Gmat_ne_zero_of_adComm_ne_zero diagTest 0 adComm_zero_diagTest_ne_zero

set_option maxHeartbeats 1000000 in
/-- **`Gmat diagTest 0 0 = 16`, from the sum of squares rather than from a trace.**

*`[ad(φ₀), diagTest]` has exactly four nonzero entries, each `-2`, so the Frobenius square is
`4 x 4`. This is the expensive half of the identity below, and it costs one commutator here
instead of a trace of a `6x6` product.* -/
theorem Gmat_diagTest_00_eq : Gmat diagTest 0 0 = 16 := by
  rw [Gmat_diag_eq_sum_sq]
  simp [adComm, adMat, diagTest, coord4, basis4, pair4, br, phi, Matrix.mul_apply,
    Matrix.of_apply, Matrix.sub_apply, Matrix.single_apply, Matrix.diagonal,
    Fin.sum_univ_six, Fin.sum_univ_four, Fin.isValue]
  norm_num

set_option maxHeartbeats 2000000 in
-- reason: `sharpMat` at a general diagonal unfolds through `Fin.sum_univ_six` twice.
/-- **`sharpMat` at a DIAGONAL argument, entry `(0,0)`.** It is `d 1 * d 3 + d 2 * d 4`.

*The pair `(0,1)` has index `0` and the complementary index runs over `2, 3`, the reading
[Sharp.lean](../Base/Sharp.lean)'s `Qop_diagTest_00` docstring already carries. Stated at a general
`d`, so the four entries the identity below needs become arithmetic rather than four expansions.* -/
theorem sharpMat_diagonal_00 (d : Fin 6 → ℚ) :
    sharpMat (Matrix.diagonal d) 0 0 = d 1 * d 3 + d 2 * d 4 := by
  simp (config := { maxSteps := 4000000 }) only [sharpMat, sharpQF, toMat4, coord4, basis4,
    pair4, br, phi, Matrix.mul_apply, Matrix.single, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.diagonal,
    Fin.ext_iff]
  norm_num [Fin.ext_iff]
  ring

theorem diagTest_sq : (diagTest * diagTest : Matrix (Fin 6) (Fin 6) ℚ)
    = Matrix.diagonal ![1, 4, 9, 16, 25, 36] := by
  rw [diagTest, Matrix.diagonal_mul_diagonal]
  congr 1; funext i; fin_cases i <;> norm_num

theorem one_as_diagonal : (1 : Matrix (Fin 6) (Fin 6) ℚ) = Matrix.diagonal ![1,1,1,1,1,1] := by
  rw [← Matrix.diagonal_one]; congr 1; funext i; fin_cases i <;> rfl

theorem diagTest_sq_add_one : (diagTest * diagTest + 1 : Matrix (Fin 6) (Fin 6) ℚ)
    = Matrix.diagonal ![2, 5, 10, 17, 26, 37] := by
  rw [diagTest_sq, one_as_diagonal, Matrix.diagonal_add]
  congr 1; funext i; fin_cases i <;> norm_num

/-- **The identity's `(0,0)` entry, and the last `native_decide` in this file is retired.**

*The left side is `16` by `Gmat_diagTest_00_eq`, from four commutator entries. The right side is
four `sharpMat` entries at diagonal arguments, which `sharpMat_diagonal_00` makes arithmetic:
`23`, `289`, `2` and `345`, giving `4 · ½ (345 - 289 - 2) - 4 · 23 = 16`.* **Two routes sharing
nothing meet at the same number**, which is the cross-check this file's history records as absent. -/
theorem G_eq_sharp_diagTest_00 :
    Gmat diagTest 0 0 = 4 * sharpBil (diagTest * diagTest) 1 0 0 - 4 * sharpMat diagTest 0 0 := by
  rw [Gmat_diagTest_00_eq, sharpBil]
  simp only [Matrix.of_apply]
  rw [diagTest_sq_add_one, diagTest_sq, one_as_diagonal, diagTest,
    sharpMat_diagonal_00, sharpMat_diagonal_00, sharpMat_diagonal_00, sharpMat_diagonal_00]
  have a2 : (![2,5,10,17,26,37] : Fin 6 → ℚ) 2 = 10 := rfl
  have a3 : (![2,5,10,17,26,37] : Fin 6 → ℚ) 3 = 17 := rfl
  have a4 : (![2,5,10,17,26,37] : Fin 6 → ℚ) 4 = 26 := rfl
  have b2 : (![1,4,9,16,25,36] : Fin 6 → ℚ) 2 = 9 := rfl
  have b3 : (![1,4,9,16,25,36] : Fin 6 → ℚ) 3 = 16 := rfl
  have b4 : (![1,4,9,16,25,36] : Fin 6 → ℚ) 4 = 25 := rfl
  have c2 : (![1,1,1,1,1,1] : Fin 6 → ℚ) 2 = 1 := rfl
  have c3 : (![1,1,1,1,1,1] : Fin 6 → ℚ) 3 = 1 := rfl
  have c4 : (![1,1,1,1,1,1] : Fin 6 → ℚ) 4 = 1 := rfl
  have e2 : (![1,2,3,4,5,6] : Fin 6 → ℚ) 2 = 3 := rfl
  have e3 : (![1,2,3,4,5,6] : Fin 6 → ℚ) 3 = 4 := rfl
  have e4 : (![1,2,3,4,5,6] : Fin 6 → ℚ) 4 = 5 := rfl
  rw [a2, a3, a4, b2, b3, b4, c2, c3, c4, e2, e3, e4]
  norm_num

end HamiltonsCubic.Results
