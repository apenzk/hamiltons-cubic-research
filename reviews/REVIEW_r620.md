# REVIEW r620, Lemma L100, the $8\le n\le11$ dichotomy

**Verdict: GAP.** The implication is sound wherever $\alpha\le\tfrac13$ holds, and $8\le n\le11$ is precisely the range where the record has no proof of $\alpha\le\tfrac13$, the block's own machinery, [Lemma L21](../findings/route-a.md), places its stable range at $n\ge12$, and the fallback it displaces, Nienhaus 4.14(c), starts at $n\ge9$ and so misses the lower endpoint entirely. **"Unconditional" is therefore REFUTED**, and the two-sentence block carries no statement, no hypotheses, no proof and no pointer. Reviewer r620, cold brief; [REVIEW_r619.md](REVIEW_r619.md) unread, and the concurrent L55/L77/L6/L119/L95/L106 audits untouched.

| attack | outcome |
| --- | --- |
| "the same machinery" is identified | **REFUTED**, the phrase points backwards at [Observation L103](../findings/route-a.md); the machinery is [Lemma L20](../findings/route-a.md)'s proof, 22 lines *below* |
| the implication itself | **CONFIRMED**, it is L20's proof with the final contradiction step deleted, and that deletion is legitimate |
| "unconditional" | **REFUTED**, conditional on $\alpha\le\tfrac13$, unproved at every $n$ in the stated range |
| the range $8\le n\le11$ | **REFUTED as method-determined**, the upper end is the crossover, the lower end is Conjecture A's clause boundary and contradicts the method's own $n\ge9$ |
| first horn "$\max P\le\sqrt{3/2}$" | **CONFIRMED but forced to "$=$"**, and the two horns are mutually exclusive, so the disjunction is one implication in disguise |
| second horn's radius | **CONFIRMED non-vacuous**, $0.5748$ is $36.6\%$ of the maximum possible distance $\pi/2$ |
| the constant $0.5748$ | **CONFIRMED derived**, not measured: the root of $\sin^3\varphi=1-\cos\varphi$, rounded down |
| a proof exists on the record | **NO**, nowhere in [findings/](../findings/), [results.md](../results.md) or [ATTEMPTS.md](../ATTEMPTS.md); the nearest thing is a remark inside L20's discussion in [report/sections/90-appendix.tex](../report/sections/90-appendix.tex) |
| the label `Lemma` | **REFUTED as reasoned**, assigned by a bulk heading pass, [6cf9b1d2](REVIEW_r655.md#provenance), one commit after a commit that explicitly refused to assign labels |

---

## 1. What "the same machinery" is, and where the block sends the reader

The block sits at [route-a.md:41](../findings/route-a.md), and it has no pointers at all, the brief's question "do all pointers resolve" answers itself: there are none to resolve. So "the same machinery" can only be read positionally, and read positionally it is wrong. The block immediately above it is [Observation L103](../findings/route-a.md), the $W_1$ witness that kills Nienhaus's $f\le1$ premise and fixes $c_{12}=1.009216785$; above that is the Gate 2 summary of the tube lemma. Neither yields a dichotomy. The machinery that does is [Lemma L20](../findings/route-a.md)'s proof, which begins twenty-two lines *below* the block and runs to the $\square$.

The reason the phrase is broken is visible in provenance. In [report/sections/90-appendix.tex](../report/sections/90-appendix.tex) the same sentence appears inside the third remark following L20's proof, where "the same machinery" has L20's proof three paragraphs above it and resolves correctly. The lift into [findings/route-a.md](../findings/route-a.md) placed the remark *before* the proof it refers to and gave it a heading, severing the antecedent. **This is a lift that lost its referent, of the same species as the [Lemma L17](../findings/route-a.md) defect the brief flags, though not the same instance**, L17's problem is a proof living only in a notebook, L100's is a proof living twenty-two lines away with nothing saying so.

**L17 is not consumed here.** L17 is first-order protection at the rival maximizer, the one-sided derivative $d^+\delta^2(u;H)=-2aF(H)$ of the *penalized* functional of [Conjecture L16](../findings/problem.md). L100's machinery is the cubic expansion of $P$ itself around $u$, the eigenvalue cap $\alpha\le\tfrac13$, and the self-bootstrap $\gamma_V\le m$. They share the point $u=W_{\mathbb{CP}^2}$ and nothing else. So the brief's worst case (a result resting on L17's refuted formulation), **does not obtain**, and I record that as a clean negative.

## 2. The derivation, rebuilt from L20's ingredients

Fix $n$ and write $\theta^*=\sqrt{3/2}$, $u=$ padded $W_{\mathbb{CP}^2}$, $m=\sqrt{2/3}\,M(n)$ with $M(n)$ the global maximum of [conventions.md](../findings/conventions.md). The unit sphere of $\mathcal W_n$ is compact, so $m$ is attained at some $W^*$. Let $\varphi=d(W^*,SO(n)\cdot u)$ and suppose $\varphi\le0.5748$. Rotating so the nearest orbit point is $u$ and writing $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V\perp u$, $V\perp T_u(SO(n)\cdot u)$ (first variation at a nearest point), the cubic form expands exactly, with no linear term because $Q(u)=\theta^*u$ forces $T(u,u,V)=\theta^*\langle u,V\rangle=0$:

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V,\qquad\alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle,\ \ \gamma_V=\sqrt{\tfrac23}P(V).$$

With $\alpha\le\tfrac13$ and $\gamma_V\le m$ (the latter is the definition of a maximum over unit Weyl operators, and I confirm it is not circular, no value is presupposed), and using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$,

$$m\le\cos\varphi+m\sin^3\varphi\quad\Longrightarrow\quad m\le\psi(\varphi):=\frac{\cos\varphi}{1-\sin^3\varphi}.$$

$\psi\le1$ on $[0,\varphi_c]$ with $\varphi_c$ the root of $\psi=1$, i.e. of $\sin^3\varphi=1-\cos\varphi$; hence $m\le1$, i.e. $M(n)\le\theta^*$. **Contrapositive: if $M(n)>\theta^*$ then $\varphi>0.5748$ for every maximizer**, which is exactly the claimed dichotomy. So the implication is right, and it is right at every $n$ for which its two inputs hold, which is the point §4 turns on.

At $n\ge12$ the balanced sphere product supplies $\Theta_n>\theta^*$, killing the left branch and leaving the tube exclusion, that is L20. At $n\le11$ there is no such witness, and one is left with the disjunction. **The block's content is therefore exactly "L20's proof, stopped one step early", and that stopping is legitimate.**

## 3. The two horns, and what the "or" conceals

**The first horn is forced to an equality.** [conventions.md](../findings/conventions.md) records $M(n)\ge\sqrt{3/2}$ at every $n\ge4$, padded $W_{\mathbb{CP}^2}$ being the witness, padding commutes with $Q$ and preserves both norm and $\theta$, and $\Lambda^2U=\mathfrak{so}(U)$ closes under the bracket so the padded operator stays inside $\mathcal W_n$. So "$\max P\le\sqrt{3/2}$" is "$M(n)=\sqrt{3/2}$", and the max is over the whole unit sphere of $\mathcal W_n$ at the single $n$ in question, no criticality hypothesis, and the statement is four separate statements, one per $n$, rather than one uniform claim as the heading's "$8\le n\le11$ dichotomy" reads.

**The two horns are mutually exclusive, so the "or" is not two live alternatives.** If $M(n)=\sqrt{3/2}$ then padded $W_{\mathbb{CP}^2}$ is itself a maximizer at distance $0$ from the orbit, and the second horn is false. If every maximizer is farther than $0.5748$ then padded $W_{\mathbb{CP}^2}$ is not a maximizer, so $M(n)>\sqrt{3/2}$ and the first horn is false. **The block's whole content is the single implication $M(n)>\sqrt{3/2}\Rightarrow$ every maximizer is farther than $0.5748$**, and the dichotomy phrasing makes it look like a case split that has been carried out when no case has been decided.

**What that costs it.** The record's standing position is that the first horn is *true* throughout $8\le n\le11$: [problem.md](../findings/problem.md) calls Fox's $\mathcal S^4(\alpha)$ "the presumed global maximizer for $4\le n\le11$", and [route-a.md](../findings/route-a.md) itself says Nienhaus's a priori cap $P\le\theta^*$ is "available only while $W_{\mathbb{CP}^2}$ is the global maximizer, that is, only for $n\le11$". If that is right, the second horn is never reached and L100 asserts nothing about the actual geometry. Its real use is contrapositive and hypothetical: **any counterexample to the first horn, hence to Conjecture A's second clause, must live outside the tube.** That is a constraint on where a refutation could be found, not a step toward a proof. Neither the block nor the report says this.

**The radius is not vacuous, and the diameter argument settles the brief's question.** $\mathcal W_n$ is $SO(n)$-irreducible for $n\ge5$, so it carries no invariant vector and $\int_{SO(n)}\langle W,gu\rangle\,dg=0$ for every $W$; hence $\max_g\langle W,gu\rangle\ge0$ and **the distance from any unit $W$ to the orbit is at most $\pi/2$**. So the maximum possible value is $\pi/2\approx1.5708$ and $0.5748$ is $36.6\%$ of it: the tube is a proper piece of the available range, not a near-diameter ball. In correlation terms the excluded set is $\langle W^*,u\rangle\ge\cos(0.5748)=0.8393$. Measure is a different matter and the file already says so ($\sim10^{-424}$ of the sphere at $n=12$) but that is a dimension effect, and the fraction-of-diameter reading is the one that decides vacuity.

The metric is the geodesic (angular) one, as [Lemma L20](../findings/route-a.md)'s audit fixed; the chord reading gives $0.5830$, where $\psi>1$ and the argument does not reach its own radius. **L100 inherits that ambiguity without repeating the resolution**, since it states the constant and cites nothing.

## 4. The gap: $\alpha\le\tfrac13$ is unproved on exactly this range

This is the finding.

The step $\alpha\le\tfrac13$ is the only unproved input of L20 and the only unproved input here. The record supports it two ways, and **both miss $8\le n\le11$**:

| support | range it covers | covers $8\le n\le11$? |
| --- | --- | --- |
| Nienhaus Theorem 4.14(c), as cited in [L20's proof](../findings/route-a.md) | $n\ge9$, and only on multiplicity-free isotypic components, a hypothesis [route-a.md](../findings/route-a.md) itself calls "unverified" | misses $n=8$ outright |
| [Lemma L21](../findings/route-a.md)'s $SO(n-4)$-isotypic argument | "the stable range once $n-4\ge8$", i.e. $n\ge12$; spectra tabulated at $n=10,12,14$ | misses all four |

So at $n=8$ **neither** support applies, and the block gives $n=8$ no sentence, it is the range's stated lower endpoint and its least defended point. At $n=9,11$ the only support is 4.14(c) under a hypothesis the record has flagged and not checked at those dimensions. At $n=10$ there is a tabulated column, which is a check outside the claimed stable range rather than a proof.

**And the failure at $n=8$ is structural, not bookkeeping.** L21 decomposes $\mathcal W_n$ under $G=SO(n-4)$ into the types trivial, vector, $\Lambda^2$, $S^2_0$ and "two higher types", the argument being that the types occurring lie in $\bigotimes^k\mathbb R^{n-4}$ for $k\le4$ and the multiplicity spaces $M_\lambda$ are then $n$-independent. That is a stable-range statement and it needs $n-4\ge2k=8$. At $n=8$ we have $G=SO(4)$, where $\Lambda^2\mathbb R^4=\Lambda^2_+\oplus\Lambda^2_-$ is **reducible**, so the row labelled $\Lambda^2$ is not one isotypic component and its multiplicity space is not the tabulated $M_\lambda$ of dimension $6$. At $n=9,10,11$ the ambient $SO(5),SO(6),SO(7)$ carry the Hodge identifications $\Lambda^4\cong\Lambda^1$, $\Lambda^3$ splitting, $\Lambda^4\cong\Lambda^3$, which merge types the table keeps apart. **Every dimension L100 claims sits outside its machinery's own stable range, and the endpoint sits outside both supports.**

This is also where the brief's triality question lands. [conventions.md](../findings/conventions.md) already records the rule, "Cartan's classification classifies involutions up to $\mathrm{Aut}(\mathfrak g)$, and an argument consuming $SO(n)$-conjugacy differs from it at $n=8$". L100's machinery does **not** consume Cartan's classification: the $SO(n)$-invariance of $P$ used to rotate the nearest orbit point to $u$ is elementary equivariance, and the stabilizer count checks out at $n=8$ ($\dim SO(8)-\dim(U(2)\times SO(4))=28-10=18=4n-14$). So $n=8$ is not broken by triality. It is broken by the $SO(4)$ reducibility above, which is a different and more elementary degeneracy, and the block needed its own sentence either way and has none.

**Therefore "unconditional" is false.** The word is doing the work of naming the hypotheses the sentence does not name. L20 earns it by having its one open input flagged elsewhere in the file and by a range where that input is at least tabulated; L100 has neither.

## 5. The constant $0.5748$, derived, and the one place the record's arithmetic slips

Provenance, traced by grep across [findings/](../findings/), [results.md](../results.md), [LEDGER.md](../findings/LEDGER.md), [INDEX-values.md](../findings/INDEX-values.md) and [report/](../report/), and by `git log -S`: the number enters the repository in commit [ca236478](REVIEW_r655.md#provenance), the commit that proves L20, and everywhere it appears it is the same object, $\varphi_c=0.574826297515555$, the root of $\sin^3\varphi=1-\cos\varphi$, i.e. the first point where $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$ reaches $1$, **rounded down to four places**. [INDEX-values.md](../findings/INDEX-values.md) lists it under recurring numbers that are not a $\theta$.

**So it is derived, not measured**, and the rounding is in the safe direction: the hypothesis $\varphi\le0.5748$ is strictly inside the region where $\psi\le1$. On the brief's `Observation`-versus-`Lemma` test the constant passes, its support is a transcendental root, not a numerical optimisation. What fails that test is the *input* $\alpha\le\tfrac13$, per §4, and that is a different objection.

**Screen** (seconds of arithmetic on objects I constructed for the purpose, reported as a screen and not as evidence for a positive claim): bisection on $\sin^3\varphi-(1-\cos\varphi)$ returns $0.5748262975155556$, matching the record's digits; $\psi$ on $[0,\varphi_c]$ has maximum $1$ attained only at the endpoint, and $\psi(0.5748)=0.99999372$. The interior minimum comes out as $0.97859$ at $\varphi=0.37479$, against [route-a.md](../findings/route-a.md)'s "falls to $0.9787$ near $\varphi=0.3927$", **the location is off by $0.018$ and looks like $\pi/8$ substituted for the true argmin**. Immaterial to either L20 or L100, since only $\psi\le1$ is used, but it is in the same sentence L100 depends on and should be corrected when the block is.

**The radius has no margin in $\alpha$.** L20's audit records $\varphi_c\approx\tfrac32-3a$ under $\alpha\le a$, so $0.5748$ needs the exact $\tfrac13$ while the qualitative dichotomy survives for any $a<\tfrac12$. Given §4, **the honest form of L100 at $8\le n\le11$ is the qualitative one with an unspecified positive radius**, which needs only $\alpha<\tfrac12$, a materially weaker input that might be provable at $n=8$ where $\tfrac13$ is not. That is the cheapest repair available and the record does not state it.

## 6. Scope, and what it gives Conjecture A's second clause

Conjecture A's second clause, as [problem.md](../findings/problem.md) states it, covers $8\le n\le11$ with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed, and it carries live content, at $n=10$, $\theta_0(10)^2=36/25<3/2$.

- **What L100 contributes.** One structural exclusion: there is no intermediate regime in which a maximizer beats $\sqrt{3/2}$ while sitting near the $\mathbb{CP}^2$ orbit. A counterexample to the clause, if one exists, is a definite distance away from the orbit it excepts. Combined with §3's exclusivity this is the whole of it.
- **What it does not contribute.** No upper bound on $M(n)$, no progress on the clause itself, and nothing at critical points off the orbit, which is where the clause lives. The clause is about the max over the complement of the orbit; L100 never bounds anything over that complement. **The clause implies L100** (any maximizer is critical; off the orbit the clause caps it at $\Theta_n<\sqrt{3/2}\le M(n)$, so every maximizer is on the orbit and the first horn holds), **and L100 does not touch the clause.** The block calls it "a bonus", which is right about its weight and wrong about its direction: it is downstream of the clause, not partial progress on it.
- **The upper end of the range is method-correct.** At $n\ge12$ the same implication holds and is strictly weaker than L20, since the first horn is then refuted by $\Theta_n>\sqrt{3/2}$. So $n\le11$ marks where the statement stops being subsumed, bounded by the crossover $6+2\sqrt7\approx11.2915$, as claimed, at both parities ($\Theta_{11}=1.21716<\sqrt{3/2}$).
- **The lower end is an artefact.** Nothing in the derivation stops at $n=8$; the derivation stops at $n\ge9$, where 4.14(c) starts. $8$ is copied from Conjecture A's clause boundary. So the range is the conjecture's, imposed on a method whose range is different, and the two disagree at the endpoint the block never mentions.

## 7. Is it a `Lemma`, and does a proof exist anywhere?

**No statement, no hypotheses, no proof, no pointer.** The block is a heading and one sentence of body. The heading carries the statement, which is the pattern L20's audit already flagged in this file. Searching the record: `L100` occurs in exactly two places, this heading and its row in [INDEX-results.md](../findings/INDEX-results.md), whose Gate 2 column reads "no verdict on the record". [results.md](../results.md) does not carry it, [ATTEMPTS.md](../ATTEMPTS.md) does not carry it, so the brief's specific trap, a numbered result whose argument lives in the notebook, **does not apply**; there is no argument anywhere at all. The nearest thing on the record is the remark in [report/sections/90-appendix.tex](../report/sections/90-appendix.tex), which is the same two sentences in LaTeX, correctly positioned after L20's proof and correctly *unnumbered*.

<a id="provenance"></a>**Provenance, checked against `git log` rather than assumed.** The sentence enters in `ca236478` ("feat(conjecture-a): prove no maximizer lies near the CP^2 orbit for n >= 12") as prose inside L20's discussion. `c349d5b3` registers it in the index as one of "the 29 result-shaped facts that have no number", and its own message states the reason for withholding a label: *"listed rather than numbered because a number carries a literal label (Lemma asserts Gate 2 passed) and assigning 29 labels in one pass would put unchecked proof status on the record."* The very next relevant commit, `6cf9b1d2` ("docs(route-a): place headings for results 100-103"), assigns the headings anyway, its message noting only that *"102 and 103 are Observations, matching their numerical support"*, **so 100 and 101 received `Lemma` by default, with no recorded reason, one commit after a commit that had refused to do exactly that.** `fe85b5bd` later prefixed the id. The block has never been derived under its own heading.

**On the label itself**, the constant is analytic (§5) so the `Observation` demotion the brief describes is not the right correction. The right correction is that a `Lemma` in this record asserts Gate 2 passed, and this one had no verdict until now.

## What is owed, and whether it is reachable

Reachable, and cheap, none of it needs computation.

1. **Name the machinery and point at it.** One clause: "by [Lemma L20](../findings/route-a.md)'s argument with the final contradiction step omitted". This also fixes the position problem, or the block moves below L20.
2. **State the hypotheses.** $\alpha\le\tfrac13$ at the $n$ in question, and delete "unconditional". Say which support covers which $n$, per §4's table.
3. **Give $n=8$ its own sentence, or drop it from the range.** As written the range's endpoint has no support for its only unproved input, and the failure is the reducibility of $\Lambda^2\mathbb R^4$ under $SO(4)$, which is nameable.
4. **State the content as the single implication**, since the horns are exclusive and the first is an equality, and say that the clause implies the block rather than the reverse.
5. **Record the qualitative fallback**: any $\alpha<\tfrac12$ gives a positive radius, which is the form most likely to survive at $n=8$.
6. Correct the argmin of $\psi$ to $\approx0.3748$ where the block's machinery is stated.

Items 1–5 are writing; item 3 is the only one that could turn into mathematics, and only if someone wants the exact $\tfrac13$ at $n=8$ rather than the qualitative radius. **A run that diagonalised $F_u$ exactly at $n=8,9,11$ would decide it**: eigenvalues $\le\tfrac13\theta^*$ on $(\mathbb Ru\oplus T_u\mathcal O)^\perp$ would close the gap and make the range genuine; anything above would refute the block at that $n$ while leaving L20 untouched. **That run is not made here and is not authorised**, recorded so the item stays on the list with the block against it.
