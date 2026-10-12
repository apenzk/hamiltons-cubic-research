# Gate 2 review r374, Lemma L128, the branching clause

Brief: work from the definitions, re-derive (i)–(iii) before reading the proofs, then attack. **Analysis only**, no computation was run, and none was needed: every witness below is quoted from the record itself.

**Verdicts.**

| part | verdict | one line |
|---|---|---|
| (i) location of the orbit | **CORRECTED** | statement true, re-derived independently; the proof elides the dimension cut $n-2\to n-3$, and its coefficient sign contradicts its own stated $\rho$-action |
| (ii) block criterion | **REFUTED as an iff** | "$L_e$-spectrum $<\tfrac12$" should read "$\tfrac12\notin\sigma(L_e)$"; witness $S^2\times S^4$, from [Lemma L11](../findings/nondegeneracy.md) against [Lemma L126](../findings/second-order.md) |
| (iii) branching clause, statement | **CONFIRMED** | true, and the repaired proof is shorter than the printed one |
| (iii) branching clause, proof as printed | **REFUTED** | the slice $N$ is affine and meets the sphere in $\{W\}$ alone, so the covering step is false, not merely unargued |
| "what is assembly and what is new" | **CORRECTED** | the negative half of (i) is mis-credited as new; it is in [DERIVE-df1.md](DERIVE-df1.md) in bold and in [Lemma L126](../findings/second-order.md)'s own statement |
| uniformity for [R16](../routes.md) | **MISSING, recoverable** | (iii) gives one neighbourhood per orbit; the uniform statement needs four extra lines **and a closed threshold** $\theta\ge\sqrt{3/2}$, which [I18](../plan.md) does not have |

---

## What I derived before reading the lemma

Recorded in [agent_logs/gate2-L128-B.log](../agent_logs/gate2-L128-B.log) at the phase-1 transition, before the lemma body was opened.

### $\rho(E_{jk})$ on $\Lambda^2$

With $E_{jk}e_j=e_k$, $E_{jk}e_k=-e_j$ and $\rho(A)(u\wedge v)=Au\wedge v+u\wedge Av$: $\rho(E_{jk})$ annihilates $e_{jk}$ and every $e_{ab}$ with $a,b\notin\{j,k\}$, and acts as a rotation generator in each of the $n-2$ planes $\langle e_{ji},e_{ki}\rangle$, $i\notin\{j,k\}$. For $W$ diagonal in the pair basis, $[A,W]_{\alpha\beta}=A_{\alpha\beta}(M_\beta-M_\alpha)$, so

$$[\rho(E_{jk}),W]=\sum_{i\notin\{j,k\}}(M_{ji}-M_{ki})\,e_{ji}\odot e_{ki}.$$

By linearity in $A=\sum a_{jk}E_{jk}$ every orbit direction is a sum of such vectors, one per pair block, so $T_W\mathcal O\subseteq\bigoplus_{\{j,k\}}V_{jk}$ and neither the four-set blocks nor $\mathcal D_n$ carries an orbit direction. **The positive and negative halves are one computation**, not two.

**Two things the printed proof skips.** The span of the $f_i=e_{ji}\odot e_{ki}$ has dimension $n-2$; $V_{jk}$ has dimension $n-3$ ([Lemma L120](../findings/second-order.md)). The containment holds because $\sum_{i\notin\{j,k\}}(M_{ki}-M_{ji})=-M_{kj}+M_{jk}=0$, using $M\mathbf 1=0$ and $M$ symmetric, Ricci-flatness, free from $W\in\mathcal W_n$, but used. Equivalently: $\mathcal W_n$ is $SO(n)$-invariant, so the orbit tangent lies in it automatically and $\mathcal W_n\cap\operatorname{span}\{f_i\}=V_{jk}$.

### The kernel of the Hessian

$P$ is a cubic form with $\langle X,Y\circ Z\rangle$ totally symmetric, so $\nabla P=3Q$ and $d^2P[X,X]=6\langle X,L_WX\rangle$. On $\{\lVert W\rVert=1\}$ the second fundamental form contributes $-\langle\nabla P,W\rangle\lVert X\rVert^2=-3\theta\lVert X\rVert^2$, giving $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, [Lemma L24](../findings/second-order.md), reproduced. Hence

$$\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp=E_{L_e}(\tfrac12),$$

the intersection being automatic: $L_eW=W$ and $L_e$ is self-adjoint, so $E(\tfrac12)\perp E(1)\ni W$.

**A frame-free proof that the orbit sits at $\tfrac12$, valid at every critical point.** $Q$ is equivariant, so $dQ_W[A\cdot W]=A\cdot Q(W)=\theta(A\cdot W)$; and $dQ_W[X]=2W\circ X=2\theta L_eX$. Hence $L_e(A\cdot W)=\tfrac12(A\cdot W)$, with no purity, no diagonality and no criticality beyond $Q(W)=\theta W$. [Lemma L122](../findings/second-order.md)'s computation of the same fact through the graph Laplacian is a check on the normalisation, not the source of the statement.

### The isolation argument I would give

$F(X)=3(Q(X)-P(X)X)$ is equivariant with $F|_{\mathcal O}=0$. On the **whole** of $\mathcal W_n$,

$$dF_W[X]=3\theta\big(2L_eX-X-3\langle W,X\rangle W\big),$$

which is self-adjoint, sends $W\mapsto-6\theta W$, and restricts to $6\theta(L_e-\tfrac12)$ on $W^\perp$. So under (ii), $\ker dF_W=T_W\mathcal O$ **in the ambient space**. Split $\mathcal W_n=T_W\mathcal O\oplus V'$, write $X=W+t+v$, and apply the implicit function theorem to $\Pi_{V'}F=0$: $\Pi_{V'}dF_W|_{V'}$ is invertible, so locally $v=\phi(t)$ and $F^{-1}(0)$ lies in a $\dim\mathcal O$-dimensional graph. $\mathcal O$ is a submanifold of that dimension inside $F^{-1}(0)$ tangent to $T_W\mathcal O$, hence equals the graph locally, hence $F^{-1}(0)=\mathcal O$ near $W$. Equivariance transports this to every $gW$; the orbit is compact, so finitely many such open sets cover it.

*No slice theorem, no tubular neighbourhood, and no use of $SO(n)$ beyond $\mathcal O\subseteq F^{-1}(0)$.*

---

## Part (i), CORRECTED

The statement is right and I re-derived it. Three defects in the proof, none fatal.

- **The dimension cut is elided.** "supported on the span of $f_i$ … which is [Lemma L122](../findings/second-order.md)'s basis of $V_{jk}$" identifies an $(n-2)$-dimensional span with an $(n-3)$-dimensional space. Repair: one clause, either the row-sum computation above or the invariance of $\mathcal W_n$. This is the only place Ricci-flatness enters (i), and it enters free.
- **The sign contradicts the proof's own convention.** The proof declares $e_{ji}\mapsto e_{ki}$, $e_{ki}\mapsto-e_{ji}$, which with its own commutator rule yields the coefficient $M_{ji}-M_{ki}$; the statement prints $M_{ki}-M_{ji}$. [DERIVE-df1.md](DERIVE-df1.md) declares the opposite $\rho$-action, $e_{ki}\mapsto e_{ji}$, $e_{ji}\mapsto-e_{ki}$, and gets $M_{ki}-M_{ji}$ consistently. L128 has taken DERIVE-df1's coefficient with the flipped action. **Spectrum- and span-neutral**, so no result moves, but the record has lost a cycle to a sign before, and this one is free to fix.
- **"fixes $e_{jk}$" should be "annihilates $e_{jk}$".** $\rho$ is the Lie algebra action.

---

## Part (ii), REFUTED as an iff, with the correction

**The printed condition.** "every four-set block and $\mathcal D_n\cap W^\perp$ have $L_e$-spectrum $<\tfrac12$, and every pair block has $\tfrac12$ either absent or simple with eigenvector $o^{jk}$."

**The correct condition.** Nondegeneracy is $E_{L_e}(\tfrac12)=T_W\mathcal O$. That forbids the value $\tfrac12$ off the orbit and says **nothing about values above it**: an eigenvalue $>\tfrac12$ is an ascent direction and leaves the kernel untouched. So the four-set and $\mathcal D_n$ clauses must read

$$\tfrac12\notin\sigma\big(L_e|_{V_{ijkl}}\big)\ \text{ for every four-subset},\qquad \tfrac12\notin\sigma\big(L_e|_{\mathcal D_n\cap W^\perp}\big).$$

**The lemma's own proof proves this and not the printed statement.** It ends "no block contributes a $\tfrac12$-vector beyond the $o^{jk}$, which is the stated condition", but "contributes no $\tfrac12$-vector" is not "spectrum $<\tfrac12$". The pair clause is already written in the correct absent-or-orbit form, so **the three clauses of (ii) are not even consistent with each other**: pair blocks are permitted eigenvalues above $\tfrac12$ and the other two families are not, with no reason given.

**The witness is on the record, and it is an internal contradiction.** Take $S^2\times S^4$ at $n=6$. It is pure (coordinate-diagonal), critical, $\theta>0$.

- [Lemma L11](../findings/nondegeneracy.md): "every two-block sphere product except $S^3\times S^3$ is Morse–Bott nondegenerate", and explicitly "$S^2\times S^4$ at the same $n=6$ is nondegenerate", established in exact arithmetic over $\mathbb Q$ at $n=6$.
- [Lemma L126](../findings/second-order.md): its four-set blocks sit at $\mu_{2,4}=\tfrac{n-2}{2(p-1)(q-1)}=\tfrac23>\tfrac12$, and "no $S^2\times S^q$ is a local maximum, its four-set block breaches [Lemma L24](../findings/second-order.md) outright".

So $S^2\times S^4$ satisfies $\ker\mathrm{Hess}=T_W\mathcal O$ while a four-set block has $L_e$-spectrum $\{\pm\tfrac23\}\not<\tfrac12$. The "only if" half of (ii) fails at it. Under the corrected condition it passes, as it must: $\tfrac23\ne\tfrac12$ and $-\tfrac23\ne\tfrac12$.

**What the printed condition actually is.** It is the conjunction of nondegeneracy with the [Lemma L24](../findings/second-order.md) local-maximum test on two of the three block families. That conjunction is a perfectly good sufficient condition, and it is exactly what [I22](../plan.md) asked for, as a **one-directional** implication ("let $W$ be a pure critical point at which every L121 and L122 block is $<\tfrac12$ … Then"). **The biconditional is L128's own upgrade of the plan item, and the upgrade is the error.**

**Consequence for the downstream clause.** (iii)'s closing sentence ("only where a non-orbit block eigenvalue equals exactly $\tfrac12$"), follows from the corrected (ii) and not from the printed one, under which a violation could equally be a block above $\tfrac12$. That sentence is further evidence that $\ne\tfrac12$ is what was meant.

### The granted diagonal case: (ii)'s $\mathcal D_n$ clause is a genuine hypothesis

Asked whether the clause is vacuous, circular, or live. **Live, and it is the heaviest half of [I18](../plan.md).**

- **What the clause says.** $\mathcal D_n$ is the tangent space at $W$ to the fixed-frame diagonal locus, a linear subspace of $\mathcal W_n$, and $L_e$ preserves it ([Lemma L120](../findings/second-order.md)). So $6\theta(L_e|_{\mathcal D_n\cap W^\perp}-\tfrac12)$ *is* the Hessian of $P$ restricted to the diagonal sphere. The clause reads: **$W$ is a nondegenerate critical point of the diagonal problem.**
- **What [README.md](../README.md) grants.** $\max P$ over the diagonal locus is attained at sphere products, for $n$ large. A **zeroth-order value statement**. It is not circular to assume the clause, because the clause is a second-order statement the grant does not contain.
- **Nor is it vacuous.** At a diagonal *maximiser*, maximality within $\mathcal D_n$ gives $\le\tfrac12$ by [Lemma L24](../findings/second-order.md) applied inside $\mathcal D_n$, but $\le$, never $\ne$. Degenerate diagonal critical points are already on the record: [Lemma L11](../findings/nondegeneracy.md) records the two-block plateau at the rival maximiser and the $\mathfrak{su}(m)$ Kähler family as Morse–Bott degenerate, with kernel excesses of $5,9,14,20,16$ in exact arithmetic over $\mathbb Q$. And the [R15](../routes.md)/DGK strongly-regular-graph families are non-maximal diagonal critical points about which the grant says nothing at all.
- **So [I18](../plan.md) contains a sub-problem the diagonal grant does not supply**: second-order nondegeneracy inside the diagonal locus at every pure critical point above the threshold. I18's sub-step (c) proposes to reach the L121 and L122 blocks from hollowness, zero row sums and $\lVert M\rVert\le\lVert W\rVert$; it says nothing about the $\mathcal D_n$ block, whose spectrum [Lemma L127](../findings/second-order.md) can only quote from [Lemma L27](../findings/nondegeneracy.md), i.e. only at sphere products with $p,q\ge3$. **That is the gap I18 should be re-graded against.**

---

## Part (iii), statement CONFIRMED, proof REFUTED as printed

**The statement is true.** The ambient-IFT argument above proves it, using only self-adjointness of $dF_W$, $\ker dF_W=T_W\mathcal O$, $\mathcal O\subseteq F^{-1}(0)$, and compactness of $\mathcal O$.

**The printed proof does not.** It sets $N=W+\big(T_W\mathcal O\big)^\perp\cap W^\perp$, an **affine** subspace whose direction space is orthogonal to $W$. For $v$ in that direction space,

$$\lVert W+v\rVert^2=1+\lVert v\rVert^2>1\quad\text{whenever }v\ne0,$$

so $N\cap S=\{W\}$ **exactly**, and $\bigcup_{g}g\cdot N$ meets the unit sphere precisely in $\mathcal O$. The conclusion "no critical point in $U$ other than $W$" is therefore true but empty (there is no other point of $S$ in $U$ to be critical) and the closing step, "the translated slices $g\cdot U$ cover a neighbourhood of the compact orbit $\mathcal O$", is **false**, not merely unargued. As printed the proof establishes nothing about $S$.

*The defect is inherited: [I22](../plan.md) sub-step (b) writes the same affine slice, $S_W=W+(T_W\text{orbit})^\perp\cap T_WS$.*

**Two repairs, either one line.**

1. **Linear-section slice.** Replace $N$ by $\Sigma=S\cap(T_W\mathcal O)^\perp$, the unit sphere of a linear subspace, a submanifold of $S$ through $W$ with tangent space $(T_W\mathcal O)^\perp\cap W^\perp$. Then $\Phi:SO(n)\times\Sigma\to S$, $(g,x)\mapsto g\cdot x$, has surjective differential at $(e,W)$ because $T_W\mathcal O+T_W\Sigma=T_WS$, so its image contains a neighbourhood of $W$ in $S$; every nearby critical point is $g\cdot x$ with $x\in\Sigma$ critical, hence $x=W$ by the IFT on $\Sigma$.
2. **Ambient IFT**, as above, shorter, and it needs no slice at all.

**Minor.** "$\mathrm{Crit}=F^{-1}(0)$" is false off the sphere ($F(0)=0$); the identity that holds is $\mathrm{Crit}=F^{-1}(0)\cap S$, and near $W$, where $P>0$, $F^{-1}(0)$ happens to coincide with $\mathcal O$, which is what makes repair 2 work.

---

## "What is assembly and what is new", CORRECTED

Checked line by line against [DERIVE-df1.md](DERIVE-df1.md), [Lemma L11](../findings/nondegeneracy.md) and [Lemma L27](../findings/nondegeneracy.md).

| L128's claim | verdict |
|---|---|
| Hessian normalisation $6\theta(L_e-\tfrac12\mathrm{Id})$ is [Lemma L24](../findings/second-order.md)'s | **correct** |
| block decomposition and block-diagonality are [Lemma L120](../findings/second-order.md)'s | **correct** |
| pair-block form and $L_eo^{jk}=\tfrac12o^{jk}$ are [Lemma L122](../findings/second-order.md)'s | **correct**, and the eigenvalue fact is on record three times over ([Lemma L24](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md)'s $\mathbb R^p\otimes\mathbb R^q$ row, [Lemma L122](../findings/second-order.md)) |
| location of the orbit direction is [DERIVE-df1.md](DERIVE-df1.md)'s | **correct** |
| **new: the negative half of (i), that four-set blocks and $\mathcal D_n$ are orbit-free** | **MIS-CREDITED** |
| new: the criterion (ii) at an arbitrary pure critical point | **over-generous**, see below |
| new: the proof of (iii), which [Lemma L11](../findings/nondegeneracy.md) asserts without argument | **correct** |

**The negative half is not new.** [DERIVE-df1.md](DERIVE-df1.md) §DF1b step 4(ii) prints it in bold, with the identical linearity argument L128 gives:

> **The conclusion survives by linearity … So the whole orbit lies in the sum of the pair blocks**, and the $4$-set and diagonal blocks contain no orbit direction, no counting needed, and the statement holds whatever the isotropy is.

[Lemma L126](../findings/second-order.md) then carries it into [findings/](../findings/) inside its own bolded statement: "The four-set blocks are orbit-free: the orbit tangent for the $(j,k)$ generator lies in the $\{j,k\}$ pair block, so the orbit's tangent space lies in the span of the pair blocks." L128's footnote ("reproved here because (ii) needs the negative half of it"), reads as though [DERIVE-df1.md](DERIVE-df1.md) lacked it, in the same sentence that cites it. It did not. **The load-bearing sentence of the novelty claim should be struck.** The same footnote's isotropy corollary is also on record, credited in [DERIVE-df1.md](DERIVE-df1.md) to [r347](REVIEW_r347.md); L128's refinement of it (the $E_{jk}$ whose rows of $M$ agree off $\{j,k\}$), is correct and is a fair addition.

**"the criterion (ii) … rather than at the sphere products, where [Lemma L11](../findings/nondegeneracy.md) and [Lemma L27](../findings/nondegeneracy.md) already have it."** L11 and L27 have *nondegeneracy* at sphere products, not a block criterion; the block table at sphere products is [Lemma L127](../findings/second-order.md)'s. Stating a criterion at an arbitrary pure point is a fair claim of first-writing-down, with the caveat that the part genuinely new relative to [I22](../plan.md), namely the *converse* direction, is the part refuted above.

---

## Part (iii) against [R16](../routes.md): the uniformity is missing, and it is recoverable

**What (iii) delivers.** One neighbourhood per orbit: for each pure critical $W$ satisfying (ii), *some* $\varepsilon(\mathcal O)>0$ with no critical point within $\varepsilon$ of $\mathcal O$ outside $\mathcal O$. Nothing in the lemma bounds $\varepsilon$ below across orbits. [I5](../plan.md) wants positive **distance**, a single number. **As stated, the lemma does not give it.**

**It is recoverable in four lines, and they belong in the lemma.** Fix $c=\sqrt{3/2}$ and let

$$A=\overline{\{X\in S:\ X\ \text{critical},\ \theta(X)>c,\ X\ \text{non-pure}\}},\qquad B=\big(O(n)\cdot\mathcal D_n\big)\cap S.$$

$B$ is the continuous image of the compact $O(n)\times(\mathcal D_n\cap S)$, hence compact; $A$ is a closed subset of the compact $S$, hence compact. Suppose $Y\in A\cap B$. Then $Y$ is critical ($\mathrm{Crit}$ is closed), $\theta(Y)\ge c$, and pure. By (ii) and (iii) at $Y$ some neighbourhood of $\mathcal O_Y$ contains no critical point off $\mathcal O_Y$, contradicting $Y=\lim X_m$ with each $X_m$ critical and non-pure, hence off the pure orbit $\mathcal O_Y$. So $A\cap B=\varnothing$, and two disjoint compacts are at positive distance. **That is exactly [I5](../plan.md)'s theorem**, and it needs no finite subcover and no Lebesgue number.

**But it needs a hypothesis [I18](../plan.md) does not currently state.** The limit point $Y$ carries $\theta(Y)\ge c$, not $\theta(Y)>c$. [I18](../plan.md) is written at "$\theta>\sqrt{3/2}$" and [Lemma L128](../findings/second-order.md)'s "Where it is used" repeats it. **The bridge needs (ii) at every pure critical point with $\theta\ge\sqrt{3/2}$, the closed threshold.** Two ways to discharge it, and the choice should be made explicitly:

- prove (ii) on $\{\theta\ge\sqrt{3/2}\}$, which the intended route through the opposite-pair sums $A,B,C$ costs nothing extra; or
- prove separately that **no pure critical point has $\theta=\sqrt{3/2}$ exactly**, which would collapse the two thresholds. Note that the value $\sqrt{3/2}$ is not an idle choice of boundary: it is attained exactly, by $W_{\mathbb{CP}^2}$ ([Lemma L124](../findings/second-order.md)). That point is **not** pure, so it does not itself break the bridge, but the coincidence is close enough that the boundary deserves a sentence rather than silence.

**Verdict on the fourth attack.** The uniformity is missing from the lemma and the omission is real, but it is a scope defect rather than a weakness of substance: the compactness bridge is short, and the only thing it genuinely adds to the burden is the closed threshold. **The lemma's real weakness is (ii)'s false converse and (iii)'s void proof, not the uniformity.**

---

## Hypotheses: what is used, what is stated, what is missing

| hypothesis | used? | stated? |
|---|---|---|
| $\theta>0$ | yes, the Hessian formula divides by $\theta$, and [Lemma L24](../findings/second-order.md) reverses at $\theta<0$ | **yes** |
| $\lVert W\rVert=1$ | yes | **yes** |
| $W$ pure in the reference frame | yes, [Lemma L120](../findings/second-order.md) block-diagonality and [Lemma L121](../findings/second-order.md)/[Lemma L122](../findings/second-order.md) blocks | **yes** |
| Ricci-flatness, i.e. $M\mathbf 1=0$ | yes, twice, the $n-2\to n-3$ cut in (i), and [Lemma L122](../findings/second-order.md)'s Laplacian rewriting, whose scope note in [Lemma L123](../findings/second-order.md) says so | **not stated, and free**: it is the Weyl condition, automatic from $W\in\mathcal W_n$. Worth one clause in (i), where the dimension count silently depends on it |
| $n\ge12$, or any dimension bound | **no**, [Lemma L120](../findings/second-order.md) uses the **full** sign group $\Gamma\subset O(n)$, whose even-subset characters are distinct at every $n$; the $n=4,6,8$ fusion is a $\Gamma\cap SO(n)$ failure only | correctly absent |
| the frame being an eigenframe of anything | **no**, "pure" names its own frame | correctly absent |
| $\ker W=0$ | **no** | correctly absent |
| the granted diagonal case | **no**, and it would not help, see the $\mathcal D_n$ discussion | correctly absent |

**One presentational note.** (ii) writes "$\mathcal D_n\cap W^\perp$" and the proof adds "$W\in\mathcal D_n$ is removed by the restriction to $W^\perp$". The removal is automatic, not a restriction one has to impose: $L_eW=W$ and $L_e$ is self-adjoint, so $E(\tfrac12)\perp\mathbb RW$ already. Harmless.

**The $SO(n)$ against $O(n)$ choice.** [I22](../plan.md) states the theorem for $O(n)\cdot W$ and L128 for $SO(n)\cdot W$. Immaterial: the two orbits have the same tangent space, $O(n)\cdot W$ is a finite union of $SO(n)$-orbits, and (iii) for one gives (iii) for the other. Worth a half-line so a later reader does not re-open it.

---

## The corrected lemma, as it should be written

> **(i)** unchanged in substance; add the clause "and $\sum_i o^{jk}_i=M_{jk}-M_{kj}=0$ by Ricci-flatness, so $o^{jk}\in V_{jk}$"; fix the coefficient sign against the declared $\rho$-action; strike the novelty claim on the negative half and cite [DERIVE-df1.md](DERIVE-df1.md) and [Lemma L126](../findings/second-order.md) for it.
>
> **(ii)** $W$ is Morse–Bott nondegenerate **if and only if** $\tfrac12\notin\sigma(L_e)$ on every four-set block and on $\mathcal D_n\cap W^\perp$, and on every pair block $\tfrac12$ is either absent or simple with eigenvector $o^{jk}$. *Separately*: the strict form, every such block $<\tfrac12$, is the conjunction of nondegeneracy with [Lemma L24](../findings/second-order.md)'s local-maximum test, and is what [I18](../plan.md) should aim at, but it is not equivalent to nondegeneracy, as $S^2\times S^4$ shows.
>
> **(iii)** unchanged in statement; replace the proof by the ambient-IFT argument, or by the linear-section slice $S\cap(T_W\mathcal O)^\perp$. **Add the corollary**: if (ii) holds at every pure critical point with $\theta\ge c$, then the non-pure critical set is at positive distance from the whole pure locus, the compactness bridge above, which is what [I5](../plan.md) consumes.

---

## Computation

**None run.** The [analysis-only rule](../.claude/rules/analysis-only.md) permits a screen of a claim about to be recorded; no claim here needed one. The witness for the (ii) refutation is [Lemma L11](../findings/nondegeneracy.md)'s exact-arithmetic nondegeneracy of $S^2\times S^4$ read against [Lemma L126](../findings/second-order.md)'s $\mu_{2,4}=\tfrac23$, both already on the record, and their conflict with L128 is settled by reading, not by running.

**What a run would decide, if one were approved.** Nothing this review turns on. The nearest useful item is [I18](../plan.md) sub-step (a), pinning the strongly-regular-graph-to-$W$ normalisation so that a DGK point's L121 and L122 blocks become quotable, and that is I18's business, not L128's.
