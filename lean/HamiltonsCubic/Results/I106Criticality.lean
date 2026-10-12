import Mathlib

set_option linter.style.longLine false

/-!
# The criticality system of `G(2)`, batches 15 to 26 of the I106 derivation

## What this file is

[2026-09-15-I106-m3-derivation.md](../../../reviews/2026-09-15-I106-m3-derivation.md)'s batches 15 to 26 record claims about the
first-order system of `G(2)` at fixed total norm. They support [I106](../../../plan.md) and carry no result number of
their own, and every one of them had been checked only in sympy and numpy. This file types and proves them, since
the obligation attaches to a claim being recorded rather than to a result being numbered.

Throughout, `U = diag u` is the moving block in its own eigenframe, `V` is symmetric with diagonal `(a₁, a₂, a₃)` and
off-diagonal entries `w k` opposite index `k`, `K = ⁅U, V⁆`, and

  `q t = 3 α β t² + 3 μ (α + β) t + 3 μ² - (1/2) β² n`,  `n = |V|²`.

## What is proved

* `phi_collapse`: batch 15's cancellation of the `|U|²` terms, leaving `q` at the complementary eigenvalue;
* `vkv_regroup`: batch 16's regrouping of `(V K V) 0 1`, computed from the matrix product itself;
* `w1_zero_forces`: batch 19's exclusion, **on the degenerate spectrum only**, `w₁ = 0` forcing `w₂² w₃ = 0`;
* `redundancy`, `collapse_from_pair`: batch 19's redundancy and its single equation, the latter needing no division;
* `jordan_gap`, `jordan_gap_le`: batch 18's `2|U|² - 3 u₃² = (u₁ - u₂)²`, putting the Jordan top eigenvalue on the
  diagonal block. **Its equality case needs the repeated pair to be the larger one**, which the statement does not say;
* `Q_floor`, `Q_floor_nonpos_iff`: the floor of `q` at the **withdrawn** halved constant `μ = β t`;
* `Q_floor_sharp`, `Q_floor_sharp_nonpos_iff`: the floor at the constant actually in use, `μ = 2 β t`;
* `elimPoly` with `elimPoly_antisymm`, `elimPoly_cycle`, `elimPoly_signFlip`: batch 25's eliminated equation and
  batch 26's parity, the polynomial carrying the sign character of `S₃`;
* `alpha_part_factors`: the cubic identity collapsing that equation's `α` side to one monomial;
* `disc_of_nonpos`: batch 22's scalar core. **It assumes `a < 0`, while only `a ≤ 0` is established**;
* `second_variation_expansion`, `constraint_expansion`: batch 21's joint second variation and the tangency form;
* `mu_ge_of_rayleigh`, `offdiag_rayleigh`: batch 18's normalisation. **`mu_ge_of_rayleigh` ASSUMES the factor of two
  rather than deriving it, and no declaration here computes `λ_max = |U|/√6`**;
* `value_at_critical`: batch 20's `Φ = 2 μ T - 2 P₃`, the fields eliminated;
* `paired_identity`: batch 17's pairing of the system with `K`;
* `commutator_from_C`, `commutator_from_A`: batch 30's two relations, `μ K - β {U, K} = ⁅U, C⁆` and
  `⁅V, A⁆ = 3 α {U, K} - 3 μ K`, identities of the matrix ring taking neither symmetry nor tracelessness nor
  criticality beyond the single equation each comes from;
* `entry_relation`, `entry_relation'`, `entry_relation''`, `K_zero_of_field_commutes`: batch 30's eigenframe
  reading `(μ + β u_k) Kᵢⱼ = ⁅U, C⁆ᵢⱼ`, where tracelessness **is** load-bearing, and the conclusion `K = 0` from a
  field commuting with `U` together with nonvanishing denominators;
* `elimination_of_K`: batch 30's claim 4, `3(α-β)μ K = 3α ⁅U,C⁆ + β ⁅V,A⁆`, a linear combination of the two relations
  above with no division, so it holds over any ring and for every `α`, `β`, `μ`. *Both Gate 2 rounds recorded it as
  typeable and untyped; it is four lines from declarations already here.* What `α ≠ β` and `μ ≠ 0` buy is the inversion;
* `orbit_equals_batch21`, `comm_sq_eq_anticomm`: batch 33's claim 8, the orbit form equalling batch 21's expression at
  the orbit direction, PROVED through its trace rearrangements, and the hypothesis-free ring identity
  `⁅W, U²⁆ = {U, ⁅W, U⁆}` that its `α` half rests on;
* `I_multiple_drops`: that the undetermined multiple of `I` in each Lagrange form drops out of every commutator with a
  field. The batch 30 and 33 blocks assert this in prose while `Afield` and `Cfield` carry no such multiple, so before
  this declaration it was typed nowhere (r961, r962);
* `orbit_first_order_vacuous`, `orbit_second_order_form`: batch 33's simultaneous-conjugation orbit. The first-order
  condition `⁅U, A⁆ + ⁅V, C⁆ = 0` is an IDENTITY once the Lagrange forms are substituted, which is what closes it as a
  lever, and the second-order form is not, which is what keeps it. **Neither declaration says the second-order form is
  nonnegative**, since that is a statement about maximisers, and neither says the orbit bound fails to exclude
  anything, which is batch 33's actual finding and is numerical;
* `Afield`, `Cfield`, `entry_relation_A`, `field_only_identity`, `shift_drops`: batch 31's companion
  `3 (μ + α u_k) Kᵢⱼ = -⁅V, A⁆ᵢⱼ`, the elimination of `K` between the two leaving a relation in the fields and
  `U`'s spectrum alone, and the fact that a shift by anything commuting with `C` leaves `⁅U, C⁆` unchanged.

**Not typed, and this is where the open question lives**: any statement about maximisers, and batch 28's finding that
the criticality system does NOT force commutativity, which is a statement about the solution set rather than an
identity. Nothing in this file bears on whether a non-commuting critical point can be a maximum. In particular
`K_zero_of_field_commutes` takes `⁅U, C⁆ = 0` as a hypothesis, and that batch 18's bound makes its three denominators
nonzero at a global maximum is argued in the derivation and typed nowhere here. **Batch 33's claim 8 is now TYPED,
as `orbit_equals_batch21`, and PROVED**: both Gate 2 readers asked for it. *The reason it does not close
by `module` like its neighbours is not that it is an identity of traces but that it carries HYPOTHESES: the `β`
terms collapse only through `tr (X Y V) = tr (X V Y)`, which needs `X`, `Y`, `V` symmetric, hence `W` skew and
`U`, `V` symmetric.* **The gap is three trace rearrangements on top of the already-proved
`orbit_second_order_form`, and `comm_sq_eq_anticomm` supplies the hypothesis-free half of the bridge.**

-/

namespace HamiltonsCubic.I106Criticality

/-- **Batch 15, the collapse.** With `u` traceless the two `|U|²` terms cancel against `3 α β u₁ u₂`, so the
bracket multiplying `(u₁ - u₂) V₁₂` is one quadratic evaluated at the complementary eigenvalue `u₃`. -/
theorem phi_collapse (u₁ u₂ u₃ μ α β n : ℝ) (hu : u₁ + u₂ + u₃ = 0) :
    3 * μ ^ 2 + 3 / 2 * α * β * (u₁ ^ 2 + u₂ ^ 2 + u₃ ^ 2) - 1 / 2 * β ^ 2 * n
        - 3 * μ * (α + β) * (u₁ + u₂) + 3 * α * β * (u₁ * u₂)
      = 3 * μ ^ 2 - 1 / 2 * β ^ 2 * n + 3 * μ * (α + β) * u₃ + 3 * α * β * u₃ ^ 2 := by
  have h : u₃ = -u₁ - u₂ := by linarith
  subst h; ring

/-- The moving block in its own eigenframe. -/
def Um (u₁ u₂ u₃ : ℝ) : Matrix (Fin 3) (Fin 3) ℝ := !![u₁, 0, 0; 0, u₂, 0; 0, 0, u₃]

/-- The partner, with diagonal `(a₁, a₂, a₃)` and `w k` the entry opposite index `k`. -/
def Vm (a₁ a₂ a₃ w₁ w₂ w₃ : ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  !![a₁, w₃, w₂; w₃, a₂, w₁; w₂, w₁, a₃]

/-- **Batch 16, the regrouping**, computed from the matrix product rather than asserted. Every term carries
either `w₃` or the product `w₁ w₂` of the other two, which is what degenerates the system on a whole stratum. -/
theorem vkv_regroup (u₁ u₂ u₃ a₁ a₂ a₃ w₁ w₂ w₃ : ℝ) :
    (Vm a₁ a₂ a₃ w₁ w₂ w₃ * (Um u₁ u₂ u₃ * Vm a₁ a₂ a₃ w₁ w₂ w₃
        - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ u₃) * Vm a₁ a₂ a₃ w₁ w₂ w₃) 0 1
      = (u₁ - u₂) * w₃ * (a₁ * a₂)
        + w₁ * w₂ * (a₁ * (u₁ - u₃) - a₂ * (u₂ - u₃))
        + w₃ * (w₁ ^ 2 * (u₂ - u₃) - w₂ ^ 2 * (u₁ - u₃) - w₃ ^ 2 * (u₁ - u₂)) := by
  simp [Um, Vm, Matrix.mul_apply, Fin.sum_univ_three]
  ring

/-- **Batch 19's exclusion, on the DEGENERATE spectrum only.** The hypothesis `hi` is batch 19's
equation (i), which is the `k = 3` equation after `D₃ = u₁ - u₂` vanishes, so this holds at
`u ~ (t, t, -2t)` and NOT at a general spectrum. **An earlier docstring credited it to batch 16 as
well, and that was wrong**: it is what made "all three `wₖ` nonzero" look like the whole open case,
when batch 16's open case is at least two. See batch 28, where exactly two is populated. -/
theorem w1_zero_forces (a₁ a₂ w₁ w₂ w₃ : ℝ) (hw : w₁ = 0)
    (hi : w₁ * w₂ * (a₁ - a₂) + w₃ * (w₁ ^ 2 - w₂ ^ 2) = 0) : w₂ ^ 2 * w₃ = 0 := by
  subst hw; linarith [hi]

/-- **Batch 19, the redundancy.** `w₂ (ii) - w₁ (iii)` is `β² a₃` times the constraint `(i)`, so `(i)` is a
consequence of the other two wherever `a₃ ≠ 0`. -/
theorem redundancy (a₁ a₂ a₃ w₁ w₂ w₃ Q β S : ℝ) (ha : a₃ = -a₁ - a₂) (hS : S = w₁ ^ 2 + w₂ ^ 2) :
    w₂ * (w₁ * (Q - β ^ 2 * (a₂ * a₃ - S)) - β ^ 2 * a₃ * w₂ * w₃)
        - w₁ * (w₂ * (Q - β ^ 2 * (a₁ * a₃ - S)) - β ^ 2 * a₃ * w₁ * w₃)
      = β ^ 2 * a₃ * (w₁ * w₂ * (a₁ - a₂) + w₃ * (w₁ ^ 2 - w₂ ^ 2)) := by
  subst ha; subst hS; ring

/-- **Batch 19, the single equation**, reached by the linear combination `w₁ (ii) - w₂ (iii)` with no division,
so it needs neither `a₃ ≠ 0` nor `w₁ ≠ 0`. -/
theorem collapse_from_pair (a₁ a₂ a₃ w₁ w₂ w₃ Q β S : ℝ) (hS : S = w₁ ^ 2 + w₂ ^ 2)
    (h₂ : w₁ * (Q - β ^ 2 * (a₂ * a₃ - S)) - β ^ 2 * a₃ * w₂ * w₃ = 0)
    (h₃ : w₂ * (Q - β ^ 2 * (a₁ * a₃ - S)) - β ^ 2 * a₃ * w₁ * w₃ = 0) :
    (w₁ ^ 2 - w₂ ^ 2) * (Q + β ^ 2 * S) = β ^ 2 * a₃ * (a₂ * w₁ ^ 2 - a₁ * w₂ ^ 2) := by
  subst hS; linear_combination w₁ * h₂ - w₂ * h₃

/-- **Batch 18, why the Jordan top eigenvalue sits on the diagonal block.** For traceless `u`,
`2|U|² - 3 u₃² = (u₁ - u₂)² ≥ 0`, with equality exactly when the other two eigenvalues agree. -/
theorem jordan_gap (u₁ u₂ u₃ : ℝ) (hu : u₁ + u₂ + u₃ = 0) :
    2 * (u₁ ^ 2 + u₂ ^ 2 + u₃ ^ 2) - 3 * u₃ ^ 2 = (u₁ - u₂) ^ 2 := by
  have h : u₃ = -u₁ - u₂ := by linarith
  subst h; ring

/-- The same, as the inequality the bound is used through. -/
theorem jordan_gap_le (u₁ u₂ u₃ : ℝ) (hu : u₁ + u₂ + u₃ = 0) :
    3 * u₃ ^ 2 ≤ 2 * (u₁ ^ 2 + u₂ ^ 2 + u₃ ^ 2) := by
  nlinarith [jordan_gap u₁ u₂ u₃ hu, sq_nonneg (u₁ - u₂)]

/-- **The floor of `q` at the WITHDRAWN halved constant.** This evaluates `q` at `μ = β t`, which is
batch 18's bound before it was corrected, so the algebra is true and the attribution is not: batch 19's
corrected floor uses `μ = 2 β t`, which is `Q_floor_sharp` below. Kept because the halved value is a
lower bound on the floor and the two are worth seeing side by side. -/
theorem Q_floor (t n : ℝ) :
    3 * (15 / 4) * (9 / 4) * t ^ 2 + 3 * ((9 / 4) * t) * ((15 / 4) + (9 / 4)) * t
        + 3 * ((9 / 4) * t) ^ 2 - 1 / 2 * (9 / 4) ^ 2 * n
      = 81 * t ^ 2 - 81 / 32 * n := by ring

/-- And the threshold it gives: the floor is nonpositive exactly when `n ≥ 32 t²`. -/
theorem Q_floor_nonpos_iff (t n : ℝ) : 81 * t ^ 2 - 81 / 32 * n ≤ 0 ↔ 32 * t ^ 2 ≤ n := by
  constructor <;> intro h <;> linarith

/-- **Batch 25's eliminated equation**, as an explicit polynomial in the block data, with
`u₃ = -u₁ - u₂`, `a₃ = -a₁ - a₂` and the eigenvalue gaps `D₁ = u₁ + 2u₂`, `D₂ = 2u₁ + u₂`,
`D₃ = u₁ - u₂` written out. -/
noncomputable def elimPoly (α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ : ℝ) : ℝ :=
  3 * α * w₁ * w₂ * w₃ * ((u₁ + 2 * u₂) * (2 * u₁ + u₂) * (u₁ - u₂))
    - β * (w₁ * w₂ * w₃ * (a₁ ^ 2 * (2 * u₁ + u₂) + 2 * a₁ * a₂ * (u₁ - u₂)
            - a₂ ^ 2 * (u₁ + 2 * u₂))
        + w₁ ^ 2 * w₂ ^ 2 * (a₁ * (2 * u₁ + u₂) - a₂ * (u₁ + 2 * u₂))
        - w₁ ^ 2 * w₃ ^ 2 * ((-a₁ - a₂) * (u₁ + 2 * u₂) + a₁ * (u₁ - u₂))
        + w₂ ^ 2 * w₃ ^ 2 * ((-a₁ - a₂) * (2 * u₁ + u₂) - a₂ * (u₁ - u₂))
        + w₁ * w₂ * w₃ * (w₁ ^ 2 * (u₁ + 2 * u₂) - w₂ ^ 2 * (2 * u₁ + u₂)
            + w₃ ^ 2 * (u₁ - u₂)))

/-- **It transforms by the sign character.** A diagonal transposition negates it. -/
theorem elimPoly_antisymm (α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ : ℝ) :
    elimPoly α β u₂ u₁ a₂ a₁ w₂ w₁ w₃ = -elimPoly α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ := by
  simp only [elimPoly]; ring

/-- A diagonal three-cycle, with the `w` indices cycled the same way as the axes, fixes it. -/
theorem elimPoly_cycle (α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ : ℝ) :
    elimPoly α β u₂ (-u₁ - u₂) a₂ (-a₁ - a₂) w₂ w₃ w₁
      = elimPoly α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ := by
  simp only [elimPoly]; ring

/-- Flipping one eigenvector's sign, which flips two of the three `wₖ`, fixes it. -/
theorem elimPoly_signFlip (α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ : ℝ) :
    elimPoly α β u₁ u₂ a₁ a₂ w₁ (-w₂) (-w₃) = elimPoly α β u₁ u₂ a₁ a₂ w₁ w₂ w₃ := by
  simp only [elimPoly]; ring

/-- **The floor of `q` at the sharp constant**, `μ = 2 β t`, which is what batch 19 actually uses. -/
theorem Q_floor_sharp (t n : ℝ) :
    3 * (15 / 4) * (9 / 4) * t ^ 2 + 3 * ((9 / 2) * t) * ((15 / 4) + (9 / 4)) * t
        + 3 * ((9 / 2) * t) ^ 2 - 1 / 2 * (9 / 4) ^ 2 * n
      = 2673 / 16 * t ^ 2 - 81 / 32 * n := by ring

/-- At the sharp constant the floor is nonpositive exactly when `n ≥ 66 t²`, against `32 t²` at the
withdrawn one. -/
theorem Q_floor_sharp_nonpos_iff (t n : ℝ) :
    2673 / 16 * t ^ 2 - 81 / 32 * n ≤ 0 ↔ 66 * t ^ 2 ≤ n := by
  constructor <;> intro h <;> linarith

/-- **The `α` part of the eliminated equation is one monomial.** Eliminating `μ` and `|V|²` from the
batch 16 system through the second divided difference of `q` leaves a single polynomial equation, and
its `α` part collapses to `3 α w₁ w₂ w₃ D₁ D₂ D₃`, since the cubic below factors into the three
eigenvalue gaps. So the `α` side vanishes exactly when some `wₖ` vanishes or some gap closes. -/
theorem alpha_part_factors (u₁ u₂ u₃ : ℝ) (hu : u₁ + u₂ + u₃ = 0) :
    2 * u₁ ^ 3 + 3 * u₁ ^ 2 * u₂ - 3 * u₁ * u₂ ^ 2 - 2 * u₂ ^ 3
      = (u₁ - u₂) * (u₁ - u₃) * (u₂ - u₃) := by
  have h : u₃ = -u₁ - u₂ := by linarith
  subst h; ring

/-- **The scalar core of the discriminant form.** A quadratic that stays nonpositive for every `t`
has `b² ≤ 4 a c`. Applied to the joint second-order condition along `(Z, t Z)`, this is what turns
the cross term into a bound on `tr (V Z²)²` by a product of two quantities in `U` alone. -/
theorem disc_of_nonpos (a b c : ℝ) (ha : a < 0) (h : ∀ t : ℝ, a * t ^ 2 + b * t + c ≤ 0) :
    b ^ 2 ≤ 4 * a * c := by
  have hne : a ≠ 0 := ne_of_lt ha
  have hb := h (-b / (2 * a))
  have key : a * (-b / (2 * a)) ^ 2 + b * (-b / (2 * a)) + c = c - b ^ 2 / (4 * a) := by
    field_simp
    ring
  rw [key, sub_nonpos] at hb
  have h4 : 4 * a < 0 := by linarith
  rw [le_div_iff_of_neg h4] at hb
  linarith

/-- **The same at `a ≤ 0`, which is all the second-order condition actually supplies.** Batch 22
establishes only `a ≤ 0`, and its screen puts `min(-a)` at `8.8e-4`, so the boundary is nearly met.
At `a = 0` the hypothesis forces `b = 0`, and then `b² = 0 = 4 a c`. -/
theorem disc_of_nonpos' (a b c : ℝ) (ha : a ≤ 0) (h : ∀ t : ℝ, a * t ^ 2 + b * t + c ≤ 0) :
    b ^ 2 ≤ 4 * a * c := by
  rcases lt_or_eq_of_le ha with ha' | ha'
  · exact disc_of_nonpos a b c ha' h
  · subst ha'
    have hb : b = 0 := by
      by_contra hne
      have key : ∀ t : ℝ, b * t + c ≤ 0 := by intro t; have := h t; nlinarith [this]
      have h1 := key ((1 - c) / b)
      have h2 : b * ((1 - c) / b) = 1 - c := by field_simp
      rw [h2] at h1
      linarith
    subst hb
    norm_num

/-- **The second variation of the cubic part**, all four coefficients at once. Taking the step at
`s = 1` loses nothing, since each coefficient is separately homogeneous in `(X, Y)`. The order-two
part `3 α tr (U X X) + β (2 tr (X V Y) + tr (U Y Y))` is the one that carries the cross term, and
that cross term is the only place a second-order statement sees `V` at all. Symmetry of all four
matrices is used, through `tr (U Y V) = tr (U V Y)`. -/
theorem second_variation_expansion (α β p₁ p₂ p₃ p₄ p₅ p₆ q₁ q₂ q₃ q₄ q₅ q₆
    x₁ x₂ x₃ x₄ x₅ x₆ y₁ y₂ y₃ y₄ y₅ y₆ : ℝ) :
    letI U := Vm p₁ p₂ p₃ p₄ p₅ p₆
    letI V := Vm q₁ q₂ q₃ q₄ q₅ q₆
    letI X := Vm x₁ x₂ x₃ x₄ x₅ x₆
    letI Y := Vm y₁ y₂ y₃ y₄ y₅ y₆
    α * ((U + X) * (U + X) * (U + X)).trace + β * ((U + X) * (V + Y) * (V + Y)).trace
      = (α * (U * U * U).trace + β * (U * V * V).trace)
        + (3 * α * (U * U * X).trace + β * ((X * V * V).trace + 2 * (U * V * Y).trace))
        + (3 * α * (U * X * X).trace + β * (2 * (X * V * Y).trace + (U * Y * Y).trace))
        + (α * (X * X * X).trace + β * (X * Y * Y).trace) := by
  simp [Vm, Matrix.trace_fin_three]
  ring

/-- **The constraint expands with no cross term beyond its gradient.** `T(U + X, V + Y)` is
`T(U, V)` plus `3 tr (U X) + tr (V Y)`, the tangency form, plus `T(X, Y)`. -/
theorem constraint_expansion (p₁ p₂ p₃ p₄ p₅ p₆ q₁ q₂ q₃ q₄ q₅ q₆
    x₁ x₂ x₃ x₄ x₅ x₆ y₁ y₂ y₃ y₄ y₅ y₆ : ℝ) :
    letI U := Vm p₁ p₂ p₃ p₄ p₅ p₆
    letI V := Vm q₁ q₂ q₃ q₄ q₅ q₆
    letI X := Vm x₁ x₂ x₃ x₄ x₅ x₆
    letI Y := Vm y₁ y₂ y₃ y₄ y₅ y₆
    3 / 2 * ((U + X) * (U + X)).trace + 1 / 2 * ((V + Y) * (V + Y)).trace
      = (3 / 2 * (U * U).trace + 1 / 2 * (V * V).trace)
        + (3 * (U * X).trace + (V * Y).trace)
        + (3 / 2 * (X * X).trace + 1 / 2 * (Y * Y).trace) := by
  simp [Vm, Matrix.trace_fin_three]
  ring

/-- **The normalisation behind the sharp second-order bound.** If `X` is a Rayleigh direction for
`U` with ratio `c`, the second-order condition in the form the `V` equation actually carries,
`2 β tr (U X X) ≤ μ tr (X X)`, gives `2 β c ≤ μ`. The factor of two is where a first reading of
batch 18 lost half the bound: `{U, V} = 2 𝓛 V`, so the trust-region multiplier is `μ / 2`. -/
theorem mu_ge_of_rayleigh (U X : Matrix (Fin 3) (Fin 3) ℝ) (μ β c : ℝ)
    (hpos : 0 < (X * X).trace)
    (hray : (U * X * X).trace = c * (X * X).trace)
    (hso : 2 * β * (U * X * X).trace ≤ μ * (X * X).trace) :
    2 * β * c ≤ μ := by
  rw [hray] at hso
  nlinarith [hpos, hso]

/-- An off-diagonal direction is a Rayleigh direction with ratio `(u₁ + u₂) / 2`, so it gives
`μ ≥ β (u₁ + u₂)`, which for traceless `u` is `μ ≥ -β u₃`. -/
theorem offdiag_rayleigh (u₁ u₂ u₃ : ℝ) :
    (Um u₁ u₂ u₃ * !![0, 1, 0; 1, 0, 0; 0, 0, 0] * !![0, 1, 0; 1, 0, 0; 0, 0, 0]).trace
      = ((u₁ + u₂) / 2)
        * ((!![0, 1, 0; 1, 0, 0; 0, 0, 0] : Matrix (Fin 3) (Fin 3) ℝ)
            * !![0, 1, 0; 1, 0, 0; 0, 0, 0]).trace := by
  simp [Um, Matrix.trace_fin_three]
  ring

/-- **The value at any critical point**, with the fields eliminated. Pairing each Lagrange equation
with its own variable kills the multiples of `I`, since `U` and `V` are traceless, and leaves
`Φ = 2 μ T - 2 P₃` where `P₃ = α tr U³ + β tr (U V²)` is the cubic part. So at a critical point the
value is determined by the multiplier, the total norm and the cubic part alone. -/
theorem value_at_critical (U V A C : Matrix (Fin 3) (Fin 3) ℝ) (α β μ c₁ c₂ T : ℝ)
    (hU0 : U.trace = 0) (hV0 : V.trace = 0)
    (h1 : (3 * α) • (U * U) + β • (V * V) + A = (3 * μ) • U + c₁ • (1 : Matrix (Fin 3) (Fin 3) ℝ))
    (h2 : β • (U * V + V * U) + C = μ • V + c₂ • (1 : Matrix (Fin 3) (Fin 3) ℝ))
    (hT : T = 3 / 2 * (U * U).trace + 1 / 2 * (V * V).trace) :
    α * (U * U * U).trace + β * (U * V * V).trace + (U * A).trace + (V * C).trace
      = 2 * μ * T - 2 * (α * (U * U * U).trace + β * (U * V * V).trace) := by
  have hc1 : (V * (U * V)).trace = (U * (V * V)).trace := by
    rw [← Matrix.trace_mul_comm (U * V) V, Matrix.mul_assoc]
  have hc2 : (V * (V * U)).trace = (U * (V * V)).trace := by
    rw [← Matrix.mul_assoc, Matrix.trace_mul_comm]
  have e1 := congrArg Matrix.trace (congrArg (fun M => U * M) h1)
  have e2 := congrArg Matrix.trace (congrArg (fun M => V * M) h2)
  simp only [Matrix.mul_add, Matrix.mul_smul, Matrix.trace_add, Matrix.trace_smul,
    Matrix.mul_one, smul_eq_mul, Matrix.mul_assoc, hU0, hV0, mul_zero, add_zero] at e1 e2 ⊢
  rw [hc1, hc2] at e2
  rw [hT]
  linarith [e1, e2]

/-- **Batch 17, the pairing with the commutator.** Pairing the matrix equation with `K` itself
collapses it to one scalar in which the fields no longer appear. Tracelessness is load-bearing,
since the expansion of `⁅A, C⁆` it rests on needs Cayley-Hamilton. -/
theorem paired_identity (u₁ u₂ a₁ a₂ w₁ w₂ w₃ μ α β : ℝ)
    (U V K A C : Matrix (Fin 3) (Fin 3) ℝ) (n q₁ q₂ q₃ : ℝ)
    (hU : U = Um u₁ u₂ (-u₁ - u₂))
    (hV : V = Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
    (hK : K = U * V - V * U)
    (hn : n = a₁ ^ 2 + a₂ ^ 2 + (-a₁ - a₂) ^ 2 + 2 * (w₁ ^ 2 + w₂ ^ 2 + w₃ ^ 2))
    (hq₁ : q₁ = 3 * α * β * u₁ ^ 2 + 3 * μ * (α + β) * u₁ + 3 * μ ^ 2 - 1 / 2 * β ^ 2 * n)
    (hq₂ : q₂ = 3 * α * β * u₂ ^ 2 + 3 * μ * (α + β) * u₂ + 3 * μ ^ 2 - 1 / 2 * β ^ 2 * n)
    (hq₃ : q₃ = 3 * α * β * (-u₁ - u₂) ^ 2 + 3 * μ * (α + β) * (-u₁ - u₂) + 3 * μ ^ 2
        - 1 / 2 * β ^ 2 * n)
    (hA : A = (3 * μ) • U - (3 * α) • (U * U) - β • (V * V))
    (hC : C = μ • V - β • (U * V + V * U)) :
    -((A * C - C * A) * K).trace
      = 2 * ((u₂ - (-u₁ - u₂)) ^ 2 * w₁ ^ 2 * q₁
              + (u₁ - (-u₁ - u₂)) ^ 2 * w₂ ^ 2 * q₂
              + (u₁ - u₂) ^ 2 * w₃ ^ 2 * q₃)
        + β ^ 2 * ((V * K) * (V * K)).trace := by
  subst hU hV hK hn hq₁ hq₂ hq₃ hA hC
  simp [Um, Vm, Matrix.trace_fin_three]
  ring

/-- **Batch 30, the commutator is carried by the field.** Commuting the `V` equation with `U` kills
the multiple of `I` and turns `⁅U, {U, V}⁆` into `⁅U², V⁆ = {U, K}`, leaving one relation between
`K` and `⁅U, C⁆` alone. *An earlier docstring wrote `⁅U, V²⁆` here, a term the `V` equation does not
contain: that one is `{V, K}` and belongs to the `A` equation (r959, r960).* It is an identity of the matrix ring: no symmetry, no tracelessness, no
criticality beyond the one equation. -/
theorem commutator_from_C (U V C : Matrix (Fin 3) (Fin 3) ℝ) (μ β c : ℝ)
    (hC : β • (U * V + V * U) + C = μ • V + c • (1 : Matrix (Fin 3) (Fin 3) ℝ)) :
    μ • (U * V - V * U) - β • (U * (U * V - V * U) + (U * V - V * U) * U)
      = U * C - C * U := by
  have h : C = μ • V + c • (1 : Matrix (Fin 3) (Fin 3) ℝ) - β • (U * V + V * U) := by
    rw [← hC]; abel
  rw [h]
  simp only [Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul,
    Matrix.smul_mul, Matrix.mul_one, Matrix.one_mul, Matrix.mul_assoc]
  module

/-- **Batch 30, the companion from the `U` equation.** The same move on the other Lagrange equation,
commuted with `V` instead, where `⁅V, V²⁆` vanishes outright. Together with `commutator_from_C` this
is two linear relations in the pair `(K, {U, K})`. -/
theorem commutator_from_A (U V A : Matrix (Fin 3) (Fin 3) ℝ) (μ α β c : ℝ)
    (hA : (3 * α) • (U * U) + β • (V * V) + A
      = (3 * μ) • U + c • (1 : Matrix (Fin 3) (Fin 3) ℝ)) :
    V * A - A * V
      = (3 * α) • (U * (U * V - V * U) + (U * V - V * U) * U) - (3 * μ) • (U * V - V * U) := by
  have h : A = (3 * μ) • U + c • (1 : Matrix (Fin 3) (Fin 3) ℝ) - (3 * α) • (U * U)
      - β • (V * V) := by
    rw [← hA]; abel
  rw [h]
  simp only [Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul,
    Matrix.smul_mul, Matrix.mul_one, Matrix.one_mul, Matrix.mul_assoc]
  module

/-- **Batch 30, the eigenframe reading.** In `U`'s eigenframe the relation is diagonal: `{U, K}` has
entry `(uᵢ + uⱼ) Kᵢⱼ = -u_k Kᵢⱼ` by tracelessness, so each off-diagonal entry satisfies
`(μ + β u_k) Kᵢⱼ = ⁅U, C⁆ᵢⱼ`. Hence a field commuting with `U` forces `K = 0` whenever the three
numbers `μ + β u_k` are nonzero, and `μ ≥ 2 β |U| / √6` of batch 18 makes them so at a maximum. -/
theorem entry_relation (u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β : ℝ) :
    (μ • (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
          - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂))
        - β • (Um u₁ u₂ (-u₁ - u₂) * (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
              - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂))
            + (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
              - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂)) * Um u₁ u₂ (-u₁ - u₂))) 0 1
      = (μ + β * (-u₁ - u₂)) * ((u₁ - u₂) * w₃) := by
  simp [Um, Vm]
  ring

theorem entry_relation' (u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β : ℝ) :
    (μ • (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
          - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂))
        - β • (Um u₁ u₂ (-u₁ - u₂) * (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
              - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂))
            + (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
              - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂)) * Um u₁ u₂ (-u₁ - u₂))) 0 2
      = (μ + β * u₂) * ((u₁ - (-u₁ - u₂)) * w₂) := by
  simp [Um, Vm]
  ring

theorem entry_relation'' (u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β : ℝ) :
    (μ • (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
          - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂))
        - β • (Um u₁ u₂ (-u₁ - u₂) * (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
              - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂))
            + (Um u₁ u₂ (-u₁ - u₂) * Vm a₁ a₂ a₃ w₁ w₂ w₃
              - Vm a₁ a₂ a₃ w₁ w₂ w₃ * Um u₁ u₂ (-u₁ - u₂)) * Um u₁ u₂ (-u₁ - u₂))) 1 2
      = (μ + β * u₁) * ((u₂ - (-u₁ - u₂)) * w₁) := by
  simp [Um, Vm]
  ring

theorem K_zero_of_field_commutes (u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β c : ℝ)
    (U V C : Matrix (Fin 3) (Fin 3) ℝ)
    (hU : U = Um u₁ u₂ (-u₁ - u₂)) (hV : V = Vm a₁ a₂ a₃ w₁ w₂ w₃)
    (hC : β • (U * V + V * U) + C = μ • V + c • (1 : Matrix (Fin 3) (Fin 3) ℝ))
    (hcom : U * C = C * U)
    (h₁ : μ + β * u₁ ≠ 0) (h₂ : μ + β * u₂ ≠ 0) (h₃ : μ + β * (-u₁ - u₂) ≠ 0) :
    (u₁ - u₂) * w₃ = 0 ∧ (u₁ - (-u₁ - u₂)) * w₂ = 0 ∧ (u₂ - (-u₁ - u₂)) * w₁ = 0 := by
  have key := commutator_from_C U V C μ β c hC
  rw [hcom, sub_self] at key
  subst hU hV
  refine ⟨?_, ?_, ?_⟩
  · have e := entry_relation u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β
    rw [key] at e
    exact (mul_eq_zero.1 e.symm).resolve_left h₃
  · have e := entry_relation' u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β
    rw [key] at e
    exact (mul_eq_zero.1 e.symm).resolve_left h₂
  · have e := entry_relation'' u₁ u₂ a₁ a₂ a₃ w₁ w₂ w₃ μ β
    rw [key] at e
    exact (mul_eq_zero.1 e.symm).resolve_left h₁

/-- The Lagrange field `A` of batch 10, up to the multiple of `I` that every commutator kills. -/
noncomputable def Afield (μ α β : ℝ) (U V : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  (3 * μ) • U - (3 * α) • (U * U) - β • (V * V)

/-- The Lagrange field `C` of batch 10, likewise. -/
noncomputable def Cfield (μ β : ℝ) (U V : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  μ • V - β • (U * V + V * U)

/-- **Batch 31, the `A`-side eigenframe form**, the companion of `entry_relation`. Reading
`⁅V, A⁆ = 3 α {U, K} - 3 μ K` in `U`'s eigenframe gives `3 (μ + α u_k) Kᵢⱼ = -⁅V, A⁆ᵢⱼ`, so this
commutator is entrywise proportional to `K` too, with `α` where the other carries `β`. Typed at the
entry `(0, 1)`, the other two being its relabellings. -/
theorem entry_relation_A (u₁ u₂ a₁ a₂ w₁ w₂ w₃ μ α β : ℝ) :
    (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃
        * Afield μ α β (Um u₁ u₂ (-u₁ - u₂)) (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
      - Afield μ α β (Um u₁ u₂ (-u₁ - u₂)) (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
        * Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃) 0 1
      = -(3 * (μ + α * (-u₁ - u₂))) * ((u₁ - u₂) * w₃) := by
  simp [Um, Vm, Afield]
  ring

/-- **Batch 31, the field-only identity.** Both field commutators are entrywise proportional to `K`,
so eliminating `K` between them leaves a relation carrying the fields and `U`'s spectrum alone. It
needs only the two Lagrange equations, not maximality. -/
theorem field_only_identity (u₁ u₂ a₁ a₂ w₁ w₂ w₃ μ α β : ℝ) :
    3 * (μ + α * (-u₁ - u₂))
        * (Um u₁ u₂ (-u₁ - u₂)
            * Cfield μ β (Um u₁ u₂ (-u₁ - u₂)) (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
          - Cfield μ β (Um u₁ u₂ (-u₁ - u₂)) (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
            * Um u₁ u₂ (-u₁ - u₂)) 0 1
      + (μ + β * (-u₁ - u₂))
        * (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃
            * Afield μ α β (Um u₁ u₂ (-u₁ - u₂)) (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
          - Afield μ α β (Um u₁ u₂ (-u₁ - u₂)) (Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃)
            * Vm a₁ a₂ (-a₁ - a₂) w₁ w₂ w₃) 0 1
      = 0 := by
  simp [Um, Vm, Afield, Cfield]
  ring

/-- **Batch 33, the first-order orbit condition is criticality restated.** The simultaneous
conjugation `(U, V) ↦ (g U g⁻¹, g V g⁻¹)` preserves both norms and the internal part, so `Φ` varies
along an orbit only through `⟨U, A⟩ + ⟨V, C⟩`, and stationarity there is `⁅U, A⁆ + ⁅V, C⁆ = 0`. With
GENERIC fields that is a real condition. With the Lagrange forms it is an identity, which is
[post F69](../../../findings/fence-posts.md) for a third time: the fields already contain the terms
being commuted. -/
theorem orbit_first_order_vacuous (U V : Matrix (Fin 3) (Fin 3) ℝ) (μ α β : ℝ) :
    (U * Afield μ α β U V - Afield μ α β U V * U)
      + (V * Cfield μ β U V - Cfield μ β U V * V) = 0 := by
  simp only [Afield, Cfield, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_add, Matrix.add_mul,
    Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_assoc]
  module

/-- **The FRAME variation's first order, and it is vacuous too**, [post F69](../../../findings/fence-posts.md)
for a fifth time.

*This is a DIFFERENT direction from `orbit_first_order_vacuous` above*, which moves `U` and `V` together by the
joint conjugation. Here only the frame carrying `V`'s eigenvectors turns, so `U`, `C` and `V`'s spectrum are
fixed and the tangent is `U̇ = 0`, `V̇ = ⁅Ω, V⁆`. The frame-dependent part of the value is
`β tr(U V²) + tr(V C)`, whose variation is `tr(⁅Ω,V⁆ (β{U,V} + C))`, so stationarity for every skew `Ω` is
`⁅V, β{U,V} + C⁆ = 0`.

**Under the `V` equation that bracket is `⁅V, μ V⁆`**, because `β{U,V} + C ≡ μ V` is batch 20's own equation,
so it vanishes for every `U`, `V`, `μ` and `β` with no criticality beyond that one substitution. *So
[I106a](../../../plan.md)'s piece 2 is fenced before it opens, and [R28](../../../routes.md)'s remaining
content is the norm trade.*

**What this does NOT state**: that the same bracket is non-zero for a GENERIC symmetric field in place of
`Cfield`, which is the control post F69 requires and which distinguishes a collapse caused by the substitution
from one caused by the geometry. *That half is screened, at `23.79` against `3.7e-15`, and is not typed.* -/
theorem frame_first_order_vacuous (U V : Matrix (Fin 3) (Fin 3) ℝ) (μ β : ℝ) :
    V * (β • (U * V + V * U) + Cfield μ β U V)
      - (β • (U * V + V * U) + Cfield μ β U V) * V = 0 := by
  simp only [Cfield, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_add, Matrix.add_mul,
    Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_assoc]
  module

/-- **The NORM TRADE's second order, eliminated to closed form.**

[I106a](../../../plan.md)'s piece 3 varies `|U|` against `|V|` at fixed `T = (3/2)|U|² + (1/2)|V|²`. Its tangent
is the RADIAL direction `X = lam • U`, `Y = kap • V`, which is joint rather than a specialisation to one
variable, so unlike the frame direction it does not empty. Batch 21's tangency `3 lam n_U + kap n_V = 0` and
the norm relation `3 n_U + n_V = 2T` eliminate `kap` and `T`, leaving batch 21's expression as a positive
multiple of

  `α p₃ n_V² + β q n_U (3 n_U - 2 n_V) - μ T n_U n_V`,

so the trade contributes exactly `μ ≥ [α p₃ n_V² + β q n_U (3 n_U - 2 n_V)] / (T n_U n_V)`.

*This is the ELIMINATION alone, over reals, which is the step the derivation adds.* The substitution feeding
it is `radial_trace_binding` below.

*Corrected 2026-09-16 on [r968](../../../reviews/REVIEW_r968.md) and [r969](../../../reviews/REVIEW_r969.md).*
**This docstring claimed the substitution needs cyclicity, and that is false**: at the radial direction every
trace becomes the defining trace with a scalar pulled out, in the same word order, so it closes by scalar
extraction alone. Pairing it with `orbit_equals_batch21`, where `X = ⁅W, U⁆` is a genuinely
different matrix, put a `simp`-level step in the class of a real one.

**What the bound is worth**: nothing, and as a THEOREM rather than a screen. The radial pair is one admissible
tangent inside batch 21's quantifier, so batch 21's full condition implies this bound pointwise and nothing can
satisfy batch 21 while failing it. *The earlier reason given here, that the threshold is negative at three
points, is WITHDRAWN: the threshold is not sign-definite, reaching `+4.498` at `U = diag(2,-1,-1)`, so that was
a fact about those points rather than about the bound*
([screen_I106a_containment.py](../../../scripts/misc/screen_I106a_containment.py)). -/
theorem radial_elimination (α β μ lam kap p₃ q nU nV T : ℝ) (hnV : nV ≠ 0)
    (htan : 3 * lam * nU + kap * nV = 0) (hT : 3 * nU + nV = 2 * T) :
    (6 * α * lam ^ 2 * p₃ + 4 * β * lam * kap * q + 2 * β * kap ^ 2 * q)
        - μ * (3 * lam ^ 2 * nU + kap ^ 2 * nV)
      = (6 * lam ^ 2 / nV ^ 2)
        * (α * p₃ * nV ^ 2 + β * q * nU * (3 * nU - 2 * nV) - μ * T * nU * nV) := by
  have hk : kap = -(3 * lam * nU) / nV := by field_simp; linarith
  have hTv : T = (3 * nU + nV) / 2 := by linarith
  subst hk hTv
  field_simp
  ring

/-- **The great-circle expansion of the cubic part**, whose coefficients are the record's four levers.

Along `γ(θ) = cos θ · p + sin θ · Z` the cubic part `Ψ = α tr U³ + β tr(U V²)` expands in `(c, s)` with four
coefficients, and each is an object the record already names:

* `c³` carries `Ψ(p)` itself,
* `c² s` carries `S(Z) = DΨ(p)[Z]`, which at a critical point equals `-(⟨A,X⟩ + ⟨C,Y⟩)`,
* `c s²` carries batch 21's cubic half, `3α tr(U X²) + β (2 tr(X V Y) + tr(U Y²))`,
* `s³` carries `Ξ(Z) = α tr X³ + β tr(X Y²)`, the cubic part at the direction itself.

**This is the object [r971](../../../reviews/REVIEW_r971.md) used to refute the completeness premise.** *Batch
21 is one coefficient of it and batch 29's value comparison is its behaviour at finite `c`, so the two were
never separate kinds of condition*, and the `s³` coefficient is a lever nothing on the record had used. It
carries no `μ`, which is why `batch21_gives_lower_bound`'s sign obstruction does not reach it.

*Stated through `Vm`'s linearity in its six entries, so `c • U + s • X` is `Vm (c p₁ + s x₁) …` exactly and no
`smul` on a matrix literal is needed.* At `c = s = 1` this is `second_variation_expansion`.

**NOT typed**: the collapse to r971's three-term form, which additionally needs criticality, tangency and
`c² + s² = 1`. *Validated numerically instead at `2.3e-13` over `4000` critical points,
[screen_I106a_great_circle.py](../../../scripts/misc/screen_I106a_great_circle.py).* -/
theorem great_circle_expansion (α β c s p₁ p₂ p₃ p₄ p₅ p₆ q₁ q₂ q₃ q₄ q₅ q₆
    x₁ x₂ x₃ x₄ x₅ x₆ y₁ y₂ y₃ y₄ y₅ y₆ : ℝ) :
    letI U := Vm p₁ p₂ p₃ p₄ p₅ p₆
    letI V := Vm q₁ q₂ q₃ q₄ q₅ q₆
    letI X := Vm x₁ x₂ x₃ x₄ x₅ x₆
    letI Y := Vm y₁ y₂ y₃ y₄ y₅ y₆
    letI Uc := Vm (c * p₁ + s * x₁) (c * p₂ + s * x₂) (c * p₃ + s * x₃)
                  (c * p₄ + s * x₄) (c * p₅ + s * x₅) (c * p₆ + s * x₆)
    letI Vc := Vm (c * q₁ + s * y₁) (c * q₂ + s * y₂) (c * q₃ + s * y₃)
                  (c * q₄ + s * y₄) (c * q₅ + s * y₅) (c * q₆ + s * y₆)
    α * (Uc * Uc * Uc).trace + β * (Uc * Vc * Vc).trace
      = c ^ 3 * (α * (U * U * U).trace + β * (U * V * V).trace)
        + c ^ 2 * s * (3 * α * (U * U * X).trace
            + β * ((X * V * V).trace + 2 * (U * V * Y).trace))
        + c * s ^ 2 * (3 * α * (U * X * X).trace
            + β * (2 * (X * V * Y).trace + (U * Y * Y).trace))
        + s ^ 3 * (α * (X * X * X).trace + β * (X * Y * Y).trace) := by
  simp [Vm, Matrix.trace_fin_three]
  ring

/-- **Why NO specialisation of batch 21 can bound `μ` from above.**

Batch 21 reads `LHS(X,Y) ≤ μ * (3|X|² + |Y|²)` for every traceless symmetric tangent `(X, Y)`. The coefficient
of `μ` is `3|X|² + |Y|²`, which is **positive at every nonzero direction** and vanishes only at `X = Y = 0`.
So the inequality always rearranges the same way, to a LOWER bound on `μ`, and never to an upper one.

**That is why the value comparison is out of reach of this family.** Batch 20's `value_at_critical` gives
`Φ = 2μT - 2P₃`, so the comparison `Φ_point < Φ_diag(T)` is exactly an UPPER bound on `μ`. *The obstruction is
the SIGN of the coefficient, not the strength of any particular direction*, which is why four directional
levers in a row came back redundant: batch 18, batch 21 itself, batch 33's orbit and the radial trade all read
`μ ≥ ...`.

*Screened over `200000` nonzero admissible tangents, smallest coefficient `0.747`, never non-positive.* The
positivity is stated here as the hypothesis `hc` rather than derived, since trace-positivity in this layer
would cost more than it teaches. -/
theorem batch21_gives_lower_bound (L c μ : ℝ) (hc : 0 < c) (h : L ≤ μ * c) : L / c ≤ μ := by
  rw [div_le_iff₀ hc]; linarith

/-- **The substitution that feeds `radial_elimination`, and it uses NO cyclicity.**

At the radial direction `X = lam • U`, `Y = kap • V`, each trace in batch 21's expression becomes the defining
trace with a scalar pulled out, in the same word order. *Closing by scalar extraction alone is itself the
evidence*: `Matrix.trace_smul` and `ring`, with no rearrangement of any product.

**This closes the gap [r968](../../../reviews/REVIEW_r968.md) and [r969](../../../reviews/REVIEW_r969.md) named**,
which is the binding of `radial_elimination`'s reals to the matrices' traces. *It is NOT the cyclicity obstacle
this file's docstring first claimed, and it is unrelated to `orbit_equals_batch21`, where `⁅W, U⁆` is a
different matrix and cyclicity is genuinely needed.*

*Symmetry of `U` and `V` is not required for any of the five, which is why none is stated.* -/
theorem radial_trace_binding (U V : Matrix (Fin 3) (Fin 3) ℝ) (lam kap : ℝ) :
    (U * (lam • U) * (lam • U)).trace = lam ^ 2 * (U * U * U).trace
      ∧ ((lam • U) * V * (kap • V)).trace = lam * kap * (U * V * V).trace
      ∧ (U * (kap • V) * (kap • V)).trace = kap ^ 2 * (U * V * V).trace
      ∧ ((lam • U) * (lam • U)).trace = lam ^ 2 * (U * U).trace
      ∧ ((kap • V) * (kap • V)).trace = kap ^ 2 * (V * V).trace := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;>
    simp only [Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul] <;> ring

/-- **The same bracket at a GENERIC field, with no hypothesis at all**, supplied by
[r967](../../../reviews/REVIEW_r967.md). `⁅V, β{U,V} + C⁆ = β ⁅V², U⁆ + ⁅V, C⁆`, because the
anticommutator term collapses: `⁅V, UV + VU⁆ = V²U - UV²`.

*This is the WITNESS that the bracket is generically non-zero*, which `frame_first_order_vacuous`'s
control had carried only as a screen. **It is stronger than the screen it replaces**: it exhibits the
whole obstruction as a formula rather than reporting one field at which the bracket fails to vanish,
and `frame_first_order_vacuous` is now visibly the case where `Cfield`'s `⁅V, C⁆` cancels `β ⁅V², U⁆`.

*The control's earlier reading is withdrawn*: a generic symmetric field is not a critical point's
field at all, so the contrast shows non-triviality rather than separating the substitution from the
geometry ([r967](../../../reviews/REVIEW_r967.md)). -/
theorem frame_bracket_identity (U V C : Matrix (Fin 3) (Fin 3) ℝ) (β : ℝ) :
    V * (β • (U * V + V * U) + C) - (β • (U * V + V * U) + C) * V
      = β • (V * V * U - U * (V * V)) + (V * C - C * V) := by
  simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_smul,
    Matrix.smul_mul, Matrix.mul_assoc]
  module

/-- **Batch 33, the second-order orbit form, which SURVIVES [post F69](../../../findings/fence-posts.md)'s
test.** Substituting the same Lagrange forms into the second variation along the orbit leaves a
relation that is not identically zero, so unlike the first-order condition it carries information.
Stated with `trace (⁅W, X⁆ * ⁅W, X⁆)` rather than a norm, so it needs no skewness of `W`. -/
theorem orbit_second_order_form (U V W : Matrix (Fin 3) (Fin 3) ℝ) (μ α β : ℝ) :
    (W * U - U * W) * (W * Afield μ α β U V - Afield μ α β U V * W)
        + (W * V - V * W) * (W * Cfield μ β U V - Cfield μ β U V * W)
      = μ • (3 • ((W * U - U * W) * (W * U - U * W))
              + (W * V - V * W) * (W * V - V * W))
        - (3 * α) • ((W * U - U * W) * (W * (U * U) - (U * U) * W))
        - β • ((W * U - U * W) * (W * (V * V) - (V * V) * W)
              + (W * V - V * W) * (W * (U * V + V * U) - (U * V + V * U) * W)) := by
  simp only [Afield, Cfield, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_add, Matrix.add_mul,
    Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_assoc]
  module

/-- **Batch 30's claim 4, the elimination, typed.** Taking `3 α` times `commutator_from_C` and `β`
times `commutator_from_A` and adding cancels `{U, K}` with no division, so the relation holds over
any ring and for every `α`, `β`, `μ`. *Both Gate 2 rounds recorded this as typeable and untyped; it
is a linear combination of two declarations already in this file.* **What `α ≠ β` and `μ ≠ 0` buy is
the INVERSION, recovering `K`, which is not what this states.** -/
theorem elimination_of_K (U V A C : Matrix (Fin 3) (Fin 3) ℝ) (μ α β c₁ c₂ : ℝ)
    (hA : (3 * α) • (U * U) + β • (V * V) + A
      = (3 * μ) • U + c₁ • (1 : Matrix (Fin 3) (Fin 3) ℝ))
    (hC : β • (U * V + V * U) + C = μ • V + c₂ • (1 : Matrix (Fin 3) (Fin 3) ℝ)) :
    (3 * (α - β) * μ) • (U * V - V * U)
      = (3 * α) • (U * C - C * U) + β • (V * A - A * V) := by
  have h1 := commutator_from_C U V C μ β c₂ hC
  have h2 := commutator_from_A U V A μ α β c₁ hA
  rw [← h1, h2]
  module

/-- **Batch 33's claim 8, which both Gate 2 readers asked for, typed with its gap named.** The orbit
form equals batch 21's joint second-order expression evaluated at the orbit direction `X = ⁅W, U⁆`,
`Y = ⁅W, V⁆`. **Unlike its neighbours this needs HYPOTHESES**, and that is why it does not close by
`module`: the `α` terms come from the ring identity `⁅W, U²⁆ = {U, X}` and cyclicity, giving
`tr (X {U, X}) = 2 tr (U X²)`, but collapsing the `β` terms needs `tr (X Y V) = tr (X V Y)`, which
holds because `X`, `Y` and `V` are all SYMMETRIC, hence because `W` is skew and `U`, `V` symmetric.

**Proved by exactly those trace rearrangements**, on top of
`orbit_second_order_form`, which is already proved: take its trace, rewrite `⁅W, U²⁆` and `⁅W, V²⁆`
as `{U, X}` and `{V, Y}`, expand `⁅W, {U, V}⁆ = X V + U Y + Y U + V X`, and use cyclicity together
with the symmetry above. *Nothing mathematical is open here; what is missing is the Lean bookkeeping,
and it is recorded rather than hidden.* -/
theorem orbit_equals_batch21 (U V W : Matrix (Fin 3) (Fin 3) ℝ) (μ α β : ℝ)
    (hU : U.IsSymm) (hV : V.IsSymm) (hW : W.transpose = -W) :
    ((W * U - U * W) * (W * Afield μ α β U V - Afield μ α β U V * W)
        + (W * V - V * W) * (W * Cfield μ β U V - Cfield μ β U V * W)).trace
      = μ * (3 * ((W * U - U * W) * (W * U - U * W)).trace
              + ((W * V - V * W) * (W * V - V * W)).trace)
        - (6 * α * (U * ((W * U - U * W) * (W * U - U * W))).trace
            + 4 * β * ((W * U - U * W) * V * (W * V - V * W)).trace
            + 2 * β * (U * ((W * V - V * W) * (W * V - V * W))).trace) := by
  -- Take the trace of the proved operator identity.
  have key := congrArg Matrix.trace (orbit_second_order_form U V W μ α β)
  -- The three rearrangements the docstring names, each stated separately.
  set X := W * U - U * W with hX
  set Y := W * V - V * W with hY
  -- (1) the `α` term: `⁅W, U²⁆ = {U, X}`, then cyclicity gives `tr (X {U,X}) = 2 tr (U X²)`.
  have hUsq : W * (U * U) - (U * U) * W = U * X + X * U := by
    rw [hX]; noncomm_ring
  have hVsq : W * (V * V) - (V * V) * W = V * Y + Y * V := by
    rw [hY]; noncomm_ring
  have hXU : (X * (U * X + X * U)).trace = 2 * (U * (X * X)).trace := by
    rw [Matrix.mul_add, Matrix.trace_add]
    rw [show X * (U * X) = (X * U) * X by noncomm_ring, Matrix.trace_mul_comm (X * U) X,
        show X * (X * U) = (X * X) * U by noncomm_ring, Matrix.trace_mul_comm (X * X) U]
    ring_nf
  have hYV : (Y * (V * Y + Y * V)).trace = 2 * (V * (Y * Y)).trace := by
    rw [Matrix.mul_add, Matrix.trace_add]
    rw [show Y * (V * Y) = (Y * V) * Y by noncomm_ring, Matrix.trace_mul_comm (Y * V) Y,
        show Y * (Y * V) = (Y * Y) * V by noncomm_ring, Matrix.trace_mul_comm (Y * Y) V]
    ring_nf
  -- (3) the mixed `β` term needs `X`, `Y`, `V` symmetric, which follows from `W` skew.
  have hXsymm : X.IsSymm := by
    rw [hX, Matrix.IsSymm, Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul,
        hW, hU.eq]
    noncomm_ring
  have hYsymm : Y.IsSymm := by
    rw [hY, Matrix.IsSymm, Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul,
        hW, hV.eq]
    noncomm_ring
  -- The mixed term: `tr (X V Y) = tr (X Y V)` because all three are symmetric.
  have hmix : (X * V * Y).trace = (X * Y * V).trace := by
    -- `tr M = tr Mᵀ`, and transposing reverses the product while symmetry fixes each factor.
    have h : (X * V * Y).transpose.trace = (Y * V * X).trace := by
      rw [Matrix.transpose_mul, Matrix.transpose_mul, hXsymm.eq, hV.eq, hYsymm.eq]
      rw [Matrix.mul_assoc]
    rw [← Matrix.trace_transpose (X * V * Y), h, Matrix.trace_mul_comm (Y * V) X,
        ← Matrix.mul_assoc]
  -- The THIRD expansion the docstring names, which the first seven attempts omitted:
  -- `⁅W, {U,V}⁆ = X V + U Y + Y U + V X`.
  have hUV : W * (U * V + V * U) - (U * V + V * U) * W = X * V + U * Y + Y * U + V * X := by
    rw [hX, hY]; noncomm_ring
  -- Assemble. `simp` finds the trace structure rather than my predicting the rewrite order.
  rw [hUsq, hVsq, hUV] at key
  simp only [Matrix.trace_sub, Matrix.trace_add, Matrix.trace_smul, smul_eq_mul] at key
  -- The β part of `key` is `tr(X(VY+YV)) + tr(Y(XV+UY+YU+VX))`: the leading factor of the first
  -- is `X`, not `Y`, so `hYV` is not the rearrangement it needs. Cyclicity and `hmix` are.
  have f1 : (X * (U * X)).trace = (U * (X * X)).trace := by
    rw [Matrix.trace_mul_comm X, Matrix.mul_assoc]
  have f2 : (X * (X * U)).trace = (U * (X * X)).trace := by
    rw [← Matrix.mul_assoc, Matrix.trace_mul_comm]
  have f3 : (X * (V * Y)).trace = (X * (Y * V)).trace := by
    rw [← Matrix.mul_assoc, ← Matrix.mul_assoc]; exact hmix
  have f4 : (Y * (X * V)).trace = (X * (V * Y)).trace := by
    rw [Matrix.trace_mul_comm Y, Matrix.mul_assoc]
  have f5 : (Y * (V * X)).trace = (X * (Y * V)).trace := by
    rw [← Matrix.mul_assoc, Matrix.trace_mul_comm]
  have f6 : (Y * (U * Y)).trace = (U * (Y * Y)).trace := by
    rw [Matrix.trace_mul_comm Y, Matrix.mul_assoc]
  have f7 : (Y * (Y * U)).trace = (U * (Y * Y)).trace := by
    rw [← Matrix.mul_assoc, Matrix.trace_mul_comm]
  simp only [Matrix.mul_add, Matrix.add_mul, Matrix.trace_add, Matrix.mul_assoc] at key ⊢
  simp only [f1, f2, f4, f5, f6, f7] at key
  rw [f3] at key ⊢
  linear_combination key


/-- **The bridge the proof above uses, and it is hypothesis-free.** `⁅W, U²⁆ = {U, ⁅W, U⁆}` in any
ring, which is what turns the `α` term of `orbit_second_order_form` into batch 21's `6 α tr (U X²)`
after cyclicity. -/
theorem comm_sq_eq_anticomm (W U : Matrix (Fin 3) (Fin 3) ℝ) :
    W * (U * U) - (U * U) * W
      = U * (W * U - U * W) + (W * U - U * W) * U := by
  noncomm_ring

/-- **The multiples of `I` drop out of every commutator with a field.** Batch 30's blocks say this in
prose, and `Afield` and `Cfield` carry no such multiple, so before this declaration the clause was
typed nowhere (r961, r962). Stated for an arbitrary field `F` and shift `c`, since that is what the
Lagrange forms leave undetermined. -/
theorem I_multiple_drops (W F : Matrix (Fin 3) (Fin 3) ℝ) (c : ℝ) :
    W * (F + c • (1 : Matrix (Fin 3) (Fin 3) ℝ)) - (F + c • (1 : Matrix (Fin 3) (Fin 3) ℝ)) * W
      = W * F - F * W := by
  simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one,
    Matrix.one_mul]
  abel

/-- **Batch 31, the shift drops out of the criterion.** With the external blocks diagonal in the
field frame, `R` and `C` commute, so the shift `U + (2/3) R` pairs with `C` exactly as `U` does. Here
`D` stands for any matrix commuting with `C`, which `R` is. -/
theorem shift_drops (U D C : Matrix (Fin 3) (Fin 3) ℝ) (t : ℝ) (h : D * C = C * D) :
    (U + t • D) * C - C * (U + t • D) = U * C - C * U := by
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.smul_mul, Matrix.mul_smul, h]
  abel

end HamiltonsCubic.I106Criticality
