# REVIEW r630, Lemma L75

**Target:** Lemma L75, "maximal isotropy, characterised three ways", [findings/isotropy-cap.md:183](../findings/isotropy-cap.md), the heading, the displayed chain of equivalences, the four-row table, the singular-value sentence, the rank-$15$ sentence and the structural paragraph that closes the block. Index row at [findings/INDEX-results.md:90](../findings/INDEX-results.md), which records **"Gate 2: no verdict on the record."**

**Reviewer:** r630, cold, adversarial, **analysis-only footing**. No search, sweep, census, optimisation or rank run was performed, and none of the block's numerics was re-run or extended. Everything below was derived from the definitions in [conventions.md](../findings/conventions.md) and [isotropy-cap.md](../findings/isotropy-cap.md) before the block was read for its reasoning. **One screen** was taken, exact rational arithmetic on $\mathfrak{so}(4)$ structure constants, seconds of compute, on an object constructed here, and it is reported as a screen in §3 and is never the ground of a positive claim; the witness it screens is derived by hand in the same section. Quantities the block presents as measurements are re-derived in closed form and reported as derivations.

**VERDICT: REFUTED as stated.** The chain of three conditions is **not** a chain of equivalences. The first two are equivalent and the equivalence is self-contained, $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ entails isotropy on its own, because the inclusion $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ *is* isotropy verbatim. The third is **strictly weaker**: it fixes a dimension without fixing a subspace, and $\mathfrak{so}(3)\subset\mathfrak{so}(4)$ satisfies it while failing isotropy. **So both reviewers of the neighbouring result are right, and their claims never conflicted**: one is about condition 3, the other about condition 2, and the audit's premise (that they are compatible only if 2 and 3 differ in strength), is exactly what holds. The repair is five words: the third condition needs "for isotropic $\mathfrak m$" attached, and the block's own next paragraph already uses the containment that supplies it. Four further defects follow (§5–§7): the table is a corollary of results the record now holds rather than evidence, with $d=6$ the only row lacking a closed form; the $d=4$ "climb into the maximal-$5$ family" clause is **false** by construction; the dimension list $\{5,6,9\}$ is **stale against its own file sixty lines below**, where $\{5,6,7,8,9\}$ stands; and the varying-dimension claim is a **theorem** at every $n\ge4$, so the four rows were never needed. The Witt comparison is **apt and load-bearing**, and the block states the contrast without the one line that causes it. Provenance is **clean**.

---

## 1, Conventions, pinned before anything was derived

[conventions.md](../findings/conventions.md) is incomplete, as the brief warns. The reading adopted here is stated for every symbol L75 uses.

| object | reading adopted here | pinned at | status |
| --- | --- | --- | --- |
| $\langle X,Y\rangle$ | $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings", bullets 1–2 | the record's choice, pinned twice ([r519](REVIEW_r519.md), [r520](REVIEW_r520.md)) |
| $N$ | $\binom n2$; $N=15$ at $n=6$, $N=6$ at $n=4$ | [conventions.md](../findings/conventions.md), "The objects" | consistent with every row of the table |
| $\omega$ | the Cartan $3$-form $\omega(x,y,z)=\langle[x,y],z\rangle$, **totally antisymmetric** | [isotropy-cap.md:11](../findings/isotropy-cap.md); antisymmetry at [conventions.md](../findings/conventions.md), "Structure constants" | total antisymmetry is load-bearing in §2 and the block never invokes it |
| isotropic | $\omega(u,v,w)=0$ for all $u,v,w\in\mathfrak m$ | [isotropy-cap.md:17](../findings/isotropy-cap.md), L36's statement | the only definition on the record |
| $[\mathfrak m,\mathfrak m]$ | the **span** $\mathop{\mathrm{span}}\{[u,v]:u,v\in\mathfrak m\}$, a subspace of $\mathfrak{so}(n)$ | not stated in the block | the only reading under which $\perp$ and $\mathop{\mathrm{rank}}$ both parse |
| $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$ | $\dim[\mathfrak m,\mathfrak m]$, equivalently the rank of the bracket map $\Lambda^2\mathfrak m\to\mathfrak{so}(n)$ | not stated in the block | the two agree, the second being the first's image |
| $\mathfrak m$ | a **free variable** over subspaces of $\mathfrak{so}(n)$, L75 mentions no Weyl operator and no critical point | [conventions.md](../findings/conventions.md) tables three other senses | see **D1** |

**D1, $\mathfrak m$ is used in a fourth sense and the block does not say so.** [conventions.md](../findings/conventions.md) tables three senses, all tied to a Weyl operator: $E_{\min}$ at a critical point, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part. L75's statement is pure Lie algebra with $\mathfrak m$ quantified over arbitrary subspaces. **This matters here rather than being pedantry**: under a reading in which "$\mathfrak m$ is isotropic" is a standing property of the ambient section, the block's chain is true; under the reading its own heading forces ($\mathfrak m$ free, "maximal isotropic" as the left-hand side of an *iff*), the third link is false. §4 shows the two readings are not interchangeable.

The three gaps the brief names in [conventions.md](../findings/conventions.md) (the $S_{XYZ}$ normalisation, the $\theta_0$ parity gloss, the $\mathfrak m$ senses), reach this audit only through the third. **Neither $S_{XYZ}$ nor $\theta_0$ is used by L75**, so [L77](../findings/isotropy-cap.md)'s live normalisation collision does not touch this result.

## 2, The first equivalence: one containment is definitional, the other is the content

Fix a subspace $\mathfrak m\subseteq\mathfrak{so}(n)$.

**(a) $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ is isotropy, restated.** Isotropy says $\langle[u,v],w\rangle=0$ for all $u,v,w\in\mathfrak m$. Holding $w$ fixed and letting $u,v$ range, this says $w\perp[u,v]$ for every generator of $[\mathfrak m,\mathfrak m]$, hence $w\perp[\mathfrak m,\mathfrak m]$ by linearity of the inner product in its first slot. Letting $w$ range gives $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$, and every step reverses. So

$$\mathfrak m\ \text{isotropic}\iff\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp .$$

This inclusion carries **no content beyond the definition**. It is a change of notation, one line, no antisymmetry needed.

**(b) $[\mathfrak m,\mathfrak m]^\perp\subseteq\mathfrak m$ is maximality, and it is the content.** Let $\mathfrak m$ be isotropic and $w\in\mathfrak{so}(n)$. Then

$$\mathfrak m+\mathbb Rw\ \text{is isotropic}\iff w\in[\mathfrak m,\mathfrak m]^\perp .$$

*Proof.* By trilinearity it suffices to test $\omega$ on triples drawn from a spanning set of $\mathfrak m+\mathbb Rw$. Triples with three entries in $\mathfrak m$ vanish by hypothesis. Triples with exactly one entry $w$ give $\omega(u,v,w)=\langle[u,v],w\rangle$, which vanishes for all $u,v\in\mathfrak m$ precisely when $w\perp[\mathfrak m,\mathfrak m]$. **Triples with $w$ repeated vanish because $\omega$ is alternating**, this is where total antisymmetry of $c_{\alpha\beta\gamma}$ is consumed, and the block does not mention it. $\square$

**(c) The reduction to one-dimensional extensions.** Maximality quantifies over all larger isotropic subspaces, not over one-dimensional extensions. The bridge: if $\mathfrak m'\supsetneq\mathfrak m$ is isotropic, pick $w\in\mathfrak m'\setminus\mathfrak m$; then $\mathfrak m+\mathbb Rw\subseteq\mathfrak m'$ is isotropic, since **any subspace of an isotropic subspace is isotropic**. So a maximal-under-one-step $\mathfrak m$ is maximal outright.

**D2, the block gives (a) implicitly, half of (b), and none of (c).** Its whole argument is *"Adding $w$ to an isotropic $\mathfrak m$ needs $\langle[u,v],w\rangle=0$ for all $u,v\in\mathfrak m$, i.e. $w\perp[\mathfrak m,\mathfrak m]$, linear in $w$"*. That establishes **necessity** and asserts the converse. The converse needs the alternating property, and the passage from "no line extends $\mathfrak m$" to "no subspace extends $\mathfrak m$" needs the hereditary remark. Both are one line each; **the gap is reachable and is filled above**. The word "needs" is doing the hedging: it states a necessary condition and the display then reads it as an *iff*.

Combining, **for isotropic $\mathfrak m$**: maximal $\iff[\mathfrak m,\mathfrak m]^\perp\subseteq\mathfrak m$. And since isotropy is the reverse inclusion by (a),

$$\boxed{\ \mathfrak m\ \text{maximal isotropic}\iff[\mathfrak m,\mathfrak m]^\perp=\mathfrak m\ }$$

**with no hypothesis at all**, the equality entails isotropy through (a) and maximality through (b) and (c). **The second reviewer of the neighbouring result is right, and the block's choice of the equality form over an inclusion is therefore correct.** The block never says why, and the reason is exactly (a): the inclusion the reader is tempted to weaken to is the half that carries the isotropy hypothesis.

## 3, The witness: the rank count holds for a non-isotropic subspace

Take $n=4$, $N=\binom42=6$, and $\mathfrak m=\mathfrak{so}(3)=\mathop{\mathrm{span}}(\varphi_{12},\varphi_{13},\varphi_{23})$, $d=3$.

**Bracket span.** $\mathfrak{so}(3)$ is a simple Lie algebra, so $[\mathfrak m,\mathfrak m]=\mathfrak m$ and $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=3$. Explicitly, with $\varphi_{ab}=E_{ab}-E_{ba}$,

$$[\varphi_{12},\varphi_{13}]=-\varphi_{23},\qquad[\varphi_{12},\varphi_{23}]=\varphi_{13},\qquad[\varphi_{13},\varphi_{23}]=-\varphi_{12},$$

so the span is all of $\mathfrak m$.

**The rank count.** $N-\dim\mathfrak m=6-3=3=\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$. **The third condition holds.**

**Isotropy.** $\langle[\varphi_{12},\varphi_{13}],\varphi_{23}\rangle=\langle-\varphi_{23},\varphi_{23}\rangle=-\lVert\varphi_{23}\rVert^2=-1\ne0$ under the half-trace pairing of [conventions.md](../findings/conventions.md). **$\mathfrak m$ is not isotropic**, and *a fortiori* not maximal isotropic. Equivalently $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m^\perp=\mathop{\mathrm{span}}(\varphi_{14},\varphi_{24},\varphi_{34})\ne\mathfrak m$: the two sides have the same dimension and intersect in $0$.

**Screen.** Exact rational arithmetic over $\mathbb Q$ on the $6\times6$ coordinate structure constants, constructed here, seconds of compute: $\langle[\varphi_{12},\varphi_{13}],\varphi_{23}\rangle=-1$, $\dim[\mathfrak m,\mathfrak m]=3$, $N-d=3$. It agrees with the hand derivation above, which is the ground of the claim.

**Independent of the pairing convention.** Under plain Frobenius every inner product doubles; $-1$ becomes $-2$ and the rank is unchanged. **The witness survives both normalisations**, which matters because [conventions.md](../findings/conventions.md) records the pairing as a place two reviewers once disagreed.

The same witness is already on the record twice, at [L36](../findings/isotropy-cap.md) (*"an isotropic subalgebra is abelian … at $n=6$ already $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1\ne0$"*) and at [L77](../findings/isotropy-cap.md) (*"At $n=4$ with $\mathfrak m=\mathfrak{so}(3)$, $d=3$: $\mu=6$ and $\gamma=0$"*). **L77's witness is this one and its rank count was never read off.**

## 4, The third condition is strictly weaker, so the chain is false as written

$\dim[\mathfrak m,\mathfrak m]^\perp=N-\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$, so

$$\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m\iff\dim[\mathfrak m,\mathfrak m]^\perp=\dim\mathfrak m .$$

**That is a dimension equality, not a subspace equality.** Two subspaces of equal dimension coincide only when one contains the other. So:

| implication | status | reason |
| --- | --- | --- |
| $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m\Rightarrow\mathop{\mathrm{rank}}=N-d$ | **holds**, unconditionally | equal subspaces have equal dimension |
| $\mathop{\mathrm{rank}}=N-d\Rightarrow[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ | **fails** | $\mathfrak{so}(3)\subset\mathfrak{so}(4)$, §3 |
| $\mathop{\mathrm{rank}}=N-d$ **and $\mathfrak m$ isotropic** $\Rightarrow[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ | **holds** | isotropy gives $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ by §2(a); equal dimensions then force equality |

**So the block's third condition is strictly weaker than its second, and the displayed chain of two *iff*s is false at its second link.** The heading is the sharper offender: it writes "$\mathfrak m$ maximal isotropic iff $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ iff $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$" with $\mathfrak m$ unquantified, and it is the heading that is quoted, [L76](../findings/isotropy-cap.md)'s block, [INDEX-results.md:90](../findings/INDEX-results.md) and the census refutation all consume "the exact rank criterion" by that name.

**The repair.** Either attach the hypothesis,

$$\text{for isotropic }\mathfrak m:\quad\mathfrak m\ \text{maximal}\iff[\mathfrak m,\mathfrak m]^\perp=\mathfrak m\iff\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$$

or drop the third condition and keep the unconditional two-way form of §2. The first is preferable, since **every consumer uses the rank form as a computational test** and needs to know that isotropy must be verified separately. This is precisely the omission [L77](../findings/isotropy-cap.md) was repaired for forty lines below, and the two blocks were written into the same file.

**D3, the block already uses the missing hypothesis, four lines under the chain that drops it.** Its rank-$15$ sentence reasons *from* $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp$ (§5 below). So the containment is in the block, doing diagnostic work, while the criterion above it is stated without it.

**Reconciling the two neighbouring reviewers.** They disagree about nothing. Condition 2 needs no external hypothesis (§2); condition 3 does (§4). The brief's conditional (*"these are compatible only if the second and third conditions differ in strength"*), is discharged in the affirmative.

## 5, Why rank $15$ is impossible: the one-line argument the block owes

Let $\mathfrak m\ne0$ be isotropic. By §2(a), $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp$, hence

$$\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]\ \le\ \dim\mathfrak m^\perp\ =\ N-\dim\mathfrak m\ \le\ N-1 .$$

At $n=6$, $d=6$ this reads $\mathop{\mathrm{rank}}\le9$, so a reported $15=N$ is impossible twice over, it exceeds the ceiling $9$ and it is full rank, which forces $[\mathfrak m,\mathfrak m]^\perp=0$ and so $\mathfrak m=0$. **The tell was sound and the block is right to keep it.** Note what it means for the table: the inequality $\mathop{\mathrm{rank}}\le N-d$ is automatic for every isotropic $\mathfrak m$, so **the whole table is the single question "is the ceiling attained?"**, i.e. "is the bracket map $\Lambda^2\mathfrak m\to\mathfrak m^\perp$ surjective?" That is a cleaner statement of the criterion than the one the block gives, and it makes the $d=4$ row's answer visible without a run.

## 6, The table is a corollary, and $d=6$ is the only row that needs a measurement

$n=6$, $N=15$. Column "free" is $N-d-\mathop{\mathrm{rank}}=\dim\big([\mathfrak m,\mathfrak m]^\perp/\mathfrak m\big)$, which checks: $11-6=5$ at $d=4$.

**$d=4$, a theorem, no run.** $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]\le\dim\Lambda^2\mathfrak m=\binom42=6<11=N-d$. So the ceiling of §5 is **unattainable for dimension reasons** and every isotropic $4$-subspace extends. Generally, a maximal isotropic satisfies $N-d\le\binom d2$, i.e. $\binom n2\le\binom{d+1}2$, i.e.

$$d\ \ge\ n-1,$$

**tight**, with equality realised at $p=1$ in §7. At $n=6$ that is $d\ge5$, so the $d=4$ row is this bound at its fencepost. **Confirmed against the brief's report of the neighbouring audit.**

**$d=5$ and $d=9$, closed form, via [L76](../findings/isotropy-cap.md)'s odd parts $\mathfrak p_{p,q}\cong\mathbb R^p\otimes\mathbb R^q$.** There $\mathop{\mathrm{rank}}=\binom p2+\binom q2=\binom n2-pq=N-d$ identically, and the singular values are $\sqrt{2p}$ with multiplicity $\binom q2$ and $\sqrt{2q}$ with multiplicity $\binom p2$.

| row | closed-form witness | rank | singular values predicted | block's report |
| --- | --- | --- | --- | --- |
| $d=5$ | $(p,q)=(1,5)$ | $\binom12+\binom52=0+10=10=N-5$ | $\sqrt{10}^{\times0}$, $\sqrt2^{\times10}$, ten values, then nothing | rank $10$, free $0$, **maximal** |
| $d=9$ | $(p,q)=(3,3)$ | $\binom32+\binom32=6=N-9$ | $\sqrt6^{\times3}$ twice, **six values of exactly $\sqrt6$, then nothing** | *"six values of exactly $\sqrt6$ then nothing"* |

The $d=9$ prediction reproduces the block's sentence word for word. **So the $\sqrt6$ is exact for a reason, and "exactly" is earned, but by a closed form the block does not have, not by the run it reports.**

**$d=6$, the only row with no closed form on the record.** No symmetric pair gives $pq=6$ at $n=6$: the available $(p,q)$ are $(1,5),(2,4),(3,3)$ with $pq=5,8,9$. Nor does the $(2,3)$ pair of $\mathfrak{so}(5)$ padded into $\mathfrak{so}(6)$ work, it has $pq=6$ and is isotropic, but $[\mathfrak p,\mathfrak p]=\mathfrak{so}(2)\oplus\mathfrak{so}(3)$ has dimension $4\ne9=N-d$, so it **extends** in $\mathfrak{so}(6)$. **So $d=6$ rests on the run and cannot be lifted off it without a construction**, and the same holds for the $d=7$ maximal recorded sixty lines below. Deciding whether a closed-form $6$-dimensional maximal isotropic exists at $n=6$ is an open question, **not** one I open a computation for under the standing rule; what a run could decide is only whether a particular candidate is generic, which is what the block already reports.

**Verdict on the table: it is a corollary of $d\ge n-1$ and of [L76](../findings/isotropy-cap.md)'s closed form for three of its four rows, and evidence for one.** Presenting it as measured evidence for the criterion inverts the dependency.

**D4, the rows carry no quantifier, and read as universal two of them are false.** "$d=5$ … maximal" is false for *every* isotropic $5$-subspace: take any $5$-dimensional subspace of the cap $\mathfrak p_{3,3}$. It is isotropic (subspaces of isotropic spaces are isotropic), its bracket span lies in $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ of dimension $6$, so $\mathop{\mathrm{rank}}\le6<10=N-d$ and it **extends**. The same construction breaks "$d=6$ … maximal". The rows are statements about the **generic** subspace at each dimension; the caveat exists on the record (*"these rows describe the generic subspace at each dimension and are not a classification"*) but it sits in the census block sixty lines below, attached to a different table, and **the L75 table does not carry it**. This is the same failure the census block itself names: *"A caveat in the text does not weaken a claim in the heading."*

**D5, "clean singular-value gaps throughout" is unearned in two ways.** *Throughout* covers four rows and gaps are quoted for two. And no normalisation of the spanning set $\{[e_a,e_b]\}$ is stated, so "a ninth of $0.436$" has no scale against which $3.5\times10^{-9}$ is clean; at the cap the gap is infinite and exact, which the closed form explains and the sentence conflates with the numerical one.

**D6, "The $d=4$ rows are consistent: they climb into the maximal-$5$ family rather than toward the cap" is false as written**, and the witness is the construction of D4. Take a $4$-dimensional subspace of $\mathfrak p_{3,3}$: it is isotropic and it extends **toward the cap**, within the $9$-dimensional family, by construction. The clause is true of the sampled generic $4$-subspaces and false of all of them; and "rows" is plural where the table has one such row. *Consistent* is the hedge, with what is never said, and after §6 the row is forced rather than consistent.

## 7, The structural claim: the list is stale, the theorem is free, and Witt is apt

**The list.** *"Maximal isotropics occur at dimensions $5$, $6$ and $9$"* is **stale against its own file**. Sixty lines below, the census refutation states *"Maximal dimensions now known at $n=6$ include $5$, $6$, $7$, $8$ and $9$"*, and gives $d=8$ as the $(2,4)$ pair with $\mathop{\mathrm{rank}}=7=N-8$. **The correct list at $n=6$ is $\{5,6,7,8,9\}$**, and by §6 that is the *whole* of the permitted interval $[n-1,\lfloor n^2/4\rfloor]=[5,9]$, the lower end being the $d\ge n-1$ bound and the upper end [L36](../findings/isotropy-cap.md)'s cap. **So the sharp statement available is stronger than the corrected list**: at $n=6$ every admissible dimension is realised.

**The varying-dimension claim is a theorem. Confirmed, at every $n\ge4$, with no numerics.**

> **Claim.** For $n\ge4$ and each $1\le p\le\lfloor n/2\rfloor$ with $q=n-p$, the odd part $\mathfrak p_{p,q}=\mathop{\mathrm{span}}\{\varphi_{ij}:i\le p<j\}$ is a maximal isotropic subspace of $\mathfrak{so}(n)$ of dimension $pq$. Hence at least $\lfloor n/2\rfloor$ distinct dimensions carry a maximal isotropic.
>
> *Proof.* **Isotropy**: in the $\varphi$ basis $\omega$ is supported exactly on triangles of $K_n$ ([L36](../findings/isotropy-cap.md), the Mantel paragraph), and $K_{p,q}$ is triangle-free. **Bracket span**: $[\varphi_{ij},\varphi_{kj}]=\pm\varphi_{ik}$ for $i,k\le p<j$ generates $\mathfrak{so}(p)$, symmetrically $\mathfrak{so}(q)$, and brackets on four distinct indices vanish, so $[\mathfrak p_{p,q},\mathfrak p_{p,q}]=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ exactly. **Perp**: the $\varphi$ basis is orthogonal and its three index classes partition it, so $(\mathfrak{so}(p)\oplus\mathfrak{so}(q))^\perp=\mathfrak p_{p,q}$. By §2 the subspace is maximal isotropic. **Distinctness**: $p\mapsto p(n-p)$ is strictly increasing on $1\le p\le n/2$, so the $\lfloor n/2\rfloor$ dimensions $p(n-p)$ are pairwise distinct. $\square$

At $n=6$ this gives $5,8,9$ from $p=1,2,3$, **three distinct dimensions, two of which the block's list omits, all in closed form.** The equivalent rank identity is the polynomial $\binom{p+q}2=\binom p2+\binom q2+pq$. **So four rows of numerics were never needed for the conclusion the block draws from them**, and the conclusion the record actually needs (*"the middle band cannot inherit the cap rigidity"*), follows from a single pair, $(1,n-1)$, at every $n\ge4$.

**The Witt comparison is apt and load-bearing, and the block states it without its cause.** For a nondegenerate symmetric bilinear form the criterion has the *same shape*: $\mathfrak m$ isotropic $\iff\mathfrak m\subseteq\mathfrak m^\perp$, maximal isotropic $\iff\mathfrak m=\mathfrak m^\perp$. The analogy is therefore structural rather than decorative, and it identifies the exact point of divergence:

| | quadratic form | Cartan $3$-form |
| --- | --- | --- |
| maximality criterion | $\mathfrak m=\mathfrak m^\perp$ | $\mathfrak m=[\mathfrak m,\mathfrak m]^\perp$ |
| dimension of the right side | $N-d$, **determined by $d$** | $N-\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$, **a free parameter** |
| consequence | $2d=N$: one dimension, the Witt index | $d+\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N$: many dimensions |

**One line, and it turns the contrast into an explanation.** It also shows the block's own reason for a Witt index to be unavailable is the very rank quantity its table tabulates. *(A quadratic form's maximal totally isotropic subspaces share a dimension in the degenerate case too (radical plus the nondegenerate part's Witt index) so the contrast needs no nondegeneracy caveat.)*

## 8, Provenance, pointers and hedges

**Provenance: clean.** The block carries no self-historical note, so there is nothing to falsify; checked anyway by distinctive-phrase grep. The chain, the four-row table and both the singular-value and rank-$15$ sentences enter at commit `fefce494` *"feat(conjecture-a): maximality of isotropic subspaces is a rank identity"*, 2026-08-23, and the block text is a faithful transcription of it. The structural sentence and the Witt clause enter one commit earlier, commit `51f8e8d5` *"the 3-form's maximal isotropics differ in dimension"*, same day. The numbered heading is a bulk retrofit, `5b258c14` and `8d34609b`, 2026-09-02, **the same retrofit pattern that mislabelled [L76](../findings/isotropy-cap.md) and left [L77](../findings/isotropy-cap.md) unhypothesised**, and here it is the retrofit that first states the chain with "maximal isotropic" as the left side, making the missing hypothesis quotable.

**One thing the commit message has and the block does not.** commit `fefce494`'s body reads *"adding w to an **isotropic** m needs …"*, and then displays the chain without it. **The hypothesis was in the author's hand at the moment of writing and was lost in the display line**, which is why §4's repair is a restoration rather than a correction.

**Pointers.** The L75 block contains **no links at all**, including none to [L36](../findings/isotropy-cap.md) whose cap its $d=9$ row uses and none to [L76](../findings/isotropy-cap.md) which supplies the closed forms for three of its four rows; the traffic runs the other way, L76 linking L75 twice. Across the file, of the eight in-file anchors **seven fail to resolve**: the empty `](#)` at [line 364](../findings/isotropy-cap.md) pointing at L36; four copies of `#lemma-l32--a-bivectors-centraliser-collapses-to-a-line` at lines 269, 291, 297 and 271, whose heading now ends *"canonical statement and proof"*; `#lemma-l81--the-sharp-centraliser-criterion-wider-than-lemma-l32--requires-pge2` at line 271, whose heading now reads *"REQUIRES $m\ne3$"*; and line 15's L36 anchor, which encodes `n22` where the heading carries $\lfloor n^2/4\rfloor$, a relic of an earlier $\lfloor n^2/2\rfloor$ heading. Only line 360's L79 anchor resolves. *None of these is inside the L75 block; they are reported because the audit checked them.*

**Hedges, taken one by one.**

| clause | verdict |
| --- | --- |
| "characterised three ways" | **false**, two ways, plus a strictly weaker consequence (§4) |
| "the criterion is exact linear algebra, not an optimiser" | **true**, and it is the block's best sentence; the exactness is what makes §4's defect a defect rather than a tolerance question |
| "needs $\langle[u,v],w\rangle=0$" | **necessary condition stated where an *iff* is used** (§2, D2) |
| "clean singular-value gaps throughout" | **unearned** (D5) |
| "impossible for a nonzero isotropic subspace" | **true**, one line, and the line is missing (§5) |
| "occur at dimensions $5$, $6$ and $9$" | **stale**; $\{5,6,7,8,9\}$, and that is the whole admissible interval (§7) |
| "unlike a quadratic form, where all maximal isotropics share the Witt index" | **true and apt**, cause omitted (§7) |
| "The $d=4$ rows are consistent: they climb into the maximal-$5$ family" | **false as written** (D6) |
| "Therefore the middle band … needs an argument of its own" | **holds**, and now follows from one closed-form pair rather than from four rows (§7) |

## 9, What is owed

| # | owed | reachable? |
| --- | --- | --- |
| 1 | Attach "for isotropic $\mathfrak m$" to the rank condition, or split the chain into the unconditional two-way form plus a hypothesised third. Witness $\mathfrak{so}(3)\subset\mathfrak{so}(4)$ recorded against it | **done here**, §3–§4; a text edit |
| 2 | Insert the alternating-form step and the hereditary step into the proof of the first equivalence | **done here**, §2 |
| 3 | Insert the one-line reason rank $15$ is impossible | **done here**, §5 |
| 4 | Quantify the table rows as generic, or restate them as existence claims; mark $d=4$ as forced by $d\ge n-1$ and $d=5,9$ as closed form | **done here**, §6 |
| 5 | Withdraw the $d=4$ "climb into the maximal-$5$ family" clause | **done here**, D6 |
| 6 | Replace $\{5,6,9\}$ with $\{5,6,7,8,9\}$ and state the interval $[n-1,\lfloor n^2/4\rfloor]$ | **done here**, §7 |
| 7 | Record the varying-dimension theorem, $\ge\lfloor n/2\rfloor$ dimensions at every $n\ge4$ | **done here**, §7 |
| 8 | Give the Witt contrast its cause | **done here**, §7 |
| 9 | A closed-form maximal isotropic of dimension $6$ or $7$ at $n=6$, or a proof that none exists | **open**; not attempted, and it is not a computation question, a run can only certify a candidate, never supply the construction |
| 10 | Add $\mathfrak m$'s free-variable sense to [conventions.md](../findings/conventions.md), which tables three Weyl-operator senses and not this one | text edit, D1 |

**Nothing downstream breaks.** [L76](../findings/isotropy-cap.md) and the census refutation both apply the criterion **to objects already proved isotropic**, where §4's third row licenses it; and their own proofs go through the equality form, which needs no hypothesis. The defect is in the statement's generality, not in any use of it.
