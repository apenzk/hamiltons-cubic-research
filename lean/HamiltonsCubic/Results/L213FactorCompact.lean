import Mathlib.Tactic
import Mathlib.Topology.Algebra.Group.Quotient

/-!
# Lemma L213, each irreducible factor is itself compact

[findings/problem.md](../../../findings/problem.md), the L213 block.

**What the Theorem owed.** [Lemma L211](../../../findings/problem.md) delivers compact TYPE for
every irreducible factor, while [L47](../../../findings/problem.md)'s census is of compact
SPACES, and nothing on the record bridged the two ([r921](../../../reviews/REVIEW_r921.md)).
The bridge is [Ziller](../../../references/ziller-2010-lie-groups-symmetric-spaces/notes.md)'s
Proposition 6.38(c): *if `(G, K)` is of compact type, then `G` is semisimple and `G` and `M` are
compact.*

## What is typed here, and what is not

Its proof has two halves and **both are typed**.

- `negDef_of_orthogonal_parts` is the LINEAR ALGEBRA half: a symmetric form negative definite on
  each of two `B`-orthogonal summands is negative definite on their sum. *That is why compact
  type, a condition on `p` alone, is the same thing as the Killing form being negative definite
  on all of `g`, once Lemma 2.1.2(b) supplies the sign on `k` and `β(k, p) = 0` separates them.*
- `negDef_of_span` is what the block actually needs, and it is the repair Gate 2 forced: the
  lemma above is stated at `x ∈ K` and `y ∈ P`, so the SPANNING `𝔤 = 𝔨 ⊕ 𝔭` was doing silent work
  in prose. Here it is a binder and the conclusion is definiteness on the whole space.
- `quotient_compactSpace` is the TOPOLOGICAL half: a quotient of a compact group is compact, so
  `M = G / K` is compact as soon as `G` is. *Mathlib gives it for ANY subgroup, closedness not
  needed, the quotient being a continuous image. It stands for the step where no difficulty lies:
  the load is in `Z(G)` being finite, which this layer does not reach.*

**Not typed**: that a compact Lie algebra has compact `Inn(g)`, which is Theorem 5.5.1(b) and
about Lie groups the layer does not carry; that the universal cover of a symmetric space is a
product of irreducible symmetric spaces; and the identification of `θ` on a cover with `θ`
downstairs. *Each is a statement about manifolds and groups, and this layer has neither.*
-/

namespace HamiltonsCubic.Results

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- **THE LINEAR ALGEBRA HALF OF PROPOSITION 6.38(c).** A symmetric bilinear form that is
negative definite on each of two summands, and pairs them to zero, is negative on every nonzero
element of their sum.

*In the application `K` is `𝔨` with Lemma 2.1.2(b)'s sign, `P` is `𝔭` with compact type's sign,
and `hortho` is `β(𝔨, 𝔭) = 0`. The conclusion is that `β` is negative definite on `𝔤`, which is
what Corollary 5.5.2 turns into `𝔤` being a compact Lie algebra.* -/
theorem negDef_of_orthogonal_parts (B : V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    {K P : Submodule ℝ V}
    (hortho : ∀ x ∈ K, ∀ y ∈ P, B x y = 0) (hsymm : ∀ x y : V, B x y = B y x)
    (hK : ∀ x ∈ K, x ≠ 0 → B x x < 0) (hP : ∀ y ∈ P, y ≠ 0 → B y y < 0)
    {x y : V} (hx : x ∈ K) (hy : y ∈ P) (hne : x + y ≠ 0) :
    B (x + y) (x + y) < 0 := by
  have hxy : B x y = 0 := hortho x hx y hy
  have hyx : B y x = 0 := by rw [hsymm]; exact hxy
  have hexp : B (x + y) (x + y) = B x x + B y y := by
    simp only [map_add, LinearMap.add_apply]
    rw [hxy, hyx]; ring
  rw [hexp]
  rcases eq_or_ne x 0 with hx0 | hx0
  · have hy0 : y ≠ 0 := by rw [hx0, zero_add] at hne; exact hne
    have : B x x = 0 := by rw [hx0]; simp
    rw [this]; simpa using hP y hy hy0
  · rcases eq_or_ne y 0 with hy0 | hy0
    · have : B y y = 0 := by rw [hy0]; simp
      rw [this]; simpa using hK x hx hx0
    · have := hK x hx hx0
      have := hP y hy hy0
      linarith

/-- **DEFINITENESS ON THE WHOLE SPACE, WHICH IS WHAT THE BLOCK NEEDS AND THE LEMMA ABOVE DOES
NOT GIVE.** *Both Gate 2 readers found `negDef_of_orthogonal_parts` short of its billing: stated
at `x ∈ K` and `y ∈ P` it says nothing about a `v` nobody has written as such a sum, so the
spanning was doing silent work in prose.* Here it is a binder: `hspan` is `V = K + P`, and the
conclusion is that `B` is negative definite on `V`.

*In the application `hspan` is `𝔤ᵢ = 𝔨ᵢ ⊕ 𝔭ᵢ`, the eigenspace decomposition of the involution,
so it costs nothing there and it is exactly what was missing from the statement.* -/
theorem negDef_of_span (B : V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    {K P : Submodule ℝ V}
    (hspan : ∀ v : V, ∃ x ∈ K, ∃ y ∈ P, v = x + y)
    (hortho : ∀ x ∈ K, ∀ y ∈ P, B x y = 0) (hsymm : ∀ x y : V, B x y = B y x)
    (hK : ∀ x ∈ K, x ≠ 0 → B x x < 0) (hP : ∀ y ∈ P, y ≠ 0 → B y y < 0)
    {v : V} (hv : v ≠ 0) :
    B v v < 0 := by
  obtain ⟨x, hx, y, hy, rfl⟩ := hspan v
  exact negDef_of_orthogonal_parts B hortho hsymm hK hP hx hy hv

/-- **THE TOPOLOGICAL HALF.** `M = G / K` is compact once `G` is, for any subgroup `K`.

*It stands for the step where no difficulty lies, and BOTH GATE 2 READERS SAID SO. The step that
carries the load is the one between: `Inn(𝔤) = G / Z(G)`, so a compact `Inn(𝔤)` gives a compact
`G` only when `Z(G)` is finite, which is Weyl's theorem. The block now cites Proposition 6.38(c)
for its conclusion rather than rebuilding it through `Inn(𝔤)`.* -/
theorem quotient_compactSpace {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] (K : Subgroup G) : CompactSpace (G ⧸ K) :=
  inferInstance

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.negDef_of_orthogonal_parts
#print axioms HamiltonsCubic.Results.negDef_of_span
#print axioms HamiltonsCubic.Results.quotient_compactSpace
