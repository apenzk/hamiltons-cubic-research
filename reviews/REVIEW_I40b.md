# REVIEW I40b, the symmetric pairs of $\mathfrak{so}(n)$, derived from the definitions

**Reviewer B of a Gate 2 pair, on a cold brief. No numerical work of any kind was done: every value below is exact and computed by hand. Log: [agent_logs/gate2-I40-B.log](../agent_logs/gate2-I40-B.log). Working from [conventions.md](../findings/conventions.md) and [references/](../references/) only; every other file in the repository was treated as unverified and none was used to close a step.**

The claim attacked: *every involution of the compact Lie algebra $\mathfrak{so}(n)$, $n\ge3$, is conjugate under $O(n)$ to one whose fixed subalgebra is $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$, or (for $n$ even) $\mathfrak u(n/2)$.*

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| 1 | The statement **as written**, for all $n\ge3$ | **BROKEN.** Explicit counterexample at $n=8$: the involution with fixed algebra $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$, constructed below and verified symmetric by two independent hand arguments. Its fixed algebra acts irreducibly on $\mathbb R^8$ and has dimension $21$, so it is $O(8)$-conjugate to nothing on the list |
| 2 | The statement restricted to $n\ge3$, $n\ne8$ | **PROVEN, hypotheses corrected.** No residual debt: every step is either proved here from the definitions or read off a source on file |
| 3 | The input $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ for $n\ge3$, $n\ne8$ | **PROVEN, now sourced.** It follows from [Ziller](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) Proposition 4.43 ($\mathrm{Aut}(\mathfrak k)/\mathrm{Int}(\mathfrak k)\cong\mathrm{Sym}(D(\mathfrak g))$) plus the diagram symmetry groups, together with an elementary rank argument given below. At $n=3$ and $n=4$ I prove it outright without any source |
| 4 | $\mathrm{Aut}(\mathfrak{so}(n))^{\circ}=\mathrm{Inn}(\mathfrak{so}(n))=\mathrm{Ad}(SO(n))$, $n\ge3$ | **PROVEN** here (Step 1) |
| 5 | $\ker\big(\mathrm{Ad}:O(n)\to\mathrm{Aut}(\mathfrak{so}(n))\big)=\{\pm1\}$, $n\ge3$ | **PROVEN** here (Step 2), by an elementary computation that uses $n\ge3$ exactly once and fails at $n=2$ |
| 6 | $\sigma=\mathrm{Ad}(g)$ involutive $\Rightarrow g^2=\pm1$, and the two cases give $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ / $\mathfrak u(n/2)$ | **PROVEN** here (Steps 3–5), completely |
| 7 | The record's convention row: *"an argument consuming $SO(n)$-conjugacy differs from it at $n=8$"* | **BROKEN as a guide to consumers.** It names the wrong divergence. $\mathrm{Aut}$ vs $O(n)$ diverges at $n=8$; **$O(n)$ vs $SO(n)$ diverges at every $n$ divisible by $4$**, including $n=12$, $16$, $20$, the record's own consumer range. See the conjugacy section |
| 8 | The statement at $n=2$ | **TRUE but for a reason the derivation does not supply.** $\mathrm{Aut}(\mathfrak{so}(2))=\mathbb R^\times\gg\mathrm{Ad}(O(2))$, yet its only involutions are $\pm\mathrm{id}$ and both conclusions happen to hold |
| 9 | The statement at $n=3$ and $n=4$ | **PROVEN**, with no debt. $\mathfrak{so}(4)$ being semisimple rather than simple costs nothing |
| 10 | $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$, the strongest falsifier candidate at $n\ge12$ | **REFUTED as a falsifier**, by an independent hand computation (Casimir $=9/28\ne1/2$). The pair is *not* symmetric |

**Headline verdict: BROKEN.** The claim as the record states it ($n\ge3$, conjugacy under $O(n)$), is false, with a counterexample at $n=8$ that is on the record's own list of worries but is stated there against the wrong conjugacy notion. The corrected statement ($n\ne8$) is derived here in full, with every step either proved from the definitions or read off a source on file.

*A note on the sources.* This review was written cold, and at the point of writing, the reference folder held no source for the one classical input the derivation needs. Four folders appeared in [references/](../references/) while the derivation was being written, [etingof-2024-real-forms-involutions](../references/etingof-2024-real-forms-involutions/), [ziller-2010-lie-groups-symmetric-spaces](../references/ziller-2010-lie-groups-symmetric-spaces/), [holland-ion-2012-symmetric-spaces](../references/holland-ion-2012-symmetric-spaces/), [yokota-2009-exceptional-lie-groups](../references/yokota-2009-exceptional-lie-groups/), and two of them settle it. I read and quote them below. The derivation was not changed to match them; only the status of Step 3 was.

## Notation fixed for this review

$\mathfrak g=\mathfrak{so}(n)=\{X\in M_n(\mathbb R):X^{\mathsf T}=-X\}$, the compact real form, with $\mathbb R^n$ carrying the standard positive-definite inner product $\langle\cdot,\cdot\rangle$. $O(n)$ acts by $\mathrm{Ad}(g)X=gXg^{-1}=gXg^{\mathsf T}$. An **involution** is $\sigma\in\mathrm{Aut}(\mathfrak g)$ with $\sigma^2=\mathrm{id}$; the identity is admitted, since a $\mathbb Z_2$-grading with $\mathfrak g_1=0$ is a $\mathbb Z_2$-grading. $\mathrm{Inn}(\mathfrak g)$ is the subgroup of $\mathrm{Aut}(\mathfrak g)$ generated by $\{e^{\mathrm{ad}X}:X\in\mathfrak g\}$. Writing $E_{ij}$ for the matrix units and $X_{ij}=E_{ij}-E_{ji}$ for $i\ne j$, the $X_{ij}$ with $i<j$ are a basis of $\mathfrak g$. The Killing-form normalisation used in the falsifier section is the record's own, from [conventions.md](../findings/conventions.md): $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$; index is normalised so that the vector representation of $\mathfrak{so}(m)$ has index $1$, again the record's convention.

## The derivation

### Step 1, $\mathrm{Aut}(\mathfrak g)^{\circ}=\mathrm{Inn}(\mathfrak g)=\mathrm{Ad}(SO(n))$ for $n\ge3$

*Hypotheses: $\mathfrak g$ semisimple with trivial centre; $SO(n)$ compact and connected.*

**(a) $\mathrm{Der}(\mathfrak g)=\mathrm{ad}(\mathfrak g)$ for any semisimple $\mathfrak g$.** Set $\mathfrak i=\mathrm{ad}(\mathfrak g)\subseteq\mathfrak d=\mathrm{Der}(\mathfrak g)$. For $D\in\mathfrak d$ and $x\in\mathfrak g$, $[D,\mathrm{ad}\,x]=\mathrm{ad}(Dx)$, so $\mathfrak i$ is an ideal of $\mathfrak d$. The Killing form $B_{\mathfrak d}$ restricted to the ideal $\mathfrak i$ equals the Killing form of $\mathfrak i\cong\mathfrak g$ (the centre is trivial, so $\mathrm{ad}$ is injective), which is nondegenerate. Hence $\mathfrak d=\mathfrak i\oplus\mathfrak i^{\perp}$ with $\mathfrak i^{\perp}$ an ideal, so $[\mathfrak i,\mathfrak i^{\perp}]\subseteq\mathfrak i\cap\mathfrak i^{\perp}=0$. For $D\in\mathfrak i^{\perp}$ and every $x$, $\mathrm{ad}(Dx)=[D,\mathrm{ad}\,x]=0$, so $Dx$ lies in the centre, which is $0$; thus $D=0$ and $\mathfrak d=\mathfrak i$.

**(b)** $\mathrm{Aut}(\mathfrak g)$ is a closed subgroup of $GL(\mathfrak g)$ (it is cut out by the polynomial equations $\varphi([x,y])=[\varphi x,\varphi y]$), hence a Lie group, and its Lie algebra is $\mathrm{Der}(\mathfrak g)$. By (a) that is $\mathrm{ad}(\mathfrak g)$, so $\mathrm{Aut}(\mathfrak g)^{\circ}$ is generated by $\exp(\mathrm{ad}\,\mathfrak g)$, which is by definition $\mathrm{Inn}(\mathfrak g)$.

**(c)** $e^{\mathrm{ad}X}=\mathrm{Ad}(e^{X})$, and $\exp:\mathfrak{so}(n)\to SO(n)$ is surjective because $SO(n)$ is compact and connected. Hence $\mathrm{Inn}(\mathfrak g)=\mathrm{Ad}(SO(n))$.

For $n\ge3$, $\mathfrak{so}(n)$ is semisimple with trivial centre, the trivial centre is Step 2 below, and semisimplicity is the nondegeneracy of $\mathop{\mathrm{tr}}(XY)$ on skew matrices, which is $-\|X\|_F^2$, definite. **At $n=2$ the algebra is abelian and every step of (a) fails.**

### Step 2, $\ker\big(\mathrm{Ad}:O(n)\to\mathrm{Aut}(\mathfrak g)\big)=\{\pm1\}$ for $n\ge3$

*Hypothesis: $n\ge3$, used exactly once and essentially.*

Let $A\in M_n(\mathbb R)$ commute with every element of $\mathfrak{so}(n)$. Then $A$ commutes with $X_{ij}^2=-(E_{ii}+E_{jj})$ for all $i\ne j$. For $n\ge3$ pick three distinct indices $i,j,k$; then
$$2E_{ii}=(E_{ii}+E_{jj})+(E_{ii}+E_{kk})-(E_{jj}+E_{kk}),$$
so $A$ commutes with each $E_{ii}$ and is therefore diagonal, $A=\mathop{\mathrm{diag}}(a_1,\dots,a_n)$. Now $AX_{ij}-X_{ij}A=(a_i-a_j)(E_{ij}+E_{ji})$, so $a_i=a_j$ for all $i\ne j$ and $A$ is scalar. An orthogonal scalar is $\pm1$.

**This is where $n\ge3$ lives.** At $n=2$ the commutant of $\mathfrak{so}(2)$ is $\{aI+bJ\}\cong\mathbb C$ and $\ker\mathrm{Ad}=SO(2)$, not $\{\pm1\}$. A corollary used repeatedly below: **an automorphism of the form $\mathrm{Ad}(g)$ determines $g\in O(n)$ up to sign.**

### Step 3, every automorphism is $\mathrm{Ad}(g)$ for some $g\in O(n)$, when $n\ge3$ and $n\ne8$

*Hypotheses: $n\ge3$, $n\ne8$; Step 1; Step 2.*

**(a) The index of $\mathrm{Ad}(O(n))$ over $\mathrm{Inn}$, elementarily.** For $n$ **odd**, $-1\notin SO(n)$ and $\mathrm{Ad}(-1)=\mathrm{id}$, so $O(n)=SO(n)\times\{\pm1\}$ and $\mathrm{Ad}(O(n))=\mathrm{Ad}(SO(n))=\mathrm{Inn}(\mathfrak g)$. For $n$ **even**, put $r=\mathop{\mathrm{diag}}(-1,1,\dots,1)$. Then $\mathrm{Ad}(r)$ is **not** inner: an inner automorphism $\mathrm{Ad}(h)$, $h\in SO(n)$, has $h$ lying in some maximal torus $T$ of the compact connected group $SO(n)$, so $\mathfrak t$ is fixed pointwise and $\mathop{\mathrm{rank}}\mathfrak g^{\mathrm{Ad}(h)}=\mathop{\mathrm{rank}}\mathfrak g=n/2$; whereas $\mathfrak g^{\mathrm{Ad}(r)}=\mathfrak{so}(n-1)$ has rank $n/2-1$. Hence $[\mathrm{Ad}(O(n)):\mathrm{Inn}]=1$ for $n$ odd and $2$ for $n$ even.

**(b) The index of $\mathrm{Aut}$ over $\mathrm{Inn}$, from a source on file.** [Ziller](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf), *Lie groups, representation theory and symmetric spaces*, Proposition 4.43 (§4.5, p. 81), read here rather than recalled:

> **Proposition 4.43** Let $K$ be a compact semisimple simply connected Lie group and $\mathfrak g=\mathfrak k^{\mathbb C}$ with Dynkin diagram $D(\mathfrak g)$. Then $\mathrm{Aut}(K)/\mathrm{Int}(K)\simeq\mathrm{Aut}(\mathfrak k)/\mathrm{Int}(\mathfrak k)\simeq\mathrm{Aut}(\mathfrak g)/\mathrm{Int}(\mathfrak g)\simeq\mathrm{Sym}(D(\mathfrak g))$ where $\mathrm{Sym}(D(\mathfrak g))$ is the group of symmetries of the Dynkin diagram.

This is stated for $\mathfrak k$ semisimple, so it covers $\mathfrak{so}(4)$ as well as the simple cases. The diagram symmetry groups are read off the diagrams and are stated in [Etingof](https://ocw.mit.edu/courses/18-755-lie-groups-and-lie-algebras-ii-spring-2024/mit18_755_s24_lec15.pdf) §41.2: for type $B_n$ ($\mathfrak{so}(2n+1)$), *"The Dynkin diagram has no nontrivial automorphisms"*; for type $D_n$ ($\mathfrak{so}(2n)$), *"in this case we have a unique nontrivial involution of the Dynkin diagram. More precisely, this is true for $n\ne4$, while for $n=4$ we have $\mathrm{Aut}(D)=S_3$"*. Adding the low cases $D(\mathfrak{so}(3))=A_1$ (trivial symmetry), $D(\mathfrak{so}(4))=A_1\sqcup A_1$ ($\mathbb Z_2$) and $D(\mathfrak{so}(6))=A_3$ ($\mathbb Z_2$):

$$[\mathrm{Aut}(\mathfrak{so}(n)):\mathrm{Inn}]=\begin{cases}1,&n\ \text{odd},\ n\ge3,\\ 2,&n\ \text{even},\ n\ge4,\ n\ne8,\\ 6,&n=8.\end{cases}$$

**(c) Conclusion.** Comparing (a) and (b): for every $n\ge3$ with $n\ne8$, $\mathrm{Ad}(O(n))=\mathrm{Aut}(\mathfrak{so}(n))$. **At $n=8$ the two disagree, $\mathrm{Ad}(O(8))$ having index $3$**; and (this is the mechanism of the break), a subgroup of index $3$ in a group with quotient $S_3$ is **not normal**, so conjugation inside $\mathrm{Aut}(\mathfrak{so}(8))$ moves involutions out of $\mathrm{Ad}(O(8))$ altogether.

**Two cases I close by hand anyway, with no source at all.**

- **$n=3$.** Under $\mathfrak{so}(3)\cong(\mathbb R^3,\times)$, the Killing form is a negative multiple of the standard inner product, so $\mathrm{Aut}(\mathfrak{so}(3))\subseteq O(3)$; and $g\in O(3)$ satisfies $g(u\times v)=gu\times gv$ iff $\det g=1$. Hence $\mathrm{Aut}(\mathfrak{so}(3))=SO(3)=\mathrm{Ad}(O(3))$.
- **$n=4$.** $\mathfrak{so}(4)=\mathfrak{su}(2)_{+}\oplus\mathfrak{su}(2)_{-}$ (the self-dual/anti-self-dual split of $\Lambda^2\mathbb R^4$). Any automorphism permutes the two minimal ideals, so $\mathrm{Aut}(\mathfrak{so}(4))=(SO(3)\times SO(3))\rtimes\mathbb Z_2$, using the previous bullet. Meanwhile $\mathrm{Ad}(SO(4))$ is a connected $6$-dimensional subgroup, hence equals $SO(3)\times SO(3)$; and $\mathrm{Ad}$ of an orientation-reversing reflection swaps $\Lambda^2_{+}$ and $\Lambda^2_{-}$, realising the $\mathbb Z_2$. So $\mathrm{Aut}(\mathfrak{so}(4))=\mathrm{Ad}(O(4))$.

**An equivalent formulation of what (b) buys, worth recording because it is the form that explains $n=8$.** Step 3 is equivalent to:

> **(I)** *Every automorphism of $\mathfrak{so}(n)$, $n\ge3$, $n\ne8$, carries the isomorphism class of the standard representation $\mathbb R^n$ to itself.*

(I) implies Step 3 directly: if $\rho\circ\sigma\cong\rho$ then some $T\in GL(n,\mathbb R)$ has $\rho(\sigma X)=T\rho(X)T^{-1}$; $\rho$ is absolutely irreducible by Step 2, so $T$ is unique up to a real scalar; both $\langle\cdot,\cdot\rangle$ and $\langle T\cdot,T\cdot\rangle$ are $\mathfrak{so}(n)$-invariant hence proportional, so after rescaling $T\in O(n)$ and $\sigma=\mathrm{Ad}(T)$. (I) fails precisely at $n=8$, where $\mathfrak{so}(8)$ has three inequivalent $8$-dimensional real orthogonal irreducibles (the vector representation and the two half-spin representations) which triality permutes.

**Corroboration of the whole classification, independently, from the second new source.** [Etingof](https://ocw.mit.edu/courses/18-755-lie-groups-and-lie-algebras-ii-spring-2024/mit18_755_s24_lec15.pdf) §41.3, Theorem 41.5, puts real forms of $\mathfrak g$ in bijection with conjugacy classes of involutions $\theta\in\mathrm{Aut}(\mathfrak g_c)$; §41.4 then enumerates them for the orthogonal types, and the enumeration is precisely Steps 4 and 5 of this review:

> *3. Type $B_n$. Then $\theta$ is an inner automorphism, given by an element of order $\le2$ in $SO(2n+1)$. So $\theta=\mathrm{Id}_{2p+1}\oplus(-\mathrm{Id}_{2q})$ where $p+q=n$. Thus all the real forms are $\mathfrak{so}(2p+1,2q)$ (all distinct), $\mathfrak k=\mathfrak{so}_{2p+1}\oplus\mathfrak{so}_{2q}$.*
>
> *5. Type $D_n$, compact inner class. We again have an inner automorphism $\theta$ given by $g\in SO(2n)$ such that $g^2=\pm1$. If $g^2=1$ … $\mathfrak k=\mathfrak{so}_{2p}\oplus\mathfrak{so}_{2q}$. … On the other hand, if $g^2=-1$ … $\mathfrak k=\mathfrak{gl}_n(\mathbb C)$.*
>
> *6. Type $D_n$, the other inner class. In this case $\theta$ is given by an element $g$ of $O(2n)$ such that $\det(g)=-1$ and $g^2=\pm1$. Note that if $g^2=-1$ then … $\det(g)=1$, so in the case at hand we always have $g^2=1$. … $\mathfrak k=\mathfrak{so}_{2p+1}\oplus\mathfrak{so}_{2q-1}$.*

Etingof's $\mathfrak k$ is the *complexified* fixed algebra, so $\mathfrak{gl}_n(\mathbb C)$ there is $\mathfrak u(n)$ here, the two families match exactly. Note also that his enumeration is **up to conjugacy in $\mathrm{Aut}$**, which is exactly the notion under which the $n=8$ break is invisible: he records for $D_4$ that "$\mathrm{Aut}(D)=S_3$, but there is still a unique non-trivial involution up to conjugation", which is consistent with, and does not rescue, the $O(8)$-form refuted below.

### Step 4, an involution induced by $O(n)$ has $g^2=\pm1$

*Hypotheses: Step 2 ($n\ge3$).*

Let $\sigma=\mathrm{Ad}(g)$ with $\sigma^2=\mathrm{id}$. Then $\mathrm{Ad}(g^2)=\mathrm{id}$, so $g^2\in\{\pm1\}$ by Step 2. The two cases are exclusive for a given $\sigma$: if $\mathrm{Ad}(g)=\mathrm{Ad}(g')$ then $g'=\pm g$, so $g'^2=g^2$.

### Step 5, the two cases, and their fixed algebras

**Case A: $g^2=1$.** Then $g=g^{-1}=g^{\mathsf T}$, so $g$ is a symmetric orthogonal matrix. **Here compactness enters**: by the real spectral theorem for the *positive-definite* form, $\mathbb R^n=V_{+}\oplus V_{-}$ orthogonally, with $g=\pm1$ on $V_{\pm}$; write $p=\dim V_{+}$, $q=\dim V_{-}$, $p+q=n$. Now
$$\mathfrak g^{\sigma}=\{X\in\mathfrak{so}(n):gXg^{-1}=X\}=\{X\in\mathfrak{so}(n):Xg=gX\},$$
and a matrix commuting with $g$ preserves each eigenspace; a skew matrix preserving an orthogonal splitting is block diagonal with skew blocks. Hence
$$\mathfrak g^{\sigma}=\mathfrak{so}(V_{+})\oplus\mathfrak{so}(V_{-})\cong\mathfrak{so}(p)\oplus\mathfrak{so}(q),\qquad \dim\mathfrak g^{\sigma}=\tbinom p2+\tbinom q2,$$
and the $(-1)$-eigenspace is the off-diagonal block, $\mathfrak g_1\cong\mathbb R^{p}\otimes\mathbb R^{q}$, of dimension $pq$. The arithmetic closes: $\binom p2+\binom q2+pq=\binom{p+q}2$. Replacing $g$ by $-g$ interchanges $(p,q)$, so the invariant is the unordered pair $\{p,q\}$; $q=0$ is $\sigma=\mathrm{id}$.

**Case B: $g^2=-1$.** Then $n$ is even, $n=2m$, and $g^{\mathsf T}=g^{-1}=-g$, so $g=:J$ is a **compatible complex structure**: skew-symmetric, orthogonal, $J^2=-1$. Identify $\mathbb R^{2m}=\mathbb C^{m}$ with $J$ acting as multiplication by $i$, and put $h(u,v)=\langle u,v\rangle+i\langle Ju,v\rangle$, a Hermitian form with $\mathop{\mathrm{Re}}h=\langle\cdot,\cdot\rangle$. Then
$$\mathfrak g^{\sigma}=\{X\in\mathfrak{so}(2m):XJ=JX\}.$$
For such $X$ (which is $\mathbb C$-linear), $h(Xu,v)+h(u,Xv)=\big[\langle Xu,v\rangle+\langle u,Xv\rangle\big]+i\big[\langle JXu,v\rangle+\langle Ju,Xv\rangle\big]$. The first bracket vanishes because $X$ is real-skew; the second because $\langle JXu,v\rangle=\langle XJu,v\rangle=-\langle Ju,Xv\rangle$, using $XJ=JX$ and again real-skewness. So $X$ is skew-Hermitian: $\mathfrak g^{\sigma}\subseteq\mathfrak u(m)$. Conversely a skew-Hermitian $\mathbb C$-linear map is $\mathbb C$-linear (so commutes with $J$) and $\mathop{\mathrm{Re}}h$-skew (so lies in $\mathfrak{so}(2m)$). Hence
$$\mathfrak g^{\sigma}=\mathfrak u(m)=\mathfrak u(n/2),\qquad\dim=m^2=n^2/4,$$
and $\dim\mathfrak g_1=\binom n2-\tfrac{n^2}4=\tfrac{n(n-2)}4$, which is $\dim_{\mathbb R}\Lambda^2_{\mathbb C}\mathbb C^{m}=m(m-1)$, as it must be. Note $\det J=1$ always ($J$ is orthogonally conjugate to $m$ copies of a $90^{\circ}$ rotation block), so $J\in SO(n)$.

**These two families are mutually exclusive and internally separated.** $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p,q\ge1$ preserves a proper subspace of $\mathbb R^n$; $\mathfrak u(m)$ does not, since it contains $J$ (so its invariant real subspaces are complex) and $\mathfrak{su}(m)$ is irreducible on $\mathbb C^m$; and $q=0$ gives $\dim=\binom n2>n^2/4$ for $n\ge3$. Within the first family, $\binom p2+\binom q2$ is strictly decreasing in $\min(p,q)$, so distinct unordered $\{p,q\}$ give non-conjugate involutions.

### Where each hypothesis is used

| hypothesis | the step that consumes it | what happens without it |
| --- | --- | --- |
| $n\ge3$ | Step 2 (three distinct indices) and Step 1 (semisimplicity) | at $n=2$, $\ker\mathrm{Ad}=SO(2)$ and $\mathrm{Aut}(\mathfrak{so}(2))=\mathbb R^\times$; the whole scaffolding collapses, though the conclusion survives by accident |
| $n\ne8$ | Step 3 only | triality; the claim is false, see below |
| compactness / positive definiteness | Step 5 Case A (real spectral theorem with *orthogonal* eigenspaces) and Case B ($J$ orthogonal $\Rightarrow$ $\mathfrak u(m)$ rather than $\mathfrak{gl}(m,\mathbb R)$) | for $\mathfrak{so}(p,q)$ the eigenspaces carry signatures and the fixed algebras are $\mathfrak{so}(p_1,q_1)\oplus\mathfrak{so}(p_2,q_2)$, $\mathfrak u(r,s)$, $\mathfrak{gl}(m,\mathbb R)$, $\mathfrak{so}(p,q)$ itself, a strictly longer list |
| the real field | Step 5 Case B: $g^2=-1$ has no square-root dodge, since $ig\notin O(n,\mathbb C)$ | over $\mathbb C$ the two cases persist but give $\mathfrak{so}(p,\mathbb C)\oplus\mathfrak{so}(q,\mathbb C)$ and $\mathfrak{gl}(m,\mathbb C)$ |
| Step 1's connectedness of $SO(n)$ | Step 1(c) | $\mathrm{Inn}$ would be only the image of the identity component |

## The exceptions, one by one

### $n=8$, the statement is FALSE, and here is the object

**Construction of the offending involution, from the definitions.** Let $\mathbb O$ be the octonions, $\mathbb R^7=\mathop{\mathrm{Im}}\mathbb O$, $\mathbb R^8=\mathbb O$ with its standard inner product. For $u\in\mathop{\mathrm{Im}}\mathbb O$ the left multiplication $L_u:\mathbb O\to\mathbb O$ satisfies $L_u^2=-|u|^2\,\mathrm{id}$ and $L_u^{\mathsf T}=-L_u$, so $\mathbb O$ is a real Clifford module for $\mathrm{Cl}(\mathbb R^7)$. Hence $\mathfrak{spin}(7)=\mathop{\mathrm{span}}\{L_uL_v-L_vL_u\}\cong\mathfrak{so}(7)$ embeds in $\mathfrak{so}(8)$; call the image $\mathfrak h$, $\dim\mathfrak h=21$. Write $\mathfrak m$ for its orthogonal complement in $\mathfrak{so}(8)$, $\dim\mathfrak m=28-21=7$.

**$\mathfrak h$ acts irreducibly on $\mathbb R^8$.** If it preserved a $k$-dimensional subspace, $0<k<8$, then $\mathfrak h$ would embed in $\mathfrak{so}(k)\oplus\mathfrak{so}(8-k)$, whose dimension is at most $\binom42+\binom42=12<21$. Impossible.

**$\mathfrak m$ is the vector module $\mathbb R^7$.** $\mathfrak m$ is a $7$-dimensional $\mathfrak h$-module. It has no trivial summand: a trivial summand would be an invariant vector in $\Lambda^2\mathbb R^8$, i.e. an invariant alternating form on the module $\mathbb R^8$; but $\mathbb R^8$ is real-irreducible with $\mathop{\mathrm{End}}_{\mathfrak h}(\mathbb R^8)=\mathbb R$, so its space of invariant bilinear forms is one-dimensional and is spanned by the *symmetric* form $\langle\cdot,\cdot\rangle$. Since the only $\mathfrak{so}(7)$-modules of dimension $\le7$ are the trivial one and $\mathbb R^7$, we get $\mathfrak m\cong\mathbb R^7$.

**$(\mathfrak h,\mathfrak m)$ is a symmetric decomposition.** The bracket $\Lambda^2\mathfrak m\to\mathfrak{so}(8)=\mathfrak h\oplus\mathfrak m$ is $\mathfrak h$-equivariant, and $\Lambda^2\mathfrak m=\Lambda^2\mathbb R^7\cong\mathfrak{so}(7)$ is irreducible of dimension $21$. Its image therefore lies in the $\mathfrak h$-isotypic component of $\mathfrak{so}(8)$ of type $\mathfrak{so}(7)$, which is $\mathfrak h$ (since $\mathfrak m\cong\mathbb R^7\not\cong\mathfrak{so}(7)$). So $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ holds because $\mathfrak m$ is the orthogonal complement of a subalgebra with respect to an $\mathrm{ad}$-invariant form. Hence $\sigma:=+1$ on $\mathfrak h$, $-1$ on $\mathfrak m$ is an **involutive automorphism of $\mathfrak{so}(8)$** with $\mathfrak g^{\sigma}=\mathfrak h$.

**$\sigma$ is $O(8)$-conjugate to nothing on the list.** $O(8)$-conjugation carries $\mathfrak g^{\sigma}$ to $g\,\mathfrak g^{\sigma}g^{-1}$, which is again irreducible on $\mathbb R^8$ and again $21$-dimensional. The candidates are: $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p,q\ge1$ (reducible; $\mathfrak{so}(8)$), dimension $28$; $\mathfrak u(4)$, dimension $16$. None matches. **The claim as written is false at $n=8$.**

*Independent confirmation of the symmetric property, by the Casimir test derived in the falsifier section below:* with the record's index normalisation, $\mathfrak h\subset\mathfrak{so}(8)$ has embedding index $1$ (the spin representation of $\mathfrak{so}(7)$ has $\mathop{\mathrm{tr}}(X^2)=8\cdot(-\tfrac14)=-2$ on $X=\tfrac12e_1e_2$, matching the vector representation's $-2$), so $-B_{\mathfrak{so}(8)}\big|_{\mathfrak h}=6\langle\cdot,\cdot\rangle_0$; and the Casimir of $\mathfrak{so}(7)$ on $\mathbb R^7$ in the $\langle\cdot,\cdot\rangle_0$ normalisation is $1\cdot21/7=3$. The ratio is $3/6=\tfrac12$, exactly the value a symmetric pair must have.

**What survives at $n=8$.** The *abstract-isomorphism* form survives: $\mathfrak{spin}(7)\cong\mathfrak{so}(7)=\mathfrak{so}(7)\oplus\mathfrak{so}(1)$, so the fixed algebra is still *isomorphic to* an algebra on the list. What fails is the geometric form, the realisation as the stabiliser of an orthogonal splitting or of a complex structure.

I did **not** determine how many $O(8)$-conjugacy classes of involutions $\mathfrak{so}(8)$ has, nor prove that $\mathfrak u(4)$ and $\mathfrak{so}(6)\oplus\mathfrak{so}(2)$ (isomorphic as abstract algebras, both of dimension $16$, and *not* $O(8)$-conjugate since one is irreducible on $\mathbb R^8$ and the other is not) are $\mathrm{Aut}$-conjugate. Those are open in this review and are not needed for the consumer statement.

### $n=4$, the statement survives, in full

$\mathfrak{so}(4)$ is semisimple but not simple. Step 1 is unaffected (it needs only semisimplicity and trivial centre). Step 3 is *proved* at $n=4$ above. So the classification holds: the involutions of $\mathfrak{so}(4)$ up to $O(4)$ are

| $g$ | $\mathfrak g_0$ | $\dim\mathfrak g_0$ | inner? |
| --- | --- | --- | --- |
| $\pm1$ | $\mathfrak{so}(4)$ | $6$ | yes (identity) |
| $\mathop{\mathrm{diag}}(1,1,1,-1)$ | $\mathfrak{so}(3)$, the diagonal $\mathfrak{su}(2)$ | $3$ | no, it is the ideal swap |
| $\mathop{\mathrm{diag}}(1,1,-1,-1)$ | $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, a maximal torus | $2$ | yes |
| $J$ | $\mathfrak u(2)=\mathfrak{su}(2)_{\pm}\oplus\mathbb R J$ | $4$ | yes |

The $(3,1)$ row is worth stating explicitly because it looks like an exception and is not: the ideal-swapping outer automorphism of $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ *is* $\mathrm{Ad}$ of a reflection, and its fixed algebra $\mathfrak{so}(3)$ is $\mathfrak{so}(3)\oplus\mathfrak{so}(1)$ in the notation of the claim.

### $n=3$

Step 3 is proved outright. In odd dimension $g^2=-1$ is impossible ($\det(g^2)=\det(g)^2=1$ while $\det(-I_3)=-1$), so only Case A occurs, giving $\mathfrak{so}(3)$ (identity) and $\mathfrak{so}(2)\oplus\mathfrak{so}(1)=\mathfrak{so}(2)$. Both are on the list. **Survives.**

### $n=2$

Excluded by the hypothesis, and rightly: $\mathfrak{so}(2)=\mathbb R$ is abelian, $\mathrm{Aut}(\mathfrak{so}(2))=\mathbb R^\times$, and $\mathrm{Ad}(O(2))=\{\pm1\}$ is a proper subgroup, so Step 3 fails badly. The *conclusion* nonetheless holds, because the only involutions in $\mathbb R^\times$ are $\pm1$: $+1$ has fixed algebra $\mathfrak{so}(2)\oplus\mathfrak{so}(0)$, realised by $g=1$; $-1$ has fixed algebra $0=\mathfrak{so}(1)\oplus\mathfrak{so}(1)$, realised by $g=\mathop{\mathrm{diag}}(1,-1)$. **A consumer must not read this as evidence that the derivation extends**, it is a coincidence of the two-element group.

### $n=6$, not an exception, and a free consistency check

$\mathfrak{so}(6)\cong\mathfrak{su}(4)$. The two classifications must agree, and they do, by dimension:

| $\mathfrak{so}(6)$ side | $\dim$ | $\mathfrak{su}(4)$ side | $\dim$ |
| --- | --- | --- | --- |
| $\mathfrak{so}(6)$ | $15$ | $\mathfrak{su}(4)$ | $15$ |
| $\mathfrak{so}(5)\oplus\mathfrak{so}(1)$ | $10$ | $\mathfrak{sp}(2)$ | $10$ |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(2)$ | $7$ | $\mathfrak s(\mathfrak u(2)\oplus\mathfrak u(2))$ | $7$ |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ | $6$ | $\mathfrak{so}(4)$ | $6$ |
| $\mathfrak u(3)$ | $9$ | $\mathfrak s(\mathfrak u(1)\oplus\mathfrak u(3))$ | $9$ |

Five classes on each side, matched bijectively by dimension. This is an independent check on Step 5's two families being the complete list at $n=6$.

## The three conjugacy notions

Write $\mathcal I$ for the set of involutions of $\mathfrak{so}(n)$. Three groups act on it: $SO(n)$ and $O(n)$ through $\mathrm{Ad}$, and $\mathrm{Aut}(\mathfrak g)$ by conjugation in $\mathrm{Aut}$.

**$\mathrm{Aut}$ versus $O(n)$.** These agree exactly when $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$, i.e. (Step 3) for every $n\ge3$ with $n\ne8$. **They differ at $n=8$ and only there**, where $\mathrm{Ad}(O(8))$ has index $3$ in $\mathrm{Aut}(\mathfrak{so}(8))$; the witness is the $\mathfrak{spin}(7)$ involution above.

**$O(n)$ versus $SO(n)$, and this is where the record's convention row misleads.** They differ, and *not* at $n=8$:

- *On the $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ family they agree, at every $n\ge3$.* Two reflections with the same eigenvalue multiplicities are $O(n)$-conjugate; and the $O(n)$-stabiliser of $g=\mathop{\mathrm{diag}}(I_p,-I_q)$ is $O(p)\times O(q)$, which contains elements of determinant $-1$ whenever $n\ge1$. So the $O(n)$-orbit is already a single $SO(n)$-orbit.
- *On the $\mathfrak u(n/2)$ family they differ exactly when $4\mid n$.* Write $n=2m$. Complex structures on $\mathbb R^{2m}$ form two $SO(2m)$-orbits, distinguished by the orientation $J$ induces (the orientation of the basis $v_1,Jv_1,\dots,v_m,Jv_m$), and fused by any orientation-reversing element of $O(2m)$. By Step 2, $\sigma_J=\sigma_{J'}$ iff $J'=\pm J$; and $-J$ induces the orientation of $J$ multiplied by $(-1)^m$. Hence: for $m$ **odd** the sign identification fuses the two orbits and there is **one** $SO(n)$-class; for $m$ **even** it does not, and there are **two** $SO(n)$-classes, fused by $O(n)$.

**The object where they differ, concretely.** At $n=4$: $\mathfrak{so}(4)=\mathfrak{su}(2)_{+}\oplus\mathfrak{su}(2)_{-}$, and the fixed algebra of a complex structure is $\mathfrak{su}(2)_{-}\oplus\mathbb R J$ with $J\in\mathfrak{su}(2)_{+}$, or the mirror image. $SO(4)$ preserves the splitting $\Lambda^2=\Lambda^2_{+}\oplus\Lambda^2_{-}$ and cannot exchange the two; a reflection does. Self-dual and anti-self-dual complex structures give $SO(4)$-inequivalent, $O(4)$-equivalent involutions.

**Verdict on the claim's own choice.** The claim is stated with $O(n)$, and $O(n)$ is the right notion: it is the coarsest of the three that is still faithful to the geometry, and for $n\ne8$ it coincides with $\mathrm{Aut}$-conjugacy. Restated with $SO(n)$ the claim would still be *true as a list of fixed subalgebras up to isomorphism* but would **undercount classes by one at every $n\equiv0\pmod4$**, at $n=12$, $16$, $20$, which is precisely the record's consumer range. The convention row's warning, which localises the discrepancy at $n=8$, is correct about $\mathrm{Aut}$ versus $O(n)$ and silent about the divergence that actually bites at $n\ge12$.

| notion | classes at even $n\ge6$, $n\ne8$ | at $n=12$ |
| --- | --- | --- |
| $\mathrm{Aut}(\mathfrak{so}(n))$ | $\lfloor n/2\rfloor+2$ | $8$ |
| $O(n)$ | $\lfloor n/2\rfloor+2$ | $8$ |
| $SO(n)$ | $\lfloor n/2\rfloor+2$ if $n\equiv2\ (4)$; $\lfloor n/2\rfloor+3$ if $n\equiv0\ (4)$ | $9$ |

(For odd $n\ge5$ all three coincide, with $\lfloor n/2\rfloor+1$ classes.)

## What a consumer may cite

The record's use is the enumeration of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ at $n\ge12$. The form that supports exactly that use, with every hypothesis:

> **Statement (safe to cite at $n\ge12$; in fact at every $n\ge3$ with $n\ne8$).**
> Let $n\ge3$, $n\ne8$, and let $\mathfrak{so}(n)=\mathfrak g_0\oplus\mathfrak g_1$ be a $\mathbb Z_2$-grading, i.e. $[\mathfrak g_i,\mathfrak g_j]\subseteq\mathfrak g_{i+j\bmod2}$ (the trivial grading $\mathfrak g_1=0$ admitted). Then:
> 1. The grading is the eigenspace decomposition of a unique involutive automorphism $\sigma$, and $\sigma=\mathrm{Ad}(g)$ for a $g\in O(n)$ unique up to sign, with $g^2=\pm1$.
> 2. After conjugating by an element of $SO(n)$, exactly one of the following holds.
>    - **(BD I)** $g=\mathop{\mathrm{diag}}(I_p,-I_q)$ with $p+q=n$, $p\ge q\ge0$; then $\mathfrak g_0=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ block-diagonally, $\dim\mathfrak g_0=\binom p2+\binom q2$, and $\mathfrak g_1$ is the off-diagonal block $\mathbb R^p\otimes\mathbb R^q$, $\dim\mathfrak g_1=pq$.
>    - **(D III)** $n$ even and $g=J$ a compatible complex structure ($J^{\mathsf T}=-J$, $J^2=-1$); then $\mathfrak g_0=\mathfrak u(n/2)$, $\dim\mathfrak g_0=n^2/4$, and $\dim\mathfrak g_1=n(n-2)/4$.
> 3. **Counting.** Up to $O(n)$-conjugacy (equivalently, for $n\ne8$, up to $\mathrm{Aut}(\mathfrak{so}(n))$-conjugacy), there are $\lfloor n/2\rfloor+1$ gradings of type BD I and, for $n$ even, one of type D III. Up to $SO(n)$-conjugacy the count is the same when $n\not\equiv0\pmod4$, and one larger when $n\equiv0\pmod4$, the D III class splitting into two by the orientation induced by $J$.
>
> **Hypotheses that must be carried, all of them:** $n\ge3$; $n\ne8$; the compact real form $\mathfrak{so}(n)$ (not $\mathfrak{so}(p,q)$, not $\mathfrak{so}(n,\mathbb C)$); conjugacy taken under $O(n)$ unless clause 3's $SO(n)$ refinement is what is wanted; and the identity grading included in the count.
>
> **Sources.** Step 3 rests on [Ziller](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) Proposition 4.43 together with the diagram symmetry groups in [Etingof](https://ocw.mit.edu/courses/18-755-lie-groups-and-lie-algebras-ii-spring-2024/mit18_755_s24_lec15.pdf) §41.2; the resulting two families are corroborated independently by Etingof §41.4 items 3, 5 and 6, and, over $\mathbb C$, by [Howe–Tan–Willenbring](https://arxiv.org/abs/math/0311159) Table I §3.2, whose "Direct Sum" row $O_n\times O_m\subset O_{n+m}$ and "Polarization" row $GL_n\subset O_{2n}$ are the complex shadows of the two families, that table asserts no completeness, listing "the symmetric pairs which we will cover in this paper", so it corroborates the list only. Everything else in this review is proved from the definitions.

At $n=12$ this gives, explicitly, the eight $O(12)$-classes with $(\dim\mathfrak g_0,\dim\mathfrak g_1)$ equal to $(66,0)$, $(55,11)$, $(46,20)$, $(39,27)$, $(34,32)$, $(31,35)$, $(30,36)$ for $(p,q)=(12,0),\dots,(6,6)$, and $(36,30)$ for $\mathfrak u(6)$; and nine $SO(12)$-classes, the $\mathfrak u(6)$ row splitting because $4\mid12$.

**Three things a consumer may NOT cite from this review.** That the classification holds at $n=8$ in the $O(n)$ form, it does not. That $SO(n)$-conjugacy may stand in for $O(n)$-conjugacy at $n\equiv0\pmod4$, it may not, and $n=12$ is such an $n$. And any count of the $O(8)$-conjugacy classes of involutions of $\mathfrak{so}(8)$, which this review leaves open.

## What would break it, and what I did to look for it

**The falsifier shape.** An involution $\sigma$ of $\mathfrak{so}(n)$, some $n\ge3$, whose fixed algebra $\mathfrak h$ is either (i) irreducible on $\mathbb R^n$ with $\dim\mathfrak h\ne n^2/4$, or (ii) reducible but not the full stabiliser of its invariant splitting. Type (i) is the dangerous one, because $O(n)$-conjugacy cannot move an irreducible subalgebra onto a reducible one, so a single such object kills the claim at that $n$. Equivalently: **a compact simple subalgebra $\mathfrak h\subsetneq\mathfrak{so}(n)$, acting irreducibly on $\mathbb R^n$, with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ for $\mathfrak m=\mathfrak h^{\perp}$.**

**A hand test for it.** For a symmetric pair $\mathfrak g=\mathfrak h\oplus\mathfrak m$ with $\mathfrak g$ simple and $\mathfrak m$ irreducible as an $\mathfrak h$-module, the Casimir of $\mathfrak h$ on $\mathfrak m$, normalised by $-B_{\mathfrak g}\big|_{\mathfrak h}$, equals $\tfrac12$. *Derivation.* Let $\{h_a\},\{m_i\}$ be orthonormal bases of $\mathfrak h,\mathfrak m$ for $-B_{\mathfrak g}$. The adjoint Casimir of $\mathfrak g$ is the identity, so on $\mathfrak m$: $\mathrm{Cas}_{\mathfrak h}\big|_{\mathfrak m}+C=\mathrm{Id}$ with $C=-\sum_i(\mathrm{ad}\,m_i)^2\big|_{\mathfrak m}$. For $m\in\mathfrak m$ put $A=\mathrm{ad}\,m|_{\mathfrak m}:\mathfrak m\to\mathfrak h$; ad-skewness gives $\mathrm{ad}\,m|_{\mathfrak h}=-A^{*}$, so $\mathop{\mathrm{tr}}_{\mathfrak m}(\mathrm{ad}\,m)^2=-\|A\|^2=\mathop{\mathrm{tr}}_{\mathfrak h}(\mathrm{ad}\,m)^2$, i.e. each is half of $B_{\mathfrak g}(m,m)=-1$. Hence $\mathop{\mathrm{tr}}_{\mathfrak m}C=\tfrac12\dim\mathfrak m$ and $\mathop{\mathrm{tr}}\big(\mathrm{Cas}_{\mathfrak h}|_{\mathfrak m}\big)=\tfrac12\dim\mathfrak m$; irreducibility of $\mathfrak m$ makes the operator scalar. *Calibration:* on the genuine symmetric pair $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ the test returns $3/6=\tfrac12$, as shown above.

**The candidate I hunted, and the outcome.** The one object that could break the claim inside the record's own range $n\ge12$ is $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$, the spin representation of $\mathfrak{so}(9)$ is real, $16$-dimensional and irreducible, so $\mathfrak h\cong\mathfrak{so}(9)$ sits irreducibly inside $\mathfrak{so}(16)$ with $\dim\mathfrak h=36\ne 64=16^2/4$. If it were symmetric, the claim would be **false at $n=16$**. It is on file: [Wolf 1968](https://archive.ymsc.tsinghua.edu.cn/pacm_download/117/6051-11511_2006_Article_BF02394607.pdf), Theorem 10.1 (p. 96), lists $\big(SO(16),\mathrm{Spin}(9)\big)$ among the pairs whose isotropy representation is absolutely irreducible.

Computing it by hand, in the record's index normalisation:

- Embedding index. On $X=\tfrac12e_1e_2$ the spin module $\Delta_9$ ($\dim16$) has eigenvalues $\pm\tfrac i2$ with multiplicity $8$ each, so $\mathop{\mathrm{tr}}_{\Delta_9}(X^2)=-4$, against $-2$ on $\mathbb R^9$. Index $2$.
- So $\mathop{\mathrm{ind}}\big(\mathrm{adj}\,\mathfrak{so}(16)\big|_{\mathfrak h}\big)=(16-2)\cdot2=28$, and $-B_{\mathfrak{so}(16)}\big|_{\mathfrak h}=28\,\langle\cdot,\cdot\rangle_0$.
- Subtracting $\mathop{\mathrm{ind}}(\mathrm{adj}\,\mathfrak{so}(9))=9-2=7$ leaves $\mathop{\mathrm{ind}}(\mathfrak m)=21$, which identifies $\mathfrak m\cong\Lambda^3\mathbb R^9$: $\dim=84=120-36$ and $\mathop{\mathrm{ind}}(\Lambda^3\mathbb R^9)=\binom72=21$. Both match.
- Casimir of $\mathfrak{so}(9)$ on $\Lambda^3\mathbb R^9$ in the $\langle\cdot,\cdot\rangle_0$ normalisation: $\mathop{\mathrm{ind}}\cdot\dim\mathfrak g/\dim V=21\cdot36/84=9$.
- Normalised value: $9/28$.

$9/28\ne\tfrac12=14/28$. **Not a symmetric pair; not a falsifier.** (The same test correctly rejects the other irreducible candidate I tried, $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ via $\mathrm{Sym}^4$: it returns $6/15=\tfrac25$.)

**What I also looked for and did not find.** A second irreducible symmetric subalgebra at $n=8$ beyond $\mathfrak{spin}(7)$ and $\mathfrak u(4)$; a $\mathfrak{sp}$-type fixed algebra (Step 4 forbids it, a single $g$ with $g^2=\pm1$ cannot encode a quaternionic structure, which is why $\mathfrak{so}(n)$ has no analogue of the $\mathfrak{sp}(m)\subset\mathfrak{su}(2m)$ symmetric pair); and, before the four new folders appeared, any source in [references/](../references/) stating input (I), at that point there was none, and [Howe–Tan–Willenbring](https://arxiv.org/abs/math/0311159) Table I was the closest thing on file, a list carrying no completeness claim.

**Verdict: BROKEN**, the claim as the record states it fails at $n=8$, by the $\mathfrak{spin}(7)$ involution exhibited above, whose fixed algebra acts irreducibly on $\mathbb R^8$ and so is the stabiliser of no orthogonal splitting. The corrected statement, $n\ge3$ and $n\ne8$, is derived here in full: Steps 1, 2, 4 and 5 from the definitions, Step 3 from [Ziller](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) Proposition 4.43 plus an elementary rank argument, with $n=3$ and $n=4$ closed by hand and independently of any source. The consumer's use at $n\ge12$ is supported by the boxed statement, provided the $SO(n)$-versus-$O(n)$ split at $n\equiv0\pmod4$ is respected, which the record's convention row, localising the discrepancy at $n=8$, does not warn about.
