# Verifier v345, Lemma L113 (moment analysis of the $g$-distribution cannot leave the pinned class): the bold claim, its premise on positivity and support, its label and argument, "pinned class", the extension of post F42, "the only sources on the table", the feasibility equivalence, the Lean files, and the boundary

**Standfirst.** Cold check from [BRIEF_L113.md](BRIEF_L113.md) alone, with the cited record lines printed exactly (bounds.md 258–264, 508, 526, 562, 566, conventions.md 50, fence-posts.md 417, 419, 423, bounds-relaxations.md 47, 51, 53, all matching the brief verbatim) and [Proposition 1.7](../references/petersen-wink-2019-bochner-technique/notes.md) read at source. No numerical work, no scripts written, no Lean compiled, every value below exact and derived by hand. Log: [agent_logs/verify-L113-v345.log](../agent_logs/verify-L113-v345.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's bold sentence "Moment analysis of the $g$-distribution cannot leave the pinned class" is a proposition | GAP |
| 2 | "Positivity of $g$ and the support of its measure are consequences of the spectrum alone", with $m_0,m_1$ free of (C) | CONFIRMED (wording corrected) |
| 3 | Passage A carries a proof, and the `Lemma` label is supported | GAP |
| 4 | "Pinned class" is the same object as F42's "pinned data" | GAP |
| 5 | L113 is "a theorem-shaped extension of post F42" | REFUTED AS STATED |
| 6 | "The only sources on the table are the Jacobi identity and first Bianchi acting on the $c$-tensor itself", "the single open door" | REFUTED AS STATED |
| 7 | $g\ge0$, $\sum_kg_k=4(n-1)$, $\sum_k\lambda_kg_k=-4\theta$ is feasible exactly when $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ | CONFIRMED AS ALGEBRA under $\lVert W\rVert=1$, $\lambda_{\min}\le0\le\lambda_{\max}$, $\theta\ge0$, REFUTED AS STATED without $\theta\ge0$ |
| 8a | L113.lean declarations support the claim | CONFIRMED AS ALGEBRA, each a tautology unrelated to the claim |
| 8b | L113Statement.lean feasible_iff, feasible_iff_theta, moment_add, moment_smul | CONFIRMED AS ALGEBRA, none states the bold claim |
| 9 | Boundary: $\lVert W\rVert\ne1$, repeated and simple $\lambda_{\min}$, $\ker W\ne0$, small and odd $n$, $n=6+2\sqrt7$ | CONFIRMED, with the unit-norm hypothesis made explicit |

**What the round should do:** define "pinned class" and "moment inequality", file the one-paragraph projection argument of §1 (it rests on feasible_iff), strike "extension of post F42" and "the only sources … single open door" (the record's own row cap L109 is a further source, §6), and add $\lVert W\rVert=1$ and $\theta\ge0$ to the feasibility statement.

## 0. Conventions, fixed once

- $\mathcal W_n$ algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=n(n-1)/2$, orthonormal eigenbasis $v_k$ with eigenvalues $\lambda_k$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$, $T_{abc}=c_{abc}^2\ge0$ totally symmetric.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, $\mu:=\sum_kg_k\,\delta_{\lambda_k}$ the $g$-distribution, $m_j=\sum_k\lambda_k^jg_k$, $G_2=m_2$.
- $P(W)=\langle W,W^2+W^\#\rangle$, and at a unit critical point $\theta=P(W)$. The "cubic identity" is read as $\sum_{kab}\lambda_k\lambda_a\lambda_bT_{kab}=2\operatorname{tr}(WW^\#)$, which is what makes $m_1=-4P(W)$ come out, and which I checked against the $n=4$ example of §6.
- $\operatorname{tr}W=0$ on $\mathcal W_n$ (zero scalar curvature), so $W\ne0$ gives $\lambda_{\min}<0<\lambda_{\max}$.
- $\mathcal W_n=0$ for $n\le3$, so the smallest admissible dimension is $n=4$, $N=6$.
- In $n=4$, $\mathfrak{so}(4)=\Lambda^2_+\oplus\Lambda^2_-$ with both summands ideals isomorphic to $\mathfrak{so}(3)$, so $c_{abc}=0$ unless $a,b,c$ lie in one summand, and $W\in\mathcal W_4$ exactly when $W=W_+\oplus W_-$ with $W_\pm$ trace-free symmetric on $\Lambda^2_\pm$. Relation (A) with $n=4$ then forces $T_{123}=2$ inside a summand.

## Hypothesis inventory

| Source | Hypothesis | Applied to | Holds? | Used by the written text? |
|---|---|---|---|---|
| Passage A | none stated (no dimension, no norm, no criticality, no sign of $\theta$) | the $g$-distribution | n/a | the text needs $\lVert W\rVert=1$ and, for the equivalence, $\theta\ge0$, neither stated (§7, §9) |
| (A) | Killing form, orthonormal basis | every row $k$ | yes, at every $W$ | yes, for $m_0$ and for the L109 cap |
| (B) | $W\in\mathcal W_n$ (the published identity $\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W$ on Weyl) | every row | yes, at every $W$ | yes, for $m_0$ and $m_1$ |
| (C) | criticality $Q(W)=\theta W$ | every row | only at critical points | not by $m_0,m_1$, enters first at $m_2$ through the $(2,1,1)$ term |
| $T\ge0$ | $T=c^2$ | all entries | yes, by definition | yes, for $g_k\ge0$ and for L109 |
| Prop 1.7 (Petersen-Wink) | $\{\Xi_\alpha\}$ an orthonormal eigenbasis of $R$, $L\in\mathfrak{so}(V)$ | $R=W$, $L=v_\gamma$ | yes | yes, it is the formula for $g_\gamma$ |
| L107 (given) | as quoted, "every $W\in\mathcal W_n$" | Passage A's implicit pinned conclusion | on the unit sphere (§9) | implicitly, as the pinned conclusion |
| L109 (given) | $T\ge0$, row marginal (A) | each $g_\gamma$ | yes | not used by L113, and it contradicts claim 6 |
| Post F42 | the census (at least two of $p,q,r\le1$ pinned) | the "pinned data" | its conclusion is withdrawn (Passage D) | imported by name as the base of an "extension" |
| feasible_iff | Fin N nonempty, $0<c$ | $c=4(n-1)$ | yes for $n\ge2$ | all used |
| feasible_iff_theta | $2\le n$, $0\le\theta$, $\inf\lambda\le0$, $0\le\sup\lambda$ | $\lambda$ = spectrum | $\inf\le0\le\sup$ from $\operatorname{tr}W=0$, $\theta\ge0$ only at nonnegative critical points | all used: hmin in the absolute value, hθ and hmax and hn in the reverse direction |
| reachable_convex | hα, hα' | α | n/a | **unused** by its proof (`rw` with linearity alone) |

## 1. Is the bold sentence a proposition (GAP)

**Located.** Line 526: "*any* pair of moment inequalities built from them, however the free moment enters, can only return a pinned conclusion once the free moment is eliminated. **Moment analysis of the $g$-distribution cannot leave the pinned class.**"

**Terms.** None of "moment inequality built from them", "pinned conclusion" or "pinned class" is defined in Passages A–F. "Pinned data" is defined in F42 (Passage D, line 419) as a set of contractions of $T$, which are numbers, not conclusions or inequalities (§4).

**Two readings.**
- *Tautological reading.* A pinned conclusion is any statement in $(\lambda,\theta,n)$. Once every free moment is eliminated, what remains is in those variables by construction, so the sentence is empty. Every bound on $\theta$ in terms of the spectrum, including any that Jacobi or Bianchi might one day give, is "pinned" in this sense.
- *Substantive reading.* Fix $\lambda$ and $\theta$ with $\lVert W\rVert=1$. Every conclusion in $(\lambda,\theta)$ that follows from "$\mu\ge0$, $\operatorname{supp}\mu\subseteq\{\lambda_k\}$, $m_0=4(n-1)$, $m_1=-4\theta$", with $m_2,m_3,\dots$ existentially eliminated, is implied by $-(n-1)\lambda_{\max}\le\theta\le(n-1)\lvert\lambda_{\min}\rvert$.

**The substantive reading is true, and its proof is not on file in Passage A.** What would have to be written is this paragraph. For fixed $\lambda$, let $F$ be the set of $(m_0,m_1)$ realised by some $g\ge0$ on the atoms $\lambda_k$. By feasible_iff, $F=\{\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0\}$. Every $(m_0,m_1)\in F$ is realised by an actual $g$ (the two-atom witness), and that $g$ has some $m_2,m_3,\dots$. So any system of inequalities valid for all $g\ge0$ on the atoms, whatever number of free moments it involves, is satisfied by a completion of every point of $F$, and its projection to $(m_0,m_1)$ contains $F$. The projection is contained in $F$ because $F$ is itself a consequence. Hence the projection equals $F$.

**Arity.** "Pair" is too narrow. With one free moment, Fourier-Motzkin on a pair eliminates it, but with $m_2,m_3$ both free a pair generally cannot eliminate both. The argument above covers any family, so "pair" should read "any finite family". Example of a pair doing the job: $\sum_k(\lambda_k-\lambda_{\min})(\lambda_k-\lambda_{\max})g_k\le0$ gives $m_2\le(\lambda_{\min}+\lambda_{\max})m_1-\lambda_{\min}\lambda_{\max}m_0$, Cauchy–Schwarz gives $m_2\ge m_1^2/m_0$, and eliminating $m_2$ yields $(m_1-\lambda_{\min}m_0)(m_1-\lambda_{\max}m_0)\le0$, exactly $F$.

**Three-step record.** Located: line 526. Failure: the sentence is undefined as written, and under its only nontrivial reading the proof is absent from the block. Charitable reading: the substantive reading is intended, and it is true. The charitable reading rescues the truth, not the filing, so the verdict is GAP (no argument on file), with the paragraph above as what must be filed.

## 2. Positivity, support, $m_0$, $m_1$, and whether (C) enters (CONFIRMED, wording corrected)

- **Positivity.** $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}\ge0$ from $T=c^2\ge0$ alone, equivalently from $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2$ (Prop 1.7 with $L=v_k$). No relation among (A), (B), (C) is used, and criticality is not used.
- **Support.** $\operatorname{supp}\mu\subseteq\{\lambda_k\}\subseteq[\lambda_{\min},\lambda_{\max}]$ by the definition of $\mu$.
- **$m_0$.** $m_0=2\sum_a\lambda_a^2\sum_{kb}T_{kab}-2\sum_a\lambda_a\sum_{bk}\lambda_bT_{abk}=2\cdot2(n-2)\lVert W\rVert^2-2\sum_a\lambda_a(-2\lambda_a)=4(n-1)\lVert W\rVert^2$. Uses (A) and (B), not the cubic identity.
- **$m_1$.** $m_1=2\sum_a\lambda_a^2\sum_{kb}\lambda_kT_{akb}-2\sum\lambda_k\lambda_a\lambda_bT_{kab}=-4\operatorname{tr}W^3-4\operatorname{tr}(WW^\#)=-4P(W)$. Uses (B) and the cubic identity, not (A).
- **(C).** Enters neither. It first enters $m_2=2\sum_{ka}\lambda_k^2\lambda_a^2\rho_{ka}-2\sum_k\lambda_k^2\sum_{ab}\lambda_a\lambda_bT_{kab}$, where the second term is $-4\sum_k\lambda_k^3(\theta-\lambda_k)$ by (C) and the first, with $\rho_{ka}=\sum_bT_{kab}$, is the free content. This agrees with Passage B's "all free content sits at $G_2$ and above".
- **Wording.** Positivity is a consequence of $T\ge0$, not of the spectrum. The values $m_0,m_1$ are functions of $(\lVert W\rVert,P(W))$, and $P(W)$ is a spectral function only in the sense that $\theta$ is carried as a parameter. The charitable reading, "positivity and support impose nothing that depends on $W$ beyond $(\lambda,\theta)$", is correct, so the claim is CONFIRMED under that reading, and the sentence should say it.

## 3. Does Passage A carry a proof, is `Lemma` supported (GAP)

**Located.** Line 526 opens "**The moral, and it is a theorem-shaped extension of post F42.**" and joins premise to conclusion with "so".

The block as quoted contains no derivation: no definition of the class of inequalities, no realisation argument, no appeal to feasible_iff. The word "so" carries the whole step. The lemma has no entry in [results.md](../results.md) (brief). The Lean file L113Statement.lean proves the ingredient (feasible_iff) but no declaration states the conclusion (§8). What would have to be proved is the projection statement of §1. The label is therefore unsupported on the record as quoted. This verdict covers the quoted lines 508 and 526, and I did not read lines 509–525.

**Three-step record.** Located. Failure: "so" with no argument. Charitable reading: the argument is "obvious" from the two-atom witness in the Lean proof. The charitable reading makes it provable, not proven on file, so GAP stands.

## 4. "Pinned class" against "pinned data" (GAP)

- **Pinned data** (Passage D, line 419): the contractions $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$ with at least two of $p,q,r\le1$. These are linear functionals of $T$ whose values (A), (B), (C) fix in terms of $(\lambda,\theta)$. I checked the forward direction of the census: if $q,r\le1$, the inner sum over $b,c$ is (A), (B) or (C) at row $a$, and weighting by $\lambda_a^p$ keeps it determined.
- **Pinned class** in Passage D (line 423, the withdrawal note) names the full $3N$-row system on $T\ge0$, "far stronger than this post claimed". That is a feasible set of $T$, not a set of numbers.
- **Passage A** uses "pinned class" for a class of conclusions.

A statement about inequalities needs a set of conclusions or the feasible set they cut out. The $g$-route sees $T$ only through the linear image $g$ and its moments $m_0,m_1$, so its feasible set is the projection of a relaxation that is strictly weaker than "$T\ge0$ with all pinned data" (§6 exhibits the strictness in closed form). Under Passage D's sense, "moment analysis cannot leave the pinned class" is true trivially (it lives inside it) and says nothing about the strength that class has. Under Passage A's sense, the term is undefined. GAP: the term must be defined before the sentence has a truth value.

## 5. "A theorem-shaped extension of post F42" (REFUTED AS STATED)

**Located.** Line 526, "it is a theorem-shaped extension of [post F42]", against fence-posts.md line 423, "**THIS POST'S CONCLUSION IS WITHDRAWN IN BOTH DIRECTIONS.** … *So the pinned class is far stronger than this post claimed, and "sharpening inside it cannot work" is unsupported.*"

**Failure in closed form.**
- F42's (withdrawn) claim ranges over every relaxation through the pinned data (line 419: "it applies to every relaxation the record has tried"). L113 ranges over the $g$-moment relaxation only, which is the image under $T\mapsto(m_0,m_1)$ of one such relaxation. That makes L113 a special case of F42's claim, not an extension.
- The special case is strictly weaker than the pinned $T$-system. At the $n=4$ spectrum of §6, the $g$-moment route yields $\theta\le3/\sqrt2$ and the row cap L109, a consequence of (A) and $T\ge0$, yields $\theta\le\sqrt2$.
- The parent claim is withdrawn, and "theorem-shaped" has no proof behind it (§3).

**Charitable reading.** "Extension" means "promotes F42's heuristic to a theorem on the $g$-moment subcase". That reading makes the relation a restriction, keeps the base withdrawn, and still has no theorem on file. It does not rescue the sentence. REFUTED AS STATED.

## 6. "The only sources on the table are Jacobi and first Bianchi", "the single open door" (REFUTED AS STATED)

**Located.** Line 526: "The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see, and the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself** … *That is now the single open door*".

**The counter-source on the table.** Passage E, L109: $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$. Following the step's own algebra: $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\le(\lambda_{\max}-\lambda_{\min})^2\sum_{\alpha\beta}T_{\gamma\alpha\beta}=2(n-2)(\lambda_{\max}-\lambda_{\min})^2$. It uses $T\ge0$, (A) at row $\gamma$, and Prop 1.7 (the formula for $g_\gamma$, whose hypotheses, orthonormal eigenbasis and $L=v_\gamma\in\mathfrak{so}(n)$, hold). It uses neither Jacobi nor Bianchi, and it constrains $g$ through row data that positivity and support do not see.

**Closed-form witness that the cap is not implied by positivity and support, and sharpens the conclusion.** Take $n=4$, $W_+=\operatorname{diag}(s,0,-s)$ on an oriented orthonormal basis of $\Lambda^2_+$, $W_-=0$, $s=1/\sqrt2$. Then $W\in\mathcal W_4$, $\lVert W\rVert^2=2s^2=1$, the spectrum is $(s,0,-s,0,0,0)$, $\lambda_{\min}=-s$ is simple, $\lambda_{\max}=s$.
- Cap: $2(n-2)(2s)^2=16s^2=8$. Mass: $m_0=4(n-1)=12$.
- The vector $g^\ast=(0,0,12,0,0,0)$ satisfies $g^\ast\ge0$, support in the spectrum, $m_0=12$, $m_1=-12s=-4\theta$ at $\theta=3s=(n-1)\lvert\lambda_{\min}\rvert$. So it is admissible to positivity, support and the pinned moments at the L107 extremum, and it violates the cap, $12>8$.
- With the cap, $\min\sum_k\lambda_kg_k$ over $0\le g_k\le8$, $\sum g_k=12$ is $8\cdot(-s)+4\cdot0=-8s$, so $\theta\le2s=\sqrt2$, strictly below L107's $3s=3/\sqrt2$.
- Consistency check that the witness respects L109: with $T_{123}=2$ inside $\Lambda^2_+$, $g=(4(\lambda_2-\lambda_3)^2,4(\lambda_1-\lambda_3)^2,4(\lambda_1-\lambda_2)^2,0,0,0)=(2,8,2,0,0,0)$, so $\sum g=12$ ✓, $\sum\lambda g=0=-4P(W)$ ✓ ($P=\operatorname{tr}W^3+6\lambda_1\lambda_2\lambda_3=0$), and $g_2=8$ meets the cap with equality.

The cap also bounds $G_2$ differently from positivity and support (at this spectrum they allow $G_2=12s^2$ with all mass at $-s$, which the cap forbids), so it is a source of exactly the kind the sentence says only Jacobi and Bianchi can supply.

**Charitable readings.** (a) "The only sources outside the pinned data": the sentence then requires that pinned data cannot beat the $g$-moment bound, which the witness refutes, since the cap is pinned. (b) "Sources acting through $G_2$ specifically": the cap acts on $G_2$ as well. (c) "Sources not yet used": L109 is on file as a given, so it is on the table. No reading rescues "the single open door". REFUTED AS STATED. Row-level constraints on $T$ (L109, and the full $3N$-row system Passage D mentions) are a door that stays inside the pinned data.

## 7. The complete consequence (CONFIRMED AS ALGEBRA with hypotheses, REFUTED AS STATED without $\theta\ge0$)

With $c=4(n-1)>0$ and $s=-4\theta$, feasible_iff gives feasibility iff $4(n-1)\lambda_{\min}\le-4\theta\le4(n-1)\lambda_{\max}$, that is

$$-(n-1)\lambda_{\max}\ \le\ \theta\ \le\ (n-1)\lvert\lambda_{\min}\rvert\qquad(\lambda_{\min}\le0).$$

- **Sign conditions used.** $n\ge2$ for $c>0$. $\lambda_{\min}\le0$ to write $-\lambda_{\min}=\lvert\lambda_{\min}\rvert$, automatic from $\operatorname{tr}W=0$. $\theta\ge0$ together with $\lambda_{\max}\ge0$ to discharge the left inequality. $\lVert W\rVert=1$ for $m_0=4(n-1)$.
- **"Exactly when $\theta\le(n-1)\lvert\lambda_{\min}\rvert$" fails without $\theta\ge0$.** Located: brief item 7 phrasing, and the hypothesis hθ in feasible_iff_theta, which is what saves the Lean. Closed form: at the §6 spectrum with $n=4$ and $\theta=-3$, the right side $-3\le3/\sqrt2$ holds, and feasibility needs $-4\theta=12\le12\lambda_{\max}=12/\sqrt2$, false. Charitable reading: at a genuine $W$ the system is always feasible (the actual $g$ witnesses it), so the equivalence matters only for abstract $(\lambda,\theta)$. The abstract equivalence is what is claimed, so the reading does not rescue it.
- **The negative-$\theta$ side is L107 for $-W$.** $Q(-W)=Q(W)=(-\theta)(-W)$, so $-W$ is critical with $\theta'=-\theta$ and spectrum $-\lambda$. The left inequality for $-W$ is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ for $W$. Negative-$\theta$ critical points exist whenever positive ones do, so the hypothesis $\theta\ge0$ has content.
- **Against Passage C.** The system implies L107 at every unit-norm $W$ with $\theta:=P(W)$, criticality unused, which is what line 566 says, read on the unit sphere (§9).

## 8. Passage F against Passage A

**L113.lean (CONFIRMED AS ALGEBRA, unrelated to the claim).**
- moment_of_combination: for $m:\mathbb R\to\mathbb R$ with the linearity hypothesis, $m(\alpha T_1+(1-\alpha)T_2)=\alpha m(T_1)+(1-\alpha)m(T_2)$. An instance of its own hypothesis. $T_1,T_2$ are reals, not tensors.
- constraints_convex: two nonnegative reals both equal to $c$ have a nonnegative convex combination equal to $c$. True and trivial.
- reachable_convex: linear $m$ carries convex combinations to convex combinations. Its hypotheses hα and hα' are unused by the proof (`rw` with linearity alone).
- unused_hypothesis: $(A\to B\to C_0)\to A\to B\to C\to C_0$, propositional weakening.
- closure_with_content: $\exists S\subseteq\mathbb N,\ 0\in S\wedge1\notin S$.

None mentions $W$, $T$, $g$, moments of the $g$-distribution, a pinned class or elimination.

**"A convex image cannot separate a non-convex class from its complement".** The phrase appears in no declaration as quoted (docstrings were removed), so it is untyped. Its truth depends on the reading. If it means "a convex set containing a non-convex class $K$ meets $K^c$", it is true: the convex set contains $\operatorname{conv}K\supsetneq K$. If it means "a linear map sends $K$ and $K^c$ to disjoint sets", it is false: $K=\{0,2\}\subset\mathbb R$ with the identity map. Neither reading is stated on the record.

**L113Statement.lean (CONFIRMED AS ALGEBRA).**
- Feasible and feasible_iff: for nonempty Fin N and $c>0$, a nonnegative $g$ with $\sum g=c$ and $\sum\lambda g=s$ exists iff $c\min\lambda\le s\le c\max\lambda$. I followed the proof. The forward direction is two monotone sum bounds. The reverse handles $\min=\max$ with a one-atom witness, where $s=c\min$ is forced by the two inequalities. Otherwise it uses the two-atom witness $t=(s-c\lambda_{\min})/(\lambda_{\max}-\lambda_{\min})\in[0,c]$ at the argmax and $c-t$ at the argmin, with $\lambda_{\max}t+\lambda_{\min}(c-t)=s$. The mathematics is correct. I did not compile it.
- feasible_iff_theta: the §7 equivalence with $2\le n$, $0\le\theta$, $\inf\lambda\le0\le\sup\lambda$, all four used. $N$ and $n$ are independent and the sign hypotheses are assumed rather than derived from $\operatorname{tr}W=0$. Both are harmless, since the theorem is universal in $N$.
- moment, moment_add, moment_smul: `moment` matches $m_j=\sum_k\lambda_k^j\sum_{ab}(\lambda_a-\lambda_b)^2T_{kab}$, and it is additive and homogeneous in $T$. True, and nothing uses it towards the claim.
- The example: $g=(2,2)$ for $\lambda=(1,-1)$, $c=4$, $s=0$. True.

**What is established.** The Lean establishes the $(m_0,m_1)$ feasibility interval, the ingredient of §1. It does not formalise the relations (A), (B), the identities $m_0=4(n-1)\lVert W\rVert^2$ and $m_1=-4P(W)$, or the projection statement, so Passage A's bold claim has no Lean statement.

## 9. The boundary (CONFIRMED, unit norm made explicit)

- **$\lVert W\rVert\ne1$.** $m_0=4(n-1)\lVert W\rVert^2$, so the system with $4(n-1)$ is the unit-sphere system. The scale-free consequence is $P(W)\le(n-1)\lVert W\rVert^2\lvert\lambda_{\min}\rvert$, homogeneous of degree 3. Example: $n=4$, $W_+=\operatorname{diag}(2,-1,-1)t$, $W_-=0$ gives $g=(0,36t^2,36t^2,0,0,0)$, $m_0=72t^2=4\cdot3\cdot6t^2$ ✓, $m_1=-72t^3$, $P=18t^3$, and $(n-1)\lVert W\rVert^2\lvert\lambda_{\min}\rvert=3\cdot6t^2\cdot t=18t^3$, equality at every scale. At $6t^2=4$ (norm 2) the unscaled form $P\le3\lvert\lambda_{\min}\rvert$ reads $18t^3\le3t$, false.
- **Repeated eigenvalues, simple $\lambda_{\min}$.** The feasibility interval depends only on the values $\lambda_{\min},\lambda_{\max}$, and the two-atom witness sits on one index of each. The case $\lambda_{\min}=\lambda_{\max}$ forces $W=0$ on $\mathcal W_n$, which is off the unit sphere. Simple $\lambda_{\min}$ is exactly where the L109 cap bites (§6), since the extremal mass $4(n-1)$ must sit on one atom.
- **$\ker W\ne0$.** Zero eigenvalues are atoms at $0$ and change nothing. Padding $W\in\mathcal W_n$ by zero to $\mathbb R^{n+1}$ keeps Ricci and Bianchi, so it gives an element of $\mathcal W_{n+1}$ with the same $\lambda_{\min}$, while (A) becomes $2(n-1)$ and the bound loosens to $\theta\le n\lvert\lambda_{\min}\rvert$ in the padded normalisation. All relations are stated in the ambient $n$, so nothing breaks.
- **Small $n$.** $n=4$ is the smallest admissible dimension, and the §6 and §9 examples are at $n=4$. The Lean hypothesis $2\le n$ admits $n=2,3$, where $\mathcal W_n=0$ and the application is vacuous.
- **Odd $n$, $n=6+2\sqrt7$.** Nothing in the argument depends on parity, and neither L113 nor the feasibility statement refers to the crossover.

## Quantifier order and scope

- The correct order is $\forall n\ge4$, $\forall\lambda$ (a spectrum with $\operatorname{tr}=0$, $\sum\lambda^2=1$), $\forall\theta\ge0$: [$\exists g\ge0$ on the atoms with $m_0=4(n-1)$, $m_1=-4\theta$] $\iff\theta\le(n-1)\lvert\lambda_{\min}\rvert$. The projection statement of §1 then quantifies over all inequality families for that fixed $\lambda$. Passage A's "any pair … can only return" has the right shape once "pair" becomes "family" and the class of admissible inequalities is fixed.
- Passage A does not say whether it quantifies over critical points or all unit $W$. Since (C) does not enter $m_0,m_1$, it holds for all unit $W$ with $\theta:=P(W)$.
- A claim proven on a subfamily and stated in general: F42's scope (all pinned relaxations) against L113's scope ($g$-moments). L113 is the narrower claim, which is why "extension" fails (§5).

## Withdrawn candidates

1. **Passage C, "the bound holds at every $W\in\mathcal W_n$", fails off the unit sphere.** Located at line 566, exhibited in §9 (norm 2). Charitable reading: $\theta$ is defined as $P(W)$ on the unit sphere, so "every $W$" means every unit $W$, critical or not. That reading holds, so the candidate is withdrawn, with the unit-norm hypothesis recorded in §9.
2. **Passage B, "both from (A) and (B) with the cubic identity", misattributes.** $m_0$ needs no cubic identity and $m_1$ needs no (A) (§2). Charitable reading: a joint attribution for the pair, which is correct. Withdrawn.
3. **feasible_iff_theta decouples $N$ from $n$ and assumes the sign conditions.** Charitable reading: the theorem is universal in $N$, and the sign conditions hold for $W\ne0$ in $\mathcal W_n$. Withdrawn.
4. **The `positivity` call on $(\text{if }k=j\text{ then }t\text{ else }0)+(\text{if }k=i\text{ then }c-t\text{ else }0)$ may not close $0\le c-t$ from htc.** No closed-form failure can be exhibited without compiling, and the mathematics ($t\le c$) is sound. Withdrawn at step 2.
5. **"Pair" is the wrong arity.** Charitable reading: "pair" is illustrative and the argument of §1 covers any family. Withdrawn as a defect and folded into §1 as a correction.
6. **"A convex image cannot separate a non-convex class" is false.** It cannot be located in any declaration as quoted, so it is withdrawn at step 1. Both readings are recorded in §8.

## The falsifying object, and the search

- **For the substantive bold claim (§1):** a spectrum $\lambda$ and $\theta$ in $[-(n-1)\lambda_{\max},(n-1)\lvert\lambda_{\min}\rvert]$ for which no nonnegative $g$ on the atoms has $m_0=4(n-1)$, $m_1=-4\theta$. The two-atom witness excludes it for every $\lambda$, so no diagonal, padded, sphere-product or $\mathbb{CP}^m$ Weyl tensor can falsify it. The search is closed by the argument, not by examples. I checked the two $n=4$ self-dual examples ($\operatorname{diag}(s,0,-s)$, $\operatorname{diag}(2,-1,-1)t$) and the padded case by hand.
- **For "the only sources … single open door" (§6):** a constraint on $g$ drawn from the record's non-Jacobi data that is not implied by positivity and support and strictly sharpens the conclusion. **Found:** the L109 row cap at $n=4$, $W_+=\operatorname{diag}(1,0,-1)/\sqrt2$, $W_-=0$, giving $\theta\le\sqrt2$ against $3/\sqrt2$.
- **For "extension of F42" (§5):** the withdrawal note at fence-posts.md line 423 together with the strict gap above.

## Overall verdict: GAP

- The substantive reading of the bold claim is true, but Passage A carries no argument, leaves "pinned class" and "moment inequality" undefined, and states the arity as "pair". The label `Lemma` is not supported on file.
- Two sentences in the block are REFUTED AS STATED and must be struck or rewritten. The first is "a theorem-shaped extension of post F42" (a restriction of a withdrawn post). The second is "the only sources on the table are Jacobi and first Bianchi … the single open door" (the record's own L109 row cap, from (A) and $T\ge0$, sharpens the $g$-moment bound strictly at an admissible $n=4$ spectrum).
- The feasibility equivalence needs $\lVert W\rVert=1$ and $\theta\ge0$ stated. The Lean proves the feasibility interval and nothing that states Lemma L113. The L113.lean declarations are tautologies unrelated to it, and reachable_convex carries two unused hypotheses.
