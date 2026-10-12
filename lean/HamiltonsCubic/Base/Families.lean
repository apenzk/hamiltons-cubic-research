import HamiltonsCubic.Base.WeylReal

/-!
# The named families over `ℝ`: the diagonal locus, `S^p × S^q`, `W_{ℂP²}`, and the two constants

**Why this file exists.** [WeylReal.lean](WeylReal.lean) states Problem P with the competitor left
as an abstract predicate `IsSphereProduct`, "because the layer does not construct the family, so
this is the shape of the problem and not a theorem about a named object". This file constructs the
family, so the predicate becomes a definition and the statement becomes a statement about a named
object.

**What is built.**

* The **diagonal locus** as an operator: a symmetric hollow weight `w` on the edges of `Kₙ` acts on
  `Λ²` by `X ↦ w ∘ X` (Hadamard). Every such operator satisfies first Bianchi with no hypothesis,
  and is a Weyl operator exactly when the row sums vanish.
* The **sphere product** `S^p × S^q` as the two-block weight, and `IsSphereProduct` from it.
* The two constants, kept apart: **`θ₀(n)² = 2(n-1)(n-2)/n²`** and **`Θₙ`**.
* **`W_{ℂP²}`** over `ℝ` at `n = 4`, with its `Λ²` spectrum `(2,-1,-1,0,0,0)` and `‖W‖² = 6`.

**`θ₀(n)` and `Θₙ` are different constants.** *`θ₀(n)` is the value of the balanced split
`S^{n/2} × S^{n/2}`, and it is what the Böhm–Wilking invariance criterion demands at **both**
parities, [problem.md](../../../findings/problem.md)'s Lemma L43, where the constant is `c(n-1)`
forced by `‖I‖² = binom n 2`, no step of it parity-dependent.* **`Θₙ` is the sphere-product
maximum, which is what the conjecture concludes at**, `Θₙ = θ₀(n)` at even `n`, and
`Θₙ² = 2(n-1)(n-3)/((n-2)(n+1))` at odd `n`, strictly below `θ₀(n)²` there. The record's own words:
*"a bound read off `θ₀` at odd `n` describes no object"*. The gap is
`θ₀(n)² - Θₙ² = 8(n-1)/(n²(n+1)(n-2))`, and its numerator-`4` identity is proved below.

**Normalisation.** `inner2` carries the `½`, and every statement here is read under that convention
`‖φᵢⱼ‖² = 1`, so `{φᵢⱼ}_{i<j}` is orthonormal and `innerOp`'s ordered-pair doubling makes
`normSq` the ordinary Frobenius square of the operator on `Λ²`. This is the convention
[WeylReal.lean](WeylReal.lean) fixes and the one the record's proofs use; reading `θ` under plain
Frobenius on the `φ` basis would inflate it by `√2`.

## What the record does not define, and the reading taken here

**The record fixes the sphere-product weight up to scale and no further.**
[diagonal-half.md](../../../findings/diagonal-half.md) writes the balanced weight as `1/(p(p-1))`
inside the blocks and `-1/(pq)` across; that weight is neither unit-norm under `normSq` nor the
Riemannian curvature of any one metric the record pins. Since `θ = P/‖·‖³` is scale-invariant, the
family is defined here **up to a nonzero scale**, with the cross-block entry normalised to `-1`;
`sphereWeight S` is `p·q` times the record's weight, and `IsSphereProduct` quantifies over the
scale so that the unit-norm member Problem P's existential asks for is inside it. *That
`exists_unit_sphereProduct` produces the unit-norm member is what makes the quantification enough;
homogeneity of `θ` itself is not typed here and is not needed, since `Pcubic` is homogeneous only
for linear `R` and `IsWeyl` carries no linearity clause, the same gap
[WeylReal.lean](WeylReal.lean) records against `sharpOp`.*

**The unbalanced weight is the record's balanced formula continued.** The record prints the
in-block entries only at `p = q`. The general two-block Ricci-flat weight is forced: zero row sums
give `α = q/(p-1)` and `β = p/(q-1)` once `γ = -1`, and at `p = q` that is the record's. *`p, q ≥ 2`
is what makes the weight defined at all, and it is carried as a hypothesis rather than assumed.*

## What is owed, and it is named rather than `sorry`-ed

* **`P(W)` at either family.** `Pcubic` runs through `sharpOp`, and neither `θ = θ_{p,q}` at the
  sphere product nor `P = 18` at `W_{ℂP²}` is proved here. What is proved is everything the value
  is read off: that each object is a Weyl operator, its `Λ²` spectrum, and its norm. The `θ` claim
  is then stated as an implication from the `P` value, so a later cycle discharging `P` gets `θ`
  with no further work. **Over `ℚ` at `n = 4` the `P` value is already discharged**, `CP2.lean`'s
  `WCP2_theta_sq`, by `native_decide` in the pair basis.
* **First Bianchi at `W_{ℂP²}`.** The obstruction is the `Λ⁴` component, which for a self-dual
  operator is the trace over `Λ⁺`, here `2 - 1 - 1 = 0`; `CP2.lean` discharges it over `ℚ`. The
  `Λ⁴` identity is not typed here, so `WCP2` is given its symmetry and Ricci clauses and the
  Bianchi clause is taken as a hypothesis where it is needed.
-/

set_option linter.style.longLine false
set_option maxHeartbeats 1000000

namespace HamiltonsCubic.FamilyLayer

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable section

/-! ## Small facts about `inner2` and `φ` that the record's own file did not need -/

/-- **`⟨φᵢⱼ, φₖₗ⟩ = δᵢₖδⱼₗ - δⱼₖδᵢₗ`**, the Gram matrix of the basis bivectors. *Under
[WeylReal.lean](WeylReal.lean)'s `½`, `‖φᵢⱼ‖² = 1` at `i ≠ j`, so `{φᵢⱼ}_{i<j}` is orthonormal.* -/
theorem inner2_phi_phi (i j k l : ι) :
    inner2 (phi i j) (phi k l)
      = (if i = k ∧ j = l then (1:ℝ) else 0) - (if j = k ∧ i = l then (1:ℝ) else 0) := by
  rw [inner2_phi _ (phi_isSkew i j) k l]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, neg_sub]

theorem inner2_self_phi (i j : ι) (h : i ≠ j) : inner2 (phi i j) (phi i j) = 1 := by
  rw [inner2_phi_phi]
  simp [h, Ne.symm h]

theorem inner2_smul_left (c : ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (c • X) Y = c * inner2 X Y := by
  simp only [inner2_eq_sum, Matrix.smul_apply, smul_eq_mul]
  have h : ∀ a : ι, ∑ b : ι, c * X a b * Y a b = c * ∑ b : ι, X a b * Y a b := by
    intro a
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => by ring
  simp only [h, ← Finset.mul_sum]
  ring

theorem inner2_smul_right (c : ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 X (c • Y) = c * inner2 X Y := by
  rw [inner2_comm, inner2_smul_left, inner2_comm]

theorem inner2_add_left (A B X : Matrix ι ι ℝ) :
    inner2 (A + B) X = inner2 A X + inner2 B X := by
  rw [inner2_comm, inner2_add_right, inner2_comm A X, inner2_comm B X]

/-- **`innerOp` is additive in its FIRST argument**, the mirror of the record's own
`innerOp_add_right`. -/
theorem innerOp_add_left (R S T : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    innerOp (fun X => R X + S X) T = innerOp R T + innerOp S T := by
  rw [innerOp_comm, innerOp_add_right, innerOp_comm T R, innerOp_comm T S]

/-- **`Ric` is additive**, which is what lets a family be assembled from rank-one pieces. -/
theorem Ric_add (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b : ι) :
    Ric (fun X => R X + S X) a b = Ric R a b + Ric S a b := by
  unfold Ric
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun c _ => inner2_add_left _ _ _

/-- **The `φ` family resolves the pairing of two skew matrices**, with the ordered-pair doubling:
`∑_{i,j} ⟨v, φᵢⱼ⟩⟨u, φᵢⱼ⟩ = 2⟨v, u⟩`. -/
theorem sum_inner2_phi (v u : Matrix ι ι ℝ) (hv : IsSkew v) (hu : IsSkew u) :
    ∑ i : ι, ∑ j : ι, inner2 v (phi i j) * inner2 u (phi i j) = 2 * inner2 v u := by
  have h : ∀ i j : ι, inner2 v (phi i j) * inner2 u (phi i j) = v i j * u i j := by
    intro i j
    rw [inner2_phi v hv, inner2_phi u hu]; ring
  simp only [h]
  rw [inner2_eq_sum]
  ring


/-! ## The diagonal locus, as an operator on `Λ²`

*Neither [WeylReal.lean](WeylReal.lean) nor the record's Lean layer carries the diagonal locus, and
three numbered results say so under their own "What is NOT typed here": [L96](../Results/L96Statement.lean),
[L97](../Results/L97Statement.lean) and [L130](../Results/L130Statement.lean). This is it.*
-/

/-- **A weight acting on `Λ²`**: `w ∘ X` entrywise. *The record writes the diagonal locus as a
symmetric hollow matrix `w` of edge weights with `W φ_{ab} = w_{ab} φ_{ab}`; the Hadamard product
is the operator on all of `Λ²` that does that, and it is the unique linear one.* -/
def diagOp (w : Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => Matrix.of fun a b => w a b * X a b

/-- **The record's `𝒟ₙ`**: symmetric, hollow, and zero row sums.
*[diagonal-half.md](../../../findings/diagonal-half.md) states the last two as `tr M = 0` and
`M𝟙 = 0`; hollowness is the stronger of the two and is what the record actually uses.* -/
structure IsWeight (w : Matrix ι ι ℝ) : Prop where
  symm : ∀ a b, w a b = w b a
  hollow : ∀ a, w a a = 0
  rowSum : ∀ a, ∑ c : ι, w a c = 0

/-- **THE BASE LAYER'S OWED STEP, OWNED HERE SO IT IS ONE OBLIGATION.** That the matrix equation
`M^{∘2} + M² = θM` off the diagonal is `IsCritical (diagOp w) θ`, i.e. that `Q` acts on `φ_ab` by
`w_ab² + (w²)_ab`. *It needs `sharpOp` evaluated on the `φ` basis. **THAT REDUCTION IS DONE**: `diagCriticalityIsCritical`
in [SharpDiag.lean](SharpDiag.lean) proves this `Prop` outright from a single named evaluation,
`sharpOp_diagOp`, proved there. Everything else is `diagOp_phi`
applied twice.* **`rowSum` IS NOT USED BY THE BRIDGE**, so a weight with nonzero row sums still
lands in the critical locus whenever the off-diagonal equation holds.

**IT LIVES HERE BECAUSE IT IS A STATEMENT ABOUT THE BASE LAYER'S OWN OBJECTS**, and because two
Results files each defined it, identically and under their own namespaces. *A `Prop` is carried as a
hypothesis so that ONE later cycle discharging `sharpOp` discharges every consumer at once, and two
copies defeat exactly that: discharging one leaves the other's consumers gated, while a third file's
prose naming it unqualified points at neither.* -/
def DiagCriticalityIsCritical : Prop :=
  ∀ (w : Matrix ι ι ℝ) (th : ℝ), IsWeight w →
    (∀ a b, a ≠ b → w a b ^ 2 + (w * w) a b = th * w a b) → IsCritical (diagOp w) th

omit [Fintype ι] in
/-- **`W φᵢⱼ = wᵢⱼ φᵢⱼ`**, which is the sentence the record's definition of the locus is. -/
theorem diagOp_phi (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (i j : ι) :
    diagOp w (phi i j) = w i j • phi i j := by
  ext a b
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply,
    Matrix.single_apply, mul_sub, mul_ite, mul_zero, mul_one]
  congr 1
  · split_ifs with h
    · obtain ⟨rfl, rfl⟩ := h; exact hw _ _
    · rfl
  · split_ifs with h
    · obtain ⟨rfl, rfl⟩ := h; rfl
    · rfl

omit [Fintype ι] [DecidableEq ι] in
/-- **Scaling a weight scales the operator**, so the locus is a cone and `θ` is constant along it. -/
theorem diagOp_smul (t : ℝ) (w : Matrix ι ι ℝ) : diagOp (t • w) = fun X => t • diagOp w X := by
  funext X; ext a b
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul]
  ring

omit [DecidableEq ι] in
theorem IsWeight.smul {w : Matrix ι ι ℝ} (h : IsWeight w) (t : ℝ) : IsWeight (t • w) where
  symm a b := by simp only [Matrix.smul_apply, smul_eq_mul, h.symm a b]
  hollow a := by simp [Matrix.smul_apply, h.hollow a]
  rowSum a := by
    simp only [Matrix.smul_apply, smul_eq_mul, ← Finset.mul_sum, h.rowSum a, mul_zero]

/-- **EVERY diagonal operator satisfies first Bianchi**, with no hypothesis beyond symmetry of the
weight. *The three pairings the identity sums cancel term by term, because `⟨φ, φ⟩` is supported on
coincident index pairs; nothing about curvature enters.* -/
theorem diagOp_bianchi (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (i j k l : ι) :
    bianchi (diagOp w) i j k l = 0 := by
  unfold bianchi
  rw [diagOp_phi w hw, diagOp_phi w hw, diagOp_phi w hw,
    inner2_smul_left, inner2_smul_left, inner2_smul_left,
    inner2_phi_phi, inner2_phi_phi, inner2_phi_phi]
  by_cases h1 : i = k <;> by_cases h2 : j = l <;> by_cases h3 : j = k <;> by_cases h4 : i = l <;>
    by_cases h5 : i = j <;> by_cases h6 : k = l <;> subst_vars <;>
      simp_all <;> (intro h; subst h; simp_all)

/-- **The Ricci contraction of a diagonal operator is the row sum**, on the diagonal and nowhere
else. *So Ricci-flatness on the locus is exactly `w𝟙 = 0`, which is the record's second constraint
and which it names "Ricci-flatness" in the same breath.* -/
theorem diagOp_ric (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (a b : ι) :
    Ric (diagOp w) a b = if a = b then (∑ c : ι, w a c) - w a a else 0 := by
  unfold Ric
  have h : ∀ c : ι, inner2 (diagOp w (phi a c)) (phi b c)
      = w a c * ((if a = b then (1:ℝ) else 0) - (if c = b ∧ a = c then (1:ℝ) else 0)) := by
    intro c
    rw [diagOp_phi w hw, inner2_smul_left, inner2_phi_phi]
    simp
  simp only [h]
  by_cases hab : a = b
  · subst hab
    simp only [if_true]
    have h2 : ∀ c : ι, w a c * ((1:ℝ) - (if c = a ∧ a = c then (1:ℝ) else 0))
        = w a c - (if c = a then w a c else 0) := by
      intro c; by_cases h3 : c = a <;> simp [h3]
    simp only [h2, Finset.sum_sub_distrib, Finset.sum_ite_eq' Finset.univ a (fun c => w a c),
      Finset.mem_univ, if_true]
  · simp only [if_neg hab]
    refine Finset.sum_eq_zero fun c _ => ?_
    have h4 : ¬ (c = b ∧ a = c) := by rintro ⟨rfl, rfl⟩; exact hab rfl
    simp [h4]

/-- **A diagonal operator is self-adjoint on `Λ²`**, with no hypothesis at all: both sides are
`½∑ w_{ab} X_{ab} Y_{ab}`. -/
theorem diagOp_selfAdjoint (w : Matrix ι ι ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (diagOp w X) Y = inner2 X (diagOp w Y) := by
  simp only [inner2_eq_sum, diagOp, Matrix.of_apply]
  congr 1
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring

omit [Fintype ι] [DecidableEq ι] in
/-- **A diagonal operator maps bivectors to bivectors**, the first clause of `IsWeyl`. *It acts
entrywise by a symmetric weight, so `(WX)_{ba} = w_{ab} X_{ba} = -(WX)_{ab}`; symmetry of `w` is
exactly what the clause needs.* -/
theorem diagOp_skew (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (X : Matrix ι ι ℝ)
    (hX : IsSkew X) : IsSkew (diagOp w X) := by
  have hba : ∀ a b : ι, X b a = - X a b := by
    intro a b
    have := congrFun (congrFun hX a) b
    simpa [Matrix.transpose_apply] using this
  unfold IsSkew
  ext a b
  simp [diagOp, Matrix.transpose_apply, hba a b, hw b a]

/-- **A weight in `𝒟ₙ` gives a Weyl operator.** *This is what makes the sphere product an
admissible competitor rather than an assumed one.* -/
theorem diagOp_isWeyl {w : Matrix ι ι ℝ} (h : IsWeight w) : IsWeyl (diagOp w) :=
  ⟨fun X hX => diagOp_skew w h.symm X hX,
   fun X Y _ _ => diagOp_selfAdjoint w X Y,
   fun i j k l => diagOp_bianchi w h.symm i j k l,
   fun a b => by rw [diagOp_ric w h.symm a b, h.rowSum a, h.hollow a]; simp⟩

/-- **`‖diagOp w‖² = ½ ∑_{a,b} w_{ab}²`**, the Frobenius square over ordered pairs, which is the
sum over unordered ones. *Under the record's `tr M² = 2` normalisation this reads `‖W‖² = 1`.* -/
theorem diagOp_normSq (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0) :
    normSq (diagOp w) = (1/2) * ∑ i : ι, ∑ j : ι, (w i j) ^ 2 := by
  unfold normSq innerOp
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [diagOp_phi w hw, inner2_smul_left, inner2_smul_right, inner2_phi_phi]
  by_cases hij : i = j
  · subst hij; rw [hh i]; ring
  · simp [hij, Ne.symm hij]; ring

theorem diagOp_normSq_smul (t : ℝ) (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a)
    (hh : ∀ a, w a a = 0) :
    normSq (diagOp (t • w)) = t ^ 2 * normSq (diagOp w) := by
  have hs : ∀ a b : ι, (t • w) a b = (t • w) b a := by
    intro a b; simp only [Matrix.smul_apply, smul_eq_mul, hw a b]
  have hz : ∀ a : ι, (t • w) a a = 0 := by intro a; simp [Matrix.smul_apply, hh a]
  rw [diagOp_normSq _ hs hz, diagOp_normSq w hw hh]
  simp only [Matrix.smul_apply, smul_eq_mul, mul_pow]
  have h : ∀ i : ι, ∑ j : ι, t ^ 2 * (w i j) ^ 2 = t ^ 2 * ∑ j : ι, (w i j) ^ 2 :=
    fun i => (Finset.mul_sum _ _ _).symm
  simp only [h, ← Finset.mul_sum]
  ring

/-! ## The sphere product `S^p × S^q`

*The record's competitor. `p` and `q` are the two block sizes, `p + q = n`; the weight is `-1`
across the blocks, and the two in-block values are then forced by Ricci-flatness.*
-/

/-- **The two-block weight of `S^p × S^q`**, at the scale that puts `-1` across the blocks.
*In the record's normalisation ([diagonal-half.md](../../../findings/diagonal-half.md)) the balanced
weight is `1/(p(p-1))` inside and `-1/(pq)` across; this is `p·q` times that, and `θ` does not see
the factor.* The in-block entries `q/(p-1)` and `p/(q-1)` are **forced** by zero row sums once the
cross entry is fixed, which is why they are not a second choice. -/
def sphereWeight (S : Finset ι) : Matrix ι ι ℝ :=
  Matrix.of fun a b =>
    if a = b then 0
    else if a ∈ S then (if b ∈ S then ((Sᶜ.card : ℝ)) / ((S.card : ℝ) - 1) else -1)
    else (if b ∈ S then -1 else ((S.card : ℝ)) / ((Sᶜ.card : ℝ) - 1))

theorem sphereWeight_symm (S : Finset ι) (a b : ι) :
    sphereWeight S a b = sphereWeight S b a := by
  unfold sphereWeight
  simp only [Matrix.of_apply]
  by_cases hab : a = b
  · subst hab; rfl
  · by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;>
      simp [hab, Ne.symm hab, ha, hb]

theorem sphereWeight_hollow (S : Finset ι) (a : ι) : sphereWeight S a a = 0 := by
  simp [sphereWeight]

/-- **The in-block entry, `q/(p-1)`.** *At `p = q` this is `p/(p-1)`, which is `pq` times the
record's `1/(p(p-1))`.* -/
theorem sphereWeight_in (S : Finset ι) {a b : ι} (ha : a ∈ S) (hb : b ∈ S) (hab : a ≠ b) :
    sphereWeight S a b = ((Sᶜ.card : ℝ)) / ((S.card : ℝ) - 1) := by
  simp [sphereWeight, hab, ha, hb]

/-- **The other in-block entry, `p/(q-1)`.** -/
theorem sphereWeight_out (S : Finset ι) {a b : ι} (ha : a ∉ S) (hb : b ∉ S) (hab : a ≠ b) :
    sphereWeight S a b = ((S.card : ℝ)) / ((Sᶜ.card : ℝ) - 1) := by
  simp [sphereWeight, hab, ha, hb]

/-- **The cross-block entry is `-1`**, which is the scale this file fixes. *`pq` times the record's
`-1/(pq)`.* -/
theorem sphereWeight_cross (S : Finset ι) {a b : ι} (ha : a ∈ S) (hb : b ∉ S) :
    sphereWeight S a b = -1 := by
  have hab : a ≠ b := fun h => hb (h ▸ ha)
  simp [sphereWeight, hab, ha, hb]

/-- **Zero row sums**, which is Ricci-flatness on the locus. *This is where `p, q ≥ 2` is used and
the only place it is: at `p = 1` the in-block entry `q/(p-1)` does not exist.* -/
theorem sphereWeight_rowSum (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (a : ι) :
    ∑ c : ι, sphereWeight S a c = 0 := by
  have hpR : (2:ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2:ℝ) ≤ ((Sᶜ.card : ℝ)) := by exact_mod_cast hq
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by intro h; linarith [h]
  have hq1 : (((Sᶜ.card : ℝ)) - 1) ≠ 0 := by intro h; linarith [h]
  rw [← Finset.sum_add_sum_compl S (fun c => sphereWeight S a c)]
  by_cases ha : a ∈ S
  · have h1 : ∑ c ∈ S, sphereWeight S a c
        = (S.card : ℝ) * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))
          - ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) := by
      rw [Finset.sum_congr rfl (fun c hc => show sphereWeight S a c
            = ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))
              - (if c = a then ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) else 0) by
          by_cases hca : c = a
          · subst hca; simp [sphereWeight]
          · simp [sphereWeight, hca, Ne.symm hca, ha, hc])]
      rw [Finset.sum_sub_distrib, Finset.sum_const,
        Finset.sum_ite_eq' S a (fun _ => ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))), if_pos ha]
      simp [nsmul_eq_mul]
    have h2 : ∑ c ∈ Sᶜ, sphereWeight S a c = -((Sᶜ.card : ℝ)) := by
      rw [Finset.sum_congr rfl (fun c hc => show sphereWeight S a c = -1 by
        have hcS : c ∉ S := Finset.mem_compl.mp hc
        have hca : c ≠ a := fun h => hcS (h ▸ ha)
        simp [sphereWeight, Ne.symm hca, ha, hcS])]
      simp
    rw [h1, h2]
    field_simp
    ring
  · have hac : a ∈ Sᶜ := Finset.mem_compl.mpr ha
    have h1 : ∑ c ∈ S, sphereWeight S a c = -((S.card : ℝ)) := by
      rw [Finset.sum_congr rfl (fun c hc => show sphereWeight S a c = -1 by
        have hca : c ≠ a := fun h => ha (h ▸ hc)
        simp [sphereWeight, Ne.symm hca, ha, hc])]
      simp
    have h2 : ∑ c ∈ Sᶜ, sphereWeight S a c
        = ((Sᶜ.card : ℝ)) * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))
          - ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) := by
      rw [Finset.sum_congr rfl (fun c hc => show sphereWeight S a c
            = ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))
              - (if c = a then ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) else 0) by
          have hcS : c ∉ S := Finset.mem_compl.mp hc
          by_cases hca : c = a
          · subst hca; simp [sphereWeight]
          · simp [sphereWeight, hca, Ne.symm hca, ha, hcS])]
      rw [Finset.sum_sub_distrib, Finset.sum_const,
        Finset.sum_ite_eq' Sᶜ a (fun _ => ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))), if_pos hac]
      simp [nsmul_eq_mul]
    rw [h1, h2]
    field_simp
    ring

theorem sphereWeight_isWeight (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    IsWeight (sphereWeight S) where
  symm := sphereWeight_symm S
  hollow := sphereWeight_hollow S
  rowSum := sphereWeight_rowSum S hp hq

/-- **`IsSphereProduct`, AS A DEFINITION**, the predicate
[WeylReal.lean](WeylReal.lean)'s `ProblemP` takes as a parameter, here built rather than assumed.
*Closed under POSITIVE scaling only.* **An earlier form carried `t ≠ 0` on the reasoning that `θ`
is scale-invariant, which holds for positive scaling and not for negative**, so `-W_{p,q}` was in
the family with `θ = -θ_{p,q}`. *Harmless inside `ProblemP`'s existential, which it only weakened,
and false the moment anyone writes `IsSphereProduct S → θ(S) = Θₙ`; this file's own
`SphereProductValue` already requires `0 < t`.* -/
def IsSphereProduct (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∃ (S : Finset ι) (t : ℝ), 2 ≤ S.card ∧ 2 ≤ Sᶜ.card ∧ 0 < t ∧ R = diagOp (t • sphereWeight S)

/-- **Every member is a Weyl operator.** *So the competitor is admissible; `ProblemP`'s existential
is over a subset of `𝒲ₙ` and not over an arbitrary operator.* -/
theorem IsSphereProduct.isWeyl {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (h : IsSphereProduct R) :
    IsWeyl R := by
  obtain ⟨S, t, hp, hq, _, rfl⟩ := h
  exact diagOp_isWeyl ((sphereWeight_isWeight S hp hq).smul t)

theorem sphereWeight_normSq_pos (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    0 < normSq (diagOp (sphereWeight S)) := by
  obtain ⟨a, ha⟩ : S.Nonempty := Finset.card_pos.mp (by omega)
  obtain ⟨b, hb⟩ : Sᶜ.Nonempty := Finset.card_pos.mp (by omega)
  have hbS : b ∉ S := Finset.mem_compl.mp hb
  have hab : a ≠ b := fun h => hbS (h ▸ ha)
  have hval : sphereWeight S a b = -1 := by simp [sphereWeight, hab, ha, hbS]
  rw [diagOp_normSq _ (sphereWeight_symm S) (sphereWeight_hollow S)]
  have h1 : (1:ℝ) ≤ ∑ j : ι, (sphereWeight S a j) ^ 2 := by
    calc (1:ℝ) = (sphereWeight S a b) ^ 2 := by rw [hval]; norm_num
      _ ≤ _ := Finset.single_le_sum (f := fun j => (sphereWeight S a j) ^ 2)
          (fun _ _ => sq_nonneg _) (Finset.mem_univ b)
  have h2 : ∑ j : ι, (sphereWeight S a j) ^ 2
      ≤ ∑ i : ι, ∑ j : ι, (sphereWeight S i j) ^ 2 :=
    Finset.single_le_sum (f := fun i => ∑ j : ι, (sphereWeight S i j) ^ 2)
      (fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _) (Finset.mem_univ a)
  linarith

/-- **THE COMPETITOR EXISTS AT UNIT NORM**, which is the clause `ProblemP` asks for. *Without this
the statement is satisfiable by an empty family and says nothing; with it, `ProblemP` is a claim
about a named object at every `ι` carrying a `2 + 2` split.* -/
theorem exists_unit_sphereProduct (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    ∃ R : Matrix ι ι ℝ → Matrix ι ι ℝ, IsWeyl R ∧ normSq R = 1 ∧ IsSphereProduct R := by
  have hpos := sphereWeight_normSq_pos S hp hq
  have hsq : 0 < Real.sqrt (normSq (diagOp (sphereWeight S))) := Real.sqrt_pos.mpr hpos
  refine ⟨diagOp ((1 / Real.sqrt (normSq (diagOp (sphereWeight S)))) • sphereWeight S), ?_, ?_, ?_⟩
  · exact diagOp_isWeyl ((sphereWeight_isWeight S hp hq).smul _)
  · rw [diagOp_normSq_smul _ _ (sphereWeight_symm S) (sphereWeight_hollow S)]
    rw [div_pow, one_pow, Real.sq_sqrt hpos.le]
    field_simp
  · exact ⟨S, _, hp, hq, by positivity, rfl⟩

/-- **PROBLEM P WITH THE COMPETITOR NAMED, WHICH IS THE PROGRAMME'S GOAL AS A LEAN PROPOSITION.**
*[WeylReal.lean](WeylReal.lean) records its own `ProblemP` as "the shape of the problem and not a
theorem about a named object", because the layer could not build the family. This is the same
statement with `IsSphereProduct` supplied, and it is now a statement about `S^p × S^q`.*

**IT HAS NO CONSUMERS AND THAT IS WHAT A GOAL LOOKS LIKE.** *[plan-lean.md](../../../plan-lean.md)'s
hypothesis-debt table lists it beside abandoned hypotheses, which have the same shape there: defined
once, taken by nothing, concluded by nothing.* **A reader working that table as a debt list would
delete the statement of the problem**, so the distinction is recorded here, where the definition is,
rather than in a generated file that cannot carry it.

*Debt class: goal.* **That token is READ by [lean_debts.py](../../../scripts/misc/lean_debts.py)**, which otherwise cannot tell a goal from an abandoned hypothesis: both are defined once, taken by nothing and concluded by nothing, and the table showed them in one list. -/
def ProblemPNamed : Prop := RealLayer.ProblemP (ι := ι) IsSphereProduct

end

/-! ## The two constants, and they are two

**`θ₀(n)` is the balanced split's value and the criterion's demand; `Θₙ` is the sphere-product
maximum and the conjecture's conclusion.** *They agree at even `n` and separate at odd `n`, where
`θ₀(n)` is attained by nothing: the balanced split does not exist there.* The record's own warning
is that "a bound read off `θ₀` at odd `n` describes no object", and the reverse substitution, `Θₙ`
where the Böhm–Wilking criterion demands `θ₀(n)`, is the other way to get it wrong, since the
criterion's constant is `c(n-1)` and no step of its derivation is parity-dependent.

*Everything here is over `ℝ` with `n`, `p`, `q` real, so that `n - 1` is an ordinary difference and
no cast appears; the parity-dependent `Θ` is the one place a natural number is needed.*
-/

/-- **`θ_{p,q}² = 2(n-1)(p-1)(q-1)/((n-2)pq)`** at `n = p + q`, the value at `S^p × S^q`.
*[problem.md](../../../findings/problem.md) records it as Nienhaus Proposition 2.25's `θ_{k,l}`, in
the equivalent form `√2·√((k-1)/k · (l-1)/l · (n-1)/(n-2))`.* -/
noncomputable def thetaSplitSq (p q : ℝ) : ℝ :=
  2 * (p + q - 1) * (p - 1) * (q - 1) / ((p + q - 2) * (p * q))

/-- **`θ₀(n)² = 2(n-1)(n-2)/n²`.** *The value at the BALANCED split `S^{n/2} × S^{n/2}`, and the
constant the Böhm–Wilking invariance criterion demands at both parities.* -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **The odd-`n` sphere-product maximum, squared**: `2(n-1)(n-3)/((n-2)(n+1))`, the value at
`S^{(n-1)/2} × S^{(n+1)/2}`. -/
noncomputable def ThetaSqOdd (n : ℝ) : ℝ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

/-- **`Θₙ²`, the sphere-product MAXIMUM**, which is what Conjecture A concludes at. *Parity is
part of the definition and not a caveat on it.* -/
noncomputable def ThetaSq (n : ℕ) : ℝ := if n % 2 = 0 then theta0Sq n else ThetaSqOdd n

noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (theta0Sq n)

noncomputable def Theta (n : ℕ) : ℝ := Real.sqrt (ThetaSq n)

noncomputable def thetaSplit (p q : ℝ) : ℝ := Real.sqrt (thetaSplitSq p q)

theorem ThetaSq_even {n : ℕ} (h : n % 2 = 0) : ThetaSq n = theta0Sq n := by
  simp [ThetaSq, h]

theorem ThetaSq_odd {n : ℕ} (h : n % 2 = 1) : ThetaSq n = ThetaSqOdd n := by
  simp [ThetaSq, h]

/-- **`θ_{p,q}² = 2(n-1)/(n-2) · (1 - (n-1)/(pq))`**, the form that makes the dependence on the
split a dependence on `pq` alone, which is the record's reason the maximum is at the balanced
split. -/
theorem thetaSplitSq_eq (p q : ℝ) (hp : p ≠ 0) (hq : q ≠ 0) (hn : p + q - 2 ≠ 0) :
    thetaSplitSq p q = 2 * (p + q - 1) / (p + q - 2) * (1 - (p + q - 1) / (p * q)) := by
  unfold thetaSplitSq
  field_simp
  ring

/-- **The balanced split is `θ₀`**: `θ_{m,m}² = θ₀(2m)²`. *This is the whole content of
"`θ₀(n)` is the balanced sphere product's value".* -/
theorem thetaSplitSq_balanced (m : ℝ) (hm : m ≠ 0) (hm1 : m - 1 ≠ 0) :
    thetaSplitSq m m = theta0Sq (2 * m) := by
  have hd1 : (m + m - 2) * (m * m) ≠ 0 :=
    mul_ne_zero (by intro h; exact hm1 (by linarith)) (mul_ne_zero hm hm)
  have hd2 : (2 * m) ^ 2 ≠ 0 := pow_ne_zero _ (by simpa using hm)
  unfold thetaSplitSq theta0Sq
  rw [div_eq_div_iff hd1 hd2]
  ring

/-- **The best odd split is `Θ`**: `θ_{m,m+1}² = Θ_{2m+1}²`. -/
theorem thetaSplitSq_odd (m : ℝ) (hm : m ≠ 0) (hm1 : m + 1 ≠ 0) (hm2 : 2 * m - 1 ≠ 0) :
    thetaSplitSq m (m + 1) = ThetaSqOdd (2 * m + 1) := by
  have hd1 : (m + (m + 1) - 2) * (m * (m + 1)) ≠ 0 :=
    mul_ne_zero (by intro h; exact hm2 (by linarith)) (mul_ne_zero hm hm1)
  have hd2 : (2 * m + 1 - 2) * (2 * m + 1 + 1) ≠ 0 :=
    mul_ne_zero (by intro h; exact hm2 (by linarith)) (by intro h; exact hm1 (by linarith))
  unfold thetaSplitSq ThetaSqOdd
  rw [div_eq_div_iff hd1 hd2]
  ring

/-- **The margin-`4` identity**, `(n-2)²(n+1) - n²(n-3) = 4`. *The record turns on it twice, as
the constant margin of the defect-penalty inequality, and as the reason `θ₀` substituted for `Θ` at
odd `n` asserts the conjecture's own negation.* -/
theorem margin_four (n : ℝ) : (n - 2) ^ 2 * (n + 1) - n ^ 2 * (n - 3) = 4 := by ring

/-- **`θ₀(n)² - Θₙ² = 8(n-1)/(n²(n+1)(n-2))` at odd `n`**, the record's own closed form for the
gap, and `margin_four` is exactly why the numerator is `8(n-1)` and not something that vanishes. -/
theorem theta0Sq_sub_ThetaSqOdd (n : ℝ) (hn : n ≠ 0) (h2 : n - 2 ≠ 0) (h1 : n + 1 ≠ 0) :
    theta0Sq n - ThetaSqOdd n = 8 * (n - 1) / (n ^ 2 * ((n + 1) * (n - 2))) := by
  unfold theta0Sq ThetaSqOdd
  field_simp
  ring

/-- **The gap never closes**: at every `n > 3` the odd constant is strictly below `θ₀(n)`. -/
theorem ThetaSqOdd_lt_theta0Sq (n : ℝ) (hn : 3 < n) : ThetaSqOdd n < theta0Sq n := by
  have hn0 : n ≠ 0 := by intro h; rw [h] at hn; linarith
  have h2 : n - 2 ≠ 0 := by intro h; linarith [h]
  have h1 : n + 1 ≠ 0 := by intro h; linarith [h]
  have := theta0Sq_sub_ThetaSqOdd n hn0 h2 h1
  have hd : (0:ℝ) < n ^ 2 * ((n + 1) * (n - 2)) :=
    mul_pos (by nlinarith) (mul_pos (by linarith) (by linarith))
  have hpos : 0 < 8 * (n - 1) / (n ^ 2 * ((n + 1) * (n - 2))) := div_pos (by linarith) hd
  linarith

/-! ### The crossover against `√(3/2)`, at both parities -/

/-- **`θ₀(n) ≥ √(3/2)` is `n² - 12n + 8 ≥ 0`**, the polynomial the record calls the same one a
fifth time. Larger root `6 + 2√7 ≈ 11.2915`. -/
theorem theta0Sq_ge_three_halves_iff (n : ℝ) (hn : 0 < n) :
    3 / 2 ≤ theta0Sq n ↔ 0 ≤ n ^ 2 - 12 * n + 8 := by
  unfold theta0Sq
  rw [le_div_iff₀ (by positivity)]
  constructor <;> intro h <;> nlinarith

/-- **`Θₙ ≥ √(3/2)` at odd `n` is `n² - 13n + 18 ≥ 0`**, a DIFFERENT polynomial, with larger root
`(13 + √97)/2 ≈ 11.4244`. *Both roots lie in `(11,12)`, which is what forces the same integer
threshold at both parities, and is stronger than there being no integer between them.* -/
theorem ThetaSqOdd_ge_three_halves_iff (n : ℝ) (hn : 2 < n) :
    3 / 2 ≤ ThetaSqOdd n ↔ 0 ≤ n ^ 2 - 13 * n + 18 := by
  unfold ThetaSqOdd
  rw [le_div_iff₀ (by nlinarith)]
  constructor <;> intro h <;> nlinarith

theorem poly_even_at_eleven : (11:ℝ) ^ 2 - 12 * 11 + 8 = -3 := by norm_num
theorem poly_even_at_twelve : (12:ℝ) ^ 2 - 12 * 12 + 8 = 8 := by norm_num
theorem poly_odd_at_eleven : (11:ℝ) ^ 2 - 13 * 11 + 18 = -4 := by norm_num
theorem poly_odd_at_thirteen : (13:ℝ) ^ 2 - 13 * 13 + 18 = 18 := by norm_num

/-! ### The record's tabulated values, checked -/

theorem theta0Sq_twelve : theta0Sq 12 = 55 / 36 := by unfold theta0Sq; norm_num
theorem theta0Sq_ten : theta0Sq 10 = 36 / 25 := by unfold theta0Sq; norm_num
theorem theta0Sq_thirteen : theta0Sq 13 = 264 / 169 := by unfold theta0Sq; norm_num
theorem ThetaSqOdd_eleven : ThetaSqOdd 11 = 40 / 27 := by unfold ThetaSqOdd; norm_num
theorem ThetaSqOdd_thirteen : ThetaSqOdd 13 = 120 / 77 := by unfold ThetaSqOdd; norm_num
theorem ThetaSqOdd_fifteen : ThetaSqOdd 15 = 21 / 13 := by unfold ThetaSqOdd; norm_num

/-- `θ_{6,6}² = 55/36`, the balanced split at `n = 12`. -/
theorem thetaSplitSq_six_six : thetaSplitSq 6 6 = 55 / 36 := by unfold thetaSplitSq; norm_num

/-- `θ_{5,7}² = 264/175`, the unbalanced split at `n = 12`, **above `3/2` and below `θ₀(12)²`**,
which is the pair of facts the record's own `9625 > 9504` records. -/
theorem thetaSplitSq_five_seven : thetaSplitSq 5 7 = 264 / 175 := by unfold thetaSplitSq; norm_num

theorem five_seven_above_cp2 : (3:ℝ) / 2 < thetaSplitSq 5 7 := by
  rw [thetaSplitSq_five_seven]; norm_num

theorem five_seven_below_balanced : thetaSplitSq 5 7 < thetaSplitSq 6 6 := by
  rw [thetaSplitSq_five_seven, thetaSplitSq_six_six]; norm_num

/-- **`Θ₁₁² = 40/27 < 3/2` and `Θ₁₂² = 55/36 > 3/2`**, the crossing over the integers, stated on
the constant the conjecture concludes at rather than on `θ₀`. -/
theorem Theta_crossover :
    ThetaSq 11 = 40 / 27 ∧ ThetaSq 12 = 55 / 36 ∧ ThetaSq 11 < 3 / 2 ∧ 3 / 2 < ThetaSq 12 := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [ThetaSq_odd (by norm_num)]; unfold ThetaSqOdd; norm_num
  · rw [ThetaSq_even (by norm_num)]; unfold theta0Sq; norm_num
  · rw [ThetaSq_odd (by norm_num)]; unfold ThetaSqOdd; norm_num
  · rw [ThetaSq_even (by norm_num)]; unfold theta0Sq; norm_num

/-- **`θ₀(13)² = 264/169` against `Θ₁₃² = 120/77`**, the record's witness that the two constants
are not the same number, and that the substitution asserts the conjecture's negation at odd `n`. -/
theorem theta0_ne_Theta_thirteen : ThetaSq 13 < theta0Sq 13 := by
  rw [ThetaSq_odd (by norm_num)]
  unfold ThetaSqOdd theta0Sq
  norm_num

noncomputable section

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **At unit norm `θ` IS `P`**, which is why every value on the record is quoted as one number for
both. *Used by every comparison in the constants section below.* -/
theorem theta_of_unit (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (h : normSq R = 1) :
    theta R = Pcubic R := by
  unfold theta RealLayer.norm
  rw [h, Real.sqrt_one, one_pow, div_one]

/-- **THE SPHERE PRODUCT'S VALUE, NAMED.** *That a unit-norm member of the family carries
`P = θ_{p,q}`, Nienhaus Proposition 2.25, and the record's own source for `sup ≥ Θₙ`. It needs
`Pcubic` evaluated on the diagonal locus, which is `DiagCubicFormula` plus the cube-and-trace
arithmetic at the two-block weight; both are arithmetic on objects this file defines, and neither
is done here.* [L130](../Results/L130Statement.lean) records the same gap as "`θ` at a sphere
product, which the `RealLayer` does not carry". -/
def SphereProductValue : Prop :=
  ∀ S : Finset ι, 2 ≤ S.card → 2 ≤ Sᶜ.card → ∀ t : ℝ, 0 < t →
    normSq (diagOp (t • sphereWeight S)) = 1 →
      Pcubic (diagOp (t • sphereWeight S)) = thetaSplit (S.card : ℝ) ((Sᶜ.card : ℝ))

/-- **`θ = θ_{p,q}` at the sphere product**, from `SphereProductValue` and nothing else. *The one
step between the record's `P` value and the record's `θ` value, discharged here so that a cycle
proving the first gets the second free.* -/
theorem theta_sphereProduct (h : SphereProductValue (ι := ι)) (S : Finset ι)
    (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight S)) = 1) :
    theta (diagOp (t • sphereWeight S)) = thetaSplit (S.card : ℝ) ((Sᶜ.card : ℝ)) := by
  rw [theta_of_unit _ hn]
  exact h S hp hq t ht hn

/-- **The record's weighted-graph functional**, `½(∑_{a,b} w_{ab}³ + tr w³)`.
*[diagonal-half.md](../../../findings/diagonal-half.md) states `θ` on the diagonal locus in exactly
this form, under `tr M² = 2`, which by `diagOp_normSq` is `‖diagOp w‖² = 1`. The cube sum is the
entrywise term and the trace is `3·(the triangle sum)`.* -/
def diagP (w : Matrix ι ι ℝ) : ℝ :=
  (1/2) * ((∑ a : ι, ∑ b : ι, (w a b) ^ 3) + (w * w * w).trace)

/-- **THAT `Pcubic` AT A DIAGONAL OPERATOR IS THE RECORD'S WEIGHTED-GRAPH FUNCTIONAL, AND IT IS
NOW PROVED**, `diagCubicFormula` in [SharpDiag.lean](SharpDiag.lean), on the standard three axioms.
*It needed `sharpOp` evaluated on the `φ` basis, which this file does not do and that one does.*

**THE `Prop` STAYS BECAUSE CONSUMERS TAKE IT AS A HYPOTHESIS**, and each is discharged by applying
`diagCubicFormula` rather than by editing the binder away. **A first version of this docstring
called it "THE ONE THING OWED ABOUT THE DIAGONAL LOCUS"**, *which stood after the proof landed and
was the definition's own copy of a staleness that reached ten sites across six files*
([r1028](../../../reviews/REVIEW_r1028.md)). **What IS still owed about the locus is the CRITICALITY
equation**, `DiagCriticalityIsCritical`, which is a different statement and needs `sharpOp` as an
OPERATOR rather than through its quadratic form. -/
def DiagCubicFormula : Prop :=
  ∀ w : Matrix ι ι ℝ, IsWeight w → Pcubic (diagOp w) = diagP w

/-! ## Rank-one pieces, and `W_{ℂP²}`

*The sphere product is diagonal in the `φ` basis; `W_{ℂP²}` is not, so it is assembled from
rank-one projections onto three bivectors instead.*
-/

omit [Fintype ι] [DecidableEq ι] in
theorem isSkew_add {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) : IsSkew (X + Y) := by
  unfold IsSkew at *
  rw [Matrix.transpose_add, hX, hY]
  abel

/-- **`c · v vᵀ` as an operator on `Λ²`**: `X ↦ c⟨v, X⟩ v`. *This is the `a aᵀ` of the record's
`W = a aᵀ - ½(b bᵀ + c cᵀ)`, read with `inner2` supplying the pairing.* -/
def proj (v : Matrix ι ι ℝ) (c : ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => (c * inner2 v X) • v

omit [Fintype ι] [DecidableEq ι] in
theorem isSkew_smul {X : Matrix ι ι ℝ} (c : ℝ) (hX : IsSkew X) : IsSkew (c • X) := by
  unfold IsSkew at *
  rw [Matrix.transpose_smul, hX, smul_neg]

omit [DecidableEq ι] in
/-- **A rank-one piece lands in the line through `v`**, so it maps bivectors to bivectors as soon
as `v` is one, the first clause of `IsWeyl`, and it holds at every argument. -/
theorem proj_skew (v : Matrix ι ι ℝ) (hv : IsSkew v) (c : ℝ) (X : Matrix ι ι ℝ) :
    IsSkew (proj v c X) := isSkew_smul _ hv

theorem proj_selfAdjoint (v : Matrix ι ι ℝ) (c : ℝ) (X Y : Matrix ι ι ℝ) :
    inner2 (proj v c X) Y = inner2 X (proj v c Y) := by
  unfold proj
  rw [inner2_smul_left, inner2_smul_right, inner2_comm X v]
  ring

/-- **`⟨c v vᵀ, d u uᵀ⟩ = c d ⟨v,u⟩²`**, the pairing of two rank-one operators, where the
ordered-pair doubling of `innerOp` cancels against the `½` of `inner2` exactly. -/
theorem innerOp_proj (v u : Matrix ι ι ℝ) (hv : IsSkew v) (hu : IsSkew u) (c d : ℝ) :
    innerOp (proj v c) (proj u d) = c * d * (inner2 v u) ^ 2 := by
  unfold innerOp proj
  have h : ∀ i j : ι, inner2 ((c * inner2 v (phi i j)) • v) ((d * inner2 u (phi i j)) • u)
      = (c * d * inner2 v u) * (inner2 v (phi i j) * inner2 u (phi i j)) := by
    intro i j
    rw [inner2_smul_left, inner2_smul_right]
    ring
  have h2 : ∀ i : ι, ∑ j : ι, (c * d * inner2 v u) * (inner2 v (phi i j) * inner2 u (phi i j))
      = (c * d * inner2 v u) * ∑ j : ι, (inner2 v (phi i j) * inner2 u (phi i j)) :=
    fun i => (Finset.mul_sum _ _ _).symm
  simp only [h, h2, ← Finset.mul_sum]
  rw [sum_inner2_phi v u hv hu]
  ring

/-- **The Ricci contraction of a rank-one piece is `c · v vᵀ`.** *So a sum of rank-one pieces is
Ricci-flat exactly when the weighted sum of the `v vᵀ` vanishes, at `W_{ℂP²}` each `v` is a
complex structure, `v vᵀ = I`, and the weights are `1, -½, -½`.* -/
theorem proj_ric (v : Matrix ι ι ℝ) (hv : IsSkew v) (c : ℝ) (a b : ι) :
    Ric (proj v c) a b = c * ∑ x : ι, v a x * v b x := by
  unfold Ric proj
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [inner2_smul_left, inner2_phi v hv, inner2_phi v hv]
  ring

/-- **`‖·‖²` of a sum of three pairwise-orthogonal rank-one pieces**, `(c₁² + c₂² + c₃²)N²` where
`N` is the common `⟨vᵢ, vᵢ⟩`. -/
theorem normSq_proj_triple (v₁ v₂ v₃ : Matrix ι ι ℝ) (c₁ c₂ c₃ N : ℝ)
    (h₁ : IsSkew v₁) (h₂ : IsSkew v₂) (h₃ : IsSkew v₃)
    (n₁ : inner2 v₁ v₁ = N) (n₂ : inner2 v₂ v₂ = N) (n₃ : inner2 v₃ v₃ = N)
    (o₁₂ : inner2 v₁ v₂ = 0) (o₁₃ : inner2 v₁ v₃ = 0) (o₂₃ : inner2 v₂ v₃ = 0) :
    normSq (fun X => proj v₁ c₁ X + (proj v₂ c₂ X + proj v₃ c₃ X))
      = (c₁ ^ 2 + c₂ ^ 2 + c₃ ^ 2) * N ^ 2 := by
  have o₂₁ : inner2 v₂ v₁ = 0 := by rw [inner2_comm]; exact o₁₂
  have o₃₁ : inner2 v₃ v₁ = 0 := by rw [inner2_comm]; exact o₁₃
  have o₃₂ : inner2 v₃ v₂ = 0 := by rw [inner2_comm]; exact o₂₃
  unfold normSq
  rw [innerOp_add_left, innerOp_add_left, innerOp_add_right, innerOp_add_right,
    innerOp_add_right, innerOp_add_right, innerOp_add_right, innerOp_add_right,
    innerOp_proj v₁ v₁ h₁ h₁, innerOp_proj v₁ v₂ h₁ h₂, innerOp_proj v₁ v₃ h₁ h₃,
    innerOp_proj v₂ v₁ h₂ h₁, innerOp_proj v₂ v₂ h₂ h₂, innerOp_proj v₂ v₃ h₂ h₃,
    innerOp_proj v₃ v₁ h₃ h₁, innerOp_proj v₃ v₂ h₃ h₂, innerOp_proj v₃ v₃ h₃ h₃,
    n₁, n₂, n₃, o₁₂, o₁₃, o₂₃, o₂₁, o₃₁, o₃₂]
  ring

end

/-! ## `W_{ℂP²}` over `ℝ`, at `n = 4`

**The record's own words**, quoted from [CP2.lean](CP2.lean):

> `Λ²ℝ⁴ = Λ⁺ ⊕ Λ⁻`, and `𝒲₄ = Sym²₀(Λ⁺) ⊕ Sym²₀(Λ⁻)`. The competitor is the self-dual operator
> with spectrum `(2,-1,-1)` and zero on `Λ⁻`:
> `W = a aᵀ - ½(b bᵀ + c cᵀ)`, `a = e₀₁+e₂₃`, `b = e₀₂-e₁₃`, `c = e₀₃+e₁₂`.

*Written with `φ` rather than `e`, and `b` as `φ₀₂ + φ₃₁` rather than `φ₀₂ - φ₁₃`, which is the same
bivector by `phi_swap`; the three then read cyclically.*
-/

namespace CP2

open HamiltonsCubic.RealLayer

/-- `a = e₀₁ + e₂₃`, the first self-dual bivector. -/
def bivA : Matrix (Fin 4) (Fin 4) ℝ := phi 0 1 + phi 2 3

/-- `b = e₀₂ - e₁₃ = e₀₂ + e₃₁`. -/
def bivB : Matrix (Fin 4) (Fin 4) ℝ := phi 0 2 + phi 3 1

/-- `c = e₀₃ + e₁₂`. -/
def bivC : Matrix (Fin 4) (Fin 4) ℝ := phi 0 3 + phi 1 2

/-- The first ANTI-self-dual bivector, `e₀₁ - e₂₃`, used to show `W` kills `Λ⁻`. -/
def bivA' : Matrix (Fin 4) (Fin 4) ℝ := phi 0 1 + phi 3 2

def bivB' : Matrix (Fin 4) (Fin 4) ℝ := phi 0 2 + phi 1 3

def bivC' : Matrix (Fin 4) (Fin 4) ℝ := phi 0 3 + phi 2 1

theorem bivA_skew : IsSkew bivA :=
  isSkew_add (phi_isSkew (0 : Fin 4) 1) (phi_isSkew (2 : Fin 4) 3)
theorem bivB_skew : IsSkew bivB :=
  isSkew_add (phi_isSkew (0 : Fin 4) 2) (phi_isSkew (3 : Fin 4) 1)
theorem bivC_skew : IsSkew bivC :=
  isSkew_add (phi_isSkew (0 : Fin 4) 3) (phi_isSkew (1 : Fin 4) 2)

/-- **The Gram matrix of `Λ⁺`, under the record's `½`**: each of `a, b, c` has `‖·‖² = 2` and the
three are pairwise orthogonal. *`‖a‖² = 2` rather than `1` is what makes the eigenvalues `2, -1, -1`
come out of the coefficients `1, -½, -½`.* -/
theorem gram :
    inner2 bivA bivA = 2 ∧ inner2 bivB bivB = 2 ∧ inner2 bivC bivC = 2 ∧
    inner2 bivA bivB = 0 ∧ inner2 bivA bivC = 0 ∧ inner2 bivB bivC = 0 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    simp only [bivA, bivB, bivC, inner2_add_left, inner2_add_right, inner2_phi_phi] <;>
      norm_num [Fin.ext_iff]

/-- **`W` annihilates `Λ⁻`**: each anti-self-dual bivector is orthogonal to all of `a, b, c`. -/
theorem gram_minus :
    inner2 bivA bivA' = 0 ∧ inner2 bivB bivA' = 0 ∧ inner2 bivC bivA' = 0 ∧
    inner2 bivA bivB' = 0 ∧ inner2 bivB bivB' = 0 ∧ inner2 bivC bivB' = 0 ∧
    inner2 bivA bivC' = 0 ∧ inner2 bivB bivC' = 0 ∧ inner2 bivC bivC' = 0 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    simp only [bivA, bivB, bivC, bivA', bivB', bivC', inner2_add_left, inner2_add_right,
      inner2_phi_phi] <;> norm_num [Fin.ext_iff]

/-- **`W_{ℂP²}` OVER `ℝ`**, `a aᵀ - ½(b bᵀ + c cᵀ)`, as an operator on `Λ²ℝ⁴`. -/
noncomputable def WCP2 : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin 4) (Fin 4) ℝ :=
  fun X => proj bivA 1 X + (proj bivB (-(1/2)) X + proj bivC (-(1/2)) X)

/-- **`W` maps bivectors to bivectors**, the first clause of `IsWeyl`, each of the three
rank-one pieces lands in the line through a bivector. -/
theorem WCP2_skew (X : Matrix (Fin 4) (Fin 4) ℝ) : IsSkew (WCP2 X) :=
  isSkew_add (proj_skew bivA bivA_skew 1 X)
    (isSkew_add (proj_skew bivB bivB_skew (-(1/2)) X) (proj_skew bivC bivC_skew (-(1/2)) X))

/-- **`W` is self-adjoint on `Λ²`**, the second clause of `IsWeyl`. -/
theorem WCP2_selfAdjoint (X Y : Matrix (Fin 4) (Fin 4) ℝ) :
    inner2 (WCP2 X) Y = inner2 X (WCP2 Y) := by
  unfold WCP2
  rw [inner2_add_left, inner2_add_left, inner2_add_right, inner2_add_right,
    proj_selfAdjoint, proj_selfAdjoint, proj_selfAdjoint]

/-! ### The `Λ²` spectrum is `(2, -1, -1, 0, 0, 0)` -/

theorem WCP2_bivA : WCP2 bivA = (2:ℝ) • bivA := by
  obtain ⟨hA, _, _, hAB, hAC, _⟩ := gram
  unfold WCP2 proj
  rw [hA, inner2_comm bivB bivA, hAB, inner2_comm bivC bivA, hAC]
  simp

theorem WCP2_bivB : WCP2 bivB = (-1:ℝ) • bivB := by
  obtain ⟨_, hB, _, hAB, _, hBC⟩ := gram
  unfold WCP2 proj
  rw [hAB, hB, inner2_comm bivC bivB, hBC]
  simp

theorem WCP2_bivC : WCP2 bivC = (-1:ℝ) • bivC := by
  obtain ⟨_, _, hC, _, hAC, hBC⟩ := gram
  unfold WCP2 proj
  rw [hAC, hBC, hC]
  simp

theorem WCP2_bivA' : WCP2 bivA' = 0 := by
  obtain ⟨h1, h2, h3, _, _, _, _, _, _⟩ := gram_minus
  unfold WCP2 proj
  rw [h1, h2, h3]
  simp

theorem WCP2_bivB' : WCP2 bivB' = 0 := by
  obtain ⟨_, _, _, h1, h2, h3, _, _, _⟩ := gram_minus
  unfold WCP2 proj
  rw [h1, h2, h3]
  simp

theorem WCP2_bivC' : WCP2 bivC' = 0 := by
  obtain ⟨_, _, _, _, _, _, h1, h2, h3⟩ := gram_minus
  unfold WCP2 proj
  rw [h1, h2, h3]
  simp

/-! ### The norm -/

/-- **`‖W‖² = 6`**, the record's own value, `(2,-1,-1,0,0,0)` has square sum `6`. -/
theorem WCP2_normSq : normSq WCP2 = 6 := by
  obtain ⟨hA, hB, hC, hAB, hAC, hBC⟩ := gram
  rw [show WCP2 = fun X => proj bivA 1 X + (proj bivB (-(1/2)) X + proj bivC (-(1/2)) X) from rfl,
    normSq_proj_triple bivA bivB bivC 1 (-(1/2)) (-(1/2)) 2
      bivA_skew bivB_skew bivC_skew hA hB hC hAB hAC hBC]
  norm_num

/-! ### Ricci-flatness

*Each of `a, b, c` is a complex structure (`v vᵀ = I`) so `Ric(W) = (1 - ½ - ½)·I = 0`. The
weights cancel; nothing about `n = 4` is used beyond the three matrices themselves.*
-/

theorem bivA_gram_row (a b : Fin 4) :
    ∑ x : Fin 4, bivA a x * bivA b x = if a = b then 1 else 0 := by
  fin_cases a <;> fin_cases b <;>
    simp [bivA, phi, Matrix.add_apply, Matrix.sub_apply, Matrix.single_apply]

theorem bivB_gram_row (a b : Fin 4) :
    ∑ x : Fin 4, bivB a x * bivB b x = if a = b then 1 else 0 := by
  fin_cases a <;> fin_cases b <;>
    simp [bivB, phi, Matrix.add_apply, Matrix.sub_apply, Matrix.single_apply]

theorem bivC_gram_row (a b : Fin 4) :
    ∑ x : Fin 4, bivC a x * bivC b x = if a = b then 1 else 0 := by
  fin_cases a <;> fin_cases b <;>
    simp [bivC, phi, Matrix.add_apply, Matrix.sub_apply, Matrix.single_apply]

/-- **`W_{ℂP²}` is Ricci-flat**, the fourth clause of `IsWeyl`. -/
theorem WCP2_ricciFlat (a b : Fin 4) : Ric WCP2 a b = 0 := by
  unfold WCP2
  rw [Ric_add, Ric_add, proj_ric bivA bivA_skew, proj_ric bivB bivB_skew,
    proj_ric bivC bivC_skew, bivA_gram_row, bivB_gram_row, bivC_gram_row]
  split_ifs <;> ring

/-- **`W_{ℂP²}` IS A WEYL OPERATOR ONCE FIRST BIANCHI IS SUPPLIED.** *This file does not type the
Bianchi clause. Its obstruction is the `Λ⁴` component, which for a self-dual operator is the trace over
`Λ⁺`, here `2 - 1 - 1 = 0`. [CP2.lean](CP2.lean) discharges it over `ℚ` in the pair basis by `rfl` and
`norm_num`, and [L134Passage.lean](../Results/L134Passage.lean)'s `WCP2_bianchi` proves it over `ℝ` from the
spectral presentation. Here it is carried as a hypothesis.* -/
theorem WCP2_isWeyl (hb : ∀ i j k l, bianchi WCP2 i j k l = 0) : IsWeyl WCP2 :=
  ⟨fun X _ => WCP2_skew X, fun X Y _ _ => WCP2_selfAdjoint X Y, hb, WCP2_ricciFlat⟩

/-! ### `θ = √(3/2)`, from `P = 18`

*`Pcubic` runs through `sharpOp` and is not evaluated here. What is proved is the conversion: with
`‖W‖² = 6` in hand, `P = 18` and `θ = √(3/2)` are the same statement.* [CP2.lean](CP2.lean)'s
`WCP2_theta_sq` is that `P² = (3/2)‖W‖⁶`, i.e. `P² = 324`, over `ℚ` in the pair basis.
-/

theorem sqrt_three_halves : Real.sqrt (3 / 2) = Real.sqrt 6 / 2 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  rw [show (3:ℝ) / 2 = (Real.sqrt 6 / 2) ^ 2 by rw [div_pow, h6]; norm_num]
  exact Real.sqrt_sq (by positivity)

/-- **`θ(W_{ℂP²}) = √(3/2)` EXACTLY, given the record's `P(W) = 18`.** *`‖W‖³ = 6√6`, so
`θ = 18/(6√6) = 3/√6 = √6/2 = √(3/2)`. If a later cycle evaluates `Pcubic` here and does not get
`18`, the definition above is wrong and the value stands.* -/
theorem WCP2_theta (hP : Pcubic WCP2 = 18) : theta WCP2 = Real.sqrt (3 / 2) := by
  have h6 : (0:ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  unfold theta RealLayer.norm
  rw [WCP2_normSq, hP, sqrt_three_halves,
    show Real.sqrt 6 ^ 3 = 6 * Real.sqrt 6 by
      rw [pow_succ, sq, Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 6)]]
  rw [div_eq_div_iff (by positivity) (by norm_num : (2:ℝ) ≠ 0),
    show Real.sqrt 6 * (6 * Real.sqrt 6) = 6 * (Real.sqrt 6 * Real.sqrt 6) by ring,
    Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 6)]
  norm_num

/-! ### The equality case of L178

*[L178](../Results/L178Statement.lean) proves `(9e₃)² ≤ 3/2` for three reals summing to zero with
unit square sum, and records that the equality clause, that it holds precisely at `(2,-1,-1)/√6`,
which is `ℂP²`, "is NOT proved and is not typed". The unit-normalised spectrum of `WCP2` above is
`(2,-1,-1)/√6`; that it meets L178's two hypotheses and attains the bound is checked here.*
-/

theorem cp2_spectrum_sum :
    2 / Real.sqrt 6 + (-1) / Real.sqrt 6 + (-1) / Real.sqrt 6 = 0 := by ring

theorem cp2_spectrum_sq :
    (2 / Real.sqrt 6) ^ 2 + ((-1) / Real.sqrt 6) ^ 2 + ((-1) / Real.sqrt 6) ^ 2 = 1 := by
  have h : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  field_simp
  linarith [h]

/-- **L178's bound is ATTAINED at `W_{ℂP²}`**: `(9e₃)² = 3/2` at the spectrum `(2,-1,-1)/√6`. -/
theorem cp2_attains_L178 :
    (9 * ((2 / Real.sqrt 6) * ((-1) / Real.sqrt 6) * ((-1) / Real.sqrt 6))) ^ 2 = 3 / 2 := by
  have h : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h0 : Real.sqrt 6 ≠ 0 := by positivity
  have h6 : Real.sqrt 6 ^ 6 = 216 := by
    rw [show (6:ℕ) = 2 * 3 from rfl, pow_mul, h]; norm_num
  field_simp
  linarith [h6]

end CP2

end HamiltonsCubic.FamilyLayer

