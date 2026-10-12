# Verifier v353, whether the L113 Lean declarations state and prove Lemma L113 or a component it uses (step E6)

Cold brief ([ADJ_L113_E6.md](ADJ_L113_E6.md)), no numerical work, no scripts written, no Lean build run, every value exact. Log: [agent_logs/verify-L113-v353.log](../agent_logs/verify-L113-v353.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The five declarations of the file [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) state Passage A's claim | REFUTED |
| 2 | The five declarations of the file [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) state a component of the claim about $g$, $T$ or the spectrum | REFUTED AS STATED |
| 3 | feasible_iff in [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) characterises exactly the $(m_0,m_1)$ shadow of positivity plus support | CONFIRMED |
| 4 | feasible_iff_theta identifies that shadow, at the pinned values, with Lemma L107 | CONFIRMED |
| 5 | moment_add and moment_smul give linearity of $m_j$ in $T$ | CONFIRMED AS ALGEBRA |
| 6 | Some declaration states the full claim, the universal statement over moment inequalities | REFUTED |
| 7 | The full claim, read as positivity plus support, follows from feasible_iff by a one-line witness argument | CONFIRMED |
| 8 | Step E6, read over the whole of Passage F, via the "component" disjunct | VALID |

**Summary: the step is VALID only on the reading that "L113.lean" names the L113 formalisation in Passage F (both files), where feasible_iff and feasible_iff_theta are an exact, correctly proved component of the claim, and it FAILS on the literal file-scoped reading, where every declaration is a scalar or propositional triviality.**

## 0. Conventions, fixed once

- $\{\lambda_k\}_{k=1}^N$ is the spectrum of $W$ on $\Lambda^2$, $N=n(n-1)/2$, with $\lambda_{\min}=\min_k\lambda_k$ and $\lambda_{\max}=\max_k\lambda_k$.
- $g\in\mathbb R^N$ is the $g$-distribution, read as the measure $\mu_g=\sum_kg_k\delta_{\lambda_k}$, and $m_j(g)=\sum_k\lambda_k^jg_k$.
- On the unit sphere at a critical point, Passage B gives the pinned values $m_0=c:=4(n-1)$ and $m_1=s:=-4\theta$, since $\lVert W\rVert=1$ and $P(W)=\theta$. The free moment is $G_2=m_2$, with all higher moments also free.
- "Positivity plus support" means the cone $K=\{g\in\mathbb R^N: g_k\ge0\ \forall k\}$, the support being fixed by indexing $g$ over the spectrum.
- Lean's Feasible lam c s is the statement $\exists g\in K,\ m_0(g)=c,\ m_1(g)=s$.

## 1. Hypothesis inventory

- **H_scope.** "The declarations of L113.lean" denotes the declarations of Passage F as a whole, that is [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) together with [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean). The step's words name one file, Passage F's heading names both, so this is a hypothesis the author may have meant and did not write. Section 2 shows the step fails without it.
- **H_build.** The two files compile as quoted. Checked by reading only. Every mathematical step of each proof is correct (sections 3 and 4). The one tactic call whose success cannot be settled by reading is the positivity call on $(\text{if }k=j\text{ then }t\text{ else }0)+(\text{if }k=i\text{ then }c-t\text{ else }0)$, whose summand $c-t$ is nonnegative from the local fact htc, $t\le c$, rather than from a hypothesis of the syntactic form $0\le c-t$. If positivity does not close it, the repair is a one-line sub_nonneg rewrite and the mathematics is unchanged.
- **H_pos.** The claim's "moment inequalities built from" positivity and support are inequalities valid on all of $K$. This is Passage A's wording. If the claim is widened to include realizability facts such as the cap of Lemma L109 (Passage E), the relevant shadow is a box-constrained one that feasible_iff does not describe (section 6).
- **H_regime.** For feasible_iff_theta only: $n\ge2$, $\theta\ge0$, $\lambda_{\min}\le0\le\lambda_{\max}$. The last holds for any traceless $W$ (the Weyl operator is traceless on $\Lambda^2$), and $\theta<0$ makes Lemma L107 trivial.

## 2. The file L113.lean on its own

The file holds five declarations. None mentions a spectrum, a tensor $T$, a distribution $g$, or a moment of one.

- **moment_of_combination.** For $m:\mathbb R\to\mathbb R$ with the hypothesis hlin, it concludes $m(\alpha T_1+(1-\alpha)T_2)=\alpha m(T_1)+(1-\alpha)m(T_2)$, and the proof is hlin applied to $(\alpha,1-\alpha,T_1,T_2)$. The conclusion is an instance of the hypothesis. Moreover hlin on $\mathbb R\to\mathbb R$ forces $m(x)=x\,m(1)$, so the "moment" is a scalar multiple of a real number. The claim's moments are functionals on tensors $T\in\mathbb R^{N\times N\times N}$, and a statement about real scalars is neither that statement nor a special case from which it follows.
- **constraints_convex.** The hypotheses he₁ and he₂ say $T_1=c$ and $T_2=c$, so the convex combination is the point $c$ itself. The claim's constraint set is the polytope cut out by (A), (B), (C) and $T\ge0$ in $\mathbb R^{N^3}$, which is not a point. The theorem records that a singleton is convex.
- **reachable_convex.** The same scalar linear map, with the conclusion again obtained by rewriting with the hypotheses.
- **unused_hypothesis.** The propositional tautology $(A\to B\to C')\to(A\to B\to C\to C')$. At most it is a picture of "the free datum is not used", with no content about $g$.
- **closure_with_content.** $\exists S\subseteq\mathbb N,\ 0\in S\wedge1\notin S$, witnessed by $\{0\}$. No connection to the lemma.

Arguing the opposite: the claim's argument plausibly uses "moments are linear in $T$" and "the feasible set is convex". The first three declarations are the one-dimensional shadows of those facts. But a one-dimensional shadow does not imply the $N^3$-dimensional statement, and constraints_convex does not even carry a nontrivial constraint set. The tensor-level linearity the claim would use is moment_add and moment_smul, which live in the other file. **So on the literal reading, the file named L113.lean states neither the claim nor a component it uses, and the step FAILS there (claims 1 and 2).**

## 3. feasible_iff, the exact shadow of positivity plus support

**Statement.** For $N\ge1$ and $c>0$: $\exists g\in K$ with $m_0(g)=c$ and $m_1(g)=s$ if and only if $c\lambda_{\min}\le s\le c\lambda_{\max}$.

**Forward.** From $\lambda_{\min}\le\lambda_k\le\lambda_{\max}$ and $g_k\ge0$, summing $\lambda_{\min}g_k\le\lambda_kg_k\le\lambda_{\max}g_k$ gives $c\lambda_{\min}\le s\le c\lambda_{\max}$. This is the proof's two calc chains.

**Backward, degenerate case** $\lambda_{\min}=\lambda_{\max}$. Every $\lambda_k$ equals $\lambda_{\min}$, the two inequalities force $s=c\lambda_{\min}$, and $g=c\,e_i$ gives $m_0=c$ and $m_1=\lambda_{\min}c=s$.

**Backward, generic case** $\lambda_{\min}<\lambda_{\max}$, attained at $i\ne j$. Put $t=(s-c\lambda_{\min})/(\lambda_{\max}-\lambda_{\min})$. Then $t\ge0$ from the lower inequality, and $t\le c$ is equivalent to $s-c\lambda_{\min}\le c(\lambda_{\max}-\lambda_{\min})$, which is $s\le c\lambda_{\max}$. The two-atom vector $g=t\,e_j+(c-t)\,e_i$ lies in $K$, has $m_0=c$, and has $m_1=\lambda_{\max}t+\lambda_{\min}(c-t)=c\lambda_{\min}+t(\lambda_{\max}-\lambda_{\min})=s$. The proof's hstep case split handles $i\ne j$ correctly (the case $k=j$ and $k=i$ is absurd by hij).

**Conclusion.** The set of pinned-moment pairs compatible with positivity and support is exactly the interval condition. Claim 3 CONFIRMED.

## 4. feasible_iff_theta, the shadow at the pinned values is Lemma L107

Substituting $c=4(n-1)>0$ (from $n\ge2$) and $s=-4\theta$, and $\lvert\lambda_{\min}\rvert=-\lambda_{\min}$ from $\lambda_{\min}\le0$:

- the lower inequality $4(n-1)\lambda_{\min}\le-4\theta$ is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$,
- the upper inequality $-4\theta\le4(n-1)\lambda_{\max}$ holds automatically, since $\theta\ge0$, $n-1\ge1$ and $\lambda_{\max}\ge0$ give $-4\theta\le0\le4(n-1)\lambda_{\max}$.

So Feasible at the pinned values is equivalent to $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, which is Lemma L107 (Passage C). The nlinarith calls need only the product of $n-2\ge0$ with $\lambda_{\max}\ge0$, which is within its product search. Claim 4 CONFIRMED under H_regime.

## 5. The moment functional and its linearity

moment lam j T is $\sum_k\sum_a\sum_b\lambda_k^j(\lambda_a-\lambda_b)^2T_{kab}=\sum_k\lambda_k^jg_k=m_j$, matching Passage B's $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$. moment_add and moment_smul are termwise distributivity. They are the tensor-level form of the linearity the scalar lemmas of section 2 gesture at. Nothing in the file connects moment to Feasible, so they stand as separate facts. Claim 5 CONFIRMED AS ALGEBRA.

The closing example, $g=(2,2)$ on spectrum $(1,-1)$ with $m_0=4$ and $m_1=2-2=0$, is a correct instance.

## 6. What the claim needs, and how much of it the Lean carries

**Strongest reading of Passage A.** Let $\Phi(m_0,m_1,m_2,\dots,m_J)$ be any conjunction of inequalities valid for every $g\in K$ (H_pos), however $m_2,\dots,m_J$ enter. Eliminating the free moments means passing to $\exists m_2,\dots,m_J\ \Phi(c,s,m_2,\dots,m_J)$. The claim says this conclusion is pinned. In the sharp sense it says the conclusion is implied by, and so no stronger than, a condition on the spectrum and $\theta$ alone.

**Proof from feasible_iff.** Suppose $c\lambda_{\min}\le s\le c\lambda_{\max}$. By feasible_iff there is $g^\ast\in K$ with $m_0(g^\ast)=c$ and $m_1(g^\ast)=s$. Since $\Phi$ is valid on $K$, $\Phi(c,s,m_2(g^\ast),\dots,m_J(g^\ast))$ holds, so the eliminated statement holds with witnesses $m_j(g^\ast)$. Hence every such conclusion is implied by the interval condition, which by section 4 is Lemma L107 in the relevant regime. Claim 7 CONFIRMED.

**Illustration that the bound is attained by a pair.** Cauchy–Schwarz gives $m_2\ge m_1^2/m_0$, and $(\lambda_k-\lambda_{\min})(\lambda_{\max}-\lambda_k)\ge0$ gives $m_2\le(\lambda_{\max}+\lambda_{\min})m_1-\lambda_{\max}\lambda_{\min}m_0$. Eliminating $m_2$ and multiplying by $m_0>0$ yields $(m_1-\lambda_{\min}m_0)(m_1-\lambda_{\max}m_0)\le0$, which is exactly the interval condition. So "a pair of moment inequalities, free moment eliminated" returns precisely feasible_iff's condition, as the claim's wording suggests.

**What the Lean does not carry.**

- No declaration quantifies over moment inequalities $\Phi$, so the universal sentence of Passage A is not stated. The one-line witness argument above is absent. Claim 6 REFUTED.
- No declaration links Feasible to realised tensors, that is, none proves $m_0(g(T))=4(n-1)\lVert W\rVert^2$ or $m_1(g(T))=-4P(W)$ from (A) and (B). The pinned values enter feasible_iff_theta as parameters. This is consistent with the claim, which treats them as given.
- Under a widened reading that adds realizability facts such as Lemma L109's cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$, the constraint set becomes $K\cap\{g_k\le U\}$ and its $(m_0,m_1)$ shadow is in general strictly smaller than the interval (for example, $s=c\lambda_{\max}$ requires $c$ units of mass on the eigenvalue $\lambda_{\max}$, impossible when $cU^{-1}$ exceeds its multiplicity). The conclusion is still a function of the spectrum, so the claim's pinned-class statement survives, but feasible_iff is then a component of the uncapped case only. This is why H_pos is named.

## 7. Verdict for step E6

**VALID**, via the disjunct "a component of it that the claim uses", on the hypotheses:

- **H_scope**, "L113.lean" read as the L113 formalisation of Passage F, both files,
- **H_build**, the files compile as quoted, with the positivity call on $c-t$ the one step not settled by reading,
- **H_pos**, the claim's moment inequalities are those valid on the positivity-plus-support cone, as Passage A words it,
- **H_regime**, $n\ge2$, $\theta\ge0$, $\lambda_{\min}\le0\le\lambda_{\max}$, for the identification with Lemma L107.

On that reading, feasible_iff is the exact $(m_0,m_1)$ shadow of positivity plus support, from which the claim follows in one line, and feasible_iff_theta identifies the shadow with Lemma L107. The step's first disjunct, that the declarations state and prove the claim itself, is refuted.

**Without H_scope the step FAILS.** Each of the five declarations of the file named L113.lean is a statement about real scalars or bare propositions (section 2), constraints_convex pins its "constraint set" to the single point $c$ by its hypotheses he₁ and he₂, and none states a fact about $g$, $T$, the spectrum or a moment.
