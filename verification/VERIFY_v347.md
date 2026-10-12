# Verifier v347, Lemma L113 step E1: elimination of the free moment from positivity-and-support inequalities

**Cold brief ([ADJ_L113_E1.md](ADJ_L113_E1.md)). No numerical work was done and no scripts were written. Every value below is exact. The Lean files quoted in the brief were read as arguments and were not compiled. Log: [agent_logs/verify-L113-v347.log](../agent_logs/verify-L113-v347.log).**

| # | Claim | Verdict |
|---|---|---|
| 1 | Positivity of $g$ and the support of its measure are "consequences of the spectrum alone" | CONFIRMED under the reading "the constraint set they impose is determined by the spectrum". Positivity itself comes from $g_k$ being a squared norm |
| 2 | Any pair of moment inequalities built from positivity and support (with the pinned $m_0,m_1$), however $G_2$ enters, returns after elimination of $G_2$ only a conclusion already implied by the pinned data | CONFIRMED, with hypotheses H1 to H4 |
| 3 | The sharp form: the $G_2$-free content of positivity, support, $m_0=4(n-1)$, $m_1=-4\theta$ is exactly $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ (L107) | CONFIRMED (feasible_iff_theta, checked by hand) |
| 4 | "Moment analysis of the $g$-distribution cannot leave the pinned class", read as the consequence of claim 2 | CONFIRMED |
| 5 | The same sentence read unrestricted, as a heading-level statement about every constraint a moment analysis of $g$ might use | REFUTED AS STATED. The passages prove no such statement, and Passage A itself names the exception (Jacobi and first Bianchi on $c$) |
| 6 | The Lean file L113.lean formalises the step | REFUTED AS STATED. Its theorems are linearity, convexity and propositional-logic tautologies. L113Statement.lean carries the actual content (claim 3) |

**Summary: the step is VALID as the elementary projection fact "a $g$-free consequence of constraints that are valid on the whole relaxation is implied by the relaxation's feasibility", which is at most L107 and hence inside the pinned class. The heading, read without the restriction to positivity and support, is not proved.**

## 0. Conventions, fixed once

- $W\in\mathcal W_n$ with $\lVert W\rVert=1$, eigenvalues $\lambda_1,\dots,\lambda_N$ on $\Lambda^2$, $N=n(n-1)/2$, $n\ge2$. Trace zero gives $\lambda_{\min}\le0\le\lambda_{\max}$.
- $\theta:=P(W)$. At a critical point this is the multiplier in $Q(W)=\theta W$. The restricted reading needs no criticality (Passage C).
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, $m_j(g)=\sum_k\lambda_k^jg_k$, $G_2=m_2$.
- The relaxation: $K(\lambda,\theta):=\{g\in\mathbb R^N: g_k\ge0\ \forall k,\ m_0(g)=4(n-1),\ m_1(g)=-4\theta\}$. "Support" is encoded by indexing the atoms by the eigenvalues, so the measure $\mu_g=\sum_kg_k\delta_{\lambda_k}$ is supported in the spectrum. This is the Lean predicate Feasible lam $(4(n-1))$ $(-4\theta)$.
- The pinned data: the per-index relations (A), (B), (C) on a totally symmetric $T\ge0$ (Passage B, and the census definition in Passage D).

## 1. Hypothesis inventory

- **H1 (what "built from them" means).** Each moment inequality $\Phi_i(\lambda,\theta,G)$ used holds for every $g\in K(\lambda,\theta)$ with $G=m_2(g)$, that is, it is valid on the whole relaxation and uses no fact about $g$ beyond positivity, support and the two pinned moments. Optionally, further constraints on $g$ may be added provided each is itself a consequence of the pinned data (for example the L109 cap). The words "built from them" support this reading, and the sentence after the bolded one in Passage A confirms it is the intended one.
- **H2 (what "pinned conclusion" means).** A conclusion $Q(\lambda,\theta)$ is pinned when it holds at every $(\lambda,\theta)$ for which the pinned data are satisfiable. Read merely as "expressed in $(\lambda,\theta)$", the claim is empty, because Conjecture A is itself such a statement.
- **H3 (normalisation).** $\lVert W\rVert=1$, $n\ge2$, $\lambda_{\min}\le0\le\lambda_{\max}$. For the two-sided characterisation in claim 3, also $\theta\ge0$.
- **H4 (the pinned moments).** $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$, as given in Passages B and C, derived from (A), (B) and the cubic identity.
- **Not needed.** The word "pair": the argument covers any family of inequalities. Linearity in $G_2$: "however the free moment enters" is covered, since the argument is purely logical. The withdrawn conclusion of post F42: only its definition of pinned data is used.

## 2. The elimination argument (claim 2)

**Statement.** Assume H1 to H4. Let $\Phi_1,\Phi_2$ be valid on the relaxation in the sense of H1, and let $Q(\lambda,\theta)$ be obtained by eliminating $G_2$, that is, $\exists G\,[\Phi_1(\lambda,\theta,G)\wedge\Phi_2(\lambda,\theta,G)]\Rightarrow Q(\lambda,\theta)$. Then $K(\lambda,\theta)\neq\emptyset\Rightarrow Q(\lambda,\theta)$.

**Proof.** Suppose $K(\lambda,\theta)\neq\emptyset$ and pick $g\in K(\lambda,\theta)$. Put $G:=m_2(g)$. By H1, $\Phi_1(\lambda,\theta,G)$ and $\Phi_2(\lambda,\theta,G)$ both hold. So the existential premise holds and $Q(\lambda,\theta)$ follows. The same proof works verbatim for any number of inequalities, for any way $G$ (or any higher moment) enters, and for $K$ shrunk by extra constraints as allowed in H1.

**From the relaxation to the pinned class.** Let $T\ge0$ be totally symmetric and satisfy the pinned relations at $(\lambda,\theta)$. Then $g_k(T)\ge0$ as a sum of nonnegative terms, and by H4 $m_0(g(T))=4(n-1)$ and $m_1(g(T))=-4\theta$. So $g(T)\in K(\lambda,\theta)$. At a critical point H4's second identity can also be read off from (B) and (C) alone: $\sum_{k\alpha\beta}\lambda_k\lambda_\alpha^2T_{k\alpha\beta}=\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)=-2\operatorname{tr}W^3$, and multiplying (C) by $\lambda_k$ and summing gives $\sum\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\theta-2\operatorname{tr}W^3$. Hence $m_1=2(-2\operatorname{tr}W^3)-2(2\theta-2\operatorname{tr}W^3)=-4\theta$. So pinned satisfiability implies $K\neq\emptyset$, which by the statement implies $Q$. Every conclusion reachable this way is therefore pinned in the sense of H2. Claims 2 and 4 are CONFIRMED.

## 3. The sharp form (claim 3)

**feasible_iff** (Passage F) says: for $c>0$, $K$ with $m_0=c$, $m_1=s$ is nonempty iff $c\lambda_{\min}\le s\le c\lambda_{\max}$.

- Necessity: $c\lambda_{\min}=\sum_k\lambda_{\min}g_k\le\sum_k\lambda_kg_k=s$, and symmetrically at the top.
- Sufficiency, when $\lambda_{\min}<\lambda_{\max}$: put $t=(s-c\lambda_{\min})/(\lambda_{\max}-\lambda_{\min})$, mass $t$ on an index attaining $\lambda_{\max}$ and $c-t$ on one attaining $\lambda_{\min}$. Then the total mass is $c$, and the first moment is $\lambda_{\max}t+\lambda_{\min}(c-t)=c\lambda_{\min}+t(\lambda_{\max}-\lambda_{\min})=s$. The bounds on $s$ are exactly $0\le t\le c$. When $\lambda_{\min}=\lambda_{\max}$, the bounds force $s=c\lambda_{\min}$ and a single atom works.

**feasible_iff_theta.** With $c=4(n-1)>0$ and $s=-4\theta$: the lower bound reads $4(n-1)\lambda_{\min}\le-4\theta$, i.e. $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. The upper bound $-4\theta\le4(n-1)\lambda_{\max}$ holds automatically under $\theta\ge0\le\lambda_{\max}$. So $K(\lambda,\theta)\neq\emptyset\iff\theta\le(n-1)\lvert\lambda_{\min}\rvert$, which is L107 (Passage C). Combined with section 2: **every $G_2$-free conclusion obtained from positivity and support is implied by L107.** Claim 3 is CONFIRMED.

## 4. Arguing the opposite

- **Try the standard pair.** $\Phi_1$: Cauchy–Schwarz $m_1^2\le m_0m_2$, i.e. $G_2\ge4\theta^2/(n-1)$. $\Phi_2$: $G_2\le\max_k\lambda_k^2\,m_0=4(n-1)\max_k\lambda_k^2$. Both are valid on $K$. Eliminating $G_2$ gives $\theta\le(n-1)\max_k\lvert\lambda_k\rvert$. This is implied by L107 because $\lvert\lambda_{\min}\rvert\le\max_k\lvert\lambda_k\rvert$. Consistent with section 3.
- **Try adding the L109 cap.** $g_k\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$ shrinks $K$ and may yield a spectral bound stronger than L107. The cap is derived from $T\ge0$ and (A) (Passage E), so it is a consequence of the pinned data. H1 allows it and section 2 still places the conclusion in the pinned class. The sharp form of claim 3 changes, but claim 2 does not.
- **Try a non-positivity input.** $\Phi_2$ could be a bound on $S_{22}$ converted to $G_2$ through $S_{22}=2\theta\operatorname{tr}W^3-2\operatorname{tr}W^4+\tfrac12G_2$ (Passage B). Such a $\Phi_2$ is not valid on all of $K$, so H1 excludes it, and the elimination can then reach beyond L107. This is where the step would fail if "built from them" were dropped. The words keep it, so the restricted step stands.
- **Is the conclusion trivial?** Yes. Section 2 is a one-line soundness argument, and the whole mathematical content is the two-atom computation of section 3. Triviality does not make it invalid.

## 5. The unrestricted reading of the heading (claim 5)

The heading and the bolded sentence, taken alone, say that moment analysis of the $g$-distribution cannot leave the pinned class. Moment analysis of $g$ may use any true constraint on the realizable $g$, and the realizable set at a critical point is the set of $g(T)$ for $T=c^2$ with $c$ a genuine structure tensor, which obeys Jacobi. Passage A states that Jacobi and first Bianchi acting on $c$ might constrain $G_2$ beyond positivity and support, and calls this "the single open door". So the author does not claim the unrestricted statement, and the passages contain no argument for it. As a statement that the Lemma label marks as proved, the unrestricted reading is REFUTED AS STATED. It is unsettled, not shown false: settling it would require knowing whether the Jacobi-constrained set of realizable $(\lambda,\theta,G_2)$ projects to a strictly smaller $(\lambda,\theta)$ region than pinned satisfiability does, which is the open question the passage names.

## 6. The Lean files and the F42 citation (claim 6)

- L113.lean: moment_of_combination is linearity instantiated, constraints_convex and reachable_convex are convex combinations of reals, unused_hypothesis is $(A\to B\to C)\to(A\to B\to X\to C)$, and closure_with_content is $\exists S,\ 0\in S\wedge1\notin S$. None mentions $g$, a spectrum, or an elimination. unused_hypothesis is the logical skeleton of section 2 at most.
- L113Statement.lean: feasible_iff and feasible_iff_theta prove claim 3. The soundness step of section 2 is not stated there, but it is the one-line argument above.
- Passage A calls L113 an extension of post F42, whose conclusion is withdrawn (Passage D). Nothing in sections 2 and 3 uses that conclusion. Passage D's report that the full pinned system is much stronger than the single-row relaxation is consistent with L113: the restricted conclusion lies inside the pinned class and may lie strictly inside it (L107 versus the full $3N$-row bound), and the lemma claims only containment.

## 7. Verdict

**VALID**, under the reading: every conclusion free of $G_2$ (and of higher moments) that follows from inequalities valid on the whole relaxation $K(\lambda,\theta)$ (positivity, support in the spectrum, $m_0=4(n-1)$, $m_1=-4\theta$, optionally plus constraints that are themselves consequences of the pinned data) is implied by $K\neq\emptyset$, equivalently by L107, and hence by pinned satisfiability.

Hypotheses this reading needs: H1 (the inequalities are valid on all of $K$, which is what "built from them" says), H2 ("pinned conclusion" means implied by the pinned data), H3 ($\lVert W\rVert=1$, $n\ge2$, $\lambda_{\min}\le0\le\lambda_{\max}$, and $\theta\ge0$ for the two-sided form), H4 (the pinned values of $m_0$ and $m_1$ as given). The heading read without the restriction to positivity and support is not proved and is explicitly left open by the passage itself.
