import Mathlib

set_option linter.style.longLine false

/-!
# L148, the defect vanishes identically on the margin summand

The record's statement, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> **LEMMA L148.** *Let `m ≥ 3` and `W* = S^m × S^m` with `n = 2m`, and let `H` lie in the joint
> `λ_m`-eigenspace `Σ` (**both** `S²₀(ℝᵐ)` copies, of dimension `(m+2)(m-1)`), with the
> diagonalising frame chosen **after** `H`. Then `W*` and `H` are simultaneously diagonal on
> coordinate `2`-planes, hence so is `W(t) = W* + tH` and so is `W(t)_-`; and since `Alt` lands in
> `Λ⁴`, whose components need four distinct indices, a coordinate-diagonal operator has none.
> **Therefore `Alt(W(t)_-) = 0` for every real `t`, an exact algebraic identity on the affine
> subspace `W* + Σ`, using no gap, no analyticity, no `ker W* = 0` and no smallness of `t`.** The
> defect is identically zero along the whole segment, **and the branch that vanishes there is the
> second one alone**: at `w = 0` the first branch is `c_p/S ≤ 3/(n-2)`, finite and positive, and it
> is what proves the route's ceiling.*

and the complex extension the record discharges beside it:

> **THE COMPLEX-`z` EXTENSION IS DISCHARGED, AND IT WAS ALREADY ON THE RECORD.** *The frame is
> fixed by `H` alone, so it does not depend on `z`; `W(z) = W* + zH` is diagonal in it with complex
> entries; the resolvent of a diagonal operator is diagonal, so the Riesz projection is too, entry
> by entry; and `Alt` is a fixed rational-coefficient index formula, extending `ℂ`-linearly and
> killing a coordinate-diagonal operator over any field.*

## What this file types

The lemma's **mechanism**, which is the whole of its content once the simultaneous diagonalisation
is granted: a curvature-type tensor supported on coordinate `2`-planes has vanishing first-Bianchi
(equivalently `Λ⁴`) component at four distinct indices, and the class of such tensors is closed
under the operations the lemma walks through.

* `IsCoordDiagonal`, `R i j k l = 0` whenever the unordered pairs `{i,j}` and `{k,l}` differ. This
  is exactly "supported on coordinate `2`-planes".
* `altSum`, the first-Bianchi/`Λ⁴` sum `R i j k l + R i k l j + R i l j k`, the record's `Alt`
  read as an index formula.
* `alt_eq_zero_of_coordDiagonal`, the load-bearing step: at four **pairwise distinct** indices,
  every one of the three terms pairs disjoint index pairs, so each vanishes separately. This is
  stated over an arbitrary commutative ring `R`, so it covers the record's `ℂ`-linear extension of
  the same index formula with no separate argument.
* `IsCoordDiagonal.add`, `.smul`, `affine`, the class is a submodule, so `W(t) = W* + tH` is
  coordinate-diagonal for every scalar `t`, and `alt_affine_eq_zero` reads the conclusion off it at
  every `t` in the scalar ring, `ℝ` and `ℂ` alike.
* `ofKernel` and `alt_ofKernel_eq_zero`, a coordinate-diagonal operator modelled by its eigenvalue
  list `K : ι → ι → R` on the `2`-planes, with the entries pushed through an arbitrary
  `f : R → R`. Since `x ↦ x_-` (and any entrywise functional calculus, real or complex) is such an
  `f`, this is the record's "so is `W(t)_-`" step at the level of eigenvalue lists, and it needs
  only `f 0 = 0`.
* `alt_negPart_eq_zero`, the lemma's own conclusion in that model: `Alt((W* + tH)_-) = 0` for
  every real `t`, with `x_- = (|x| - x)/2` written out, no gap, no analyticity, no smallness of
  `t`.
* `witness_nontrivial`, a nonzero coordinate-diagonal tensor exists, so nothing above is vacuous.

## What is NOT typed here

* **The simultaneous diagonalisation itself.** That `W* = S^m × S^m` and every `H` in the joint
  `λ_m`-eigenspace `Σ` are coordinate-diagonal in one frame chosen after `H` is the record's own
  geometric computation, resting on the Kulkarni–Nomizu embedding of L146 and on the
  `O(m) × O(m)`-invariance of `W*`. It enters here as the hypothesis `IsCoordDiagonal` on both
  tensors rather than as a proved fact, so this file checks that the conclusion follows from
  coordinate-diagonality and not that the margin summand is coordinate-diagonal.
* **The spectral part as a spectral part.** `W_-` is modelled as the entrywise `x ↦ (|x| - x)/2`
  on the eigenvalue list of a diagonal operator. That the negative spectral part of a
  coordinate-diagonal curvature operator *is* that entrywise map, the Riesz-projection step the
  record discharges in prose, is not typed; `alt_ofKernel_eq_zero` is stated for an arbitrary
  entrywise `f` precisely so that the modelling assumption is the only gap.
* **`Alt` as the record's operator.** `altSum` is the three-term cyclic index formula. The record's
  `Alt` is the orthogonal projection onto `Λ⁴`, which is a multiple of that formula; the constant
  is irrelevant to a vanishing statement and is not carried.
* **Everything the record draws from the vanishing**: `‖A''‖ = 0` on the summand, the branch
  bookkeeping (`c_p/S ≤ 3/(n-2)` at `w = 0`, branch 2 unbounded there), the displacement of L146,
  and the scope conditions `m ≥ 5` for the word "margin", `dim Σ = (m+2)(m-1)`, and the failure of
  the fixed-frame reading.
-/

namespace HamiltonsCubic.L148Statement

variable {ι : Type*} [DecidableEq ι] {R : Type*}

/-! ## Coordinate-diagonal tensors and the `Λ⁴` index formula -/

section Ring

variable [CommRing R]

/-- **Supported on coordinate `2`-planes.** `T i j k l` vanishes unless the unordered pairs `{i,j}`
and `{k,l}` coincide, the record's "diagonal on coordinate `2`-planes". -/
def IsCoordDiagonal (T : ι → ι → ι → ι → R) : Prop :=
  ∀ i j k l, ({i, j} : Finset ι) ≠ ({k, l} : Finset ι) → T i j k l = 0

/-- Four **pairwise distinct** indices, what a `Λ⁴` component needs. -/
def Distinct4 (i j k l : ι) : Prop :=
  i ≠ j ∧ i ≠ k ∧ i ≠ l ∧ j ≠ k ∧ j ≠ l ∧ k ≠ l

/-- **The first-Bianchi / `Λ⁴` sum**, the record's `Alt` read as an index formula. -/
def altSum (T : ι → ι → ι → ι → R) (i j k l : ι) : R :=
  T i j k l + T i k l j + T i l j k

/-- Two disjoint two-element index sets are distinct. -/
private lemma pair_ne (a b c d : ι) (hac : a ≠ c) (had : a ≠ d) :
    ({a, b} : Finset ι) ≠ ({c, d} : Finset ι) := by
  intro h
  have ha : a ∈ ({c, d} : Finset ι) := h ▸ (by simp : a ∈ ({a, b} : Finset ι))
  simp only [Finset.mem_insert, Finset.mem_singleton] at ha
  rcases ha with h1 | h2
  · exact hac h1
  · exact had h2

/-- **THE LOAD-BEARING STEP.** At four pairwise distinct indices, a coordinate-diagonal tensor has
vanishing `Λ⁴` component: each of the three terms pairs two disjoint index pairs.

*Stated over an arbitrary commutative ring, which is the record's "`Alt` … extends `ℂ`-linearly and
kills a coordinate-diagonal operator over any field".* -/
theorem alt_eq_zero_of_coordDiagonal {T : ι → ι → ι → ι → R} (hT : IsCoordDiagonal T)
    {i j k l : ι} (hd : Distinct4 i j k l) :
    altSum T i j k l = 0 := by
  obtain ⟨hij, hik, hil, -, -, -⟩ := hd
  have h1 : T i j k l = 0 := hT _ _ _ _ (pair_ne i j k l hik hil)
  have h2 : T i k l j = 0 := hT _ _ _ _ (pair_ne i k l j hil hij)
  have h3 : T i l j k = 0 := hT _ _ _ _ (pair_ne i l j k hij hik)
  simp [altSum, h1, h2, h3]

/-! ## The class is a submodule, so the whole segment lies in it -/

theorem IsCoordDiagonal.zero : IsCoordDiagonal (ι := ι) (fun _ _ _ _ => (0 : R)) :=
  fun _ _ _ _ _ => rfl

theorem IsCoordDiagonal.add {S T : ι → ι → ι → ι → R} (hS : IsCoordDiagonal S)
    (hT : IsCoordDiagonal T) : IsCoordDiagonal (fun i j k l => S i j k l + T i j k l) := by
  intro i j k l h
  simp [hS i j k l h, hT i j k l h]

theorem IsCoordDiagonal.smul {T : ι → ι → ι → ι → R} (hT : IsCoordDiagonal T) (t : R) :
    IsCoordDiagonal (fun i j k l => t * T i j k l) := by
  intro i j k l h
  simp [hT i j k l h]

/-- **`W(t) = W* + tH` is coordinate-diagonal for every scalar `t`**, `ℝ` and `ℂ` alike. -/
theorem IsCoordDiagonal.affine {W H : ι → ι → ι → ι → R} (hW : IsCoordDiagonal W)
    (hH : IsCoordDiagonal H) (t : R) :
    IsCoordDiagonal (fun i j k l => W i j k l + t * H i j k l) :=
  hW.add (hH.smul t)

/-- **The conclusion along the whole segment**: `Alt(W* + tH) = 0` at every scalar `t` and every
four distinct indices, no gap, no analyticity, no smallness of `t`. -/
theorem alt_affine_eq_zero {W H : ι → ι → ι → ι → R} (hW : IsCoordDiagonal W)
    (hH : IsCoordDiagonal H) (t : R) {i j k l : ι} (hd : Distinct4 i j k l) :
    altSum (fun i j k l => W i j k l + t * H i j k l) i j k l = 0 :=
  alt_eq_zero_of_coordDiagonal (hW.affine hH t) hd

/-! ## The eigenvalue-list model, and the entrywise functional calculus -/

/-- A coordinate-diagonal tensor built from an **eigenvalue list** `K` on the coordinate
`2`-planes: `K i j` on `{i,j}`, with the curvature sign convention on the swapped pair, and `0`
off the diagonal. -/
def ofKernel (K : ι → ι → R) : ι → ι → ι → ι → R := fun i j k l =>
  if i = k then (if j = l then K i j else 0)
  else if i = l then (if j = k then -K i j else 0) else 0

theorem ofKernel_isCoordDiagonal (K : ι → ι → R) : IsCoordDiagonal (ofKernel K) := by
  intro i j k l h
  unfold ofKernel
  by_cases h1 : i = k
  · by_cases h2 : j = l
    · exact absurd (by rw [h1, h2]) h
    · rw [if_pos h1, if_neg h2]
  · by_cases h3 : i = l
    · by_cases h4 : j = k
      · refine absurd ?_ h
        rw [h3, h4]
        exact Finset.pair_comm l k
      · rw [if_neg h1, if_pos h3, if_neg h4]
    · rw [if_neg h1, if_neg h3]

/-- **The entrywise functional calculus keeps it diagonal.** For any `f : R → R`, the tensor built
from `f ∘ K` is again coordinate-diagonal, so its `Λ⁴` component vanishes. *`x ↦ x_-` is such an
`f`; so is every Riesz projection of a diagonal operator, real or complex, which is why this needs
no hypothesis on `f` beyond being a function.* -/
theorem alt_ofKernel_eq_zero (f : R → R) (K : ι → ι → R) {i j k l : ι}
    (hd : Distinct4 i j k l) :
    altSum (ofKernel (fun a b => f (K a b))) i j k l = 0 :=
  alt_eq_zero_of_coordDiagonal (ofKernel_isCoordDiagonal _) hd

end Ring

/-! ## The lemma's own conclusion, with `x ↦ x_-` written out -/

/-- `x_- = (|x| - x)/2`, the negative part. -/
noncomputable def negPart (x : ℝ) : ℝ := (|x| - x) / 2

/-- **LEMMA L148, in the eigenvalue-list model.** With `W*` carrying the eigenvalue list `KW` and
`H` carrying `KH` on the coordinate `2`-planes, `Alt((W* + tH)_-) = 0` for **every real `t`**, at
every four distinct indices.

*The `t` is arbitrary (past every eigenvalue crossing) and the proof uses no spectral gap, no
analyticity, no `ker W* = 0` and no smallness of `t`, exactly as the record states.* -/
theorem alt_negPart_eq_zero (KW KH : ι → ι → ℝ) (t : ℝ) {i j k l : ι}
    (hd : Distinct4 i j k l) :
    altSum (ofKernel (fun a b => negPart (KW a b + t * KH a b))) i j k l = 0 :=
  alt_ofKernel_eq_zero negPart (fun a b => KW a b + t * KH a b) hd

/-- **The same over `ℂ`**, which is the discharged complex-`z` extension: the frame does not depend
on `z`, so the tensor stays coordinate-diagonal with complex entries and the index formula still
kills it. -/
theorem alt_negPart_eq_zero_complex (f : ℂ → ℂ) (KW KH : ι → ι → ℂ) (z : ℂ) {i j k l : ι}
    (hd : Distinct4 i j k l) :
    altSum (ofKernel (fun a b => f (KW a b + z * KH a b))) i j k l = 0 :=
  alt_ofKernel_eq_zero f (fun a b => KW a b + z * KH a b) hd

/-! ## Nothing above is vacuous -/

/-- **Nothing above is vacuous.** At `ι = Fin 4` there are four pairwise distinct indices, and the
all-ones eigenvalue list gives a coordinate-diagonal tensor that is **nonzero** on the `2`-plane
`{0,1}` while its `Λ⁴` component at those four indices vanishes. -/
theorem witness_nontrivial :
    Distinct4 (0 : Fin 4) 1 2 3 ∧
      IsCoordDiagonal (ofKernel (fun _ _ : Fin 4 => (1 : ℝ))) ∧
      ofKernel (fun _ _ : Fin 4 => (1 : ℝ)) 0 1 0 1 ≠ 0 ∧
      altSum (ofKernel (fun _ _ : Fin 4 => (1 : ℝ))) 0 1 2 3 = 0 := by
  have hd : Distinct4 (0 : Fin 4) 1 2 3 := by
    refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> decide
  refine ⟨hd, ofKernel_isCoordDiagonal _, ?_,
    alt_eq_zero_of_coordDiagonal (ofKernel_isCoordDiagonal _) hd⟩
  simp [ofKernel]

end HamiltonsCubic.L148Statement
