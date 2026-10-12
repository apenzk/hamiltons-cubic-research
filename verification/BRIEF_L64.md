# Brief, round L64

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the statement and proof as the findings file carries them ([findings/fence-posts.md](../findings/fence-posts.md) line 241, under the heading at line 227)

**The statement, with the scope it owes.** Over the finite sequence $\{B_n\}$ of signed permutations, where presentation degrees exist, the unique $B_n$-invariant extension of an $O(n_0)$-invariant is $O(n)$-invariant at every $n\ge n_0\ge k_B$. **It is an $O(n)$ statement and is FALSE for $SO(n)$**, $\epsilon$-diagrams being neither dimension-free nor padding-compatible; the record's actual use is $O(12)$, so nothing breaks, and the condition belongs in the statement. The first fundamental theorem spans $O$-invariants by contraction diagrams at *every* dimension, and each restricts correctly under padding, no free $\delta$-loop being available since every slot sits on a Weyl factor; Proposition 2.9's projection isomorphism then forces the unique extension to *be* that lift.

## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 224)

- **Lemma L64 (direct). The transfer mechanism.** Over the sequence of signed permutation groups $B_n$, where presentation degrees exist, the unique $B_n$-invariant extension of an $O(n_0)$-invariant is $O(n)$-invariant for every $n\ge n_0\ge k_B$: the first fundamental theorem spans $O$-invariants by contraction diagrams at every $n$, each restricting correctly under padding with no free $\delta$-loop.

## Passage C, the canonical statement, detail form ([results.md](../results.md) line 765, under the heading at line 763)

Let $n\ge n_0\ge k_B$, with $k_B$ the presentation degree of the sequence $\{B_n\}$ of signed permutation groups, and let $F$ be an $O(n_0)$-invariant form on $\mathcal W_{n_0}$. Then its unique $B_n$-invariant extension to $\mathcal W_n$ is $O(n)$-invariant. The first fundamental theorem spans the $O(n)$-invariants by contraction diagrams at every dimension; each diagram restricts correctly under zero-padding because every slot sits on a Weyl factor, so no free $\delta$-loop is available; and the projection isomorphism forces the unique extension to be that lift. The mechanism is what would carry a certificate from $n_0$ to every larger $n$; whether $k_B$ is small enough to reach $n=12$ is a separate, open question.

## Passage D, the context the statement's hypothesis lives in: posts F30 and F32 ([findings/fence-posts.md](../findings/fence-posts.md) lines 197-203 and 215-225)

## Post F30, Levin–Chandrasekaran's dimension-free machinery does not apply to $\{O_n\}$ at all

Their Section 1.3: *"we apply this notion only when $H$ has finite index in $G$."* Definition 2.6 builds algebraically free modules **only** from that induction, and Definition 2.7 defines the presentation degree **only** through such a module. For $G_n=O_n$ their own Example 2.8 gives $H_{n,d}=O(n-d)$, so the subgroup is $O(d)\times O(n-d)$, whose coset space is the Grassmannian $\mathrm{Gr}(d,n)$, **infinite index**.

So **no nonzero module over $\{O_n\}$ has a finite presentation degree**, while Theorems 3.4 and 3.5 both open *"fix $n_0\ge k$."* The route fails at Definition 2.7, not at any arithmetic threshold. The authors state this twice themselves: Section 7 lists extending the calculus to Lie groups such as $O_n$ as **open**, and their own $O_n$ example says the theory *"does not guarantee the existence of an $O_n$-invariant extension."*

**What a new attempt must clear:** any use of their Theorem 3.5 for an $O(n)$-equivariant object must either supply a finite-index induction that Definition 2.6 accepts, or run over a finite subgroup sequence and bridge back. *Reviewer 227.* [notes](../references/levin-chandrasekaran-dimension-free/notes.md).

## Post F32, $k_B\ge24$ bounds Proposition 2.9's *antecedent*, and does **not** put the base at $24$

The transfer mechanism is **proved**: over $\{B_n\}$, the unique $B_n$-invariant extension of an $O(n_0)$-invariant is $O(n)$-invariant at every $n\ge n_0\ge k_B$ ([run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py)). **Equivariance was never the obstruction.** The hypothesis is.

$\{\mathcal W_n\}$ is generated in degree exactly $4$ over $B_n$, and a coordinate-support argument gives generation degree $4\ell$ for $\mathrm{Sym}^\ell(\mathcal W_n)$, with presentation degree at least generation degree. The certificate is degree $6$, so $k_B\ge 4\cdot6=24>12$.

**And Theorem 2.11's calculus yields no $k_B$ here at all**: its kernel clause needs the adjoint to be a morphism, equivalent to $\mathrm{Ric}$ commuting with **truncation**, which it does not; its sums clause needs the Ricci part padding-closed, which holds only for $h\propto I$, and the round sphere is exactly that exception, so testing with $S^{n_0}$ shows the opposite of the truth.

**$k_B\ge24$ IS A GENERATION-DEGREE FACT, AND NOT A SUPPORT BOUND.** six Weyl blocks on disjoint $4$-subsets have support $24$. But the sign subgroup of $B_n$ forces every coordinate index to **even multiplicity**, so a $B_n$-invariant of degree $d$ has support $\le 2d$, never $4d$. By Burnside, $\dim(\mathrm{Sym}^d\mathcal W_n^*)^{B_n}$ is stationary from $n=2d$ in every column, $4,6,8,10,12$ for $d=1..6$, with $\dim(\mathrm{Sym}^6\mathcal W_n^*)^{B_n}=339\,423$ for all $n\ge12$, cross-checked by brute-force enumeration of $B_4$ and $B_5$ sharing no code. So the *consequent* of Proposition 2.9 is dimensionally intact at $12$: **$24$ is removed as a proved lower bound on the base, for either route.** *Reviewer 232's own prose was careful; this post's headline was not.*

**What a new attempt must clear:** a reason the extension fails at $n_0=12$ despite the $B_n$-invariant dimension being stationary there. By the stability theorem the SDP at $24$ has the same $71/184/477$ shape, so only the covariants grow, and the diagram reduction ([run_n24_via_diagrams.py](../scripts/runs/run_n24_via_diagrams.py)) says a basis found at $12$ serves at $24$, **though not by the argument it prints**: reviewer 250 finds step 1's *"spanning at 12 implies spanning at 24"* a **non sequitur**, with basis-hood coming instead from step 3's stability count ($184$ independent functions in a $184$-dimensional space). *And the transfer needs the carrier to be a **projector-free** diagram: $J_1=I_1+I_2/n$ and $J_2=I_1+I_2/24$ are independent at $n=12$ and identical at $n=24$, and trace removal supplies exactly such $1/n$ coefficients.* *Reviewer 232.*

## Passage E, the Lean file ([lean/HamiltonsCubic/Results/L64.lean](../lean/HamiltonsCubic/Results/L64.lean), whole file, 92 lines)

```lean
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L64 / post F32, the transfer mechanism, and what `k_B ≥ 24` is a fact about

[fence-posts.md](../../../findings/fence-posts.md)'s post F32 and the lemma built on it. The
representation theory stays imported; the counting is here, and it is where the audit's
correction bites.

**The two counts in the correction are in tension by a factor of two, and the resolution is a
degree rather than a bound.** The headline reads `k_B ≥ 4·6 = 24`, from six Weyl blocks on
disjoint `4`-subsets carrying support `24`. But the sign subgroup of `B_n` forces every
coordinate index to **even multiplicity**, so a `B_n`-invariant of degree `d` has support at
most `2d`, which at `d = 6` is `12`, not `24`. **A support-`24` invariant therefore needs
degree at least `12`**, and that is the quantitative form of *"the headline overstated what
was proved"*.

**Transfer moves an element, never an inequality.** The mechanism says a `B_n`-invariant
extension of an `O(n₀)`-invariant is `O(n)`-invariant, a predicate carried along a map. That
a predicate transfers does not make an order relation transfer, and `transfer_not_order`
below is a two-line counterexample, so the gap is structural rather than a missing step.
-/

namespace HamiltonsCubic.Transfer

/-! ## The generation-degree arithmetic -/

/-- Generation degree `4` for `{𝒲ₙ}` gives `4ℓ` for `Symˡ`, so the degree-`6` certificate
reads `4·6 = 24`. -/
theorem generation_degree : 4 * 6 = 24 := by decide

/-- And `24 > 12`, which is what the headline uses. -/
theorem exceeds_twelve : 12 < 24 := by decide

/-- Six Weyl blocks on disjoint `4`-subsets carry support `24`. -/
theorem six_blocks_support : 6 * 4 = 24 := by decide

/-! ## The even-multiplicity cap, and the tension -/

/-- **The sign subgroup caps support at `2d`.** At degree `6` that is `12`. -/
theorem support_cap_at_six : 2 * 6 = 12 := by decide

/-- **So the two counts disagree at degree `6`**, support `24` against a cap of `12`. -/
theorem counts_disagree : 2 * 6 < 6 * 4 := by decide

/-- **And the resolution is a degree**: a support-`24` invariant needs `2d ≥ 24`, so
`d ≥ 12`. The six-block object is degree `12` or more, not `6`, which is the quantitative
form of the correction. -/
theorem support_forces_degree (d : ℕ) (h : 24 ≤ 2 * d) : 12 ≤ d := by omega

/-- The overstatement is exactly a factor of two. -/
theorem overstatement_factor : 24 = 2 * 12 := by decide

/-! ## `k_B` grows with `d`, so a bare `k_B` names nothing -/

/-- A quantity indexed by `d` and strictly increasing in it has no single value, so a
statement quantifying over *"the* presentation degree`"` needs the index. This is that, with
nothing else in it. -/
theorem indexed_not_scalar (k : ℕ → ℕ) (hmono : ∀ d, k d < k (d + 1)) (d : ℕ) :
    k d ≠ k (d + 1) := by
  have := hmono d
  omega

/-- **Only a lower bound is known, and the family is unbounded**, so no lower bound can ever
supply a satisfiable instance: for every `N` some degree exceeds it. -/
theorem unbounded (k : ℕ → ℕ) (hmono : ∀ d, k d < k (d + 1)) : ∀ N, ∃ d, N < k d := by
  intro N
  have h : ∀ d, d ≤ k d := by
    intro d
    induction d with
    | zero => exact Nat.zero_le _
    | succ n ih => have := hmono n; omega
  exact ⟨N + 1, by have := h (N + 1); omega⟩

/-! ## Transfer moves an element, never an inequality -/

/-- **A map carrying a predicate need not carry an order relation.** Negation preserves
*"is a rational"* and reverses every inequality, so predicate transfer gives no inequality
transfer, which is why the mechanism transfers an element and never a bound. -/
theorem transfer_not_order :
    ∃ (T : ℚ → ℚ) (P : ℚ → Prop), (∀ x, P x → P (T x)) ∧ ∃ x, 0 ≤ x ∧ ¬ (0 ≤ T x) := by
  refine ⟨fun x => -x, fun _ => True, fun _ _ => trivial, 1, by norm_num, by norm_num⟩

/-- Step 1 being unconditional means the conditional statement is weaker than what holds:
`P → Q` where `Q` holds outright advertises a hypothesis that buys nothing. -/
theorem conditional_of_free {P Q : Prop} (hQ : Q) : P → Q := fun _ => hQ

end HamiltonsCubic.Transfer

```

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$; $B_n$ is the group of signed permutation matrices; zero-padding embeds $\mathcal W_{n_0}\subset\mathcal W_n$.
- **Filed source**: [references/levin-chandrasekaran-dimension-free/](../references/levin-chandrasekaran-dimension-free/), for Proposition 2.9, Definitions 2.6 and 2.7, Section 1.3 and Theorem 2.11. The first fundamental theorem of invariant theory for $O(n)$ is classical and is not filed; say where the argument needs its exact form.
- **This loop does no numerical work**; a statement supported only by a script's docstring or a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **The hypothesis $n_0\ge k_B$**: what $k_B$ is (the presentation degree of which module over which sequence), whether it is finite for the module the statement needs, and whether any instance is on file, **given Passage D**.
2. **The proof as written in Passage A**: (i) the first fundamental theorem spans the $O(n)$-invariants by contraction diagrams at every dimension; (ii) each diagram restricts correctly under zero-padding, no free $\delta$-loop being available; (iii) Proposition 2.9's projection isomorphism forces the unique $B_n$-invariant extension to be that lift. **For each step, whether it follows, what it imports, and which steps use $k_B$ at all.**
3. **Existence against uniqueness**: whether steps (i) and (ii) alone give an $O(n)$-invariant lift with no hypothesis, and what the hypothesis then adds.
4. **"FALSE for $SO(n)$"**: whether the claim about $\epsilon$-diagrams is argued, and whether the statement as canonised (Passages B, C) carries the $O(n)$ restriction.
5. **"The mechanism is what would carry a certificate from $n_0$ to every larger $n$"** (Passage C): whether an invariant's lift carries an inequality or a certificate, or only an element.
6. **Passage B's "presentation degree of the sequence $\{B_n\}$"** against Passage C's and Passage D's use of presentation degree.
7. **Passage E**: what the Lean file types, and whether it states the lemma.
8. The boundary: $n=n_0$, $n_0<k_B$, and the degree $d$ of the invariant.

