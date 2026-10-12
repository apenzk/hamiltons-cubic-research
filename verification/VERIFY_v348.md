# Verifier v348, Lemma L113 step E1: moment inequalities from positivity and support return only pinned conclusions

Cold brief ([ADJ_L113_E1.md](ADJ_L113_E1.md)), read in full. No numerical work was done and no scripts were written. Every value below is exact. Log: [agent_logs/verify-L113-v348.log](../agent_logs/verify-L113-v348.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | A conclusion from inequalities built from $g\ge0$ and support in the spectrum, with every free moment eliminated, is a statement in pinned quantities only | CONFIRMED (definitional, needs H1 to H4) |
| 2 | Sharp reading: every such conclusion is implied by $\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0$, which at a unit critical point is the two-sided bound $-(n-1)\lambda_{\max}\le\theta\le(n-1)\lvert\lambda_{\min}\rvert$, so nothing sharper than L107 comes out | CONFIRMED |
| 3 | The pair (Cauchy-Schwarz lower bound on $G_2$, support upper bound on $G_2$) eliminates $G_2$ to exactly L107 | CONFIRMED AS ALGEBRA |
| 4 | "Positivity of $g$ and the support of its measure are consequences of the spectrum alone" | REFUTED AS STATED (positivity comes from $g_k$ being a squared norm. What is spectral is the atom locations and the coefficients, which is all the argument uses) |
| 5 | "Hence moment analysis of the $g$-distribution cannot leave the pinned class", with no restriction on the inputs | CONFIRMED only for inputs whose coefficients are functions of $(\lambda,\theta,n)$. The sharp form (claim 2) holds only for positivity and support |
| 6 | The Lean file L113.lean proves the step | REFUTED (its declarations never mention $g$, a spectrum or a moment. The projection is proved by feasible_iff and feasible_iff_theta in L113Statement.lean) |

**Summary: the step is VALID under the reading "every free-moment-free consequence of $g\ge0$, support in the spectrum and the two pinned moments is implied by the $(m_0,m_1)$ feasibility interval, that is by L107", which is a genuine proposition proved by projection plus the feasible_iff characterisation. Read literally, the sentence is definitional.**

## 0. Conventions, fixed once

- $W\in\mathcal W_n$, $\lVert W\rVert=1$, critical: $Q(W)=\theta W$, $\theta=P(W)$. Eigenvalues $\lambda_1,\dots,\lambda_N$ of $W$ on $\Lambda^2$, $N=\binom n2$, with $a:=\lambda_{\min}$ and $b:=\lambda_{\max}$.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, the measure $\mu=\sum_kg_k\,\delta_{\lambda_k}$, and moments $m_j=\sum_k\lambda_k^jg_k$, so $G_2=m_2$.
- Pinned moments (Passage B): $m_0=4(n-1)=:c$ and $m_1=-4P(W)=-4\theta=:s$.
- "Pinned quantity" means a function of $(\lambda,\theta,n)$, following Passage D ("everything a critical point's spectrum and $\theta$ already determine").
- $\mathcal R:=\{(m_0,m_1,m_2,\dots)\text{ of some }h\in\mathbb R_{\ge0}^N\}$, the moment vectors of all nonnegative weightings on the fixed atoms $\lambda_1,\dots,\lambda_N$. $\pi$ denotes projection onto $(m_0,m_1)$.
- "Built from positivity and support" means: an inequality $\Phi(m_0,m_1,m_2,\dots)\ge0$ whose coefficients are functions of $(\lambda,n)$ and which holds at every point of $\mathcal R$.

## 1. Hypothesis inventory

- **H1 (validity class).** Each inequality used holds for every $h\ge0$ on the atoms $\lambda_k$, with coefficients depending only on $(\lambda,n)$. Unstated. It is what "built from positivity of $g$ and the support of its measure" must mean for the sentence to be a claim at all.
- **H2 (all free moments eliminated).** The text says "the free moment", singular. If the pair involves $m_3$ or $m_4$ (for instance a $3\times3$ Hankel minor), eliminating only $G_2$ leaves a free quantity. The reading needs every $m_j$ with $j\ge2$ eliminated. Unstated.
- **H3 (pinned moments).** $m_0=4(n-1)\lVert W\rVert^2$ and $m_1=-4P(W)$ from (A), (B) and the cubic identity (Passage B). Given.
- **H4 (critical point, or $\theta$ as datum).** $P(W)$ is a function of the spectrum only through $\theta=P(W)$ at a unit critical point. Off critical points "pinned" must be read as "function of $(\lambda,P(W),\lVert W\rVert)$". Stated in Passage D's definition.
- **H5 (for the sharp reading).** $c>0$, which needs $n\ge2$ and $W\ne0$, and $N\ge1$. The specialisation to $\theta$ also uses $a\le0\le b$, true because a Weyl operator on $\Lambda^2$ is traceless. Needed only to rewrite the interval as L107.

## 2. The literal sentence is definitional

Under H1 and H2 a conclusion obtained by eliminating every $m_j$, $j\ge2$, from inequalities with coefficients in $(\lambda,n)$ is a relation among $m_0,m_1$ and $(\lambda,n)$. By H3 and H4, $m_0$ and $m_1$ are functions of $(\theta,n)$. So the conclusion is a relation in $(\lambda,\theta,n)$, a pinned conclusion by the definition in §0. Nothing beyond the meaning of the words is used, so as written the clause "can only return a pinned conclusion" is true by construction and carries no content of its own.

The argument fails exactly when H1 or H2 is dropped. An input with a non-spectral coefficient, or a residual $m_3$, gives a conclusion that still involves a free quantity. Neither contradicts the step, since the step names its inputs.

## 3. The sharp reading, which is the proposition the lemma label needs

**Claim.** Let $\mathcal C$ be any family of inequalities satisfying H1, and let $\psi(m_0,m_1)$ be any statement derived from $\mathcal C$ in which no $m_j$, $j\ge2$, occurs. Then $\psi(c,s)$ holds whenever $ac\le s\le bc$.

**Proof.** Let $\mathcal S=\{x:\Phi(x)\ge0\ \forall\Phi\in\mathcal C\}$. By H1, $\mathcal R\subseteq\mathcal S$. A statement derived from $\mathcal C$ holds on $\mathcal S$. A statement in $(m_0,m_1)$ only that holds on $\mathcal S$ holds on $\pi(\mathcal S)\supseteq\pi(\mathcal R)$. So $\psi$ holds on $\pi(\mathcal R)$. It remains to identify $\pi(\mathcal R)\cap\{m_0=c\}$, and this is the Feasible predicate of Passage F:

- If $h\ge0$, $\sum h_k=c$, $\sum\lambda_kh_k=s$, then $ac=\sum ah_k\le\sum\lambda_kh_k=s\le\sum bh_k=bc$.
- Conversely, if $ac\le s\le bc$ and $a<b$, put $t=(s-ac)/(b-a)\in[0,c]$ and $h=t\,e_{j}+(c-t)\,e_{i}$ with $\lambda_j=b$, $\lambda_i=a$. Then $\sum h=c$ and $\sum\lambda h=bt+a(c-t)=ac+(b-a)t=s$. If $a=b$ then $s=ac$ and $h=c\,e_i$ works.

This is exactly feasible_iff in L113Statement.lean (Passage F), with the same two-atom witness. With $c=4(n-1)$ and $s=-4\theta$ the interval reads
$$-(n-1)\,b\ \le\ \theta\ \le\ (n-1)\lvert a\rvert ,$$
whose upper side is L107 (Passage C) and whose lower side is automatic when $\theta\ge0$ (the case feasible_iff_theta treats). $\blacksquare$

**Consequence.** The strongest $G_2$-free conclusion that positivity and support can return is the feasibility interval itself, and every other one is implied by it. The claim is best possible: §4 exhibits a single pair that attains it.

## 4. An exact pair that returns L107

Two inequalities satisfying H1, with $m_0>0$:

- Cauchy-Schwarz with weights $h$: $m_0m_2\ge m_1^2$.
- Support in $[a,b]$: $\sum_k(\lambda_k-a)(b-\lambda_k)h_k\ge0$, that is $m_2\le(a+b)m_1-ab\,m_0$.

Eliminating $m_2$: $m_1^2\le(a+b)m_0m_1-ab\,m_0^2$, which factors as $(m_1-a\,m_0)(m_1-b\,m_0)\le0$, that is $a\,m_0\le m_1\le b\,m_0$. Substituting H3 gives $4(n-1)a\le-4\theta$, which is $\theta\le(n-1)\lvert a\rvert$. This is L107 exactly, so the pair meets the bound of §3 and nothing stronger is available from this class.

## 5. Arguing the opposite

- **Could a nonlinear or higher-degree use of $G_2$ beat the interval?** No. The proof of §3 uses only that each input holds on $\mathcal R$. Linearity in $m_2$ is never used, and "however the free moment enters" is covered.
- **Could the support constraint say more than "atoms at the $\lambda_k$"?** Support of $\mu$ is a subset of $\{\lambda_k\}$ and $\mathcal R$ already allows every nonnegative weighting of those atoms, zeros included. Multiplicities add atoms at the same location and change nothing in $\pi(\mathcal R)$.
- **Could other true constraints on $g$ break "cannot leave the pinned class"?** The per-coordinate cap of L109 (Passage E), $g_k\le2(n-2)(b-a)^2$, is a valid constraint on the actual $g$ that is outside H1: it comes from $T\ge0$ and relation (A), and fails for general $h\ge0$. Adding it replaces $\pi(\mathcal R)$ by the capped feasibility set, which can be strictly smaller (for instance when the multiplicity of $a$ times the cap is below the mass the lower endpoint needs). So claim 2 fails for capped analysis. The conclusion is still pinned, because the cap's coefficients are functions of $(\lambda,n)$, so the literal claim 1 survives. The bolded "hence" is therefore correct only with the scope "positivity and support" carried over from the sentence before, and in the literal sense for any spectral-coefficient input.
- **Does the withdrawn post F42 undermine the step?** No. Passage D withdraws F42's claim that pinned data cannot close the conjecture. The proposition of §3 uses nothing from F42. It does mean the lemma's surrounding moral ("the single open door") is an obstruction only to routes that stay inside $\{g\ge0,\ \mathrm{supp}\subseteq\mathrm{spec},\ m_0,m_1\}$, and says nothing about the strength of the full pinned $T$-system, which Passage D reports is much stronger.
- **Positivity "a consequence of the spectrum alone" (claim 4).** $g_k\ge0$ holds because $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2$, at every $W$. The spectrum does not imply it. The slip is harmless: §3 uses positivity as an input and the spectrum only for atom locations and coefficients.
- **The Lean record (claim 6).** In L113.lean, moment_of_combination and reachable_convex are linearity of an abstract $m:\mathbb R\to\mathbb R$, constraints_convex is a convex combination of two equal scalars, unused_hypothesis is weakening, and closure_with_content is the existence of a set containing 0 and not 1. None mentions $g$, a spectrum or elimination. L113Statement.lean's feasible_iff and feasible_iff_theta prove the projection used in §3. The elimination step of §3 (from $\mathcal R\subseteq\mathcal S$ to $\pi$) is not formalised there, but it is one line of set inclusion.

## 6. Verdict

**VALID**, under the reading: every conclusion obtained from inequalities that hold for all nonnegative weightings of the atoms $\lambda_k$ (H1), with every free moment $m_j$, $j\ge2$, eliminated (H2), given the pinned moments $m_0=4(n-1)$ and $m_1=-4\theta$ (H3) at a unit critical point (H4), is implied by $4(n-1)\lambda_{\min}\le-4\theta\le4(n-1)\lambda_{\max}$, whose nontrivial side is L107, and one pair (§4) attains it.

- As written, "can only return a pinned conclusion" is definitional (§2). It becomes a proposition with content only in the sharp form of §3, which is proved by projection plus feasible_iff.
- H1 and H2 are unstated and required. The singular "the free moment" must be read as all free moments.
- The bolded extension "moment analysis of the $g$-distribution cannot leave the pinned class" holds in the sharp sense only with the positivity-and-support scope. Constraints such as the L109 cap keep conclusions pinned but can move them past L107.
- The justification "consequences of the spectrum alone" misattributes positivity, without effect on the argument.
- The label is supported by the reasoning above and by L113Statement.lean, and by nothing in L113.lean.
