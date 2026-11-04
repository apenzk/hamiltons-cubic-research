# Brief, round L65

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the section carrying the argument ([findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 86-98)

## The seed is the inclusion padded by cups

The realisation theorem says one nonzero seed per block generates that block, and says nothing about **where a seed comes from**. That gap is what kept obligation (ii) open: if the seed must be found by search, finding a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$ is the same construction problem the item started with, once per block.

**It need not be searched for.** Let $\lambda$ be a block label, so $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda:V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion given by Weyl's construction of $V_\lambda$ as the traceless tensors of symmetry type $\lambda$ (classical, unfiled), and let $\mathrm{cup}=\sum_a e_a\otimes e_a\in V\otimes V$ be the invariant metric element.

> **Lemma.** *Let $n\ge1$, and let $\lambda$ be $O(n)$-admissible, $\lambda'_1+\lambda'_2\le n$, with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$.* Then $c_0:=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$, the map $x\mapsto\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$, is a **nonzero** element of $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$.

**Admissibility is what makes $V_\lambda$ nonzero.** For a label that is not admissible, Weyl's construction gives the zero space and no nonzero seed exists, witness $\lambda=(2,2)$ at $n=2,3$ and $\lambda=(2,1,1)$ at $n=3$. **Every label with $\lvert\lambda\rvert\le n$ is admissible**, because $\lambda'_1$ counts the nonzero parts and $\lambda'_2$ the parts of size at least two, so a part of size $p$ contributes at most $p$ to $\lambda'_1+\lambda'_2$ ([L65.lean](../lean/HamiltonsCubic/Results/L65.lean)). So at $n\ge12$ every block label is admissible, with equality $\lambda'_1+\lambda'_2=12$ at $\lambda=(2,2,2,2,2,2)$.

**Proof.** *Equivariance.* $g\cdot\mathrm{cup}=\sum_a ge_a\otimes ge_a$ has coefficient matrix $gg^{\mathsf T}=I$ for every $g\in O(n)$, reflections included, so $\mathrm{cup}$ is invariant, and the tensor product of the equivariant map $\iota_\lambda$ with invariant vectors is equivariant. *Nonvanishing.* For $x\ne0$, $\iota_\lambda(x)\ne0$, and $\mathrm{cup}\ne0$ because $n\ge1$, so $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}$ is a tensor product of nonzero vectors and is nonzero. Equivalently, the contraction applying $\langle\cdot,\cdot\rangle$ to the two factors of one cup returns $\sum_a\langle e_a,e_a\rangle=n$, so contracting all $k$ cups returns $n^k\iota_\lambda\ne0$. **Nonzero in $M_\lambda$ and nonzero as a map are the same statement**, $M_\lambda$ being a space of maps. $\square$

So every block has a seed in closed form relative to $\iota_\lambda$, and the realisation theorem applies to it. **The seed is $\iota_\lambda$ followed by a padding diagram of $k$ cups.** Where $\lvert\lambda\rvert=12$, $k=0$ and the seed is $\iota_\lambda$ itself, so there the content is Weyl's construction.

## Passage B, the result's block in the same file ([findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 112 and 116)

#### Lemma L65, the seed is the inclusion padded by cups

Let $n\ge1$ and let $\lambda$ be an $O(n)$-admissible label with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. Write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion and $\mathrm{cup}=\sum_ae_a\otimes e_a$ the invariant metric element. Then $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$, so the seed of every block is given in closed form and need not be searched for. Admissibility is what makes $V_\lambda$ nonzero, and it holds whenever $\lvert\lambda\rvert\le n$.

## Passage C, the canonical statement ([results.md](../results.md) line 229, landscape, and lines 800 and 802, detail)

- **Lemma L65 (direct). The seed is the inclusion padded by cups.** For $n\ge1$ and an $O(n)$-admissible label $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, with $k=(12-\lvert\lambda\rvert)/2$ and $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ the inclusion, the seed $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$, so it is constructed rather than searched for. Admissibility holds whenever $\lvert\lambda\rvert\le n$.

##### Lemma L65, the seed is the inclusion padded by cups

For $n\ge1$ and a block label $\lambda$, $O(n)$-admissible with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion of the irreducible into the tensor power, and let $\mathrm{cup}=\sum_ae_a\otimes e_a$ be the invariant metric element. Then the seed $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$: $\mathrm{cup}$ is $O(n)$-invariant, and a tensor product of nonzero vectors is nonzero. The seed is $\iota_\lambda$ followed by a padding diagram of $k$ cups, and at $\lvert\lambda\rvert=12$ it is $\iota_\lambda$ itself. Admissibility makes $V_\lambda$ nonzero and holds whenever $\lvert\lambda\rvert\le n$, since $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$. The lemma removes a search from the certificate pipeline and adds no certificate.

## Passage D, the Lean files, declarations with docstrings removed ([L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean), [L65.lean](../lean/HamiltonsCubic/Results/L65.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L65Statement

open TensorProduct

theorem legs (f : ℕ) (hf : f ≤ 12) (heven : f % 2 = 0) : 2 * ((12 - f) / 2) + f = 12 := by
  omega

theorem no_cup_iff (f : ℕ) (hf : f ≤ 12) (heven : f % 2 = 0) : (12 - f) / 2 = 0 ↔ f = 12 := by
  omega

variable {G : Type*} [Group G]
variable {V W V' W' : Type*}
  [AddCommGroup V] [Module ℝ V] [AddCommGroup W] [Module ℝ W]
  [AddCommGroup V'] [Module ℝ V'] [AddCommGroup W'] [Module ℝ W']

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

theorem seed_ne_zero {Vlam T : Type*}
    [AddCommGroup Vlam] [Module ℝ Vlam] [AddCommGroup T] [Module ℝ T]
    (c0 : Vlam →ₗ[ℝ] T) (cap : T →ₗ[ℝ] Vlam) (iota : Vlam →ₗ[ℝ] Vlam) (nk : ℝ)
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

theorem no_seed_of_trivial {Vlam T : Type*}
    [AddCommGroup Vlam] [Module ℝ Vlam] [Subsingleton Vlam] [AddCommGroup T] [Module ℝ T]
    (c0 : Vlam →ₗ[ℝ] T) : c0 = 0 := by
  ext x
  rw [Subsingleton.elim x 0, map_zero]
  simp

def rows (l : List ℕ) : ℕ := (l.filter (fun p => 0 < p)).length

def rows2 (l : List ℕ) : ℕ := (l.filter (fun p => 2 ≤ p)).length

def Admissible (n : ℕ) (l : List ℕ) : Prop := rows l + rows2 l ≤ n

theorem admissibility_witnesses :
    ¬ Admissible 2 [2, 2] ∧ ¬ Admissible 3 [2, 2] ∧ ¬ Admissible 3 [2, 1, 1] := by
  refine ⟨?_, ?_, ?_⟩ <;> (unfold Admissible rows rows2; decide)

theorem admissibility_tight :
    rows [2, 2, 2, 2, 2, 2] + rows2 [2, 2, 2, 2, 2, 2] = 12 ∧
      Admissible 12 [2, 2, 2, 2, 2, 2] := by
  refine ⟨by unfold rows rows2; decide, by unfold Admissible rows rows2; decide⟩

example : (LinearMap.id : ℝ →ₗ[ℝ] ℝ) ≠ 0 := by
  refine seed_ne_zero (LinearMap.id : ℝ →ₗ[ℝ] ℝ) LinearMap.id LinearMap.id 1 one_ne_zero ?_ ?_
  · intro h
    have := congrArg (fun f => f (1:ℝ)) h
    simp at this
  · ext; simp

example (a : G) (z : ℝ ⊗[ℝ] ℝ) :
    TensorProduct.map (LinearMap.id : ℝ →ₗ[ℝ] ℝ) LinearMap.id
        (((1 : Representation ℝ G ℝ).tprod (1 : Representation ℝ G ℝ)) a z)
      = ((1 : Representation ℝ G ℝ).tprod (1 : Representation ℝ G ℝ)) a
        (TensorProduct.map LinearMap.id LinearMap.id z) :=
  tprod_map_equivariant 1 1 1 1 LinearMap.id LinearMap.id (fun _ _ => rfl) (fun _ _ => rfl) a z

end HamiltonsCubic.L65Statement
```

```lean
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.DeriveFintype
import Mathlib.Data.List.Basic

namespace HamiltonsCubic.Seed

def rows (l : List ℕ) : ℕ := (l.filter (fun p => 0 < p)).length

def rows2 (l : List ℕ) : ℕ := (l.filter (fun p => 2 ≤ p)).length

abbrev admissible (n : ℕ) (l : List ℕ) : Prop := rows l + rows2 l ≤ n

theorem conj_le_size : ∀ l : List ℕ, rows l + rows2 l ≤ l.sum
  | [] => by simp [rows, rows2]
  | p :: t => by
    have ih := conj_le_size t
    unfold rows rows2 at *
    rcases Nat.lt_or_ge p 1 with hp | hp
    · have hp0 : p = 0 := by omega
      subst hp0
      simp only [List.filter_cons, List.sum_cons]
      norm_num
      omega
    · rcases Nat.lt_or_ge p 2 with hp2 | hp2
      · have hp1 : p = 1 := by omega
        subst hp1
        simp only [List.filter_cons, List.sum_cons]
        norm_num
        omega
      · have h0 : 0 < p := by omega
        simp only [List.filter_cons, List.sum_cons]
        rw [if_pos (by simpa using h0), if_pos (by simpa using hp2)]
        simp only [List.length_cons]
        omega

theorem admissible_of_size_le {n : ℕ} {l : List ℕ} (h : l.sum ≤ n) : admissible n l :=
  le_trans (conj_le_size l) h

theorem admissible_in_range {l : List ℕ} (h : l.sum ≤ 12) : admissible 12 l :=
  admissible_of_size_le h

theorem tight_conj : rows [2, 2, 2, 2, 2, 2] + rows2 [2, 2, 2, 2, 2, 2] = 12 := by decide

theorem tight_size : ([2, 2, 2, 2, 2, 2] : List ℕ).sum = 12 := by decide

theorem fails_22_at_three : ¬ admissible 3 [2, 2] := by decide

theorem fails_22_at_two : ¬ admissible 2 [2, 2] := by decide

theorem fails_211_at_three : ¬ admissible 3 [2, 1, 1] := by decide

theorem witnesses_exceed : ([2, 2] : List ℕ).sum = 4 ∧ ([2, 1, 1] : List ℕ).sum = 4 := by
  constructor <;> decide

theorem leg_count : 3 * 4 = 12 := by decide

theorem cups_wellposed (s : ℕ) (heven : s % 2 = 0) (hle : s ≤ 12) : 2 * ((12 - s) / 2) = 12 - s := by
  omega

theorem diagram_failure_share : 16 * 4 < 71 ∧ 71 < 16 * 5 := by
  constructor <;> decide

end HamiltonsCubic.Seed
```

## Definitions

- $V=\mathbb R^n$ with the standard action of $O(n)$, and $V^{\otimes m}$ with the diagonal action $g\cdot(v_1\otimes\dots\otimes v_m)=gv_1\otimes\dots\otimes gv_m$ and the induced inner product.
- A **block label** is a partition $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$. $\lambda'$ is the conjugate partition, so $\lambda'_1$ is the number of nonzero parts of $\lambda$ and $\lambda'_2$ the number of parts of size at least $2$. $\lambda$ is **$O(n)$-admissible** when $\lambda'_1+\lambda'_2\le n$.
- $V_\lambda$ is the $O(n)$-representation labelled by $\lambda$, and $M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## What to attack, beyond the standing list

1. **The hypotheses.** Which of $n\ge1$, admissibility and $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ each step uses, and whether any step uses a hypothesis not stated.
2. **Weyl's construction, "classical, unfiled".** What the proof needs from it: that $V_\lambda$ is realised as traceless tensors of symmetry type $\lambda$, that $\iota_\lambda$ is $O(n)$-equivariant and injective, and that $V_\lambda\ne0$ exactly for admissible $\lambda$. Whether each is argued, cited or assumed, and whether the "exactly" direction is used.
3. **Equivariance.** The invariance of $\mathrm{cup}$ from $gg^{\mathsf T}=I$, reflections included, and whether a tensor product of an equivariant map with invariant vectors is equivariant under the diagonal action on $V^{\otimes12}$, with the slots in the stated order.
4. **Nonvanishing.** The tensor-product argument, the contraction identity returning $n^k\iota_\lambda$, and "nonzero in $M_\lambda$ and nonzero as a map are the same statement".
5. **The partition bound** $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$: the argument given, the witnesses $(2,2)$ at $n=2,3$ and $(2,1,1)$ at $n=3$, and the equality at $(2,2,2,2,2,2)$.
6. **"So at $n\ge12$ every block label is admissible"**, and "admissibility holds whenever $\lvert\lambda\rvert\le n$" in Passages B and C.
7. **The seed's description**: "$\iota_\lambda$ followed by a padding diagram of $k$ cups", the case $\lvert\lambda\rvert=12$, and what "given in closed form", "constructed rather than searched for" and "relative to $\iota_\lambda$" each claim, given how $\iota_\lambda$ is obtained.
8. **"The realisation theorem applies to it"**: what Passage A says that theorem needs of a seed, and whether the lemma supplies it.
9. **Passages B and C against Passage A**: the range of $n$, the hypotheses, "a nonzero element of" against "a nonzero $O(n)$-equivariant map", and every qualifier that differs.
10. **Passage D against Passages A to C**: what each declaration states, over which types, and what of the lemma is and is not typed.
11. **The boundary**: $n=1$, $\lambda=\varnothing$ with $k=6$, $\lvert\lambda\rvert=12$ with $k=0$, odd $n$, a label that is admissible with $\lvert\lambda\rvert>n$, and $SO(n)$ in place of $O(n)$.
