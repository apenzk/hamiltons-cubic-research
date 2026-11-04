# Brief for round L21

**Verbatim extracts. Nothing here is paraphrased. Where two passages of the record state the same thing differently, both are given unlabelled.**

## A. The canonical entry, results.md lines 713-715

```markdown
##### Lemma L21, the eigenvalue bound $\alpha\le1/3$ holds in every dimension, for a structural reason

**Proof:** [route-a.md](findings/route-a.md)
```

## B. The landscape statement, results.md line 234

```markdown
- **Lemma L21 (localization). The eigenvalue bound Lemma L20 rests on holds in every dimension, structurally.** $W_{\mathbb{CP}^2}$ lives in $\Lambda^2(\mathbb{R}^4)$, so the construction is $SO(n-4)$-equivariant and Schur applies with **no multiplicity-free hypothesis**. Four spaces of dimensions $20,20,6,10$ carry every nonzero eigenvalue and do not vary with $n$, making the bound a fixed finite computation.
```

## C. The section that carries the argument, findings/route-a.md lines 150-180

```markdown
### $\alpha\le1/3$ is structural, and needs no multiplicity-free hypothesis

The tube audit left one gap: $\alpha\le1/3$ is verified at four dimensions but *asserted* for all $n\ge9$ on Theorem 4.14's Schur argument, whose Lemma 4.13 is valid only on **multiplicity-free** isotypic components. That gap is now closed, by an argument that never needs multiplicity-freeness.

**The mechanism.** $W_{\mathbb{CP}^2}$ is supported entirely inside $\Lambda^2(\mathbb{R}^4)$, so the whole construction is equivariant for $G=SO(n-4)$ acting on the last $n-4$ coordinates and fixing $\mathbb{R}^4$. Hence $F_u$ commutes with $G$, verified at $3.9\times10^{-15}$ over the generators ([p0_schur_free.py](../scripts/pipelines/p0_schur_free.py)), and decomposing into $G$-isotypic pieces

$$\mathrm{Weyl}_n=\bigoplus_\lambda M_\lambda\otimes V_\lambda\qquad\Longrightarrow\qquad F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda},$$

so $\mathop{\mathrm{spec}}(F_u)=\bigcup_\lambda\mathop{\mathrm{spec}}(F_\lambda)$. **Multiplicities are exactly what the spaces $M_\lambda$ absorb**, so Schur applies unconditionally here, this is the structural difference from the thesis's route, which works with the full stabilizer and asks each irreducible subspace to be an eigenspace.

**The multiplicity spaces do not depend on $n$.** Splitting $\mathrm{Weyl}_n$ by the $SO(n-4)$ Casimir and restricting $F_u$ to each block:

| $G$-type | $\dim V_\lambda$ ($n{=}10/12/14$) | $\dim M_\lambda$ | $\mathop{\mathrm{spec}}(F_\lambda)/\sqrt{3/2}$ |
| --- | --- | --- | --- |
| trivial | $1/1/1$ | $20/20/20$ | $-1^{\times2},\ -\tfrac16^{\times6},\ 0^{\times6},\ \tfrac13^{\times3},\ \tfrac12^{\times2},\ 1^{\times1}$ |
| vector | $6/8/10$ | $20/20/20$ | $-\tfrac12^{\times4},\ 0^{\times12},\ \tfrac12^{\times4}$ |
| $\Lambda^2$ | $15/28/45$ | $6/6/6$ | $-\tfrac16^{\times2},\ 0^{\times3},\ \tfrac13^{\times1}$ |
| $S^2_0$ | $20/35/54$ | $10/10/10$ | $-\tfrac16^{\times6},\ 0^{\times1},\ \tfrac13^{\times3}$ |
| two higher types | $-$ | $-$ | $0$ throughout |

Every multiplicity-space dimension and every $F_\lambda$ spectrum is **identical** across all three dimensions, while the $\dim V_\lambda$ grow. Only four blocks carry a nonzero eigenvalue at all, and they are of dimensions $20,20,6,10$, a fixed finite problem. The types occurring are those in $\bigotimes^k\mathbb{R}^{n-4}$ for $k\le4$, since $\mathrm{Weyl}_n\subset S^2(\Lambda^2(\mathbb{R}^n))$ and each $\Lambda^2$ contributes at most two $\mathbb{R}^{n-4}$ factors, so the decomposition is in the stable range once $n-4\ge8$.

**The orbit decomposition, and why $\alpha\le1/3$ follows.** Under $G$, $\mathfrak{so}(n)=\mathfrak{so}(4)\oplus(\mathbb{R}^4\otimes\mathbb{R}^{n-4})\oplus\mathfrak{so}(n-4)$, and modulo the stabilizer the orbit directions are $\mathfrak{so}(4)/\mathfrak{stab}_4$ (dimension $2$, trivial type) together with $\mathbb{R}^4\otimes\mathbb{R}^{n-4}$ (four copies of the vector type). So

$$T_u(SO(n).u)=2\cdot(\text{trivial})\ \oplus\ 4\cdot(\text{vector}),\qquad \dim=2+4(n-4)=4n-14$$

for **every** $n$, the identity previously verified numerically now has its reason. And the eigenvalue $\tfrac12\sqrt{3/2}$ occurs exactly twice in the trivial block and four times per vector copy, i.e. exactly $2+4(n-4)$ times in total: the $\tfrac12$-eigenspace *is* the orbit tangent space, block by block.

Removing $\mathbb{R}u$ and the orbit therefore leaves, in each block: $\tfrac13$ in the trivial block (top, after deleting the single $1$ and the two $\tfrac12$'s), $0$ in the vector block (after deleting the four $\tfrac12$'s per copy), $\tfrac13$ in the $\Lambda^2$ and $S^2_0$ blocks, and $0$ in the rest. **Hence $\alpha\le1/3$, with equality attained, for every $n$ in the stable range, proved by a fixed finite computation on four multiplicity spaces rather than by an isotypic argument that needs multiplicity-freeness.**

This removes the last external dependency of Lemma L20. The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions; the $n=10$ column already agrees, which is evidence that even $n-4=6$ is inside it.
```

## D. The block, findings/route-a.md lines 182-215

```markdown
#### Lemma L21, the eigenvalue bound $\alpha\le1/3$, and the $940$ dimensions its table left unnamed

> **THE TWO UNNAMED TYPES ARE $V_{(2,1)}$ WITH MULTIPLICITY $4$ AND $V_{(2,2)}=\mathrm{Weyl}_{n-4}$ WITH MULTIPLICITY $1$.** *Branching $\mathrm{Weyl}_n=S^2(\Lambda^2\mathbb R^n)\ominus S^2\mathbb R^n\ominus\Lambda^4\mathbb R^n$ over $\Lambda^2\mathbb R^4\oplus(\mathbb R^4\otimes\mathbb R^m)\oplus\Lambda^2\mathbb R^m$, with $\dim V_{(2,1)}=\tfrac{m(m^2-1)}3-m=\tfrac{m(m-2)(m+2)}3$ (the factored form showing it vanishes at $m=2$) and $\dim V_{(2,2)}=\tfrac{m(m+1)(m+2)(m-3)}{12}$, **which is the $\dim\mathrm{Weyl}_m$ formula itself**, so $V_{(2,2)}=\mathrm{Weyl}_{n-4}$ is an equality of formulas rather than an agreement at one dimension. Both are strictly positive at every $m\ge4$, so the unnamed rows are a systematic omission and not an accident of $n=12$ ([L21.lean](../lean/HamiltonsCubic/Results/L21.lean)).* **At $n=12$: $4\cdot160+1\cdot300=940$, and $698+940=1638$ exactly**, and the sum is $\dim\mathrm{Weyl}_n$ identically in $m$. *The same branching reproduces the block's own multiplicities $20,20,6,10$, so those four are consequences rather than measurements.*

> **AND "$0$ THROUGHOUT" ON THOSE $940$ IS A THEOREM WITH NO DIMENSION IN IT.** *$F_u$ preserves the $A$-index degree and vanishes on degree $\le1$: $u$ carries all four indices in $\mathbb R^4$, so $u\#h$ needs two $A$-indices from $h$ and the anticommutator dies on support.* **Both higher isotypics sit at degree $0$ and $1$, so $F_u$ annihilates them**, equivalently, from $[\mathfrak{so}(4),\mathfrak{so}(m)]=0$, $\mathop{\mathrm{im}}F_u\subseteq AA\oplus AB\oplus AC\oplus BB$, which carries neither type. **The bound never has to look at $940$ of the $1638$.**

> **A CLAIM ABOUT THE STABLE RANGE SITS HERE, AND THE SECTION ABOVE STATES THE OBLIGATION AS STILL OPEN.** *a prior audit: the governing bound is on **row length**, not tensor degree, every partition here has $\ell(\nu)\le2$, so Littlewood restriction needs $m\ge4$ and $SO(m)$-irreducibility $m\ge5$, making the decomposition valid for every $n\ge9$.* **So the $n=10$ column is inside the range and this file's stated obligation was over-strong.** *a prior audit adds the complementary point: classical stability governs the type set and $\dim M_\lambda$, and constrains no entry of $F_\lambda$.*

> **WHAT REMAINS IS SMALL AND NAMED.** *a prior audit reduces the whole obligation to one $20\times20$ block (the one carrying the $1$, both $\tfrac12$'s and three $\tfrac13$'s) since $m$ can enter only through $g_m$-normalisations and the trace-free projection, which reach the trivial block alone.* **a prior audit puts it at three of the four named $F_\lambda$, and notes the $\Lambda^2$ block is structurally $m$-independent with $\tfrac13$ attained there, so sharpness follows from one fixed rational $6\times6$.** *An exact argument needs rational rank certificates $\dim\ker(F_\lambda-r\theta^*)$ per claimed eigenvalue, no eigenvectors and no floating point, plus a degree bound in $m$.*

> **$\tfrac13$ IS SHARP, ATTAINED ON $136$ DIMENSIONS AT $n=12$.** *The dependent radius vanishes at $\alpha=\tfrac12$, so the margin is real*, **and the "$a<\tfrac12$ suffices" hedge rescues [Lemma L20](../findings/route-a.md#lemma-l20-no-maximizer-lies-near-the-rival-maximizers-orbit-for-every-nge12) but not [Lemma L134](#)(a), which consumes the numerical $\tfrac13$.**

> **THE BLOCK OMITS THE FIFTH TABLE ROW ENTIRELY** and asserts *"only four types carry a nonzero eigenvalue"* with nothing behind it; the five-row table sits in the preceding section and **the two tables already disagree.** *[results.md](../results.md)'s L21 entry states the motivation and never the result, the same defect as the L20 entry directly above it.*

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Lemma L20 rests on one external input: that the largest eigenvalue of $F_u$ transverse to $\mathbb{R}u$ and the orbit is $\tfrac13\theta^*$. Nienhaus's Theorem 4.14 gives this for $n\ge9$ by Schur on the stabilizer's isotypic components, an argument valid only where those components are multiplicity-free, which is unverified at large $n$. That hypothesis is avoidable.

$W_{\mathbb{CP}^2}$ is supported inside $\Lambda^2(\mathbb{R}^4)$, so the construction is equivariant for $SO(n-4)$ acting on the complementary coordinates. Decomposing $\mathrm{Weyl}_n=\bigoplus_\lambda M_\lambda\otimes V_\lambda$ into isotypic pieces, Schur gives $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$ **with no multiplicity-free hypothesis**, since multiplicities are exactly what the spaces $M_\lambda$ absorb. Only four types carry a nonzero eigenvalue:

| type | $\dim V_\lambda$ ($n=10/12/14$) | $\dim M_\lambda$ | $\mathop{\mathrm{spec}}(F_\lambda)/\theta^*$ |
| --- | --- | --- | --- |
| trivial | $1/1/1$ | $20$ | $-1^{2},\,-\tfrac16^{6},\,0^{6},\,\tfrac13^{3},\,\tfrac12^{2},\,1$ |
| vector | $6/8/10$ | $20$ | $-\tfrac12^{4},\,0^{12},\,\tfrac12^{4}$ |
| $\Lambda^2$ | $15/28/45$ | $6$ | $-\tfrac16^{2},\,0^{3},\,\tfrac13$ |
| $S^2_0$ | $20/35/54$ | $10$ | $-\tfrac16^{6},\,0,\,\tfrac13^{3}$ |

Every multiplicity-space dimension and every $F_\lambda$ spectrum is identical across the three dimensions while the $\dim V_\lambda$ grow. Under the same group the orbit is $2\cdot(\text{trivial})\oplus4\cdot(\text{vector})$, of dimension $2+4(n-4)=4n-14$ for every $n$, and it coincides with the $\tfrac12\theta^*$-eigenspace block by block. Deleting $\mathbb{R}u$ and the orbit leaves top eigenvalue $\tfrac13\theta^*$ in the trivial, $\Lambda^2$ and $S^2_0$ blocks and $0$ in the vector block, so the bound is a fixed finite computation on four spaces of dimensions $20,20,6,10$, valid in every dimension rather than checked at particular ones.

The independent diagonalization also reproduces Theorem 4.14's full spectrum $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\theta^*$ (all seven cases), with multiplicities summing to $\dim\mathrm{Weyl}_n$ exactly, and confirms that the Hessian's kernel at the competitor is precisely the orbit tangent space.


```

## E. What the tube proof consumes from it, findings/route-a.md lines 137-140

```markdown
$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V,\qquad \alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle,\quad \gamma_V=\sqrt{\tfrac23}P(V),$$

where $F_u(h)=\tfrac12(uh+hu)+u\# h$. The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, so $\alpha\le1/3$. **This is the lemma's one unproved input, and the citation given for it does not carry it.** [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(c) states *one* eigenvalue on *one* subspace; that it is the largest on $u^\perp\cap T_u\mathcal O^\perp$ needs 4.14(a) and (d)–(g) to be exhaustive **and** Remark 4.16, which identifies the $\tfrac12\theta^*$-eigenspace with $T_u\mathcal O$ and so removes the larger eigenvalue, neither cited here. **Without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty and the theorem is vacuous**, so this input is load-bearing rather than a convenience. *And 4.14's own proof runs through a Schur step whose multiplicity-free hypothesis this record's own [Lemma L21](#lemma-l21-the-eigenvalue-bound-alphale13-and-the-940-dimensions-its-table-left-unnamed) says fails here.* **What would discharge the debt**: that the four rational $F_\lambda$ matrices have the tabulated spectra, by rank certificates over $\mathbb Q$, and that their entries do not depend on $m=n-4$. And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them. Substituting both and using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$,

```
