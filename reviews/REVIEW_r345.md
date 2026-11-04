# Review r345, Gate 2 on I14, the sign-flip decomposition and the block-diagonality of $L_e$

**E1, CONFIRMED as an enumeration, REFUTED as a statement about characters.** The three overlap types and their counts are right, and the case list is exhaustive. The gloss attached to it, "*Nothing else occurs*: a character $\varepsilon_j\varepsilon_k$ arises only from a one-index overlap … disjoint would give four distinct indices", is false at $n=4,6,8$, because $\Gamma$ is the *determinant-one* sign group and $\chi_S=\chi_{S^c}$ on it.

**E2, CONFIRMED, all three claims, with the signs.** Bianchi is empty on the trivial and pair blocks, Ricci is empty on the $4$-set block, the Bianchi relation is $\alpha-\beta+\gamma=0$ in the stated labelling, and each cut is by a single non-vanishing functional. A cleaner proof than the note's is available and is given below: the two constraint maps are themselves $\Gamma$-equivariant, into $\Lambda^4$ and into $\mathrm{Sym}^2(\mathbb R^n)$, and the characters say which block each can touch.

**E3, CONFIRMED as an identity, and it is worth much less than the note claims.** It is a polynomial identity in $n$, proved below in three lines; "verified at $n=4,\dots,12$" is nine evaluations of one degree-$4$ identity, of which five would already force it. It is one scalar equation on three cut-counts, so it cannot localise an error, and (the point that matters here), **it is completely blind to the defect in E1/E4**, since the character fusion changes no dimension. It holds at $n=4$, where the isotypic claim is false.

**E4, REFUTED as stated; the CONCLUSION is CONFIRMED at every $n$ by a different argument.** The listed summands are the isotypic components if and only if $n\notin\{4,6,8\}$: at $n=6$ the $4$-set block $\{1,2,3,4\}$ and the pair block $\{5,6\}$ carry the *same* $\Gamma$-character, at $n=8$ complementary $4$-sets do, and at $n=4$ the $4$-set block carries the trivial character. So equivariance does not deliver the stated block sizes there, and the note's screen was taken at $n=6$, the one dimension among those tested where its own proof fails. The conclusion survives: $L_e$ preserves every listed block at every $n$, by a support argument that uses no representation theory. The one-word repair to the proof is to run the argument on the **full** diagonal sign group $\widetilde\Gamma\cong(\mathbb Z/2)^n\subset O(n)$, which is legitimate because $\circ$ is $O(n)$-equivariant and which makes all the characters distinct at every $n$.

**E5, CONFIRMED with three corrections.** On $W^\perp$ the trivial block has dimension $\tfrac{n(n-3)}2-1$, not $\tfrac{n(n-3)}2$; the size claim needs $n\ge5$ (at $n=4$ the largest non-diagonal block is $2>n-3$); and the orbit directions sit **one inside each pair block**, never across blocks and never inside $\mathcal D_n$ or a $4$-set block, with the explicit form $x_i\propto M_{ij}-M_{ik}$, which satisfies the pair block's Ricci constraint identically. $W^\perp$ is $\Gamma$-stable. The criterion remains necessary only, and a block sitting *exactly* at $\tfrac12$ decides nothing, $S^3\times S^3$ is the standing witness.

**Method.** Analysis only, per the brief. Every positive claim below was derived by hand from the definitions before any code ran. Three screens are reported as screens, each on objects built from scratch in this review with nothing imported from the record: the calibration of $\#$, the $4$-set closed form against a direct evaluation, and the block assembly at four sphere products. They are transcription insurance, and no claim rests on them.

---

## The one fact everything turns on: $\chi_S=\chi_{S^c}$ on $\Gamma$

$\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon):\prod\varepsilon_i=1\}$ is the kernel of the character $\chi_{[n]}:\varepsilon\mapsto\prod_i\varepsilon_i$ of $(\mathbb Z/2)^n$, so it has index $2$ and is elementary abelian of order $2^{n-1}$, $\Gamma\cong(\mathbb Z/2)^{n-1}$, as E1 says. Every character of $(\mathbb Z/2)^n$ is $\chi_S(\varepsilon)=\prod_{i\in S}\varepsilon_i$ for a subset $S$, and restriction to $\Gamma$ is surjective on characters with kernel the annihilator of $\Gamma$, which is exactly $\{1,\chi_{[n]}\}$. Hence

$$\chi_S\big|_\Gamma=\chi_{S'}\big|_\Gamma\iff S'=S\ \text{ or }\ S'=[n]\setminus S .$$

The blocks of E1 are labelled by $S=\varnothing$ (trivial), $|S|=2$ (pair blocks) and $|S|=4$ ($4$-set blocks). Two labels collide exactly when one is the complement of the other, which needs $n-|S|\in\{0,2,4\}$ with $|S|\in\{0,2,4\}$:

| $n$ | the collision | consequence |
| --- | --- | --- |
| $4$ | $\varnothing\leftrightarrow\{1,2,3,4\}$, and each pair $\leftrightarrow$ its complementary pair | the $4$-set block fuses with the trivial block; pair blocks fuse in $3$ complementary couples |
| $6$ | $4$-set $\leftrightarrow$ complementary pair | each $2$-dimensional $4$-set block fuses with an $(n-3)=3$-dimensional pair block, giving $15$ isotypic components of dimension $5$, plus $\mathcal D_6$ of dimension $9$; $9+15\cdot5=84=\dim\mathcal W_6$ |
| $8$ | $4$-set $\leftrightarrow$ complementary $4$-set | the $70$ blocks fuse into $35$ isotypic components of dimension $4$; $20+35\cdot4+28\cdot5=300=\dim\mathcal W_8$ |
| $n=5,7$ and every $n\ge9$ | none | the listed summands **are** the isotypic components |

For $n$ odd there is never a collision, because $|S^c|$ is then odd and no listed label has odd size. So the exceptional set is exactly $\{4,6,8\}$.

**The determinant-one condition is the whole cause**, which answers E1's question directly. On the full sign group $\widetilde\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon)\}\cong(\mathbb Z/2)^n\subset O(n)$ the characters $\chi_S$ are pairwise distinct, and the listed summands are the isotypic components at every $n\ge4$ with no exceptions. Nothing is lost by that substitution: $W^\#$ is built from the structure constants of $\mathfrak{so}(n)$ in an orthonormal basis, conjugation by any $g\in O(n)$ is a metric-preserving Lie algebra automorphism, so $\circ$ is $O(n)$-equivariant, which is what [DERIVE-df1.md](DERIVE-df1.md) itself asserts in Step 2 and then declines to use. **Replacing $\Gamma$ by $\widetilde\Gamma$ repairs the proposition's proof at $n=4,6,8$ at no cost.**

The one thing that does not change is the effective group on $\Lambda^2$: $-I$ acts trivially there, so for even $n$ the action factors through a group of order $2^{n-2}$ (or $2^{n-1}$ for $\widetilde\Gamma$). This is harmless (every character in play has $|S|$ even, hence is trivial on $-I$ and descends) and it introduces no further identification beyond $S\leftrightarrow S^c$.

## E1 in detail

Two $2$-subsets of $[n]$ meet in $0$, $1$ or $2$ elements, so the case list is exhaustive. Counts: $\binom n2$ elements $e_{ij}\odot e_{ij}$; for a fixed unshared pair $\{j,k\}$ the shared index ranges over the other $n-2$ indices, giving $n-2$ per pair block; a $4$-set splits into two disjoint pairs in $3$ ways. The screen $\binom n2+(n-2)\binom n2+3\binom n4=\tfrac{N(N+1)}2$ with $N=\binom n2$ is an identity, not a coincidence, and it is a partition of the basis by overlap type, it says nothing about characters.

**Emptiness at small $n$.** The $4$-set blocks exist only for $n\ge4$; at $n=4$ there is one, at $n=5$ five. The pair blocks have dimension $n-3$ after the Weyl cut, so they are **zero-dimensional at $n=3$ and one-dimensional at $n=4$**, the $n=3$ case is the statement $\mathcal W_3=0$, consistent with $\tfrac{n(n-3)}2=0$ and $\binom n4=0$ there. Nothing in the case list breaks at small $n$; what breaks is the identification of blocks with characters, as tabulated above.

## E2 in detail, the three cuts, each proved separately

The cleanest proof of both emptiness claims is not the note's ("a trace pairs indices, and there are none to pair"; "needing four distinct indices") but the observation that the constraint maps are themselves $\Gamma$-equivariant and land in spaces whose characters are known.

- **First Bianchi.** For a tensor with the pair symmetries, first Bianchi is equivalent to the vanishing of the total antisymmetrisation, so the constraint map is $b:\mathrm{Sym}^2(\Lambda^2)\to\Lambda^4$, $W\mapsto W_{[abcd]}$, the classical splitting $\mathrm{Sym}^2(\Lambda^2 V)=\mathcal R(V)\oplus\Lambda^4V$. The basis of $\Lambda^4$ is $e_{abcd}$ with character $\chi_{\{a,b,c,d\}}$, a four-index character. So Bianchi can constrain only the $4$-set blocks, and it is **empty on the trivial and pair blocks**, E2's claim, with the direction of the argument reversed and one line shorter. It also confirms the count $3\to2$: $b$ restricted to one $4$-set block is a single surjection onto a line.
- **The sign.** With $\alpha=W_{abcd}$, $\beta=W_{acbd}$, $\gamma=W_{adbc}$, first Bianchi $W_{abcd}+W_{acdb}+W_{adbc}=0$ and $W_{acdb}=-W_{acbd}$ give $\alpha-\beta+\gamma=0$. **The signs are right.** The four relations $R_{a[bcd]},R_{b[acd]},R_{c[abd]},R_{d[abc]}$ on one $4$-set are all equivalent to $R_{[abcd]}=0$, so there is exactly one relation per $4$-set and not four.
- **Ricci.** $\mathrm{Ric}_{ik}=\sum_jW_{ijkj}$ is a $\Gamma$-equivariant map into $\mathrm{Sym}^2(\mathbb R^n)$, whose basis $e_i\odot e_k$ carries $\chi_{\{i,k\}}$ for $i\ne k$ and the trivial character for $i=k$. So Ricci constrains only the trivial block (through its $n$ diagonal components) and the pair blocks (one component each), and is **empty on the $4$-set blocks**, E2's claim. For $n\ge5$ the component $\mathrm{Ric}_{jk}$ is the *only* one carrying $\chi_{\{j,k\}}$, so each pair block takes exactly one relation, $\sum_ix_i=0$ with $x_i=W_{ijik}$, a non-zero functional: $n-2\to n-3$.
- **The trivial block.** There the surviving components are $M_{ij}=W_{ijij}$, a hollow symmetric array, and the row-sum map onto $\mathbb R^n$ is surjective for every $n\ge3$, so $\binom n2-n=\tfrac{n(n-3)}2$, which is $\mathcal D_n$ of [conventions.md](../findings/conventions.md). Bianchi is empty here by the character argument above.

Note that the character argument for the *emptiness* claims survives the $n=4,6,8$ fusion untouched, because it compares the source block against the target of a constraint map component that is computed directly, not against another block.

## E3 in detail, the identity, and what it is worth

$$2\binom n4+(n-3)\binom n2+\frac{n(n-3)}2=n(n-3)\left[\frac{(n-1)(n-2)}{12}+\frac{n-1}2+\frac12\right]=\frac{n(n-3)}{12}\big[(n-1)(n-2)+6(n-1)+6\big]=\frac{n(n-3)(n^2+3n+2)}{12}=\frac{n(n+1)(n+2)(n-3)}{12}.$$

So it is an identity in $n$, not a numerical coincidence, and it needs no verification at all. Three things follow about its evidential value, all of which cut against the note's "this is the note's real check".

- **Nine evaluations of a degree-$4$ polynomial identity are one check, not nine.** Five points already determine it.
- **It is one linear equation on three unknown cut-counts.** It certifies the total and cannot localise a wrong cut; only if the errors are *constant per block* does it force each to vanish, and there is no reason an error would be constant in $n$.
- **It is blind to the actual defect.** Fusing two blocks changes no dimension, so the identity holds verbatim at $n=4,6,8$ where the isotypic claim is false. It holds at $n=4$: $2+2+6=10=\dim\mathcal W_4$. **The identity checks E2 and says nothing whatever about E1 or E4**, which is where the error is.

The stronger statement the note wants is available and is a different check: the three families of subspaces are pairwise orthogonal and their sum is direct, so the identity is equivalent to their spanning $\mathcal W_n$. I verified that constructively as a screen at four sphere products (below), dimension assembled $=\dim\mathcal W_n$ exactly, with the blocks built independently.

## E4 in detail

**$e$ is $\Gamma$-fixed: yes, with two provisos.** If $M$ is diagonal in the coordinate $2$-planes then $(\gamma\cdot M)_{ijij}=\varepsilon_i^2\varepsilon_j^2M_{ijij}=M_{ijij}$ and all other components vanish, so $M$ is $\Gamma$-fixed and so is $e=M/\theta$ whenever $\theta\ne0$. The provisos: $\Gamma$ must be the sign group **of the frame in which $M$ is diagonal**, [conventions.md](../findings/conventions.md) flags exactly this confusion, and the converse "$\Gamma$-fixed $\Rightarrow$ in $\mathcal D_n$" needs $n\ge5$, since at $n=4$ the fixed set also contains the $4$-set block and has dimension $4$, not $2$.

**Equivariance gives block-diagonality, not triangularity.** The isotypic projector $\pi_\chi=\tfrac1{|\Gamma|}\sum_g\chi(g)g$ is a polynomial in the group action, so it commutes with any equivariant $L_e$, giving $\pi_\chi L_e\pi_{\chi'}=0$ for $\chi\ne\chi'$, genuinely block-diagonal. Over $\mathbb R$ there is no Schur complication: $\Gamma$ is elementary abelian of exponent $2$, every irreducible is a real character line, and the projectors are real. The blocks are also mutually orthogonal for the $O(n)$-invariant inner product, so $L_e$ being self-adjoint adds nothing here but costs nothing either.

**Where it fails.** The step "here every component above is a distinct character" is the false one, at $n\in\{4,6,8\}$. At $n=6$ equivariance permits $L_e$ to carry the $4$-set block $\{1,2,3,4\}$ into the pair block $\{5,6\}$, and the proposition's block sizes ($2$ and $n-3=3$) are then unproved; the true isotypic block is $5$-dimensional. This matters beyond bookkeeping because **the note's own screen is at $S^3\times S^3$, i.e. $n=6$**. The note calls that screen "transcription insurance … the proof is the equivariance". At $n=6$ the equivariance proof is not there, so the $9\times10^{-16}$ leak was the only support the claim had at that dimension.

**The conclusion is nevertheless true at every $n$, and here is why.** Let $M$ be diagonal, $m_\gamma=M_{ab}$ for $\gamma=\{a,b\}$, and write $L_MX=\tfrac12(MX+XM)+N$ with

$$N_{\alpha\beta}=\tfrac12\sum_{\gamma,\varepsilon,\zeta}c_{\alpha\gamma\varepsilon}\,c_{\beta\gamma\zeta}\,m_\gamma X_{\varepsilon\zeta},$$

which is the polarisation of $R^\#_{\alpha\beta}=\tfrac12c_{\alpha\gamma\varepsilon}c_{\beta\delta\zeta}R_{\gamma\delta}R_{\varepsilon\zeta}$ with $M$ diagonal. The composition part manifestly preserves the support of $X$ in the pair basis. For $N$: $c_{\alpha\gamma\varepsilon}\ne0$ forces $\{\alpha,\gamma,\varepsilon\}$ to be the three $2$-subsets of a $3$-set $T_1$, and likewise $\{\beta,\gamma,\zeta\}\subset T_2$. Take $X$ supported on one $4$-set block, so $\varepsilon,\zeta$ are complementary $2$-subsets of $S$ with $|S|=4$. Then $\gamma\subset T_1=\varepsilon\cup\{t_1\}$ and $\gamma\subset T_2=\zeta\cup\{t_2\}$ with $\gamma\ne\varepsilon,\zeta$, which forces $\gamma$ to have one index in $\varepsilon$ and one in $\zeta$, hence $\gamma\subset S$, hence $T_1,T_2\subset S$ and $\alpha,\beta\subset S$. **So $L_M$ carries a $4$-set block into itself at every $n$, with no character input.** The same argument run on a pair-block input $X_{(ij)(ik)}$ shows $\alpha,\beta$ must meet $\{j,k\}$ in the same way, so pair blocks are preserved too. This is the argument the note should carry, and it is insensitive to the fusion.

Consequently **the proposition's conclusion stands as written at every $n\ge4$**, and the record should keep it; what must be replaced is the sentence claiming the summands are the isotypic components, and the derivation of block-diagonality from that claim.

## E5 in detail

- **The Hessian formula.** $6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$ is [Lemma L24](../findings/second-order.md), whose hypotheses are that $W$ is a unit critical point and $\theta=P(W)\ne0$ for $e=W/\theta$ to exist; $\theta>0$ is needed to turn "Hessian $\preceq0$" into "$L_e\le\tfrac12$" rather than its reverse, and the note's domain line says so correctly.
- **$W^\perp$ is $\Gamma$-stable**, since $W$ is $\Gamma$-fixed and $\Gamma$ acts orthogonally. But the trivial block of $W^\perp$ is $\mathcal D_n\ominus\mathbb RM$, of dimension $\tfrac{n(n-3)}2-1$. The note's "block-diagonal the same way" over-counts by one.
- **The size claim needs $n\ge5$.** For $n\ge5$, $n-3\ge2$ and the largest block available to a non-diagonal direction is indeed $n-3$; at $n=4$ the pair blocks are $1$-dimensional and the $4$-set block is $2$-dimensional, so the largest is $2>n-3$.
- **Where the orbit sits, inside the pair blocks, one per block.** For $X=\varphi_{jk}\in\mathfrak{so}(n)$ and $\gamma\in\Gamma$, $\gamma\cdot(X\!\cdot\!M)=(\gamma X\gamma^{-1})\!\cdot\!(\gamma\cdot M)=\chi_{\{j,k\}}(\gamma)\,X\!\cdot\!M$, so the orbit direction generated by $\varphi_{jk}$ lies in the $\chi_{\{j,k\}}$ eigenspace, which for $n\ge5$ is the pair block $\{j,k\}$. Explicitly, with $D=\mathrm{ad}(\varphi_{jk})$ on $\Lambda^2$ one gets $[D,M]e_{ik}=(M_{ik}-M_{ij})e_{ij}$, so the direction has pair-block coordinates $x_i\propto M_{ij}-M_{ik}$, and $\sum_ix_i=(\text{row sum }j)-(\text{row sum }k)=0$ **automatically**, the Ricci constraint of that block is satisfied for free, which is the consistency check the owed step 4 will need. The direction vanishes iff $M_{ij}=M_{ik}$ for all $i$, i.e. exactly on the isotropy. **No orbit direction ever lies in $\mathcal D_n$ or in a $4$-set block, and none straddles two blocks.**
- **A caveat the note does not state.** Block-diagonality makes the criterion checkable block by block, but the criterion is necessary only, and equality in a block is not a failure *or* a pass. $S^3\times S^3$ satisfies $L_e\le\tfrac12$ exactly and is not a local maximum, being killed at third order ([second-order.md](../findings/second-order.md)). The route's planned "branching corollary naming the locus where a $\Gamma$-nontrivial block hits exactly $\tfrac12$" is therefore naming the *inconclusive* locus, and it will need the third-order test on those blocks, not the second.

---

## The owed step: the $2\times2$ $4$-set block in closed form

Fix a $4$-set $\{a,b,c,d\}$ and put

$$A=M_{ab}+M_{cd},\qquad B=M_{ac}+M_{bd},\qquad C=M_{ad}+M_{bc},$$

the three **opposite-pair sums**. Use the *signed* coordinates $(\alpha,\beta',\gamma)$ with $\alpha=W_{abcd}$, $\beta'=-W_{acbd}$, $\gamma=W_{adbc}$, in which first Bianchi reads $\alpha+\beta'+\gamma=0$. Evaluating $N$ above term by term, each $\gamma$ in the sum is one of the four "cross" pairs joining $\{a,b\}$-type to $\{c,d\}$-type, and each contributes a single $(\varepsilon,\zeta)$, and adding the composition part $\tfrac12(MX+XM)$, which is diagonal with entries $\tfrac12A,\tfrac12B,\tfrac12C$, gives

$$\boxed{\ L_M\big|_{4\text{-set}}=\tfrac12G,\qquad G=\begin{pmatrix}A&C&B\\ C&B&A\\ B&A&C\end{pmatrix}\ }$$

on the full $3$-dimensional space, in the ordered signed basis. Three consequences, in order.

**The Weyl cut is automatic.** $G\mathbf 1=(A+B+C)\mathbf 1$, and $G$ is symmetric, so $G$ preserves $\mathbf 1^\perp$, which is exactly the Bianchi subspace. The $\Lambda^4$ line is the $\mathbf 1$ direction with eigenvalue $\tfrac12(A+B+C)=\tfrac12\sum_{\{i,j\}\subset S}M_{ij}$. *This is a strong check on the signs: a single sign error anywhere in the computation destroys $G\mathbf 1\parallel\mathbf 1$.*

**The block is traceless, hence its spectrum is a $\pm$ pair.** $\mathop{\mathrm{tr}}(\tfrac12G)=\tfrac12(A+B+C)$ is entirely the $\Lambda^4$ eigenvalue, so on the Weyl $2$-plane

$$\mathop{\mathrm{spec}}\big(L_M\big|_{V_{abcd}}\big)=\Big\{+\tfrac\lambda2,\,-\tfrac\lambda2\Big\},\qquad \lambda^2=A^2+B^2+C^2-AB-BC-CA=\tfrac12\big[(A-B)^2+(B-C)^2+(C-A)^2\big],$$

from $\mathop{\mathrm{tr}}(G^2)=3(A^2+B^2+C^2)$. **Every $4$-set contributes exactly as much to the negative spectrum as to the positive**, at every diagonal critical point, a structural fact the record does not currently carry. For $L_e$ divide by $\theta$: the $4$-set contribution to [Lemma L24](../findings/second-order.md) is

$$\frac{\lambda}{2\theta}\le\frac12\iff \tfrac12\big[(A-B)^2+(B-C)^2+(C-A)^2\big]\le\theta^2\quad\text{for every }4\text{-subset}.$$

So the $4$-set half of the second-order condition is a **single explicit inequality in the vertex matrix**, one per $\binom n4$, and it is vacuous exactly when the three opposite-pair sums of that $4$-set are equal.

**What it gives at $S^p\times S^q$.** Let the vertex matrix be $u$ inside the $p$-block, $v$ inside the $q$-block, $x$ across. A $4$-set split $4$–$0$ has $A=B=C=2u$, and split $3$–$1$ has $A=B=C=u+x$; both give $\lambda=0$. Only the $2$–$2$ splits survive, with $A=u+v$, $B=C=2x$, hence $\lambda=|u+v-2x|$ and

$$\mathop{\mathrm{spec}}\big(L_e\big|_{V}\big)=\pm\frac{u+v-2x}{2\theta}=\pm\frac{1}{2\theta}\sqrt{\frac{2(n-1)(n-2)}{pq(p-1)(q-1)}}\;=\;\pm\,\mu,\qquad \mu=\frac{n-2}{2(p-1)(q-1)},$$

the last step using $\theta^2(S^p\times S^q)=\frac{2(p-1)(q-1)(n-1)}{pq(n-2)}$ from [target.md](../findings/target.md). At the balanced product this is $\pm\frac2{n-2}$ exactly, and the number of contributing $4$-sets is $\binom p2\binom q2$.

**RECORD DISCIPLINE, this value is already on file, and the derivation agrees with it.** $\mu=\frac{n-2}{2(p-1)(q-1)}$ is [Lemma L26](../findings/nondegeneracy.md), whose eigenvector is described as "supported on the three pairings of four indices, with coefficients $\tfrac23,\tfrac13,-\tfrac13$ and $\|X\|^2=\tfrac43$", which is precisely the projection of the signed basis vector $(1,0,0)$ onto $\mathbf 1^\perp$, namely $(\tfrac23,-\tfrac13,-\tfrac13)$ in signed coordinates, i.e. $\alpha=\tfrac23$, $\beta=\tfrac13$, $\gamma=-\tfrac13$, of squared norm $\tfrac43$. L26's free-symbol form $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ for a three-block diagonal operator is the special case $A=\varepsilon_{PP}+\varepsilon_{QQ}$, $B=C=2\varepsilon_{PQ}$ of the formula above. So **I14's owed step 3 partly duplicates L26**, and the honest statement of what is new is: (i) L26's summand is *identified* as the $\Gamma$-isotypic $4$-set block, (ii) the formula is extended from three-block operators to an arbitrary diagonal critical point and from one eigenvector to the whole block, and (iii) the second eigenvalue $-\mu$, which L26 does not record, is forced by tracelessness.

**Two things the closed form settles immediately.**

- **The $n=6$ anomaly is explained.** At $S^3\times S^3$, $\mu=\frac2{n-2}=\tfrac12$ exactly, and the number of $2$–$2$ four-sets is $\binom32^2=9$. The record's standing datum, $\dim E(\tfrac12)=18$ against an orbit of $9$, with "nine of the eighteen $\tfrac12$-directions an eigenvalue coincidence with no group origin" ([second-order.md](../findings/second-order.md)), is now attributed exactly: the nine are one per $2$–$2$ four-set block, and the coincidence is the arithmetic accident $\frac2{n-2}=\frac12$ at $n=6$. This agrees with [nondegeneracy.md](../findings/nondegeneracy.md)'s independent reading that $(3,3)$ is an eigenvalue coincidence rather than representation mixing, and supplies the count.
- **The padding-invariant top eigenvalue of $S^2\times S^k$ is a $4$-set eigenvalue.** $\mu=\frac{n-2}{2(n-3)}>\tfrac12$ at $p=2$ gives $\tfrac23$ for $S^2\times S^4$ and $\tfrac35$ for $S^2\times S^6$, which are exactly the values [second-order.md](../findings/second-order.md) records as $\lambda_{\max}(L_W|_{W^\perp})/\theta$ at every padding of those points. The invariance under padding is then structural rather than observed: the formula depends only on $p,q$ and $\theta$, and padding changes neither.

## A by-product: the attribution the note flags as a live verification candidate

The note's caution says the record attributes $(p-2)/(2(p-1))$ to the *diagonal* restriction while a screen found it in a non-diagonal pair block, and that the decomposition would settle it. It does, and **both attributions are correct**. Assembling the blocks and diagonalising each separately (screen, four splits) puts the value in two places at once: $(p-2)/(2(p-1))$ is the top eigenvalue of each **within-$P$ pair block**, with multiplicity $\binom p2$, and $(q-2)/(2(q-1))$ of each within-$Q$ pair block, with multiplicity $\binom q2$; the same value also occurs inside $\mathcal D_n$. So $\lambda_2=\frac{M-2}{2(M-1)}$ with $M=\max(p,q)$, [Reviewer 314](INDEX.md)'s correction in [nondegeneracy.md](../findings/nondegeneracy.md), is the top eigenvalue of the largest within-factor pair block, and it is not exclusive to the diagonal locus. The full attribution at $S^p\times S^q$ reads: $\tfrac12$ occurs **only** in the $pq$ cross-factor pair blocks and is the orbit; $\pm\mu$ occurs only in the $\binom p2\binom q2$ two-two $4$-set blocks; the within-factor pair blocks top out at $(p-2)/(2(p-1))$ and $(q-2)/(2(q-1))$; the remaining $4$-set blocks are identically zero.

## The screens, reported as screens

Built from the definitions in this review, importing nothing from the repository: $\Lambda^2$ with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ so the $\varphi_{ab}$ are orthonormal, $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$, and $R^\#=k\sum cc RR$.

1. **Calibration.** $k=\tfrac12$ exactly at $n=5,6,7,8$ (residual $\le2\times10^{-15}$) against the classical diagonal identity $(M^\#)_{ij,ij}=\sum_kM_{ik}M_{jk}$, confirming the convention used in the hand derivation. With it, $S^p\times S^q$ is critical to $10^{-16}$ with $\theta=\theta_0(n)$ at $(6,3),(8,4),(10,5),(12,6)$ and $\theta=1.11554670$ at $(8,3)$, matching the record.
2. **The $4$-set closed form.** For random diagonal $M$ at $n=6,7,8,9$: $\max|L_MX-\tfrac12GX|=0$ to machine zero on all three basis directions, and the leak outside the $4$-set block is $0$, **including at $n=6$ and $n=8$, where the character fuses**, confirming the support argument rather than the character argument.
3. **Assembly.** Building $\mathcal D_n$, the pair blocks and the $4$-set blocks independently at $(p,q)=(3,5),(4,4),(4,6),(5,5)$: total dimension $300,300,770,770=\dim\mathcal W_n$ exactly, cross-block leak $\le3\times10^{-16}$, and the per-block spectra as tabulated above. At $S^3\times S^3$ the full spectrum on $\mathcal W_6$ is $1^{(1)},\tfrac12^{(18)},\tfrac14^{(10)},0^{(30)},(-\tfrac12)^{(25)}$, reproducing the record's Peirce table, with the $18$ split $9+9$ between cross pair blocks and $2$–$2$ four-set blocks.

## What I would change in DERIVE-df1.md

- Replace $\Gamma$ by the full sign group $\widetilde\Gamma\cong(\mathbb Z/2)^n\subset O(n)$ throughout, and note in one line that $\circ$ is $O(n)$- and not merely $SO(n)$-equivariant. This makes E1's characters distinct and E4's proof valid at every $n\ge4$.
- Keep the support argument of E4 above as a second proof, since it needs no group at all and is what actually certifies $n=4,6,8$ if anyone later works there.
- Demote the dimension identity from "the note's real check" to what it is: a check on E2 alone, blind to E1 and E4.
- Correct the trivial block on $W^\perp$ to $\tfrac{n(n-3)}2-1$, add $n\ge5$ to the largest-block claim, and record that the orbit sits one direction per pair block with $x_i\propto M_{ij}-M_{ik}$.
- Cite [Lemma L26](../findings/nondegeneracy.md) when the $4$-set block is written up, and state the new content as the identification, the generalisation to arbitrary diagonal $M$, and the $\pm$ pairing.
