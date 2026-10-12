# Review r583, Lemma L4 (a generator for critical points, and a new family)

Reviewer r583, independent adversarial audit, working from the definitions. Target: the block `Lemma L4 (a generator for critical points, and a new family), canonical statement and proof` at [ungraded-slack.md](../findings/ungraded-slack.md), lines 105-112. Analysis only: every number below is derived by hand in exact or hand-checkable arithmetic, on objects constructed for the purpose.

## The block's true boundaries

The heading sits at [ungraded-slack.md:105](../findings/ungraded-slack.md); the block is two paragraphs plus a provenance line, ending at line 112 where `Lemma L23`'s heading begins. **The material the brief calls L4's preamble belongs to a different block**, the un-numbered `The subalgebra family: theta from dim h alone, and Conjecture A proved on it` at lines 73-103, which carries both hedging paragraphs. L4's own block carries no hedge, no proof and no verification paragraph.

## Verdict summary

| # | clause | verdict |
| --- | --- | --- |
| D1 | the provenance note's middle clause | REFUTED |
| D2 | the heading's promise of a proof | REFUTED; proof supplied below |
| D3 | the criterion itself | CONFIRMED, and true under a strictly weaker hypothesis |
| D4 | $(\Lambda^4\mathbb R^n)^K=0$ as a hypothesis | REPAIRED, inert, and refuted as *necessary* by the record's own L28 |
| D5 | "None is coordinate-diagonalizable" | REFUTED, witness below |
| D6 | the maximum claim's quantifier | REPAIRED, even $n$ only |
| D7 | "$\theta$ increases with $\dim\mathfrak h$" | CONFIRMED, one line |
| D8 | the cap $n(n-2)/4$ and its $t_{112}=0$ hypothesis | CONFIRMED, hypothesis discharged by construction |
| D9 | "Two non-members exceed $\theta_0$ harmlessly" (preamble) | REFUTED, infinitely many do; *harmlessly* is earned |
| D10 | the $0.8367$ ceiling | value CONFIRMED; the ceiling claim rests on an enumeration that is not on the record |
| D11 | report/ carries a withdrawn form of the maximum | REFUTED, live in [90-appendix.tex:47](../report/sections/90-appendix.tex) |

**Overall: REPAIRED.** The criterion the lemma exists for is true, and provable in three lines from weaker hypotheses than it states. Two of its own clauses are false and one of its consumers is stale.

## D1, the provenance note, against `git`

The note reads *"Moved here from results.md on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."* The first and third clauses hold; the middle clause is false twice over.

- **It was a copy, not a move.** The migration commit `a9e4b8c0` (2026-08-31) removed only the second paragraph from results.md. The first paragraph still sits at [results.md:314](../results.md), byte-identical to [ungraded-slack.md:109](../findings/ungraded-slack.md), checked with `diff`, which reports no difference.
- **A prior copy of the substance existed for a week.** The criticality criterion, the closed form and the cap were all in [graded-half.md](../findings/graded-half.md) from commit `51ab61f8` (2026-08-24), in the block that is now the subalgebra-family block at lines 73-103 of ungraded-slack.md, and in what is now L23.
- **The destination named is not the one it went to.** `a9e4b8c0` put the block in graded-half.md; it reached ungraded-slack.md only through the split `7ad0455d` later the same day.
- **What moved carries no argument.** The moved paragraph asserts monotonicity and defers to L23 for both of its statements.

## D2, the heading promises a proof; the block contains none

The heading is `canonical statement and proof`. Between it and L23's heading there is a statement of the criterion, a list of examples, a closed form, and the maximum claim, each asserted. `by equivariance` is the whole of the argument. The proof of L4's criterion in the form L4 states it is nowhere in [findings/](../findings/): the family block and L23 both prove a *different* statement, whose hypotheses are (F1) $K$-irreducibility with $\mathfrak h\not\cong\mathfrak m$, (F2) $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ and (F3) $(\Lambda^4\mathbb R^n)^K=0$. The only prose proof of L4's own form is in [90-appendix.tex:38](../report/sections/90-appendix.tex), and its account of the second hypothesis is the one D4 refutes.

## D3 and D4, rebuilding the criterion, and what each hypothesis buys

**Claim.** Let $K\subseteq SO(n)$ act on $\mathbb R^n$ and suppose $\dim\mathcal W_n^K=1$, spanned by a unit $W$. Then $Q(W)=\theta W$ with $\theta=P(W)$.

**Proof.** Three inputs, each already on the record.

1. **$Q$ is $O(n)$-equivariant**: $Q(gWg^{\mathsf T})=gQ(W)g^{\mathsf T}$, because $W\mapsto W^2$ is conjugation and $W\mapsto W^\#$ is built from the structure constants of $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$, which are $\mathrm{Ad}$-invariant ([conventions.md](../findings/conventions.md), structure constants).
2. **$\mathcal W_n$ is closed under $Q$**, the Weyl operators are a subalgebra of the curvature algebra. This is Fox's theorem, cited at [problem.md:108](../findings/problem.md). Concretely: $\mathrm{Alt}(Q(R))=0$ whenever $\mathrm{Alt}(R)=0$, and the Ricci reaction terms $2\mathring R(\mathrm{Ric})-2\mathrm{Ric}^2$ each carry a Ricci factor, so a Ricci-flat $R$ has a Ricci-flat $Q(R)$.
3. Hence $Q(W)\in\mathcal W_n^K=\mathbb R\,W$, so $Q(W)=\theta W$, and pairing with $W$ at $\lVert W\rVert=1$ identifies $\theta=\langle W,Q(W)\rangle=P(W)$. $\square$

**$(\Lambda^4\mathbb R^n)^K=0$ is used nowhere in that argument, and it is not necessary.** The report's justification for it, *"what places $W$ in $\mathrm{Weyl}_n$ to begin with: $\mathrm{Alt}(W)$ is a $K$-invariant $4$-form, hence zero"*, presupposes that $W$ is drawn from a larger invariant space, which contradicts the statement's own hypothesis $\dim\mathcal W_n^K=1$: an element of $\mathcal W_n^K$ satisfies Bianchi by membership. The hypothesis is a leftover from the family construction, where the candidate is the Casimir $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, an element of $S^2(\Lambda^2)$ that (F3) places inside $\mathcal W_n$, a hypothesis about *producing* $W$, not about criticality.

**The record refutes necessity outright.** Take $K=U(m)\subset SO(2m)$. Then $(\Lambda^4\mathbb R^{2m})^{U(m)}\ne0$, since $\omega\wedge\omega\ne0$ for $m\ge2$ with $\omega$ the Kähler form, so L4's second hypothesis fails. Yet [L28](../findings/nondegeneracy.md) proves $\dim\mathcal W_{2m}^{U(m)}=1$ (its branching table has exactly one trivial summand) and that its spanning $W_{\mathbb{CP}^m}$ **is** critical, with the criticality residual $3\times10^{-16}$ recorded independently at [problem.md:239](../findings/problem.md). So the criterion holds at a $K$ that violates $(\Lambda^4)^K=0$, and L4's version of it is strictly weaker than the truth. *If the hypothesis were load-bearing, L28 would be false.*

**Neither hypothesis is used anywhere else in the block.** $\dim\mathcal W_n^K=1$ appears only in the criticality step; $(\Lambda^4)^K=0$ appears only in the statement.

## D5, "None is coordinate-diagonalizable" is false, and the block refutes it two paragraphs later

[conventions.md](../findings/conventions.md) fixes the sense: *diagonal in coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame*. Take $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ at any even $n$, which L4's own second paragraph names as a member and as the family's maximiser. In the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$ of $\Lambda^2\mathbb R^n$, $\mathfrak h$ is spanned by the basis vectors with both indices in the same block, so $\Pi_{\mathfrak h}$ is a diagonal $0/1$ matrix, and $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is diagonal in that basis. **Every balanced-split member is coordinate-diagonal**, at every even $n$, by inspection and with no computation.

The block's escape clause, *"the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, which is exactly why $S^3\times S^3$ is diagonal"*, treats the $n=6$ case as isolated when the same one-line argument covers $n=8,10,12,\dots$. [problem.md:158](../findings/problem.md) already records the correction, attributed to Reviewer 118, in the very entry that states the criterion: *"**Some members are coordinate-diagonalizable**, the balanced sphere product is one, and the $3$-block product just named is another."* The correction reached problem.md and results.md's glance line reads *"provably non-diagonalizable family"* at [results.md:116](../results.md), so the false clause survives in three places.

*Spillover, for whoever repairs it*: problem.md's replacement claim (*"their positive eigenspaces contain no decomposable bivector at all"*), is false for the same member, since $E_{\max}=\mathfrak h$ contains $e_1\wedge e_2$. It is true of the bi-invariant simple members, where $\mathrm{ad}(X)$ has rank at least $4$.

## D6, the maximum claim's quantifier

The claim *"the answer is $n(n-2)/4$, attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$"* is stated for all $n$. Attainment needs $n$ even: at odd $n$ the cap is not an integer and $\theta<\theta_0(n)$ strictly, which [L23](../findings/ungraded-slack.md) states correctly and L4 omits. The bound $r\le n(n-2)/4$ itself holds at every $n$.

## D7, the asserted monotonicity, derived

Write $N=\binom n2$, fixed once $n$ is. From the closed form,
$$\theta^2=\frac4{n^2}\cdot\frac{rN}{N-r}=\frac{2(n-1)}n\cdot\frac r{N-r},$$
and $r\mapsto r/(N-r)$ is strictly increasing on $(0,N)$ with positive derivative $N/(N-r)^2$. So $\theta$ is strictly increasing in $r=\dim\mathfrak h$ at fixed $n$, on the whole family and not on a subfamily. The maximum claim inherits nothing. At $r=n(n-2)/4$ one has $N-r=n^2/4$ and $rN/(N-r)=(n-1)(n-2)/2$, giving $\theta=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$, which matches [conventions.md](../findings/conventions.md).

## D8, which cap L4 consumes

L4 consumes [L23](../findings/ungraded-slack.md)'s cap, the one that falls out of $S_{\mathfrak{mmm}}\ge0$ in $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, which gives $r\le n(n-2)/4$ exactly, at $n=6$, $(15-r)(8-4r/3)\ge0$ gives $r\le6$, the true value. It does not consume [L105](../findings/bounds-relaxations.md)'s LP route, whose weaker $T\ge0$ form yields only $r\le8$ at $n=6$ and needs $t_{112}=0$ to reach the cap. **The hypothesis is discharged by construction**: L105 records that $t_{112}=0$ says exactly that $E_{\max}$ is a subalgebra, and family membership *is* the statement that $E_{\max}=\mathfrak h$ is a subalgebra. No gap here.

## D9, the preamble's hedge "Two non-members exceed $\theta_0$ harmlessly"

**A closed form for the two-eigenvalue Casimir of any symmetric pair, derived from the two structure-constant identities alone.** Let $\mathfrak h\subset\mathfrak{so}(n)$ with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, so $S_{\mathfrak{mmm}}=0$, $S_{\mathfrak{hmm}}=\kappa(N-r)/2$ and $S_{\mathfrak{hhh}}=\kappa(3r-N)/2$ with $\kappa=2(n-2)$. With $\rho=r/N$, $u=c(1-\rho)$, $v=-c\rho$, $c=1/\sqrt{N\rho(1-\rho)}$, the two block averages of $Q(W)$ are the left-hand sides of L23's own scalar equations, and $P=\langle W,Q(W)\rangle=ruq_{\mathfrak h}+(N-r)vq_{\mathfrak m}=Nc\rho(1-\rho)(q_{\mathfrak h}-q_{\mathfrak m})$, which collapses to

$$P(W_{\mathfrak h})=\frac{(1-2\rho)+\kappa\,(1-\rho)\dfrac{4\rho-1}{4\rho}}{\sqrt{N\rho(1-\rho)}}.$$

*This formula is $P$ at the Casimir whether or not it is critical, so it applies to non-members, where L23's $\theta=\tfrac2n\sqrt{rN/(N-r)}$ (a consequence of the eigen-equation), does not.*

**Three validations, none of them shared with the block's route.** At the balanced split $\rho=(n-2)/(2(n-1))$ it returns exactly $\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. At $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ it returns $3.0384616/2.6389933=1.1513702$, against the block's $1.151371$. At $\mathfrak{so}(4)\oplus\mathfrak{so}(6)\subset\mathfrak{so}(10)$ it returns $1.203762$, against the block's $1.203766$. **Both published figures are correct, and both are $P$ at a non-critical Casimir rather than the closed form**, the closed form would give $1.2315$ and $1.2550$ there.

**The count is wrong.** The exceedances are the near-balanced splits $\lvert p-q\rvert\in\{1,2\}$, and they continue past the two named:

| pair | $n$ | $r$ | $P$ | $\theta_0(n)$ |
| --- | --- | --- | --- | --- |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ | $8$ | $13$ | $1.151370$ | $1.145644$ |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(5)$ | $9$ | $16$ | $1.178591$ | $1.175889$ |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(6)$ | $10$ | $21$ | $1.203762$ | $1.200000$ |
| $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ | $12$ | $31$ | $1.238530$ | $1.236033$ |
| $\mathfrak{so}(6)\oplus\mathfrak{so}(8)$ | $14$ | $43$ | $1.263314$ | $1.261678$ |

**The $n=12$ row in exact arithmetic**, so the refutation stands without a floating-point step. $N=66$, $\kappa=20$, $r=31$, $\rho=31/66$: the numerator is $\tfrac2{33}+20\cdot\tfrac{35}{66}\cdot\tfrac{29}{62}=\tfrac{62}{1023}+\tfrac{5075}{1023}=\tfrac{5137}{1023}$ and $N\rho(1-\rho)=\tfrac{1085}{66}$, so
$$P^2=\frac{5137^2}{1023^2}\cdot\frac{66}{1085}=\frac{1741658754}{1135483965},\qquad \theta_0(12)^2=\frac{220}{144}=\frac{55}{36},$$
and $1741658754\cdot36-55\cdot1135483965=62699715144-62451618075=248097069>0$. The same cross-multiplication at $n=9$ gives $64009\cdot81-112\cdot46080=23769>0$.

So **"Two non-members exceed $\theta_0$" is refuted**; the true statement is that every near-balanced unbalanced split does, with a margin that shrinks in $n$ ($0.0057$, $0.0027$, $0.0038$, $0.0025$, $0.0016$ in the rows above).

***Harmlessly* is earned, on the record's own reason and on a check the record does not give.** For $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ the Ricci of $W_{\mathfrak h}$ is $K$-invariant, hence $\alpha I_p\oplus\beta I_q$ with $\alpha=(p-1)u+qv$; at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $\alpha=2u+5v=-0.473665\ne0$ and $\lVert\mathrm{Ric}\rVert=1.0377$, matching the block's $\lVert\mathrm{Ric}\rVert\approx1$; at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, $\alpha=4u+7v=-0.287733\ne0$. None of these operators lies in $\mathcal W_n$, so none bears on $\sup P$ over the Weyl space. The hedge's *point* survives its count.

## D10, the $0.8367$ ceiling

**The value is right.** $\mathfrak h=\mathfrak{su}(3)$ acting on itself, $n=8$, $r=8$, $N=28$: $\theta=\tfrac28\sqrt{8\cdot28/20}=0.836660$. The block's other figure checks too: $\mathfrak{sp}(3)\subset\mathfrak{so}(14)$ for $SU(6)/Sp(3)$, $r=21$, $N=91$, gives $\tfrac2{14}\sqrt{21\cdot91/70}=0.746423$, the block's $0.7464$.

**Bi-invariant simple members are exhausted by a derivation.** There $r=n$, so $\theta=\tfrac2n\sqrt{n(n-1)/(n-3)}$, decreasing in $n$: $0.8367$ at $n=8$ ($\mathfrak{su}(3)$), $0.7171$ at $n=10$ ($\mathfrak{so}(5)$), $0.5811$ at $n=14$ ($\mathfrak g_2$), $0.5578$ at $n=15$ ($\mathfrak{su}(4)$). The smallest $n$ for a simple compact group is $8$, so $0.8367$ is the maximum over that sub-population, and $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ at $n=6$ reaching $\theta_0(6)$ is exactly the non-simple boundary case.

**The claim over all simple-isotropy members is an enumeration, and the enumeration is not on the record.** $\theta>0.8367$ needs $r/(N-r)>0.35n/(n-1)$, i.e. $r\gtrsim0.26N$, and the cap permits $r$ up to $\approx0.5N$; the runner-up on file, $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ for $SU(3)/SO(3)$, sits at $0.828$, which is the preamble's own ratio $0.845=0.828/\theta_0(5)$. Nothing on the record rules out a simple $\mathfrak h$ of dimension $\gtrsim0.26N$ passing all three conditions; the candidates that would ($\mathfrak{su}(m)$, $\mathfrak{sp}(m)$, $\mathfrak g_2$, $\mathfrak{spin}(7)$) each carry an invariant $4$-form, which is a pattern rather than a proof. [problem.md:158](../findings/problem.md) states the honest form (*"the maximum over members with $\mathfrak h$ simple, which is where the enumeration looked"*) and L4's block drops the qualifier.

## D11, the ceiling is load-bearing in a place that is now wrong

[90-appendix.tex:47](../report/sections/90-appendix.tex) reads *"The family maximizes at $0.8367$, far below $\theta^*$, and the reason is structural: $P\ge\theta^*$ would force $\dim\mathfrak h\gtrsim0.44\binom n2$, and inside $\mathfrak{so}(n)$ a subalgebra that large forces a unitary factor, which reintroduces the invariant $4$-form."* Three failures, all settled by L4's own second paragraph:

- the family's maximum is $\theta_0(n)$, attained at the balanced split, not $0.8367$;
- $\theta_0(n)>\theta^*=\sqrt{3/2}$ for every $n\ge12$, $\theta_0(12)=1.236033$ against $1.224745$, so members do exceed $\theta^*$, which is the crossover the whole programme is built on;
- $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ has $\dim\mathfrak h=\tfrac{n-2}{2(n-1)}\binom n2$, above the $0.44$ threshold, with no unitary factor and no invariant $4$-form under the full normaliser.

The Lemma 5 entry seven lines below in the same file already carries the correction, *"the figure $0.8367$ that stood here is the ceiling of the isotropy-generated family alone"*, so the repair reached L5's entry and stopped short of L4's.

## Citations, by the corrected rule

Counting the token `L4` not followed by a digit, in [findings/](../findings/), [results.md](../results.md) and [report/](../report/): **5 occurrences, of 87 raw `L4` hits**, the other $82$ are `L40`-`L49`. No `#L4` anchor and no `#lemma-l4-` link exists anywhere, and [report/](../report/) contains the token zero times.

| location | kind |
| --- | --- |
| [ungraded-slack.md:105](../findings/ungraded-slack.md) | the block's own heading |
| [results.md:312](../results.md) | the statement entry's heading |
| [results.md:116](../results.md) | the glance line |
| [results.md:320](../results.md) | cited by L5 |
| [graded-half.md:69](../findings/graded-half.md) | cited by L5, same sentence |

**So there are two genuine third-party citations, both the same sentence of L5, against the brief's figure of 26.** Both use L4 inside its hypotheses, they take the simple-isotropy ceiling $P\le0.837$ and the balanced products' membership, and defer the maximum to L23. *Their two copies have diverged*: graded-half.md:69 counts *"Five further families, of which four lose to both named competitors and one ties"*, while results.md:320 still reads *"Six further families lose to both named competitors"*. That is L5's defect, recorded here because it sits in L4's only citing sentence.

## What the block leans on that is still undefined

- **$Q$ preserves $\mathcal W_n$**, the load-bearing input of the whole criterion, asserted in the family block and in the report as *"$Q$ preserves the Weyl space"*, sourced only as a passing remark on Fox at [problem.md:108](../findings/problem.md), and absent from [conventions.md](../findings/conventions.md).
- **$\Pi_{\mathfrak h}$**, the orthogonal projection onto the subalgebra, is a **fifth** sense of $\Pi$ beyond the four conventions.md tables.
- **$b_4=0$** is used to select the qualifying symmetric spaces and is defined nowhere on the record; it functions as a proxy for $(\Lambda^4\mathbb R^n)^K=0$, which is the hypothesis D4 shows to be inert.
- **$\mathfrak h$ and $r$** enter L4's closed form with no introduction in the block; conventions.md defines $\mathfrak h$ as $E_{\max}$ at a critical point, which happens to agree here, and the block never says so.
- **"critical point"** in conventions.md is $Q(W)=\theta W$, an equation in $S^2(\Lambda^2)$; it is legitimate here only because $\mathcal W_n$ is $Q$-closed, and otherwise reads as the projected condition $\Pi_{\mathcal W_n}Q(W)=\theta W$. The two coincide, and the reason is the undefined input above.
- **"isotropy-irreducible"** and **"held-out spaces"** are used without definition or reference.

## Repairs the record needs

1. Delete *"where the argument was the only copy"* from the provenance line, or restate it as what happened: the second paragraph moved, the first was duplicated, and the substance had been in findings/ since 2026-08-24.
2. Replace *"None is coordinate-diagonalizable"* with the true statement, the bi-invariant simple members are non-diagonal, and the balanced splits and the $3$-block product are diagonal, in [ungraded-slack.md:109](../findings/ungraded-slack.md), [results.md:314](../results.md) and the glance line at [results.md:116](../results.md).
3. State the criterion as $\dim\mathcal W_n^K=1$ alone, note that $\mathcal W_n$ is $Q$-closed as the input, and drop $(\Lambda^4\mathbb R^n)^K=0$ or demote it to the member-producing conditions where it belongs. L28 is the witness that it is not necessary.
4. Add the proof (the three lines of D3), under a heading that promises one.
5. Restrict the attainment clause to even $n$.
6. Correct *"Two non-members exceed $\theta_0$"* to the near-balanced splits generally, keeping *harmlessly*, which is earned.
7. Rewrite [90-appendix.tex:47](../report/sections/90-appendix.tex): the family's maximum is $\theta_0(n)$, and $0.8367$ is the simple-isotropy ceiling.
8. Reconcile L5's two copies on the family count.
