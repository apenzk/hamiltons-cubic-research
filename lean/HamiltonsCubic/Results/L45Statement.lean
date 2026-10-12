import Mathlib

set_option linter.style.longLine false

/-!
# L45, stated as the parity argument and the triple census it runs on

## The record's statement, verbatim

> For general $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$, five of the ten distinct triples of the
> cubic vanish and five survive:
> \[
> \langle R,\Phi(R)\rangle=\underbrace{c^3(n-1)\|I\|^2+3c\langle I,\Phi(Y)\rangle+\langle
> Y,\Phi(Y)\rangle}_{W\text{-even}}
> +\underbrace{3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle}_{W\text{-odd}} .
> \]
> Against the slice exactly one new coupling appears, the triple $(Y,Y,W)$, equal to
> $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$; every $I$--$W$ pairing
> vanishes. The $\Omega_0$ constraint depends only on $\|W\|$, so $cI+Y-W\in\Omega_0$ whenever
> $cI+Y+W$ is, and demanding the criterion at both signs gives the two-sided bound
> \[
> \big|\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\big|\;\le\;\mathrm{RHS}_{\rm
> even}-\mathrm{LHS}_{\rm even},
> \qquad \mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle .
> \]

The block now states `n ≥ 4`, the multiplicities `1,3,1,3,1` from the total symmetry of the
trilinear form, the constant `3/(n-2)` as multiplicity `3` times trilinear value `1/(n-2)` in
Böhm–Wilking's normalisation, and `RHS_even`, `RHS_odd` as the `W`-parity parts of the right side;
`RHS_even - LHS_even ≥ 0` follows by adding the two instances.

[target.md](../../../findings/target.md), Lemma L45.

## What this file states

Three parts, all of them free of the curvature layer and all proved here.

* **The reflection argument.** Reading the criterion at `+W` and at `-W` gives the two-sided
  bound, and gives `RHS_even ≥ LHS_even` as a consequence rather than a hypothesis. This is the
  lemma's actual mechanism and it is pure inequality manipulation.
* **The parity facts it rests on.** `Q` even makes the cubic odd; the `Ω₀` premise is invariant
  under `W ↦ -W` because it reads `‖W‖` only.
* **The triple census.** Ten multisets of size three over `{I, Y, W}`, split five and five, with
  multinomial weights `1,3,1,3,1` on the survivors and `3,3,6,3,3` on the vanishers, summing to
  `9` and `18` and so to `27 = 3³`; and no survivor carries weight `6`.

**Not typed here:** the identification of the surviving and vanishing triples with the terms of
`⟨R, Φ(R)⟩`, and the value `3/(n-2)⟨W, Ric₀ ∧ Ric₀⟩` of the new coupling. Both need `Φ`, `Q`,
`Ric₀` and the wedge, which is the curvature layer. The census below is the combinatorial
skeleton those terms are indexed by, and the multiplicities `1,3,1,3,1` are a statement about that
skeleton alone.
-/

namespace HamiltonsCubic.L45

/-! ## The reflection argument -/

/-- **The two-sided bound.** `Le`, `Lo`, `Re`, `Ro` are the `W`-even and `W`-odd parts of the two
sides. `hplus` is the criterion at `cI + Y + W`, `hminus` at `cI + Y - W`; the second is available
because `Ω₀` reads `‖W‖` only. -/
theorem two_sided {Le Lo Re Ro : ℝ} (hplus : Le + Lo ≤ Re + Ro) (hminus : Le - Lo ≤ Re - Ro) :
    |Lo - Ro| ≤ Re - Le := by
  rw [abs_le]
  constructor <;> linarith

/-- **`RHS_even - LHS_even ≥ 0` is implied by adding the two instances**, so it is a consequence
and not an extra hypothesis. -/
theorem even_gap_nonneg {Le Lo Re Ro : ℝ} (hplus : Le + Lo ≤ Re + Ro)
    (hminus : Le - Lo ≤ Re - Ro) : 0 ≤ Re - Le := by linarith

/-! ## The parity facts -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-- **The cubic is odd.** `Q` is even (it is quadratic) and the pairing adds one factor of `W`,
so `⟨W, Q(W)⟩` changes sign with `W`. This is what makes the reflection argument's two instances
differ only in the odd part. -/
theorem cubic_odd (Q : V → V) (hQ : ∀ x : V, Q (-x) = Q x) (x : V) :
    (inner ℝ (-x) (Q (-x)) : ℝ) = -inner ℝ x (Q x) := by
  rw [hQ, inner_neg_left]

/-- **The `Ω₀` premise is `W`-sign-symmetric**, its clauses reading `‖W‖` only. -/
theorem omega0_sign_symmetric (φ : ℝ → Prop) (W : V) : φ ‖(-W)‖ ↔ φ ‖W‖ := by rw [norm_neg]

/-! ## The triple census

*Multisets of size three over the three summands of `R = cI + Y + W`, written as exponent triples
`(i,j,k)` with `i + j + k = 3` for the powers of `I`, `Y` and `W`. The multinomial weight is
`3!/(i! j! k!)`, and it is the number of ordered triples the multiset stands for.* -/

/-- The multinomial weight of an exponent triple. -/
def weight (t : ℕ × ℕ × ℕ) : ℕ :=
  Nat.factorial 3 / (Nat.factorial t.1 * Nat.factorial t.2.1 * Nat.factorial t.2.2)

/-- The five surviving triples, in the order the record's display writes them:
`(I,I,I)`, `(I,Y,Y)`, `(Y,Y,Y)`, `(Y,Y,W)`, `(W,W,W)`. -/
def survivors : List (ℕ × ℕ × ℕ) := [(3, 0, 0), (1, 2, 0), (0, 3, 0), (0, 2, 1), (0, 0, 3)]

/-- The five vanishing triples: `(I,I,Y)`, `(I,I,W)`, `(I,Y,W)`, `(I,W,W)`, `(Y,W,W)`. -/
def vanishers : List (ℕ × ℕ × ℕ) := [(2, 1, 0), (2, 0, 1), (1, 1, 1), (1, 0, 2), (0, 1, 2)]

/-- **There are ten triples in all.** -/
theorem ten_triples :
    ((Finset.univ : Finset (Fin 4 × Fin 4 × Fin 4)).filter
      (fun t => (t.1 : ℕ) + (t.2.1 : ℕ) + (t.2.2 : ℕ) = 3)).card = 10 := by decide

/-- **Five survive and five vanish, and the ten are distinct.** -/
theorem five_and_five :
    survivors.length = 5 ∧ vanishers.length = 5 ∧ (survivors ++ vanishers).Nodup := by
  refine ⟨rfl, rfl, ?_⟩
  decide

/-- **Every listed triple is an exponent triple of total degree three.** -/
theorem degrees : ∀ t ∈ survivors ++ vanishers, t.1 + t.2.1 + t.2.2 = 3 := by decide

/-- **The survivors' multiplicities are `1,3,1,3,1`.** -/
theorem survivor_weights : survivors.map weight = [1, 3, 1, 3, 1] := by decide

/-- **The vanishers' multiplicities are `3,3,6,3,3`**, the weight-`6` triple `(I,Y,W)` among
them. -/
theorem vanisher_weights : vanishers.map weight = [3, 3, 6, 3, 3] := by decide

/-- **No survivor carries multiplicity `6`.** -/
theorem no_survivor_has_weight_six : ∀ t ∈ survivors, weight t ≠ 6 := by decide

/-- **The partition checks: `9 + 18 = 27 = 3³`.** -/
theorem weights_partition :
    (survivors.map weight).sum = 9 ∧ (vanishers.map weight).sum = 18 ∧ 9 + 18 = 3 ^ 3 := by
  refine ⟨by decide, by decide, by norm_num⟩

/-- **The new coupling's constant splits as weight times trilinear value.** The `3` in
`3/(n-2)` is `(Y,Y,W)`'s multinomial weight and the `1/(n-2)` is the trilinear value, so the
normalisation of `Ric₀` is what the constant depends on, not the `3`. -/
theorem coupling_split (x : ℝ) :
    3 / (x - 2) = (weight (0, 2, 1) : ℝ) * (1 / (x - 2)) := by
  have h : weight (0, 2, 1) = 3 := by decide
  rw [h]
  push_cast
  ring

end HamiltonsCubic.L45
