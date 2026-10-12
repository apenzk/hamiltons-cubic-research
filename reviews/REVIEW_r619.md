# REVIEW r619, Lemma L100, the $8\le n\le11$ dichotomy

**Verdict: GAP.** The dichotomy is true and re-derives in three lines for every $n$ at which $\alpha\le\tfrac13$ is available, but the record makes that input available only from $n\ge9$, so **the block's lower endpoint $n=8$ is unsupported**, and both of its hedges are false as read: "the same machinery" points at the wrong neighbour in the current file order, and "unconditional" hides the one hypothesis the statement has. Reviewer r619, cold brief, the concurrent r620 unread.

| attack | outcome |
| --- | --- |
| the analytic argument (expansion, $\alpha\le\tfrac13$, bootstrap, $\psi\le1$) | **CONFIRMED**, re-derived from the definitions; the dichotomy is [Lemma L20](../findings/route-a.md)'s proof with its last step deleted |
| "the same machinery" resolves | **REFUTED as written**, the nearest antecedent is [Observation L103](../findings/route-a.md), which yields nothing of the kind; the machinery is $40$ lines **below** the block |
| does it consume [Lemma L17](../findings/route-a.md)? | **NO**, disjoint inputs; L17's `REFUTED AS STATED` verdict does not reach here |
| "unconditional" | **REFUTED**, conditional on $\alpha\le\tfrac13$, whose two routes both start at $n\ge9$ |
| the first horn | **forced to "="**, $M(n)\ge\sqrt{3/2}$ by padding, so horn 1 reads $M(n)=\sqrt{3/2}$ |
| the second horn's metric | **geodesic angular distance**, diameter $\pi$; $0.5748$ is $18.3\%$ of it, **not vacuous** |
| the constant $0.5748$ | **DERIVED, not measured**, the root of $\sin^3\varphi=1-\cos\varphi$; screened at $0.5748262975155302$ |
| the range $8\le n\le11$ | **lower endpoint unsupported**; upper endpoint is presentational, not a limit of the method |
| statement, hypotheses and proof on the record | statement in the heading, proof in [Lemma L20](../findings/route-a.md)'s block and at [report/sections/90-appendix.tex:315](../report/sections/90-appendix.tex#L315); **hypotheses nowhere** |
| pointers | **the block has none**, zero links in its two sentences; and nothing on the record cites L100 |

Screening only (seconds, on objects built for the purpose): the root of $\sin^3\varphi=1-\cos\varphi$, $\psi$ on $[0,\varphi_c]$, $\theta_0$ and $\Theta_n$ at $n=8,\dots,12$, and the branching dimension identity at $m=4,5$. No search, sweep or census was run; the analysis-only rule is inherited and honoured.

---

## 1. What "the same machinery" is, and why the phrase fails in place

The machinery is the proof of [Lemma L20](../findings/route-a.md) (the tube bootstrap), **with its final contradiction step removed**. That is not what the phrase points at.

- In [route-a.md](../findings/route-a.md) the block is at line 41. What precedes it is [Observation L103](../findings/route-a.md), the witness $W_1$ killing Theorem 4.17's $f\le1$ premise, and above that the Gate 2 corrections list. **None of that yields a dichotomy**: L103 is about the sharp replacement constant $c_{12}$ in Nienhaus's argument, not about the location of maximizers. Read in file order, the phrase resolves to the wrong result.
- The proof that does yield it sits **below**, at [route-a.md](../findings/route-a.md)'s L20 block.
- **Provenance, checked rather than assumed.** The sentence was born in `ca236478` (2026-08-20, *"prove no maximizer lies near the CP^2 orbit for n >= 12"*) as an unheaded aside, $60$ lines **after** the then-Lemma-18 proof, so the phrase resolved backwards correctly at birth. The 2026-08-24 split (`51ab61f8`) reordered the file, `c349d5b3` registered the fact as one of "the 29 result-shaped facts that have no number", and `6cf9b1d2` (*"place headings for results 100-103"*) put the `Lemma L100` heading on two sentences of prose without adding a word to them. **The referent broke in the split and no commit since has repaired it.**
- The referent is nonetheless pinned externally: [report/sections/90-appendix.tex:315](../report/sections/90-appendix.tex#L315) carries the identical sentence as a remark immediately after Lemma 20's proof. So the intent is not in doubt; only the pointer is.

**Does it consume [Lemma L17](../findings/route-a.md)?** No. The inputs are, in order of use: compactness of the unit sphere of $\mathcal W_n$; $SO(n)$-invariance of $P$; total symmetry of the polarisation $T(X,Y,Z)=\langle X,Y\circ Z\rangle$; criticality $Q(u)=\theta^*u$ at the padded competitor; $\alpha\le\tfrac13$; and $\gamma_V\le m$. L17 is a statement about the one-sided first derivative of the **penalised** functional $\Phi=P-\kappa_n\delta^2$ and feeds [Conjecture L16](../findings/problem.md) and [Lemma L134](../findings/route-a.md); it appears nowhere in this chain, and $\delta^2$ appears nowhere in it either. **The refuted-neighbour hazard the brief names does not materialise through L17.** It materialises through [Lemma L21](../findings/route-a.md) instead, see §4.

## 2. The derivation, cold

Write $\theta^*=\sqrt{3/2}=P(u)$ at $u=W_{\mathbb{CP}^2}$ padded into $\mathbb R^n$, which is critical with $Q(u)=\theta^*u$ at every $n\ge4$ ([problem.md](../findings/problem.md), item 4 of the competitor census). Let $m=\sqrt{2/3}\,M(n)$, attained at $W^*$ by compactness, and suppose $\varphi:=d(W^*,SO(n)\cdot u)\le0.5748$.

Rotate the nearest orbit point to $u$ and write $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $\lVert V\rVert=1$, $V\perp u$. The first-variation condition at a nearest point gives $\langle W^*,X\rangle=0$ for $X\in T_u(SO(n)\cdot u)$; since the orbit lies in the unit sphere, $u\perp T_u(SO(n)\cdot u)$, so for $\varphi\ne0$ this is $V\perp T_u(SO(n)\cdot u)$. With $T$ the symmetric polarisation, $P(x)=T(x,x,x)$ and

$$P(W^*)=\cos^3\varphi\,\theta^*+3\cos^2\varphi\sin\varphi\,T(u,u,V)+3\cos\varphi\sin^2\varphi\,\langle F_uV,V\rangle+\sin^3\varphi\,P(V),$$

with $F_u=u\circ(\cdot)$. The linear term dies because $T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$. Multiplying by $\sqrt{2/3}$ and putting $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$, $\gamma_V=\sqrt{2/3}P(V)$,

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V.$$

Both substitutions are made against **nonnegative** coefficients on $[0,\pi/2]$, which is what makes them legitimate: $\alpha\le\tfrac13$ because $V$ lies in $u^\perp\cap T_u(SO(n)\cdot u)^\perp$ where $\lambda_{\max}(F_u)=\tfrac13\theta^*$, and $\gamma_V\le m$ because $V$ is itself a unit Weyl operator. Using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$ and $1-\sin^3\varphi>0$ for $\varphi<\pi/2$,

$$m\le\cos\varphi+m\sin^3\varphi\quad\Longrightarrow\quad m\le\psi(\varphi)=\frac{\cos\varphi}{1-\sin^3\varphi}\le1\ \text{ on }[0,0.5748],$$

hence $M(n)=\sqrt{3/2}\,m\le\sqrt{3/2}$. The branch $\varphi=0$ puts $W^*$ on the orbit and gives the same conclusion directly. **So: if any maximizer lies within $0.5748$ of the orbit then $M(n)\le\sqrt{3/2}$**, which is the dichotomy, contrapositive. $\square$

**Dimension enters at exactly one place: $\alpha\le\tfrac13$.** Every other step is dimension-free. This is the whole of the scope question and §4 is about nothing else.

## 3. The two horns, separately

### Horn 1 is an equality, and that is what makes the dichotomy thin

The maximum is over the unit sphere of $\mathcal W_n$ at the $n$ in question, and it is $M(n)$ in [conventions.md](../findings/conventions.md)'s sense, the **global** maximum, distinct from the diagonal maximum $\Theta_n$ that [W5](../findings/INDEX-traps.md) warns is repeatedly read for it. Padding gives $M(n)\ge\sqrt{3/2}$ at every $n\ge5$, so

> **horn 1 $\iff$ $M(n)=\sqrt{3/2}$, i.e. the padded $\mathbb{CP}^2$ competitor is a global maximizer.**

Two consequences the block does not state.

- **The two horns are mutually exclusive, not merely alternative.** Under horn 1 the orbit points are themselves maximizers at distance $0$, so horn 2 is false. The dichotomy is therefore exactly the single conditional *"$M(n)>\sqrt{3/2}\Rightarrow$ every maximizer is farther than $0.5748$ from the orbit"*, the "either/or" phrasing makes it sound like a case split with two live branches when it is one implication.
- **It reads stronger than it is.** "$\max P\le\sqrt{3/2}$" invites reading as a *bound obtained*; it is not, since the reverse inequality is free. Nothing is bounded in horn 1 that padding did not already give; what horn 1 asserts is *attainment*, and attainment at the competitor is precisely the open content of Conjecture A below the crossover.

### Horn 2: the metric, and how far $0.5748$ is from vacuous

The metric is **geodesic angular distance in the unit sphere of $\mathcal W_n$**, in the record's inner product ($\tfrac12\operatorname{tr}$ at the $\Lambda^2$ level, [conventions.md](../findings/conventions.md)), with distance to the orbit the minimum over the orbit. This is not stated in the block, and it is load-bearing: the parametrisation $W^*=\cos\varphi\,u+\sin\varphi\,V$ *is* the geodesic one, and [r485](REVIEW_r485.md) records that under the chord reading the same number is angle $0.5830$, where $\psi=1.00201>1$ and the argument does not reach its own radius. [Lemma L20](../findings/route-a.md)'s block already carries this correction; **L100 inherits neither the correction nor the warning.**

Maximum possible value: $\pi$. It is attained, $-u$ is a unit Weyl operator with $d(-u,g\cdot u)=\pi-\arccos\langle u,g\cdot u\rangle\ge\pi-0$, minimised at $g=e$ to give $\pi$ exactly, and $-u$ is off the orbit since $P(-u)=-\theta^*$. So

$$\frac{0.5748}{\pi}=18.3\%,\qquad \frac{0.5748}{\pi/2}=36.6\%\ \text{of the orthogonality radius}.$$

**Not vacuous by the diameter test.** The honest smallness is the one [Lemma L20](../findings/route-a.md)'s block already prints for itself: the tube is $\sim10^{-424}$ of the sphere at $n=12$.

## 4. Scope, the lower endpoint is the defect

$\alpha\le\tfrac13$ is the sole dimension-sensitive input, and the record offers exactly two routes to it. **Both begin at $n\ge9$.**

| route | stated validity | what it covers at $8\le n\le11$ |
| --- | --- | --- |
| Nienhaus Theorem 4.14(c), cited in [Lemma L20](../findings/route-a.md)'s proof | *"valid for $n\ge9$"*, and its Lemma 4.13 needs multiplicity-free isotypic components, which the record calls unverified | $9,10,11$, conditionally |
| [Lemma L21](../findings/route-a.md), the $SO(n-4)$-equivariant four-block computation | per [r487](REVIEW_r487.md): every partition has $\ell(\nu)\le2$, so Littlewood restriction needs $m\ge4$ and $SO(m)$-irreducibility $m\ge5$, **"valid for every $n\ge9$"** | $9,10,11$ |

At $n=8$, $m=n-4=4$ and the second route's own threshold is missed by one. The failure is not bookkeeping: $\mathfrak{so}(4)$ is not simple and $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, so three of the five types in L21's table stop being $SO(m)$-irreducible and the isotypic decomposition refines. Schur still applies to the refinement, but **the four fixed matrices $F_\lambda$ are what carry the eigenvalue $\tfrac13$, and their $m$-independence down to $m=4$ is exactly what is not proved**, the record's tables have columns at $n=10,12,14$ only, and [route-a.md](../findings/route-a.md) names the $m$-independence of the $F_\lambda$ as the standing obligation.

*Screened, since it is a positive-sounding point I would otherwise have to leave unqualified:* the branching dimension identity $20+20m+6\binom m2+10\big(\tfrac{m(m+1)}2-1\big)+4\big(\tfrac{m(m^2-1)}3-m\big)+\tfrac{m(m+1)(m+2)(m-3)}{12}=\dim\mathrm{Weyl}_{m+4}$ closes at $m=4$ ($226+74=300$) and $m=5$ ($320+175=495$) as it does at $m=8$. So the **dimensions** survive at the endpoint; the **irreducibility** and the entries of $F_\lambda$ do not follow from that.

What $n=8$ actually has is one floating-point datum: $\lVert\Pi_E-\Pi_T\rVert_2\le1.4\times10^{-14}$ at $n=8,10,12,14$, from which [route-a.md](../findings/route-a.md) reads off that the complement's top eigenvalue is $\tfrac13\theta^*$. The exact finite-field result at $n=6,8,10$ is $\ker(6F_u-3\theta^*)=T_u(SO(n)\cdot u)$, it certifies that $\tfrac12\theta^*$ is **not** an eigenvalue on the complement, which does not by itself exclude an eigenvalue in $(\tfrac13\theta^*,\tfrac12\theta^*)$ and so does not deliver $\alpha\le\tfrac13$, nor even $\alpha<\tfrac12$.

**So the honest range of the block, on the record as it stands, is $9\le n\le11$.** Whether $n=8$ can be added is a question a computation would settle and this review may not open:

> **Blocked for computation, stated and stopped.** An exact rational diagonalisation of $F_u$ at $n=8$ restricted to $u^\perp\cap T_u(SO(n)\cdot u)^\perp$, rank certificates $\dim\ker(F_u-r\theta^*)$ over $\mathbb Q$, no eigenvectors, no floating point, decides the endpoint. $\lambda_{\max}=\tfrac13\theta^*$ adds $n=8$ with the constant $0.5748$ intact. $\lambda_{\max}=a\theta^*$ with $\tfrac13<a<\tfrac12$ keeps the *qualitative* dichotomy at $n=8$ at the smaller radius $\varphi_c(a)\approx\tfrac32-3a$ ([Lemma L20](../findings/route-a.md)'s own hedge) and refutes the constant there. $a\ge\tfrac12$ removes $n=8$ altogether. **I have not run it.**

**The upper endpoint is presentational, not a limit of the method.** The derivation of §2 never uses $n\le11$: it holds at every $n\ge9$. What changes at the crossover $n=6+2\sqrt7=11.2915$ is only that horn 1 becomes refutable, $\Theta_{12}=1.236033>\sqrt{3/2}=1.224745$, so above it the disjunction collapses to horn 2 and is called [Lemma L20](../findings/route-a.md). **The range is bounded above by the crossover in the sense that matters (it is where horn 1 stops surviving) and below by an artefact of the method that the block got wrong by one dimension.**

**Cartan and triality are not an input here** and the brief's $n=8$ hazard arrives by a different door. [conventions.md](../findings/conventions.md)'s warning, Cartan classifies up to $\mathrm{Aut}(\mathfrak g)$, which differs from $SO(n)$-conjugacy at $n=8$, governs the isotropy and symmetric-space arguments. This chain consumes $SO(n-4)$-equivariance and a Rayleigh quotient, no classification at all. The $n=8$ degeneration is $m=4$, in the *complementary* factor.

### What it contributes to Conjecture A's second clause: close to nothing

The second clause covers $8\le n\le11$ with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed, and it is a **critical-point** statement, [ATTEMPTS.md](../ATTEMPTS.md) holds the conjecture verbatim, *"Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P$ among $\mathrm{Weyl}^1_n$. If either $n\ge12$ or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$"*, so it reads: every critical point off the orbit has $P\le\Theta_n$. **This is why the clause is not trivially false by continuity**: it quantifies over critical points, and points just off the orbit carry $P$ just under $\sqrt{3/2}>\Theta_n$ without being critical.

- **The clause implies L100, not the reverse.** If the clause holds then every off-orbit critical point sits at $\le\Theta_n<\sqrt{3/2}$, the maximum is attained at a critical point, so $M(n)=\sqrt{3/2}$ and horn 1 holds. L100 is a **necessary condition** for the clause and is therefore satisfied vacuously by it.
- **It misses the clause's live interval entirely.** A counterexample to the clause is an off-orbit critical point with $P\in(\Theta_n,\sqrt{3/2}]$, the interval where a violation is plausible, since it contains the competitor's own value, and $\Theta_n<\sqrt{3/2}$ by margins of $0.079$ at $n=8$ down to $0.0076$ at $n=11$. Such a point is **not a maximizer** in horn 1, so L100 says nothing whatever about it.
- **What it does contribute:** if the clause fails so badly that the failure lifts the *global* maximum above $\sqrt{3/2}$, the offending maximizer is confined outside the tube. That is a real statement and a narrow one.
- **It does not clear the punctured tube.** Under horn 1, a second maximizer at distance $0.3$ from the orbit with $P=\sqrt{3/2}$ is not excluded by anything here, the argument yields a contradiction only from the *value*, and in horn 1 there is no contradiction to draw.

## 5. The constant, and the label

**$0.5748$ is derived.** It is $\varphi_c$, the point where the method's own bound $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$ returns to $1$; setting $\psi=1$ gives $\sin^3\varphi=1-\cos\varphi$, a transcendental equation in one variable whose relevant root I screened at $0.5748262975155302$, matching the record's $\varphi_c=0.574826297515555$ to twelve digits. The block's $0.5748$ is that truncated **downwards**, which is the safe direction: $\psi(0.5748)=0.9999937<1$. So the four decimals are a rounded root of a derived equation, **not** the output of an optimisation, and the "$\to$ Observation" rule the brief raises is not triggered by the constant.

*One inherited discrepancy, minor and non-load-bearing:* [route-a.md](../findings/route-a.md) and [report/sections/90-appendix.tex:308](../report/sections/90-appendix.tex#L308) put $\psi$'s dip at *"$0.9787$ near $\varphi\approx0.3927$"* while correction 3 of the same file says *"near $\varphi\approx0.33$"*. Screened: the minimum is $0.978593$ at $\varphi=0.3747$; $\psi(0.3927)=0.978730$ and $\psi(0.33)=0.979366$. All three roundings are $\approx0.9787$–$0.9794$ and nothing depends on the location, but the two stated positions disagree with each other and both miss the argmin.

**What does trigger the label question is the input, not the constant.** $\alpha\le\tfrac13$ ends in four $F_\lambda$ spectra verified in floating point at $n=10,12,14$ (no column at $8$, $9$ or $11$), with [Lemma L21](../findings/route-a.md) itself audited only `PLAUSIBLE`. By the record's literal labels, `Lemma` asserts a Gate 2 pass, and [INDEX-results.md](../findings/INDEX-results.md) row 100 reads *"Gate 2: no verdict on the record."* **This review is that verdict, and it does not support the label at $n=8$.**

## 6. Is it a Lemma at all, statement, hypotheses, proof

- **Statement: yes, and only in the heading.** The heading is a complete assertion; the two-sentence body restates it verbatim and adds "a bonus", "the same machinery" and "unconditional".
- **Hypotheses: nowhere.** Not in the block, not in [INDEX-results.md](../findings/INDEX-results.md)'s row, not in the report's remark. The one real hypothesis ($\alpha\le\tfrac13$, hence a dimension floor), is absent from all three, which is how the range came to start at $8$.
- **Proof: on the record, in [findings/](../findings/), and in the wrong place.** It is [Lemma L20](../findings/route-a.md)'s proof minus the closing contradiction, $40$ lines below, and the same argument is at [report/sections/90-appendix.tex:299](../report/sections/90-appendix.tex#L299). Unlike its sibling [Lemma L17](../findings/route-a.md), **the argument does not live only in [ATTEMPTS.md](../ATTEMPTS.md)**, that notebook carries neither the sentence nor the constant. The defect here is the *unpointed* proof, not an out-of-record one.
- **Pointers: zero.** The block contains no markdown link of any kind, so a reader has no route from the claim to its argument.
- **Consumers: zero.** `L100` occurs on the record only at [route-a.md](../findings/route-a.md) line 41 and [INDEX-results.md](../findings/INDEX-results.md) row 100. Nothing rests on it, so the endpoint defect has no downstream spread.

## 7. The hedges, tested

| hedge | what it conceals |
| --- | --- |
| *"the same machinery"* | a pointer that no longer resolves, the nearest antecedent in file order is [Observation L103](../findings/route-a.md), which yields no dichotomy; the real machinery is below the block |
| *"a bonus"* | that horn 1 is forced to an equality by padding, so the "bonus" is one implication with a scenario-dependent antecedent, not a case split |
| *"unconditional"* | $\alpha\le\tfrac13$, the sole hypothesis, whose two routes both start at $n\ge9$; the word is earned only in the narrow sense [Lemma L20](../findings/route-a.md) earns it, that no a priori cap and no instance of Conjecture A is assumed |
| *"$8\le n\le11$"* | that $n=8$ has floating-point support and no proof, and that $n\le11$ is where horn 1 survives rather than where the method stops |

**And the file's other statement about this range is over-stated.** [Lemma L20](../findings/route-a.md)'s own paragraph, repeated at [report/sections/90-appendix.tex:315](../report/sections/90-appendix.tex#L315), reads *"Run at $n=10$ the argument has no contradiction to draw and simply returns $\max P\le\sqrt{3/2}$, the correct answer there."* Two errors in one sentence: the argument returns that conclusion only **under the supposition** $\varphi\le0.5748$, and unconditionally it returns the disjunction; and *"the correct answer there"* asserts $M(10)=\sqrt{3/2}$, which is the open ambient content of Conjecture A's second clause, presented as settled. The record's own list of what is missing does not include it, and [conventions.md](../findings/conventions.md) proves $M=\sqrt{3/2}$ only at $n=4$ and $n=6$.

## 8. What is owed, and whether it is reachable

1. **Correct the range to $9\le n\le11$**, or write the $n=8$ sentence. Reachable, the computation named in §4 is a fixed rational eigenvalue problem in one dimension, and the block already has the hedge that rescues the qualitative claim for any $a<\tfrac12$.
2. **State the hypothesis in the block**: $\alpha\le\tfrac13$ via [Lemma L21](../findings/route-a.md), with L21's own status carried across. One sentence.
3. **Point at the proof**, and say it is [Lemma L20](../findings/route-a.md)'s minus the contradiction. One link, and it retires "the same machinery" entirely.
4. **Name the metric** as geodesic angular distance and inherit [r485](REVIEW_r485.md)'s chord warning. One clause.
5. **Say horn 1 is an equality.** Free, and it is what stops the statement being read as a bound.
6. **Drop "unconditional", or qualify it** the way L20's block now qualifies its own.

None of the six needs new mathematics; item 1 needs one exact computation this review is not authorised to run.
