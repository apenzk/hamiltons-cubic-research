# REVIEW r629, Lemma L75, "maximal isotropy, characterised three ways"

Reviewer r629, independent adversarial audit, cold from the definitions in [conventions.md](../findings/conventions.md). Target: [Lemma L75](../findings/isotropy-cap.md#L183) at [isotropy-cap.md:183](../findings/isotropy-cap.md#L183), the criterion at line 188, the four-row table at lines 190–195, and the two sentences beneath it at lines 196 and 198.

**Analysis only, and the allowance was used once.** Every claim below is derived by hand from the structure constants of $\mathfrak{so}(n)$. Two constructions I record positively (the non-isotropic witness for the rank count, and a closed-form $d=6$ maximal isotropic), were additionally **screened** numerically for seconds on objects I built for that purpose, after the argument was complete. The screens are reported as screens; each positive claim stands on the proof beside it, and none of the block's own runs was repeated.

## Verdict

**REFUTED as written.** The three conditions are not three characterisations of one thing. The first two are equivalent; **the third is strictly weaker, and the chain is false in the direction $\text{rank}\Rightarrow$ everything else.** The witness is the one the neighbouring audit named, and it survives: $\mathfrak m=\mathfrak{so}(3)\subset\mathfrak{so}(4)$ satisfies $\operatorname{rank}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$ exactly, and is not isotropic, so it is not maximal isotropic and it does not satisfy $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$.

**The two reviewers who disagreed in passing are both right, and about different conditions.** $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ *does* entail isotropy on its own; $\operatorname{rank}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$ *does not*, because it is only $\dim[\mathfrak m,\mathfrak m]^\perp=\dim\mathfrak m$, which fixes a dimension and leaves the subspace free. That is precisely the compatibility the brief asked for, and it means the repair is not symmetric: the equality form needs nothing, and **the rank form needs "for isotropic $\mathfrak m$" written into it**, the same repair [L77](../findings/isotropy-cap.md#L112) received forty lines below, with the same witness at the same $n=4$.

**The mathematics under the standing hypothesis is entirely correct**, and the block's own prose carries that hypothesis one line above the display ("Adding $w$ to an **isotropic** $\mathfrak m$"). What fails is the display and the heading, which state the chain free-standing, and the heading is what the index quotes and what a consumer cites.

**And the table is a corollary, all four rows.** The neighbouring audit had $d=4,5,9$ in closed form and left $d=6$ as the one measured row. $d=6$ is closed form too: it is the odd part of the symmetric pair $\mathfrak{so}(6)/\mathfrak u(3)$, dimension $6$, bracket rank $9=N-6$, and **the same file already records it, twenty-two lines above the table, as the $\mathbb{CP}^3$ point with $\dim\mathfrak m=6$.** No row of the table carries information the record did not already hold.

| # | finding | verdict |
| --- | --- | --- |
| 1 | The chain of three equivalences as stated in the heading and the display | **REFUTED**; the third condition is strictly weaker |
| 2 | $\mathfrak m$ maximal isotropic $\iff[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ | **CONFIRMED**, both directions, and the equality is forced rather than chosen |
| 3 | $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ entails isotropy unaided | **CONFIRMED**, it contains $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$, which *is* isotropy |
| 4 | $\operatorname{rank}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$ as a free-standing test | **REFUTED**; witness $\mathfrak{so}(3)\subset\mathfrak{so}(4)$, rank $3=6-3$, isotropy residual $1$ |
| 5 | The same rank condition **under a standing isotropy hypothesis** | **CONFIRMED**, and then equivalent to both others |
| 6 | Sufficiency of $w\perp[\mathfrak m,\mathfrak m]$ for the extension | **CONFIRMED**, but it consumes total antisymmetry of $\omega$, which the block never names |
| 7 | Row $d=4$, *extends* | **CONFIRMED as a theorem**, $\binom42=6<11$; no run was ever needed |
| 8 | Row $d=5$ | **CONFIRMED in closed form**: the odd part of $\mathfrak{so}(1)\oplus\mathfrak{so}(5)$, rank exactly $10$ |
| 9 | Row $d=6$ | **CONFIRMED in closed form**, $\mathfrak{so}(6)/\mathfrak u(3)$, which is the record's own $\mathbb{CP}^3$ point. The last measurement-only row falls |
| 10 | Row $d=9$ | **CONFIRMED in closed form**: the odd part of $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, rank $6$ |
| 11 | "with clean singular-value gaps throughout" | **REFUTED as to "throughout"**: at $d=4$ and $d=5$ the bracket matrix has full column rank, so there is no zero singular value and no gap can exist |
| 12 | "six values of exactly $\sqrt6$" at the cap | **CONVENTION-DEPENDENT and unstated**: under the pairing [conventions.md](../findings/conventions.md) says the record runs in, the six values are $\sqrt3$ |
| 13 | The rank-$15$ impossibility | **CONFIRMED**, and the proof is one line the block owed: isotropy caps the rank at $N-\dim\mathfrak m=9$ |
| 14 | "dimensions $5$, $6$ and $9$" | **STALE**; the correct list at $n=6$ is $\{5,6,7,8,9\}$, the whole of $[n-1,\lfloor n^2/4\rfloor]$ |
| 15 | The Witt-index comparison | **DECORATIVE**; the apt analogy is the Lagrangian condition $\mathfrak m^\perp=\mathfrak m$, which is condition 2 itself |
| 16 | "at least $\lfloor n/2\rfloor$ distinct dimensions at every $n\ge4$" | **CONFIRMED**, and improvable to $\lfloor n/2\rfloor+1$ at most even $n$ |
| 17 | "The $d=4$ rows … climb into the maximal-$5$ family rather than toward the cap" | **GAP**: false for non-generic $d=4$ isotropics, and its scope is unstated |
| 18 | Provenance | **CLEAN in the body, and the heading is a bulk retrofit**, the same commit family that mislabelled [L76](../findings/isotropy-cap.md#L200) |
| 19 | Pointers | The block carries **zero** links while consuming four conventions; $8$ of the file's $9$ internal anchors are dead |

## Conventions I fixed before starting, as the brief requires

The brief warns that [conventions.md](../findings/conventions.md) is incomplete in three ways. Only one of the three touches this block, and I record all three readings.

- **$\mathfrak m$.** [conventions.md](../findings/conventions.md) tables three senses. **None of them is the one L75 uses.** Here $\mathfrak m$ is an *arbitrary linear subspace of $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$* being tested for isotropy, not $E_{\min}$ at a critical point, not [L36](../findings/isotropy-cap.md#L17)'s whole negative eigenspace, not [target.md](../findings/target.md)'s symmetric-pair odd part. **This is a fourth sense and it is the one the criterion needs**, since the criterion's whole value is that it applies to a subspace with no critical point behind it. I adopt it, and note that the table's rows then silently switch back to the eigenspace sense when they are read against $\dim\mathfrak m$ at catalogued $S=0$ points.
- **Isotropy.** $\mathfrak m$ is isotropic when the Cartan $3$-form $\omega(u,v,w)=\langle[u,v],w\rangle$ vanishes on $\mathfrak m$, i.e. $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle=0$. Total antisymmetry of $\omega$ is [conventions.md](../findings/conventions.md)'s structure-constant bullet, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric.
- **The pairing.** I run in the half-trace pairing, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal, the one [conventions.md](../findings/conventions.md) says "every result uses". This is the reading that matters for finding 12 and for nothing else: **rank is pairing-independent, so the criterion itself is immune.**
- **$N=\binom n2$**, and the table is at $n=6$, so $N=15$. The block never states $n$; it is fixed by the sentence two lines above the heading and by $N-d$ arithmetic.
- **$S_{XYZ}$ and $\theta_0$** are not used by this block, so their unfixed normalisations do not reach it.
- **"$\operatorname{rank}[\mathfrak m,\mathfrak m]$"** I read as $\dim\operatorname{span}\{[u,v]:u,v\in\mathfrak m\}$. It coincides with the matrix rank of the $N\times\binom d2$ array of bracket coordinates on any basis, by bilinearity, and is basis-independent.

## 1. The three-way equivalence, which is what this audit is for

Write $d=\dim\mathfrak m$ and $r=\operatorname{rank}[\mathfrak m,\mathfrak m]$, so that $\dim[\mathfrak m,\mathfrak m]^\perp=N-r$ always. The three conditions are

$$(\mathrm A)\ \mathfrak m\ \text{maximal isotropic},\qquad(\mathrm B)\ [\mathfrak m,\mathfrak m]^\perp=\mathfrak m,\qquad(\mathrm C)\ r=N-d.$$

### 1.1 (B) entails isotropy on its own, confirmed, and it is immediate

Isotropy of $\mathfrak m$ says $\langle[u,v],w\rangle=0$ for all $u,v,w\in\mathfrak m$. Read with $w$ free, that is exactly $\mathfrak m\perp[\mathfrak m,\mathfrak m]$, i.e.

$$\mathfrak m\ \text{isotropic}\iff\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp .$$

So the *inclusion half* of (B) is not an extra fact about $\mathfrak m$; **it is isotropy, rewritten.** (B) therefore entails isotropy with nothing supplied from outside, and the second reviewer of [L76](../findings/isotropy-cap.md#L200) is right. **I confirm that reading and state it plainly: the equality in (B) is two statements welded together ($\subseteq$ is isotropy and $\supseteq$ is maximality) and the block's choice of the equality over an inclusion is correct for exactly that reason, which the block never gives.**

### 1.2 (C) is only a dimension count, and the witness stands

(C) says $N-r=d$, i.e. $\dim[\mathfrak m,\mathfrak m]^\perp=\dim\mathfrak m$. **It says nothing about where $[\mathfrak m,\mathfrak m]^\perp$ sits.** Two subspaces of equal dimension need not meet at all, so (C) is strictly weaker than (B) unless something independently forces $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$, and that something is isotropy.

**The witness, by hand.** Take $n=4$, $N=6$, and $\mathfrak m=\mathfrak{so}(3)=\operatorname{span}\{\varphi_{12},\varphi_{13},\varphi_{23}\}$, so $d=3$ and $N-d=3$.

With $\varphi_{ab}=E_{ab}-E_{ba}$ and $E_{ab}E_{cd}=\delta_{bc}E_{ad}$,

$$\varphi_{12}\varphi_{13}=-E_{23},\qquad\varphi_{13}\varphi_{12}=-E_{32},\qquad[\varphi_{12},\varphi_{13}]=-E_{23}+E_{32}=-\varphi_{23},$$

and cyclically $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, $[\varphi_{13},\varphi_{23}]=-\varphi_{12}$. Hence $[\mathfrak m,\mathfrak m]=\mathfrak m$ and $r=3$.

- **(C) holds exactly:** $r=3=6-3=N-d$. No tolerance, no genericity, no run.
- **Isotropy fails maximally:** $\langle[\varphi_{12},\varphi_{13}],\varphi_{23}\rangle=-\lVert\varphi_{23}\rVert^2=-1$ in the half-trace pairing (and $-2$ in Frobenius). The residual is of order the norm, not of order a tolerance.
- **(B) fails:** $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m^\perp=\operatorname{span}\{\varphi_{14},\varphi_{24},\varphi_{34}\}$, which has dimension $3=\dim\mathfrak m$ and meets $\mathfrak m$ in $\{0\}$. **This is the strictly-weaker phenomenon in its purest form: the dimensions agree and the subspaces are transverse.**
- **(A) fails**, since $\mathfrak m$ is not isotropic and so is not maximal isotropic.

*Screen, reported as a screen.* A seconds-long numerical check on this subspace returns $\dim\mathfrak m=3$, $r=3$, $N-d=3$, isotropy residual $1.000$. It agrees with the hand computation and is not the evidence for it.

**So (C) $\not\Rightarrow$ (B) and (C) $\not\Rightarrow$ (A), and the chain of three equivalences is false as written.** The failure is one-directional: (A) $\iff$ (B) $\Rightarrow$ (C) all hold, since (B) gives $\dim[\mathfrak m,\mathfrak m]^\perp=\dim\mathfrak m$ at once.

### 1.3 The repair, and why it is not cosmetic

**For *isotropic* $\mathfrak m$:**

$$\mathfrak m\ \text{maximal}\iff[\mathfrak m,\mathfrak m]^\perp=\mathfrak m\iff\operatorname{rank}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m.$$

Under isotropy, $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ holds automatically, and two nested subspaces of equal dimension are equal, so (C) $\Rightarrow$ (B) is restored. **The equality form (B) may keep the chain's left-hand side with no hypothesis; only (C) needs it.**

The repair is load-bearing rather than pedantic because **(C) is the form that gets used.** (B) is a subspace identity nobody evaluates; the table evaluates (C), a rank against an integer, and reads off a verdict in the "verdict" column. As a decision procedure, the table's column is unsound: $\mathfrak{so}(3)\subset\mathfrak{so}(4)$ would enter it as *maximal*. Every consumer of L75 that computes a rank is consuming the unsound form.

**The same omission, in the same file, forty lines below.** [L77](../findings/isotropy-cap.md#L112) was refuted by [r609](REVIEW_r609.md) and [r610](REVIEW_r610.md) for dropping exactly this hypothesis, and its warning box uses **the same witness at the same $n=4$**, $\mathfrak m=\mathfrak{so}(3)$, $d=3$, $\mathfrak m^\perp=\operatorname{span}(\varphi_{14},\varphi_{24},\varphi_{34})$. That box is on line 116 of the file. **The refutation of L75's third condition was already written into this file, sixty-seven lines above L75's own heading, in the subspace it names.** This is the sixteen-times pattern the brief warns about, and it is the second time in this file that a hypothesis restored in one block was not propagated to a neighbouring one.

## 2. The first equivalence: which containment is definitional

**The block's extension step is correct, and it is sufficient as well as necessary, for a reason it does not give.** Suppose $\mathfrak m$ is isotropic and $w\notin\mathfrak m$; put $\mathfrak m'=\mathfrak m\oplus\mathbb Rw$. Isotropy of $\mathfrak m'$ needs $\omega$ to vanish on four families of triples:

| triple | requirement |
| --- | --- |
| $(u,v,x)$, all in $\mathfrak m$ | holds, $\mathfrak m$ isotropic |
| $(u,v,w)$, two in $\mathfrak m$ | $\langle[u,v],w\rangle=0$, i.e. $w\perp[\mathfrak m,\mathfrak m]$, the block's condition |
| $(u,w,w)$ | $\omega(u,w,w)=0$ **automatically**, $\omega$ being alternating |
| $(w,w,w)$ | $0$ |

So $w\perp[\mathfrak m,\mathfrak m]$ is necessary *and* sufficient. **The block writes only "needs", which is necessity**; sufficiency is what turns the criterion into an equivalence, and it consumes the total antisymmetry of $c_{abc}$ from [conventions.md](../findings/conventions.md). Without antisymmetry the third row would be a separate condition $\langle[u,w],w\rangle=0$ and the criterion would not close. **The block cites nothing for it.**

Given that, for isotropic $\mathfrak m$:

$$\mathfrak m\ \text{maximal}\iff\text{no }w\notin\mathfrak m\text{ has }w\in[\mathfrak m,\mathfrak m]^\perp\iff[\mathfrak m,\mathfrak m]^\perp\subseteq\mathfrak m.$$

**So the answer the brief asks for is:**

- $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ is **definitional**, it is isotropy verbatim, and carries no content beyond the hypothesis.
- $[\mathfrak m,\mathfrak m]^\perp\subseteq\mathfrak m$ is **the content**, it is maximality, and it is the half the extension argument proves.

The block writing equality is right, and *for the isotropy half it is right by accident of what the equality contains* rather than by an argument the block supplies. One sentence fixes it: *"the inclusion $\subseteq$ is isotropy restated, so writing equality lets the criterion carry its own hypothesis."*

## 3. The table: every row is a corollary

Two standing inequalities do all four rows. For any $\mathfrak m$ of dimension $d$, the brackets of a basis span $[\mathfrak m,\mathfrak m]$, so

$$r\le\binom d2,$$

and for **isotropic** $\mathfrak m$, $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ gives

$$r\le N-d.$$

Maximality is the case of equality in the second. Combining, **a maximal isotropic needs $N-d\le\binom d2$**, which at $n=6$ excludes $d=4$ ($11>6$) and admits $d=5$ ($10=10$) onward. In general $\binom n2-\binom{d}2\le d$ fails at $d=n-2$ (the gap is $2n-3>n-2$) and holds with equality at $d=n-1$, giving **$d\ge n-1$ for every maximal isotropic**, which is the free result [L76](../findings/isotropy-cap.md#L200)'s box already claims.

| $d$ | the block's row | what proves it, with no run |
| --- | --- | --- |
| $4$ | rank $6$, $N-d=11$, **extends** | $r\le\binom42=6<11$. **A theorem, not an observation**, and the recorded $6$ is the generic value of a quantity that is irrelevant to the verdict |
| $5$ | rank $10=N-d$, **maximal** | $\mathfrak p$ of $\mathfrak{so}(1)\oplus\mathfrak{so}(5)$: $[\mathfrak p,\mathfrak p]=\mathfrak{so}(5)$ exactly, $\dim=10=15-5$ |
| $6$ | rank $9=N-d$, **maximal** | $\mathfrak p$ of $\mathfrak{so}(6)/\mathfrak u(3)$: $\dim\mathfrak p=15-9=6$, $[\mathfrak p,\mathfrak p]=\mathfrak u(3)$, $\dim=9=15-6$ |
| $9$ | rank $6=N-d$, **maximal** | $\mathfrak p$ of $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$: $\binom62=\binom32+\binom32+9$, so $r=6=15-9$ |

**The $d=6$ row is the one the neighbouring audit left standing as measurement-only, and it falls to a symmetric pair the record already knows about.** The mechanism is general and subsumes [L76](../findings/isotropy-cap.md#L200):

> **For any symmetric decomposition $\mathfrak{so}(n)=\mathfrak k\oplus\mathfrak p$ with $[\mathfrak p,\mathfrak p]=\mathfrak k$, the odd part $\mathfrak p$ is a maximal isotropic subspace.** Isotropy: $\langle[\mathfrak p,\mathfrak p],\mathfrak p\rangle\subseteq\langle\mathfrak k,\mathfrak p\rangle=0$, the decomposition being orthogonal. Maximality: $[\mathfrak p,\mathfrak p]^\perp=\mathfrak k^\perp=\mathfrak p$, which is condition (B) directly. And $[\mathfrak p,\mathfrak p]=\mathfrak k$ is automatic whenever the pair is irreducible with $\mathfrak{so}(n)$ simple, since $[\mathfrak p,\mathfrak p]$ is an ideal of $\mathfrak k$ and $[\mathfrak p,\mathfrak p]+\mathfrak p$ is an ideal of $\mathfrak{so}(n)$.

The compact symmetric pairs of $\mathfrak{so}(n)$ are $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$, giving $\dim\mathfrak p=pq$, **and $\mathfrak u(m)$ at $n=2m$, giving $\dim\mathfrak p=m(m-1)$**, the type DIII pair, which this very file names on line 126 in the Cartan-classification discussion and never connects to isotropy. At $n=6$ that is $\dim\mathfrak p=6$, and $\mathfrak p=\{X\in\mathfrak{so}(6):XJ=-JX\}$ for a complex structure $J$. It is outside [L76](../findings/isotropy-cap.md#L200)'s family for the arithmetic reason that $pq=6$ has no solution with $p+q=6$.

*Screen, reported as a screen.* Building $\mathfrak p=\{X:XJ=-JX\}$ from the block-diagonal $J$ with three copies of $\left(\begin{smallmatrix}0&-1\\1&0\end{smallmatrix}\right)$ and computing returns $\dim\mathfrak p=6$, $r=9=N-6$, isotropy residual $3.3\times10^{-16}$. The three symmetric-pair rows screen identically to their closed forms: $(1,5)\to d=5$, $r=10$; $(2,4)\to d=8$, $r=7$; $(3,3)\to d=9$, $r=6$; all isotropy residuals exactly $0$. The proof above is the evidence; this is corroboration on objects I constructed.

**And the record already held the $d=6$ answer, twenty-two lines above the table.** Line 161 of the same file lists $\dim\mathfrak m=6$ at $\mathbb{CP}^3$ ($n=6$) and $\dim\mathfrak m=12$ at $\mathbb{CP}^4$ ($n=8$). Those are exactly $\binom62-\dim\mathfrak u(3)=15-9=6$ and $\binom82-\dim\mathfrak u(4)=28-16=12$, **two independent dimension matches identifying the $\mathbb{CP}^m$ minimal eigenspace as the DIII odd part.** So the $d=6$ maximal isotropic is the $\mathbb{CP}^3$ point, it was in the file when the table was written, and the table reports it as a measurement.

**Consequence.** The table is a corollary of the two inequalities plus the symmetric-pair construction. It is not evidence for the criterion; it is an application of it, and the criterion's soundness has to come from §1.

## 4. The rank-$15$ tell, and the argument the block owed

The block says an unpolished run gave $r=15$ at $d=6$, "impossible for a nonzero isotropic subspace", and stops. **The reason is one line, and it is the inequality of §3.**

> For any isotropic $\mathfrak m$, $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$, so $\dim[\mathfrak m,\mathfrak m]^\perp\ge\dim\mathfrak m$, i.e. $r\le N-\dim\mathfrak m$. At $n=6$, $d=6$ that is $r\le9$. **A rank of $15$ forces $[\mathfrak m,\mathfrak m]^\perp=0$ and hence $\mathfrak m=0$.** The observed $15$ overshoots the ceiling by $6$, which is $\dim\mathfrak m$ itself.

**This is the strongest thing on the page and the brief is right to say so**: the criterion detected that a numerical candidate had failed its own hypothesis, before any verdict was read off. It is worth stating that the detector is the *isotropy* half of the criterion, not the maximality half, i.e. **precisely the hypothesis the third condition drops.** The block's numerics were saved by the clause its statement omits.

The competing ceiling $r\le\binom62=15$ is not binding here, which is why the observed value was exactly $15$: the run had drifted onto the generic bound for a *non-isotropic* $6$-space, which is what a non-isotropic $\mathfrak m$ looks like.

## 5. The structural claim

### 5.1 The list is stale, and the correct one is complete

**"dimensions $5$, $6$ and $9$" omits $7$ and $8$, both of which the same file records forty lines below**, the block headed *"REFUTED: there is no gap at $8$"* gives $d=8$ from the $(2,4)$ pair and $d=7$ from generic isotropics. The correct statement at $n=6$:

$$\{d:\text{a maximal isotropic of dimension }d\text{ exists at }n=6\}=\{5,6,7,8,9\}.$$

This is **the whole of the admissible interval** $[n-1,\lfloor n^2/4\rfloor]=[5,9]$: the lower end is §3's $d\ge n-1$, the upper is [L36](../findings/isotropy-cap.md#L17)'s cap. Four of the five values are closed-form ($5,8,9$ from $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $6$ from $\mathfrak u(3)$) and **$d=7$ is the only value at $n=6$ still resting on numerics.** That is a sharper statement than the block's and it costs nothing.

### 5.2 The Witt comparison is decorative, and the apt analogy is a different one

Witt's theorem concerns a **nondegenerate quadratic form**; its content is that all maximal totally isotropic subspaces have one dimension, the Witt index, and that the orthogonal group is transitive on them. The object here is an alternating **trilinear** form $\omega$. The sentence "unlike a quadratic form, where all maximal isotropics share the Witt index" is a true statement about quadratic forms, and the contrast it draws is real, but:

- **Nothing downstream uses it.** No later line invokes Witt, transitivity, or an index. Removing the clause removes no step.
- **It is a negation of the kind the record's own writing rule forbids**, it says what the situation is not, and the positive statement ("the dimension is not an invariant of the form; it ranges over $[n-1,\lfloor n^2/4\rfloor]$ and every value in it occurs at $n=6$") is both shorter and usable.
- **There was no reason to expect equidimensionality**, so the contrast informs nobody. Equidimensionality for a quadratic form comes from Witt's *extension* theorem, which has no analogue for a $3$-form; the surprise would have been the other outcome.
- **The analogy that *is* apt sits in condition (B) and goes unremarked.** For a nondegenerate quadratic form, "maximal isotropic" is $\mathfrak m^\perp=\mathfrak m$, the Lagrangian condition. L75's (B) is $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$, the same shape with the bracket inserted, and the same self-duality is what makes the equality form carry its own isotropy hypothesis. **That is a structural parallel worth one sentence; the Witt-index contrast is not.**

Verdict: **decorative**. Replace it with the positive statement of §5.1.

### 5.3 The varying-dimension claim is provable, and the four rows were never needed

**Confirmed, and the proof is three lines.** For each $1\le p\le\lfloor n/2\rfloor$, the pair $\mathfrak{so}(p)\oplus\mathfrak{so}(n-p)$ has odd part of dimension $p(n-p)$, maximal isotropic by [L76](../findings/isotropy-cap.md#L200) (equivalently by §3's symmetric-pair argument, with $r=\binom p2+\binom{n-p}2=N-p(n-p)$ the symbolic identity). The map $p\mapsto p(n-p)$ is strictly increasing on $[1,n/2]$, so the $\lfloor n/2\rfloor$ values are distinct. Hence **at every $n\ge4$ there are at least $\lfloor n/2\rfloor$ distinct maximal-isotropic dimensions**, with no numerics anywhere. At $n=4$ that gives $3$ and $4$; at $n=6$, $5,8,9$.

**It improves for free.** At even $n=2m$ the DIII pair adds $m(m-1)$, and $m(m-1)=p(2m-p)$ forces $p=m\pm\sqrt m$, so the value is new **whenever $m$ is not a perfect square**, giving $\lfloor n/2\rfloor+1$ distinct dimensions at those $n$, including $n=6$ where it supplies the $d=6$ row.

**So the block's four rows were never needed for its own conclusion**, and the conclusion the rows were reported to support, *"the middle band is not proper subspaces of a symmetric pair and cannot inherit the cap rigidity"*, follows from the closed forms directly: at $n=6$ there are maximal isotropics at $5,6,8$ below the cap $9$, three of them symmetric-pair odd parts, and a maximal isotropic is by definition not a proper subspace of anything isotropic. **The downstream conclusion survives; only its evidence changes character, from four measurements to a construction.**

## 6. Hedging clauses, one at a time

| clause | verdict |
| --- | --- |
| "characterised three ways" | **False as a claim about three characterisations.** Two characterise; the third is a consequence. The phrase is in the heading, which is what the index quotes |
| "and the criterion is exact linear algebra, not an optimiser" | **True and the block's best sentence**, and it is exactly why the missing hypothesis matters, an exact test being one people apply without re-checking its side conditions |
| "with clean singular-value gaps throughout" | **Overstated.** At $d=4$ the bracket matrix is $15\times6$ of rank $6$ and at $d=5$ it is $15\times10$ of rank $10$: **full column rank, so no zero singular value exists and no gap is observable.** The evidence covers the two rows the sentence goes on to cite, $d=6$ and $d=9$, and "throughout" claims four |
| "at $d=6$ the tenth value is $3.5\times10^{-9}$ against a ninth of $0.436$" | **Consistent** with rank $9$ on a $15\times15$ matrix. It describes a *generic* $6$-space, not the $\mathfrak u(3)$ one, whose nine nonzero values are $\{2,1^{\times8}\}$, so the row's numbers and the closed form describe different subspaces of the same dimension |
| "at the cap six values of exactly $\sqrt6$ then nothing" | **The multiplicity $6$ is right; the value is pairing-dependent and no pairing is named.** With a half-trace-orthonormal basis of $\mathfrak m$ and half-trace bracket coordinates, [conventions.md](../findings/conventions.md)'s stated choice, the six values are $\sqrt3$, and the $(2,4)$ pair gives $\{\sqrt2^{\times6},2\}$ where [L76](../findings/isotropy-cap.md#L200)'s closed form predicts $\{2^{\times6},2\sqrt2\}$. **The recorded numbers are uniformly $\sqrt2$ larger**, i.e. brackets measured in Frobenius against a half-trace-orthonormal basis, the mixed reading [conventions.md](../findings/conventions.md) warns has cost a cycle. In the record's own pairing the closed form reads $\sqrt p$ with multiplicity $\binom q2$ and $\sqrt q$ with multiplicity $\binom p2$. **Nothing in the criterion moves**, rank being pairing-independent; what moves is a published number |
| "which is impossible for a nonzero isotropic subspace" | **True, and now proved** in §4. It was stated without its reason |
| "The $d=4$ rows are consistent: they climb into the maximal-$5$ family rather than toward the cap" | **GAP.** The theorem says a $d=4$ isotropic extends; nothing says where it stops. **It is false without a genericity qualifier**: any $4$-dimensional subspace of the $9$-dimensional $\mathfrak p_{3,3}$ is isotropic and extends all the way to the cap, and the sentence two lines above the heading is itself about "sub-subspaces of the symmetric pair". As a report on the particular generic rows measured it may be right; as written it is an unqualified claim contradicted by the construction its own paragraph uses |
| "Therefore the middle band … needs an argument of its own" | **CONFIRMED**, and now on better footing than the block's, see §5.3 |

## 7. Provenance, and the pointers

**Provenance is clean in the body and the heading is a retrofit**, one of the audit's less common outcomes, and the same shape as [L76](../findings/isotropy-cap.md#L200)'s.

| element | commit | date |
| --- | --- | --- |
| the criterion, the display, the table, the singular-value sentence, the rank-$15$ tell | `fefce494` *feat(conjecture-a): maximality of isotropic subspaces is a rank identity* | 2026-08-23 |
| the Witt sentence and the dimension list | `51f8e8d5` *feat(conjecture-a): the 3-form's maximal isotropics differ in dimension* | 2026-08-23 |
| the file split | `51ab61f8` |, |
| **the numbered heading**, "maximal isotropy, characterised three ways, $\mathfrak m$ maximal isotropic iff … iff …" | `5b258c14` *docs(isotropy-cap): place headings for Lemmas 75-82* | 2026-09-02 |

**The body's display reads "$\mathfrak m$ is maximal iff …", and the heading rewrote it as "$\mathfrak m$ maximal isotropic iff …".** Both drop the hypothesis from the third condition, so the defect predates the retrofit; but the retrofit is what promoted a display sitting one line under "Adding $w$ to an *isotropic* $\mathfrak m$" into a free-standing indexed statement with its hypothesis ten days and one bulk commit away. **That is the identical mechanism by which `5b258c14` mislabelled [L76](../findings/isotropy-cap.md#L200)**, repaired in `1381c033` two days ago, and it is the mechanism [L77](../findings/isotropy-cap.md#L112)'s box already describes ("the numbered heading was retrofitted ten days later still unconditional"). **Three results in one file, one commit, one failure mode.**

**Pointers.**

- **The L75 block contains no links at all**, while consuming four things it does not own: the definition of isotropy, the total antisymmetry of $c_{abc}$, $N=\binom n2$, and the value of $n$. All four are in [conventions.md](../findings/conventions.md) or the paragraph above the heading, and none is cited. For a block whose entire claim is a definitional equivalence, that is the pointer defect that matters.
- **The empty target the brief names is real**: line 364 carries `[Lemma L36](#)`.
- **The stale anchor is worse than one.** Of the file's nine internal anchors, **eight are dead**: line 15 (`…lfloor-n22-rfloor…` against a heading giving `n24`), line 253 (L131, heading since rewritten with a colon), lines 269, 271, 291, 297 (L32, four times, the heading having gained "canonical statement and proof"), line 271 (L81, whose heading now reads "REQUIRES $m\ne3$" against an anchor saying "wider than Lemma L32, requires $p\ge2$"), and line 364 (empty). Only the L79 anchor at line 360 resolves. **The L32 anchor is dead in four places at once**, so a reader following any cross-reference in the file's second half lands at the top of the page.
- The index row for L75 in [INDEX-results.md](../findings/INDEX-results.md) reads *"Gate 2: no verdict on the record"* while labelling the result **Lemma**, which [INDEX-results.md](../findings/INDEX-results.md)'s own header defines as "proven, Gate 1 and Gate 2 passed". The label and the status contradict each other; this round supplies the missing verdict.

## 8. What is owed, and whether it is reachable

| owed | reachable |
| --- | --- |
| Write the isotropy hypothesis into the third condition, in the heading, in the display, and in the index row | **Immediately.** One clause, "for isotropic $\mathfrak m$", and the result is true and useful |
| One sentence saying why the equality form is chosen, that $\subseteq$ *is* isotropy | **Immediately** |
| One sentence for the sufficiency half of the extension step, citing total antisymmetry | **Immediately** |
| The one-line proof of the rank-$15$ impossibility | **Immediately**, §4 |
| Replace the table with the two inequalities and the symmetric-pair construction, or keep it labelled as an application | **Immediately**, §3 |
| Name the pairing behind "$\sqrt6$", or restate it as $\sqrt p$ and $\sqrt q$ in the record's own pairing | **Immediately.** This is a number on the record that is right in a pairing the record says it does not use |
| Correct the dimension list to $\{5,6,7,8,9\}$ and state the interval $[n-1,\lfloor n^2/4\rfloor]$ | **Immediately**, §5.1 |
| Drop or qualify the $d=4$ "climb into the maximal-$5$ family" sentence | **Immediately** as a qualification; **blocked** as a general claim, which is false |
| Replace the Witt contrast with the Lagrangian parallel and the positive dimension statement | **Immediately**, §5.2 |
| Add the DIII pair $\mathfrak u(m)\subset\mathfrak{so}(2m)$ to the maximal-isotropic family, and record that it is the $\mathbb{CP}^m$ point | **Immediately** for the statement and its proof. **The identification of $\mathfrak m$ at $\mathbb{CP}^m$ with $\mathfrak p_{DIII}$ is established here by two dimension matches, $6$ at $n=6$ and $12$ at $n=8$**, which is strong and is not an elementwise verification; upgrading it is a short piece of analysis on the Fubini–Study curvature operator, and it is not needed for anything L75 claims |
| Whether $d=7$ at $n=6$ has a closed-form witness, closing the last numerical row of the whole dimension spectrum | **Open, and analytic.** It is the only value in $[5,9]$ not supplied by a symmetric pair, so it needs a construction outside that family. **A computation would not settle it**, a run can only re-find what the census already found; what is owed is a subspace written down. Not attempted here |
| Whether every value in $[n-1,\lfloor n^2/4\rfloor]$ occurs at every $n$, as it does at $n=6$ | **Open.** Symmetric pairs give $\lfloor n/2\rfloor+1$ of them and the interval has $\lfloor n^2/4\rfloor-n+2$ members, so the gap grows; this is a genuine question and it is the general form of the $d=7$ one |

---

*Screens run: two, both on objects I constructed, both after the corresponding argument was complete, the $\mathfrak{so}(3)\subset\mathfrak{so}(4)$ witness and the four $n=6$ symmetric-pair odd parts. Seconds of compute. No search, sweep, census or optimisation was run, and no positive claim above rests on a screen.*
