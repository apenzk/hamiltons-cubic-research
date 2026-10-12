# Gate 2, reviewer r174: the orbit constraint's logical status, and the exact size of the reduced SDP

Cold adversarial review of [plan.md](../plan.md) item 3c, [sym3_weyl_blocks.sage](../scripts/runs/sym3_weyl_blocks.sage), [REVIEW_r171.md](REVIEW_r171.md), [REVIEW_r172.md](REVIEW_r172.md), and commits `40bdc9a`, `d84c242`, `9b2efcd`. Deliverable: derivation. The $n\ge12$ plethysm was not run; every figure below is $B_2$ character theory plus one integer enumeration, all under ten seconds.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $24$ blocks, dims summing to $7770$, mults $4,4,3,2^{\times9},1^{\times12}$, $65$ unknowns | **verified exactly, two independent routes**, Sage's symmetric power, and a from-scratch weight-multiset peel that never calls it |
| 2 | at most four vectors per block; group averaging "neither needed nor desirable" | **right conclusion, wrong measure and wrong reason**, the cost is the largest *weight space*, $234$, not the largest multiplicity, $4$; and exact averaging exists |
| 3 | the trivial block dies; the vector block "carries no cubic covariant by parity" | **first half right, second half refuted**, independently of r173, whose refutation landed at `2cc444b` while this was being derived |
| 4 | the orbit constraint is UNCONDITIONAL | **the implication is unconditional and both earlier reviewers were loose about it, but the plan's rebuttal answers a question neither of them asked, and the quantitative conclusion it draws is now false** |

**The result this review adds.** The orbit multiplicities $k_\lambda$ are not a bracket. They are **forced**, block by block, by the isotropy of $W_{\mathbb{CP}^2}$: $k_\lambda=1$ exactly when the second label of the block is even, $0$ otherwise. Summing the dimensions over that rule gives $3570$ **on the nose**, which derives the record's measured span rather than reproducing it, and pins the survivors at

$$\boxed{\ \textbf{36 scalar unknowns against 14 constraints}\ }$$

in two $3\times3$ blocks, five $2\times2$ and nine scalars. So [plan.md:317](../plan.md#L317)'s bracket $[9,54]$, r170's $[9,56]$ and my own exhaustive arithmetic bracket $[9,57]$ are all superseded, and with them the sentence **"the low end is over-determined against $14$ constraints"**, the low end is not where the problem sits, and $36$ against $14$ is comfortably under-determined.

---

## 1. Claim 4, the primary attack: what "unconditional" is true of, and what it is not

### 1.1 The implication is unconditional, and the derivation needs nothing about $F\ge0$

Write $F$ for the sextic, $v:\mathrm{Weyl}_5\to\mathrm{Sym}^3(\mathrm{Weyl}_5)$ for the cubic Veronese, and

$$\mathcal G:=\{G:\ G\succeq0,\ v(W)^{\!\top}Gv(W)=F(W)\ \text{identically}\}$$

for the SDP's feasible set. The claim at [plan.md:298](../plan.md#L298) is the statement

$$\forall G\in\mathcal G:\quad Gv(gW_0)=0\ \ \forall g\in O(5).$$

Its proof is three lines and uses only two inputs. Factor $G=L^{\!\top}L$; then $F(W_0)=\lVert Lv(W_0)\rVert^2=0$ forces $Lv(W_0)=0$, hence $Gv(W_0)=0$; $O(5)$-invariance of $F$ and equivariance of $v$ carry this along the orbit. The inputs are **$G\succeq0$**, which is part of the definition of $\mathcal G$ rather than an assumption about $F$, and **$F(W_0)=0$**. Global nonnegativity of $F$ never enters. This is textbook facial reduction, and the plan's word is the right one: as an implication the constraint is unconditional.

**So r171's "conditional on $F\ge0$ on $\mathrm{Weyl}_5$" and r172's "conditional" are, read literally, imprecise, and the correction at `d84c242` is well founded on that narrow point.** r171 in fact conceded the substance in its own caveat (*"a sound conditional, since infeasibility of $F\ge0$ would kill the certificate anyway"*) so what `d84c242` adds over the record is the label, not the observation.

### 1.2 What it is unconditionally true *of* is a set not known to be inhabited

A universally quantified statement over $\mathcal G$ is unconditional and **vacuous** at the same time if $\mathcal G=\varnothing$. Nothing on the record establishes $\mathcal G\ne\varnothing$; that is the whole of sub-step 2. So the honest form of the result is

> *any certificate, should one exist, annihilates the orbit-evaluation span; hence its Gram has rank at most $4200$.*

and the form on the record, *"$45.9\%$ of $\mathrm{Sym}^3$ forced into $\ker G$"*, reads as a statement about an existing object $G$. **This is the smuggle, and it is one of register rather than of logic.** The brief's suspicion, that the constraint "presupposes an SOS decomposition exists", is not borne out: a $\forall$ over a possibly-empty set presupposes nothing. But every phrase in the item that speaks of *"the certificate"*, *"the live problem"* or *"$\ker G$"* silently instantiates the quantifier, and that is what both earlier reviewers were reaching for with the word "conditional".

### 1.3 The rebuttal at `d84c242` answers a question nobody asked

The commit's argument runs: *the zero at $W_{\mathbb{CP}^2}$ is exhibited, and $F\ge0$ is what a certificate proves rather than assumes, so sub-step 2 has no unproved precondition.* Both sentences are true, and neither touches the objection. The reviewers' worry was about the non-vacuity of $\mathcal G$; the reply is about the provenance of $F\ge0$. **A route with no unproved precondition can still have an empty feasible set**, indeed the item's own next sentence tries to argue exactly that ("the low end is over-determined"). The rebuttal and the conclusion drawn immediately after it point in opposite directions.

### 1.4 The zero is exact, and it is also definitional

Here the record understates itself and oversells itself in the same paragraph.

**Understates.** $F(W_0)=0$ is not a $-8.9\times10^{-16}$ measurement; it is an identity, provable without a computer. At $n=5$ the Lovelock collapse gives $\theta=3\operatorname{tr}(W^3)$; padded $W_{\mathbb{CP}^2}$ has $\Lambda^2$-spectrum $(2,-1,-1,0^7)/\sqrt6$, so $p_1=0$, $p_2=1$, $p_3=(8-1-1)/6^{3/2}=1/\sqrt6$, whence $\theta=3/\sqrt6=\sqrt{3/2}$ and $\Theta_5^2\lVert W_0\rVert^6-\theta^2=\tfrac32-\tfrac32=0$; the $\mu$ term vanishes because $Q(W_0)=\theta W_0$. **Propping an exact identity on floating-point agreement to $10^{-16}$, and citing "$60$ ascents" and "second-order.md at $3\times10^{-16}$" as independent corroboration of it, is weaker evidence than the two lines above and invites the reader to think a measurement is load-bearing where none is.**

**Oversells.** $\Theta_5$ is *defined* as $\sqrt{3/2}=\theta(W_0)$. So "$F$ vanishes at $W_{\mathbb{CP}^2}$" is a consequence of how $F$ was written down, and the item says as much elsewhere, *"the expression is identically zero at the extremiser: tight by construction."* The orbit constraint is therefore **a generic consequence of tightness, present in any tight SOS problem**, rather than a discovered feature of this one. That is worth recording plainly, because it settles what the constraint can and cannot be evidence for: it is evidence about the *shape* of $\mathcal G$, and no evidence at all about whether $\mathcal G$ is inhabited or about $\Theta_5$.

### 1.5 Where the conditionality genuinely lives, and it is not where either side put it

$F\ge0$ on $\mathrm{Weyl}_5$ is equivalent, on the critical locus $W\wedge Q(W)=0$ that the $\mu$ term cuts out, to $\Theta_5\le\sqrt{3/2}$, which [plan.md:310](../plan.md#L310) itself lists as *"what the record does not have"*. So the plan's "only nonnegativity elsewhere is open" is accurate but flat: what is open is the $n=5$ conjecture entire. **The item is internally consistent on this and neither reviewer's phrasing was fatal; the correction at `d84c242` is a refinement of vocabulary, not of mathematics.**

---

## 2. The $k_\lambda$ profile is forced, the orbit constraint has an exact answer

This is the computation [REVIEW_r173.md](REVIEW_r173.md) identified as the way to replace the bracket by a number and did not carry out. It comes out clean.

### 2.1 The isotropy group

$W_0$ is the padded $\mathbb{CP}^2$ Weyl tensor, supported on $\mathbb R^4\subset\mathbb R^5$. Any $g\in O(5)$ fixing $W_0$ preserves that support and its orthogonal complement, so $H:=\mathrm{Stab}_{O(5)}(W_0)=H_4\times\{\pm1\}$ with $H_4=\mathrm{Stab}_{O(4)}(W_{\mathbb{CP}^2})$ and the $\pm1$ acting on $e_5$.

$W_{\mathbb{CP}^2}$ has $W^+$ of spectrum $(2,-1,-1)/\sqrt6$ and $W^-=0$. An element of $O(4)$ of determinant $-1$ exchanges $\Lambda^+$ and $\Lambda^-$, so it cannot fix a tensor whose two halves differ; hence $H_4\subset SO(4)$. Under $SO(4)\to SO(3)_+\times SO(3)_-$ the condition is that the $SO(3)_+$ factor fix $\mathrm{diag}(2,-1,-1)$ and the $SO(3)_-$ factor be unconstrained, so

$$H_4=\bigl(N(T)_+\times SU(2)_-\bigr)/\{\pm1\},\qquad H_4^{\circ}\cong U(2),\ \dim H_4=4,\ \text{two components}.$$

### 2.2 $\dim V_\lambda^H$ is $1$ or $0$, by the second label alone

Branch $\mathfrak{so}(5)\to\mathfrak{so}(4)$. The interlacing rule sends the irreducible $(a,b)$ to $\bigoplus_{(p,q)}$ with $a\ge p\ge b\ge|q|$, and $(p,q)$ carries spins $j_\pm=(p\pm q)/2$. Invariance under $SU(2)_-$ forces $j_-=0$, i.e. $p=q$, and the interlacing then forces $p=q=b$: **exactly one constituent survives, with $(j_+,j_-)=(b,0)$ and dimension $2b+1$.** Sage's branching confirms uniqueness on every block I checked, including $(4,2)\to(2,0)$, $(4,3)\to(3,0)$, $(6,6)\to(6,0)$, $(1,0)\to(0,0)$.

Invariance under the torus $U(1)_+$ picks the zero-weight line of that spin-$b$ space, dimension $1$. The second component of $H_4$ acts on it by the $\pi$-rotation about a perpendicular axis, which sends $\lvert b,0\rangle\mapsto(-1)^b\lvert b,0\rangle$. Finally $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$ factors as $(-\mathrm{Id}_5)\cdot(-\mathrm{Id}_4\oplus1)$ with $-\mathrm{Id}_4\oplus1\in H_4$, and $-\mathrm{Id}_5$ acts trivially on $\mathrm{Sym}^3(\mathrm{Weyl}_5)$ by parity, so $\varepsilon$ imposes nothing new. Hence

$$\dim V_\lambda^{H}=\begin{cases}1,&b\ \text{even}\\0,&b\ \text{odd,}\end{cases}\qquad\text{and}\qquad k_\lambda\le\min(m_\lambda,\dim V_\lambda^H)\le 1 .$$

### 2.3 The bound is attained, and it reproduces $3570$ exactly

The span of $\{v(gW_0)\}$ is the image of $\mathbb C[O(5)/H]$, so $\sum_\lambda k_\lambda d_\lambda\le\sum_{b\ \mathrm{even}}d_\lambda$. Summing the sixteen blocks with even second label,

$$220+35+105+390+165+55+30+14+810+625+455+429+140+91+5+1=3570$$

gives precisely the record's measured span. **An upper bound that equals a measured value forces equality throughout**, so $k_\lambda=1$ on those sixteen and $0$ on the eight with $b$ odd, and $\sum(m_\lambda-k_\lambda)d_\lambda=4200$ confirms the rank bound independently.

*Two things follow immediately.* The $45.9\%$ figure is now **derived rather than sampled**, r173 rebuilt it from $4800$ Haar samples, this rebuilds it from the isotropy, and the two agree. And the trivial block $(0,0)$ and the vector block $(1,0)$ both have $b=0$, so both die by the orbit, which is the mechanism `2cc444b` has just installed for the vector block.

### 2.4 The reduced SDP, exactly

| block $(a,b)$ | $m_\lambda$ | $k_\lambda$ | reduced size | unknowns |
|---|---|---|---|---|
| $(4,2)_{220}$, $(2,2)_{35}$ | $4$ | $1$ | $3\times3$ | $6+6$ |
| $(3,2)_{105}$ | $3$ | $1$ | $2\times2$ | $3$ |
| $(4,3)_{231}$, $(4,1)_{154}$, $(3,1)_{81}$, $(2,1)_{35}$ | $2$ | $0$ | $2\times2$ | $3\times4$ |
| $(5,2)_{390}$, $(4,4)_{165}$, $(4)_{55}$, $(3)_{30}$, $(2)_{14}$ | $2$ | $1$ | $1\times1$ | $1\times5$ |
| $(6,3)_{770}$, $(5,3)_{455}$, $(5,1)_{260}$, $(3,3)_{84}$ | $1$ | $0$ | $1\times1$ | $1\times4$ |
| the eight remaining multiplicity-$1$ blocks, $b$ even | $1$ | $1$ |, | $0$ |

**Two $3\times3$ PSD blocks, five $2\times2$, nine scalars: $36$ unknowns.** Against $\dim(\mathrm{Sym}^6\mathrm{Weyl}_5)^{O(5)}=14$, which I reproduce from $B_2$ symmetric powers alongside $1,1,4,5$ at degrees $2,3,4,5$, the degree-$3$ entry being the $1$ that the item correctly contrasts with $2$ at $n\ge12$.

### 2.5 Consequences for the record

- **[plan.md:317](../plan.md#L317)'s "the live problem is $63$ parameters" is right as a lower bound on the reduction and far short of it.** The true figure is $36$, and the reduction is $29$ unknowns rather than $2$.
- **"The low end is over-determined against $14$ constraints" no longer has a referent.** The low end $9$ is an artefact of the bracket; the actual reduced problem has $36$ unknowns against $14$ equations, so its affine slice has dimension $\ge22$ before the PSD cones are imposed. **The one argument on the record pointing at infeasibility of the degree-$3$ ansatz is removed by this, and nothing replaces it.** That is a change in the item's outlook, not merely in its bookkeeping.
- **The bracket's endpoints are wrong anyway.** Exhaustive enumeration over $\sum k_\lambda d_\lambda=3570$, $0\le k_\lambda\le m_\lambda$, has $3\,392\,286$ solutions and survivor counts spanning $[9,57]$, not $[9,54]$ or $[9,56]$; a witness at $57$ is $k=1$ on $(5,2)_{390}$ and on the multiplicity-$1$ blocks of dimensions $810,770,625,455,429,91$, losing eight unknowns from $65$. Forcing the trivial block to $k=1$ does not move either endpoint. *Moot now, but all three published brackets are arithmetic claims and all three are wrong.*

---

## 3. Claims 1 and 3, verified independently

**Claim 1 reproduces exactly, twice.** Sage's `WeylCharacterRing("B2")(2,2).symmetric_power(3)` gives $24$ blocks, multiplicities summing to $41$, $\sum m_\lambda d_\lambda=7770$, $65$ unknowns, profile $12$ scalars, nine $2$s, one $3$, two $4$s. A second route that calls no plethysm, form the $7770$ weight triples of the $35$ weights of $\mathrm{Weyl}_5$ and peel highest weights against Freudenthal multiplicities, returns the identical table with zero residue. **Every dimension in [plan.md:308](../plan.md#L308) is right**, checked against $\dim(a,b)=(a-b+1)(a+b+2)(2a+3)(2b+1)/6$ for $B_2$.

**The $(2,2)_{35}$ coincidence the brief asks about is neither a coincidence nor an error.** $(2,2)$ *is* $\mathrm{Weyl}_5$, and multiplicity $4$ says there are four independent $O(5)$-equivariant cubic maps $\mathrm{Weyl}_5\to\mathrm{Weyl}_5$. The trap sits one row below instead: the table also lists $(2,1)_{35}$, a **different** irreducible of the **same** dimension. That is the same $35$-fold ambiguity the item already flags for $4\omega_2$ against $\omega_1+2\omega_2$, and it recurs inside the block table itself.

**Claim 3's parity argument is wrong, and my derivation agrees with r173's.** $\mathrm{Weyl}_5\subset V^{\otimes4}$ so $-\mathrm{Id}$ acts by $(-1)^4=+1$, hence trivially on $\mathrm{Sym}^3\subset V^{\otimes12}$; the constituents are therefore the $[\mu]$ with $|\mu|$ even and the $[\mu]\otimes\det$ with $|\mu|$ odd. Parity kills the vector $[1]$, and $[1]\otimes\det=\Lambda^4\mathbb R^5$, also $5$-dimensional, is exactly what parity permits. Both of my decompositions place a $5$-dimensional block in the table with multiplicity $1$; a table of $24$ blocks summing to $7770$ **contains** it, so the item's own numbers contradicted its own sentence. `2cc444b` has since installed the correct account, and the correct mechanism (the orbit), is confirmed by §2.3, where $(1,0)$ has $b=0$ and therefore $k=1$.

*One addition to `2cc444b`.* At odd $n$ the $SO(5)$ labels lose no information, because $|\mu|$ and $|\tilde\mu|=|\mu|+n-2\mu'_1$ have opposite parities, so exactly one of $[\mu],[\mu]\otimes\det$ can occur. **The table is a faithful encoding after all**, the defect was reading its labels as $O(5)$ partitions, not the labels themselves.

---

## 4. Claim 2, right conclusion, wrong measure, wrong reason

**"At most four vectors per block" is not the cost.** A highest-weight vector of weight $\lambda$ is found as the kernel of the two raising operators inside the weight-$\lambda$ subspace of $\mathrm{Sym}^3(\mathrm{Weyl}_5)$, so the size of the linear algebra is that weight space, not the multiplicity. Measured: the largest weight space of $\mathrm{Sym}^3(\mathrm{Weyl}_5)$ is **$234$** (at weight $(0,0)$), then $210$ at $(1,0)$, $162$ at $(2,0)$, $116$ at $(2,2)$, $72$ at $(3,2)$, $38$ at $(4,2)$, $2$ at $(6,4)$. **The conclusion survives comfortably**, exact rational kernels of a few $\le234$-dimensional systems are trivial, and the ambient $7770$ is never formed densely, but the item reaches it through a number that does not measure the work.

**Exactness is available at the input too**, which the item does not say: $W_{\mathbb{CP}^2}$'s $\sqrt6$ is a unit-norm normalisation, and the orbit-vanishing condition $Gv(W_0)=0$ is scale-invariant, so one may work with the rescaled tensor over $\mathbb Q$ throughout.

**"Group averaging would introduce approximation" is false as stated.** Isotypic projection on a compact group is a Reynolds operator, and it has an exact rational implementation through the Casimir: the projector onto the $\lambda$-isotypic component is the interpolation polynomial in $\Omega$ that is $1$ at the Casimir eigenvalue of $\lambda$ and $0$ at the others, all of which are rational. What introduces approximation is *Haar sampling*, one implementation of averaging among several. **The right reason to prefer highest-weight vectors here is cost, not exactness**, the Casimir route needs the operator on all of $\mathrm{Sym}^3$, where weight-by-weight work stays inside $234$ dimensions.

---

## Answers to the three questions

**(a) One thing.** `d84c242`'s substance was already on the record: r171 wrote *"a sound conditional, since infeasibility of $F\ge0$ would kill the certificate anyway, but it should be stated"*, which concedes the implication and asks only for the qualification. The commit presents this as a correction *of* r171 rather than the fold-in *of* r171's own caveat. Nothing else in `40bdc9a` is a restatement, the multiplicity profile it adds is precisely what r172 asked for.

**(b) $6$ is right for the item as scoped, and generous for the work in flight.** The rubric at [plan.md:81](../plan.md#L81) reads $3\times2\times1$, with `closes`$=3$ earned by a certificate **at $n=12$**. Everything in this cycle is $n=5$, and the item's own line says an $n=5$ certificate does not lift (*"no lift; trace-word transfer needs the stable range and $n=5$ carries the Lovelock syzygy"*) so the sub-step actually being executed has `closes`$=1$ and a grade of $2$. Against that, §2 raises `attackable` for the $n=5$ half: the reduced problem is now fully specified at $36$ unknowns, $14$ constraints, blocks $3,3,2,2,2,2,2,1^{\times9}$, and only the explicit projections remain. **Keep $6$; the two adjustments cancel, and the item should say which $n$ the $3$ is being claimed at.**

**(c) Exactly $36$, down from $65$.** Unconditionally $\ge36$ from the isotropy bound alone, and $=36$ once the record's measured span of $3570$ is used to force the bound to equality. The reduction is $29$ unknowns: sixteen blocks lose one multiplicity each, which costs $4+4$ in the two multiplicity-$4$ blocks, $3$ in the multiplicity-$3$ block, $2$ in each of five multiplicity-$2$ blocks and $1$ in each of eight multiplicity-$1$ blocks, so $8+3+10+8=29$. **The record's "smaller than $65$", "$63$", and the brackets $[9,54]$, $[9,56]$, $[9,57]$ should all be replaced by the single number.**

---

## What I ran, and what I did not

The $n\ge12$ plethysm was not invoked. Everything is $B_2$: `symmetric_power(3)` of the $35$-dimensional module; an independent weight-multiset peel using Freudenthal multiplicities only; `symmetric_power(k)` for $k\le6$ for the invariant counts $1,1,4,5,14$; `branch` to $D_2$ to confirm the $j_-=0$ uniqueness; and one exhaustive integer enumeration in plain Python over $\sum k_\lambda d_\lambda=3570$. Total wall clock under a minute. The isotropy computation of §2.1–2.2 is on paper and was checked only through the $3570$ agreement.
