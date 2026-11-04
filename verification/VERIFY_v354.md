# Verifier v354, whether the declarations of L113.lean state and prove Lemma L113 or a component of it

Cold brief [ADJ_L113_E6.md](ADJ_L113_E6.md). No numerical work, no scripts written, no Lean build run, every value exact. The two cited lines of [findings/bounds.md](../findings/bounds.md) (508 and 526) were printed and match the brief's Passage A verbatim. Log: [agent_logs/verify-L113-v354.log](../agent_logs/verify-L113-v354.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Some declaration of L113.lean states Passage A's claim | REFUTED |
| 2 | Some declaration of L113.lean proves a component of Passage A's claim that the claim uses, at the claim's objects | REFUTED |
| 3 | moment_of_combination, constraints_convex, reachable_convex, unused_hypothesis, closure_with_content are true as stated | CONFIRMED AS ALGEBRA |
| 4 | unused_hypothesis encodes the elimination of the free moment | REFUTED (it proves weakening, the converse direction) |
| 5 | Companion file L113Statement.lean (feasible_iff, feasible_iff_theta) proves the witness component of the claim | CONFIRMED, under hypotheses H1 to H5, and outside the step as worded |

**Summary: the step FAILS, because every declaration of L113.lean is scalar or propositional scaffolding whose types never mention $g$, $\lambda$, $T$ or a moment, and the one component that is formalised lives in L113Statement.lean.**

## 0. Conventions, fixed once

- $N=\dim\Lambda^2\mathbb R^n$, eigenvalues $\lambda_1,\dots,\lambda_N$ of $W$, $\lambda_{\min}$ and $\lambda_{\max}$ their extremes.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}\ge0$, $m_j=\sum_k\lambda_k^jg_k$, $G_2=m_2$.
- Pinned moments (Passage B): $m_0=4(n-1)\lVert W\rVert^2$, $m_1=-4P(W)$. On the unit sphere with $\theta=P(W)$ these read $m_0=4(n-1)$, $m_1=-4\theta$.
- "The step" means the sentence of the brief: the declarations of L113.lean state and prove Passage A's claim, or a component of it that the claim uses.
- "L113.lean" means the first code block of Passage F. "L113Statement.lean" means the second.

## 1. Hypothesis inventory

- **H1 (relaxation).** "Moment inequalities built from positivity and support" are inequalities valid for every vector $g\in\mathbb R^N_{\ge0}$ whose measure $\sum_kg_k\delta_{\lambda_k}$ carries the pinned $m_0,m_1$. The structure of $g$ as a contraction of $T$ is forgotten.
- **H2 (normalisation).** $\lVert W\rVert=1$, so $m_0=4(n-1)$, and $n\ge2$, so $m_0>0$.
- **H3 (trace).** $\mathop{\mathrm{tr}}W=0$ on $\Lambda^2$, giving $\lambda_{\min}\le0\le\lambda_{\max}$.
- **H4 (sign).** $\theta\ge0$, the branch on which the upper feasibility inequality is automatic.
- **H5 (no cap).** The inequality family excludes the per-coordinate cap of Lemma L109, $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$, which is built from $T\ge0$ and the row marginal rather than from positivity of $g$ and support.

H1 to H5 are needed only for claim 5. Claims 1 to 4 need none of them.

## 2. What Passage A claims, and its components

Passage A asserts that any pair of moment inequalities built from $g\ge0$ and the support of its measure, with $G_2$ entering in any way, returns after elimination of $G_2$ only a pinned conclusion. The strongest precise reading under H1 is the projection statement:

$$\{(m_0,m_1): \exists g\ge0 \text{ with these moments}\}=\{(c,s): c\lambda_{\min}\le s\le c\lambda_{\max}\},$$

together with the logical bridge that an inequality valid at every feasible $g$ holds at every point of the right-hand side, because each such point has a witness $g$. Under H2 to H4 the right-hand side at $(4(n-1),-4\theta)$ is exactly $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, Lemma L107. So the components the claim uses are:

- (K1) the objects: a nonnegative vector indexed by the eigenbasis, its moments against $\lambda$, and their linearity in $g$ (and in $T$).
- (K2) necessity: feasibility forces $c\lambda_{\min}\le s\le c\lambda_{\max}$.
- (K3) sufficiency: every such $(c,s)$ has a witness, which is what makes elimination return nothing stronger.
- (K4) the specialisation of K2 and K3 to $(4(n-1),-4\theta)$, giving L107.

A convexity fact (a linear map sends convex combinations to convex combinations, so the reachable moment set is convex and the range of $G_2$ at fixed pinned data is an interval) is a natural auxiliary component of a projection argument, and §3 tests it as K1'.

## 3. The five declarations of L113.lean, one at a time

### 3.1 moment_of_combination

Its type is `(m : ℝ → ℝ) (hlin : ∀ a b x y, m (a*x+b*y) = a*m x + b*m y) (α T₁ T₂ : ℝ) : m (α*T₁+(1-α)*T₂) = α*m T₁ + (1-α)*m T₂`, proved by `hlin α (1 - α) T₁ T₂`. The conclusion is the hypothesis instantiated at $a=\alpha$, $b=1-\alpha$. True as algebra.

Against K1': the carrier is $\mathbb R$, and $T_1,T_2$ are real numbers. The moment map of the claim is $T\mapsto m_j(T)$ on `Fin N → Fin N → Fin N → ℝ`, or $g\mapsto m_j$ on `Fin N → ℝ`. A function of that type cannot be passed as `m : ℝ → ℝ`, so the declaration cannot be applied at the claim's objects. Reducing the vector case to it along a line also fails: the natural scalar restriction $t\mapsto m(tT_1+(1-t)T_2)$ is affine, and `hlin` at $a=b=0$ forces $m(0)=0$, which the restriction violates whenever $m(T_2)\ne0$. Moreover `hlin` on $\mathbb R$ forces $m(x)=x\,m(1)$, so the declaration is the statement that multiplication by a constant distributes, and carries no moment content.

### 3.2 constraints_convex

Hypotheses $0\le T_1$, $0\le T_2$, $0\le\alpha\le1$, $T_1=c$, $T_2=c$. Conclusion $0\le\alpha T_1+(1-\alpha)T_2$ and $\alpha T_1+(1-\alpha)T_2=c$. True as algebra: with $T_1=T_2=c$ the combination equals $c$ identically, and nonnegativity is $\alpha T_1+(1-\alpha)T_2\ge0$ from four nonnegative factors.

Against K1': the hypotheses `he₁` and `he₂` force $T_1=T_2$, so the "convex set" tested is a single point of $\mathbb R$. The claim's constraint set is $\{T\ge0\}$ cut by $3N$ linear equalities (A), (B), (C) in $\mathbb R^{N^3}$, where two feasible points are generally distinct. The declaration states convexity of a singleton and cannot be instantiated at a tensor.

### 3.3 reachable_convex

Same `m : ℝ → ℝ` and `hlin`, with $m(T_1)=v_1$, $m(T_2)=v_2$, concluding $m(\alpha T_1+(1-\alpha)T_2)=\alpha v_1+(1-\alpha)v_2$. The proof rewrites by 3.1 and the two equations. The hypotheses `hα` and `hα'` are unused. True as algebra, and it inherits every defect of 3.1: the carrier is $\mathbb R$, so it says nothing about the set of moment values reachable by tensors or by vectors $g$.

### 3.4 unused_hypothesis

Type `{A B C Concl : Prop} (h : A → B → Concl) : A → B → C → Concl`. True, it is propositional weakening.

This is the declaration that looks most like the claim, with $C$ read as the hypothesis carrying $G_2$. So its direction must be checked exactly. The claim needs elimination: a conclusion obtained from $A$, $B$ and $C$ (with $G_2$ free and then eliminated) is already a pinned one, available from the pinned data. In propositional form that is the passage from $A\to B\to C\to\mathrm{Concl}$ to something without $C$. The declaration proves the converse passage, from a derivation without $C$ to one with $C$. The needed direction is false as a propositional schema: take $A=B=\mathrm{True}$, $C=\mathrm{False}$, $\mathrm{Concl}=\mathrm{False}$. Then $A\to B\to C\to\mathrm{Concl}$ holds and $A\to B\to\mathrm{Concl}$ fails. So the declaration states the trivial direction, and the direction the lemma depends on requires the witness construction K3, which propositional logic cannot supply.

### 3.5 closure_with_content

Type `∃ S : Set ℕ, 0 ∈ S ∧ 1 ∉ S`, witnessed by $\{0\}$. True. It mentions no spectrum, moment, measure, or class, and its "closure" is not defined. It states no component of the claim.

### 3.6 Collective check

The five types mention between them only `ℝ`, `ℕ`, `Set ℕ` and propositional variables. None mentions `Fin N`, an eigenvalue vector, a nonnegative distribution, a moment $m_j$, $G_2$, a support condition, or the constant $4(n-1)$. Hence none can state K2, K3 or K4 (they need an existential over nonnegative vectors indexed by the eigenbasis), and none states K1 at the claim's objects (§3.1 to §3.3). Claims 1 and 2 are REFUTED.

## 4. Arguing the opposite

**Reading (i): "state a component" allows a toy model.** One may hold that 3.1 and 3.3 formalise "linear maps preserve convex combinations", which the claim uses. The claim's proof in §2 does not need that fact: K2 is a termwise inequality $\lambda_{\min}g_k\le\lambda_kg_k\le\lambda_{\max}g_k$ summed, and K3 is an explicit two-atom witness, and neither step invokes convexity of the reachable set. Where convexity would be invoked, it is at a vector space of dimension $N$ or $N^3$, and §3.1 shows the scalar declaration cannot be applied there. So even the charitable reading gives a fact that is neither used by the claim nor usable at its objects.

**Reading (ii): "L113.lean" names Passage F as a whole.** Passage F's heading lists two files, and the step names one. If the author meant both, the verdict changes for the component clause, and §5 settles that reading. The words of the step name the file L113.lean, and the brief distinguishes it from L113Statement.lean by name, so this reading is recorded as a separate claim (claim 5) and the step's verdict is given on the file it names.

**Reading (iii): the claim is so weak that trivial declarations suffice.** Under the loose meaning of "pinned" (any condition on spectrum and $\theta$), eliminating $g$ from any system whose data are functions of spectrum and $\theta$ trivially yields such a condition. Even this tautological version needs an existential over $g$ indexed by the eigenbasis to be stated, which none of the five declarations has. The substantive version (the conclusion is no stronger than L107) needs K3.

## 5. The companion file, L113Statement.lean

- **feasible_iff.** `Feasible lam c s` is $\exists g\ge0$, $\sum g_k=c$, $\sum\lambda_kg_k=s$. For $c>0$ and nonempty index set it is equivalent to $c\lambda_{\min}\le s\le c\lambda_{\max}$. Necessity is K2 by termwise bounds. Sufficiency is K3: if $\lambda_{\min}=\lambda_{\max}$ then $s=c\lambda_{\min}$ and a one-atom $g$ works. Otherwise $t=(s-c\lambda_{\min})/(\lambda_{\max}-\lambda_{\min})\in[0,c]$, and $g=t\,e_j+(c-t)\,e_i$ at an argmax $j$ and argmin $i$ gives $\sum g=c$ and $\sum\lambda g=\lambda_{\max}t+\lambda_{\min}(c-t)=c\lambda_{\min}+t(\lambda_{\max}-\lambda_{\min})=s$. CONFIRMED as mathematics.
- **feasible_iff_theta.** At $c=4(n-1)$, $s=-4\theta$, with $n\ge2$, $\theta\ge0$, $\lambda_{\min}\le0\le\lambda_{\max}$: the lower inequality $4(n-1)\lambda_{\min}\le-4\theta$ is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, and the upper $-4\theta\le4(n-1)\lambda_{\max}$ holds because both sides' signs are fixed by H3 and H4. This is K4, recovering L107. CONFIRMED as mathematics.
- **moment, moment_add, moment_smul.** Additivity and homogeneity of $m_j(T)=\sum_{k,a,b}\lambda_k^j(\lambda_a-\lambda_b)^2T_{kab}$ in $T$, which is K1 at the claim's objects.

This file therefore proves the witness component on which Passage A's "cannot leave the pinned class" rests, under H1 to H5. Each hypothesis is load-bearing:

- H1: the realised $g$ comes from a tensor, and the two-atom witness need not be of the form $\sum(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$ for a realisable $T$. The claim restricts itself to positivity and support, so this is the claim's own scope, and the lemma says nothing about inequalities using more of $T$.
- H2 and H4: with $\theta<0$ the upper inequality $-\theta\le(n-1)\lambda_{\max}$ becomes a second nontrivial pinned condition, which `feasible_iff_theta` does not state (feasible_iff still covers it).
- H3: needed for the absolute value in `feasible_iff_theta`.
- H5: the witness puts mass $c-t$ or $t$ on one coordinate, up to $4(n-1)$. Lemma L109 caps a single $g_\gamma$ at $2(n-2)(\lambda_{\max}-\lambda_{\min})^2$, so when that cap is below the atom mass the witness is excluded and K3 as formalised no longer shows that cap-using inequalities are no stronger than L107.
- The file does not quantify over "pairs of moment inequalities" and has no $m_2$ variable. The passage from K3 to "elimination returns nothing stronger" is the one-line bridge of §2, which lives outside Lean.

The `N` and `n` of `feasible_iff_theta` are independent, a harmless generalisation of $N=n(n-1)/2$.

## 6. Verdict

**FAILS.** The step says the declarations of L113.lean state and prove Lemma L113 or a component of it. The five declarations of that file are true but are scalar identities over `ℝ`, a singleton convexity check, propositional weakening in the direction opposite to elimination, and an unrelated existence statement over `Set ℕ`, and none can be instantiated at $g$, $T$ or the moments $m_j$. The component the lemma actually uses (feasibility of the pinned first two moments is exactly $c\lambda_{\min}\le s\le c\lambda_{\max}$, with a two-atom witness, specialising to L107) is stated and proved in L113Statement.lean, and a reading that counts that file would be VALID for the component clause only, under H1 (positivity and support alone), H2 (unit norm, $n\ge2$), H3 ($\mathop{\mathrm{tr}}W=0$), H4 ($\theta\ge0$) and H5 (no L109 cap), with the elimination bridge supplied outside Lean.
