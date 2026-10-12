# VERIFY_v201, Lemma L21, cold verification

Brief read cold: [BRIEF_L21.md](BRIEF_L21.md), sections A–E, with [conventions.md](../findings/conventions.md) and the surrounding blocks of [route-a.md](../findings/route-a.md). **No numerical work of any kind was done**, no script, no Sage, no Python, no numeric evaluation, and in particular no re-diagonalisation of any $F_\lambda$. Every number below is exact rational arithmetic on objects I constructed for the purpose, done by hand, and is reported as a screen. Log: [verify-L21-v201.log](../agent_logs/verify-L21-v201.log).

## Claim table

| # | Claim as the record states it | Verdict |
| --- | --- | --- |
| 1 | Section A carries a canonical statement of L21 | **BROKEN**, a heading and a proof pointer, nothing between; and the heading's *"every dimension"* is false at $n\le8$ |
| 2 | Section B is a faithful summary of section C | **PROVEN, hypotheses corrected**; faithful on content, but it omits the range and calls a computation *"fixed"* that no file carries in closed form |
| 3 | $\mathrm{Weyl}_n=\bigoplus_\lambda M_\lambda\otimes V_\lambda\Rightarrow F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}$, *"no multiplicity-free hypothesis"* | **PROVEN, hypotheses corrected**: real Schur needs each $V_\lambda$ **absolutely** irreducible; that holds here at $m\ge5$, and the record states it nowhere |
| 4 | The six $SO(m)$-types and their multiplicities $20,20,6,10,4,1$ | **PROVEN**, derived here in full from the block decomposition, identically in $m$, for every $m\ge5$ |
| 5 | $\dim V_{(2,1)}=\tfrac{m(m-2)(m+2)}3$, $\dim V_{(2,2)}=\tfrac{m(m+1)(m+2)(m-3)}{12}=\dim\mathrm{Weyl}_m$, and $\sum\dim M_\lambda\dim V_\lambda=\dim\mathrm{Weyl}_n$ identically in $m$ | **PROVEN**, the polynomial identity closes exactly; both dimension formulas are right |
| 6 | *"Every $\dim M_\lambda$ is identical across $n=10,12,14$"* | **PROVEN**, and by more than three data points: the multiplicities are $m$-free constants |
| 7 | *"Every $F_\lambda$ spectrum is identical across $n=10,12,14$"* | **HYPOTHESIS-DEBT**, three sampled dimensions, no argument on file, and the record's two audits contradict each other about what is owed |
| 8 | Fifth row, *"two higher types ($0$ throughout"* | **PROVEN), hypotheses corrected**: the conclusion holds, the record's stated reason does not |
| 9 | *"$F_u$ preserves $A$-index degree and vanishes on degree $\le1$"* | **BROKEN**, $F_u$ vanishes on neither the degree-$1$ block $AC$ nor the degree-$0$ block $BB$, and the sentence's own image clause lists both |
| 10 | $\operatorname{im}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$ | **PROVEN**, derived here from $[\mathfrak{so}(4),\mathfrak{so}(m)]=0$ and $u$'s support |
| 11 | $T_u(SO(n).u)=2\cdot\mathbf1\oplus4\cdot V$, $\dim=4n-14$ | **PROVEN** |
| 12 | The $\tfrac12\theta^*$-eigenspace **is** the orbit tangent space | **PROVEN, hypotheses corrected**: one inclusion is two lines from equivariance and criticality, not the numerical coincidence the record records; the reverse needs the tables |
| 13 | *"The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$"* (section C) | **BROKEN**, over-strong; refuted by the explicit $m=5$ branching below |
| 14 | *"$\ell(\nu)\le2$, Littlewood needs $m\ge4$, $SO(m)$-irreducibility $m\ge5$, valid at every $n\ge9$"* (section D) | **PROVEN**, this is the correct reading, and my independent block computation reaches the same endpoint without Littlewood |
| 15 | *"The two tables already disagree"* | **withdrawn**, they are logically compatible; section D's is incomplete, not contradictory |
| 16 | $\alpha\le\tfrac13$, with equality attained, for every $n$ | **HYPOTHESIS-DEBT**, the exhaustion half now has a proof, the four $F_\lambda$ spectra have none, and no $\tfrac13$-eigenvector is exhibited anywhere in closed form |

**Summary.** *The half of L21 that was asserted from three data points (the type list, the multiplicities and the annihilation of the $940$), is now proved outright, identically in $m$, for every $n\ge9$; the half that carries the bound (the four $F_\lambda$ matrices), still has no argument on file, so the lemma is exactly as far from proved as its four $20\times20$, $20\times20$, $6\times6$, $10\times10$ blocks are.*

**Verdict: HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

Quoted, never restated.

- $\dim\mathcal W_n$: *"$\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$"* ([conventions.md](../findings/conventions.md)).
- $Q$, $P$, $\theta$: *"$Q(W)$ (Hamilton's quadratic map $W^2+W^\#$"*, *"$P(W)$), the cubic form $\langle W,Q(W)\rangle$"*, *"$\theta$, $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"* ([conventions.md](../findings/conventions.md)).
- $\theta^*$: *"Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$"*, [route-a.md](../findings/route-a.md), Lemma L20's notation line. **It has no row in [conventions.md](../findings/conventions.md).** I grepped the file for `theta^*` and got nothing.
- $F_u$: *"$F_u(h)=\tfrac12(uh+hu)+u\# h$"*, [route-a.md](../findings/route-a.md), Lemma L20's proof. Also untabled.
- $\alpha$, in this block's sense: *"$\alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle$"*, same line.
- $u$: the padded $\mathbb{CP}^2$-type competitor, as [Lemma L17](../findings/route-a.md) commits to, *"this proof commits to the padded reading, nothing else having the spectrum it runs on."*
- $\mathrm{Weyl}_n$ as a subspace: *"$\mathrm{Weyl}_n=S^2(\Lambda^2\mathbb R^n)\ominus S^2\mathbb R^n\ominus\Lambda^4\mathbb R^n$"*, section D of the brief. I use exactly this.

**Symbol collisions, checked one at a time.** These are the six the round names.

| symbol | senses live in this block | status |
| --- | --- | --- |
| $m$ | $\sqrt{2/3}\max P$ in [Lemma L20](../findings/route-a.md)'s proof, and $n-4$ in section D | **live and dangerous, the two occur in the same paragraph** (§7) |
| $\alpha$ | this block's $\sqrt{2/3}\langle F_uV,V\rangle$; a cubic coefficient and an eigenframe index in [L35](../findings/stratum-two-negative.md), per the conventions row | live across files, unambiguous inside L21 |
| $\theta^*$ | one sense only | untabled, not ambiguous |
| $u$ | the competitor here; the orbit acceleration in the $\Pi$ row of [conventions.md](../findings/conventions.md); $\lambda_1^2+d$ in [L35](../findings/stratum-two-negative.md) | live across files, unambiguous inside L21 |
| $F$ | $F_u$ and $F_\lambda$ here; [Lemma L17](../findings/route-a.md)'s first-variation functional $F(H)$, **in the same file, forty lines up** | live, untabled |
| $M_\lambda$ | multiplicity space here; $M(n)$ the global max of $P$, and $M$ the sectional matrix, both tabled | live across files; $M_\lambda$ itself untabled |

## Hypothesis inventory

Every hypothesis the argument uses, marked by whether the record states it. **A pass with no inventory is not a pass.**

| # | Hypothesis | Where used | Stated? |
| --- | --- | --- | --- |
| H1 | $u=W_{\mathbb{CP}^2}$ padded, supported in $\Lambda^2\mathbb R^4$ | everything | **yes**, section C |
| H2 | $G=SO(m)$, $m=n-4$, acting on the last $m$ coordinates and fixing $\mathbb R^4$ pointwise | everything | **yes**, section C |
| H3 | $Q$ is $SO(n)$-equivariant | $F_u$ commutes with $G$; the orbit eigenvalue | **no**, the record instead *measures* the commutation at $3.9\times10^{-15}$ |
| H4 | $u$ is **critical**: $Q(u)=\theta^*u$ | $F_uu=\theta^*u$ (the deleted $1$); $T_u\mathcal O\subseteq E(\tfrac12\theta^*)$ | **no** in L21; stated in [Lemma L17](../findings/route-a.md), which flags it as *"load-bearing and stated nowhere"* |
| H5 | Each $V_\lambda$ is **absolutely** irreducible over $\mathbb R$ | the Schur step | **no**, §2 |
| H6 | The six $V_\lambda$ are pairwise non-isomorphic | that the decomposition is the isotypic one | **no** |
| H7 | $m\ge5$ | H5, H6, and the irreducibility of $\Lambda^2\mathbb R^m$, $S^2_0\mathbb R^m$, $V_{(2,1)}$, $V_{(2,2)}$ | **contested inside the record**: section C says $m\ge8$, section D says $m\ge5$ |
| H8 | The four tabulated $F_\lambda$ spectra, and their independence of $m$ | the entire numerical content of the bound | **stated as verified at $n=10,12,14$; not proved** |
| H9 | $\mathrm{Weyl}_n$ is $G$-invariant inside $S^2(\Lambda^2\mathbb R^n)$ | that the restriction makes sense | **no**; true, since it is $SO(n)$-invariant |
| H10 | $\dim\mathfrak{stab}_{\mathfrak{so}(4)}(u)=4$ | $\dim=2$ for the trivial part of the orbit | asserted as *"$\mathfrak{so}(4)/\mathfrak{stab}_4$ (dimension 2)"*, unproved, §6 |

**Hypothesis stated but never used, a clean negative.** I looked for one and found none in section C. **$\lVert H\rVert=1$**, the inert hypothesis [Lemma L17](../findings/route-a.md) carries, does not recur here. The *unital algebra* trap that killed a route elsewhere on this record does not bite: no theorem about algebras is imported into L21 at all, Schur's lemma is imported instead, and §2 checks its hypotheses.

## 1. What section A would have to say

**The finding is that section A states no result.** It is a heading,

> `##### Lemma L21, the eigenvalue bound $\alpha\le1/3$ holds in every dimension, for a structural reason`

followed immediately by `**Proof:** [route-a.md](findings/route-a.md)`. There is no statement of what $\alpha$ is, what $F_u$ is, on what subspace the bound holds, or for which $n$. **This is the same defect the record itself books against the L20 entry directly above it**, in section D's last annotation.

**Drawn from the argument as written, the canonical statement would have to be:**

> **Lemma L21.** *Let $n\ge9$, let $u\in\mathcal W_n$ be the padded $\mathbb{CP}^2$-type competitor of [conventions.md](../findings/conventions.md), critical with $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$, and let $F_u(h)=\tfrac12(uh+hu)+u\#h$ on $\mathcal W_n$. Then the largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, and it is attained; equivalently $\alpha:=\sqrt{2/3}\langle F_uV,V\rangle\le\tfrac13$ for every unit $V$ in that subspace, with equality for some $V$.*

Three things that statement must carry and the heading does not:

- **The range.** *"In every dimension"* is **false**. At $n=8$ ($m=4$) $SO(4)$ is not simple, $\Lambda^2\mathbb R^4$ splits into $\Lambda^\pm$, $\mathrm{Weyl}_4$ splits into $\mathrm{Weyl}^\pm$, and three of the six rows stop being single isotypic components, which is the record's own reading in [Lemma L100](../findings/route-a.md): *"At $n=8$ the failure is structural rather than bookkeeping."* §5 confirms $m\ge5$ is where the decomposition first holds, so the range is $n\ge9$.
- **The subspace.** The bound is on $u^\perp\cap T_u\mathcal O^\perp$ and on nothing else; on $\mathcal W_n$ itself the top eigenvalue is $\theta^*$, and on $u^\perp$ alone it is $\tfrac12\theta^*$. Section D's own note records what that costs: *"Without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty and the theorem is vacuous."*
- **Criticality**, H4, without which $u$ is not an eigenvector and the deletion of $\mathbb Ru$ has no meaning.

**Is section B a faithful summary?** On content, yes. *"$W_{\mathbb{CP}^2}$ lives in $\Lambda^2(\mathbb R^4)$, so the construction is $SO(n-4)$-equivariant and Schur applies with no multiplicity-free hypothesis"* is section C's mechanism verbatim in substance, and *"Four spaces of dimensions $20,20,6,10$ carry every nonzero eigenvalue and do not vary with $n$"* is exactly section C's four named rows plus its fifth row's content. Two corrections it needs:

1. It carries no range either, so it inherits the false *"every dimension"*.
2. *"making the bound a fixed finite computation"* describes a computation that **has not been performed in any form the record can check**, §7. The honest phrasing is *reduces the bound to a fixed finite computation*.

## 2. The Schur step, against real Schur

**The step.** $\mathrm{Weyl}_n=\bigoplus_\lambda M_\lambda\otimes V_\lambda$ and $F_u$ commutes with $G$, therefore $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$, *"since multiplicities are exactly what the spaces $M_\lambda$ absorb."*

**The slogan is not the proof, and over $\mathbb R$ it is not enough.** Everything here is real: $\mathcal W_n$ is a real vector space, $F_u$ is a real symmetric operator on it, and the $V_\lambda$ are real irreducibles. For a real irreducible $V$, $D:=\mathrm{End}_G(V)$ is $\mathbb R$, $\mathbb C$ or $\mathbb H$ by the real Schur lemma, and the correct general statement is

$$\mathrm{End}_G(M\otimes_D V)\;\cong\;\mathrm{End}_D(M),$$

which is $\mathrm{Mat}_k(D)$, not $\mathrm{Mat}_k(\mathbb R)$. Concretely: if $D=\mathbb C$ with generator $J\in\mathrm{End}_G(V)$, $J^2=-\mathrm{Id}$, then

$$F_u\big|_{\text{isotypic}}\;=\;F_\lambda\otimes\mathrm{Id}_V\;+\;F'_\lambda\otimes J$$

is $G$-equivariant for **any** pair $F_\lambda,F'_\lambda$, and the claimed form is the special case $F'_\lambda=0$. The eigenvalue consequence changes with it: the spectrum of $F_\lambda\otimes\mathrm{Id}+F'_\lambda\otimes J$ is not $\operatorname{spec}(F_\lambda)$ but the spectrum of the complex matrix $F_\lambda+iF'_\lambda$, each eigenvalue doubled. **So $\operatorname{spec}(F_u)=\bigcup_\lambda\operatorname{spec}(F_\lambda)$ genuinely requires $D=\mathbb R$**, i.e. each $V_\lambda$ absolutely irreducible. That $F_u$ is real and symmetric does not supply it, a symmetric operator commuting with a quaternionic $G$-action is still an $\mathbb H$-linear map.

**Does the step have absolute irreducibility here?** Yes, at $m\ge5$, and the record never says so. The six types occurring (§5) are $\nu=(0),(1),(1,1),(2),(2,1),(2,2)$, every one a **tensor** representation of $SO(m)$ with row length $\ell(\nu)\le2$. For $m\ge5$ we have $\ell(\nu)\le2<m/2$, so none of them is a $\pm$-split half of a middle exterior power and each stays irreducible after complexification. A real representation that is irreducible and remains irreducible over $\mathbb C$ is absolutely irreducible, so $D=\mathbb R$ in all six cases and the claimed form is correct.

**Verdict: PROVEN, hypotheses corrected.** The conclusion is right; H5 must be added to the statement, and with it H7 ($m\ge5$), since $D=\mathbb R$ is exactly what fails when $\Lambda^2\mathbb R^4$ or $\mathrm{Weyl}_4$ splits at $m=4$.

**One thing the record gets right that its own prose obscures.** The contrast it draws, *"the structural difference from the thesis's route, which works with the full stabilizer and asks each irreducible subspace to be an eigenspace"*, is correct and is the real content. Multiplicity-freeness is needed to conclude *each irreducible is an eigenspace*; it is not needed to conclude *each isotypic component is $F_\lambda\otimes\mathrm{Id}$*. The gain is genuine.

## 3. The image of $F_u$, and the degree argument, checked separately

Write $\Lambda^2\mathbb R^n=A\oplus B\oplus C$ with $A=\Lambda^2\mathbb R^4$ ($\dim6$), $B=\mathbb R^4\otimes\mathbb R^m$ ($\dim4m$), $C=\Lambda^2\mathbb R^m$ ($\dim\binom m2$); as a Lie algebra $A=\mathfrak{so}(4)$, $C=\mathfrak{so}(m)$. The blocks of $S^2(\Lambda^2\mathbb R^n)$ are $AA,AB,AC,BB,BC,CC$, and the **$A$-index degree** of a block is how many of its two $\Lambda^2$ factors lie in $A$: degree $2$ is $AA$; degree $1$ is $AB$ and $AC$; degree $0$ is $BB$, $BC$, $CC$.

**The anticommutator part.** $u$ as an operator on $\Lambda^2\mathbb R^n$ maps $A\to A$ and kills $B\oplus C$. So $(uh)$ is supported in $A$-rows and $(hu)$ in $A$-columns:

$$[\tfrac12(uh+hu)]_{XY}=\tfrac12\big(u_{AA}h_{AY}\delta_{XA}+h_{XA}u_{AA}\delta_{YA}\big).$$

Hence it maps $AA\to AA$, $AB\to AB$, $AC\to AC$, and **kills $BB$, $BC$, $CC$**. It preserves $A$-degree.

**The sharp part.** $\langle u\#h,\cdot\rangle$ contracts two structure constants of $\mathfrak{so}(n)$ against $u$ and $h$: $(u\#h)_{\alpha\beta}\propto c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}u_{\gamma\varepsilon}h_{\delta\zeta}$. Since $u$ is supported in $A$, both $\gamma$ and $\varepsilon$ lie in $A$, so $c_{\alpha\gamma\delta}$ and $c_{\beta\varepsilon\zeta}$ are brackets **against $\mathfrak{so}(4)$**. The bracket table is

$$[A,A]\subseteq A,\quad [A,B]\subseteq B,\quad [A,C]=0,\quad [B,B]\subseteq A\oplus C,\quad [B,C]\subseteq B,\quad [C,C]\subseteq C,$$

and only the first three are consulted. So $(\alpha,\delta)$ is in $A\times A$ or $B\times B$, and likewise $(\beta,\zeta)$. Hence $u\#h$ maps $AA\to AA$, $AB\to AB$, $BB\to BB$, and **kills $AC$, $BC$, $CC$**. It too preserves $A$-degree.

**Two conclusions, and they are not the same conclusion.**

- **Image claim: CORRECT.** $\operatorname{im}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$. Both parts land there; nothing lands in $BC$ or $CC$. The record's stated reason, *"from $[\mathfrak{so}(4),\mathfrak{so}(m)]=0$"*, is the right reason and is the $[A,C]=0$ row above.
- **Degree claim: BROKEN.** *"$F_u$ preserves the $A$-index degree and vanishes on degree $\le1$"* is false twice over, and the sentence refutes itself: if $F_u$ preserved degree **and** vanished on degree $\le1$, its image would be $AA$ alone, and the same sentence's image list contains $AB$, $AC$ and $BB$.
  - **$AC$ is degree $1$ and $F_u$ does not vanish on it.** In closed form: take $h=\omega\odot\eta$ with $\omega\in\Lambda^+\subset A$ an eigenvector of $u|_A$ with eigenvalue $2c\ne0$ and $\eta\in C$ any nonzero bivector of $\mathbb R^m$. Then $u\#h=0$ (the $AC$ block is killed by the sharp part) but $\tfrac12(uh+hu)=2c\,\omega\odot\eta\ne0$. So $F_uh=2c\,h\ne0$.
  - **$BB$ is degree $0$ and $F_u$ does not vanish on it.** There the anticommutator dies and the sharp part does not, $BB\to BB$ is one of the three surviving arrows, and $S^2B$ is where the $S^2_0$ row's multiplicity space largely lives (§5), a block the table itself records as carrying $\tfrac13$ and $-\tfrac16$.

**The correct statement of the mechanism**, which the record must write in place of the broken one:

> $F_u$ preserves the $A$-index degree, and $F_u$ annihilates exactly the blocks $BC\oplus CC$, the anticommutator because $h$ there has no $A$-row and no $A$-column, the sharp part because $[\mathfrak{so}(4),\mathfrak{so}(m)]=0$ forbids the $C$ index from being reached through a bracket against $u$'s support.

**Does that rescue "$0$ throughout"?** It does, but only with one further step the record never takes, and the step is not about $F_u$ at all: **one must know that the two higher isotypic components lie inside $BC\oplus CC$.** They do, and §5's branching is what shows it, the type $(2,1)$ occurs in $S^2(\Lambda^2\mathbb R^n)$ **only** in $B\otimes C$, with multiplicity exactly $4$, and $(2,2)$ **only** in $S^2C$, with multiplicity exactly $1$. Multiplicity $4$ and $1$ are the multiplicities the record claims, so the isotypic components have nowhere else to sit and are contained in $BC\oplus CC$, which $F_u$ kills. **Claim 8: PROVEN, hypotheses corrected.** The row is true; the argument on file for it is not; and the missing step is the exhaustiveness of the branching, which is a different claim from the one the annotation argues.

*Note on the annotation's phrasing.* *"Both higher isotypics sit at degree $0$ and $1$"* is loose in a way that matters: they sit at degree $0$ **only**. Degree $1$ contains $AC$, where $F_u$ is nonzero, so a reader who accepts the sentence has accepted the false half.

## 4. The two unnamed types, dimensions and the identity in $m$

All exact, by hand.

**$\dim V_{(2,1)}$.** The record gives $\tfrac{m(m^2-1)}3-m$ and calls $\tfrac{m(m-2)(m+2)}3$ its factored form. $\tfrac{m^3-m}3-m=\tfrac{m^3-m-3m}3=\tfrac{m^3-4m}3=\tfrac{m(m-2)(m+2)}3$. ✓ It vanishes at $m=2$ as claimed. It is also positive at $m=3$, so *"strictly positive at every $m\ge4$"* is true but weaker than the truth.

**$\dim V_{(2,2)}$.** $\tfrac{m(m+1)(m+2)(m-3)}{12}$ against the tabled $\dim\mathcal W_m=\tfrac{m(m-3)(m+1)(m+2)}{12}$, **the same polynomial, factor for factor.** ✓ The record's claim that this is *"an equality of formulas rather than an agreement at one dimension"* is correct.

**Sanity at $m=5$, the boundary.** $\dim V_{(2,1)}=\tfrac{5\cdot3\cdot7}3=35$ and $\dim V_{(2,2)}=\tfrac{5\cdot6\cdot7\cdot2}{12}=35$. Equal dimensions, different highest weights $(2,1)$ and $(2,2)$, so still non-isomorphic. I cross-checked both against the Weyl dimension formula for $B_2$ with $\rho=(\tfrac32,\tfrac12)$: for $(2,1)$, $2\cdot\tfrac52\cdot\tfrac73\cdot3=35$; for $(2,2)$, $1\cdot3\cdot\tfrac73\cdot5=35$. ✓ Both irreducible at $m=5$.

**The identity in $m$.** Set $n=m+4$ and sum $\sum_\lambda\dim M_\lambda\dim V_\lambda$ with the claimed multiplicities:

$$20\cdot1+20\cdot m+6\cdot\tbinom m2+10\big(\tfrac{m(m+1)}2-1\big)+4\cdot\tfrac{m(m-2)(m+2)}3+1\cdot\tfrac{m(m+1)(m+2)(m-3)}{12}.$$

The first four give $8m^2+22m+10$. Multiplying everything by $12$:

$$12(8m^2+22m+10)+4(4m^3-16m)+m(m+1)(m+2)(m-3)=96m^2+264m+120+16m^3-64m+(m^4-7m^2-6m)$$
$$=m^4+16m^3+89m^2+194m+120.$$

And $12\dim\mathcal W_{m+4}=(m+4)(m+1)(m+5)(m+6)=(m^2+5m+4)(m^2+11m+30)=m^4+16m^3+89m^2+194m+120.$

**Identical.** ✓ The identity holds **as polynomials in $m$**, not at a sampled dimension. At $m=8$ it reads $698+940=1638$, and $4\cdot160+300=940$ with $\tfrac{8\cdot6\cdot10}3=160$ and $\tfrac{8\cdot9\cdot10\cdot5}{12}=300$, the record's own numbers. ✓

## 5. The branching, derived rather than accepted

This is the load-bearing claim, since exhaustion is what the bound needs, and the record asserts it in one clause. **I derived it independently, and it is correct.** Restrict everything to $G=SO(m)$, using $\Lambda^2\mathbb R^n=A\oplus B\oplus C$ from §3, where $A=6\cdot\mathbf1$, $B=4\cdot V$, $C=\Lambda^2$.

$$S^2(\Lambda^2\mathbb R^n)=S^2A\;\oplus\;A\!\otimes\!B\;\oplus\;A\!\otimes\!C\;\oplus\;S^2B\;\oplus\;B\!\otimes\!C\;\oplus\;S^2C.$$

| block | as $SO(m)$-modules | why |
| --- | --- | --- |
| $S^2A$ | $21\cdot\mathbf1$ | $A$ is six trivials |
| $A\otimes B$ | $24\cdot V$ | $6\times4$ |
| $A\otimes C$ | $6\cdot\Lambda^2$ | $6\times1$ |
| $S^2B$ | $10\cdot S^2_0\;\oplus\;10\cdot\mathbf1\;\oplus\;6\cdot\Lambda^2$ | $S^2(\mathbb R^4\!\otimes\!\mathbb R^m)=S^2\mathbb R^4\!\otimes\!S^2\mathbb R^m\oplus\Lambda^2\mathbb R^4\!\otimes\!\Lambda^2\mathbb R^m$ |
| $B\otimes C$ | $4\cdot V_{(2,1)}\;\oplus\;4\cdot\Lambda^3\;\oplus\;4\cdot V$ | $V\otimes\Lambda^2=V_{(2,1)}\oplus\Lambda^3\oplus V$ |
| $S^2C$ | $V_{(2,2)}\;\oplus\;S^2_0\;\oplus\;\mathbf1\;\oplus\;\Lambda^4$ | $S^2(\Lambda^2\mathbb R^m)=\mathcal R_m\oplus\Lambda^4\mathbb R^m$, $\mathcal R_m=\mathcal W_m\oplus S^2_0\oplus\mathbb R$ |

Totals in $S^2(\Lambda^2\mathbb R^n)$: $\mathbf1^{32}$, $V^{28}$, $(\Lambda^2)^{12}$, $(S^2_0)^{11}$, $V_{(2,1)}^{4}$, $(\Lambda^3)^{4}$, $(\Lambda^4)^{1}$, $V_{(2,2)}^{1}$.

Now subtract the two pieces the record's own formula subtracts.

$$S^2\mathbb R^n=S^2\mathbb R^4\oplus(\mathbb R^4\!\otimes\!\mathbb R^m)\oplus S^2\mathbb R^m=10\cdot\mathbf1\;\oplus\;4\cdot V\;\oplus\;(S^2_0\oplus\mathbf1),$$
$$\Lambda^4\mathbb R^n=\Lambda^4\mathbb R^m\;\oplus\;4\Lambda^3\mathbb R^m\;\oplus\;6\Lambda^2\mathbb R^m\;\oplus\;4\mathbb R^m\;\oplus\;\mathbf1 .$$

| type | in $S^2(\Lambda^2)$ | $-S^2\mathbb R^n$ | $-\Lambda^4\mathbb R^n$ | **$\dim M_\lambda$** | record |
| --- | --- | --- | --- | --- | --- |
| $\mathbf1$ | $32$ | $11$ | $1$ | **$20$** | $20$ ✓ |
| $V$ | $28$ | $4$ | $4$ | **$20$** | $20$ ✓ |
| $\Lambda^2$ | $12$ | $0$ | $6$ | **$6$** | $6$ ✓ |
| $S^2_0$ | $11$ | $1$ | $0$ | **$10$** | $10$ ✓ |
| $V_{(2,1)}$ | $4$ | $0$ | $0$ | **$4$** | $4$ ✓ |
| $V_{(2,2)}$ | $1$ | $0$ | $0$ | **$1$** | $1$ ✓ |
| $\Lambda^3$ | $4$ | $0$ | $4$ | **$0$** | absent ✓ |
| $\Lambda^4$ | $1$ | $0$ | $1$ | **$0$** | absent ✓ |

**Every multiplicity the record claims is right, and the $\Lambda^3$ and $\Lambda^4$ types cancel exactly.** The computation has no $m$ in it anywhere (the multiplicities are integers, not functions of $m$) so **claim 6, the $n$-independence of the $\dim M_\lambda$, is a theorem and not three data points.** Section D's remark that *"the same branching reproduces the block's own multiplicities $20,20,6,10$, so those four are consequences rather than measurements"* is correct, and is the strongest sentence in the block.

**Where it is valid, and where it is not, H7 decided.** The table above needs each of $\Lambda^2\mathbb R^m$, $S^2_0\mathbb R^m$, $V_{(2,1)}$, $V_{(2,2)}$ irreducible and the six pairwise distinct. The binding constraints:

| $m$ | $n$ | what happens | valid? |
| --- | --- | --- | --- |
| $\le3$ | $\le7$ | $V_{(2,2)}=\mathcal W_m=0$; $\Lambda^2\mathbb R^2$ degenerate | no |
| $4$ | $8$ | $SO(4)$ not simple; $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$; $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$; $V_{(2,1)}$ splits | **no** |
| $5$ | $9$ | all six irreducible and distinct; $\Lambda^3\cong\Lambda^2$ and $\Lambda^4\cong V$ under Hodge, but the cancellations still balance | **yes** |
| $6$ | $10$ | $\Lambda^3\mathbb R^6$ splits and $\Lambda^4\cong\Lambda^2$; both cancel unchanged | **yes** |
| $\ge7$ | $\ge11$ | generic | **yes** |

The $m=5$ row is the one that decides the round, so I redid the whole count there with the Hodge identifications in place: $\mathbf1$: $32-1-11=20$; $V$: $(24+4+1)-5-4=20$; $\Lambda^2$: $(6+6+4)-10=6$; $S^2_0$: $11-1=10$; $V_{(2,1)}$: $4$; $V_{(2,2)}$: $1$. **The same six multiplicities.** Dimension check: $20\cdot1+20\cdot5+6\cdot10+10\cdot14+4\cdot35+1\cdot35=495=\dim\mathcal W_9$. ✓

**Claim 13 is BROKEN; claim 14 is PROVEN.** Section C's *"the remaining formal obligation is a proof that the stable range begins at $n-4\ge8$"* rests on the wrong invariant, its own reason, *"each $\Lambda^2$ contributes at most two $\mathbb R^{n-4}$ factors ... stable once $n-4\ge8$"*, is the classical tensor-degree stability $m\ge2k$ with $k=4$. That is **sufficient and far from necessary**. Section D's annotation names the right invariant: with $\ell(\nu)\le2$, Littlewood restriction needs $\ell(\nu)\le m/2$, i.e. $m\ge4$, and $SO(m)$-irreducibility needs $m\ge5$, and my block computation, which uses no Littlewood at all, lands on the same $m\ge5$. **So the decomposition is valid at every $n\ge9$, section C's stated obligation was over-strong, and section C's *"the $n=10$ column already agrees, which is evidence that even $n-4=6$ is inside it"* is no longer evidence for anything: $m=6$ is provably inside.**

**Discrepancy protocol on this one.** *Located*: section C, closing sentence, against section D's third annotation. *Exhibited in closed form*: the $m=5$ column above, an explicit decomposition with no numerics. *Argued the opposite*: could the $F_\lambda$ **entries** require $m\ge8$ even though the types do not? They might, but that is a different obligation, and section D's own second audit note states it: *"classical stability governs the type set and $\dim M_\lambda$, and constrains no entry of $F_\lambda$."* The sentence in section C is about the decomposition, so it is over-strong as written. **Written down.**

## 6. The orbit

**The splitting.** $\mathfrak{so}(n)=\mathfrak{so}(4)\oplus(\mathbb R^4\otimes\mathbb R^m)\oplus\mathfrak{so}(m)$, this is $A\oplus B\oplus C$ from §3, and it is correct.

**The stabiliser and the trivial part.** $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ acting as $\mathfrak{so}(3)$ on each of $\Lambda^\pm$. For $u=W_{\mathbb{CP}^2}$, $W^-=0$, so all of $\mathfrak{su}(2)_-$ stabilises; and $W^+$ has eigenvalues proportional to $(2,-1,-1)$, whose stabiliser in $\mathfrak{so}(3)$ is the $\mathfrak{so}(2)$ rotating the repeated eigenplane. So $\dim\mathfrak{stab}_{\mathfrak{so}(4)}(u)=3+1=4$, and $\dim(\mathfrak{so}(4)/\mathfrak{stab}_4)=6-4=2$ ✓, matching the record's asserted $2$, **which the record asserts and does not derive** (H10). It is $\mathfrak u(2)$, dimension $4$, consistent with the $\mathbb{CP}^2$ isotropy.

**The vector part.** For $\xi\in B$, $\xi\cdot u=[\operatorname{ad}\xi,u]$, and since $u_{BB}=u_{CC}=0$, its only surviving block is $(\operatorname{ad}\xi)_{BA}\,u_{AA}$, in $AB$. This vanishes only if $\operatorname{ad}\xi$ annihilates $\operatorname{im}(u|_A)=\Lambda^+$; but $\Lambda^+$ contains nondegenerate $2$-forms on $\mathbb R^4$, and $[\,e_i\wedge f_a,\omega\,]\ne0$ for such $\omega$ and any $0\ne e_i\wedge f_a$. So $B$ injects, contributing $\dim B=4m$, and as a $G$-module the image of an injective $G$-map on $B=4\cdot V$ is $4\cdot V$. **$C=\mathfrak{so}(m)$ stabilises $u$ outright**, $u$ being supported in $A$.

$$T_u(SO(n).u)=2\cdot\mathbf1\;\oplus\;4\cdot V,\qquad\dim=2+4m=2+4(n-4)=4n-14.\quad\checkmark$$

**Claim 11: PROVEN.**

**Claim 12, the coincidence with the $\tfrac12\theta^*$-eigenspace, one half is a theorem the record records as a measurement.** By H3, $Q(g\cdot u)=g\cdot Q(u)=\theta^*(g\cdot u)$ for $g\in SO(n)$; differentiating at $g=e$ in direction $\xi$ and using $DQ_u(h)=uh+hu+2u\#h=2F_u(h)$ gives

$$F_u(h)=\tfrac{\theta^*}2\,h\qquad\text{for every }h\in T_u(SO(n).u).$$

Two lines, from equivariance and criticality alone, no dimension in it. So $T_u\mathcal O\subseteq E(\tfrac12\theta^*)$ **always**. The record instead reports it as $\lVert\Pi_E-\Pi_T\rVert_2\le1.4\times10^{-14}$ at $n=8,10,12,14$ and as a finite-field identity at $n=6,8,10$. The reverse inclusion is the part that needs content, it needs $\dim E(\tfrac12\theta^*)=4n-14$, which the tables supply as $2\cdot1+4\cdot m$ and which therefore inherits all of §7's debt. **PROVEN, hypotheses corrected**, the correction being that the record misattributes which half is hard.

*Same trap, twice more in this block.* *"$F_u$ commutes with $G$, verified at $3.9\times10^{-15}$ over the generators"* is a measurement of a one-line consequence of H3: $Q$ is $SO(n)$-equivariant, $u$ is $G$-fixed, so $F_u=\tfrac12DQ_u$ is $G$-equivariant. And $F_u(u)=u^2+u^\#=Q(u)=\theta^*u$ gives the table's $1^{\times1}$ in closed form. This is the same species as the neighbouring [Observation L103](../findings/route-a.md)'s *"$4.8\times10^{-16}$ orbit residual is exactly zero"* (**a measurement of an identity**) which that block already books against itself.

**A boundary note that bites.** The exact finite-field verifications the file cites are at $n=6,8,10$. By §5, **$n=6$ and $n=8$ lie outside the range where the decomposition is even the isotypic one**, so two of the three exact checks are outside the theorem, and only $n=10$ is in range. The [Lemma L20](../findings/route-a.md) annotation records the two audits arguing over $n\ge12$ versus $n\ge9$ for the same reason; §5 settles it at $n\ge9$, which puts $n=10$ inside and leaves $n=6,8$ outside under either reading.

## 7. The $n$-independence of the four $F_\lambda$, the debt

**What is now proved (§5): the type list and the multiplicity-space dimensions are $m$-free, for every $m\ge5$.** That is half of the record's sentence *"Every multiplicity-space dimension and every $F_\lambda$ spectrum is identical."*

**What has no argument on file: the other half.** The $F_\lambda$ are the matrices $F_u$ induces on $M_\lambda\cong\mathbb R^{20},\mathbb R^{20},\mathbb R^6,\mathbb R^{10}$. Their entries depend on the choice of orthonormal basis of $M_\lambda$, and the natural bases are built from $\delta_{\mathbb R^m}$, from Kulkarni–Nomizu products with it, and from trace-free projections, every one of which carries $m$ explicitly, in norms of the form $\lVert g_4\owedge g_m\rVert$ and in projection coefficients $\tfrac1{m}$, $\tfrac1{m-1}$, $\tfrac1{m+2}$. **Nothing in the record shows those cancel.** The evidence offered is three sampled dimensions.

**The record contradicts itself about what is owed, and the brief gives both sides.**

- Section C: *"The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$."*, refuted in §5; and even were it true, it would settle only the type set.
- Section D, fourth annotation, one audit: *"reduces the whole obligation to one $20\times20$ block ... since $m$ can enter only through $g_m$-normalisations and the trace-free projection, which reach the trivial block alone."* **This is an assertion, not an argument.** It is also false as reasoning: the $S^2_0$ row's multiplicity space lives in $S^2B\oplus S^2C$ and the $\Lambda^2$ row's in $A\otimes C\oplus S^2B$ (§5), and the trace-free projection $S^2\mathbb R^m\to S^2_0\mathbb R^m$ carries $\tfrac1m$ and acts on the $S^2_0$ row, not on the trivial row alone.
- Section D, same annotation, the other audit: *"puts it at three of the four named $F_\lambda$, and notes the $\Lambda^2$ block is structurally $m$-independent."* Also an assertion.
- Section E: *"What would discharge the debt: that the four rational $F_\lambda$ matrices have the tabulated spectra, by rank certificates over $\mathbb Q$, and that their entries do not depend on $m=n-4$."* **This is the correct statement of the obligation**, and it is stated as still open.

**Verdict: HYPOTHESIS-DEBT.** *What would have to be proved:* that for each of the four $\lambda\in\{\mathbf1,V,\Lambda^2,S^2_0\}$ there is a basis of $M_\lambda$, natural in $m$, in which the matrix of $F_u/\theta^*$ has entries in $\mathbb Q$ **independent of $m$** for all $m\ge5$; together with rational rank certificates $\dim\ker(F_\lambda-r\,\mathrm{Id})$ for each $r$ in the tabulated multiset. Neither exists on the record, and producing them is computation this loop may not do.

**Two consistency screens that the tabulated spectra pass.** Exact rational arithmetic on the table's own entries, reported as screens and not as evidence for the spectra.

- **Dimensions.** At $n=12$: $20\cdot1+20\cdot8+6\cdot28+10\cdot35=698$, and $698+940=1638=\dim\mathcal W_{12}$. ✓ The full eigenvalue census reads $1$ at multiplicity $1$; $\tfrac12$ at $2+4\cdot8=34=4n-14$ ✓; $\tfrac13$ at $3+28+3\cdot35=136$, matching the block's own *"attained on $136$ dimensions at $n=12$"* ✓; $-\tfrac16$ at $6+2\cdot28+6\cdot35=272$; $-\tfrac12$ at $32$; $-1$ at $2$; $0$ at $1161$. Sum $1638$. ✓
- **Trace.** $\operatorname{tr}(F_u)/\theta^*=1+\tfrac12(2+4m)+\tfrac13X-\tfrac16(2X)-\tfrac12(4m)-2$ where $X=3+\binom m2+3\big(\tfrac{m(m+1)}2-1\big)$ is the $\tfrac13$-multiplicity, and the table makes the $-\tfrac16$-multiplicity **exactly $2X$**, identically in $m$. So the $\tfrac13$ and $-\tfrac16$ contributions cancel, and the rest is $1+1+2m-2m-2=0$. **$\operatorname{tr}F_u=0$ identically in $m$**, which is what a traceless $u$ forces. The table has this structure built in and is internally consistent at $m=6,8,10$ and beyond.

These screens make the tabulated spectra harder to doubt. **They are not a proof of them**, and I record them as screens only.

## 8. The two tables, the discrepancy, cleared

*Located*: section C's five-row table against section D's four-row table plus its sentence *"Only four types carry a nonzero eigenvalue."*

*Exhibited in closed form*: **I could not.** Section C's fifth row says the two higher types are *"$0$ throughout"*; if that holds (and §3 plus §5 show it does) then *"only four types carry a nonzero eigenvalue"* is a **true consequence** of C's own table, not a contradiction of it. The two statements are jointly satisfiable, and §5's decomposition satisfies both.

*Argued the opposite*: the strongest reading against them is that D's table is presented as a decomposition of $\mathcal W_n$ and is not one, it accounts for $698$ of $1638$. That is a real defect, and **section D already books it against itself** in its final annotation. It is an omission, not an inconsistency.

**Reported as `withdrawn`, reason: fails step (ii) of the protocol, no closed-form exhibition of an actual inconsistency between the two tables.** What replaces it is the positive statement: **the correct table has six rows**, and §5 supplies every entry the record left as `—`:

| $G$-type | highest weight | $\dim V_\lambda$ | $\dim M_\lambda$ | $\operatorname{spec}(F_\lambda)/\theta^*$ |
| --- | --- | --- | --- | --- |
| trivial | $(0)$ | $1$ | $20$ | $-1^{2},\,-\tfrac16^{6},\,0^{6},\,\tfrac13^{3},\,\tfrac12^{2},\,1$ |
| vector | $(1)$ | $m$ | $20$ | $-\tfrac12^{4},\,0^{12},\,\tfrac12^{4}$ |
| $\Lambda^2$ | $(1,1)$ | $\tfrac{m(m-1)}2$ | $6$ | $-\tfrac16^{2},\,0^{3},\,\tfrac13$ |
| $S^2_0$ | $(2)$ | $\tfrac{m(m+1)}2-1$ | $10$ | $-\tfrac16^{6},\,0,\,\tfrac13^{3}$ |
| $V_{(2,1)}$ | $(2,1)$ | $\tfrac{m(m-2)(m+2)}3$ | $4$ | $0^{4}$ |
| $V_{(2,2)}=\mathcal W_m$ | $(2,2)$ | $\tfrac{m(m+1)(m+2)(m-3)}{12}$ | $1$ | $0$ |

The last two columns of the last two rows are **proved** (§3, §5). The last column of the first four is **the debt** (§7).

## 9. The conclusion's direction: bound, attained, or both

**The normalisation first, because it decides the reading.** $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ and $\theta^*=\sqrt{3/2}$, so $\sqrt{2/3}\,\theta^*=1$ and **the table's column $\operatorname{spec}(F_\lambda)/\theta^*$ is literally the multiset of attainable $\alpha$ values.** Section C's header $\operatorname{spec}(F_\lambda)/\sqrt{3/2}$ and section D's $\operatorname{spec}(F_\lambda)/\theta^*$ are the same column. ✓ No discrepancy there.

**What the deletion does.** $\mathbb Ru$ removes the single $1$ (in closed form: $F_uu=Q(u)=\theta^*u$). $T_u\mathcal O$ removes the $\tfrac12$'s, the two in the trivial block and four per vector copy, $2+4m=4n-14$ in all, and by §6 those are exactly the orbit. What remains has top entry $\tfrac13$, in the trivial, $\Lambda^2$ and $S^2_0$ blocks, and $0$ in the vector block and in the two higher types.

**So the record's conclusion is *both*, and the two halves have different costs:**

| reading | what it needs | status |
| --- | --- | --- |
| **Upper bound** $\alpha\le\tfrac13$, what [Lemma L20](../findings/route-a.md) consumes | **exhaustion**: every type, and every eigenvalue of every $F_\lambda$, bounded by $\tfrac13\theta^*$ after the deletion | needs all of §7. Exhaustion over types is now proved (§5) and the $940$ are now proved to be $0$ (§3); the four $F_\lambda$ are not |
| **Attainment** $\alpha=\tfrac13$, what [Lemma L134](../results.md)(a) is recorded as consuming | **one witness**: a single unit $V\in u^\perp\cap T_u\mathcal O^\perp$ with $F_uV=\tfrac13\theta^*V$ | needs far less, and **no such $V$ is exhibited anywhere on the record**, in closed form or otherwise |

**This asymmetry is not recorded anywhere and it should be.** Attainment is the cheaper obligation by a wide margin (a single eigenvector in the $6\times6$ $\Lambda^2$ block, written out, discharges it) and section D's fourth annotation half-sees this (*"sharpness follows from one fixed rational $6\times6$"*) without drawing the conclusion that L134's dependency is therefore separable from L20's and much closer to closable.

**And the hedge that section D names cuts the same way.** *"The 'a<½ suffices' hedge rescues [Lemma L20](../findings/route-a.md) but not [Lemma L134](../results.md)(a), which consumes the numerical $\tfrac13$"*, correct, and consistent with [Lemma L20](../findings/route-a.md)'s own annotation that *"the qualitative theorem survives for any $a<\tfrac12$"* while $0.5748$ needs the exact $\tfrac13$.

## 10. The traps, answered by name, including where I found nothing

| trap | finding |
| --- | --- |
| $\ker W\ne0$ and padded objects | **No defect.** $u$ has a large kernel ($\Lambda^-\oplus B\oplus C$ inside $\Lambda^2\mathbb R^n$) and no step inverts $u$; the argument uses only $u$'s **support** in $A$. The padding is what makes $G=SO(m)$ act at all. *But note the escalation [Lemma L17](../findings/route-a.md) carries: the record contradicts itself on which object $u$ is, and **L21 commits to the padded $W_{\mathbb{CP}^2}$ reading**, the only one supported in $\Lambda^2\mathbb R^4$.* |
| $n=9$ | **In range, and this is the round's main correction.** §5 derives the $m=5$ branching explicitly, with the Hodge identifications $\Lambda^3\cong\Lambda^2$ and $\Lambda^4\cong V$ in place, and gets the same six multiplicities. |
| $n=10$ | **In range**, provably, not merely *"evidence"* as section C says. |
| $m=4$ ($n=8$) | **Out of range, structurally.** $SO(4)$ not simple; $\Lambda^2\mathbb R^4$, $\mathcal W_4$ and $V_{(2,1)}$ all split. The dimension identity of §4 still closes at $m=4$ ($226+64+10=300=\dim\mathcal W_8$), **so the identity alone would not have caught it**, which is why §5 checks irreducibility separately. |
| $m=5$ | **In range**; both $V_{(2,1)}$ and $V_{(2,2)}$ have dimension $35$ there and are non-isomorphic, checked against the $B_2$ Weyl dimension formula. |
| $m=6$ ($n=10$) | **In range**; $\Lambda^3\mathbb R^6$ splits and $\Lambda^4\mathbb R^6\cong\Lambda^2\mathbb R^6$, and both cancel against $\Lambda^4\mathbb R^n$ unchanged. |
| the crossover $n=6+2\sqrt7\approx11.29$ | **Not L21's boundary at all**, it is [Lemma L20](../findings/route-a.md)'s, where $\theta_0(n)>\theta^*$ first. L21's own range $n\ge9$ **covers** L20's $n\ge12$ and [Lemma L100](../findings/route-a.md)'s $9\le n\le11$, and misses only $n=8$, exactly what L100 records (*"Only floating point covers $n=8$"*). Consistent; no defect. |
| proved on a subfamily, used in general | **The central defect, and now half-repaired.** The type list and multiplicities are no longer three data points (§5). The four $F_\lambda$ spectra still are (§7). |
| a hypothesis stated but never used | **None found.** Every hypothesis in section C is consumed. |
| a step using a hypothesis never stated | **Five: H3, H4, H5, H6, H9** in the inventory, plus the unstated $m\ge5$ (H7). H5 is the one that could have sunk the Schur step. |
| a universal claim with no witness | **Two.** (i) *"$\tfrac13$ is sharp, attained on $136$ dimensions"*, the count $3+28+105=136$ checks against the tables, but **no eigenvector is written down** (§9). (ii) *"the $\tfrac12\theta^*$-eigenspace **is** the orbit"*, one inclusion proved (§6), the reverse rests on the tables. |
| an imported theorem whose hypotheses were never checked | **Schur's lemma**, imported without its absolute-irreducibility hypothesis (§2), it holds, unstated. **Littlewood restriction**, invoked in section D's annotation with the hypothesis $\ell(\nu)\le m/2$ correctly discharged as $m\ge4$, clean. **The unital-algebra trap does not recur**: no algebra theorem is imported here. |
| symbol collisions | **$m$ is the live danger**, see §11. |

## 11. The $m$ collision, escalated

**Inside one paragraph of [route-a.md](../findings/route-a.md)** (Lemma L20's proof, quoted in section E of the brief), the letter $m$ carries both senses:

- *"$m:=\sqrt{2/3}\max P$ is attained, at some $W^*$"*, then *"$\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them"*, and the whole chain $m\le\psi(\varphi)$;
- and, in the **same paragraph**, *"that their entries do not depend on $m=n-4$."*

A reader who resolves the second occurrence against the first is told that four matrices' entries do not depend on the maximum of $P$, a statement about a different object, in a paragraph whose every other $m$ is that maximum. This is precisely the failure mode [conventions.md](../findings/conventions.md) exists to prevent, and neither sense of $m$ has a row there. **Recommend: write $\mathrm M$ or $\mu$ for $\sqrt{2/3}\max P$ throughout [Lemma L20](../findings/route-a.md), reserve $m=n-4$, and table both.** Also untabled and live in the same file: $\theta^*$, $F_u$, $F_\lambda$, $M_\lambda$, and this block's sense of $\alpha$.

## 12. What would falsify it, and what I did to look

**The object that would break L21 as stated.** A unit $V\in\mathcal W_n$ with $\langle V,u\rangle=0$, $V\perp T_u(SO(n).u)$, and $\langle F_uV,V\rangle>\tfrac13\theta^*$, for some $n\ge9$. Equivalently, an eigenvalue of some $F_\lambda$ strictly between $\tfrac13\theta^*$ and $\tfrac12\theta^*$, or a $\tfrac12\theta^*$-eigenvector outside the orbit tangent space, or a **seventh $SO(m)$-type** in $\mathcal W_n$ carrying a nonzero eigenvalue.

**What I did to look for it, all analytically.**

- **The seventh type.** Ruled out. §5 decomposes $S^2(\Lambda^2\mathbb R^n)$ block by block and subtracts $S^2\mathbb R^n$ and $\Lambda^4\mathbb R^n$ exactly; the only types that appear are the six, the $\Lambda^3$ and $\Lambda^4$ types cancel identically, and the multiplicities sum to $\dim\mathcal W_n$ as a polynomial identity in $m$ (§4). **There is no room for a seventh type at any $m\ge5$.**
- **A nonzero eigenvalue on the $940$.** Ruled out. §3 shows $F_u$ annihilates $BC\oplus CC$, and §5 shows the $(2,1)$ and $(2,2)$ isotypics are confined there. So the falsifier cannot live in the unnamed rows.
- **A $\tfrac12\theta^*$-eigenvector outside the orbit.** Not ruled out, and this is where a falsifier could still hide: §6 proves only $T_u\mathcal O\subseteq E(\tfrac12\theta^*)$. If some $F_\lambda$ carried an extra $\tfrac12$ that the sampled dimensions missed, the deletion would leave $\tfrac12$ behind and **L20 would become vacuous**, since its interval is empty at $\alpha=\tfrac12$. The tabulated $\tfrac12$-multiplicity is exactly $4n-14$ at all three sampled $n$ and identically in $m$ as a formula, which is a real constraint but is not a proof.
- **An eigenvalue in $(\tfrac13\theta^*,\tfrac12\theta^*)$.** Not ruled out. This is the debt of §7 in its sharpest form, and it lives entirely inside the four matrices.
- **A trace obstruction.** I looked for one and it does not obstruct: §7's screen shows $\operatorname{tr}F_u=0$ holds identically in $m$ on the tabulated spectra, so trace gives no leverage against a falsifier.

**I ran nothing.** No script, no Sage, no numeric evaluation; the four $F_\lambda$ were not rebuilt or re-diagonalised, and the record's three sampled dimensions were not re-sampled.

## Verdict

**HYPOTHESIS-DEBT.**

The lemma splits cleanly into a half that is now proved and a half that is not.

**Proved here, for every $n\ge9$, identically in $m$:** the six $SO(m)$-types; the multiplicities $20,20,6,10,4,1$ and their $n$-independence; the two unnamed dimension formulas and the identity $\sum\dim M_\lambda\dim V_\lambda=\dim\mathcal W_n$; the image inclusion $\operatorname{im}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$; the annihilation of the $940$; the orbit decomposition $2\cdot\mathbf1\oplus4\cdot V$ of dimension $4n-14$; and $T_u\mathcal O\subseteq E(\tfrac12\theta^*)$.

**Owed:** that the four matrices $F_{\mathbf1},F_V,F_{\Lambda^2},F_{S^2_0}$ on $\mathbb R^{20},\mathbb R^{20},\mathbb R^6,\mathbb R^{10}$ have entries independent of $m$ for all $m\ge5$, and have the tabulated spectra, by rational rank certificates $\dim\ker(F_\lambda-r\,\mathrm{Id})$, no eigenvectors and no floating point. Until that exists, $\alpha\le\tfrac13$ rests on three sampled dimensions, and $\alpha=\tfrac13$ attained rests on no exhibited witness at all.

**Corrections the record must take.**

1. **Section A** must carry a statement, with the range $n\ge9$, *"every dimension"* is false at $n\le8$.
2. **Section C's closing obligation** (*"the stable range begins at $n-4\ge8$"*) is **withdrawn**; the correct range is $m\ge5$, i.e. $n\ge9$, and it is now proved rather than owed.
3. **Section D's degree argument** (*"vanishes on degree $\le1$"*) is **broken** and must be replaced by *"annihilates exactly $BC\oplus CC$"*, with the confinement of the two higher isotypics to those blocks stated as the step it is.
4. **The Schur step** must state absolute irreducibility of the $V_\lambda$, and note that it holds at $m\ge5$ and fails at $m=4$.
5. **The four-row table** must become the six-row table of §8.
6. **$m$ must be disambiguated** in [route-a.md](../findings/route-a.md), where both senses share a paragraph.
7. **The equivariance and the orbit-eigenvalue inclusion** must be stated as theorems, not reported as $3.9\times10^{-15}$ and $1.4\times10^{-14}$.
8. **[Lemma L134](../results.md)'s dependency** (attainment), must be recorded as separable from [Lemma L20](../findings/route-a.md)'s, and much cheaper: one closed-form eigenvector in the $6\times6$ $\Lambda^2$ block discharges it.
