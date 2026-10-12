import Mathlib

/-!
# L4, a generator for critical points, and the Casimir family, STATED

[ungraded-slack.md](../../../findings/ungraded-slack.md)'s Lemma L4, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> - **Lemma L4 (landscape). A generator for critical points.** Any `K ⊆ SO(n)` with
>   `dim 𝒲ₙ^K = 1` yields a critical point automatically, by equivariance of `Q` and `Q`-closure
>   of `𝒲ₙ`; `(Λ⁴)^K = 0` is unused and unnecessary. The two-eigenvalue Casimir family it draws
>   on has the closed form `θ = (2/n)√(rN/(N−r))`, **derived** at Lemma L23. **The family is not
>   non-diagonalizable**: its own maximiser `𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` is coordinate-diagonal at every
>   even `n`, and only the bi-invariant simple members are established as non-diagonalizable.

and the block's own statement of the criterion:

> **The criterion.** If `K ⊆ SO(n)` satisfies `dim 𝒲ₙ^K = 1`, the `K`-invariant `W` is a critical
> point automatically, by equivariance, no per-example computation. **Two hypotheses carry it
> and both are imports rather than assumptions on `K`**: `O(n)`-equivariance of `Q`, and
> `Q(𝒲ₙ) ⊆ 𝒲ₙ`. **`(Λ⁴ℝⁿ)^K = 0` is not among them**: the argument runs verbatim without it,
> and it is not necessary.

## The criterion is proved here, at the level it actually holds

`generator` below is the criterion, and it is a statement about **any** linear action on **any**
real module together with **any** equivariant self-map: nothing about `SO(n)`, `𝒲ₙ` or curvature
enters the argument. That is the block's own point (*"by equivariance), no per-example
computation"*, and stating it at that level is what makes `(Λ⁴)^K = 0` visibly unused, since
there is no `Λ⁴` in the statement to assume anything about.

**The two imports are the two hypotheses of `generator`.** `Q` maps `V` to `V` (the `Q`-closure
of `𝒲ₙ`, which the record takes from
[Böhm–Wilking](../../../references/boehm-wilking-2008-space-forms/) eq. (6) together with
Hamilton's Bianchi preservation) and `Q` commutes with the action (`O(n)`-equivariance of `Q`,
which is classical). Both are published inputs, so both are binders.

## What is NOT typed here

* **That `Q(W) = θW` is criticality of `P` on the unit sphere.** `IsEigen` below records the
  conclusion in the form the record's proof produces it; the identification with vanishing of the
  constrained gradient is `∇P = 3Q(W)` and is the record's, not typed here.
* **That `𝒲ₙ` is a module and `Q` maps it to itself.** `generator` is applied to `V = 𝒲ₙ` by the
  record; the Lean layer has no `Q`, so the specialisation is not written.
* **The derivation of the closed form `θ = (2/n)√(rN/(N−r))`**, which is
  [Lemma L23](../../../findings/ungraded-slack.md)'s, from the two block-averaged trace equations
  and the Killing relations. What is typed here is the arithmetic L4 reads off it: the
  monotonicity, the cap, the evaluation at the cap, the two named points, and the padding error.
* **The two-eigenvalue property**, which the block says is *"a property of this family, not a
  consequence of the criterion"*, `U(3)` at `n = 6` has `dim 𝒲₆^{U(3)} = 1` with three
  eigenvalues, and *"nothing on file bridges the two"*.

There is no `sorry`.
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L4Statement

/-! ## The criterion -/

variable {G V : Type*} [AddCommGroup V] [Module ℝ V]

/-- **The `K`-invariants of a linear action**, as a submodule. -/
def fixedSub (act : G → V →ₗ[ℝ] V) : Submodule ℝ V where
  carrier := {v | ∀ g, act g v = v}
  add_mem' := by intro a b ha hb g; simp [ha g, hb g]
  zero_mem' := by intro g; simp
  smul_mem' := by intro c a ha g; simp [ha g]

/-- **`W` is a critical point of the family**, in the form the record's criticality equation
takes: `Q(W) = θW`. -/
def IsEigen (Q : V → V) (W : V) : Prop := ∃ θ : ℝ, Q W = θ • W

/-- **L4's criterion.** Let a group act linearly on `V`, let `Q : V → V` be equivariant, and
suppose the invariant submodule is the line spanned by `W`. Then `Q(W) = θW`: `W` is a critical
point, automatically.

*The two hypotheses are exactly the block's two imports, `Q` maps `V` into `V`, and `Q` commutes
with the action. Nothing is assumed about the acting group, and in particular no `Λ⁴` condition
appears: `(Λ⁴)^K = 0` is unused and unnecessary, which is what stating the criterion at this
level makes visible.* -/
theorem generator {act : G → V →ₗ[ℝ] V} {Q : V → V} {W : V}
    (hequiv : ∀ (g : G) (v : V), Q (act g v) = act g (Q v))
    (hfix : fixedSub act = Submodule.span ℝ {W}) :
    IsEigen Q W := by
  have hW : W ∈ fixedSub act := by
    rw [hfix]; exact Submodule.mem_span_singleton_self W
  have hQW : Q W ∈ fixedSub act := by
    intro g
    rw [← hequiv g W, hW g]
  rw [hfix, Submodule.mem_span_singleton] at hQW
  obtain ⟨θ, hθ⟩ := hQW
  exact ⟨θ, hθ.symm⟩

/-- **The criterion is not vacuous.** `V = ℝ` with the trivial action of a one-element group has
invariant submodule the line spanned by `1`, and doubling is equivariant; the criterion returns
`Q(1) = 2·1`. -/
example : IsEigen (fun x : ℝ => 2 * x) (1 : ℝ) := by
  refine generator (act := fun _ : Unit => LinearMap.id) (Q := fun x : ℝ => 2 * x)
    (fun g v => by simp) ?_
  ext x
  simp only [fixedSub, Submodule.mem_mk, AddSubmonoid.mem_mk, AddSubsemigroup.mem_mk,
    Set.mem_ofPred_eq, Submodule.mem_span_singleton]
  exact ⟨fun _ => ⟨x, by simp⟩, fun _ _ => rfl⟩

/-! ## The Casimir family's closed form, and the arithmetic L4 reads off it -/

/-- `N = C(n,2) = n(n−1)/2`, the dimension of `Λ²ℝⁿ`. -/
noncomputable def Ndim (n : ℝ) : ℝ := n * (n - 1) / 2

/-- **`θ² = 4rN/(n²(N−r))`**, the square of the family's closed form `θ = (2/n)√(rN/(N−r))`. -/
noncomputable def thetaCasSq (n r : ℝ) : ℝ := 4 * r * Ndim n / (n ^ 2 * (Ndim n - r))

/-- `θ₀(n)² = 2(n−1)(n−2)/n²`. -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **`θ` increases with `r` at fixed `n`**, strictly, on `0 < r < N`. *The block insists on the
quantifier: the monotonicity is in `r` at fixed `n` alone.* -/
theorem thetaCasSq_mono {n r r' : ℝ} (hn : 0 < n) (hr : 0 < r) (hrr : r < r')
    (hr' : r' < Ndim n) : thetaCasSq n r < thetaCasSq n r' := by
  have hN : 0 < Ndim n := by linarith
  have h1 : 0 < Ndim n - r := by linarith
  have h2 : 0 < Ndim n - r' := by linarith
  have hn2 : 0 < n ^ 2 := by positivity
  unfold thetaCasSq
  rw [div_lt_div_iff₀ (by positivity) (by positivity)]
  nlinarith [mul_pos hn2 hN, mul_pos (mul_pos hn2 hN) (sub_pos.mpr hrr)]

/-- **The cap.** `S_{𝔪𝔪𝔪}` is a sum of squares, so it is nonnegative, and its closed form
`(r/(nN))[4(N−r) − n²]` makes that exactly `r ≤ n(n−2)/4`. -/
theorem cap_iff {n r : ℝ} (hn : 0 < n) : 4 * (Ndim n - r) - n ^ 2 ≥ 0 ↔ r ≤ n * (n - 2) / 4 := by
  unfold Ndim
  constructor <;> intro h <;> linarith

/-- **At the cap the family attains `θ₀(n)` exactly**, so the maximum over the family is the
balanced sphere product's value. -/
theorem thetaCasSq_at_cap {n : ℝ} (hn : 4 ≤ n) :
    thetaCasSq n (n * (n - 2) / 4) = theta0Sq n := by
  have hn0 : 0 < n := by linarith
  have hres : Ndim n - n * (n - 2) / 4 = n ^ 2 / 4 := by unfold Ndim; ring
  unfold thetaCasSq theta0Sq
  rw [hres]
  unfold Ndim
  rw [div_eq_div_iff (by positivity) (by positivity)]
  ring

/-- **Hence `θ ≤ θ₀(n)` on the family**, at every admissible `r`: the cap plus the monotonicity.
*The second step is the one [Lemma L23](../../../findings/ungraded-slack.md)'s proof uses and did
not state.* -/
theorem thetaCasSq_le_theta0 {n r : ℝ} (hn : 4 ≤ n) (hr : 0 < r) (hcap : r ≤ n * (n - 2) / 4) :
    thetaCasSq n r ≤ theta0Sq n := by
  rcases eq_or_lt_of_le hcap with h | h
  · rw [h, thetaCasSq_at_cap hn]
  · have hlt : n * (n - 2) / 4 < Ndim n := by unfold Ndim; nlinarith
    rw [← thetaCasSq_at_cap hn]
    exact le_of_lt (thetaCasSq_mono (by linarith) hr h hlt)

/-! ## The two named points, and the ceiling -/

/-- **`SU(3)` at `n = 8`**: `r = 8`, `N = 28`, `θ² = 7/10`. -/
theorem su3 : Ndim 8 = 28 ∧ thetaCasSq 8 8 = 7 / 10 := by
  refine ⟨by unfold Ndim; norm_num, ?_⟩
  unfold thetaCasSq Ndim; norm_num

/-- **`SU(6)/Sp(3)` at `n = 14`**: `r = 21`, `N = 91`, `θ² = 39/70`. -/
theorem sp3 : Ndim 14 = 91 ∧ thetaCasSq 14 21 = 39 / 70 := by
  refine ⟨by unfold Ndim; norm_num, ?_⟩
  unfold thetaCasSq Ndim; norm_num

/-- **Across dimensions the family's own members reverse the monotonicity**: `r = 21` at `n = 14`
sits below `r = 8` at `n = 8`. *This is why the monotonicity clause needs its quantifier.* -/
theorem monotonicity_is_in_r_alone : thetaCasSq 14 21 < thetaCasSq 8 8 := by
  rw [(sp3).2, (su3).2]; norm_num

/-- **The simple-isotropy ceiling is `(3/4)√(10/7)`, not `√(7/10)`**, attained by
`𝔰𝔭𝔦𝔫(9) ⊂ 𝔰𝔬(16)`, where `r = 36`, `N = 120` and `θ² = 45/56`. -/
theorem spin9_ceiling : Ndim 16 = 120 ∧ thetaCasSq 16 36 = 45 / 56 ∧
    (3 / 4 : ℝ) ^ 2 * (10 / 7) = 45 / 56 ∧ thetaCasSq 8 8 < thetaCasSq 16 36 := by
  have h1 : Ndim 16 = 120 := by unfold Ndim; norm_num
  have h2 : thetaCasSq 16 36 = 45 / 56 := by unfold thetaCasSq Ndim; norm_num
  refine ⟨h1, h2, by norm_num, ?_⟩
  rw [h2, (su3).2]; norm_num

/-- **And the ceiling is below the value the elimination stands against**, `√(56/45)`:
`45/56 < 56/45`. -/
theorem ceiling_below_hp2 : (45 : ℝ) / 56 < 56 / 45 := by norm_num

/-! ## Padding: the closed form must not be read at a padded member -/

/-- **Reading the closed form at the padded object is an error.** `SU(3)` padded from `n = 8`
into `n = 12` keeps `θ² = 7/10`, while `(n,r) = (12,8)` returns `22/87`. *The padded object is
not a member: it has a `38`-dimensional kernel and `dim 𝒲₁₂^K = 1` fails.* -/
theorem padding_error : thetaCasSq 12 8 = 22 / 87 ∧ thetaCasSq 12 8 ≠ thetaCasSq 8 8 := by
  have h : thetaCasSq 12 8 = 22 / 87 := by unfold thetaCasSq Ndim; norm_num
  refine ⟨h, ?_⟩
  rw [h, (su3).2]
  norm_num

/-- **And `22/87` is the block's `0.502866`**, bracketed by squaring. -/
theorem padding_error_bracket :
    ((0.502865 : ℝ)) ^ 2 < 22 / 87 ∧ (22 : ℝ) / 87 < (0.502867 : ℝ) ^ 2 := by
  constructor <;> norm_num

/-! ## The cap is not an integer at odd `n` -/

/-- **`n(n−2)/4` is an integer only at even `n`**: at `n = 13` it is `143/4`, so the equality
case of the cap is empty there and the inequality is strict. -/
theorem cap_not_integral_at_thirteen : (13 : ℝ) * (13 - 2) / 4 = 143 / 4 := by norm_num

end HamiltonsCubic.L4Statement
