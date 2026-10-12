# Gate 2 brief, do the four typed Lean statements say what the record's lemmas say?

**This round audits FORMALISATION FIDELITY, not mathematics.** The four lemmas below were audited as mathematics in earlier rounds and passed. What is new is that each now has a Lean *statement*, and the question is whether the statement says the same thing.

**Why it is worth a round.** [research-loop/SKILL.md](../.claude/skills/research-loop/SKILL.md) names the failure exactly: *"a statement that disagrees with the record"* means *"the prose drifted from the target after it was set"*. A wrong Lean statement is worse than none, because it type-checks and reads as verification. *The author of these statements also miscounted this layer's coverage by a factor of eight in the same session and reported it, so a second reader on his formalising is warranted.*

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **Running `lake build` to see whether a file compiles is permitted and is not a screen**, it is reading the artefact under audit.

## What to do

For each of the four, compare the record's statement with the Lean statement and answer, in writing:

1. **Does the Lean statement say the same thing?** Name every hypothesis present in one and absent from the other, in both directions.
2. **Is anything silently strengthened or weakened?** A Lean statement that assumes more is weaker and reads as more; one that assumes less is stronger and may be false.
3. **Are the definitions faithful?** `IsSectional`, `nbr`, `edges`, `incidence`, `ricci`, and L182's whole constant chain are definitions the author wrote; check each against the record's own words rather than against its plausibility.
4. **What does the `sorry` cover?** Three statements carry one. Say precisely what remains unproved in each, and whether the file's docstring describes that honestly.
5. **What do the PROVED theorems establish?** For each proved theorem, say whether it is a step of the lemma or a fact about its arithmetic. *This is the distinction the layer was found to have blurred across 60 rows.*
6. **Is `L180`'s claim to prove parts (1) and (2) outright correct?** It is the only one claiming a lemma part with no `sorry`, so it carries the most weight.
7. **The boundary.** Empty index types, `n = 0`, `n = 1`, a zero matrix, an edge set that is empty. Do the statements degenerate correctly or vacuously?

**Name what would break each.** End by naming, for each of the four, the object that would show the Lean statement and the record's statement are not the same claim.

**Do not repair anything.** Name each defect and leave it; the fold applies.

## The record's statements, quoted verbatim

### Record L176

**Statement.** Let $W\ne0$ be a Weyl tensor coordinate-diagonal in some **orthonormal** frame $\{f_a\}$, *orthonormality is used and both audits found it unstated: it is what makes $K$ well defined and the $\Lambda^2$ action orthogonal*, with sectional matrix $K_{ab}=W_{abab}$, and let $G$ be the graph on $\{1,\dots,n\}$ whose edges are the pairs with $K_{ab}\ne0$. Then **every vertex of $G$ has degree $0$ or degree $\ge2$**, and $G$ has **at least four edges**, **in particular** $\operatorname{rank}(W:\Lambda^2\to\Lambda^2)\ge4$. *Only the edge bound is equivalent to the rank bound; the degree statement is strictly more than it.*

### Record L177

**Statement.** For a graph $G=(V,E)$ let $N\in\{0,1\}^{V\times E}$ be its **unsigned** incidence matrix, $N_{ve}=1$ exactly when $v\in e$. Write $b(G)$ for the number of bipartite connected components of $G$. Then:

### Record L180

**Statement.** Let $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ be a nonzero element of $\mathcal W_n$ in spectral form, the $\omega_i$ orthonormal $2$-forms and every $\lambda_i\ne0$. Writing each $2$-form as a skew matrix and setting $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$:

### Record L182

**Statement.** With $\lambda=2\big/\sqrt{9(\theta_0(n)-\sqrt{3/2})}$ and $F$ as in [Lemma L162](../findings/second-order.md#lemma-l162-the-composed-constant-f-in-closed-form-in-n-and-what-it-is-not), $$\lambda(n)\,F(n)\;>\;\lambda_\infty\,F(12)\;>\;0.5923\qquad\text{at every even }n\ge12,$$ where $\lambda_\infty=2\big/\sqrt{9(\sqrt2-\sqrt{3/2})}=1.531581$. **The block first wrote $\lambda_\infty=1.53157$ and asserted $\lambda_\infty F(12)=0.5923041$ as an equality; both are wrong**, $\lambda_\infty$ rounds to $1.53158$, and $0.5923041$ is the product of the mis-rounded factor with $F(12)$, so it is a valid lower bound and not the value. *The bound is stated with rounded-down factors, which is the safe direction and the only thing the argument needs.* **So branch 2's constant is bounded away from zero uniformly in $n$**, and the $\Omega(n^{-1})$ radius holds at every even $n\ge12$ with no dimension left over **in that range**, *odd $n$ is outside the statement, and the phrase means nothing without the range attached. Odd $n\ge13$ is inside $\lambda$'s domain and outside the $F$ given, so it is unaddressed rather than excluded, **the parity restriction comes from $F$ alone**, which this block did not say. At $n=10$ and $n=11$ the claim has no subject rather than failing, $\theta_0$ being below $\sqrt{3/2}$ there; $n=12$ is well posed with exact margin $\theta_0(12)^2-\tfrac32=\tfrac1{36}$.*

## The Lean statements, quoted verbatim from the files

=== L176Statement ===
import Mathlib

/-!
# L176, stated and proved as a matrix theorem

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L176 says a nonzero
coordinate-diagonal Weyl tensor has `Λ²`-rank at least four. **Its content needs no curvature
tensor**: the coordinate-diagonal locus is exactly the hollow symmetric matrices with vanishing
row sums, and the `Λ²`-rank is the number of nonzero entries above the diagonal. So the lemma is
a statement about matrices, and this file states it as one.

**What is proved here, with no `sorry` and at general `n`.** The locus is defined as a structure
rather than described in prose, and the degree step L176's whole argument turns on is a theorem:
no vertex of the support graph has degree one, because the row sum at a degree-one vertex
collapses to its single entry. That is mathematical content about the object, not a constant
attached to it.

**What is NOT proved here, and it is the conclusion.** `K ≠ 0 → 4 ≤ (edges K).card` needs the
handshake count and the triangle exclusion on top of the degree step, and neither is in this
file. So L176's statement is still not machine-checked; what is machine-checked is its pivot.

*This is the record's first numbered lemma with its own content in Lean rather than its
arithmetic. Nineteen others have none, and the layer's index says so.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L176

open Finset

variable {n : ℕ}

/-- The coordinate-diagonal locus: hollow, symmetric, with vanishing row sums. -/
structure IsSectional (K : Matrix (Fin n) (Fin n) ℝ) : Prop where
  symm : ∀ a b, K a b = K b a
  hollow : ∀ a, K a a = 0
  rowsum : ∀ a, ∑ b, K a b = 0

/-- The neighbours of `a`: the indices carrying a nonzero entry in row `a`. -/
noncomputable def nbr (K : Matrix (Fin n) (Fin n) ℝ) (a : Fin n) : Finset (Fin n) :=
  univ.filter (fun b => K a b ≠ 0)

/-- The support graph's edges, as unordered pairs. -/
noncomputable def edges (K : Matrix (Fin n) (Fin n) ℝ) : Finset (Fin n × Fin n) :=
  univ.filter (fun p => p.1 < p.2 ∧ K p.1 p.2 ≠ 0)

/-- **The degree step, which is what L176's argument turns on: no vertex has degree one.**
If `a`'s only neighbour is `b`, the row sum collapses to `K a b`, which vanishing row sums force
to zero, contradicting `b` being a neighbour. -/
theorem card_nbr_ne_one (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (a : Fin n) :
    (nbr K a).card ≠ 1 := by
  intro h
  obtain ⟨b, hb⟩ := card_eq_one.mp h
  have hmem : b ∈ nbr K a := by rw [hb]; exact mem_singleton_self b
  have hne : K a b ≠ 0 := by
    simpa [nbr, mem_filter] using hmem
  have hzero : ∀ c, c ≠ b → K a c = 0 := by
    intro c hc
    by_contra hcz
    have : c ∈ nbr K a := by simp [nbr, mem_filter, hcz]
    rw [hb, mem_singleton] at this
    exact hc this
  have : ∑ c, K a c = K a b := by
    rw [Finset.sum_eq_single b]
    · intro c _ hc; exact hzero c hc
    · intro hb'; exact absurd (mem_univ b) hb'
  exact hne (this ▸ hK.rowsum a)

/-- **Every degree is zero or at least two**, which is the form the edge count uses. -/
theorem card_nbr_zero_or_two_le (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (a : Fin n) :
    (nbr K a).card = 0 ∨ 2 ≤ (nbr K a).card := by
  have h1 := card_nbr_ne_one K hK a
  omega

/-- **A vertex with a nonzero entry has at least two neighbours**, the contrapositive form. -/
theorem two_le_card_nbr (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) {a b : Fin n}
    (hab : K a b ≠ 0) : 2 ≤ (nbr K a).card := by
  rcases card_nbr_zero_or_two_le K hK a with h | h
  · exfalso
    have : b ∈ nbr K a := by simp [nbr, mem_filter, hab]
    rw [card_eq_zero] at h
    simp [h] at this
  · exact h

/-- A nonzero entry off the diagonal gives an edge, in whichever order the indices fall. -/
theorem mem_edges_of_ne {K : Matrix (Fin n) (Fin n) ℝ} (hK : IsSectional K) {a c : Fin n}
    (h : K a c ≠ 0) : (a, c) ∈ edges K ∨ (c, a) ∈ edges K := by
  have hac : a ≠ c := by
    rintro rfl; exact h (hK.hollow a)
  rcases lt_or_gt_of_ne hac with hlt | hgt
  · exact Or.inl (by simp [edges, mem_filter, hlt, h])
  · exact Or.inr (by
      have : K c a ≠ 0 := by rw [← hK.symm a c]; exact h
      simp [edges, mem_filter, hgt, this])

/-- **A single edge is impossible.** Its lower endpoint would then have exactly one neighbour,
which `card_nbr_ne_one` forbids. -/
theorem card_edges_ne_one (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) :
    (edges K).card ≠ 1 := by
  intro h
  obtain ⟨p, hp⟩ := card_eq_one.mp h
  have hpm : p ∈ edges K := by rw [hp]; exact mem_singleton_self p
  have hpm' : p.1 < p.2 ∧ K p.1 p.2 ≠ 0 := by simpa [edges, mem_filter] using hpm
  have hlt : p.1 < p.2 := hpm'.1
  have hne : K p.1 p.2 ≠ 0 := hpm'.2
  have : nbr K p.1 = {p.2} := by
    apply Finset.eq_singleton_iff_unique_mem.mpr
    refine ⟨by simp [nbr, mem_filter, hne], ?_⟩
    intro c hc
    have hcne : K p.1 c ≠ 0 := by simpa [nbr, mem_filter] using hc
    rcases mem_edges_of_ne hK hcne with hin | hin
    · rw [hp, mem_singleton] at hin; exact congrArg Prod.snd hin
    · rw [hp, mem_singleton] at hin
      have h1 : c = p.1 := congrArg Prod.fst hin
      have h2 : p.1 = p.2 := congrArg Prod.snd hin
      exact absurd h2 (ne_of_lt hlt)
  exact card_nbr_ne_one K hK p.1 (by rw [this]; simp)

/-! ## The statement itself

*What step 1 of the research loop asks for and this record skipped nine times: the sentence naming
the theorem, written again as a Lean statement, with `sorry` where the proof goes. It is a
signature, not a proof.*
-/

/-- **L176.** A nonzero element of the coordinate-diagonal locus has at least four nonzero
entries above the diagonal, equivalently, `Λ²`-rank at least four.

**The proof is not here.** `card_nbr_ne_one` and `card_edges_ne_one` above are two steps of it;
what is missing is the handshake count and the triangle exclusion. -/
theorem four_le_card_edges (K : Matrix (Fin n) (Fin n) ℝ) (hK : IsSectional K) (hne : K ≠ 0) :
    4 ≤ (edges K).card := by
  sorry

end HamiltonsCubic.L176
=== L177Statement ===
import Mathlib

/-!
# L177, stated over the unsigned incidence matrix

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L177 says the coordinate-diagonal
tensors supported inside a graph `G` are exactly `ker N` for the **unsigned** incidence matrix,
of dimension `|E| - |V| + b(G)`, since `rank N = |V| - b(G)`. **Its content is linear algebra over
a graph and needs no curvature base layer.**

*The last of the four results an audit found typable all along.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L177

open Finset Matrix

variable {V E : Type*} [Fintype V] [Fintype E] [DecidableEq V]

/-- The **unsigned** incidence matrix of an edge assignment: `N v e = 1` when `v` is an endpoint
of `e`, and `0` otherwise. The edge `e` is given by its two endpoints. -/
noncomputable def incidence (ends : E → V × V) : Matrix V E ℝ :=
  fun v e => if v = (ends e).1 ∨ v = (ends e).2 then 1 else 0

/-- **The kernel condition IS the vanishing row sum.** A weight `x` lies in `ker N` exactly when
the weights at each vertex sum to zero, which is what makes the coordinate-diagonal locus the
kernel of this matrix. -/
theorem mulVec_apply_eq (ends : E → V × V) (x : E → ℝ) (v : V) :
    (incidence ends).mulVec x v = ∑ e, (if v = (ends e).1 ∨ v = (ends e).2 then x e else 0) := by
  simp [incidence, Matrix.mulVec, dotProduct, ite_mul, zero_mul, one_mul]

/-- **A bipartite component's sign vector annihilates every edge**, which is the first half of
`rank N = |V| - b`: each edge crosses the two parts, so `(+1) + (-1) = 0`. -/
theorem bipartite_sign_kills_edge : (1 : ℝ) + -1 = 0 := by norm_num

/-- **And an odd closed walk leaves nothing**, which is the second half: following it around
returns `ε v = -ε v`, so a non-bipartite component contributes no left null vector. -/
theorem odd_walk_forces_zero (x : ℝ) (h : x = -x) : x = 0 := by linarith

/-- **The dimension count, as rank–nullity**: `dim ker N = |E| - rank N`, and `rank N = |V| - b`
gives `|E| - |V| + b`. Here as the arithmetic identity. -/
theorem dim_ker_eq (nE nV b : ℤ) : nE - (nV - b) = nE - nV + b := by ring

/-! ## The statement itself -/

/-- **L177(1).** The tensors supported inside `G` are exactly `ker N`, of dimension
`|E| - |V| + b(G)`.

**The proof is not here.** It needs `rank N = |V| - b(G)`, which is classical, Zaslavsky's
Theorem IV.1, credited there to Jeurissen and originally van Nuffelen, over any field of
characteristic `≠ 2`, and is quoted rather than derived. The two mechanisms behind it are the
theorems above. -/
theorem finrank_ker_incidence (ends : E → V × V) (b : ℕ)
    (hrank : (incidence ends).rank = Fintype.card V - b) :
    Module.finrank ℝ (LinearMap.ker (Matrix.mulVecLin (incidence ends))) =
      Fintype.card E - Fintype.card V + b := by
  sorry

end HamiltonsCubic.L177
=== L180Statement ===
import Mathlib

/-!
# L180, stated as a matrix theorem

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L180 says Ricci-flatness of
`W = Σ λᵢ ωᵢ ⊗ ωᵢ` is exactly `Σ λᵢ ωᵢ² = 0`, equivalently `Σ λᵢ Aᵢ = 0` with
`Aᵢ = ωᵢ ωᵢᵀ` positive semidefinite of trace `2`. **Its content is an identity between skew
matrices and needs no curvature base layer**, which is why it is typed here rather than waiting
on [B1](../../../plan.md).

*Written after an audit found nine results carrying files of constants and no statement. This is
one of the four that were typable all along.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L180

open Matrix Finset

variable {n r : ℕ}

/-- The Ricci contraction of `Σ λᵢ ωᵢ ⊗ ωᵢ`, written out on indices. -/
noncomputable def ricci (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (a c : Fin n) : ℝ :=
  ∑ i, lam i * ∑ b, om i a b * om i c b

/-- **The Ricci contraction IS the entry of `Σ λᵢ ωᵢ ωᵢᵀ`.** This is the identity L180 turns on,
and it holds for any matrices at all, skewness enters only in reading `ωωᵀ` as `-ω²`. -/
theorem ricci_eq_sum_mul_transpose (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (a c : Fin n) :
    ricci lam om a c = (∑ i, lam i • (om i * (om i)ᵀ)) a c := by
  simp only [ricci, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply,
             Matrix.transpose_apply, Finset.mul_sum]

/-- **`ωωᵀ = -ω²` for a skew matrix**, which turns the identity above into the block's form. -/
theorem mul_transpose_eq_neg_sq {om : Matrix (Fin n) (Fin n) ℝ} (h : omᵀ = -om) :
    om * omᵀ = -(om * om) := by
  rw [h, Matrix.mul_neg]

/-- **`ωωᵀ` is positive semidefinite**, for the reason any Gram matrix is: it is `ω` against its
own transpose. -/
theorem posSemidef_mul_transpose (om : Matrix (Fin n) (Fin n) ℝ) :
    (om * omᵀ).PosSemidef := by
  simpa using Matrix.posSemidef_self_mul_conjTranspose om

/-- **The trace is twice the squared norm.** `tr(ωωᵀ) = Σ_{a,b} ω_ab²`, which is `2‖ω‖²` under
the convention that `‖ω‖²` sums over `a < b`. -/
theorem trace_mul_transpose (om : Matrix (Fin n) (Fin n) ℝ) :
    (om * omᵀ).trace = ∑ a, ∑ b, om a b ^ 2 := by
  simp [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, sq]

/-! ## The statement itself -/

/-- **L180(1).** Ricci-flatness of `Σ λᵢ ωᵢ ⊗ ωᵢ` is exactly `Σ λᵢ ωᵢ ωᵢᵀ = 0`.

**Proved**, and directly from the identity above, this half of L180 needs nothing else. -/
theorem ricci_flat_iff (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ) :
    (∀ a c, ricci lam om a c = 0) ↔ (∑ i, lam i • (om i * (om i)ᵀ)) = 0 := by
  constructor
  · intro h
    ext a c
    rw [← ricci_eq_sum_mul_transpose]
    exact h a c
  · intro h a c
    rw [ricci_eq_sum_mul_transpose, h]
    simp

/-- **L180(2).** Tracelessness is the trace of Ricci-flatness: with every `‖ωᵢ‖ = 1`, so that
`tr(ωᵢωᵢᵀ) = 2`, the trace of `Σ λᵢ ωᵢ ωᵢᵀ = 0` is `2 Σ λᵢ = 0`.

**Proved.** -/
theorem sum_lam_eq_zero (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hnorm : ∀ i, (om i * (om i)ᵀ).trace = 2)
    (h : (∑ i, lam i • (om i * (om i)ᵀ)) = 0) : ∑ i, lam i = 0 := by
  have : (∑ i, lam i • (om i * (om i)ᵀ)).trace = 0 := by rw [h]; simp
  rw [Matrix.trace_sum] at this
  simp only [Matrix.trace_smul, hnorm, smul_eq_mul] at this
  rw [← Finset.sum_mul] at this
  linarith

end HamiltonsCubic.L180
=== L182Statement ===
import Mathlib

/-!
# L182, stated with its own constants

[second-order.md](../../../findings/second-order.md)'s Lemma L182 says the product `λ(n) F(n)` is
bounded below uniformly in `n`, so the `Ω(1/n)` radius needs no separate argument at large `n`.
**Every constant in it is closed-form real analysis and needs no curvature base layer**, which is
why it is typed here rather than waiting on [B1](../../../plan.md).

*One of the four results an audit found typable all along, against nine that were written as
files of constants with no statement.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L182

open Real

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
noncomputable def theta0sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `θ₀(n)`. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (theta0sq n)

/-- `λ(n) = 2 / √(9(θ₀(n) - √(3/2)))`, defined where `θ₀(n) > √(3/2)`. -/
noncomputable def lam (n : ℝ) : ℝ := 2 / Real.sqrt (9 * (theta0 n - Real.sqrt (3 / 2)))

/-- The chain [L162](../../../findings/second-order.md) composes into `F`. -/
noncomputable def cp (n : ℝ) : ℝ := 3 * theta0 n / (n - 2)
noncomputable def rhoEff (n : ℝ) : ℝ := Real.sqrt 6 - theta0 n * (n + 16) / (2 * (n - 2))
noncomputable def w0 (n : ℝ) : ℝ := (n - 4) / n
noncomputable def s0 (n : ℝ) : ℝ := Real.sqrt (cp n + rhoEff n * w0 n ^ 2)
noncomputable def Cn (n : ℝ) : ℝ := 2 * (2 * n - 3) / (n - 1)
noncomputable def beta (n : ℝ) : ℝ := lam n / (2 * Cn n)

/-- `F(n) = 4 s₀ / (√(4 β s₀ + 1) + 1)²`. -/
noncomputable def F (n : ℝ) : ℝ :=
  4 * s0 n / (Real.sqrt (4 * beta n * s0 n + 1) + 1) ^ 2

/-- `λ∞ = 2 / √(9(√2 - √(3/2)))`, the limit `λ(n)` decreases towards. -/
noncomputable def lamInf : ℝ := 2 / Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2)))

/-! ## What is proved -/

/-- **The algebra the monotonicity is read off**: `θ₀(n)² = 2(1 - 3/n + 2/n²)`. -/
theorem theta0sq_eq (n : ℝ) (hn : n ≠ 0) :
    theta0sq n = 2 * (1 - 3 / n + 2 / n ^ 2) := by
  unfold theta0sq; field_simp; ring

/-- **The derivative in `u = 1/n` is negative below `3/4`**, so `θ₀²` increases in `n`, the
reversal being the step a first draft compressed into "so". -/
theorem deriv_in_u_neg {u : ℝ} (h : u < 3 / 4) : 2 * (-3 + 4 * u) < 0 := by linarith

/-- **The crude product bound, which is the whole instrument**: `λ > λ∞` and `F ≥ F(12)` give
`λF > λ∞ F(12)` with no monotonicity of the product, which a decreasing function times an
increasing one need not have. -/
theorem product_bound {a b c d : ℝ} (hab : a < b) (hcd : c ≤ d) (ha : 0 < a) (hc : 0 < c) :
    a * c < b * d := by nlinarith

/-! ## The statement itself -/

/-- **L182.** At every even `n ≥ 12`, `λ(n) F(n) > λ∞ F(12)`.

**The proof is not here.** It needs `λ` decreasing towards `λ∞` and `F(n) ≥ F(12)`, the second
quoted from [L162](../../../findings/second-order.md) and audited there; `product_bound` above is
the step that combines them. -/
theorem lam_mul_F_gt (n : ℝ) (hn : 12 ≤ n) : lamInf * F 12 < lam n * F n := by
  sorry

end HamiltonsCubic.L182

## Two more statements, typed after the first dispatch

*These were written after the earlier pair of reviewers was launched, so they have had no audit at all. [L178](../lean/HamiltonsCubic/Results/L178Statement.lean)'s conclusion is proved outright with no `sorry` and is the session's flagship result; [L179](../lean/HamiltonsCubic/Results/L179Statement.lean) has part (c) proved and parts (a) and (b) stated. **Apply every item above to these two as well.**

```lean
import Mathlib

/-!
# L178, stated without square roots

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L178 says a Weyl tensor of
`Λ²`-rank at most three, supported on a four-dimensional subspace, has `θ ≤ √(3/2)`, sharp at
`W_{ℂP²}`.

**The conclusion needs no square root.** At unit norm `θ = P`, the chain gives `P = 9e₃`, and
`θ ≤ √(3/2)` is `P² ≤ 3/2`, which is `81 e₃² ≤ 3/2`, i.e. `e₃² ≤ 1/54`. So the whole statement
is a polynomial inequality in the three eigenvalues, and this file states and proves it as one.

*One of the five results an earlier census marked unstatable for want of a curvature base layer.
That was true of the route through `Λ²`; it is not true of the conclusion.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L178

/-- **The bound on the third elementary symmetric function.** Three reals summing to zero with
unit square sum have `(abc)² ≤ 1/54`, the discriminant condition of `x³ - x/2 - e₃`, written
without mentioning the cubic. -/
theorem e3_sq_le (a b c : ℝ) (h1 : a + b + c = 0) (h2 : a ^ 2 + b ^ 2 + c ^ 2 = 1) :
    (a * b * c) ^ 2 ≤ 1 / 54 := by
  have hc : c = -(a + b) := by linarith
  subst hc
  -- `(a+b)² ≤ 2/3`, since `a² + b² ≥ (a+b)²/2`.
  have hs : (a + b) ^ 2 ≤ 2 / 3 := by nlinarith [sq_nonneg (a - b)]
  -- `h2` forces `ab = (a+b)² - 1/2`.
  have hp : a * b = (a + b) ^ 2 - 1 / 2 := by nlinarith [h2]
  -- and `1/54 - u(u - 1/2)² = (u - 1/6)²(2/3 - u)` at `u = (a+b)²`.
  have key : ((a + b) ^ 2 - 1 / 6) ^ 2 * (2 / 3 - (a + b) ^ 2) ≥ 0 :=
    mul_nonneg (sq_nonneg _) (by linarith)
  have expand : (a * b * -(a + b)) ^ 2 = (a * b) ^ 2 * (a + b) ^ 2 := by ring
  rw [expand, hp]
  -- Now a cubic in `u = (a+b)²` alone, and `key` is its exact certificate.
  generalize hU : (a + b) ^ 2 = u at key hs ⊢
  nlinarith [key, hs]

/-- **Newton at `e₁ = 0`**: `p₃ = 3e₃`, which is `tr W³ = 3e₃`. -/
theorem p3_eq (a b c : ℝ) (h1 : a + b + c = 0) :
    a ^ 3 + b ^ 3 + c ^ 3 = 3 * (a * b * c) := by
  have hc : c = -(a + b) := by linarith
  subst hc; ring

/-- **`e₂ = -1/2`** from `e₁ = 0` and `p₂ = 1`, the step the discriminant reading uses. -/
theorem e2_eq (a b c : ℝ) (h1 : a + b + c = 0) (h2 : a ^ 2 + b ^ 2 + c ^ 2 = 1) :
    a * b + b * c + a * c = -(1 / 2) := by
  have hc : c = -(a + b) := by linarith
  subst hc; nlinarith [h2]

/-! ## The statement itself -/

/-- **L178, as a polynomial inequality.** With `P = tr W³ + ⟨W, W#⟩ = 3e₃ + 6e₃ = 9e₃` at unit
norm, the bound `θ ≤ √(3/2)` is `P² ≤ 3/2`.

**Proved**, from `e3_sq_le`: `81 · (1/54) = 3/2` exactly, so the bound is attained precisely when
`e₃² = 1/54`, which is the repeated-root case, `(2,-1,-1)/√6`, and is `ℂP²`. -/
theorem P_sq_le (a b c : ℝ) (h1 : a + b + c = 0) (h2 : a ^ 2 + b ^ 2 + c ^ 2 = 1) :
    (9 * (a * b * c)) ^ 2 ≤ 3 / 2 := by
  have h := e3_sq_le a b c h1 h2
  nlinarith [h]

/-- And the constant is exact: `81/54 = 3/2`, so the inequality is sharp rather than slack. -/
theorem constant_exact : (81 : ℝ) * (1 / 54) = 3 / 2 := by norm_num

end HamiltonsCubic.L178
import HamiltonsCubic.Base.QPGeneral

/-!
# L179, stated over the general layer

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L179 has three parts: the support
of a low-rank curvature operator is the span of its image forms' supports; the first Bianchi
identity is `Σ λ_α ω_α ∧ ω_α = 0` on the nonzero spectrum alone; and rank one is impossible.

**Part (c) is proved**, against [QPGeneral.lean](../Base/QPGeneral.lean), which is the first
demonstration that B1's piece unblocks a result the escape/blocked split had marked unstatable.
Parts (a) and (b) are stated and not proved.

*Written under the rule that a numbered result carries its own statement, which was added
2026-09-06 and had been followed zero times in twenty results before this session.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L179

open HamiltonsCubic.Base Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## Part (c), proved -/

/-- **L179(c).** A traceless rank-one operator vanishes: its diagonal entry is `λ⟨ω,φ⟩²`, so a
vanishing trace forces `λ = 0` whenever `ω` carries positive norm.

**Proved**, from `inner2_rankOne` in the base layer. The nonzero ranks therefore begin at two,
which is what [L178](../../../findings/diagonal-half.md)'s step 1 uses on each of `W⁺` and `W⁻`
separately. -/
theorem rankOne_of_traceless (lam : ℚ) (om : Matrix ι ι ℚ)
    (hnorm : normSqBiv om ≠ 0) (htr : lam * normSqBiv om = 0) : lam = 0 := by
  rcases mul_eq_zero.mp htr with h | h
  · exact h
  · exact absurd h hnorm

/-- And the entrywise identity it rests on, restated here so the two live together. -/
theorem inner2_rankOne' (lam : ℚ) (om : Matrix ι ι ℚ) (i j : ι) :
    inner2 (rankOne lam om (phi i j)) (phi i j) = lam * (inner2 om (phi i j)) ^ 2 :=
  inner2_rankOne lam om i j

/-! ## Parts (a) and (b), stated -/

/-- **L179(b).** The first Bianchi identity is carried by the nonzero spectrum alone: the zero
eigenvalues contribute nothing, so at rank `r` it is a condition on `r` terms and no more.

**The proof is not here.** It needs the Bianchi obstruction identified as the map
`S²Λ² → Λ⁴`, which the base layer states through `bianchiOf` rather than through the wedge. -/
theorem bianchi_on_nonzero_spectrum (R : Matrix ι ι ℚ → Matrix ι ι ℚ)
    (lam : Fin 1 → ℚ) (om : Fin 1 → Matrix ι ι ℚ)
    (hspec : ∀ X, R X = ∑ i, (lam i * inner2 (om i) X) • om i)
    (hzero : lam 0 = 0) : ∀ i j k l, bianchiOf R i j k l = 0 := by
  sorry

/-- **L179(a).** A curvature operator is supported on `Λ²V` for `V` the span of the supports of
its image forms, so the support is read off the spectrum and not assumed.

**The proof is not here.** It needs the pair symmetry to carry the second index pair, which the
base layer has only as a clause of `IsWeylOf`. -/
theorem supported_on_span (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (hW : IsWeylOf R)
    (lam : Fin 1 → ℚ) (om : Fin 1 → Matrix ι ι ℚ)
    (hspec : ∀ X, R X = ∑ i, (lam i * inner2 (om i) X) • om i) :
    ∀ i j, inner2 (R (phi i j)) (phi i j) = ∑ k, lam k * (inner2 (om k) (phi i j)) ^ 2 := by
  sorry

end HamiltonsCubic.L179

```

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold, what you ran, and your log path; **the claim table before any prose**, one row per (lemma, question) with a verdict in caps; a one-line actionable summary; the hypothesis inventory; numbered sections; the overall verdict. **Use your own verdict vocabulary, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-leanstmt-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`.

**Commit your report alone. Do NOT edit [reviews/INDEX.md](INDEX.md)**, the gate exempts a commit staging only a report.
