import Mathlib

set_option linter.style.longLine false

/-!
# L66, no maximizer is `∘`-decomposable

## The record's statement, verbatim

[support-dichotomy.md](../../../findings/support-dichotomy.md)'s *Lemma L66, no maximizer is
`∘`-decomposable*:

> Call $W$ *$\circ$-decomposable* if $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit
> element of $\mathrm{Weyl}_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for
> $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is
> $\circ$-decomposable.

and, from the same file, the proof it is the statement of:

> **Proof.** Write $M(n)=\max\{P(A):A\in\mathcal W_n,\lVert A\rVert=1\}$ for the global maximum;
> $M(n)>0$ at every $n\ge4$, since $S^k\times S^l$ with $k,l\ge2$ has
> $P(W_{S_{k,l}})=\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}}>0$
> (Nienhaus, Proposition 2.25), and **the final inequality below is strict only because of that**.
> $A_i\circ A_j=0$ makes $P$ **additive**: $P(W)=\sum_ia_i^3P(A_i)$. *That step uses the **total**
> symmetry of $T(X,Y,Z)=\langle X,Y\circ Z\rangle$*, the cross term
> $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ dies only after moving the first slot to
> $\langle A_j,A_i\circ A_j\rangle=0$. [...] Hence
> $$P(W)=\sum_ia_i^3P(A_i)\le M(n)\sum_i\lvert a_i\rvert^3\le M(n)\max_i\lvert a_i\rvert<M(n),$$
> using $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert\cdot\sum_ia_i^2=\max_i\lvert a_i\rvert$,
> and $\max_i\lvert a_i\rvert<1$ because $\sum a_i^2=1$ with $k\ge2$ and every $a_i\ne0$.

> **Nothing else is used.** No padding, no monotonicity of $M$, no harmonic-square law, and (the
> part that widens the reach), **no criticality of the pieces**. $A_i$ is a unit element of
> $\mathrm{Weyl}_n$ and $P$ is odd, so $\lvert P(A_i)\rvert\le M(n)$ outright and the pieces'
> support dimensions never enter.

## How this is typed, and why abstractly

**The Fox product `∘` has no Lean layer here**, [WeylReal.lean](../Base/WeylReal.lean) carries
`IsWeyl`, `Qop`, `IsCritical`, `Pcubic`, `theta`, and no `∘`. So the definition of
`∘`-decomposability cannot be written against the record's objects directly.

What is written instead is **the same statement over an arbitrary real normed space carrying a
totally symmetric trilinear form `T`**, with `P X = T X X X`, and with `Aᵢ ∘ Aⱼ = 0` in the only
form the proof ever uses it: `T X Aᵢ Aⱼ = 0` for every `X` and every `i ≠ j`. The record's own
account of the proof says this is exactly the content, *"nothing else is used"*, and the step
that needs `∘` at all is the one that reads `⟨Aⱼ, Aᵢ ∘ Aⱼ⟩ = 0`, which is that hypothesis at
`X = Aⱼ`. The programme's `T(X,Y,Z) = ⟨X, Y ∘ Z⟩` is totally symmetric, symmetry in the last two
slots is free from the polarisation, and in the first because `∇P = 3Q`, so instantiating the
form below at the record's `T` is faithful, and the abstract statement is strictly more general.

**`∘`-decomposability is defined below in full**, with all five of its clauses: `k ≥ 2`, unit
pieces, `Σ aᵢ² = 1`, every `aᵢ ≠ 0`, and pairwise `∘`-orthogonality. Nothing is dropped.

**The absolute values are load-bearing and are present.** The record records an exact witness for
their absence: at `(a,b) = (3/5, −4/5)` with pieces at `±M`, the chain without them is false. That
witness is checked below.

## What is NOT typed here

**That the record's `T(X,Y,Z) = ⟨X, Y ∘ Z⟩` on `𝒲ₙ` is totally symmetric, and that `P = Pcubic`
is its diagonal.** Both are geometry (the polarisation and `∇P = 3Q`) and both are hypotheses
of the theorem below rather than consequences of anything in it.

**`M(n) > 0`.** The record takes it from Nienhaus's Proposition 2.25, `P(W_{S_{k,l}}) = θ_{k,l} > 0`
for `k, l ≥ 2`, which needs the sphere-product family; it is a hypothesis below. *The record is explicit that the final
inequality is strict only because of it.*
-/

namespace HamiltonsCubic.L66Statement

open Finset

variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-- **The cubic form**, `P(X) = T(X,X,X)`, the diagonal of the trilinear form. -/
noncomputable def Pf (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) (X : E) : ℝ := T X X X

/-- **`∘`-DECOMPOSABILITY, in full.** `W = Σ aᵢAᵢ` with `k ≥ 2`, each `Aᵢ` a unit element,
`Σ aᵢ² = 1`, every `aᵢ ≠ 0`, and `Aᵢ ∘ Aⱼ = 0` for `i ≠ j`, the last read through the pairing,
`T X Aᵢ Aⱼ = 0` for every `X`, which is the only form the proof uses. -/
def IsCircDecomposable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) (W : E) : Prop :=
  ∃ (k : ℕ) (a : Fin k → ℝ) (A : Fin k → E),
    2 ≤ k ∧ (∀ i, ‖A i‖ = 1) ∧ (∑ i, a i ^ 2 = 1) ∧ (∀ i, a i ≠ 0) ∧
      (∀ (X : E) (i j : Fin k), i ≠ j → T X (A i) (A j) = 0) ∧
      W = ∑ i, a i • A i

/-! ## Additivity, from `∘`-orthogonality and total symmetry -/

/-- Pushing a sum through the first slot. -/
private theorem slot1 (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (Y Z : E) : T (∑ i, a i • A i) Y Z = ∑ i, a i * T (A i) Y Z := by
  simp [map_sum, LinearMap.sum_apply, LinearMap.smul_apply]

/-- Pushing a sum through the second slot. -/
private theorem slot2 (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (X Z : E) : T X (∑ j, a j • A j) Z = ∑ j, a j * T X (A j) Z := by
  simp [map_sum, LinearMap.sum_apply, LinearMap.smul_apply]

/-- Pushing a sum through the third slot. -/
private theorem slot3 (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (X Y : E) : T X Y (∑ l, a l • A l) = ∑ l, a l * T X Y (A l) := by
  simp [map_sum]

/-- **The expansion of the cubic form on a sum.** -/
theorem Pf_sum (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E) :
    Pf T (∑ i, a i • A i)
      = ∑ i, a i * ∑ j, a j * ∑ l, a l * T (A i) (A j) (A l) := by
  rw [Pf, slot1 T a A]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [slot2 T a A]
  refine congrArg (fun x => a i * x) (Finset.sum_congr rfl fun j _ => ?_)
  rw [slot3 T a A]

/-- **`P` IS ADDITIVE ON A `∘`-ORTHOGONAL SPLITTING**: `P(Σ aᵢAᵢ) = Σ aᵢ³ P(Aᵢ)`.
*The cross term `T(Aᵢ,Aⱼ,Aⱼ)` dies only after moving the first slot, which is where the total
symmetry of `T` is consumed.* -/
theorem Pf_additive (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z)
    {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (horth : ∀ (X : E) (i j : Fin k), i ≠ j → T X (A i) (A j) = 0) :
    Pf T (∑ i, a i • A i) = ∑ i, a i ^ 3 * Pf T (A i) := by
  rw [Pf_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hinner : ∀ j : Fin k, (∑ l, a l * T (A i) (A j) (A l)) = a j * T (A i) (A j) (A j) := by
    intro j
    refine Finset.sum_eq_single j (fun l _ hl => ?_) (fun h => absurd (Finset.mem_univ j) h)
    rw [horth (A i) j l (fun h => hl h.symm), mul_zero]
  rw [Finset.sum_congr rfl fun j (_ : j ∈ Finset.univ) => congrArg (fun x => a j * x) (hinner j)]
  have hmid : (∑ j, a j * (a j * T (A i) (A j) (A j)))
      = a i * (a i * T (A i) (A i) (A i)) := by
    refine Finset.sum_eq_single i (fun j _ hj => ?_) (fun h => absurd (Finset.mem_univ i) h)
    have hz : T (A i) (A j) (A j) = 0 := by
      rw [hsym12 (A i) (A j) (A j)]
      exact horth (A j) i j (fun h => hj h.symm)
    rw [hz, mul_zero, mul_zero]
  rw [hmid, Pf]
  ring

/-! ## The chain -/

/-- **Every coefficient is a strict sub-unit**: `Σ aᵢ² = 1` with `k ≥ 2` and every `aᵢ ≠ 0`
forces `|aᵢ| < 1`. -/
theorem abs_lt_one {k : ℕ} (hk : 2 ≤ k) (a : Fin k → ℝ) (hsum : ∑ i, a i ^ 2 = 1)
    (hne : ∀ i, a i ≠ 0) (i : Fin k) : |a i| < 1 := by
  obtain ⟨j, hj⟩ : ∃ j : Fin k, j ≠ i :=
    Fintype.exists_ne_of_one_lt_card (by simpa using (by omega : 1 < k)) i
  have hsub : a i ^ 2 + a j ^ 2 ≤ ∑ l, a l ^ 2 := by
    have hpair : ({i, j} : Finset (Fin k)) ⊆ Finset.univ := Finset.subset_univ _
    have := Finset.sum_le_sum_of_subset_of_nonneg hpair (fun l _ _ => sq_nonneg (a l))
    rwa [Finset.sum_pair (Ne.symm hj)] at this
  have hjpos : 0 < a j ^ 2 :=
    lt_of_le_of_ne (sq_nonneg _) (Ne.symm (pow_ne_zero 2 (hne j)))
  have hlt : a i ^ 2 < 1 := by rw [hsum] at hsub; linarith
  have h1 : |a i| ^ 2 < 1 := by rwa [sq_abs]
  nlinarith [abs_nonneg (a i)]

/-- **`Σ|aᵢ|³ < 1`**, the record's `Σ|aᵢ|³ ≤ max|aᵢ|·Σaᵢ² = max|aᵢ| < 1` run without naming the
maximum. -/
theorem sum_abs_cube_lt_one {k : ℕ} (hk : 2 ≤ k) (a : Fin k → ℝ) (hsum : ∑ i, a i ^ 2 = 1)
    (hne : ∀ i, a i ≠ 0) : ∑ i, |a i| ^ 3 < 1 := by
  have hk0 : 0 < k := by omega
  have hnonempty : (Finset.univ : Finset (Fin k)).Nonempty := ⟨⟨0, hk0⟩, Finset.mem_univ _⟩
  have hlt : ∑ i, |a i| ^ 3 < ∑ i, a i ^ 2 := by
    refine Finset.sum_lt_sum_of_nonempty hnonempty fun i _ => ?_
    have hb := abs_lt_one hk a hsum hne i
    have hpos : 0 < a i ^ 2 :=
      lt_of_le_of_ne (sq_nonneg _) (Ne.symm (pow_ne_zero 2 (hne i)))
    have hrw : |a i| ^ 3 = |a i| * a i ^ 2 := by rw [← sq_abs (a i)]; ring
    rw [hrw]
    nlinarith [abs_nonneg (a i)]
  rwa [hsum] at hlt

/-- **`∘`-decomposability over a unit set `S`**, the norm-free form: the same clauses with
`Aᵢ ∈ S` in place of `‖Aᵢ‖ = 1`, for a space whose unit sphere is given by a predicate. -/
def IsCircDecomposableOn (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) (S : Set E) (W : E) : Prop :=
  ∃ (k : ℕ) (a : Fin k → ℝ) (A : Fin k → E),
    2 ≤ k ∧ (∀ i, A i ∈ S) ∧ (∑ i, a i ^ 2 = 1) ∧ (∀ i, a i ≠ 0) ∧
      (∀ (X : E) (i j : Fin k), i ≠ j → T X (A i) (A j) = 0) ∧
      W = ∑ i, a i • A i

/-- **The bound over a unit set closed under negation**, the argument of `Pf_lt_max` with the
sphere replaced by `S`: it uses only that `S` holds the pieces, is closed under `B ↦ -B`, and
carries `P ≤ M`. -/
theorem Pf_lt_max_on (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z) (S : Set E) (hSneg : ∀ B ∈ S, -B ∈ S)
    (M : ℝ) (hMpos : 0 < M) (hM : ∀ B ∈ S, Pf T B ≤ M)
    (W : E) (hW : IsCircDecomposableOn T S W) :
    Pf T W < M := by
  obtain ⟨k, a, A, hk, hunit, hsum, hne, horth, hdec⟩ := hW
  have hodd : ∀ B : E, Pf T (-B) = -Pf T B := by intro B; simp [Pf]
  have habs : ∀ i, |Pf T (A i)| ≤ M := by
    intro i
    rw [abs_le]
    refine ⟨?_, hM (A i) (hunit i)⟩
    have hneg : Pf T (-A i) ≤ M := hM (-A i) (hSneg _ (hunit i))
    rw [hodd] at hneg
    linarith
  rw [hdec, Pf_additive T hsym12 a A horth]
  have hterm : ∀ i ∈ (Finset.univ : Finset (Fin k)), a i ^ 3 * Pf T (A i) ≤ M * |a i| ^ 3 := by
    intro i _
    calc a i ^ 3 * Pf T (A i) ≤ |a i ^ 3 * Pf T (A i)| := le_abs_self _
      _ = |a i| ^ 3 * |Pf T (A i)| := by rw [abs_mul, abs_pow]
      _ ≤ |a i| ^ 3 * M := mul_le_mul_of_nonneg_left (habs i) (by positivity)
      _ = M * |a i| ^ 3 := by ring
  calc ∑ i, a i ^ 3 * Pf T (A i) ≤ ∑ i, M * |a i| ^ 3 := Finset.sum_le_sum hterm
    _ = M * ∑ i, |a i| ^ 3 := by rw [Finset.mul_sum]
    _ < M * 1 := mul_lt_mul_of_pos_left (sum_abs_cube_lt_one hk a hsum hne) hMpos
    _ = M := mul_one M

/-! ## The theorem -/

/-- **NO `∘`-DECOMPOSABLE POINT REACHES THE MAXIMUM.** With `M` an upper bound for `P` on the
unit sphere and `M > 0`, any `∘`-decomposable `W` has `P(W) < M`. -/
theorem Pf_lt_max {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z)
    (M : ℝ) (hMpos : 0 < M) (hM : ∀ B : E, ‖B‖ = 1 → Pf T B ≤ M)
    (W : E) (hW : IsCircDecomposable T W) :
    Pf T W < M := by
  obtain ⟨k, a, A, hk, hunit, hsum, hne, horth, hdec⟩ := hW
  have hodd : ∀ B : E, Pf T (-B) = -Pf T B := by intro B; simp [Pf]
  have habs : ∀ i, |Pf T (A i)| ≤ M := by
    intro i
    rw [abs_le]
    refine ⟨?_, hM (A i) (hunit i)⟩
    have hneg : Pf T (-A i) ≤ M := hM (-A i) (by rw [norm_neg]; exact hunit i)
    rw [hodd] at hneg
    linarith
  rw [hdec, Pf_additive T hsym12 a A horth]
  have hterm : ∀ i ∈ (Finset.univ : Finset (Fin k)), a i ^ 3 * Pf T (A i) ≤ M * |a i| ^ 3 := by
    intro i _
    calc a i ^ 3 * Pf T (A i) ≤ |a i ^ 3 * Pf T (A i)| := le_abs_self _
      _ = |a i| ^ 3 * |Pf T (A i)| := by rw [abs_mul, abs_pow]
      _ ≤ |a i| ^ 3 * M := mul_le_mul_of_nonneg_left (habs i) (by positivity)
      _ = M * |a i| ^ 3 := by ring
  calc ∑ i, a i ^ 3 * Pf T (A i) ≤ ∑ i, M * |a i| ^ 3 := Finset.sum_le_sum hterm
    _ = M * ∑ i, |a i| ^ 3 := by rw [Finset.mul_sum]
    _ < M * 1 := mul_lt_mul_of_pos_left (sum_abs_cube_lt_one hk a hsum hne) hMpos
    _ = M := mul_one M

/-- **THE LEMMA.** No maximizer of `P` on the unit sphere is `∘`-decomposable. -/
theorem no_maximizer_is_circDecomposable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z)
    (M : ℝ) (hMpos : 0 < M) (hM : ∀ B : E, ‖B‖ = 1 → Pf T B ≤ M)
    (W : E) (_hWnorm : ‖W‖ = 1) (hmax : Pf T W = M) :
    ¬ IsCircDecomposable T W := fun hdec =>
  absurd hmax (ne_of_lt (Pf_lt_max T hsym12 M hMpos hM W hdec))

/-! ## The absolute values are load-bearing

*"With `aᵢ³` in place of `|aᵢ|³` the chain is **false** at any negative coefficient."* -/

/-- **The record's exact witness**, at `(a,b) = (3/5, −4/5)` with pieces at `±M`: the true value
is `(91/125)M` against a claimed bound of `−(37/125)M`, and `91/125 > −37/125`. Both are exact
rationals, so the failure is not a rounding artefact. -/
example (M : ℝ) (hM : 0 < M) :
    (3/5 : ℝ) ^ 3 * M + (-4/5 : ℝ) ^ 3 * (-M) = (91/125) * M ∧
      ((3/5 : ℝ) ^ 3 + (-4/5 : ℝ) ^ 3) * M = (-37/125) * M ∧
      (-37/125 : ℝ) * M < (91/125) * M := by
  refine ⟨by ring, by ring, by nlinarith⟩

/-! ## Non-vacuity

The definition is satisfiable, so the theorem is not empty. -/

/-- **A witness for `∘`-decomposability**: on `EuclideanSpace ℝ (Fin 2)` with the zero trilinear
form, the two standard unit vectors at coefficients `(3/5, 4/5)` satisfy every clause. *The zero
form makes the `∘`-orthogonality trivial, which is what a witness for satisfiability needs; the
theorem's hypothesis `0 < M` then fails for `M = 0`, so this exhibits the definition rather than
a counterexample to the conclusion.* -/
example : IsCircDecomposable (E := EuclideanSpace ℝ (Fin 2)) 0
    ((3/5 : ℝ) • EuclideanSpace.single (0 : Fin 2) (1:ℝ)
      + (4/5 : ℝ) • EuclideanSpace.single (1 : Fin 2) (1:ℝ)) := by
  refine ⟨2, ![3/5, 4/5], fun i => EuclideanSpace.single i (1:ℝ), le_refl 2, ?_, ?_, ?_, ?_, ?_⟩
  · intro i; simp
  · simp [Fin.sum_univ_two]; norm_num
  · intro i; fin_cases i <;> norm_num
  · intro X i j _; simp
  · simp [Fin.sum_univ_two]

end HamiltonsCubic.L66Statement
