import Mathlib

set_option linter.style.longLine false

/-!
# L128, stated in the parts that do not need the manifold or curvature layer

## The record's statement, verbatim

> **Let $W$ be a pure (frame-diagonal) critical point of unit norm with $\theta=P(W)>0$ and
> sectional matrix $M$, in a fixed frame. Write $\mathcal O=SO(n)\cdot W$ and decompose
> $\mathcal W_n$ by [Lemma L120]. Then:**
>
> **(i) (Location of the orbit, on record, restated for use.)
> $T_W\mathcal O\subseteq\bigoplus_{\{j,k\}}V_{jk}$, and the $\{j,k\}$-component of
> $[\rho(E_{jk}),W]$ is $o^{jk}_i=M_{ki}-M_{ji}$, $i\notin\{j,k\}$. The four-set blocks and
> $\mathcal D_n$ carry no orbit direction.**
>
> **(ii) (Block criterion.) $W$ is Morse–Bott nondegenerate,
> $\ker\mathrm{Hess}(P|_S)_W=T_W\mathcal O$, if and only if $\tfrac12$ is NOT an $L_e$-eigenvalue
> of any four-set block or of $\mathcal D_n\cap W^\perp$, and in every pair block $\tfrac12$ is
> either absent or simple with eigenvector $o^{jk}$.**
>
> **(iii) (Branching clause.) If (ii) holds then some neighbourhood of $\mathcal O$ in
> $S(\mathcal W_n)$ contains no critical point outside $\mathcal O$. Hence a critical point
> outside $\mathcal O$ can approach $\mathcal O$ only if (ii) fails, only where a non-orbit block
> carries $\tfrac12$ exactly.**
>
> **(iv) (Uniform separation, the form [I5] consumes.) If (ii) holds at every pure critical point
> with $\theta\ge c>0$, then $A=\{\text{non-pure critical}\}\cap\{\theta\ge c\}$ and
> $B=O(n)\cdot(\mathcal D_n\cap S)$ have $\overline A\cap B=\varnothing$, and both are compact, so
> $d(A,B)>0$.**

> **THE INEQUALITIES IN (ii) ARE EXCLUSIONS OF $\tfrac12$, NOT STRICT BOUNDS, AND THE DIFFERENCE
> HAS A WITNESS ON THE RECORD.** […] A block **above** $\tfrac12$ is possible because the
> hypothesis is criticality, not maximality: $S^2\times S^4$ at $n=6$ is pure, critical and
> Morse–Bott nondegenerate, while its $(2,2)$ four-set blocks sit at $\mu_{2,4}=\tfrac23>\tfrac12$.

[second-order.md](../../../findings/second-order.md), Lemma L128 and Corollary L128.1.

## What is typed here and what is not

**Not typed: (i), and the implicit-function step of (iii).** (i) needs `Λ²ℝⁿ`, the sectional
matrix and `ρ(E_{jk})`; (iii)'s conclusion is a statement about a neighbourhood of a submanifold
of a sphere, which needs the manifold layer. **What is typed of (iii) is its load-bearing
algebraic step**, that self-adjointness of `dF_W` puts its image in `(ker dF_W)ᗮ` and makes its
restriction there injective, which is exactly what the record's proof needs to apply the implicit
function theorem without a slice.

**Typed and proved here, with no `sorry`:**

* `ker_hess_eq_eigenspace`, (ii)'s first step: `Hess = 6θ(L_e - ½ Id)` with `θ > 0` makes the
  Hessian kernel the `½`-eigenspace of `L_e`, *an eigenspace*, which is why the criterion excludes
  the value `½` rather than bounding the spectrum.
* `eigenvalue_above_half_witness`, the record's correction, in miniature: an operator with an
  eigenvalue `2/3 > ½` and empty `½`-eigenspace, so "nondegenerate" and "spectrum `< ½`" are
  different statements and the first does not imply the second.
* `mem_eigenspace_pi` and `eigenspace_pi_eq_iff`, (ii)'s second step: for a block-diagonal
  operator the `½`-eigenspace is read block by block, so nondegeneracy says exactly that no block
  contributes a `½`-vector beyond the orbit's.
* `range_le_ker_orthogonal` and `injOn_ker_orthogonal`, (iii)'s algebraic step.
* `disjoint_compacts_separated`, (iv), as the metric statement it is.
* `four_set_threshold` and `pair_block_below_half`, Corollary L128.1's two arithmetic legs.
-/

namespace HamiltonsCubic.L128

open Module

/-! ## (ii), first step: the Hessian kernel is an eigenspace -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **The Hessian kernel is `L_e`'s `½`-eigenspace.** With
`Hess(P|_S)_W = 6θ(L_e - ½ Id)` on `T_W S = W^⊥` and `θ > 0`, the scalar is invertible and drops
out. *This is why (ii) excludes the value `½` rather than bounding the spectrum: the object is an
eigenspace.* -/
theorem ker_hess_eq_eigenspace (θ : ℝ) (hθ : 0 < θ) (Le : End ℝ E) :
    LinearMap.ker ((6 * θ) • (Le - (1 / 2 : ℝ) • LinearMap.id)) = End.eigenspace Le (1 / 2) := by
  have hne : (6 * θ) ≠ 0 := by positivity
  ext x
  simp only [LinearMap.mem_ker, LinearMap.smul_apply, smul_eq_zero, hne, false_or,
    End.mem_eigenspace_iff, LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply,
    sub_eq_zero]

/-- **An eigenvalue above `½` is compatible with nondegeneracy.** On `ℝ²` the diagonal operator
`(2/3, 0)` has empty `½`-eigenspace while carrying `2/3 > ½`. *This is the record's `S² × S⁴`
correction in miniature: the first version of (ii) wrote "`L_e`-spectrum `< ½`" and both reviewers
refuted it, the hypothesis being criticality rather than maximality.* -/
theorem eigenvalue_above_half_witness :
    ∃ f : End ℝ ℝ, End.eigenspace f (1 / 2 : ℝ) = ⊥ ∧ End.HasEigenvalue f (2 / 3 : ℝ) := by
  refine ⟨(2 / 3 : ℝ) • LinearMap.id, ?_, ?_⟩
  · rw [eq_bot_iff]
    intro x hx
    rw [End.mem_eigenspace_iff] at hx
    simp only [LinearMap.smul_apply, LinearMap.id_apply, smul_eq_mul] at hx
    have hz : x = 0 := by linarith
    simpa using hz
  · rw [End.hasEigenvalue_iff, Submodule.ne_bot_iff]
    refine ⟨1, ?_, one_ne_zero⟩
    rw [End.mem_eigenspace_iff]
    norm_num

/-! ## (ii), second step: block-diagonal eigenspaces are read block by block -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {F : ι → Type*} [∀ i, AddCommGroup (F i)] [∀ i, Module ℝ (F i)]

/-- A block-diagonal operator: `L120`'s decomposition of `𝒲ₙ` over the sign characters, with one
endomorphism per block. -/
def blockDiag (g : ∀ i, End ℝ (F i)) : End ℝ (∀ i, F i) where
  toFun x := fun i => g i (x i)
  map_add' x y := by funext i; simp
  map_smul' c x := by funext i; simp

/-- **The `μ`-eigenspace of a block-diagonal operator is read block by block.** This is the step
(ii) turns on: `ker Hess` is the sum of its block components. -/
theorem mem_eigenspace_pi (g : ∀ i, End ℝ (F i)) (μ : ℝ) (x : ∀ i, F i) :
    x ∈ End.eigenspace (blockDiag g) μ ↔ ∀ i, x i ∈ End.eigenspace (g i) μ := by
  simp only [End.mem_eigenspace_iff]
  constructor
  · intro h i; exact congrFun h i
  · intro h; funext i; exact h i

/-- **(ii) as an equality of eigenspaces, block by block.** The left-hand side says the
`μ`-eigenspace of the whole operator is exactly the designated family `O`, at `μ = ½` and
`O` the orbit's components, this is Morse–Bott nondegeneracy. The right-hand side says no block
contributes a `μ`-vector beyond its own `O i`. -/
theorem eigenspace_pi_eq_iff (g : ∀ i, End ℝ (F i)) (μ : ℝ) (O : ∀ i, Submodule ℝ (F i)) :
    (∀ x : ∀ i, F i, x ∈ End.eigenspace (blockDiag g) μ ↔ ∀ i, x i ∈ O i) ↔
      ∀ i, End.eigenspace (g i) μ = O i := by
  constructor
  · intro h i
    ext v
    have hx := h (Pi.single i v)
    rw [mem_eigenspace_pi] at hx
    constructor
    · intro hv
      have h1 : ∀ j, Pi.single i v j ∈ End.eigenspace (g j) μ := by
        intro j
        by_cases hj : j = i
        · subst hj; simpa using hv
        · rw [Pi.single_eq_of_ne hj]; exact Submodule.zero_mem _
      have := (hx.mp h1) i
      simpa using this
    · intro hv
      have h2 : ∀ j, Pi.single i v j ∈ O j := by
        intro j
        by_cases hj : j = i
        · subst hj; simpa using hv
        · rw [Pi.single_eq_of_ne hj]; exact Submodule.zero_mem _
      have := (hx.mpr h2) i
      simpa using this
  · intro h x
    rw [mem_eigenspace_pi]
    exact forall_congr' fun i => by rw [h i]

/-! ## (iii)'s algebraic step

*The record's proof: "self-adjointness gives `im dF_W ⊆ (ker dF_W)ᗮ = V'`, hence
`Π_{V'} dF_W|_{V'} = dF_W|_{V'}`", which is what lets the implicit function theorem run in the
ambient space, with no equivariant slice and no Lyapunov–Schmidt reduction.* -/

/-- **The image of a symmetric operator lies in the orthogonal complement of its kernel.** -/
theorem range_le_ker_orthogonal {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric) (x : E) :
    T x ∈ (LinearMap.ker T)ᗮ := by
  rw [Submodule.mem_orthogonal]
  intro y hy
  rw [LinearMap.mem_ker] at hy
  rw [← hT y x, hy, inner_zero_left]

/-- **And it is injective on that complement**, which is the invertibility the implicit function
theorem consumes. -/
theorem injOn_ker_orthogonal {T : E →ₗ[ℝ] E} {x : E}
    (hx : x ∈ (LinearMap.ker T)ᗮ) (hTx : T x = 0) : x = 0 := by
  have hker : x ∈ LinearMap.ker T := LinearMap.mem_ker.mpr hTx
  have : x ∈ LinearMap.ker T ⊓ (LinearMap.ker T)ᗮ := ⟨hker, hx⟩
  simpa [Submodule.inf_orthogonal_eq_bot] using this

/-! ## (iv), as the metric statement it is -/

/-- **(iv): disjoint compacts are uniformly separated.** The record's `A` and `B`, with `closure A`
and `B` compact and disjoint (the disjointness being what (ii) and (iii) buy), have positive
distance. *The record's own note is that `A` itself is cut by an open condition, so nothing
elementary closes it and the step must run on `closure A`.* -/
theorem disjoint_compacts_separated {X : Type*} [MetricSpace X] {A B : Set X}
    (hA : IsCompact (closure A)) (hB : IsCompact B) (hBne : B.Nonempty)
    (hdisj : Disjoint (closure A) B) (hAne : (closure A).Nonempty) :
    ∃ ε > 0, ∀ a ∈ A, ∀ b ∈ B, ε ≤ dist a b := by
  have hBclosed : IsClosed B := hB.isClosed
  have hcont : Continuous fun x : X => Metric.infDist x B :=
    Metric.continuous_infDist_pt B
  obtain ⟨x₀, hx₀, hmin⟩ := hA.exists_isMinOn hAne hcont.continuousOn
  have hpos : 0 < Metric.infDist x₀ B := by
    rw [← hBclosed.notMem_iff_infDist_pos hBne]
    exact Set.disjoint_left.mp hdisj hx₀
  refine ⟨Metric.infDist x₀ B, hpos, fun a ha b hb => ?_⟩
  have ha' : a ∈ closure A := subset_closure ha
  have h1 : Metric.infDist x₀ B ≤ Metric.infDist a B := isMinOn_iff.mp hmin a ha'
  exact h1.trans (Metric.infDist_le_dist_of_mem hb)

/-! ## Corollary L128.1's two arithmetic legs

*"the four-set blocks meet `½` exactly when `Σ = θ²`, which [Lemma L126] shows happens iff
`1/(p-1) + 1/(q-1) = 1`, i.e. only at `S³ × S³`"; and "the pair blocks […] top out at
`(p-2)/(2(p-1)) < ½` within a factor".* -/

/-- **The four-set threshold is met only at `S³ × S³`.** For `p, q ≥ 3`, the equation
`1/(p-1) + 1/(q-1) = 1` forces `p = q = 3`, so it is never met at `n = p + q ≥ 12`. -/
theorem four_set_threshold (p q : ℕ) (hp : 3 ≤ p) (hq : 3 ≤ q) :
    (1 : ℝ) / (p - 1) + 1 / (q - 1) = 1 ↔ p = 3 ∧ q = 3 := by
  have hp' : (2 : ℝ) ≤ (p : ℝ) - 1 := by
    have : (3 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  have hq' : (2 : ℝ) ≤ (q : ℝ) - 1 := by
    have : (3 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  have hpne : ((p : ℝ) - 1) ≠ 0 := by linarith
  have hqne : ((q : ℝ) - 1) ≠ 0 := by linarith
  constructor
  · intro h
    rw [div_add_div _ _ hpne hqne, div_eq_one_iff_eq (by positivity)] at h
    have hpe : (p : ℝ) = 3 := by nlinarith
    have hqe : (q : ℝ) = 3 := by nlinarith
    constructor
    · exact_mod_cast hpe
    · exact_mod_cast hqe
  · rintro ⟨rfl, rfl⟩
    norm_num

/-- **The within-factor pair blocks stay strictly below `½`.** -/
theorem pair_block_below_half (p : ℕ) (hp : 2 ≤ p) :
    ((p : ℝ) - 2) / (2 * ((p : ℝ) - 1)) < 1 / 2 := by
  have hp' : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  rw [div_lt_div_iff₀ (by linarith) (by norm_num)]
  linarith

end HamiltonsCubic.L128
