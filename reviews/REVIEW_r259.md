# REVIEW r259, Gate 2, the diagram-realisation theorem

Reviewer 259. Commits under review: `b6ecd9d` (primary), `cb964bc`, `12b1bec`.
Primary file: [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py). Supporting: [findings/brauer-pairing.md](../findings/brauer-pairing.md) final section, [rui-brauer-semisimplicity/notes.md](../references/rui-brauer-semisimplicity/notes.md), [lehrer-zhang-sft-orthogonal/notes.md](../references/lehrer-zhang-sft-orthogonal/notes.md), [run_b_dependency_audit.py](../scripts/runs/run_b_dependency_audit.py), [plan.md](../plan.md) section 2 item 1.
Scripts: [scripts/reviewers/r259/](../scripts/reviewers/r259/). Reviewer 260 runs the identical brief concurrently and independently.

Every number below comes from a code path that shares nothing with the reviewed script. $\dim\nu(B_f(n))$ is computed as the rank of the **diagram Gram matrix** $[\,n^{c(D\cup D')}\,]$, whose size does not depend on $n$, so $f=5$ is reachable where the dense $n^f\times n^f$ route is not, and semisimplicity of $B_f(n)$ is tested by **Dickson's criterion** on the regular trace form, which decides the inequality directly instead of through a consequence of it. Ranks are taken modulo two 31-bit primes.

| # | Claim | Verdict |
|---|---|---|
| 1 | The leg count, and which algebra acts | **NOT INCONSISTENT, AND THE TABLE IS A CATEGORY ERROR.** $f=12$ governs the algebra acting on $V^{\otimes12}$; $r=6$ governs the *invariant functionals* on $V^{\otimes12}$, the $\lambda=\varnothing$ block alone. Different objects, both right. But the findings table sets their "slack" side by side, and applied to the algebra the theorem actually uses Lehrer–Zhang reads $r=12\le n$, **zero** slack, tighter than Rui's. For a covariant into a block of label $\lambda$ the honest count is $r=6+|\lambda|/2$, running to $12$ |
| 2 | Rui's criterion as quoted | **CONFIRMED, inequality, direction and sharpness.** Andersen–Stroppel–Tubbenhauer Theorem 7.1(3) states it as $d\le\delta_0+1$ for $\delta_0=\lvert\delta\rvert\ne0$ in characteristic zero, which is $n\ge f-1$ verbatim. Independently reproduced by the trace form at $f=2\dots5$, $n=1\dots8$, **both directions**, boundaries included, and the same computation rediscovers the literature's own exception clause at $n=0$. Two misquotes in the note, neither load-bearing |
| 3 | Step (ii), and what semisimplicity buys | **THE CONCLUSION THE ROUTE USES IS UNCONDITIONAL; THE THRESHOLD IS DECORATION.** $M_\lambda$ is an irreducible module over the **image** at every $n$, by the double centraliser plus the surjectivity half, no inequality enters. Demonstrated below the threshold: at $(f,n)=(6,3)$, where $B_6(3)$ is **not** semisimple, one seed still generates all $15$ dimensions of $M_\varnothing$. "The binding constraint of the whole route" is **refuted**; the *literal* statement (ii) is honest at $n\ge11$, and injectivity, which nothing here needs, would want $n\ge12$ |
| 4 | Step (iii), the projector | **CONFIRMED, wording loose in one place.** Surjectivity is unconditional at every $n$ (ASWT Theorem 3.17(b)), so $e\in\nu(B_{12}(n))$, as a *combination* of diagrams, not "a diagram element". The composition is well defined because $e$ preserves isotypic components, and $e\,M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathrm{Weyl}_n)$ exactly. The seed need not lie in the covariant space: verified with a seed $e$ **annihilates** |
| 5 | The identity and its admissibility filter | **BOTH CORRECT; THE RUN UNDER-TESTS ITS OWN THRESHOLD.** Every reported number reproduces. But "exactly ONE sub-threshold failure" is an artefact of starting $n$ at $2$: $(3,1)$ and $(4,1)$ fail too, and $f=5$ adds $(5,3)$, $(5,2)$, $(5,1)$, **five more**. The universal identity is $\sum_\lambda m_\lambda(n)^2$ over *restricted* up–down tableaux, which matches the rank at all $40$ pairs tested; the cell-module form agrees with it exactly when $n\ge f-1$. And at $f=12$ itself the two part company at every $n\le10$ and agree at every $n\ge11$ |
| 6 | Option (b)'s dependency audit | **ITS CENTRAL CLAIM IS REFUTED, AND THE FILE CONTRADICTS ITSELF FOUR PARAGRAPHS APART.** Theorem 3.4 cannot supply A2″'s hypothesis, for a reason the same file states: the covariants are not known to be the $\gamma_D$. Two further gaps, the hypothesis is root-freeness on a **real interval**, which a theorem about integer dimensions cannot give, and $r=6$ is the wrong count for a covariant. The r244 citation inverts r244's own reading. All three asserts are constant-folded |

---

## Claim 1, the leg count, and which algebra acts

Evidence: [r259_claim6.py](../scripts/reviewers/r259/r259_claim6.py) part (3), [out_claim6.txt](../scripts/reviewers/r259/out_claim6.txt).

**Two statements, two algebras, no contradiction.** Lehrer–Zhang Theorem 3.4's basis half is quoted in the record as: *"If $r\le n$, the $\gamma_D$ form a basis of the space of $O(V)$-invariants on $(V^{\otimes2r})^*$."* Invariants on $V^{\otimes12}$ means $2r=12$, $r=6$, and that is correct. The theorem's $f=12$ is the number of legs $B_f(n)$ acts on in $\operatorname{End}(V^{\otimes12})$, and that is correct too. The isomorphism $B_r(n)\cong\{\gamma_D\text{ on }V^{\otimes2r}\}$ is the bend, and $\dim B_6(n)=11!!=10395$ is the dimension of the invariant space on $12$ legs, so both numbers are describing the same $12$ legs from two ends. **The record is not inconsistent.**

**What the table gets wrong is the comparison.** [findings/brauer-pairing.md](../findings/brauer-pairing.md) puts the two side by side under a column headed *slack at $n=12$* (six dimensions against one) and concludes Rui's is "the binding constraint of the route". Two different constraints on two different objects have no common scale, and the ranking does not survive being made honest:

- **Applied to the algebra the theorem uses**, Lehrer–Zhang (equivalently ASWT Theorem 3.17(b): $\Phi_{Br}:B_d(\delta)\to\operatorname{End}(T_n^d)$ is an isomorphism *if $n\ge d$*) reads $12\le n$. At $n=12$ that is **zero** slack, which is tighter than Rui's one.
- **Applied to the covariants**, $r=6$ covers only $\lambda=\varnothing$. A covariant into a block of label $\lambda$ is a map $V^{\otimes12}\to V_\lambda$; pairing against $V_\lambda\subset V^{\otimes|\lambda|}$ makes it an invariant functional on $V^{\otimes(12+|\lambda|)}$, so Theorem 3.4 wants $r=6+|\lambda|/2$. The labels of $V^{\otimes12}$ have $|\lambda|\in\{0,2,\dots,12\}$:

| $\lvert\lambda\rvert$ | 0 | 2 | 4 | 6 | 8 | 10 | 12 |
|---|---|---|---|---|---|---|---|
| $r=6+\lvert\lambda\rvert/2$ | 6 | 7 | 8 | 9 | 10 | 11 | **12** |
| $r\le n$ at $n=6$ | yes | no | no | no | no | no | no |

So the record's *"independence holds for every $n\ge6$"* ([lehrer-zhang notes](../references/lehrer-zhang-sft-orthogonal/notes.md), and [run_b_dependency_audit.py](../scripts/runs/run_b_dependency_audit.py)) is a statement about the invariant row. The widest blocks land at $r=12=n$, zero slack, the same place the injectivity half lands.

**A second reason $n\ge6$ cannot carry the covariants**: at $n=6$ only $77$ of the $160$ labels of $V^{\otimes12}$ are $O(n)$-admissible at all. Eighty-three blocks do not exist there to be independent.

**Which number is right:** both, for their own statements. What should be dropped is the slack column and the word *binding*.

## Claim 2, Rui's criterion as quoted

Evidence: [r259_brauer.py](../scripts/reviewers/r259/r259_brauer.py) part (C), [out_dickson.txt](../scripts/reviewers/r259/out_dickson.txt).

### The source

The primary text is paywalled, as the note says. An accessible source states the criterion in full: Andersen, Stroppel and Tubbenhauer, *Semisimplicity of Hecke and (walled) Brauer algebras*, [arXiv:1507.07676](https://arxiv.org/abs/1507.07676), **Theorem 7.1**, with Conventions 3.11 fixing $\delta\in\mathbb Z$ and $\delta_0=\lvert\delta\rvert$ in characteristic zero:

> **Theorem 7.1.** $B_d(\delta)$ is semisimple if and only if one of the following conditions hold: … (3) $\delta_0\ne0$, $\mathrm{char}(K)=0$ and $d\le\delta_0+1$. … (5) $\delta_0=0$, $\mathrm{char}(K)=0$ and $d\in\{1,3,5\}$.

$d\le\delta_0+1$ **is** $n\ge f-1$. The inequality in the note is right, it is an *iff*, and it is stated for $\delta=n$ the integer dimension rather than for generic $\delta$. The paper attributes the criterion to the existing literature (*"of course not new"*), so the note's provenance is sound as well.

### The independent verification

Dickson's criterion, over a characteristic-zero field an algebra is semisimple iff the trace form of its regular representation is nondegenerate, decides this without any of the cell-module theory. I built the Brauer multiplication table from the diagrams (composition verified: associativity on 300 random triples, closure, $e^2=\delta e$, $s^2=1$), formed $T(D,D')=\operatorname{tr}(L_{DD'})$ and ranked it:

| $f$ | $\dim B_f$ | trace-form rank at $n=0,1,2,3,4,5$ | semisimple exactly at |
|---|---|---|---|
| 2 | 3 | 2, 3, 3, 3, 3, 3 | $n\ge1$ |
| 3 | 15 | **15**, 7, 15, 15, 15, 15 | $n\ge2$, plus $n=0$ |
| 4 | 105 | 69, 97, 58, 105, 105, 105 | $n\ge3$ |
| 5 | 945 | **945**, 517, 745, 706, 945, 945 | $n\ge4$, plus $n=0$ |

**For $n\ge1$ the agreement with $n\ge f-1$ is exact in both directions, at every one of the 32 pairs tested**, including the boundaries $(4,3)$ and $(5,4)$, which are nondegenerate, and $(5,3)$, which is not. The two disagreements are $B_3(0)$ and $B_5(0)$, which *are* semisimple though $0<f-1$, and that is exactly Theorem 7.1(5), $\delta_0=0$ with $d\in\{1,3,5\}$. **A computation that knew nothing of the paper rediscovered the paper's own exception clause**, which is the strongest cross-check available on both.

### Two defects in the note, neither load-bearing

1. *"Same statement holds for $\delta=-2n$."* By 7.1(3) with $\delta_0=\lvert-2n\rvert=2n$ the bound there is $f\le2n+1$, i.e. $2n\ge f-1$, not $n\ge f-1$. The symplectic case is twice as generous, and the sentence as written understates it.
2. The *iff* is false at $n=0$, per the table. The note says *"$\delta=n$ a positive integer"*, so this is guarded, and the route is at $n=12$; it is worth a clause all the same, since the note is the thing that will be cited.

### Does "clears by ONE" survive?

Yes, as arithmetic: $f=12$ needs $n\ge11$ and the route sits at $n=12$. And the margin is real rather than an artefact of the small cases, see claim 5, where the two predictions at $f=12$ itself agree at every $n\ge11$ and differ at every $n\le10$. What does not survive is the claim that this is the constraint that binds; see claim 3.

## Claim 3, step (ii), and what semisimplicity actually buys

Evidence: [r259_seed_span.py](../scripts/reviewers/r259/r259_seed_span.py), [out_seed_span.txt](../scripts/reviewers/r259/out_seed_span.txt).

### The derivation

$V$ is a semisimple $O(n)$-module in characteristic zero, so $V^{\otimes f}=\bigoplus_\lambda V_\lambda\otimes M_\lambda$ with $M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes f})$, and the double centraliser gives

$$\operatorname{End}_{O(n)}(V^{\otimes f})=\bigoplus_\lambda\operatorname{End}(M_\lambda).$$

By the **surjectivity** half of the SFT that algebra *is* $\nu(B_f(n))$. So each $M_\lambda$ is a simple module over $\nu(B_f(n))$ (**at every $n$, with no inequality anywhere in the argument**) and therefore $\operatorname{span}\{\nu(D)c_0:D\}=M_\lambda$ for any nonzero $c_0\in M_\lambda$.

The brief's dichotomy is the right question and the answer is *neither*. The multiplicity space is a module over the image, as the brief says; irreducibility over the image is free; injectivity of $\nu$ is not needed. What semisimplicity of $B_f(n)$ buys is the stronger *identification* $M_\lambda\cong\Delta_\lambda$, a semisimple algebra is $\bigoplus_\lambda\operatorname{End}(\Delta_\lambda)$, any quotient is a sub-sum of those blocks, so for the surviving $\lambda$ the multiplicity space is the cell module on the nose. **The route uses only "generated by any nonzero vector", which is the free half.**

### The demonstration, below the threshold

$\lambda=\varnothing$ makes everything computable: $M_\varnothing$ is the invariant subspace of $V^{\otimes f}$. I take the seed $c_0=\delta_{12}\delta_{34}\cdots$, apply every Brauer diagram, and rank the result.

| $f$ | $n$ | $B_f(n)$ semisimple | $\dim M_\varnothing$ | $\operatorname{span}\{\nu(D)c_0\}$ |
|---|---|---|---|---|
| 4 | 2 | **no** ($2<3$) | 3 | **3** |
| 4 | 3, 4, 5 | yes | 3 | 3 |
| 6 | 2 | **no** ($2<5$) | 10 | **10** |
| 6 | 3 | **no** ($3<5$) | 15 | **15** |

At $(6,3)$ a single seed generates all fifteen dimensions with $B_6(3)$ two short of semisimple. At $(4,2)$ (the reviewed script's own showcase failure, $35$ against $82$), the seed still generates everything. **Step (ii)'s operative conclusion holds in exactly the regime the theorem says it needs a threshold for.**

### What the threshold numbers honestly are

| statement | needs | at $n=12$, $f=12$ |
|---|---|---|
| $\{\nu(D)c_0\}$ spans $M_\lambda$ for any nonzero $c_0$, *what the route uses* | nothing | free at every $n$ |
| $M_\lambda\cong\Delta_\lambda$, the cell module, *what (ii) literally says* | $n\ge f-1=11$ | one to spare |
| $\nu$ injective, $\ker\nu=0$ | $n\ge f=12$ | **zero** to spare |

So the theorem's stated $n\ge11$ is honest for the sentence it is attached to. What is refuted is the headline: *"That is the binding constraint of the whole route"*. Nothing in the route binds at $11$, because nothing in the route needs the cell-module identification, and the one genuine zero-slack inequality in the neighbourhood, $n\ge f$, is not the one on record either.

## Claim 4, step (iii), the projector

Evidence: same script.

**Surjectivity is unconditional, in the exact form needed.** ASWT Theorem 3.17(b), type $B_m$: $\Phi_{Br}:B_d(\delta)\twoheadrightarrow\operatorname{End}_{U}(T_n^d)$, with the isomorphism clause carrying the extra hypothesis $n\ge d$ and the surjection carrying none. $T_n^d=V^{\otimes d}$ and $d=f=12$, $n=12$, so it applies as used. This is the classical first fundamental theorem and it has no threshold.

**Therefore $e\in\nu(B_{12}(n))$**, since $\mathrm{Sym}^3(\mathrm{Weyl}_n)$ is an $O(n)$-submodule of $V^{\otimes12}$ and the projector onto it along its orthogonal complement is $O(n)$-equivariant. Then $e=\nu(b)$ and $e\,\nu(D)=\nu(bD)$, as claimed.

**One wording defect.** [findings/brauer-pairing.md](../findings/brauer-pairing.md) says *"Step 3 needs $e$ itself to be a diagram element, and it is"*. $e$ lies in the **span** of the diagram images; it is a linear combination, not a diagram. The argument is unaffected ($\nu(B)$ is closed under multiplication either way) but the item this theorem replaces is *"exhibit the covariants over Brauer diagrams"*, where the distinction between a diagram and a combination of them is the entire currency.

**The composition is well defined.** $e$ commutes with $O(n)$, so it preserves the isotypic decomposition and restricts to an endomorphism of each $M_\lambda$; $\mathrm{Sym}^3(\mathrm{Weyl}_n)$ being a direct summand gives $e\,M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathrm{Weyl}_n)$, the block's covariant space, exactly. Composing with $\operatorname{span}\{\nu(D)c_0\}=M_\lambda$ gives the spanning claim.

**The seed need not lie in the covariant space, and the check is arranged so it does not.** Every row above uses $c_0=\delta_{12}\delta_{34}\cdots$ with $e=A_{12}A_{34}\cdots$ the product of antisymmetrisers (a stand-in for the Weyl projector with the same equivariance) and $e\,c_0=0$ at every row. The projected seeds still span $e\,M_\varnothing$ in full. **A seed annihilated by the projector still generates the projector's image.**

**A scope note the commit should carry.** The theorem reduces *"exhibit each of the 184 covariants over diagrams"* to *"exhibit one seed per block over diagrams"*. [findings/sym3-stability.md](../findings/sym3-stability.md) gives the shape as **71 blocks, 184 multiplicities**, so the reduction is $184\to71$, a factor of $2.6$, not the $184\to1$ the framing suggests. And the seeds are still the objects [plan.md](../plan.md) section 2 item 1 says the construction cannot yet write down.

## Claim 5, the verification's identity and its admissibility filter

Evidence: [r259_brauer.py](../scripts/reviewers/r259/r259_brauer.py) parts (A), (B), (D); [out_gram_f5.txt](../scripts/reviewers/r259/out_gram_f5.txt).

### Is the identity correct?

Yes, in this direction. Semisimplicity gives $B_f(n)=\bigoplus_\lambda\operatorname{End}(\Delta_\lambda)$; the image is a quotient, hence a sub-sum; the surviving labels are the $O(n)$-admissible ones; so $\dim\nu(B_f(n))=\sum_{\lambda\text{ adm}}(\dim\Delta_\lambda)^2$. The converse does not hold, so a match is consistent with semisimplicity rather than evidence of it, which is why claim 2 is settled by the trace form instead.

**The identity that holds without any hypothesis** is $\dim\nu(B_f(n))=\sum_\lambda m_\lambda(n)^2$ with $m_\lambda(n)$ the number of up–down tableaux of length $f$ ending at $\lambda$ **all of whose intermediate shapes are admissible**. I computed both predictions against the Gram rank at every $(f,n)$ with $2\le f\le5$, $1\le n\le8$: the restricted count matches the rank at **all 40 pairs**, the cell-module count matches exactly where $n\ge f-1$.

### Is `admissible` the right rule, and is `updown_counts` right?

Both yes. First two column lengths summing to at most $n$ is the standard labelling of $O(n)$-irreducibles, and the reviewed `conj`/`admissible` implement it correctly. `updown_counts` computes $\dim\Delta_\lambda$ correctly: the totals $\sum_\lambda(\dim\Delta_\lambda)^2$ come out $3$, $15$, $105$, $945$, $=(2f-1)!!=\dim B_f$ at $f=2,3,4,5$, and $316234143225=23!!$ at $f=12$.

### The extension, and the run's one weak point

| $f$ | $n$ | rank $\nu(B_f(n))$ | $\sum_{\rm adm}(\dim\Delta)^2$ | verdict |
|---|---|---|---|---|
| 3 | **1** | 1 | 9 | **fails, not in the run** |
| 4 | **1** | 1 | 9 | **fails, not in the run** |
| 4 | 2 | 35 | 82 | fails (the run's one case) |
| 5 | **1** | 1 | 225 | **fails** |
| 5 | **2** | 126 | 326 | **fails** |
| 5 | **3** | 603 | 842 | **fails** |
| 5 | 4 | 903 | 903 | match, boundary $n=f-1$ |
| 5 | 5…8 | 945 | 945 | match |

**The run reports exactly one sub-threshold failure because it starts $n$ at 2.** There are six in the range $1\le n\le8$, $2\le f\le5$: every single pair with $n<f-1$ fails, and every pair with $n\ge f-1$ matches. The $f=5$ row the brief asked for is the second clean test of the threshold (boundary $n=4$ lands on $903$ exactly, $n=3$ misses by $239$) and it removes the worry that $(4,2)$ was a coincidence.

### The threshold at the route's own parameters

The small cases are not the interesting ones. At $f=12$ both predictions are computable directly:

| $n$ | $\sum_{\rm adm}(\dim\Delta_\lambda)^2$ | $\sum_\lambda m_\lambda(n)^2$ | equal |
|---|---|---|---|
| 9 | 316125326381 | 315957071241 | no |
| 10 | 316229719418 | 316222167677 | **no** |
| **11** | 316233935213 | 316233935213 | **yes** |
| 12 | 316234143225 | 316234143225 | yes ($=23!!$, so $\nu$ injective) |

**They agree at every $n\ge11$ and differ at every $n\le10$.** The threshold is sharp at $f=12$ itself, not extrapolated from $f\le5$, and $n=12$ clears it by one, that much of the commit's headline is right on its own terms.

## Claim 6, option (b)'s dependency audit

Evidence: [r259_claim6.py](../scripts/reviewers/r259/r259_claim6.py), [out_claim6.txt](../scripts/reviewers/r259/out_claim6.txt).

### A2″, the central claim is refuted, and the file refutes it itself

The audit's load-bearing sentence: *"THAT HYPOTHESIS IS NOW SUPPLIED BY THEOREM 3.4, not by anything the programme must build."* Three independent reasons it is not.

1. **The covariants are not known to be the $\gamma_D$.** Theorem 3.4 is about the functionals attached to Brauer diagrams. [plan.md:61](../plan.md) states, and [run_b_dependency_audit.py](../scripts/runs/run_b_dependency_audit.py) *itself restates four paragraphs later*, that *"the construction emits VECTORS IN A WEIGHT SPACE"* and whether those are the $\gamma_D$ is unestablished. A theorem about the independence of one family cannot supply the independence of a family not yet known to be it. **The file asserts the supply and then names the obstruction to it, in the same docstring.**
2. **The hypothesis is a real-interval statement.** [r245](REVIEW_r245.md) claim 1(iii): the theorem needs the covariant family independent at **every** $n\ge12$, *"equivalently the $184\times184$ covariant-Gram determinant has root-free determinant on $[12,\infty)$"*. Theorem 3.4 quantifies over $n=\dim V$, an integer. No statement about integer dimensions gives root-freeness on a real interval, that is the same gap [r242](REVIEW_r242.md) records for $\det\mathrm{Gram}_S$ and routes to A5's Sturm list.
3. **$r=6$ is the wrong count for a covariant.** Claim 1 above: a covariant into a block of label $\lambda$ needs $r=6+|\lambda|/2$, up to $12$. The blanket *"holds for every $n\ge6$"* is the invariant row only.

**Is A2″ the only step that took independence as a hypothesis?** No. [r245](REVIEW_r245.md)'s recommendation 1 lists **three** preconditions for A2″, and [plan.md:37](../plan.md) already carries them: (a) the 89 constraint functionals **separate**, which is A2's own $\det\mathrm{Gram}_S$ obligation; (b) the covariant family is independent; (c) the pivot minor $\xi(n)$ is root-free. The audit addresses (b), reclassifies (a), and does not mention (c), the one r245 calls *"the single gate to a fixed $\mathbb R^k$"*.

**And A2″ is not only about constant $t$.** [r245](REVIEW_r245.md) claim 2: a trivial recession cone is what excludes *weak* infeasibility, so *"the boundedness theorem is exactly what buys the exactness of its own refutation certificate"*. Discarding A2″ discards that. r245 also supplies the softening the audit could have used and did not: **$S_{12}$ compact alone suffices** for the whole Helly apparatus.

### The r244 citation inverts r244

The audit: *"reviewer 244 already showed a constant $t$ is not what the route needs … so the fallback reads $t\in\mathbb Q(n)$ regardless."*

I evaluated the witness exactly. $S_n=[(n-1)/n^2,(n+1)/n^2]$, so $1/n\in S_n$ at every $n$, as quoted. But:

- $\max_n\text{lower}=11/144=0.076389$ at $n=12$ and $\text{upper}(16)=17/256=0.066406$, so $S_{12}\cap S_{16}=\varnothing$. **The witness kills a constant $t$ too**, in two dimensions.
- So the witness does not show the constant-$t$ question is *skippable*; in the witness the answer is simply *no*. Whether the real instance answers *no* is untouched, r244 built a $2\times2$ family "of A2's exact shape", not A2.
- And [r244](REVIEW_r244.md)'s R1 says the opposite of what it is cited for: *"Sharpness is therefore not a reason the intersection must be empty. The file concedes the open case without this analysis, and the analysis says the concession is premature."* r244 argued the constant-$t$ question is **live and finitely decidable**. The audit cites it as having closed it.

### A2, the downgrade is exactly what r242 refused

The audit: $\det\mathrm{Gram}_S$ is *"a chosen subset being invertible, which the solve either achieves or does not, checkable at the point of use."* [r242](REVIEW_r242.md) considered that and priced it: *"a singular $\mathrm{Gram}_S$ or a vanishing normaliser makes the solve fail visibly rather than silently. That is an operational safeguard, not a proof, and it is enough for A4."* Enough for **A4**, which needs four sample points. A2's conclusion is *"specialises to every $n$ at once"*, and for that r242 states the obligation positively: *"a uniformity lemma (one independent subset of the diagram spanning set … valid at every $n\ge12$ simultaneously) or $\det\mathrm{Gram}_S(n)$ on A5's checklist."* The audit applies A4's licence to A2.

### The asserts

The file says it *"checks the two arithmetic facts the audit turns on"*. Neither check can fail.

| assert | evaluates to | why |
|---|---|---|
| `two_r % 2 == 0` | `12 % 2 == 0` | `DEGREE` and `LEGS_PER_WEYL` are literals |
| `r <= 12` | `6 <= 12` | same constants |
| `r <= 6` | `6 <= 6` | same constants; message names a failure *"somewhere in [6, 12]"* no input can produce |
| `lo < 1/n < hi` | true for every $n\ge1$ | $lo=1/n-1/n^2$, $hi=1/n+1/n^2$, $1/n^2>0$, it restates the definition |

The printed loop `r <= n is {r<=n} -> diagrams are a basis: {r<=n}` emits the same boolean twice at $n=6,12,24$. **Nothing in the file is a function of anything measured.** The one number that would have made it a check ($r=6+|\lambda|/2$ against $n$, per block), is the one it does not compute.

### What survives

The audit's third conclusion is right and is the useful one: **A3 needs the covariants built, which is not the same as proving them independent**, and the two were conflated. That reframing stands, and it is what the primary commit then acts on.

---

## Verdict

**Three of the six hold; the framing of the fourth is the problem, and the sixth is refuted.**

The theorem is **true**. Steps (i), (ii) and (iii) are each correct at $n=12$, $f=12$, and the verification's arithmetic reproduces under a wholly independent method. Rui's criterion is quoted correctly and I confirmed it twice over, once from an accessible source and once from the trace form.

What fails is the claim about **why** it is true. Step (ii)'s operative conclusion (one seed generates the block), costs nothing: it is the double centraliser plus the unconditional surjectivity half, and I exhibit it holding at $(6,3)$ and $(4,2)$ where $B_f(n)$ is not semisimple and the theorem says it should not. So *"Rui's is the binding constraint of the route, and it clears by one"* is decoration on a threshold-free argument, and the genuinely tight inequality in the area ($n\ge f=12$ for injectivity, zero slack), is neither the one on record nor one the route needs.

**What to change.**

1. Restate step (ii) as two sentences: the spanning conclusion, unconditional in characteristic zero by the double centraliser; and the cell-module identification, at $n\ge f-1$, marked as not used.
2. Drop the *slack* column from the findings table. The two criteria constrain different objects; if a comparison is wanted, the row to add is $r=6+|\lambda|/2$ against $n$, which reaches $12$.
3. Fix the two note defects: $\delta=-2n$ gives $f\le2n+1$; the *iff* has an exception at $\delta=0$, $d\in\{1,3,5\}$. Cite ASWT Theorem 7.1 as the accessible statement.
4. Say "$e$ lies in the span of the diagram images", not "$e$ is a diagram element", and record that the reduction is $184\to71$ seeds.
5. Extend the run's $n$ range to $1$ and its $f$ range to $5$ (six sub-threshold failures instead of one) and add the $f=12$ row, where the two predictions part at $n=10$ and agree from $n=11$. That is the check the theorem's own parameters deserve, and it costs nothing.
6. Withdraw *"Theorem 3.4 supplies A2″'s hypothesis"*. The covariants are not known to be the $\gamma_D$ (the same file says so), the hypothesis is root-freeness on a real interval, and $r=6$ is the invariant block's count. Restore r245's precondition (c) and r242's uniformity lemma, and cite r244 for what R1 says: the constant-$t$ question is open and finitely decidable.
