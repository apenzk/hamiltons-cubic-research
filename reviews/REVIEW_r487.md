# Review r487, Lemma L21 ($\alpha\le\tfrac13$ in every dimension)

**Status: PLAUSIBLE.** Exhaustion CONFIRMED (and the two missing types identified); the "$0$ throughout" row upgraded from measurement to proof; the $n$-stability dispute DECIDED against both sides' premise. One input remains unproved: the $m$-independence of three of the four $F_\lambda$ matrices.

**Target:** [Lemma L21](../findings/route-a.md), the sole unproved input to [Lemma L20](../findings/route-a.md).

## Findings

### 1. The two unnamed types, IDENTIFIED, and the exhaustion CONFIRMED as a polynomial identity

**Verdict on target 1: the table exhausts. The $940$ is $4\times160+1\times300$, and the identity holds in every $n$, not just at $n=12$.**

Write $\mathbb R^n=A\oplus B$, $A=\mathbb R^4$ carrying $u=W_{\mathbb{CP}^2}$, $B=\mathbb R^m$ with $m=n-4$, and $G=SO(m)$ acting on $B$ alone. $\mathrm{Weyl}_n$ is the $O(n)$-irreducible traceless part of the $2\times2$-window Schur functor: $\mathbb S_{(2,2)}(\mathbb R^n)=\mathrm{Weyl}_n\oplus S^2(\mathbb R^n)$ (dimensions $n^2(n^2-1)/12=n(n+1)(n+2)(n-3)/12+n(n+1)/2$).

**Step (i), Littlewood–Richardson on $A\oplus B$.** $c^{(2,2)}_{\mu\nu}\ne0$ forces $\mu,\nu\subseteq(2,2)$, and the six surviving pairs each have coefficient $1$:

$$\mathbb S_{(2,2)}(A\oplus B)=\mathbb S_{22}(B)\ \oplus\ A\otimes\mathbb S_{21}(B)\ \oplus\ S^2A\otimes S^2B\ \oplus\ \Lambda^2A\otimes\Lambda^2B\ \oplus\ \mathbb S_{21}(A)\otimes B\ \oplus\ \mathbb S_{22}(A).$$

*(The vanishing pairs, checked from the Pieri products: $s_2\cdot s_{11}=s_{31}+s_{211}$ carries no $s_{22}$, so $\mu=(2),\nu=(1,1)$ and its transpose drop out; $s_1s_3$ and $s_1s_{111}$ carry none, so $\nu=(3),(1^3)$ drop out.)*

**Step (ii), Littlewood restriction $GL(m)\downarrow O(m)$**, $\mathbb S_\nu=\bigoplus_\sigma(\sum_{\delta\ \mathrm{even\ rows}}c^\nu_{\sigma\delta})V_{[\sigma]}$:
$\mathbb S_{22}(B)=V_{(2,2)}\oplus V_{(2)}\oplus V_{(0)}$, the Weyl/traceless-Ricci/scalar split of $B$'s own curvature space; $\mathbb S_{21}(B)=V_{(2,1)}\oplus V_{(1)}$; $S^2B=V_{(2)}\oplus V_{(0)}$; $\Lambda^2B=V_{(1,1)}$.

**Step (iii), collect, and subtract $S^2(\mathbb R^n)|_G=11V_{(0)}\oplus4V_{(1)}\oplus V_{(2)}$.** The $A$-side factors have dimensions $\dim\mathbb S_{22}(\mathbb R^4)=20$, $\dim\mathbb S_{21}(\mathbb R^4)=4(4^2-1)/3=20$, $\dim S^2A=10$, $\dim\Lambda^2A=6$, $\dim A=4$:

| $G$-type $\lambda$ | multiplicity in $\mathbb S_{(2,2)}(\mathbb R^n)$ | in $\mathrm{Weyl}_n$ | $\dim V_\lambda$ | at $n=12$ |
| --- | --- | --- | --- | --- |
| trivial $V_{(0)}$ | $1+10+20=31$ | $\mathbf{20}$ | $1$ | $20$ |
| vector $V_{(1)}$ | $4+20=24$ | $\mathbf{20}$ | $m$ | $160$ |
| $\Lambda^2$ $V_{(1,1)}$ | $6$ | $\mathbf 6$ | $\binom m2$ | $168$ |
| $S^2_0$ $V_{(2)}$ | $1+10=11$ | $\mathbf{10}$ | $\tfrac{m(m+1)}2-1$ | $350$ |
| $V_{(2,1)}$ | $4$ | $\mathbf 4$ | $\tfrac{m(m^2-1)}3-m$ | $4\times160=640$ |
| $V_{(2,2)}=\mathrm{Weyl}_m$ | $1$ | $\mathbf 1$ | $\tfrac{m(m+1)(m+2)(m-3)}{12}$ | $1\times300=300$ |

**The derivation reproduces all four tabulated multiplicities $20,20,6,10$ independently** (they were measurements in the record and are now consequences), **and names the two missing types: $V_{(2,1)}$ with multiplicity $4$ and $V_{(2,2)}$, the Weyl space of the complement $\mathbb R^{n-4}$ itself, with multiplicity $1$.**

**The two higher dimensions cross-checked by Weyl's formula for $D_4$ ($SO(8)$), independently of the $\mathbb S_\nu$ route.** With $\rho=(3,2,1,0)$: for $\lambda=(2,1,0,0)$, $\lambda+\rho=(5,3,1,0)$ and $\prod_{i<j}\frac{l_i^2-l_j^2}{r_i^2-r_j^2}=\frac{691200}{4320}=160$; for $\lambda=(2,2,0,0)$, $\lambda+\rho=(5,4,1,0)$ and the ratio is $\frac{1296000}{4320}=300$. So $4\times160+300=940$ exactly.

**They sum.** Screened symbolically in $m$ (sympy, seconds; a screen, and the identity is checkable by hand): $20+20m+6\binom m2+10(\tfrac{m(m+1)}2-1)+4(\tfrac{m(m^2-1)}3-m)+\tfrac{m(m+1)(m+2)(m-3)}{12}-\tfrac{(m+4)(m+5)(m+6)(m+1)}{12}\equiv0$. So $698+940=1638$ at $n=12$ is not a coincidence of one dimension: **the six blocks exhaust $\mathrm{Weyl}_n$ identically in $n$.** At $n=10$: $430+340=770$; at $n=14$: $1030+2050=3080$.

### 2. The "$0$ throughout" row is a THEOREM, not a measurement, and I supply the proof

**$F_\lambda=0$ on both higher blocks, exactly, in every dimension.** The record leaves this row as an unexplained observation; it follows in three lines.

**$F_u$ preserves the $A$-index degree.** Grade $\bigotimes^4\mathbb R^n$ by the number of indices lying in $A$. Every nonzero component of $u=W_{\mathbb{CP}^2}$ has all four indices in $A$. In $u\# h$ two indices of $u$ are contracted against two of $h$; the contracted pair must therefore be $A$-indices on both sides, so the output has $2$ free $A$-indices from $u$ plus $\deg_A(h)-2$ from $h$, **degree preserved, and identically zero whenever $\deg_A(h)\le1$.** The anticommutator vanishes for the same support reason: as an operator on $\Lambda^2\mathbb R^n$, $u$ maps $\Lambda^2A\to\Lambda^2A$ and annihilates $A\wedge B$ and $\Lambda^2B$, so $uh=hu=0$ for any $h$ carrying no $\Lambda^2A\to\Lambda^2A$ component.

**Both higher isotypics lie in degree $\le1$.** $V_{(2,2)}$ occurs once in $\mathbb S_{(2,2)}(\mathbb R^n)$ and once in $\mathrm{Weyl}_n$, so the two copies coincide, and the unique copy is the one inside $\mathbb S_{22}(B)$, **degree $0$: it is literally $\mathrm{Weyl}_{n-4}$, the zero-padded Weyl tensors of the complement.** $V_{(2,1)}$ occurs $4$ times in both (none in $S^2(\mathbb R^n)$), so again the copies coincide and sit inside $A\otimes\mathbb S_{21}(B)$, **degree $1$.** Hence $F_u$ annihilates $940$ of the $1638$ dimensions at $n=12$, for a reason with no dimension in it.

**The record already owns the mechanism and never connected it to the row.** [route-a.md](../findings/route-a.md) line 60 says *"complement-supported directions do not couple to the competitor through the quadratic map at all"*, and [Lemma L134](../findings/route-a.md)(c) uses the same disjointness to get $\langle L_eH,H\rangle=0$ on the padded flat. That is exactly the $V_{(2,2)}$ row. **The $V_{(2,1)}$ row (the larger one, $640$ of the $940$), is new here.**

**Internal check the four named rows pass.** Each tabulated block spectrum has trace zero: $-2-1+0+1+1+1=0$ (trivial), $-2+2=0$ (vector), $-\tfrac13+\tfrac13=0$ ($\Lambda^2$), $-1+1=0$ ($S^2_0$). With the two higher blocks now known to be zero, $\mathop{\mathrm{tr}}F_u=0$ on all of $\mathrm{Weyl}_n$, block by block.

### 3. The $n$-stability question, DECIDED, and both divided reviewers used the wrong criterion

**Neither [r485](REVIEW_r485.md)'s "$m\ge2k$, $k\le4$, so $n\ge12$" nor [r484](REVIEW_r484.md)'s inference from it survives. The governing bound is on the number of ROWS, not on the tensor degree.**

$\mathrm{Weyl}_n$ is the $2\times2$-window functor, so every partition appearing in step (i) satisfies $\nu\subseteq(2,2)$, i.e. $\ell(\nu)\le2$. Three conditions, and only these:

| step | condition | threshold |
| --- | --- | --- |
| LR expansion $\mathbb S_{(2,2)}(A\oplus B)$ | $\mathbb S_\nu(B)\ne0$, i.e. $\ell(\nu)\le m$ | $m\ge2$ |
| Littlewood restriction $GL(m)\downarrow O(m)$ | $\ell(\nu)\le m/2$ | $m\ge4$ |
| $V_{[\sigma]}$ stays $SO(m)$-irreducible | $\ell(\sigma)<m/2$ | $m\ge5$ |

**So the six-type decomposition with multiplicities $20,20,6,10,4,1$ is valid for every $n\ge9$**, which is exactly the range Nienhaus's Theorem 4.14 is stated in, and comfortably below the $n\ge12$ the theorem is applied at. **The $n=10$ column is INSIDE the stable range, and the record's own hedge (*"the remaining formal obligation is a proof that the stable range begins at $n-4\ge8$"*), asks for a proof of something stronger than it needs and is now discharged at $n-4\ge5$.**

*A caveat that does not bite: at $m=4$ ($n=8$) the blocks $V_{(1,1)}$ and $V_{(2,2)}$ split into self-dual and anti-self-dual halves under $SO(4)$, so the table refines rather than fails; the dimension identity still balances ($226+74=300$). At $m=2$ ($n=6$) $SO(2)$ is abelian and the table has no meaning. **Of the three exact verifications at $n=6,8,10$, one ($n=10$) is inside the stable range and two are outside it, but the point is now moot, because the branching is proved rather than verified.***

### 4. What an exact argument still needs, and it is smaller than the record thinks

The branching is settled (§1, §3) and the higher rows are settled (§2). What remains is the four named $F_\lambda$ matrices, and they split:

- **The $\Lambda^2$ block is $m$-independent, structurally.** Its multiplicity space is the single clean LR term $\Lambda^2A\otimes\Lambda^2B$, of $A$-degree $2$, and it is Ricci-traceless in $\mathbb R^n$ automatically, every candidate trace lands in a different index block ($A\wedge B$ against $\Lambda^2A$ or $\Lambda^2B$) and vanishes. So no $\delta_B$ and no trace-removal enters, the contractions in both $\tfrac12(uh+hu)$ and $u\#h$ run over $A$-indices only, and $F_{(1,1)}$ is a fixed $6\times6$ rational matrix on $\Lambda^2A$. **One exact diagonalisation retires this block for every $n\ge9$.**
- **The padded $\mathrm{Weyl}_4\subset M_{\text{trivial}}$ is $m$-independent**, since padding commutes with $Q$ ([conventions.md](../findings/conventions.md)) and hence with $\circ$ and $F_u$, $10$ of the trivial block's $20$ dimensions, including the eigenvector $u$ itself with its eigenvalue $\theta^*$.
- **The residue is where $m$ can genuinely enter**: the trivial block's remaining $10$, the vector block's $20$, the $S^2_0$ block's $10$. In each, the multiplicity space mixes two $A$-degrees ($4$ with $2$ and $0$; $3$ with $1$; $2$ with $0$) and the mixing coefficients are fixed by the $\mathbb R^n$-tracelessness condition, whose $\delta_B$ contractions produce $m$. **This (not "where the stable range begins"), is the true residual obligation, and [r484](REVIEW_r484.md) named it correctly in words while resting it on the wrong threshold.**

**What an exact argument would need, stated plainly.** Every tabulated eigenvalue is rational, so no eigenvector extraction and no floating point is required at all:

1. For each block $\lambda$ and each claimed rational $r$, compute $\mathop{\mathrm{rank}}_{\mathbb Q}(F_\lambda-r\theta^*\mathrm{Id})$ exactly and check $\dim M_\lambda-\mathop{\mathrm{rank}}$ equals the tabulated multiplicity. Sizes are $20,20,6,10$; the certificate is a rational row-reduction. **Multiplicities summing to $\dim M_\lambda$ then close the spectrum with no further work.**
2. For $n$-independence, carry $m$ as a symbol: the entries of $F_\lambda$ in the $m$-independent LR basis are rational functions of $m$ whose degree is bounded by the number of closed $B$-loops a product of at most four contractions can form. Agreement at three tabulated values ($m=6,8,10$) certifies constancy only up to that degree bound; **the degree bound is the missing half of the argument, and it is a finite combinatorial statement, not a numerical one.**
3. For $\alpha\le\tfrac13$ alone, less suffices: a rational PSD certificate for $\tfrac13\theta^*\mathrm{Id}-F_u\succeq0$ on $u^\perp\cap T_u\mathcal O^\perp$, block by block.

### 5. The orbit sits inside the $\tfrac12$-eigenspace for free, and only the reverse inclusion is measured

**The containment $T_u\mathcal O\subseteq E_{\frac12\theta^*}$ needs no table.** $F_u=u\circ(\cdot)$ is half the differential of $Q$ at $u$: $Q(u+th)=Q(u)+2t\,u\circ h+t^2Q(h)$, so $DQ_u=2F_u$. Differentiating the equivariance $Q(g\cdot W)=g\cdot Q(W)$ along $g=\exp(tX)$ at $W=u$ gives $DQ_u(X\!\cdot\!u)=X\!\cdot\!Q(u)=\theta^*(X\!\cdot\!u)$, hence $F_u(X\!\cdot\!u)=\tfrac12\theta^*(X\!\cdot\!u)$ for every $X\in\mathfrak{so}(n)$ and every $n$. *(This is [Lemma L101](../findings/route-a.md)'s identity read at $x=y$; the record derives it and never uses it here.)*

**What is measured is the reverse inclusion, and it is the step that carries the whole radius.** If $E_{\frac12\theta^*}\supsetneq T_u\mathcal O$ then a transverse direction reaches $\alpha=\tfrac12$, and by the record's own $\varphi_c\approx\tfrac32-3a$ the tube collapses to radius zero, the theorem, not merely the constant $0.5748$, is lost. [Lemma L134](../findings/route-a.md)'s "Scope of (a)" states this correctly and gives the honest warning that $\dim E_{1/2}>\dim\mathcal O$ does happen elsewhere ($18$ against $9$ at $S^3\times S^3$).

**§2 shrinks the exposure by more than half.** $E_{1/2}$ is $SO(n-4)$-invariant, and the two higher blocks are now known to lie in $\ker F_u$. So $E_{1/2}$ is confined to the four named blocks ($698$ of $1638$ dimensions at $n=12$) and the tabulated counts ($\tfrac12$ with multiplicity $2$ in the trivial block, $4$ in the vector block, absent from $\Lambda^2$ and $S^2_0$, total $2+4(n-4)=4n-14=\dim\mathcal O$, matching $\dim\mathfrak{so}(n)-\dim(\mathfrak u(2)\oplus\mathfrak{so}(n-4))$) are what closes it.

### 6. Sharpness, $\tfrac13$ is attained, and attained in the one block that is provably $n$-independent

**$\tfrac13$ cannot be lowered.** It occurs in three of the four named blocks after $\mathbb Ru$ and the orbit are removed, with total eigenspace dimension $3+\binom{n-4}2+3\big(\tfrac{(n-4)(n-3)}2-1\big)$, $136$ at $n=12$, growing with $n$. **A large flat, not a handful of directions.**

**And equality is attained in the $\Lambda^2$ block**, whose multiplicity space is $\Lambda^2A$ and whose $F_\lambda$ §4 shows to be a fixed rational $6\times6$ matrix with no $m$ in it. So *sharpness* is provable outright once that one matrix is diagonalised exactly, at any single $n\ge9$, the attaining directions being $h\in\Lambda^2A\otimes\Lambda^2B$, mixed competitor/complement directions, present in every dimension.

**The margin the dependent theorem needs is $\tfrac16$, and it is structural on $940$ of $1638$ dimensions.** $\varphi_c$ vanishes at $a=\tfrac12$; $a=\tfrac13$ leaves $\varphi_c\approx0.5$ against the record's $0.5748$. Since $F_u\equiv0$ on the two higher blocks, no direction there can approach $\tfrac12$ at any $n$, **the risk to the radius is confined entirely to three fixed matrices of sizes $10,20,10$.**

### 7. The block does NOT contain its proof, and the canon entry contains no statement

- **The L21 block's table has four rows and no fifth.** The row reading *"two higher types … $0$ throughout"* lives in the *preceding* section, headed *"$\alpha\le1/3$ is structural, and needs no multiplicity-free hypothesis"*, not in the block. So the block asserts *"Only four types carry a nonzero eigenvalue"* (the exhaustion claim the bound rests on), **with nothing whatever behind it inside the block.** A reader who follows the canon's *Proof: route-a.md* pointer to the block sees the assertion and no accounting.
- **The block is a compressed duplicate of the section above it**, restating the mechanism, the table and the orbit decomposition in shorter form. [conventions.md](../findings/conventions.md)'s own rule (*"a convention restated in two files is a convention that will disagree with itself"*), applies within a file: the two tables already differ (one has five rows, one four; one is headed $/\sqrt{3/2}$, the other $/\theta^*$).
- **The block overstates against the section it duplicates.** It closes *"valid in every dimension rather than checked at particular ones"* while its own table header reads $n=10/12/14$, and while the section above ends *"the remaining formal obligation is a proof that the stable range begins at $n-4\ge8$"*. §3 now makes the branching half of that claim true; the $F_\lambda$ half (§4) is still not.
- **The canon's [L21](../results.md) detail entry states no lemma.** It reproduces only the motivation (*"Lemma L20 rests on one external input… That hypothesis is avoidable"*) and stops. **It never asserts $\alpha\le\tfrac13$, nor names the four blocks, nor gives a range of $n$.** This is the same defect the audit found in the L20 block, in the entry immediately above it. *The glance entry at [results.md](../results.md) line 234 does carry a statement, and is the only place in the canon that does.*

### 8. What cites L21, and whether the use is inside its hypotheses

| site | use | inside hypotheses? |
| --- | --- | --- |
| [Lemma L20](../findings/route-a.md), the proof | $\alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle\le\tfrac13$ for $V$ unit, $V\perp u$, $V\perp T_u\mathcal O$ | **Yes.** $V$'s orthogonality to both is supplied by the nearest-point first-variation condition; $\theta^*=\sqrt{3/2}$ makes $\alpha\le\tfrac13\Leftrightarrow\langle F_uV,V\rangle\le\tfrac13\theta^*$, consistent |
| [Lemma L134](../findings/route-a.md)(a) | $\langle L_eH,H\rangle\le\tfrac13$ for $H\in T_uS$, $H\perp T_u\mathcal O$ | **Yes**, and the identification $F_u=\theta^*L_e$ is pinned twice in that block. (d) then carries the orthogonality as an explicit hypothesis, which is exactly L21's domain |
| [results.md](../results.md) line 234, glance | *"Four spaces of dimensions $20,20,6,10$ carry every nonzero eigenvalue and do not vary with $n$"* | **Now confirmed on the first half** (§1–§2: the other two types carry eigenvalue $0$ identically). *"do not vary with $n$"* is the half still unproved for three of the four (§4) |
| [results.md](../results.md) line 660, L20 canon | names L21 as L20's input, with the $n$-stability caveat | **Yes**, and the caveat is now over-stated: the branching stability is settled |
| [results.md](../results.md) line 668, L21 canon |, | **No statement to check** (§7) |
| [reviews/plan-maximizer.md](plan-maximizer.md) items 1–2 | *"a transverse eigenvalue bound $\alpha<\tfrac12$ (Lemma L21's analogue)"* at $\mathbb{HP}^2$ | **Correctly flagged as an analogue.** *It does not transfer*: L21 is $SO(n-4)$-equivariance around a $\Lambda^2(\mathbb R^4)$-supported $u$; at $\mathbb{HP}^2$ the support is $\Lambda^2(\mathbb R^8)$ and the group is $SO(n-8)$, so the entire block table must be recomputed. The item says so |
| [reviews/ELIM-canon.md](ELIM-canon.md) line 145 | *"a fixed finite computation on four blocks"* | **Accurate**, and now with the fifth and sixth blocks accounted for |
| [findings/INDEX-results.md](../findings/INDEX-results.md) row 21 | *"Gate 2: no verdict on the record"* | Accurate as of this review's start |

**No consumer uses L21 outside its hypotheses.** Every use is at a unit direction orthogonal to both $\mathbb Ru$ and $T_u\mathcal O$, which is precisely the domain on which the bound is asserted.

### 9. Would this be true vacuously?

**No.** The admissible set is $u^\perp\cap T_u\mathcal O^\perp$, of dimension $\dim\mathrm{Weyl}_n-1-(4n-14)=1603$ at $n=12$, and the bound is attained on a $136$-dimensional subspace of it (§6). Nor is the exhaustion vacuous: the $940$ unaccounted dimensions are $57\%$ of the space, they carry a genuine eigenvalue of $F_u$ (namely $0$), and had any of them carried $\tfrac12$ the dependent theorem would be false rather than merely unproved.

## Verdict, **PLAUSIBLE**, and materially stronger than it was

**The conclusion $\alpha\le\tfrac13$ is almost certainly true, its two most-doubted supports are now proved rather than measured, and one input remains genuinely unproved.**

**Proved here, replacing measurement:**

1. **Exhaustion.** The $SO(n-4)$-isotypic decomposition of $\mathrm{Weyl}_n$ is exactly six types with multiplicities $20,20,6,10,4,1$, the two unnamed ones being $V_{(2,1)}$ and $V_{(2,2)}=\mathrm{Weyl}_{n-4}$, and $\sum\dim M_\lambda\dim V_\lambda=\dim\mathrm{Weyl}_n$ **identically in $n$**. At $n=12$: $698+640+300=1638$. **The table's four multiplicities $20,20,6,10$ are consequences, not measurements.**
2. **The *"-e"* row.** $F_u$ annihilates both higher blocks exactly, in every dimension, by an $A$-index-degree argument.
3. **Stability.** Valid for every $n\ge9$, on row length $\ell\le2$, not $n\ge12$ on tensor degree. **Both divided reviewers argued from the wrong threshold; the dispute dissolves.**
4. **$T_u\mathcal O\subseteq E_{\frac12\theta^*}$**, from equivariance alone.

**Not proved, and this is why the verdict is not CONFIRMED:**

- **The $n$-independence of three of the four named $F_\lambda$ matrices** (trivial minus its padded $\mathrm{Weyl}_4$, vector, $S^2_0$), where the $\mathbb R^n$-tracelessness condition mixes two $A$-degrees with $\delta_B$-built coefficients. Three tabulated values of $m$ do not settle a rational function of $m$ without a degree bound.
- **The reverse inclusion $E_{\frac12\theta^*}\subseteq T_u\mathcal O$**, which is the step the radius actually depends on, and which rests on those same three matrices.
- **No block spectrum has been certified exactly at any $n$ in the stable range.**

**The hypotheses L21 actually needs:** $n\ge9$; $u=W_{\mathbb{CP}^2}$ zero-padded from $\Lambda^2(\mathbb R^4)$; the direction unit, orthogonal to $\mathbb Ru$ and to $T_u\mathcal O$; and the four tabulated $F_\lambda$ spectra correct and $m$-independent, of which the $\Lambda^2$ row's $m$-independence is now structural and the other three are not.

**Recommended repairs, in order of cost:** (i) put the fifth row *with its types and dimensions* into the L21 block and the §2 proof beside it; (ii) give the canon's L21 entry a statement; (iii) replace *"the stable range begins at $n-4\ge8$"* with the discharged $n\ge9$ and the true residual, the $m$-independence of three matrices; (iv) an exact rational rank certificate per block per claimed eigenvalue, which needs no eigenvectors and no floating point.

*Computation used: one symbolic polynomial identity in $m$ (sympy, seconds), constructed to screen the dimension arithmetic of §1 before recording it. Reported as a screen; the identity is verifiable by hand and the surrounding derivation is analytic throughout.*
