# REVIEW r622, Lemma L76

**Target:** Lemma L76, "every symmetric pair $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is a maximal isotropic subspace", [findings/isotropy-cap.md:200](../findings/isotropy-cap.md), the heading, the block under it, the criterion it consumes ([Lemma L75](../findings/isotropy-cap.md), line 183) and L75's four-row table. Second copy of the statement at [findings/INDEX-results.md:91](../findings/INDEX-results.md).

**Reviewer:** r622, cold, adversarial, **analysis-only footing**. No search, sweep, census or optimisation was run, and none of the block's own numerics was re-run or extended. Every statement below was derived from the definitions before the block was read for its reasoning. One **screen** was taken, of claims written here and on objects constructed here (exact rational arithmetic on the coordinate structure constants, seconds of compute) and it is reported as a screen in §6, never as the ground of a positive claim. Three quantities the block and its neighbour present as measurements are re-derived in closed form here and are therefore reported as derivations.

**VERDICT: REFUTED as stated, the heading names the wrong object, and under its own words the claim is false at every $(p,q)$ with $\max(p,q)\ge3$.** The object the block's arithmetic actually describes is the **odd part** $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ of the symmetric pair, of dimension $pq$, not the subalgebra $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, of dimension $\binom p2+\binom q2$. For that object the claim is **true at every $(p,q)$ with $p,q\ge1$, unconditionally and in closed form**, a four-line proof, given in §3, which the block does not have and which replaces its census over $n=6,7,8$. The heading's *every* still needs a range: at $q=0$ the statement is **false** at every $n\ge2$. Three further results fall out that the record does not carry: a **lower bound $d\ge n-1$ on the dimension of any maximal isotropic subspace** (§4), which makes L75's $d=4$ "extends" row a theorem rather than a sample; the block's structural conclusion (maximal isotropics of differing dimension), proved **without numerics** at $n=6$ from the pairs $(1,5),(2,4),(3,3)$ alone (§5); and L75's singular-value figures, including "six values of exactly $\sqrt6$", derived in closed form (§6). Provenance is **clean**, every self-historical claim in the block checks out against `git`.

---

## 1, Conventions, pinned before anything was derived

[conventions.md](../findings/conventions.md) is incomplete, as the brief warns. Each symbol used below is fixed against the file it is taken from, and the reading adopted is stated.

| object | reading adopted here | pinned at | verdict |
| --- | --- | --- | --- |
| $\langle X,Y\rangle$ | $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\mathfrak{so}(n)=\Lambda^2\mathbb R^n$, so $\{\varphi_{ab}\}_{a<b}$ is **orthonormal** | [conventions.md](../findings/conventions.md), "Norms and pairings", first two bullets | ✓ the record's choice, pinned twice ([r519](REVIEW_r519.md), [r520](REVIEW_r520.md)) |
| $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ | **totally** antisymmetric | [conventions.md](../findings/conventions.md), "Structure constants" | ✓, and it is load-bearing in §2, where the block does not say so |
| $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$ | [conventions.md](../findings/conventions.md), "The objects" | ✓ confirmed; the row cites **no source**, which is harmless here |
| $\omega$ | the Cartan $3$-form $\omega(x,y,z)=\langle[x,y],z\rangle$ | [isotropy-cap.md](../findings/isotropy-cap.md), line 11 | ✓ |
| isotropic | $\omega(u,v,w)=0$ for **all** $u,v,w\in\mathfrak m$, equivalently $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ | [isotropy-cap.md](../findings/isotropy-cap.md), L36's statement | ✓ |
| $\mathfrak m$ | in L75 a **free variable** ranging over subspaces of $\mathfrak{so}(n)$; in L76 the symmetric pair's **odd part** | [conventions.md](../findings/conventions.md) tables three senses | ✗, see D1 |
| ordered pairs | sums over pairs are **ordered** unless said otherwise | [conventions.md](../findings/conventions.md), "The normalisations" | ✓, and it is what makes L75's $\sqrt6$ come out (§6) |

**D1, $\mathfrak m$ carries a fourth sense here, and conventions.md tables three.** The file records $\mathfrak m$ as $E_{\min}$ at a critical point, as [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and as [target.md](../findings/target.md)'s symmetric-pair odd part. L75 uses none of them: its $\mathfrak m$ is a bound variable over *arbitrary* subspaces of $\mathfrak{so}(n)$, with no Weyl operator anywhere in the statement, and the criterion is pure Lie algebra. L76 then silently specialises it to the third sense. The two senses are not the same object and the transition is unmarked. **This is the whole of the mislabel in §2**: read $\mathfrak m$ as free, the block is about a $pq$-dimensional subspace; read the heading, it is about a $\big(\binom p2+\binom q2\big)$-dimensional subalgebra.

$S_{XYZ}$ and $\theta_0(n)$ (the two other gaps the brief names), are **not used** by L75, L76 or anything derived here, so neither normalisation dispute reaches this audit.

## 2, REFUTED as written: an isotropic subalgebra is abelian

Take the heading and the block's own first sentence at their word: $\mathfrak m:=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$.

It is a **subalgebra**, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m$. Isotropy requires $[\mathfrak m,\mathfrak m]\perp\mathfrak m$. A subspace both contained in and orthogonal to $\mathfrak m$ is $\{0\}$, so

$$\mathfrak{so}(p)\oplus\mathfrak{so}(q)\ \text{isotropic}\iff[\mathfrak m,\mathfrak m]=0\iff\mathfrak m\ \text{abelian}\iff p\le2\ \text{and}\ q\le2 .$$

For $\max(p,q)\ge3$ it fails outright, with a one-line witness: inside the first factor, $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, so $\omega(\varphi_{12},\varphi_{23},\varphi_{13})=1\ne0$. So the heading is false at $(3,3)$ and $(2,4)$, including the very pair the block's example uses.

**And even where it is isotropic it is not maximal.** At $p=q=2$, $n=4$: $\mathfrak m=\mathop{\mathrm{span}}(\varphi_{12},\varphi_{34})$ is abelian, $[\mathfrak m,\mathfrak m]=0$, $[\mathfrak m,\mathfrak m]^\perp=\mathfrak{so}(4)\ne\mathfrak m$. So the reading survives at no $(p,q)$ with $p+q\ge3$ except by accident of smallness, and at $(2,2)$ it is refuted by the criterion the block itself invokes.

**The block's own arithmetic proves it means something else.** It writes: *"At $n=6$ the pair $(2,4)$ has $\dim\mathfrak m=8$."* But $\dim\big(\mathfrak{so}(2)\oplus\mathfrak{so}(4)\big)=1+6=7$, and $pq=2\cdot4=8$. The number quoted is $pq$. The same sentence writes $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-pq$, $pq$, not $\binom p2+\binom q2$. **So the block's $\mathfrak m$ is $\mathbb R^p\otimes\mathbb R^q$, the mixed planes, and the name attached to it is its orthogonal complement.**

**D2, the file already refuted this heading, 170 lines above it, today.** [L36](../findings/isotropy-cap.md)'s correction block carries the identical finding in the identical words:

> **THE FIRST VERSION NAMED $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ AS THE MAXIMISER, AND THAT IS FALSE TWICE OVER.** It is $\mathfrak m^\perp$ rather than $\mathfrak m$ … and **it is not admissible at all**, since an isotropic subalgebra is abelian, and at $n=6$ already $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1\ne0$ inside the first $\mathfrak{so}(3)$.

`git` dates that repair to **2026-09-04**, commit `5fb36ac7`, *"L36's maximiser was its own complement, and inadmissible besides"*, the same day as this audit. It was applied to L36 and **not propagated** to L76's heading, its first sentence, or its index row, all of which repeat the corrected error verbatim. L36's block even ends *"This file states the correct object 190 lines below"*, pointing at the L76 region, where the object is stated correctly in numbers and incorrectly in words.

## 3, The intended statement, proved in closed form for every $(p,q)$ with $p,q\ge1$

**Statement.** Let $[n]=P\sqcup Q$ with $|P|=p\ge1$, $|Q|=q\ge1$, and let $\mathfrak m_{p,q}=\mathop{\mathrm{span}}\{\varphi_{ab}:a\in P,\,b\in Q\}$, of dimension $pq$. Then $\mathfrak m_{p,q}$ is a **maximal isotropic** subspace of the Cartan $3$-form of $\mathfrak{so}(n)$.

**Proof.** In the orthonormal basis $\varphi_{ij}=E_{ij}-E_{ji}$,

$$[\varphi_{ij},\varphi_{kl}]=\delta_{jk}\varphi_{il}+\delta_{il}\varphi_{jk}-\delta_{ik}\varphi_{jl}-\delta_{jl}\varphi_{ik},$$

so $c_{(ij)(kl)(mn)}=\pm1$ exactly when the three index pairs are the three edges of a triangle in $K_n$, and $0$ otherwise.

*Isotropy.* A triangle has three vertices and two parts, so by pigeonhole two of its vertices lie in the same part and that edge is not mixed. No triangle has all three edges mixed, hence $\omega|_{\mathfrak m_{p,q}}=0$ identically, **residual exactly zero, in exact arithmetic, at every $(p,q)$ and every $n$.**

*The bracket span.* For $a,a'\in P$ and $b,b'\in Q$ the four cases of the display are

$$[\varphi_{ab},\varphi_{ab'}]=-\varphi_{bb'},\qquad[\varphi_{ab},\varphi_{a'b}]=-\varphi_{aa'},\qquad[\varphi_{ab},\varphi_{a'b'}]=0\ (a\ne a',\ b\ne b'),$$

so every bracket lands in $\mathfrak{so}(P)\oplus\mathfrak{so}(Q)$, and every basis vector of that space is hit: $\varphi_{bb'}$ needs some $a\in P$, which exists as $p\ge1$; $\varphi_{aa'}$ needs some $b\in Q$, which exists as $q\ge1$. Hence, **exactly**,

$$[\mathfrak m_{p,q},\mathfrak m_{p,q}]=\mathfrak{so}(P)\oplus\mathfrak{so}(Q)=\mathfrak m_{p,q}^{\perp},\qquad \dim=\binom p2+\binom q2 .$$

*Maximality.* Therefore $[\mathfrak m,\mathfrak m]^\perp=\big(\mathfrak m^\perp\big)^\perp=\mathfrak m$, which is L75's criterion met on the nose. In rank form, the binomial identity $\binom{p+q}2=\binom p2+\binom q2+pq$ gives

$$\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=\binom p2+\binom q2=\binom n2-pq=N-\dim\mathfrak m. \qquad\square$$

**This is symbolic in $(p,q)$ and closed at every $n$.** It supersedes the block's evidence (*"at every $(p,q)$ for $n=6,7,8$"*) which is a census over three values of $n$ offered for an unbounded *every*. The claim is true; the warrant on the page is not one.

**The range the heading owes.** At $q=0$ (equivalently $p=0$) the statement is **false at every $n\ge2$**: $\mathfrak m=\{0\}$, so $[\mathfrak m,\mathfrak m]=0$ and $[\mathfrak m,\mathfrak m]^\perp=\mathfrak{so}(n)\ne\{0\}$, every line $\mathbb Rx$ is isotropic, since $\omega$ is alternating, so $\{0\}$ extends. In rank form $0\ne N-0$. Whether $(n,0)$ deserves the name "symmetric pair" (its involution is the identity), is a matter of taste; the heading's *every* is unqualified and so is refuted by it, and the fix is to write $p,q\ge1$. The other degenerate cases are **fine and not vacuous**: $q=1$ gives $\mathfrak m=\mathbb R^{n-1}$, maximal, with $[\mathfrak m,\mathfrak m]=\mathfrak{so}(n-1)$; $p=q=1$ gives $n=2$, $\mathfrak m=\mathfrak{so}(2)$, maximal by $0^\perp=\mathfrak{so}(2)$; $q=2$ gives $\mathfrak m$ of dimension $2(n-2)$, maximal. Note that $\mathfrak m$ is **not** abelian at $q\ge1,p\ge2$, isotropy here comes from the $\mathbb Z_2$-grading $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, not from commutativity, which is exactly the distinction §2 turns on.

## 4, The criterion (L75), and a bound it hands over for free

**First equivalence: CONFIRMED, and the block's *equality* is right where the brief's *inclusion* would be weaker.**

Let $\mathfrak m$ be isotropic and $w\notin\mathfrak m$. Then $\mathfrak m\oplus\mathbb Rw$ is isotropic iff $\omega$ kills every triple drawn from it. Triples inside $\mathfrak m$ vanish by hypothesis; triples with **two or three** $w$'s vanish because $\omega$ is alternating, this uses the total antisymmetry of $c$ from [conventions.md](../findings/conventions.md), and **the block never says so**, though it is the step that makes the condition linear in $w$ rather than quadratic. Triples with exactly one $w$ give $\langle[u,v],w\rangle=0$ for all $u,v\in\mathfrak m$, i.e. $w\perp[\mathfrak m,\mathfrak m]$. Any isotropic $\mathfrak m'\supsetneq\mathfrak m$ contains such a $w$, so

$$\mathfrak m\ \text{maximal}\iff[\mathfrak m,\mathfrak m]^\perp\subseteq\mathfrak m .$$

The reverse inclusion $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ **is** isotropy, restated, it says $\langle[u,v],w\rangle=0$ for $u,v,w\in\mathfrak m$ and nothing more. So under the standing hypothesis it is automatic and the block's equality is correct. **It is also the better formulation**, for a reason the block does not claim: the equality is *self-enforcing*. $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ implies $\mathfrak m\perp[\mathfrak m,\mathfrak m]$, hence isotropy; so the equality characterises "maximal isotropic" among **all** subspaces, while the inclusion characterises it only among isotropic ones.

**Second equivalence: CONFIRMED, and it is a subspace dimension.** $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$ means $\dim\mathop{\mathrm{span}}\{[u,v]:u,v\in\mathfrak m\}$, computed as the rank of the matrix whose rows are $[e_a,e_b]$ over basis pairs, the two agree because the span is exactly the row space. With $N=\binom n2$, $\dim[\mathfrak m,\mathfrak m]^\perp=N-\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$, and given the automatic inclusion, equality of subspaces reduces to equality of dimensions. ✓

**But isotropy is a hypothesis of the second equivalence, and the block does not flag it.** Without it the rank count is not sufficient. Witness, in this file: $n=4$, $\mathfrak m=\mathfrak{so}(3)=\mathop{\mathrm{span}}(\varphi_{12},\varphi_{13},\varphi_{23})$, $d=3$, $N=6$. Then $[\mathfrak m,\mathfrak m]=\mathfrak{so}(3)$, so $\mathop{\mathrm{rank}}=3=N-d$ (the criterion's arithmetic is satisfied) while $[\mathfrak m,\mathfrak m]^\perp=\mathop{\mathrm{span}}(\varphi_{14},\varphi_{24},\varphi_{34})\ne\mathfrak m$ and $\mathfrak m$ is not isotropic at all. **This is the same $\mathfrak{so}(3)\subset\mathfrak{so}(4)$ configuration [L77](../findings/isotropy-cap.md) was repaired with, forty lines below**, and it applies here for the same reason: the rank identity is a consequence of maximal isotropy, not a substitute for isotropy.

**The strongest thing on the page, named.** The block says an unpolished run gave $\mathop{\mathrm{rank}}=15$ at $d=6$, *"impossible for a nonzero isotropic"*. The argument is one line and is the inequality the criterion saturates: isotropy gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp$, hence

$$\boxed{\ \mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]\le N-\dim\mathfrak m\ }$$

for every isotropic $\mathfrak m$, with equality iff maximal. At $d=6$, $n=6$ the ceiling is $9$; rank $15$ overshoots by six. **The block understates its own tell**, any value above $9$ was already impossible, so the run was detectably wrong long before it reached $N$.

**A bound the record does not carry, and it is free.** For maximal isotropic $\mathfrak m$ of dimension $d$, the span $[\mathfrak m,\mathfrak m]$ has at most $\binom d2$ generators $[e_a,e_b]$, so $N-d=\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]\le\binom d2$, i.e. $\binom n2\le d+\binom d2=\binom{d+1}2$, whence

$$\textbf{every maximal isotropic subspace of the Cartan 3-form has }\dim\ge n-1 .$$

Attained, with the generator count saturated, by $\mathfrak m_{1,n-1}$, where $\binom d2=\binom{n-1}2=N-d$ exactly. Combined with [L36](../findings/isotropy-cap.md)'s cap, **every maximal isotropic dimension lies in $[\,n-1,\ \lfloor n^2/4\rfloor\,]$**, at $n=6$, in $[5,9]$, which is precisely the set the block reports.

## 5, L75's table, its labels, and the Witt-index comparison

At $n=6$, $N=15$. The four rows are internally consistent ($\text{free}=(N-\mathop{\mathrm{rank}})-d$ throughout), and this is what closed form now says about each.

| $d$ | row's verdict | status after §3–§4 |
| --- | --- | --- |
| $4$ | extends, free $5$ | **Proven, and for all $4$-subspaces, not this one.** $d\ge n-1=5$ forbids any maximal isotropic of dimension $4$. The row's *destination* ("climbs into the maximal-$5$ family"), stays a measurement. |
| $5$ | maximal, rank $10$ | **Proven that dimension $5$ is achieved**: $\mathfrak m_{1,5}$ has $\mathop{\mathrm{rank}}=\binom52=10=N-5$. **The row cannot certify what it claims**, namely that a *generic* isotropic $5$-space is maximal: $\mathfrak m_{1,5}$ produces the identical rank, so the number does not separate generic from symmetric-pair. |
| $6$ | maximal, rank $9$ | **Measurement, and irreducibly so.** $pq=6$ with $p+q=6$ has no integer solution, so no symmetric pair sits here and §3 says nothing. Verified numerically at $n=6$ only. |
| $9$ | maximal, rank $6$, six singular values $\sqrt6$ | **Fully closed-form**, it is $\mathfrak m_{3,3}$; see §6. Not a measurement at all. |

**On the labels.** The record's rule is `Lemma` proven, `Observation` verified numerically at the dimensions named.

- **L75's criterion is correctly labelled**, §4 proves all three characterisations, at every $n$.
- **L75's table is not a lemma and sits under one.** Rows $d=6$ (and the $d=7$ row the commit history shows, at $13/14$) are numerical facts about randomly drawn subspaces at $n=6$. The block's summary sentence *"maximal isotropic subspaces occur at dimensions $5$, $6$ **and** $9$"* mixes three proven dimensions with one measured one and marks neither.
- **L76 is correctly labelled once §3 is written into it, and mislabelled as it stands**, the statement is a lemma, the argument offered is a census. This is the [L117](../findings/bounds.md) failure mode again: `git` shows the heading was added on **2026-09-02** by `5b258c14`, *"docs(isotropy-cap): place headings for Lemmas 75-82 … headings only: no statement, proof or table text is altered"*, ten days after the block it labels was written on 2026-08-23. The bulk heading commit copied the block's first sentence verbatim, inheriting its mislabel; it did not create it.

**D3, a same-level heading beginning "REFUTED" sits directly under L76's heading.** A reader scanning `####` lines sees `Lemma L76, every symmetric pair …` followed immediately by `REFUTED: there is no gap at 8 …`. The refutation is of the *earlier census*, not of L76, but nothing on the page says so, and the two headings are at the same depth.

**D4, L75's own summary is stale, left so by the commit that refuted it.** The sentence *"maximal isotropic subspaces occur at dimensions $5$, $6$ and $9$"* survives seventeen lines above L76's *"Maximal dimensions now known at $n=6$ include $5$, $6$, $7$, $8$ and $9$."* Commit `66457b5d` rewrote the table below that sentence and left the sentence itself untouched. Not a contradiction (both are existence claims) but the earlier list is the one a reader meets first, and it is the one the Witt-index remark is attached to.

**The Witt-index comparison: apt as a contrast, decorative as evidence, and the claim it decorates is now proved.** For a nondegenerate quadratic form all maximal totally isotropic subspaces do share a dimension, the Witt index; that is a real theorem and the contrast is correctly drawn. But the analogy carries no weight, the failure of equidimensionality is the ordinary behaviour of alternating *trilinear* forms, and no argument passes from the quadratic case to this one, so the sentence explains rather than establishes. **What it points at is real, and §3 proves it with no numerics at all.** At $n=6$ the pairs $(1,5),(2,4),(3,3)$ give maximal isotropics of dimensions $5$, $8$ and $9$, three distinct dimensions, from one closed-form lemma. In general $\{p(n-p):1\le p\le n/2\}$ is a strictly increasing set of $\lfloor n/2\rfloor$ distinct maximal dimensions, so **the dimension is non-constant at every $n\ge4$**, and the four rows are not needed for the conclusion they were offered for. The block's own $5,6,9$ list is *weaker* than what its own lemma yields.

## 6, The screen, and what it does and does not license

Screened, on objects constructed here, in exact rational arithmetic (Gaussian elimination over $\mathbb Q$; no tolerance, no random draw, no search): for every $(p,q)$ at $n=2,\dots,9$ the isotropy residual of $\mathfrak m_{p,q}$ is exactly $0$, and $\mathop{\mathrm{rank}}[\mathfrak m_{p,q},\mathfrak m_{p,q}]=\binom p2+\binom q2=N-pq$, with the criterion met at every $p,q\ge1$ and failing at every $q=0$. This **agrees with §3 and is reported only as agreement**; §3 is the warrant.

The same screen settles the block's singular-value figures as closed form, and here the derivation is the point. Under [conventions.md](../findings/conventions.md)'s **ordered**-pair convention, the bracket matrix has one row per ordered pair from $\mathfrak m_{p,q}$. Its columns are indexed by $\mathfrak{so}(P)\oplus\mathfrak{so}(Q)$ and are mutually orthogonal, because a target $\varphi_{bb'}$ is produced only by pairs $(\varphi_{ab},\varphi_{ab'})$ sharing their $P$-index and a target $\varphi_{aa'}$ only by pairs sharing their $Q$-index. Counting the $\pm1$ entries in each column,

$$\sigma=\sqrt{2p}\ \text{on each of the }\tbinom q2\ \mathfrak{so}(Q)\text{-columns},\qquad \sigma=\sqrt{2q}\ \text{on each of the }\tbinom p2\ \mathfrak{so}(P)\text{-columns}.$$

At $(3,3)$, $n=6$: $\binom32+\binom32=6$ columns, all with $\sigma=\sqrt{2\cdot3}=\sqrt6$. **That is the block's "six values of exactly $\sqrt6$ at the cap", derived**, the coincidence of the two values is $p=q$, and nothing was measured. A falsifiable consequence, offered for whenever computation is approved: the same run at $(2,4)$ must return $\{2^{\times6},2\sqrt2\}$, seven values, and at $(4,4)$, $n=8$, twelve values of $2\sqrt2$.

## 7, Provenance: CLEAN, all four self-historical claims

Checked by distinctive-phrase grep over `git log -S`. This block is one of the ones that comes back clean.

| claim in the block | `git` says | verdict |
| --- | --- | --- |
| "an earlier census of $14$ polished random draws per dimension reported maximal isotropics at $d=5,6,7,9$ and none at $d=8$" | `7e48c5c3`, 2026-08-23, *"dimension spectrum of maximal isotropic subspaces at n=6"*, body lists $14$ draws per dimension, $d=5,6,7,9$ maximal, $d=8$ EXTENDS $14/14$ | ✓ exact |
| the caveat *"these rows describe the generic subspace at each dimension and are not a classification"* was in the record | present verbatim in `7e48c5c3`'s diff | ✓ exact |
| "and the result was nonetheless titled a dimension spectrum" | the commit subject and the added bold sentence both say "dimension spectrum … with a gap at $8$" | ✓ exact |
| "(Reviewer 66, verified independently here)" | `66457b5d`, 2026-08-23, *"Found by Reviewer 66, verified here independently"* | ✓ exact |

The block also correctly reports that the $d=10$ control found nothing above the cap. **No boilerplate provenance sentence is present**, which is why this block escapes the failure mode the brief warns of.

**Pointers.** One empty target in this file, as the brief anticipated: [findings/isotropy-cap.md:350](../findings/isotropy-cap.md) writes `[Lemma L36](#)` in the $\#$-calculus block, an empty `(#)` where the working anchor `#lemma-l36--s0-caps-the-negative-eigenspace-at-lfloor-n22-rfloor--canonical-statement-and-proof` is used correctly at line 15. That is the only one. **Neither L75 nor L76 is anchored from anywhere**: their index rows at [findings/INDEX-results.md:90–91](../findings/INDEX-results.md) point at the file, not at the headings, and no other file in [findings/](../findings/) mentions either number. Both index rows read "Gate 2: no verdict on the record"; row 76's summary drops the offending symbols and reads "every symmetric pair is a maximal isotropic subspace", which is ambiguous rather than false, so the index needs the range $p,q\ge1$ and the object named, not a retraction.

## 8, What L76 feeds, and whether the chain needs it

**It is an obstruction result, not a step of the rigidity chain.** The chain runs isotropy $\Rightarrow S_{\mathfrak{mmm}}=0$, cap $\Rightarrow S_{\mathfrak{mhh}}=0$, together a $\mathbb Z_2$-grading $\Rightarrow$ symmetric pair $\Rightarrow$ Cartan $\Rightarrow$ balanced split. Every step is taken **at** $d=\lfloor n^2/4\rfloor$, and it needs only that the balanced pair is what sits there. **It does not need every symmetric pair to be maximal, and it does not use L76 at all**, L76 has no consumer on the record (§7).

**What L76 does is bound the reach of that chain from the other side.** The chain's conclusion is unavailable in the middle band $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$, and the reason is exactly that maximal isotropics live there: an isotropic subspace of dimension $8$ at $n=6$ need not sit inside a $9$-dimensional one, so it inherits nothing from the cap. **That conclusion is now unconditional and needs no numerics.** Section 3 supplies a witness in closed form at every $n\ge4$: $\mathfrak m_{1,n-1}$ is maximal isotropic of dimension $n-1$, and $3\le n-1<\lfloor n^2/4\rfloor$ for every $n\ge4$. The block currently rests the same conclusion on *"generic isotropic subspaces at $d=5,6,7$ are maximal"*, a sampled claim; the symmetric pairs alone carry it, and they are exact.

The one thing the sampled rows still add is that maximal isotropics exist **away from** the symmetric-pair family (dimension $6$ at $n=6$ admits no $(p,q)$) and that remains a measurement, correctly, at $n=6$.

## 9, What is owed, in order

1. **Rename the object in L76's heading, its first sentence and its index row.** "Every symmetric pair's odd part $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$", or the file's own idiom "$\mathfrak m$ of $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$", which the rigidity block at line 165 already uses correctly. **Reachable now**, the repair is the one applied to L36 today under `5fb36ac7`, moved 170 lines down.
2. **Add the range $p,q\ge1$.** Reachable now; §3 gives the $q=0$ witness.
3. **Replace the $n=6,7,8$ census with §3's four-line proof.** Reachable now, and it upgrades L76 from a checked claim to a theorem at every $n$.
4. **Record $d\ge n-1$** (§4). Reachable now; it is two lines from L75's own criterion, it makes L75's $d=4$ row a theorem, and with L36 it brackets the maximal dimensions in $[n-1,\lfloor n^2/4\rfloor]$.
5. **Mark isotropy as a hypothesis of L75's rank equivalence**, with the $\mathfrak{so}(3)\subset\mathfrak{so}(4)$ witness (§4). Reachable now, and it is the identical omission L77 was repaired for.
6. **Split L75's table by warrant**, $d=9$ closed form, $d=5$ dimension-achieved-but-genericity-unwitnessed, $d=4$ forced, $d=6$ measured at $n=6$. Reachable now.
7. **Repair the empty `(#)` at line 350, and refresh L75's stale "$5$, $6$ and $9$" to the proved $\{5,8,9\}\cup\{6,7\}$.** Reachable now.
