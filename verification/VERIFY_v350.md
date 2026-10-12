# Verifier v350, whether Lemma L113 extends post F42 as post F42 now stands (step E3)

Cold brief ([ADJ_L113_E3.md](ADJ_L113_E3.md)). No numerical work was done and no scripts were written. Every value below is exact. The cited lines ([bounds.md](../findings/bounds.md) lines 508 and 526, [fence-posts.md](../findings/fence-posts.md) lines 417, 419 and 423) were printed and match the brief verbatim. Log: [agent_logs/verify-L113-v350.log](../agent_logs/verify-L113-v350.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Inequalities on the $g$-distribution built from positivity, support and the pinned $m_0,m_1$, with the free moment eliminated, return only pinned conclusions | CONFIRMED (under H1 to H3) |
| C2 | The natural pair (Cauchy–Schwarz and the support quadratic) returns exactly the L107 interval once $G_2$ is eliminated | CONFIRMED AS ALGEBRA |
| C3 | Reading R1: the statement of Passage A implies the conclusion of post F42 | REFUTED |
| C4 | Reading R2: Passage A composed with post F42 gives "moment analysis cannot close the conjecture" and the "single open door" moral, as Passage D now stands | REFUTED AS STATED |
| C5 | Reading R3: Passage A applies the surviving census definition of post F42 to $g$-moment arguments | CONFIRMED, but it uses nothing from post F42 beyond its vocabulary |
| C6 | Adjacent, outside the step: positivity and support of $g$ with pinned moments imply the L109 cap | REFUTED |

**Summary: the step FAILS as written, because the only reading in which Passage A extends post F42 as a theorem needs the post's heading conclusion, and Passage D withdraws exactly that conclusion.**

## 0. Conventions, fixed once

- $W\in\mathcal W_n$ is a critical point on the unit sphere: $\lVert W\rVert=1$, $Q(W)=\theta W$, $\theta=P(W)$. Eigenvalues $\lambda_1,\dots,\lambda_N$ on $\Lambda^2$, $N=\binom n2$, so $\sum_k\lambda_k^2=1$.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$ and $m_j=\sum_k\lambda_k^jg_k$, with $G_2=m_2$.
- From Passage B: $m_0=4(n-1)\lVert W\rVert^2=4(n-1)$ and $m_1=-4P(W)=-4\theta$.
- A real quantity is **pinned** when at every critical point it is a function of $(n,\text{spectrum},\theta)$. This is the sense of the last sentence of [fence-posts.md](../findings/fence-posts.md) line 419. A **pinned conclusion** is a statement whose only free symbols are $n$, the spectrum and $\theta$.
- $\lambda_{\min},\lambda_{\max}$ are the extreme eigenvalues, and $\lambda_{\min}\le0\le\lambda_{\max}$ since $\sum_k\lambda_k=\operatorname{tr}W=0$ on $\Lambda^2$ for an algebraic Weyl tensor.
- Passage D is split into three parts. D1 is the heading claim, "no route through the pinned data can close the conjecture". D2 is the census definition of the pinned data (line 419). D3 is the withdrawal notice (line 423).

## Hypothesis inventory

- **H1.** $W$ is critical and of unit norm. It makes $m_1=-4\theta$ pinned, since off the critical set $P(W)$ involves $W^\#$, which is then no polynomial in $W$.
- **H2.** "Moment analysis of the $g$-distribution" uses as inputs only $g_k\ge0$, the support of the measure $\sum_kg_k\delta_{\lambda_k}$ in the spectrum, the values $m_0,m_1$, and free moments $m_j$ with $j\ge2$.
- **H3.** "Once the free moment is eliminated" means projecting out the real variable $G_2$ (or finitely many free moments) from a finite system of polynomial inequalities with pinned coefficients.
- **H4.** The meaning of "extends". Three readings are examined: R1 (A implies D1), R2 (A composed with D1), R3 (A applies D2).

## 1. What the statement of Passage A proves (C1)

Under H2 every input inequality is a polynomial inequality in the variables $(m_2,m_3,\dots)$ whose coefficients are polynomials in $n$, the eigenvalues, $m_0$ and $m_1$. Under H1 the coefficients are pinned. Under H3 the conclusion is the projection of that semi-algebraic set onto the pinned coordinates. By Tarski–Seidenberg the projection is again a semi-algebraic condition, and its only free symbols are pinned ones. So the conclusion is pinned.

The argument is purely definitional: inputs that are pinned, with every unpinned variable projected out, leave only pinned symbols. It needs neither the census of D2 nor any fact about whether the conjecture holds. C1 is CONFIRMED under H1 to H3.

## 2. The natural pair returns exactly L107 (C2)

Take the two inequalities that positivity and support supply at degree two.

- Cauchy–Schwarz for the positive measure: $m_1^2\le m_0\,G_2$.
- Support in $[\lambda_{\min},\lambda_{\max}]$: $(\lambda-\lambda_{\min})(\lambda_{\max}-\lambda)\ge0$ on the spectrum gives $G_2\le(\lambda_{\min}+\lambda_{\max})m_1-\lambda_{\min}\lambda_{\max}m_0$.

Eliminating $G_2$ (with $m_0>0$):

$$m_1^2-(\lambda_{\min}+\lambda_{\max})m_0m_1+\lambda_{\min}\lambda_{\max}m_0^2=(m_1-\lambda_{\min}m_0)(m_1-\lambda_{\max}m_0)\le0,$$

that is $\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0$. With $m_0=4(n-1)$ and $m_1=-4\theta$, the left inequality reads $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, which is L107 (Passage C). The right one reads $\theta\ge-(n-1)\lambda_{\max}$, which is automatic for $\theta\ge0$. This matches feasible_iff and feasible_iff_theta in Passage F, which show that this interval is exactly the set of $(m_0,m_1)$ realised by some $g\ge0$. C2 is CONFIRMED AS ALGEBRA.

## 3. What post F42 asserts as Passage D now stands

- **D1 is withdrawn.** Line 423: "THIS POST'S CONCLUSION IS WITHDRAWN IN BOTH DIRECTIONS", and "the pinned class is far stronger than this post claimed, and 'sharpening inside it cannot work' is unsupported."
- **D2 is untouched by the quoted withdrawal.** The census still defines the pinned data as the contractions $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$ with at least two of $p,q,r$ at most $1$.
- **D3 adds a screened observation.** The full $3N$-row system (relations (A), (B), (C) at every index, with $T\ge0$) has exact max-$\theta$ at fixed spectrum on all seven catalogued spectra tested. This is a screen, and it is recorded here as what D says, never as evidence for either direction.

So the post, as it stands, carries a definition (D2) and an open question (whether the pinned class closes the conjecture). It carries no theorem.

## 4. Reading R1: Passage A implies D1 (C3)

The statement of Passage A is a containment: every $g$-moment conclusion lies in the pinned class. D1 is an exclusion: the pinned class does not contain the conjecture. A containment implies nothing about what the containing class excludes.

Exhibited concretely: Section 1 proves A from definitions alone, with no input about the conjecture. If A implied D1, then D1 would follow from definitions alone and would be a theorem. D3 records D1 as unsupported and records the full pinned system reaching exact max-$\theta$ on every spectrum screened. A is true in both possible worlds (pinned class closes or does not), so A cannot imply D1. C3 is REFUTED.

## 5. Reading R2: Passage A composed with D1 (C4)

This is the reading the paragraph at [bounds.md](../findings/bounds.md) line 526 actually uses. The quoted line proceeds: A holds, so "the free data $G_2$ helps only if realizability constrains it through something positivity and support do not see", and "That is now the single open door". The inference from "moment analysis stays inside the pinned class" to "the only door lies outside the pinned class" needs the premise that the pinned class cannot close the conjecture. That premise is D1.

As logic the composition is valid: $(\text{moment analysis}\subseteq\text{pinned})\wedge(\text{pinned}\not\ni\text{conjecture})\Rightarrow(\text{moment analysis}\not\ni\text{conjecture})$. As Passage D now stands, the second conjunct is withdrawn, so the composed conclusion and the "single open door" moral are unsupported. They also contradict D3 directly: D3 says sharpening inside the pinned class is not ruled out, while line 526 places the single open door outside it.

Arguing the opposite: one could hold that the moral concerns only $g$-moment arguments, which reach L107 and no further (Section 2), so that D1 is never used. That reading does not survive the text, which says "the question the whole route stands on". It also meets a concrete obstacle: the per-index $T$-level system is a pinned source that positivity and support of $g$ do not see, and Section 7 exhibits one of its consequences (L109) that they do not imply. So a door inside the pinned class, but outside moment analysis of $g$, is exactly what D3 leaves open. C4 is REFUTED AS STATED.

## 6. Reading R3: Passage A applies the census definition D2 (C5)

This is the strongest reading under which the words hold. The census of D2 is consistent with Passage A's split between pinned and free moments. Expanding $\lambda_k^j(\lambda_\alpha-\lambda_\beta)^2=\lambda_k^j\lambda_\alpha^2+\lambda_k^j\lambda_\beta^2-2\lambda_k^j\lambda_\alpha\lambda_\beta$ and using the total symmetry of $T$:

- $j=0$: exponents $(0,2,0)$ and $(0,1,1)$. Both have two entries at most $1$, so $m_0$ is pinned.
- $j=1$: exponents $(1,2,0)$ and $(1,1,1)$. Both qualify, so $m_1$ is pinned.
- $j=2$: $G_2=2\sum\lambda_k^2\lambda_\alpha^2T_{k\alpha\beta}-2\sum\lambda_k^2\lambda_\alpha\lambda_\beta T_{k\alpha\beta}$. The exponent $(2,2,0)$ has only one entry at most $1$, so $G_2$ is outside the census. This agrees with Passage B's "all free content sits at $G_2$ and above".

Under R3, A extends D2 in the sense that it shows one further family of arguments lands in the class D2 names. It needs H1 to H3 and the hypothesis that "post F42" denotes only its surviving census definition. Two limits apply:

- Section 1 proves A without the census, since $m_0,m_1$ are pinned by (A), (B) and the cubic identity (Passage B). So R3 draws only vocabulary from post F42.
- R3 supports none of line 526 after the bolded sentence, because the "single open door" moral needs D1 (Section 5). The phrase "theorem-shaped extension" also presupposes a theorem to extend, and D as it stands holds none (Section 3).

C5 is CONFIRMED with these limits.

## 7. Adjacent, outside the step: L109 is invisible to positivity and support (C6)

This bears on Section 5 and it concerns data the passages give. Take a spectrum with $\lambda_{\min}<0$ simple, at index $\gamma$, and set $\theta:=(n-1)\lvert\lambda_{\min}\rvert$. Then $m_1=\lambda_{\min}m_0$, and the only $g\ge0$ with support in the spectrum and these moments is $g=m_0e_\gamma$. The reason is $\sum_k(\lambda_k-\lambda_{\min})g_k=m_1-\lambda_{\min}m_0=0$ with every term nonnegative and $\lambda_k>\lambda_{\min}$ for $k\ne\gamma$. So positivity and support permit $g_\gamma=4(n-1)$.

L109 (Passage E) caps $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$. Since $\lambda_{\max}\ge0>\lambda_{\min}$ sit at distinct indices, $(\lambda_{\max}-\lambda_{\min})^2\le2(\lambda_{\max}^2+\lambda_{\min}^2)\le2\sum_k\lambda_k^2=2$, so the cap is at most $4(n-2)<4(n-1)$. Thus the $T$-level data ($T\ge0$ with the row marginal) excludes a $g$ that positivity and support admit. That constraint is pinned, and it lies outside what "positivity of $g$ and the support of its measure" see. C6 is REFUTED. Whether it sharpens L107 at some spectrum is a separate question: settling it needs the exact max of $\theta$ over the $g$-relaxation with the L109 caps added, compared with $(n-1)\lvert\lambda_{\min}\rvert$ at a spectrum where $\lambda_{\min}$ has low multiplicity. This verifier did not pursue it.

## 8. The Lean files

L113.lean proves linearity of a linear map on convex combinations, convexity of an equality-and-sign constraint, the dropping of an unused hypothesis, and the existence of a set containing $0$ and not $1$. L113Statement.lean proves the feasibility characterisation used in Section 2. Neither file states anything about post F42, the census, or closure of the conjecture. They give no support to the extension relation.

## Verdict for step E3: FAILS

- **Where it fails.** [bounds.md](../findings/bounds.md) line 526, "it is a theorem-shaped extension of post F42", used to carry the "single open door" moral. That moral needs D1, the conclusion of post F42, and [fence-posts.md](../findings/fence-posts.md) line 423 withdraws D1 in both directions and calls "sharpening inside it cannot work" unsupported (Sections 4 and 5).
- **The strongest reading that holds (R3).** Passage A shows that $g$-moment arguments land in the pinned class that post F42's surviving census defines. This reading is VALID under H1 (critical, unit norm), H2 (inputs are positivity, support, $m_0$, $m_1$ and free moments), H3 (elimination by projection) and the hypothesis that "post F42" denotes only its census definition D2. Under it the extension is one of vocabulary, it is provable without post F42, and it supports none of the moral that follows the bolded sentence.
