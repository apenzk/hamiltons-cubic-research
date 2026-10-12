# REVIEW r609, Lemma L77, $\gamma=2S_{\mathfrak{mhh}}$ and the subalgebra criterion

Reviewer r609, independent adversarial audit, cold from the definitions in [conventions.md](../findings/conventions.md). Target: [Lemma L77](../findings/isotropy-cap.md#L112) at [isotropy-cap.md:112](../findings/isotropy-cap.md#L112), whose content sits in the two blocks that follow it, [*"The odd-$n$ gap, stated sharply"*](../findings/isotropy-cap.md#L114) and the rigidity chain at [isotropy-cap.md:122](../findings/isotropy-cap.md#L122) through [isotropy-cap.md:137](../findings/isotropy-cap.md#L137).

**Analysis only.** Every claim below was derived by hand first. One screen was run: exact integer evaluation of $\mu$, $X$, $\gamma$ and the four block masses on five subspaces I built for the purpose, $\mathbb R\varphi_{12}\subset\mathfrak{so}(4)$, $\mathfrak{so}(3)$ inside $\mathfrak{so}(3)$, $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ inside $\mathfrak{so}(6)$, and the mixed planes at $n=5,6,7,9$. It reproduced every hand value to the integer and is reported as a screen, never as the ground of a positive claim. No sweep, no search, no optimiser. The block's own numerics were not re-run.

## Verdict

**REFUTED as stated**, in the headline identity, by a factor $2$ and by a missing hypothesis, *and everything the chain draws from it survives, because both defects cancel out of the biconditional.* The parity arithmetic is exact and I confirm it. The one arrow the brief flags as load-bearing, *"two vanishing conditions give a $\mathbb Z_2$-grading"*, is **correct**, and for a reason the block never states.

| # | finding | verdict |
| --- | --- | --- |
| D1 | $\gamma=2S_{\mathfrak{mhh}}$ is off by a factor $2$ in the record's own $S$ convention; the truth is $\gamma=S_{\mathfrak{mhh}}$ | **REFUTED**, exact witness |
| D2 | The identity needs **isotropy**, which the heading and the display omit; in general $\gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$ | **REFUTED as stated**, exact witness |
| D3 | [Lemma L36](../findings/isotropy-cap.md#L17), $138$ lines above, defines $\gamma$ the opposite way and warns against L77's reading | **CONFIRMED** (internal contradiction) |
| D4 | The row marginal $2(n-2)$ is the same Killing fact [conventions.md:89](../findings/conventions.md#L89) carries, with no result number | **CONFIRMED**, re-derived |
| D5 | $\gamma=0\iff[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$: sign-definite, sum of squares, holds **under isotropy** | **CONFIRMED** |
| D6 | $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\iff\mathfrak m^\perp$ a subalgebra is a restatement, but $\mathfrak h=\mathfrak m^\perp$ is never declared and contradicts [conventions.md](../findings/conventions.md)'s tabled $\mathfrak h=E_{\max}$ | **GAP**, one line to close |
| D7 | The chained bound $\gamma\le2d(n^2-4d)/n$ and both parity values | **CONFIRMED**, re-derived exactly |
| D8 | *"Measured, $\gamma=0$ anyway"* at the odd symmetric pair is **derivable in one line**, not measured; $18$ and $60$ are forced | **CONFIRMED** (mislabelled as numerics) |
| D9 | The third bracket relation $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ **is** free, it is the same condition as $S_{\mathfrak{mhh}}=0$ | **CONFIRMED**, and the block owes the one line |
| D10 | The chain consumes $SO(n)$-conjugacy and cites Cartan, which is up to $\mathrm{Aut}$; $n=8$ is safe, by facts in **two other files**, cited from neither | **GAP**, already closed elsewhere |
| D11 | Every column of the isotypic table has a closed form; the "at even $n$" claim is true and derivable at every even $n$ | **CONFIRMED**, derived |
| D12 | The block's inference from that table runs **backwards**, the table is an output of $\gamma=0$, not an input to it | **REFUTED** (the arrow) |
| D13 | *"the same parity asymmetry that makes $\theta_0(n)$ non-integral at odd $n$"*, $\theta_0(n)$ is non-integral at even $n$ too | **REFUTED** (as printed) |
| D14 | The two $n=6$ numeric sets in one paragraph are mutually inconsistent if read as one run | hazard, not an error |
| D15 | Pointers: the L77 block contains **no links at all**; the file carries one empty target at [isotropy-cap.md:334](../findings/isotropy-cap.md#L334) | **REFUTED** (one dead link) |

---

## 1. The setting, fixed before anything is derived

[conventions.md](../findings/conventions.md) tables three senses of $\mathfrak m$ and says to read it from context. Here the sense is **[L36](../findings/isotropy-cap.md#L17)'s**: $\mathfrak m\subseteq\mathfrak{so}(n)$ an arbitrary subspace of dimension $d$, isotropic for the Cartan 3-form when so hypothesised. That is the second row of the table's three, not the tabled $\mathfrak m=E_{\min}$.

$\mathfrak h$ is worse. [conventions.md](../findings/conventions.md) tables $\mathfrak h=E_{\max}$ with a third space $\mathfrak r$ carrying everything else, so $\mathfrak m\oplus\mathfrak h\subsetneq\mathfrak{so}(n)$ in general. **L77 needs $\mathfrak h=\mathfrak m^\perp$ and never says so.** Under the tabled reading the block's opening identity $\mu+X=2(n-2)d$ is false, because $X$ would miss the $\mathfrak r$ brackets. I take $\mathfrak h:=\mathfrak m^\perp$ throughout, which is what [L36](../findings/isotropy-cap.md#L37) means when it glosses $\gamma$ as *"the failure of $\mathfrak m^\perp$ to be a subalgebra"*. This is a fourth sense of $\mathfrak h$ on the record and belongs in the table. **(D6, first half.)**

Fix an orthonormal basis $\{v_\alpha\}$ of $\mathfrak{so}(n)$ under the half-trace pairing of [conventions.md](../findings/conventions.md), $\{e_a\}_{a\le d}$ of $\mathfrak m$ and $\{f_i\}$ of $\mathfrak h$. Structure constants $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ are totally antisymmetric, so $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is totally symmetric.

### What $S_{\mathfrak{mhh}}$ is, and the record does pin it

The L77 block uses $S_{\mathfrak{mmh}}$ and $S_{\mathfrak{mhh}}$ without defining either, and no findings file defines them at their point of use. **The record pins the convention twice, in [nondegeneracy.md](../findings/nondegeneracy.md), and both pins say the same thing.**

The first is the bookkeeping identity at [nondegeneracy.md:317](../findings/nondegeneracy.md#L317):

$$S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2),$$

stated there as *"derived from total antisymmetry and the row marginal"*. That is exactly the partition of $\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}$ into its eight index patterns, grouped into four by total symmetry, with the multiplicity $3$ counting slot placements. It closes **only** if each $S$ is the **fully ordered** sum:

$$S_{\mathfrak{mmm}}=\sum_{a,b,c}c_{abc}^2,\qquad S_{\mathfrak{mmh}}=\sum_{a,b,i}c_{abi}^2,\qquad S_{\mathfrak{mhh}}=\sum_{a,i,j}c_{aij}^2,\qquad S_{\mathfrak{hhh}}=\sum_{i,j,k}c_{ijk}^2 .$$

The second pin is a number. [nondegeneracy.md:291](../findings/nondegeneracy.md#L291) reports that at the $n=6$ balanced product with the sign flipped (so that $\mathfrak m$ is $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$), the record's $S_{\mathfrak{mmm}}$ is **$12$**. By hand: inside one $\mathfrak{so}(3)$ the only nonzero constants are the $3!=6$ orderings of $(\varphi_{12},\varphi_{13},\varphi_{23})$, each with $c^2=1$, giving $6$; two copies with no cross terms give $12$. The unordered readings give $2$ or $6$. **Ordered, decisively.**

## 2. The identity, REFUTED by a factor $2$, and by a missing hypothesis

### The derivation

$\|[e_a,e_b]\|^2=\sum_\gamma T_{ab\gamma}$, so splitting $\gamma$ over $\mathfrak m$ and $\mathfrak h$,

$$\mu:=\sum_{a,b}\|[e_a,e_b]\|^2=S_{\mathfrak{mmm}}+S_{\mathfrak{mmh}}.$$

The row marginal gives $\sum_a\sum_\beta\|[e_a,v_\beta]\|^2=2(n-2)d$, whose two halves are $\mu$ and $X:=\sum_{a,i}\|[e_a,f_i]\|^2$; so $\mu+X=2(n-2)d$, which is the block's line. Splitting $X$ the same way and using total symmetry to fold $\sum_{a,i,b}T_{aib}$ into $S_{\mathfrak{mmh}}$,

$$X=S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}.$$

Therefore, with $\gamma:=2(n-2)d-2\mu=(\mu+X)-2\mu=X-\mu$,

$$\boxed{\ \gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}\ }$$

and under isotropy ($S_{\mathfrak{mmm}}=0$), $\gamma=S_{\mathfrak{mhh}}$.

**The block asserts $\mu=2S_{\mathfrak{mmh}}$ and $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$, hence $\gamma=2S_{\mathfrak{mhh}}$. Both intermediate lines carry a spurious factor $2$, and it survives into the headline.** The block's factor is right only under a convention in which the two like-type indices are taken unordered, a convention that appears nowhere on the record and breaks [nondegeneracy.md:317](../findings/nondegeneracy.md#L317).

### D1, the witness, $n=4$, $\mathfrak m=\mathbb R\varphi_{12}$

$d=1$, $N=6$. $\mathfrak m$ is isotropic vacuously and $\mu=0$, so $\gamma=2(n-2)d-2\mu=4$. And $c$ vanishes whenever two indices coincide, so with $\dim\mathfrak m=1$,

$$S_{\mathfrak{mhh}}=\sum_{i,j\in\mathfrak h}c_{(12)ij}^2=\sum_{\beta,\gamma}c_{(12)\beta\gamma}^2=\sum_\beta\|[\varphi_{12},v_\beta]\|^2=2(n-2)=4 .$$

So $\gamma=4=S_{\mathfrak{mhh}}$ and $2S_{\mathfrak{mhh}}=8\ne\gamma$. **The identity as printed fails at the smallest nontrivial configuration on an isotropic subspace.**

### D2, the witness, $n=3$, $\mathfrak m=\mathfrak{so}(3)$

$d=3$, $\mathfrak h=\{0\}$, which **is** a subalgebra, so $S_{\mathfrak{mhh}}=0$. But $\mu=6$ (the six ordered pairs, each bracket of norm $1$) against $2(n-2)d=6$, giving $\gamma=6-12=-6$. So $\gamma\ne0$ while $\mathfrak m^\perp$ is a subalgebra: **the $\Leftarrow$ direction of the biconditional fails without isotropy**, and $\gamma\ge0$ fails with it. The general formula reads $-6=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}=0-6$. ✓

The block does acknowledge the hypothesis, but only in the *verification* paragraph (*"the discrepancy being the $S_{\mathfrak{mmm}}$ that isotropy kills"*), after the heading and the display have both stated the identity unconditionally. **A heading is a claim.**

### D3, the same file contradicts itself

[L36](../findings/isotropy-cap.md#L37), $138$ lines above, writes $2\mu+\gamma=2(n-2)d$ with $\gamma$ **defined** as the $\mathfrak{hhm}$ mass, and adds in italics: *"read instead as the residual $2(n-2)d-2\mu$, the identity is a tautology and $\gamma\ge0$ restates the conclusion."* L77 adopts precisely the residual reading it warns against. The two are consistent only if the mass equals the residual, i.e. only if $\gamma=S_{\mathfrak{mhh}}$, **L36's arithmetic is right and L77's factor $2$ is what breaks between them.** The file settles its own question, and this is the fifteenth-plus instance of that pattern in this record.

### D4, the row marginal

$\sum_\beta\|[v_\alpha,v_\beta]\|^2=-\operatorname{tr}\operatorname{ad}(v_\alpha)^2=-B(v_\alpha,v_\alpha)=-(n-2)\operatorname{tr}(v_\alpha^2)=2(n-2)$, using $\operatorname{tr}(v^2)=-2$ for a unit bivector. **This is the same Killing-form fact**, not a coincident constant: [conventions.md:89](../findings/conventions.md#L89) carries it verbatim under *"The pair cap and the Killing marginal"*, alongside $\kappa=2(n-2)$ in the normalisations. It carries no result number, and by the record's own quoting rule L77 should cite it rather than restate it.

## 3. The two equivalences

### $\gamma=0\iff[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, CONFIRMED under isotropy

$S_{\mathfrak{mhh}}=\sum_{i,j}\sum_a\langle[f_i,f_j],e_a\rangle^2=\sum_{i,j}\|P_{\mathfrak m}[f_i,f_j]\|^2$, a sum of squares, hence $\ge0$, hence sign-definite, and zero exactly when $P_{\mathfrak m}[f_i,f_j]=0$ for every $i,j$, which is $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$. It is basis-independent, being the contraction of the totally symmetric $T$ against $P_{\mathfrak m}\otimes P_{\mathfrak h}\otimes P_{\mathfrak h}$. With $\gamma=S_{\mathfrak{mhh}}$ under isotropy, the forward implication goes through. **Confirmed, with the hypothesis restored and the constant corrected.**

### $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\iff\mathfrak m^\perp$ a subalgebra, a restatement, and it must say so

It is a definitional restatement **and only because $\mathfrak h=\mathfrak m^\perp$**. The block never writes that equality. Under [conventions.md](../findings/conventions.md)'s tabled $\mathfrak h=E_{\max}$ it is not a restatement but a false claim. **(D6.)** One clause closes it.

## 4. The parity claim

### D7, the chained bound, re-derived

[L36](../findings/isotropy-cap.md#L66)'s second lemma is $\mu\ge4d^2/n-2d$ for **every** $d$-subspace. I rebuilt it: with $P$ the projection onto $\mathfrak m$, $P_0=P-\tfrac dN\mathrm{Id}$ and $T$'s spectrum $(2n-4,\,n-4,\,-2,\,4)$ on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$,

$$\mu=\langle T(P),P\rangle=\tfrac{(2n-4)d^2}{N}+\langle T(P_0),P_0\rangle\ \ge\ \tfrac{4(n-2)d^2}{n(n-1)}-2d+\tfrac{4d^2}{n(n-1)}=\tfrac{4d^2}{n}-2d,$$

using $N=n(n-1)/2$ and $\langle T(P_0),P_0\rangle\ge-2\|P_0\|^2=-2d(N-d)/N$. Then

$$\gamma=2(n-2)d-2\mu\ \le\ 2(n-2)d-\tfrac{8d^2}{n}+4d\ =\ 2nd-\tfrac{8d^2}{n}\ =\ \frac{2d(n^2-4d)}{n}. \qquad\checkmark$$

**Confirmed exactly.** It is a **both-parity** statement: no parity enters the derivation.

### The two parities, labelled

| statement | parity |
| --- | --- |
| $\gamma\le2d(n^2-4d)/n$ | **both**; pure algebra |
| $d=n^2/4$ makes it vanish, forcing $\gamma=0$ | **even $n$ only**, at odd $n$ no subspace has that dimension |
| the cap $\lfloor n^2/4\rfloor$ is attained | **both**, by [L36](../findings/isotropy-cap.md#L17)'s mixed planes at $p=\lceil n/2\rceil$ |
| $(n^2-1)/(2n)$, giving $2.4$ and $3.4286$ | **odd $n$ only** |
| $\gamma\ge0$, so $\gamma=0$ at the even cap | needs **isotropy**, at both parities |
| the $\Lambda^4$ component vanishes | **both** |
| the $\mathrm{Sym}^2_0$ component vanishes | **even $n$ only**, and correctly so labelled |

**The cap at odd $n$ and the recomputed bound.** At odd $n$, $\lfloor n^2/4\rfloor=(n^2-1)/4$, so $n^2-4d=1$ and $\gamma\le2d/n=(n^2-1)/(2n)$. At $n=5$ that is $24/10=2.4$; at $n=7$, $48/14=3.428571$. **The block's numbers follow.** ✓

I found **no** unqualified even-$n$ constant masquerading as a both-parity one in this block, the failure mode that refuted [result 0](../findings/INDEX-results.md). The block is explicit about its parities throughout, which is the one place it is more careful than its neighbours.

### D8, "Measured" understates what is proved

*"**Measured**, $\gamma=0$ anyway: at the cap the symmetric pair $((n-1)/2,(n+1)/2)$ has $\mu=(n-2)d$ exactly ($18=3\cdot6$ at $n=5$, $60=5\cdot12$ at $n=7$)."*

That is a **theorem, in one line**. For any symmetric pair, $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is a subalgebra, so $S_{\mathfrak{mhh}}=0$; and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ gives $S_{\mathfrak{mmm}}=0$; so $\gamma=0$ and $\mu=(n-2)d$, at **both** parities, with no run. $18=3\cdot6$ and $60=5\cdot12$ are forced. The genuinely numerical part of that sentence is the *other* clause (ten random isotropic subspaces per $n$) and welding the two under one bold **Measured** buries a proof inside a measurement. The brief warned about numbers presented as identities; this is the inverse and is the more expensive way round, because it leaves the odd-$n$ debt looking larger than it is.

**What is actually owed at odd $n$** is narrower than the block's phrasing: not that the symmetric pair has $\gamma=0$ (proved), but that **every** isotropic $\mathfrak m$ at $d=(n^2-1)/4$ does.

## 5. The rigidity chain

### D9, the load-bearing arrow is sound, and free for a reason the block omits

A $\mathbb Z_2$-grading needs three relations. The brief is right that only two conditions are claimed killed. **The third is free, and the reason is total antisymmetry of $c$:**

$$\langle[f_i,e_a],f_j\rangle=c_{iaj}=c_{aij},$$

so $P_{\mathfrak h}[\mathfrak h,\mathfrak m]=0$ and $P_{\mathfrak m}[\mathfrak h,\mathfrak h]=0$ are governed by **the same** array of constants. Hence

$$S_{\mathfrak{mhh}}=0\iff[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\ \textbf{and}\ [\mathfrak h,\mathfrak m]\subseteq\mathfrak m,\qquad S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h .$$

Equivalently, in one clause: the orthogonal complement of a subalgebra is automatically an $\operatorname{ad}$-module, the pairing being $\operatorname{ad}$-invariant. Two conditions do give all three relations, the map $\sigma=+1$ on $\mathfrak h$, $-1$ on $\mathfrak m$ is then an involutive automorphism, and $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **Arrow CONFIRMED, but "exactly a $\mathbb Z_2$-grading" is a hedge covering a step, and it costs one sentence to state.**

### D10, Cartan, $SO(n)$-conjugacy, and $n=8$

**Yes, the chain consumes $SO(n)$-conjugacy.** Its terminus is *"hence the balanced split"*, and the downstream block at [isotropy-cap.md:161](../findings/isotropy-cap.md#L161) reads that as *"the rigidity forces $\mathfrak m$ onto the symmetric-pair subspace, hence $W$ onto the sphere product"*, a statement about the $SO(n)$-orbit of $\mathfrak m$, since $\theta$ is an $O(n)$-invariant and nothing coarser. Cartan supplies conjugacy up to $\mathrm{Aut}(\mathfrak g)$ only, and [conventions.md:33](../findings/conventions.md#L33) states this rule and adds that Cartan *"is cited to no source anywhere on the record"*. **The block invokes it bare, with no citation and no caveat.**

**Is $n=8$ affected? No, and the record already holds both reasons, in files L77 does not cite.**

- At the cap, $\dim\mathfrak h=N-\lfloor n^2/4\rfloor=n(n-2)/4$, which is $12$ at $n=8$. [Trap W2](../findings/INDEX-traps.md#L20) records that triality adds exactly two involutions at $n=8$, $\mathfrak{spin}(7)$ at dimension $21$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $13$. **Neither is $12$**, so the cap dimension is untouched.
- [bounds.md:478](../findings/bounds.md#L478) closes the conjugacy question directly: $\operatorname{Ad}(\operatorname{diag}(-1_4,1_4))$ has determinant $+1$ and is **inner**, so Cartan up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy (*"which is exactly why dimension $12$ is safe and $13$ is not"*), with a second route through the weight pattern $(1^4,(-1)^4)$ on $V$, $S^+$, $S^-$ alike. Gate 2, [r567](REVIEW_r567.md) and [r568](REVIEW_r568.md).

Two further steps the block leaves silent, both closed in [bounds.md:478](../findings/bounds.md#L478) and neither cited here: $\mathfrak u(n/2)$ has dimension $n^2/4\ne n(n-2)/4$ and is excluded at every even $n$; and writing $p=\tfrac n2+t$, $q=\tfrac n2-t$ gives $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{n^2}4+t^2-\tfrac n2$, so the target $\tfrac{n(n-2)}4$ forces $t=0$, **the balanced split at every even $n$ at once, no case list.**

**Verdict on D10: GAP in the block, reachable and in fact already reached, three cross-references and the chain is closed at even $n$.** [bounds-relaxations.md:174](../findings/bounds-relaxations.md#L174) states the identical implication *"$S_{\mathfrak{mhh}}=S_{\mathfrak{mmm}}=0$ says exactly that $(\mathfrak h,\mathfrak m)$ is a symmetric pair"* **with** the W2 caveat attached. The record therefore carries the caveated form in one file and the bare form here.

**One arrow beyond L77's scope, flagged.** *"hence $W$ onto the sphere product"* needs more than $\mathfrak m$'s orbit: a subspace fixes the negative eigenspace, not the eigenvalues. That step is asserted at [isotropy-cap.md:161](../findings/isotropy-cap.md#L161) without argument. Outside this audit, but on the chain the brief asks about.

## 6. The isotypic table, every column has a closed form

The table at [isotropy-cap.md:130](../findings/isotropy-cap.md#L130) contains four rows and **one even $n$**. Its conclusion is nevertheless true, and derivable at every even $n$. Here is the derivation, which is what the block owes in place of the table.

**Column $\|P_0\|^2$.** $\|P_0\|^2=\|P\|^2-d^2/N=d(N-d)/N$. This gives $2.4$, $3.6$, $108/21=5.142857$, $320/36=8.8889$, **all four rows exactly.**

**Column $\Lambda^4$.** At the symmetric pair $P$ is diagonal in the coordinate-plane basis, so $P_{ijkl}=0$ on four distinct indices and $\operatorname{Alt}(P)=0$. **Both parities, derived**, the block's *"vanishes at both parities"* is right.

**Column $\mathrm{Sym}^2_0$.** Two independent routes, agreeing.

*Route 1, the Ricci contraction.* $P$ has sectional entries $1$ on mixed planes and $0$ on pure ones, so its Ricci is $q$ on the first block and $p$ on the second, trace $2pq$. The traceless part has entries $q(n-2p)/n$ and $p(n-2q)/n$. **At $p=q$ this is identically zero**, the vanishing is exactly balance, at every even $n$, not a fact about $n=6$. At odd $n$, $n-2p=1$ and the entries are $q/n$, $-p/n$, with $\|\mathring r\|^2=pq/n=d/n$.

*Route 2, the slack, which fixes the normalisation without fitting.* $P_0$ has no $\mathbb R$ part and no $\Lambda^4$ part, so

$$\mu-\left(\tfrac{4d^2}{n}-2d\right)=\langle T(P_0),P_0\rangle+2\|P_0\|^2=(n-2)\|P_0^{\mathrm{Sym}^2_0}\|^2 .$$

At the odd cap $\mu=(n-2)d$ (§4, D8) and $n^2-4d=1$, so the left side is $\tfrac dn(n^2-4d)=d/n$, whence

$$\|P_0^{\mathrm{Sym}^2_0}\|^2=\frac{d}{n(n-2)}=\frac{n^2-1}{4n(n-2)} .$$

At $n=5,7,9$: $6/15=0.4000$, $12/35=0.342857$, $20/63=0.31746$. **All three odd rows, exactly.** The Weyl column is the difference and reproduces $2.0000$, $3.6000$, $4.8000$, $8.5714$ to every digit printed.

**D11.** *"At even $n$ the traceless part lies entirely in $\mathrm{Weyl}_n$"* is **true and derivable at every even $n$**, and more strongly than the block claims: at the even cap, $\gamma=0$ is forced for **every** isotropic $\mathfrak m$, so $\mu=(n-2)d$, so the slack $(n-2)\|P_0^{\mathrm{Sym}^2_0}\|^2+6\|P_0^{\Lambda^4}\|^2$ vanishes and both components die, not only at the symmetric pair. **The claim is right; the table does not support it.** One even row is an extrapolation, and the brief's alternative applies: *the label is the finding.*

**D12, the arrow is reversed.** The block writes *"At even $n$ the traceless part lies entirely in $\mathrm{Weyl}_n$, **so** Lemma L2 is tight and $\gamma=0$ is forced."* The implication runs the other way. $\gamma=0$ at the even cap comes from the chained bound alone, with no table; tightness and the vanishing $\mathrm{Sym}^2_0$ component are **consequences** of it. Read as an argument the passage is circular, since the table is computed at a point where $\gamma=0$ is already known. It is a good *diagnosis* of the parity split (I confirm the mechanism) and it is not a proof of anything, and the word "forced" says it is.

**The remaining clause is confirmed.** *"$\mu$ exceeds the Lemma-2 bound by exactly its contribution"*, exact: excess $=(n-2)\cdot\tfrac{d}{n(n-2)}=d/n$, and directly $(n-2)d-(4d^2/n-2d)=\tfrac dn(n^2-4d)=d/n$. ✓ So is *"the unbalanced split cannot be Ricci-isotropic the way a balanced one is"*, which is Route 1 above, and which [bounds-relaxations.md:174](../findings/bounds-relaxations.md#L174) already carries with its own measured residuals.

**D13, the closing analogy is false.** *"the same parity asymmetry that makes $\theta_0(n)$ non-integral at odd $n$."* $\theta_0(n)^2=2(n-1)(n-2)/n^2$ gives $\theta_0(6)=1.054093$ and $\theta_0(5)=0.979796$: **non-integral at both parities**, so the sentence names no asymmetry. The intended fact is presumably [conventions.md](../findings/conventions.md)'s $\Theta_n=\theta_0(n)$ at even $n$ and strictly otherwise at odd $n$, or simply that $n/2$ is non-integral. As printed it is a false analogy at the end of an otherwise sound paragraph.

## 7. Provenance, hedges, pointers

**Provenance.** The L77 block makes **no claim about its own history**, no "moved here", no "corrected", no dated note. There is nothing to falsify, and I record that as the clean outcome rather than as an absence of checking. The one self-referential sentence, *"Checking it only at the symmetric pairs would have proved nothing: both sides are zero there"*, is **true**: at a symmetric pair $\gamma=0$ and $S_{\mathfrak{mhh}}=0$, as §4 derives. `git log -S` over the identity returns only commit `5b258c14`, *"place headings for Lemmas 75-82"*, and the file split, consistent with a block that predates its number.

**Hedges.** Five in the block, and each conceals something.

| clause | what it covers |
| --- | --- |
| *"the two together are **exactly** a $\mathbb Z_2$-grading"* | the third bracket relation, free by total antisymmetry, D9 |
| *"has $\mu=(n-2)d$ **exactly**"* | a one-line theorem, presented as a measurement, D8 |
| *"$\gamma$ has a structural meaning"* | the factor $2$ and the isotropy hypothesis, D1, D2 |
| *"**Measured**, $\gamma=0$ anyway"* | two claims of different status welded together, D8 |
| *"**precisely** the slack"* | true, and the only one of the five that is exact, §6 |

**Numbers presented as identities.** *"to $10^{-14}$ and $10^{-10}$"* at $n=6$, $d=3,4$ is a measurement of a script whose $S$ convention differs from the record's by a factor $2$ (D1); it verifies the script's internal consistency and nothing about the record's identity. **D14:** the same paragraph reports $\mu=2.77,6.49$ at $d=3,4$ and, two sentences later, $\gamma=18.8959,19.9337$ at the same $n$ and $d$, which back-solve to $\mu=2.552,6.033$. Two different draws described as if one; a reader checking the arithmetic across the paragraph will find it fails. Both sets satisfy the chained bound, so no claim is wrong.

**D15, pointers.** The L77 block contains **no links at all**, not to [L36](../findings/isotropy-cap.md#L17) whose two lemmas it chains, not to [conventions.md:89](../findings/conventions.md#L89) for the row marginal it restates, not to the trap or the file that close its own $n=8$ question. Elsewhere in the same file, [isotropy-cap.md:334](../findings/isotropy-cap.md#L334) carries `[Lemma L36](#)`, **one empty target**, the known defect class, and the only one in the file.

**The label.** [INDEX-results.md:92](../findings/INDEX-results.md#L92) carries L77 as kind `Lemma` with the note *"Gate 2: no verdict on the record."* The index's own rule two lines from the top is *"Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed."* The two cannot both hold. This review is the first Gate 2 verdict on it.

## 8. What is owed, and whether it is reachable

**Reachable now, by editing the block:**

1. $\gamma=S_{\mathfrak{mhh}}$, with the isotropy hypothesis in the heading and in the display, and the general form $\gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$ beside it. The two $n=6$ verification figures must be recomputed in the record's convention or the script's convention stated.
2. $\mathfrak h:=\mathfrak m^\perp$, declared, and a fourth row for $\mathfrak h$ in [conventions.md](../findings/conventions.md)'s table.
3. $S_{\mathfrak{mmm}},S_{\mathfrak{mmh}},S_{\mathfrak{mhh}},S_{\mathfrak{hhh}}$ defined once, best in [conventions.md](../findings/conventions.md), quoted here, as ordered sums, with [nondegeneracy.md:317](../findings/nondegeneracy.md#L317)'s identity as the anchor.
4. The one-line reason $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ is free.
5. The $n=8$ and $\mathfrak u(n/2)$ steps cited to [trap W2](../findings/INDEX-traps.md#L20) and [bounds.md:478](../findings/bounds.md#L478).
6. The isotypic table replaced by, or given, the closed forms $\|P_0\|^2=d(N-d)/N$, $\|P_0^{\mathrm{Sym}^2_0}\|^2=d/(n(n-2))$ at odd $n$ and $0$ at even $n$, $\|P_0^{\Lambda^4}\|^2=0$, and the "so" at [isotropy-cap.md:137](../findings/isotropy-cap.md#L137) turned round.
7. The $\theta_0(n)$ analogy struck or repaired.

**The genuine open debt, unchanged by any of the above:** at odd $n$, that **every** isotropic $\mathfrak m$ of dimension $(n^2-1)/4$ has $\gamma=0$, where the chained bound permits $(n^2-1)/(2n)$. §6 localises it precisely: the slack is $(n-2)\|P_0^{\mathrm{Sym}^2_0}\|^2$, so the debt is to show that no isotropic subspace at the odd cap can carry a $\mathrm{Sym}^2_0$ component larger than the symmetric pair's $d/(n(n-2))$, an extremal question about $P_0$'s isotypic profile, not about $\gamma$. **That reformulation is new here and is, in my judgement, the reachable form of the debt.** I did not open a numerical line on it, and note for the record what a run would decide: a search for an isotropic $\mathfrak m$ at $d=(n^2-1)/4$ with $\gamma>0$ would settle it negatively at a stroke; failure to find one at $n=5,7$ would be evidence only, since the block already reports ten such draws.
