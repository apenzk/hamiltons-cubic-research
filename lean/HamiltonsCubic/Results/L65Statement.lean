import Mathlib

set_option linter.style.longLine false

/-!
# L65, the seed is the inclusion padded by cups

## The record's statement, verbatim

[brauer-pairing.md](../../../findings/brauer-pairing.md)'s *Lemma L65, the seed is the inclusion
padded by cups*:

> Let $n\ge1$ and let $\lambda$ be an $O(n)$-admissible label with
> $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. Write $k=(12-\lvert\lambda\rvert)/2$, let
> $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion and
> $\mathrm{cup}=\sum_ae_a\otimes e_a$ the invariant metric element. Then
> $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of
> $\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$, so the seed of every block is given in closed
> form and need not be searched for. Admissibility is what makes $V_\lambda$ nonzero, and it holds
> whenever $\lvert\lambda\rvert\le n$.

and, in the section of the same file that proves it, the nonvanishing step:

> *Nonvanishing.* For $x\ne0$, $\iota_\lambda(x)\ne0$, and $\mathrm{cup}\ne0$ because $n\ge1$, so
> $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is a tensor product of nonzero vectors and is
> nonzero. Equivalently, the contraction applying $\langle\cdot,\cdot\rangle$ to the two factors of
> one cup returns $\sum_a\langle e_a,e_a\rangle=n$, so contracting all $k$ cups returns
> $n^k\iota_\lambda\ne0$.

## What is typed here

The lemma has three separable claims, and each is typed in the generality its own argument uses:

1. **Equivariance is closure of the tensor product under equivariant maps.** That is proved below
   for `Representation.tprod`, the tensor product of two `ℝ`-linear representations of an
   arbitrary group `G`, so the statement covers the full `O(n)`, reflection included, and does
   not depend on which group it is.
2. **Nonvanishing, by the cap.** The record gives two reasons and prefers the second, since it
   proves *the map* nonzero: the cap computation returns `nᵏ ι_λ`. That is what is typed, a map
   with a left inverse up to a nonzero scalar multiple of a nonzero map is itself nonzero.
3. **Admissibility is load-bearing.** Without it `V_λ = 0`, and every linear map out of the zero
   module is zero, so no nonzero seed exists there. The record's three witnesses,
   `λ = (2,2)` at `n = 2, 3` and `λ = (2,1,1)` at `n = 3`, and its tightness point
   `λ = (2,2,2,2,2,2)` at `n = 12` are checked as arithmetic against
   [L65.lean](L65.lean)'s `rows`/`rows2`.

Together with the leg-count arithmetic `2k + |λ| = 12`, that is the lemma's mechanism.

## What is NOT typed here

**The seed itself.** `V_λ` as an `O(n)`-irreducible, `ι_λ` as the inclusion into `V^{⊗|λ|}`,
`cup = Σ_a e_a ⊗ e_a` as the invariant metric element, and the identification of
`ι_λ ⊗ cup^{⊗k}` with an element of `M_λ = Hom_{O(n)}(V_λ, V^{⊗12})` need the tensor-power
functor on `O(n)`-representations, Brauer diagrams and Weyl's construction, none of which exists
in this repository, [WeylReal.lean](../Base/WeylReal.lean) carries `IsWeyl`, `Qop`, `IsCritical`,
`Pcubic` and `theta`, and the brief names the Brauer layer as unnameable. **So `c₀` is not
constructed below**, and the three claims are stated about abstract maps rather than about it.

**The cap computation `cup^{⊗k} · cup^{⊗k} = nᵏ`.** It is the input to claim 2 and enters as the
hypothesis `hcap`; the record derives it, one cup contracting to `Σ_a ⟨e_a, e_a⟩ = n`.

**That `λ` admissible implies `V_λ ≠ 0`.** That is Weyl's construction for `O(n)`; claim 3 runs in
the contrapositive direction, which is the one the record calls load-bearing.
-/

namespace HamiltonsCubic.L65Statement

open TensorProduct

/-! ## The leg count

*"Write `k = (12 − |λ|)/2`"*, `12` being three Weyl tensors at four legs each. -/

/-- **`2k + |λ| = 12`.** The seed's `k` cups and `|λ|` free legs fill the `12` exactly. *`|λ|` is
even because `12` is, which is why `k` is an integer at all.* -/
theorem legs (f : ℕ) (hf : f ≤ 12) (heven : f % 2 = 0) : 2 * ((12 - f) / 2) + f = 12 := by
  omega

/-- **`k = 0` exactly at `|λ| = 12`**, *"a **padding** diagram only where `k > 0`"*, and at the
`16` blocks with `|λ| = 12` there is no cup at all. -/
theorem no_cup_iff (f : ℕ) (hf : f ≤ 12) (heven : f % 2 = 0) : (12 - f) / 2 = 0 ↔ f = 12 := by
  omega

/-! ## Claim 1, equivariance is closure of the tensor product under equivariant maps -/

variable {G : Type*} [Group G]
variable {V W V' W' : Type*}
  [AddCommGroup V] [Module ℝ V] [AddCommGroup W] [Module ℝ W]
  [AddCommGroup V'] [Module ℝ V'] [AddCommGroup W'] [Module ℝ W']

/-- **THE TENSOR PRODUCT OF TWO EQUIVARIANT MAPS IS EQUIVARIANT**, for the *full* group `G`,
no connectedness, no orientation, so reflections are covered. *This is the whole of the lemma's
equivariance clause.* -/
theorem tprod_map_equivariant
    (ρV : Representation ℝ G V) (ρW : Representation ℝ G W)
    (ρV' : Representation ℝ G V') (ρW' : Representation ℝ G W')
    (f : V →ₗ[ℝ] V') (g : W →ₗ[ℝ] W')
    (hf : ∀ (a : G) (x : V), f (ρV a x) = ρV' a (f x))
    (hg : ∀ (a : G) (y : W), g (ρW a y) = ρW' a (g y)) :
    ∀ (a : G) (z : V ⊗[ℝ] W),
      TensorProduct.map f g ((ρV.tprod ρW) a z) = (ρV'.tprod ρW') a (TensorProduct.map f g z) := by
  intro a z
  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul x y => simp [hf, hg]
  | add z₁ z₂ h₁ h₂ =>
      simp only [Representation.tprod_apply, map_add] at h₁ h₂ ⊢
      rw [h₁, h₂]

/-! ## Claim 2, nonvanishing, by the cap

*"The cap computation returning `nᵏ ι_λ` proves it too, and proves **the map** nonzero rather
than merely some contraction."* -/

/-- **A MAP WITH A LEFT INVERSE UP TO A NONZERO SCALAR MULTIPLE OF A NONZERO MAP IS NONZERO.**
Reading `c₀ : V_λ → V^{⊗12}` for the seed, `cap : V^{⊗12} → V^{⊗|λ|}` for the contraction of the
`k` cups and `ι : V_λ → V^{⊗|λ|}` for the inclusion, `cap ∘ c₀ = nᵏ • ι` with `nᵏ ≠ 0` and `ι ≠ 0`
forces `c₀ ≠ 0`. -/
theorem seed_ne_zero {Vlam T U : Type*}
    [AddCommGroup Vlam] [Module ℝ Vlam] [AddCommGroup T] [Module ℝ T]
    [AddCommGroup U] [Module ℝ U]
    (c0 : Vlam →ₗ[ℝ] T) (cap : T →ₗ[ℝ] U) (iota : Vlam →ₗ[ℝ] U) (nk : ℝ)
    (hnk : nk ≠ 0) (hiota : iota ≠ 0) (hcap : cap ∘ₗ c0 = nk • iota) :
    c0 ≠ 0 := by
  intro h
  apply hiota
  have h0 : cap ∘ₗ c0 = 0 := by rw [h]; ext x; simp
  rw [h0] at hcap
  have : nk • iota = 0 := hcap.symm
  rcases smul_eq_zero.mp this with h1 | h2
  · exact absurd h1 hnk
  · exact h2

/-! ## Claim 3, admissibility is load-bearing

*"Without admissibility `V_λ = 0` and `ι_λ` does not exist, so the hypothesis is load-bearing
rather than decorative."* -/

/-- **NO NONZERO SEED EXISTS WHEN `V_λ = 0`.** Every linear map out of the zero module is zero,
so the realisation theorem (which needs *a nonzero* seed), has nothing to apply to. -/
theorem no_seed_of_trivial {Vlam T : Type*}
    [AddCommGroup Vlam] [Module ℝ Vlam] [Subsingleton Vlam] [AddCommGroup T] [Module ℝ T]
    (c0 : Vlam →ₗ[ℝ] T) : c0 = 0 := by
  ext x
  rw [Subsingleton.elim x 0, map_zero]
  simp

/-! ## The admissibility arithmetic, against the record's own witnesses

`λ'₁` is the number of nonzero parts of `λ` and `λ'₂` the number of parts of size at least two,
[L65.lean](L65.lean)'s `rows` and `rows2`. Admissibility is `λ'₁ + λ'₂ ≤ n`. -/

/-- The number of nonzero parts of `λ`, i.e. `λ'₁`. *Same definition as
[L65.lean](L65.lean)'s `rows`.* -/
def rows (l : List ℕ) : ℕ := (l.filter (fun p => 0 < p)).length

/-- The number of parts of `λ` of size at least two, i.e. `λ'₂`. -/
def rows2 (l : List ℕ) : ℕ := (l.filter (fun p => 2 ≤ p)).length

/-- `O(n)`-admissibility: `λ'₁ + λ'₂ ≤ n`. -/
def Admissible (n : ℕ) (l : List ℕ) : Prop := rows l + rows2 l ≤ n

/-- **THE RECORD'S THREE FAILURES**: `λ = (2,2)` at `n = 2` and `n = 3`, and `λ = (2,1,1)` at
`n = 3`. Each has `λ'₁ + λ'₂ = 4`. -/
theorem admissibility_witnesses :
    ¬ Admissible 2 [2, 2] ∧ ¬ Admissible 3 [2, 2] ∧ ¬ Admissible 3 [2, 1, 1] := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold Admissible rows rows2; decide)

/-- **TIGHTNESS**: `λ = (2,2,2,2,2,2)` sits at `λ'₁ + λ'₂ = 12 = n`, zero slack, and it is
admissible, so the hypothesis is exactly met rather than exceeded. -/
theorem admissibility_tight :
    rows [2, 2, 2, 2, 2, 2] + rows2 [2, 2, 2, 2, 2, 2] = 12 ∧
      Admissible 12 [2, 2, 2, 2, 2, 2] := by
  refine ⟨by unfold rows rows2; decide, by unfold Admissible rows rows2; decide⟩

/-! ## Non-vacuity

The hypotheses of claims 1 and 2 are satisfiable, so neither is empty. -/

/-- **A witness for claim 2**: the identity on `ℝ` with `cap = id`, `ι = id` and `nᵏ = 1`
satisfies every hypothesis, and the conclusion is that the identity is nonzero. -/
example : (LinearMap.id : ℝ →ₗ[ℝ] ℝ) ≠ 0 := by
  refine seed_ne_zero (LinearMap.id : ℝ →ₗ[ℝ] ℝ) LinearMap.id LinearMap.id 1 one_ne_zero ?_ ?_
  · intro h
    have := congrArg (fun f => f (1:ℝ)) h
    simp at this
  · ext; simp

/-- **A witness for claim 1**: the trivial representation on `ℝ`, where both equivariance
hypotheses hold and the conclusion is an identity. -/
example (a : G) (z : ℝ ⊗[ℝ] ℝ) :
    TensorProduct.map (LinearMap.id : ℝ →ₗ[ℝ] ℝ) LinearMap.id
        (((1 : Representation ℝ G ℝ).tprod (1 : Representation ℝ G ℝ)) a z)
      = ((1 : Representation ℝ G ℝ).tprod (1 : Representation ℝ G ℝ)) a
        (TensorProduct.map LinearMap.id LinearMap.id z) :=
  tprod_map_equivariant 1 1 1 1 LinearMap.id LinearMap.id (fun _ _ => rfl) (fun _ _ => rfl) a z

end HamiltonsCubic.L65Statement
